Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454571;
	b=z2DEjnMFXET5RFj3Y0M6yBAHVTw3HXvo83bJ2lJj961Dh/t/NVTgTPkZSjeoY0jaBwoy
	 42LdfTWLvrh4rDgRl7GxYFxoqNG4W7Cq9czjqFVvYmY8OnwMMi1dPg9mEZzts/E+AENOt
	 +YyjITd4yiBkBKe2o0NbCb5aJ1iJJL6QkAHFV9tUF1X8z07zs62r6x+rKz8c2p7wzxIN2
	 zEm7vn7Vl/mSq/BKeiAy7nfqRWSLKCRPVrxqKm7M+1ZVnrPJ3oQ2ODiK3Uzyy+lxq1CTF
	 d7jsomYy/3nSWMgQ69OKhRD8ZBolXbu0aqs8rQxI1fl23vSPpa1V/6J3TUmCmv+VGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454571;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=To0SY0PCUEWNtp8vKtDr3U/74vnYOoZDCurwJNOsb+E=;
	b=UXgw+ZQJPB3Po/l+YlJXwRHz9lMUMMaHE0NmO9zozaceKC06Vp186Yfxmzm7KhxxFP/G
	 rVtKZfL8Vf3vjPBMKONixSdGGBSpl505NrTH3M/onyATVyvhweZ7HAYE1ql/TrJOtX/WA
	 +ZUj/Nbq9TyiHrh905XsEv9/keXM/dhbHUJ6eXzqptH6jAVQTbA2NqtkmsgAr8jtWnek1
	 YdMyBoR0H3A32o8EPgLszd8xykaCBMs0P7QYNbOVqCou4fK0MJ0BMOM5ubxwIf4Xw62k6
	 lrLSqjEfVqsJSh3/ZHzo7bThbYqLq9+HtskMot4zabpQeXph5pOQnekOpcbDN5eSoRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5Sn69Fn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0D606A327;
	Mon, 23 Nov 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5Sn69Fn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925541F000D4;
	Mon, 23 Nov 2026 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454570;
	bh=To0SY0PCUEWNtp8vKtDr3U/74vnYOoZDCurwJNOsb+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=n5Sn69FnkbmU1o8ob6qHPrFVakoc4kcL4qpkMfrY/+3Y1/f+Sw7Fc5fu4dh41Ot2C
	 64dkif6Mq6BcbFGiFgMJdacI08ek1oXrMssJaTiBcw/6crWDJi4yR12jw6RxOqDyHR
	 2dUnxbO1y8tnHa7psNzkdLmA5feI1gh5N8MUJr4QUIO+jN0laEfTjURaG/s752YUT3
	 SuBbR2h05X2nHRzGYEAq3PK/AdrbsyNaOAY9RQjAN9Iv57GuVzbiNHOhUb2rcyzt//
	 4/dCe8OnmtECessrTMLBz5WLv3GH9Od66vtm0y+rQC/wH3Mh7cAbx5zOhDeDBaljV8
	 ojFHMGmiNRaIw==
Date: Mon, 23 Nov 2026 11:22:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Danny Gonzalez <digonzal@google.com>,
	David Decotigny <decot@google.com>,
	Sheena Mohan <sheenamo@google.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid relying on pci_ats_supported() for
 rbtree removal
Message-ID: <20261123172249.GA1095219@bhelgaas>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123003805.2828580-1-baolu.lu@linux.intel.com>

[+cc Danny, David, Sheena, Pranjal]

On Mon, Nov 23, 2026 at 08:38:05AM +0800, Lu Baolu wrote:
> Commit 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path") made
> the device rbtree insertion in intel_iommu_probe_device() conditional on
> pci_ats_supported(). To match, intel_iommu_release_device() only removes
> the device from the rbtree if pci_ats_supported() is still true.
> 
> That relies on pci_ats_supported() returning the same result at release
> as it did at probe. If it changes in between, the rbtree can retain an
> entry after its device_domain_info has been freed, resulting in a
> use-after-free during a later lookup.
> 
> Checking RB_EMPTY_NODE() to track rbtree membership is common in the
> iommu subsystem. Since device_rbtree_remove() safely handles an empty
> node, call it unconditionally in the release path. This makes removal
> depend on the device's actual rbtree membership.
> 
> Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good to me, thanks!

> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5a2e705a2f2e..82f7bd8ecadf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3393,6 +3393,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  
>  	info->dev = dev;
>  	info->iommu = iommu;
> +	/* An empty node marks the device as not in the rbtree. */
>  	RB_CLEAR_NODE(&info->node);
>  	if (dev_is_pci(dev)) {
>  		if (ecap_dev_iotlb_support(iommu->ecap) &&
> @@ -3508,8 +3509,7 @@ static void intel_iommu_release_device(struct device *dev)
>  	}
>  
>  	mutex_lock(&iommu->iopf_lock);
> -	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
> -		device_rbtree_remove(info);
> +	device_rbtree_remove(info);
>  	mutex_unlock(&iommu->iopf_lock);
>  
>  	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> -- 
> 2.43.0
> 
