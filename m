Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB148D51B
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 18:11:08 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id d9so26521823wrm.13
        for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXUrh/5nwD/o+lxT2UQDr3GIedJ5OTEbeeA4oKAPCJU=;
        b=HIgDYWVXWjmS+KTbLLdGplMOxwcC9jfWjS7pjRFM1xOd3Xlixm82Uy7BdGGtO6Va5G
         NlD+BNS8bA1OgESs0vTdz9zWfJw6f/vc7RfUK8EKvewuXh2+kfyASYH8XMk3j09j3Hi+
         9SD4pq/wsqoscwcsthe+SqluXpsGOKFISXaWeom3jms0Iw9pCRno4Dm2XiuWGCteTAL2
         +kj3u/kUySXUJoK+McyDLOTJXMFzDsrEC4sc6R2LD236jT2F/pnU1vSqPlezzAF4Azo4
         uWEq3qhbDcVgKz4ZrXQqrZO8jUMXZQuKBGaRT9GOGIPFJQoo2VlMsKyAZu70T4S1s2U0
         pUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXUrh/5nwD/o+lxT2UQDr3GIedJ5OTEbeeA4oKAPCJU=;
        b=ukJ/aTJWCz7bwbJpOUEKQYjMbtvFCVOVmNlT871uP0sBGi+Dl+VyOZD0H6TBahOjZf
         AdzZSGe+9r0FMFbDaW2uTtDsXNvipUt9t++CJgBMhrpEMIFTdKKAyMnS5W0QQlJgnpeW
         8uD0D/LeP5okM9iemUyZqOLfqDeRcGN+4ZMibXgmfDGdPnv064058xdYJvjGGdPSylc6
         a++A1RxScnbFh3DkD8HikYBlAFRM918GZz8w4He4SdY6bq2NXK6WcS5rE7ihEbkNz1mR
         1ntZvjUsxs/JA1EKGHLq+H2Q0bBH9tqSeWBc0YjuE0Nrh4k9mA8bJZ7VmRCwSeiesiE2
         CJyg==
X-Gm-Message-State: ANoB5pma1DDzoFXhRUs5rJ5ceD7+aEd+Pud9lv7IymJkr40ikILXrjtU
	UFc/TUE9DcEbPsFjmbsGaLI=
X-Google-Smtp-Source: AA0mqf4dY4OsqWQ9ilBzVdWnLdqzfeksb8IeB81scWDAHwf0V02NHZgCQZDCm8FKNeGVXCeAMK9AOA==
X-Received: by 2002:a05:6000:3c3:b0:22e:3275:983e with SMTP id b3-20020a05600003c300b0022e3275983emr15028487wrg.71.1668622267054;
        Wed, 16 Nov 2022 10:11:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003cf78aafdd7sm3172139wmq.39.2022.11.16.10.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:11:06 -0800 (PST)
Date: Wed, 16 Nov 2022 21:11:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y3UntBjV51+MNwep@kadam>
References: <Y2Nhj0mIjrSJwO7W@kili>
 <Y3P2oEIICOTiVOBH@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3P2oEIICOTiVOBH@ziepe.ca>

On Tue, Nov 15, 2022 at 04:29:20PM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 15, 2022 at 03:45:00PM +0300, Dan Carpenter wrote:
> > [ Resending two weeks of email because mutt + msmtp has been silently
> >   eating my outgoing mail instead of delivering it.  *sigh* -dan ]
> > 
> > Hello Jason Gunthorpe,
> > 
> > The patch 32c328dc9b73: "iommufd: vfio container FD ioctl
> > compatibility" from Dec 15, 2021, leads to the following Smatch
> > static checker warning:
> > 
> > 	drivers/iommu/iommufd/vfio_compat.c:174 iommufd_vfio_unmap_dma()
> > 	warn: potential integer overflow from user (local copy) 'unmap.iova + unmap.size'
> > 
> > drivers/iommu/iommufd/vfio_compat.c
> >     140 static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
> >     141                                   void __user *arg)
> >     142 {
> >     143         size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> >     144         /*
> >     145          * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
> >     146          * dirty tracking direction:
> >     147          *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
> >     148          *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
> >     149          */
> >     150         u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
> >     151         struct vfio_iommu_type1_dma_unmap unmap;
> >     152         struct iommufd_ioas *ioas;
> >     153         unsigned long unmapped;
> >     154         int rc;
> >     155 
> >     156         if (copy_from_user(&unmap, arg, minsz))
> >     157                 return -EFAULT;
> >     158 
> >     159         if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
> >     160                 return -EINVAL;
> >     161 
> >     162         ioas = get_compat_ioas(ictx);
> >     163         if (IS_ERR(ioas))
> >     164                 return PTR_ERR(ioas);
> >     165 
> >     166         if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> >     167                 if (unmap.iova != 0 || unmap.size != 0) {
> >     168                         rc = -EINVAL;
> >     169                         goto err_put;
> >     170                 }
> >     171                 rc = iopt_unmap_all(&ioas->iopt, &unmapped);
> >     172         } else {
> >     173                 if (READ_ONCE(ioas->iopt.disable_large_pages)) {
> > --> 174                         unsigned long iovas[] = { unmap.iova + unmap.size - 1,
> > 
> > The unmap.iova + unmap.size addition can have an integer overflow.  It's
> > unclear to me if this is caught later or if it has any negative
> > implications.
> 
> There are no negative implications to the kernel, which is why I left
> it unchecked here.
> 
> Do you think we should have the check for the sake of static tools?

No.  I've written something like five different integer overflow checks.
One is pretty decent but the problem is a hard nut to crack.  This
heuristic here is not useful enough to the point where we'd want to
silence false positives.

regards,
dan carpenter

