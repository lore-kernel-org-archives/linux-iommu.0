Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34D2FBE1A
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565390; cv=none; b=kCc3DbjaSoza+yUcLGwjzqOOvNnfpA7fyltsSVfwlfUc0uxx2JwVqNLhg4ofrdvxwZ3JK4m2EkVwezE5Uv8cG6si3GsLNOi/irjw4D6W7XcjcUa/bruYODv0s4DxtbezTjW7XTntSWx0aX582J2k9uUxq+lrKH/vZaAP+lwakIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565390; c=relaxed/simple;
	bh=QHB7ogBviW1sk+l+lwC23glCf9NdDmpFfN6Z4qzApQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlBWdUJ27aeuSan4Cvd9PBfMCVoEYKs873JeS0N0T/qFVB9YB2U6AyIoJwCFHCf6teFJ/9zhWDp0ostjWhxnP11Ezjw8BXCpeNEFM6UzQia7bbal0AzxgYHEb44RRVP210yFN904TQZj5vc+ZXihUhGNevG0kzsBq9LkQkNK+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=uKEGJJ+S; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="uKEGJJ+S"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D04BC598D5;
	Mon, 27 Oct 2025 12:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761565388;
	bh=QHB7ogBviW1sk+l+lwC23glCf9NdDmpFfN6Z4qzApQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKEGJJ+S41J6K4x7ujgqrKO56V8Tg6vOhZ+scdGG+hkOKQ8V7EnAvOKfHeOWJIRtJ
	 HppkmxRZIR7H3bo/lA9JjEfz8Fe3VVWlcO3ocesdAItzupOIPSX8Cbitj4lnkhtK/N
	 VlicelCFx4F3oilFlsHZUSaGBdTa2cY6nk1KdHuWqH27xxYNIB3b/zn51NYXmzvwJn
	 xzhiX7VfL7vcfacK1KVuXVSd1WlURNVWbKz8RWWmB9RFkyPX8hsHtid0jNZvbuNcEC
	 oWt9yJrIZToTAuYdNHssW9VHpG12yr00lHPVzBgaPrApQ/0aOlc6Sru2368nDTuF+S
	 vKjzvcHY/dhJw==
Date: Mon, 27 Oct 2025 12:43:06 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org
Subject: Re: [RFC PATCH 2/4] drivers/iommu: Add calls for iommu debug
Message-ID: <hu7ozrdn6la24apa4pco5nkhow2dmthahjomjj6hy4nrefx6j4@lcdfbykoafw4>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003173229.1533640-3-smostafa@google.com>

On Fri, Oct 03, 2025 at 05:32:27PM +0000, Mostafa Saleh wrote:
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap: Track iommu pages unmapped, using IO virtual
>   address.
> - iommu_debug_remap: Track iommu pages, already mapped using IOVA.
> 
> We have to do the unmap/remap as once pages are unmapped we lose the
> information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug.c | 23 +++++++++++++++++++++++
>  drivers/iommu/iommu.c       | 21 +++++++++++++++++++--
>  include/linux/iommu-debug.h |  6 ++++++
>  3 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
> index 297a35137b38..607f1fcf2235 100644
> --- a/drivers/iommu/iommu-debug.c
> +++ b/drivers/iommu/iommu-debug.c
> @@ -5,11 +5,13 @@
>   * IOMMU API santaizers and debug
>   */
>  #include <linux/atomic.h>
> +#include <linux/iommu.h>
>  #include <linux/iommu-debug.h>
>  #include <linux/kernel.h>
>  #include <linux/page_ext.h>
>  
>  static bool needed;
> +static DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
>  
>  struct iommu_debug_metadate {
>  	atomic_t ref;
> @@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
>  	.need = need_iommu_debug,
>  };
>  
> +void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> +{
> +}
> +
> +void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
> +{
> +}
> +
> +void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
> +{
> +}
> +
> +void iommu_debug_init(void)
> +{
> +	if (!needed)
> +		return;
> +
> +	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
> +	static_branch_enable(&iommu_debug_initialized);
> +}
> +
>  static int __init iommu_debug_pagealloc(char *str)
>  {
>  	return kstrtobool(str, &needed);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee1..56c89636a33c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-debug.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -231,6 +232,9 @@ static int __init iommu_subsys_init(void)
>  	if (!nb)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +	iommu_debug_init();
> +#endif
>  	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>  		nb[i].notifier_call = iommu_bus_notifier;
>  		bus_register_notifier(iommu_buses[i], &nb[i]);
> @@ -2518,10 +2522,14 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  	}
>  
>  	/* unroll mapping in case something went wrong */
> -	if (ret)
> +	if (ret) {
>  		iommu_unmap(domain, orig_iova, orig_size - size);
> -	else
> +	} else {
>  		trace_map(orig_iova, orig_paddr, orig_size);
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +		iommu_debug_map(domain, orig_paddr, orig_size);
> +#endif

These #ifdefs need to be in a header file, not the actual source code.

