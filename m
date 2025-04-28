Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171C26562C;
	Mon, 28 Apr 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842440; cv=none; b=Bocx9Jam7sVqq1YuCLM74TtfFPl+wu+8Wxz4KexUFQ4ARzfWQWt7GCax5jChK7C5DdZNessrLAqz1DuVM86cwCWcdmh/tmw3OQDO0ul8ornjfrJpG3v8/5aRNb7lSNeUZvq7V0fQYg9LkBFGbwGVSZvfJXrE0INasGFUaDG9fW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842440; c=relaxed/simple;
	bh=GLl4raAjKli9gG84v1bq7BKjKi1z7iQiV+EVknKy6J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2an84PBXWixTbBkGaqs8DWEZxn9LUm1n7oihB5NwA7i4Rijc0DsVQQ1/S0TpF97/X1yTNB+AtppDBP/qzLRw+alJUGGzzPfh53khB/OTxiFIQzoodLILwox2uKGOwVPwzyGk+4V9k8INVUOeFsUpYasfHDGF3YcDPa3oO6WQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxIb9Bsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxIb9Bsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D7C4CEE4;
	Mon, 28 Apr 2025 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745842439;
	bh=GLl4raAjKli9gG84v1bq7BKjKi1z7iQiV+EVknKy6J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxIb9BsrRgqCH3q90z79/S0/gWog/8Z+xxqlNVn5nO68LzZ8YiJxU+IFGzrw9AXH3
	 CeB1KXhrUR7llj2dI6PsBnxGG1xpK7ubu7faAbU2KJGKUSaNLSJbZtJrjZp/c4w6Th
	 43cFPci1KhNwAr8nw2CzoiDq5dCn2l1FIjatAEXyocMypJHzF4xpJJPy+35G/PfpLo
	 pldtFsBKoeXzPAxO7beYMGT3FD7Qln0wcRLaaNRCR+3T4DN1qc0JKAkw8bB1bBd5kz
	 YxB7A6ziVNNlcAu99cvpxt3kEnT3vwwokxLB7sn/VdVwRop8FWrfyCzTRxCnf6vgjh
	 aII0MUKTvOdZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u9NN2-000000003bo-45iM;
	Mon, 28 Apr 2025 14:14:01 +0200
Date: Mon, 28 Apr 2025 14:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Handle yet another race around registration
Message-ID: <aA9xCLF_wNsCUuJ8@hovoldconsulting.com>
References: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>

On Thu, Apr 24, 2025 at 06:41:28PM +0100, Robin Murphy wrote:
> Next up on our list of race windows to close is another one during
> iommu_device_register() - it's now OK again for multiple instances to
> run their bus_iommu_probe() in parallel, but an iommu_probe_device() can
> still also race against a running bus_iommu_probe(). As Johan has
> managed to prove, this has now become a lot more visible on DT platforms
> wth driver_async_probe where a client driver is attempting to probe in
> parallel with its IOMMU driver 

To be clear, I hit this with just normal probe deferral (not explicit
async probe).

> - although commit b46064a18810 ("iommu:
> Handle race with default domain setup") resolves this from the client
> driver's point of view, this isn't before of_iommu_configure() has had
> the chance to attempt to "replay" a probe that the bus walk hasn't even
> tried yet, and so still cause the out-of-order group allocation
> behaviour that we're trying to clean up (and now warning about).
> 
> The most reliable thing to do here is to explicitly keep track of the
> "iommu_device_register() is still running" state, so we can then
> special-case the ops lookup for the replay path (based on dev->iommu
> again) to let that think it's still waiting for the IOMMU driver to
> appear at all. This still leaves the longstanding theoretical case of
> iommu_bus_notifier() being triggered during bus_iommu_probe(), but it's
> not so simple to defer a notifier, and nobody's ever reported that being
> a visible issue, so let's quietly kick that can down the road for now...
> 
> Reported-by: Johan Hovold <johan@kernel.org>

Perhaps add a reference to my report:

Link: https://lore.kernel.org/lkml/Z_jMiC1uj_MJpKVj@hovoldconsulting.com/

> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This looks like it should work and nothing blows up even if I haven't
tried to instrument a reliable reproducer to test it against:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

That said, don't you have a similar issue with:

@@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
+	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
+	 * is buried in the bus dma_configure path. Properly unpicking that is
+	 * still a big job, so for now just invoke the whole thing. The device
+	 * already having a driver bound means dma_configure has already run and
+	 * either found no IOMMU to wait for, or we're in its replay call right
+	 * now, so either way there's no point calling it again.
+	 */
+	if (!dev->driver && dev->bus->dma_configure) {

What prevents a racing client driver probe from having set dev->driver
here so that dma_configure() isn't called?

+		mutex_unlock(&iommu_probe_device_lock);
+		dev->bus->dma_configure(dev);
+		mutex_lock(&iommu_probe_device_lock);
+	}

Johan
