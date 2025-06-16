Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB38176AC5
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085236; cv=none; b=rsJ6lgJrcGaUt7k8c11hHnk2jXDMkxEfNLP6WdnSd7NJwnq2480M3A82h4sMBrZkge13Bw9zrMD24V7D+OLVrfb1mcZI2q8Dnh8zS4K+I+8QbJBeJiKTKEK1Mji23Z7ETljXbEmpcn95JFnVhyCLFz8f9fLigebBDjgmFRN9qFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085236; c=relaxed/simple;
	bh=xg24GodcE/R7QwlKG95Q6b8SkO55s4EXCY89KpOFH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxgQ+4QbiJy91Sz5nkkTPg+6JNaNKh4N20rZLeWJE2zgWPtsQFAJNKXUC9PFsXgl0wudYUQmpFxNbd3PQ/eL7NhMrlwJgMCtTTbqk3Q45FpHK6FOL/BlLo8UTq6V2GSicAEujAJFEclez5d53Q5gUfpZ7KsjkiHCU8mVdBfmW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iePG8Jgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iePG8Jgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750085233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oMCwmhoJuX3afov1EeRHX/PbEgzpQwOebgiLZxq3lU=;
	b=iePG8JgsWw/nq3HxASE4wJt/YgVuTbGqL2Kp67hpwxL+dKW2mpskfifNo7ptKLlEjB22Fx
	L9srq5HoHAdDITGmh86PS8RKCQRrsyruXqHjzeSqcZR4/JtqKP485HSIXKH2QJB22dY7S2
	FPGSUDy8Gr8EG8xG/qSdkMGUHTy+PMs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-46yjUbzUNvaU9PK7tAwrQg-1; Mon, 16 Jun 2025 10:47:12 -0400
X-MC-Unique: 46yjUbzUNvaU9PK7tAwrQg-1
X-Mimecast-MFC-AGG-ID: 46yjUbzUNvaU9PK7tAwrQg_1750085232
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cff09d29dso55146239f.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 07:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750085232; x=1750690032;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oMCwmhoJuX3afov1EeRHX/PbEgzpQwOebgiLZxq3lU=;
        b=DVHSgZHgzyYPbyfTGsADweb6ol3twdeUc8NL3b5AudbB014iiqHWCCpKN+2WiLEM3F
         Kd57BL3SZBx3h1CEtzDU8i3+cey8+yqArCxF1ozPMZe29XshVYK5GrLKdFXPskq/SFn4
         kWOLrB16LZu50cmvFPkPawZ8jxzzWxmKt4WL8y1hQ+UxT30kIOG6PWNfGOAQiO1Q5KYr
         rWYZf8Yh/FFkeIaFEsVRvVvITtTwwx16QXlP+gk6sUBgFqeP9b/8/wVyf0qCQNKQs7ex
         XswHtB7sM6ZLVi+Ua7Z5nXwR5MzT56ET0+cbRrbEUrCugD/6quLDMn1RtIP2cXivXpLg
         /g0w==
X-Forwarded-Encrypted: i=1; AJvYcCVl6bQNNEqHx4IGZkFofHzQ5qB3K1UEmbhJr4589iQxDrh7NMiIX8P9jIXIeY46/QFYZ17aPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxACFTGnblE6iHNTxcRipPyjLRvhbjLfnet4b7y8+EwYURFEIGn
	n+nYPtpw6svuymsA9OehAM3UwqoHzUfNeXmMondHnIb0Sk7Zj8a320jFs4AFgLMvIXL5de/8OQo
	L6LTfKHL+ygLvtiSZvNZOVv2kGWMfCtH87b3aTII2wuXUQuxpGp3Ge6++
X-Gm-Gg: ASbGnctd29zBHRmCNo395fUdsPLm4s8mZdDaBct8ZPDO/w5F8KHkoOMiwsRG7BskK8a
	kIzqgPUn/YnZrXsCCqU9Sx58XvFpSxQLDf2Hni4NUS6UYk+0y5MDRCnHxEDuGVFBKymnvaYLlJX
	NopzfHp25tVUr+54KReNyrdWOpU4RyW9juaZbVGfwt8zwM6GQKxRDX7KUrFwsaWFqygu0ht3UfX
	VDUoWPNSkSEGLM+ME1kls+5SDevy9rmOc6fRZWsHQP7lXC7GorxOULxNBdTNmZu+aWi94OGa6V0
	00oxiS1nn6YF+m9yZepBiPecBw==
X-Received: by 2002:a05:6e02:380a:b0:3dc:8423:545b with SMTP id e9e14a558f8ab-3de07bb2627mr27839295ab.0.1750085231888;
        Mon, 16 Jun 2025 07:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLpLGsMkr0KWba9uSXUpLEeujlM/8bc3J1BFXjs68sqnUor1wGTGtN+OZ3Xm3jdQMZTJM55g==
X-Received: by 2002:a05:6e02:380a:b0:3dc:8423:545b with SMTP id e9e14a558f8ab-3de07bb2627mr27839185ab.0.1750085231534;
        Mon, 16 Jun 2025 07:47:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a4541esm20253865ab.46.2025.06.16.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:47:10 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:47:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250616084708.5a94ead7.alex.williamson@redhat.com>
In-Reply-To: <20250614001555.GR1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
	<20250603152343.1104-2-jacob.pan@linux.microsoft.com>
	<20250613163103.3bca27cd.alex.williamson@redhat.com>
	<20250614001555.GR1174925@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HG7g9HHIQoiDcg_DzBVQdwVAeAt_TYObFs0xh19YjQA_1750085232
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 21:15:55 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 13, 2025 at 04:31:03PM -0600, Alex Williamson wrote:
> > On Tue,  3 Jun 2025 08:23:43 -0700
> > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> >   
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > 
> > > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
> > > open path skips vfio_df_open(), leaving open_count at 0. This causes a
> > > warning in vfio_assert_device_open(device) when vfio_df_close() is called
> > > during group close.
> > > 
> > > The correct behavior is to skip only the IOMMUFD bind in the device open
> > > path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
> > > which was too broad. This patch restores the previous behavior, ensuring
> > > the vfio_df_open is called in the group open path.
> > > 
> > > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > ---
> > > v2: Use a fix from Jason
> > > ---
> > >  drivers/vfio/group.c     | 10 +++++-----
> > >  drivers/vfio/iommufd.c   |  3 ---
> > >  drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
> > >  3 files changed, 21 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > > index c321d442f0da..8f5fe8a392de 100644
> > > --- a/drivers/vfio/group.c
> > > +++ b/drivers/vfio/group.c
> > > @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
> > >  		 * implies they expected translation to exist
> > >  		 */
> > >  		if (!capable(CAP_SYS_RAWIO) ||
> > > -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> > > +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
> > >  			ret = -EPERM;
> > > -		else
> > > -			ret = 0;
> > > -		goto out_put_kvm;
> > > +			goto out_put_kvm;
> > > +		}
> > >  	}
> > >  
> > >  	ret = vfio_df_open(df);
> > >  	if (ret)
> > >  		goto out_put_kvm;
> > >  
> > > -	if (df->iommufd && device->open_count == 1) {
> > > +	if (df->iommufd && device->open_count == 1 &&
> > > +	    !vfio_device_is_noiommu(device)) {  
> > 
> > Why do we need this?  
> 
> What I was trying to do is put all the logic about noiommu into only
> vfio_df..open/close functions instead of sprikling it into a bunch of
> other functions. That seemed to be the right point to make this cut.

Alternatively we could be consistent about breaking out of the
vfio/iommufd.c functions that aren't relevant to noiommu.  The
container side handles noiommu internally, why should iommufd push
handling up to the device file layer?  We're really just missing the
bind path.

TBH, it seems like special casing iommufd in the device file layer is
what led to the issue introduced in 6086efe73498.

> > int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
> >                                     struct iommufd_ctx *ictx)
> > {
> >         u32 ioas_id;
> >         int ret;
> > 
> >         lockdep_assert_held(&vdev->dev_set->lock);
> > 
> >         /* compat noiommu does not need to do ioas attach */
> >         if (vfio_device_is_noiommu(vdev))
> >                 return 0;  
> 
> So this should be removed, I missed it
> 
> > > @@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
> > >  
> > >  	lockdep_assert_held(&vdev->dev_set->lock);
> > >  
> > > -	if (vfio_device_is_noiommu(vdev))
> > > -		return;
> > > -  
> > 
> > Why not keep this and add similar to vfio_df_iommufd_bind()?  It seems
> > cleaner to me.  Thanks,  
> 
> Same as above, we don't check for noiommu in bind, so we should not
> check it in unbind to have a symetrical API design.

Or check it in bind since we already check it in unbind.  Either way,
symmetry.
 
> With this patch we move toward the vfio_df..open/close functions being
> symmetrical in their decision making.

But is it?  We special case all the iommufd paths to filter out noiommu
but it's inconsistent with the legacy paths.  Thanks,

Alex

