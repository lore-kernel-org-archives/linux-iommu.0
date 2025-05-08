Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C322A811;
	Thu,  8 May 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746746093; cv=none; b=HLKdOnlwSwg+5+3AApBxpwWgMFAlntFl+YJF/ZidFnauZtDOEXPhSSqgbA//NhdR6sqi7wcstm0XuZ4rUTJNuGvxe2sW5I32z+z1Nf+IWW+zRmaWu3bIhm5u8tK7ysmQDPQYwXQFULyzgzZqWb6VhZDD1sreWz+QQHkZGGybPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746746093; c=relaxed/simple;
	bh=b/rZbBu/kd8miGQyME180cFglbDpC6omgZiTM3EgZvE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EUG9bGXE3jCFG3i1Eka7WxUfCy8029GbjhnWgPFqAKu1c6mQ4PO8CtWsYSO1kZWVfUD3mlbHxGz8u4fQY5w2qak8GTi0JRHfGLS493TX/zYmtQavhX/hN9yYPfAMNONvT8n+QOZneJt7mer20YVwVIOQvO/pKcineLrG6dZlYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muucR9EJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muucR9EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58903C4CEE7;
	Thu,  8 May 2025 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746092;
	bh=b/rZbBu/kd8miGQyME180cFglbDpC6omgZiTM3EgZvE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=muucR9EJAc7m4NJf2H9VIUt1waSHNztv2dI0HxkkiYDyNzgZ20+vhc/hLIi7SplRQ
	 G/ZPN5ry52zgZV+Vy47H0TIG4563fxjhHcXUBYyAYxlAjqhbcgRqxvlyD1DGFPaAjH
	 nETZt1r3fGNF266oTJ4K9isd8g//Ojqy5xKqH8OqZtCMOzhr+KtQ31IFHTQp9E02u3
	 2MtaMfiq0j0cxwK5ApE6IbFR6GxooQJ6iLlPTNt9NXt8sjoFhsphLeZFhltN1du7CH
	 cj74y0Cb8lHczM05duqYh5D9W4mwdas5K17oxFuno1yqYfSgDDRfCE3lht3rlTwQH8
	 BPK+YOn1pH/qw==
Date: Thu, 8 May 2025 16:14:49 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@infradead.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
    John Ernberg <john.ernberg@actia.se>, Juergen Gross <jgross@suse.com>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
In-Reply-To: <aBwvrLKD_VJapYkB@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2505081614450.3879245@ubuntu-linux-20-04-desktop>
References: <20250502114043.1968976-1-john.ernberg@actia.se> <20250502114043.1968976-3-john.ernberg@actia.se> <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop> <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
 <alpine.DEB.2.22.394.2505071602570.3879245@ubuntu-linux-20-04-desktop> <aBwvrLKD_VJapYkB@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 May 2025, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 04:09:15PM -0700, Stefano Stabellini wrote:
> > > This mapping is not for a RAM backed address. In the eDMA case for the 
> > > iMX8QXP the `phys` coming in here is the address of a register.
> > 
> > Ok, this information is important :-)
> > 
> > I am not certain whether the map_resource interface can only be called
> > for MMIO addresses or if it can also be called for RAM-backed addresses
> > with a size > PAGE_SIZE. In the latter case, we could run into the issue
> > I was describing.
> 
> map_resource is intended for MMIO regions, although those could be >
> PAGE_SIZE.  It must not be called on RAM.

In that case, John, you can just use dma_direct_map_resource().

That's because MMIO regions:
- are 1:1 mapped on ARM
- are 1:1 mapped on x86 for PV Dom0
- might not be 1:1 mapped on x86 for PVH Dom0, but in this case we rely
  on the IOMMU to do address translation

In none of these cases xen_phys_to_dma would give us any interesting
results.  It would be the same as calling phys_to_dma.
