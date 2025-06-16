Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CB38DDB
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102813; cv=none; b=ZBR4saOKLMMWhUfNAA3ps5LUouC56MVAmoatTMbenBK+0DaPovJQ+Ahn+57Nry3ae442Z6aq3guKR0/DwlI5L29JCl19MqMQ5Lu4rtH7sfaZJvSKnF7EQBoF3LdMUf3dllLeu+5Qn2gbruBFuf/81YnfdUykMhk2IE8n/I03Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102813; c=relaxed/simple;
	bh=2HSj50ZkFeGvip9u2ovexwxRbE+rayK2QY+MngvUtSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMnT3xOutbSprlz5O9aEkmpZKCSD9N9MbU4z+bJBGcSHiFaeiNWweMI/RQIRh6iZr7aPfcVgC8HfSx5JbMw0ad6SUTnTf+jW18UW6OLCL0w1YGXSb1iCUM07ZCRzhHTnvbyPwrjqXrFkv1eP1/re26IlRM62ZOIsxYRkhiM5JUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fF43hVTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF43hVTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750102810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv0l4BNCIbAbpcAAOOCGBfYtJjS97nEwM6epWvM50jQ=;
	b=fF43hVTAfDRzgYUulmljd/nN74DrKMmM1MDUtTJWDTfdVkAD1972+O7+SpDR2NGOnQ/tvr
	DDJypodfbmM+0N5ubJlhGQSAz05d87FnqpEqKH/xofp6PTEYcS11vq3JybyQtQb0YgE7Ok
	iBngBKAzcGf/3HiMK6Il9atEF3hvkhk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-6D3Kh397N8S501neY78c2A-1; Mon, 16 Jun 2025 15:40:09 -0400
X-MC-Unique: 6D3Kh397N8S501neY78c2A-1
X-Mimecast-MFC-AGG-ID: 6D3Kh397N8S501neY78c2A_1750102808
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf30a9be6so66244639f.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750102808; x=1750707608;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv0l4BNCIbAbpcAAOOCGBfYtJjS97nEwM6epWvM50jQ=;
        b=cWLx19SbMq1ZPr3Ma68/8X7Q+TjnrwX8ETEPBOM4nK2t41BlWJ2HlyiALlDUdkZZAe
         hQYKcbKFVtsdVLiXlfBP8YQmMA5VYN+5ku3nLOCgJ2o7KEm0sVq2BEYVl1jJxue/cNL+
         NSjce4QXG9pi93bojZ6RYwW3ToidCq/WtSM3tVuoFsf+/jbvpYymFMe1cCdWoYuUq6Qy
         uiYzyNol6JaY9A8OqBAr1dlLNFLiHCTL7BjmZguVX9e9gd7T/csWl9Fgm3N3kEllqvk6
         9QvRq/oW2sylLLNGoy76+fMeECvd2lIE0jT/7IZAqTdmPBo4q3NFUm+QeEXsOrugIr8/
         CNhA==
X-Forwarded-Encrypted: i=1; AJvYcCX6XhXG1Ikcp1gZNCMK/6LtaIiw0GVRlDwsP855yD81Bh11NNzLV025duieI/zoTaVd4CUmKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzslJhn4uFGQgyh7UPYzM6uBAzY73b2XsIk6oSz3d/9jzmaVNZZ
	+xCf2GTQC+VKz0RHokXBYLfm13g8XkK2vrBeHA6F5WnK5sQXjVl9OWYA1TqWJq8q8G5vJB/DrSc
	Qha8fvQtieSc0hy4JRMLNRnvse22rKjj9nJLFL5AzehTsFiYKXk9NQOWI
X-Gm-Gg: ASbGnctofLMFwWdQ4KnTOmaN+rGRHKF5/ubYSNzPBqvyrD04xITAVkR7V/Xzlj2Kj+5
	T5O37TpyZB7k9L3m+pPNic1KIzIzhmSZVF+fzRLV/MY5XTYsSVnSQITjX2yP4p72kPqQYDua1hW
	pRXgi40h6ySP98nlHFAObXX2kX/tDCcuJWD/yZ3TS/WmWEsbSj3Izo9E31/8Wt8o1rWncrhQJvw
	td29+XRdctsIBgzJLljpE+TbhhQ9CCb5FBbzCEfwO/Lz9GnSOA4pGqJ90+ZqJarr3eV+sgAqZdZ
	DEYzLdV9warmVlcyfpEKwoBErg==
X-Received: by 2002:a05:6602:1683:b0:873:13c6:f365 with SMTP id ca18e2360f4ac-875dedfd0efmr313067639f.5.1750102808218;
        Mon, 16 Jun 2025 12:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnRPBkV684dJntapdXKPif4JLdEUHjwAgaMW17ime3UOUTf06bvLAvLx4npqtrBInZ4sL6Jg==
X-Received: by 2002:a05:6602:1683:b0:873:13c6:f365 with SMTP id ca18e2360f4ac-875dedfd0efmr313066539f.5.1750102807793;
        Mon, 16 Jun 2025 12:40:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149ca3519sm1818547173.144.2025.06.16.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:40:06 -0700 (PDT)
Date: Mon, 16 Jun 2025 13:40:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250616134004.60105ad5.alex.williamson@redhat.com>
In-Reply-To: <20250616153455.GK1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
	<20250603152343.1104-2-jacob.pan@linux.microsoft.com>
	<20250613163103.3bca27cd.alex.williamson@redhat.com>
	<20250614001555.GR1174925@nvidia.com>
	<20250616084708.5a94ead7.alex.williamson@redhat.com>
	<20250616153455.GK1174925@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zJL4RXMCuNZtni-nzY-swtg66-zLpIFotujt_LsaeIk_1750102808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 12:34:55 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 16, 2025 at 08:47:08AM -0600, Alex Williamson wrote:
> > On Fri, 13 Jun 2025 21:15:55 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Fri, Jun 13, 2025 at 04:31:03PM -0600, Alex Williamson wrote:  
> > > > On Tue,  3 Jun 2025 08:23:43 -0700
> > > > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> > > >     
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > 
> > > > > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
> > > > > open path skips vfio_df_open(), leaving open_count at 0. This causes a
> > > > > warning in vfio_assert_device_open(device) when vfio_df_close() is called
> > > > > during group close.
> > > > > 
> > > > > The correct behavior is to skip only the IOMMUFD bind in the device open
> > > > > path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
> > > > > which was too broad. This patch restores the previous behavior, ensuring
> > > > > the vfio_df_open is called in the group open path.
> > > > > 
> > > > > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> > > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > > > ---
> > > > > v2: Use a fix from Jason
> > > > > ---
> > > > >  drivers/vfio/group.c     | 10 +++++-----
> > > > >  drivers/vfio/iommufd.c   |  3 ---
> > > > >  drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
> > > > >  3 files changed, 21 insertions(+), 18 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > > > > index c321d442f0da..8f5fe8a392de 100644
> > > > > --- a/drivers/vfio/group.c
> > > > > +++ b/drivers/vfio/group.c
> > > > > @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
> > > > >  		 * implies they expected translation to exist
> > > > >  		 */
> > > > >  		if (!capable(CAP_SYS_RAWIO) ||
> > > > > -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> > > > > +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
> > > > >  			ret = -EPERM;
> > > > > -		else
> > > > > -			ret = 0;
> > > > > -		goto out_put_kvm;
> > > > > +			goto out_put_kvm;
> > > > > +		}
> > > > >  	}
> > > > >  
> > > > >  	ret = vfio_df_open(df);
> > > > >  	if (ret)
> > > > >  		goto out_put_kvm;
> > > > >  
> > > > > -	if (df->iommufd && device->open_count == 1) {
> > > > > +	if (df->iommufd && device->open_count == 1 &&
> > > > > +	    !vfio_device_is_noiommu(device)) {    
> > > > 
> > > > Why do we need this?    
> > > 
> > > What I was trying to do is put all the logic about noiommu into only
> > > vfio_df..open/close functions instead of sprikling it into a bunch of
> > > other functions. That seemed to be the right point to make this cut.  
> > 
> > Alternatively we could be consistent about breaking out of the
> > vfio/iommufd.c functions that aren't relevant to noiommu.  The
> > container side handles noiommu internally, why should iommufd push
> > handling up to the device file layer?  We're really just missing the
> > bind path.  
> 
> Broadly what I was going for was to just remove the iommufd stuff
> entirely from the DF layer rather than to half pretend there is an
> iommufd layer below it. This should ideally go as far as not having an
> iommufd_ctx at all. So things start to look really weird calling
> iommufd functions without an iommufd ctx.
> 
> > > With this patch we move toward the vfio_df..open/close functions being
> > > symmetrical in their decision making.  
> > 
> > But is it?  We special case all the iommufd paths to filter out noiommu
> > but it's inconsistent with the legacy paths.  Thanks,  
> 
> The container still exists in noiommu mode and internally does things,
> eg it has a container->noiommu indicationm and the vfio-noiommu ops to
> manage this.
> 
> The iommufd should not exist and should never be used. They are
> different cases.
> 
> If Jacob eventually does what I suggested in another email then we
> would have a noiommu special mode inside iommufd and it would look
> more like the container.

A concise fix would be nice for stable backports though, so even if we
want to move to testing noiommu in the device file layer or create a
special mode in iommufd, the smallest, most consistent initial fix
would be to continue the _group_open:

--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		 * implies they expected translation to exist
 		 */
 		if (!capable(CAP_SYS_RAWIO) ||
-		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
 			ret = -EPERM;
-		else
-			ret = 0;
-		goto out_put_kvm;
+			goto out_put_kvm;
+		}
 	}


And add a noiommu exit branch to _iommufd_bind, symmetric to unbind.
Right?  Thanks,

Alex

