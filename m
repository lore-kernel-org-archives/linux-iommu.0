Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A98ABA
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 20:29:23 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id n18so10543188qvt.11
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=js1gsQk2qW+tROYqBlATL8XNon+oklh3P+AQDk2woKc=;
        b=e2JrBfwTSJbdIv+ODjz9gCepogEixJavT4Sl5DROjeRdeuIdatUUpZXpx8BGlM979n
         B4ARXpLAZcw5dzth58vH1H4pq0tOmlAioI10gNh3jBDFO+aQCHFiRYnQ8nBFcCtaIec4
         ZF/68c7tFCYf1e6jSPWLWReAJ7mVvr+JtMrb7cemYdDXPirrc8UaHHhu0OHkuzHZlHyK
         TqMWNTVxZPiadBBNI4EZyCQb7M16NxZacIOa0rwwoTL4D/IXhTiK1If9VkgcvWetoLnT
         CFkiY+VNVzS9XLQX4/Bwj5SAxuc0Pkp6h5fXsqukadoKSRJE/FS/xM2wOPmUpI8KudlR
         xJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js1gsQk2qW+tROYqBlATL8XNon+oklh3P+AQDk2woKc=;
        b=uaPQ41EXQSd/VnV2bw4KA3okBoDQFmBXoMTViHHvkwaf7c38hc3cWhtZecVXyhV4Y2
         6yTsH98gTvE2VD9cE1Rb4WqBMFPeAHP/FOKOhxIZtlEnpli9mmU2G2gD2lgYJ5jPxyWr
         I22tWZRrOELHNUgMUYOdmkhZmnsKgooQvr1NhWyg72k4fQCYNEpcZ+akNMOSd2loFeDi
         TrlV/Hd73X9IKZzdrqMLjortn140dKVbuVG/mkoJ9ZVzTZqw+7071tug2JlrmkAIw74P
         HIpBJjmsda5GX4vaqLXHfJUe6MRD/9PCSkXVIYVi54QSOGhtaUCoVMWR0h5zyTYxZpG0
         zn9Q==
X-Gm-Message-State: ANoB5pkH0Frz4eUU9tFindI1HUMssPdjDPXjpe/e3SDZDM9z69rWz9LV
	RUY/j3FxCs9Y3/19DvBe0b229+y8dDl5bA==
X-Google-Smtp-Source: AA0mqf7SebHOSS709jTQKQJdt65Uu4dUQ404fDscHm3gyvh9w6piA6YoIN74C4gLhiW7eShxro6HGQ==
X-Received: by 2002:a05:6214:1787:b0:4b1:92ca:9cd7 with SMTP id ct7-20020a056214178700b004b192ca9cd7mr18324847qvb.103.1668544162328;
        Tue, 15 Nov 2022 12:29:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006cdd0939ffbsm8845089qko.86.2022.11.15.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:29:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ov2Ya-004jrx-Qd;
	Tue, 15 Nov 2022 16:29:20 -0400
Date: Tue, 15 Nov 2022 16:29:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <error27@gmail.com>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y3P2oEIICOTiVOBH@ziepe.ca>
References: <Y2Nhj0mIjrSJwO7W@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Nhj0mIjrSJwO7W@kili>

On Tue, Nov 15, 2022 at 03:45:00PM +0300, Dan Carpenter wrote:
> [ Resending two weeks of email because mutt + msmtp has been silently
>   eating my outgoing mail instead of delivering it.  *sigh* -dan ]
> 
> Hello Jason Gunthorpe,
> 
> The patch 32c328dc9b73: "iommufd: vfio container FD ioctl
> compatibility" from Dec 15, 2021, leads to the following Smatch
> static checker warning:
> 
> 	drivers/iommu/iommufd/vfio_compat.c:174 iommufd_vfio_unmap_dma()
> 	warn: potential integer overflow from user (local copy) 'unmap.iova + unmap.size'
> 
> drivers/iommu/iommufd/vfio_compat.c
>     140 static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
>     141                                   void __user *arg)
>     142 {
>     143         size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>     144         /*
>     145          * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
>     146          * dirty tracking direction:
>     147          *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
>     148          *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
>     149          */
>     150         u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
>     151         struct vfio_iommu_type1_dma_unmap unmap;
>     152         struct iommufd_ioas *ioas;
>     153         unsigned long unmapped;
>     154         int rc;
>     155 
>     156         if (copy_from_user(&unmap, arg, minsz))
>     157                 return -EFAULT;
>     158 
>     159         if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
>     160                 return -EINVAL;
>     161 
>     162         ioas = get_compat_ioas(ictx);
>     163         if (IS_ERR(ioas))
>     164                 return PTR_ERR(ioas);
>     165 
>     166         if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
>     167                 if (unmap.iova != 0 || unmap.size != 0) {
>     168                         rc = -EINVAL;
>     169                         goto err_put;
>     170                 }
>     171                 rc = iopt_unmap_all(&ioas->iopt, &unmapped);
>     172         } else {
>     173                 if (READ_ONCE(ioas->iopt.disable_large_pages)) {
> --> 174                         unsigned long iovas[] = { unmap.iova + unmap.size - 1,
> 
> The unmap.iova + unmap.size addition can have an integer overflow.  It's
> unclear to me if this is caught later or if it has any negative
> implications.

There are no negative implications to the kernel, which is why I left
it unchecked here.

Do you think we should have the check for the sake of static tools?

Jason
