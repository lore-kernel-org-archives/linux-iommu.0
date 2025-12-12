Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE63019B3
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765565058; cv=none; b=N73ezxTh1N2qOUXeITT4b61OEuVEzoS6p8KHisOnQviz/ylepxS1FmWbPELAAhE+FNR/2oBJNg+hifCuWns7cTCxQrzeB9m/LUZEE3q4mx1x4n1JxXs2am1XX4429I29q8dvJgreyKKKf1e7uccENl10aieUrXqusGsJwsTfz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765565058; c=relaxed/simple;
	bh=rmtKLb7q+5ezLO29xEQUuSgWaDW8KS0K3IegkM6c0uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2rYQZdI1hf0ebyOnpa08H7EJoagT+kK7/4KA3ceWY1ELp2JfvX7Gdaqhj/Itq6Cf1EZwRRwGmQVTjewwIyVGwShvo1jS2phlj/GT2ed4yEAqPZCMh1fNe+FCzHk+CaTZ+pah/GU9HR/ZJHhpHfEVri7Q5RzfuUQBHrWTrEbfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9W8k4HI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9W8k4HI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so181815e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765565055; x=1766169855; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZ+zh4+qr/HN6w+u7QW254+tODE+L4KOJGO5KT43g/s=;
        b=I9W8k4HINxgUtRoE928vcjcd7P7cO2XJMpYlrYCz9rnV8qcHrtut+4ywsOU8JoXZxM
         gkUfnATdpqGBCAbkUkV9L9BzdiTn/gNPPY5vOkGegztLkHzBH+7lrSfx2bEu+DLbSYAr
         LxAu9SbslVdZK2NePpnIryH0tYA4W+M/vDxVhHqPN2I4hdbcfOAYgw0G2e/TeCYZv8Dn
         yYV5k129gEJ76oxdDfTgJMKDSAKeu5lnhtX3x3FsZT45TuXRs2eoS5e+2qQtEIW+goRu
         7DPnlgC2mbxhLPA/YR+07e9YRiMtLqIHuXuLrCR2F/gKW2jE6pdF13NUhwo7fj1kkYDC
         ADUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765565055; x=1766169855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ+zh4+qr/HN6w+u7QW254+tODE+L4KOJGO5KT43g/s=;
        b=FGmrPGldZw8QdphukSTqiF62i9krcAzECdoWARyNVpIXhposxY0aw35tZwOnF1hABP
         hwRIBQlBuEdl3HQLURXfoDPdWDinTcWvnGIDcwgYY89lzNMuOvd1NUjZTf3FZBA9QvUH
         3TFwPfyHl8VaIfoZ7ESXKOFjEHeabj3SvTBzaHe0j7V9iCPNgQbjngVx2BZlQNbp1X+k
         YnnH87kgGZdZ0onpzE3i8165zH/72DjHQWJE7hQJdpHrIkbOfdijDsHFDMblF3m7W3R5
         8SYONxpmea0hge5vKWtppZFwknFFRF89BxptoQCx2Cxrk3Ufrl9Geh/DkkIdlzR4zjgz
         kaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWTo0cjScGyIiho7xq8cUEbLKBIUcpQqOvoLv7i0V5DT1oP5Jb3YRlkGfnYqFMgjJM19lffg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6xtYWZNe5OyWnfZPZXYd/v7XYSlm2uapMJ1UIamZ0mxNJ+Jf5
	tFu5RZFyQgEhZMSlDSh8yErQ9TKaYdd+3Dj/VEOr5ysVINCLmqAuxoswpGdRkCd/jQ==
X-Gm-Gg: AY/fxX5a+CBJ+4O1q2dZq3Hp7341EoHaeZNHgIP9f0FzJW3pyYFKowvH8LkoZbwzDUw
	MJ9dWw7T+N4L2lfQxAajjIIJYvMX3yrGzfzxQkNR25100o+Mm6YazWZNhp0OoJBD4pWjQl3vIR9
	KfMxUajVqxf4SrkMOO6EwSKiNdnHQizeL04OtKCGnB/S6UxUnGPFNTqqSZKIsLK9uvvl43FvVMK
	SHHkZ57zAUBUvMTn9w+iRGjbjw6U2H5qQPosj+lNEEEhrwf9Lkji0lscjYF1gN+q3dbH3vBg+ru
	g7kd2dre4wkDlQlCnaAsQaUgnb7FonEFdUxmvW+d5N1MksMIknvrdZFb9cbcjDQ2nQX8W3hFb5s
	Pxidl987G8LftTD2h8yS9vCqQxI2ILUVLVFZAfsb+9teOu1hF9xI/LPaZN7Tb5ddxGT0l4sC/he
	sWYHLjO7tn5wAH/FVRO8SHW+JakunQsfQL2pR1RhJGYoiAOLkrqQ==
X-Google-Smtp-Source: AGHT+IHGvjVZJ6nOuRdDb1gX2OZv9LSRuh0+95/zqQtd/9rPsVw68PVqoRCbVL9lWG9KXK+ZBoktwg==
X-Received: by 2002:a05:600c:2195:b0:477:b358:d7a9 with SMTP id 5b1f17b1804b1-47a948f6e81mr4845e9.17.1765565055030;
        Fri, 12 Dec 2025 10:44:15 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4b516bsm18335255e9.2.2025.12.12.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:44:13 -0800 (PST)
Date: Fri, 12 Dec 2025 18:44:09 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v4 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aTxiefxT08hbUPsd@google.com>
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-3-smostafa@google.com>
 <20e015d7-cb54-4a2a-bf62-a828e10e3126@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20e015d7-cb54-4a2a-bf62-a828e10e3126@linux.intel.com>

On Fri, Dec 12, 2025 at 10:33:20AM +0800, Baolu Lu wrote:
> On 12/11/25 20:59, Mostafa Saleh wrote:
> > Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> > - iommu_debug_init: Enable the debug mode if configured by the user.
> > - iommu_debug_map: Track iommu pages mapped, using physical address.
> > - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
> >    IOVA and size.
> > - iommu_debug_unmap_end: Track the end of unmap operation, passing the
> >    actual unmapped size versus the tracked one at unmap_begin.
> > 
> > We have to do the unmap_begin/end as once pages are unmapped we lose
> > the information of the physical address.
> > This is racy, but the API is racy by construction as it uses refcounts
> > and doesn't attempt to lock/synchronize with the IOMMU API as that will
> > be costly, meaning that possibility of false negative exists.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
> >   drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
> >   drivers/iommu/iommu.c                 | 11 ++++-
> >   include/linux/iommu-debug-pagealloc.h |  1 +
> >   4 files changed, 96 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> > index 4022e9af7f27..1d343421da98 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -5,11 +5,15 @@
> >    * IOMMU API debug page alloc sanitizer
> >    */
> >   #include <linux/atomic.h>
> > +#include <linux/iommu.h>
> >   #include <linux/iommu-debug-pagealloc.h>
> >   #include <linux/kernel.h>
> >   #include <linux/page_ext.h>
> > +#include "iommu-priv.h"
> > +
> >   static bool needed;
> > +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
> >   struct iommu_debug_metadata {
> >   	atomic_t ref;
> > @@ -25,6 +29,30 @@ struct page_ext_operations page_iommu_debug_ops = {
> >   	.need = need_iommu_debug,
> >   };
> > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> > +{
> > +}
> > +
> > +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +			       unsigned long iova, size_t size)
> > +{
> > +}
> > +
> > +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> > +			     unsigned long iova, size_t size,
> > +			     size_t unmapped)
> > +{
> > +}
> > +
> > +void iommu_debug_init(void)
> > +{
> > +	if (!needed)
> > +		return;
> > +
> > +	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
> > +	static_branch_enable(&iommu_debug_initialized);
> > +}
> > +
> >   static int __init iommu_debug_pagealloc(char *str)
> >   {
> >   	return kstrtobool(str, &needed);
> > diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> > index c95394cd03a7..aaffad5854fc 100644
> > --- a/drivers/iommu/iommu-priv.h
> > +++ b/drivers/iommu/iommu-priv.h
> > @@ -5,6 +5,7 @@
> >   #define __LINUX_IOMMU_PRIV_H
> >   #include <linux/iommu.h>
> > +#include <linux/iommu-debug-pagealloc.h>
> >   #include <linux/msi.h>
> >   static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> > @@ -65,4 +66,61 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
> >   int iommu_replace_device_pasid(struct iommu_domain *domain,
> >   			       struct device *dev, ioasid_t pasid,
> >   			       struct iommu_attach_handle *handle);
> > +
> > +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > +
> > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
> > +		       size_t size);
> > +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +			       unsigned long iova, size_t size);
> > +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> > +			     unsigned long iova, size_t size, size_t unmapped);
> > +
> > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > +				   phys_addr_t phys, size_t size)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_map(domain, phys, size);
> > +}
> > +
> > +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +					   unsigned long iova, size_t size)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_unmap_begin(domain, iova, size);
> > +}
> > +
> > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> > +					 unsigned long iova, size_t size,
> > +					 size_t unmapped)
> > +{
> > +	if (static_branch_unlikely(&iommu_debug_initialized))
> > +		__iommu_debug_unmap_end(domain, iova, size, unmapped);
> > +}
> 
> I am wondering whether it would be better if we move iommu_debug_map()
> to iommu-debug-pagealloc.c,
> 
> void iommu_debug_map(struct iommu_domain *domain,
> 		     phys_addr_t phys, size_t size)
> {
> 	if (static_branch_likely(&iommu_debug_initialized))
> 		__iommu_debug_map(domain, phys, size);
> }
> 
> (Does it make sense to use static_branch_likely() here? Normally, people
>  who enable CONFIG_IOMMU_DEBUG_PAGEALLOC would want to use this
>  debugging feature. Or not?)
> 
> So that ...

This actually was the v1 implementation [1], but Jörg suggested to move
it to a header file as a function call would have an overhead if this
feautre is disabled.

I believe the priority would be to keep the performance overhead minimal
with CONFIG_IOMMU_DEBUG_PAGEALLOC and the commandline disabled, so people
can run with the config in production and only enable the commandline
it to debug problems, without having overhead on the typical case.

> 
> > +
> > +void iommu_debug_init(void);
> > +
> > +#else
> > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > +				   phys_addr_t phys, size_t size)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
> > +					   unsigned long iova, size_t size)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
> > +					 unsigned long iova, size_t size,
> > +					 size_t unmapped)
> > +{
> > +}
> > +
> > +static inline void iommu_debug_init(void)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> > +
> >   #endif /* __LINUX_IOMMU_PRIV_H */
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 2ca990dfbb88..01b062575519 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -232,6 +232,8 @@ static int __init iommu_subsys_init(void)
> >   	if (!nb)
> >   		return -ENOMEM;
> > +	iommu_debug_init();
> > +
> >   	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> >   		nb[i].notifier_call = iommu_bus_notifier;
> >   		bus_register_notifier(iommu_buses[i], &nb[i]);
> > @@ -2562,10 +2564,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> >   	}
> >   	/* unroll mapping in case something went wrong */
> > -	if (ret)
> > +	if (ret) {
> >   		iommu_unmap(domain, orig_iova, orig_size - size);
> > -	else
> > +	} else {
> >   		trace_map(orig_iova, orig_paddr, orig_size);
> > +		iommu_debug_map(domain, orig_paddr, orig_size);
> > +	}
> >   	return ret;
> >   }
> > @@ -2627,6 +2631,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
> >   	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
> > +	iommu_debug_unmap_begin(domain, iova, size);
> > +
> >   	/*
> >   	 * Keep iterating until we either unmap 'size' bytes (or more)
> >   	 * or we hit an area that isn't mapped.
> > @@ -2647,6 +2653,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
> >   	}
> >   	trace_unmap(orig_iova, size, unmapped);
> > +	iommu_debug_unmap_end(domain, orig_iova, size, unmapped);
> >   	return unmapped;
> >   }
> > diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> > index 83e64d70bf6c..a439d6815ca1 100644
> > --- a/include/linux/iommu-debug-pagealloc.h
> > +++ b/include/linux/iommu-debug-pagealloc.h
> > @@ -9,6 +9,7 @@
> >   #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> >   #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> 
> ... we could make this static?
>

This is not static because of the header usage as mentioned above.

Thanks,
Mostafa

> >   extern struct page_ext_operations page_iommu_debug_ops;

[1] https://lore.kernel.org/linux-iommu/20251003173229.1533640-2-smostafa@google.com/
> 
> Thanks,
> baolu
> 
