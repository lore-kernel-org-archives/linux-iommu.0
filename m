Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08B2E11D4
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853876; cv=none; b=QXYrBP4NpAxgCqx59PXBLtRWLEcj4qVv0+gOds2kVppNAWY9QPIHiuTfYX1UNJKoJE+Ouyuf2eW3p6UUhzbNl7o8Wr9UPy2dRrMPD1DoDyXQTqXJ1uEBjglTyE1eHwpoO35P0qYfkv1w0cIlJvnCrf/UddoBAhEAPW+G15oKXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853876; c=relaxed/simple;
	bh=CUdNhTNdI3W/WjDv4FEJCGsxc0OikP5xHgNGo0iDXpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH5m1C4MPh576508iWfhcjCzPJ4Wki96wPk1V+OkXoUli08XuUHCw291JI0eWS/nmZ/2yWaFyA33Mh6DQophR0YBDEts4DlrYIYZh0m5brRIllo4/9GIKAM77EB5mLLBiAGFngU6lWvn3FrzCssbnCMx3nfry+tVSp5U16cqztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Afrt2b6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afrt2b6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749853873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3NcXW1X2EQ+iIT8GcacHhMupAyBhF1g0lj8W/NWBMY=;
	b=Afrt2b6yd+I4Y0Ez6/0qd2k0ajmwg1tZGLYKW+bjJjbJhLrjmOKiACuBzUN71urBaupuj3
	axAJPtNjzfCziLQD3maxJm4iW4qsPsIdcBaH2CgtNs2bzElrrC2GPbnXDmnMrj/hQsTVH5
	4A4pUv1sg0NvEK0QeR7x1YWsE+jYHUk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-RbPAv648M3OylHcBx-Autg-1; Fri, 13 Jun 2025 18:31:12 -0400
X-MC-Unique: RbPAv648M3OylHcBx-Autg-1
X-Mimecast-MFC-AGG-ID: RbPAv648M3OylHcBx-Autg_1749853872
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dd756e44bcso3072235ab.2
        for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 15:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853871; x=1750458671;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3NcXW1X2EQ+iIT8GcacHhMupAyBhF1g0lj8W/NWBMY=;
        b=SEB0vd+g1LvDGKQFtKAfgdbav33UzpgK8NDxbMNphrmjxNHjYYl1qZQ8SYb9rj2NiW
         SdUBLPlB/pGTt5alxG1RCLkQsVjUO+ZrC+DiPO3cxvgk9+Lg9vUZnU2SVPU5JyG2OtGp
         cMEaUYSJNKxJ5ZiH00qm45CK2epQ2I34xlNrUhzEkAEsI5a2jwwJRf9Xgg7Dryl3P+Gi
         lNVlIbOxpHySA5FZd9Sg+F2R1FFal/KYyHZRerwx8UkD7legM0eT2yBlKbX+3DI5at3w
         vJ+MlJhVO57TPNM1g4d97umZMIHkENEfdA0JMqNrbvlMCxSYnLhEINEXNU/F6wWRn5uY
         U3cg==
X-Forwarded-Encrypted: i=1; AJvYcCViIsYLegxqXNdsQ5ZgPGAUX1RVLaLJw7ZzcO9s6VQnmMQgWq1RCFtiYnCymd9gjCBQK0wNFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMkiXqogFmy0QDsc+unxHh7+LKplB/zM4+LButzwUIrjuNZwKE
	xjBPFJ18rPZ3HYzJDtG2HcMiRw1AkVXH2gVkCgNTmv8JUQdTxQnZhL0/q+ehdlpKiIhsGgu3f0o
	zH9g4TqCrEd6P+Ah/muWT2Vyc3y2ZADGsiQmHlKa2KbV49MAvbhnUO3Y9iNVsiFeg
X-Gm-Gg: ASbGnctlIQT8fgJsYxgFCKzmZJXYAUyxR0nuQBYyTBKFR4i2t3UfXGrtTWXXCltEYtR
	Jv8o0DDhJeZYf5p8ZJAaLi+q+0rYphNv7rW4SVfua7r47P3XGWur0mK7DE5KoiHPgdM3Ua9v7QO
	3OG14Ko/8UsOknZs1/8fPq2k6B5y9i2lleg5vgxlLUQpcEmoy9IAlu3r1ShkkSDpthDMNeadI7l
	sl54YCIywdqDAaHCHlkR+iLBlKYsSRKmUTTyWV463Fq3dRjSt8bZ84cWKKlza6wsbaz7zgckkjU
	4Uj0Fk+UUxV6aQlujfYTpoda/w==
X-Received: by 2002:a05:6602:608a:b0:873:13c6:f37b with SMTP id ca18e2360f4ac-875dede0723mr34496339f.3.1749853871306;
        Fri, 13 Jun 2025 15:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXSXoSbA8I0Hvkx//SE0JzUwJmJV92eYQmiHgIhgmK7NohihKNmCrzP0m9Qv08pVXoJvoxw==
X-Received: by 2002:a05:6602:608a:b0:873:13c6:f37b with SMTP id ca18e2360f4ac-875dede0723mr34494539f.3.1749853870935;
        Fri, 13 Jun 2025 15:31:10 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149ca2aa9sm508990173.123.2025.06.13.15.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:31:09 -0700 (PDT)
Date: Fri, 13 Jun 2025 16:31:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250613163103.3bca27cd.alex.williamson@redhat.com>
In-Reply-To: <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
	<20250603152343.1104-2-jacob.pan@linux.microsoft.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CcXPjH9dT2KBCoL8sIZ9VlwVsr2Wo4-uKoPlq6s0B7I_1749853872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 08:23:43 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
> open path skips vfio_df_open(), leaving open_count at 0. This causes a
> warning in vfio_assert_device_open(device) when vfio_df_close() is called
> during group close.
> 
> The correct behavior is to skip only the IOMMUFD bind in the device open
> path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
> which was too broad. This patch restores the previous behavior, ensuring
> the vfio_df_open is called in the group open path.
> 
> Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v2: Use a fix from Jason
> ---
>  drivers/vfio/group.c     | 10 +++++-----
>  drivers/vfio/iommufd.c   |  3 ---
>  drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c321d442f0da..8f5fe8a392de 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>  		 * implies they expected translation to exist
>  		 */
>  		if (!capable(CAP_SYS_RAWIO) ||
> -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
>  			ret = -EPERM;
> -		else
> -			ret = 0;
> -		goto out_put_kvm;
> +			goto out_put_kvm;
> +		}
>  	}
>  
>  	ret = vfio_df_open(df);
>  	if (ret)
>  		goto out_put_kvm;
>  
> -	if (df->iommufd && device->open_count == 1) {
> +	if (df->iommufd && device->open_count == 1 &&
> +	    !vfio_device_is_noiommu(device)) {

Why do we need this?

int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
                                    struct iommufd_ctx *ictx)
{
        u32 ioas_id;
        int ret;

        lockdep_assert_held(&vdev->dev_set->lock);

        /* compat noiommu does not need to do ioas attach */
        if (vfio_device_is_noiommu(vdev))
                return 0;


>  		ret = vfio_iommufd_compat_attach_ioas(device, df->iommufd);
>  		if (ret)
>  			goto out_close_device;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c8c3a2d53f86..26c9c3068c77 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> -	if (vfio_device_is_noiommu(vdev))
> -		return;
> -

Why not keep this and add similar to vfio_df_iommufd_bind()?  It seems
cleaner to me.  Thanks,

Alex

>  	if (vdev->ops->unbind_iommufd)
>  		vdev->ops->unbind_iommufd(vdev);
>  }
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 5046cae05222..ac2dbd4e5d04 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -506,17 +506,19 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
>  {
>  	struct vfio_device *device = df->device;
>  	struct iommufd_ctx *iommufd = df->iommufd;
> -	int ret;
> +	int ret = 0;
>  
>  	lockdep_assert_held(&device->dev_set->lock);
>  
>  	if (!try_module_get(device->dev->driver->owner))
>  		return -ENODEV;
>  
> -	if (iommufd)
> -		ret = vfio_df_iommufd_bind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			ret = vfio_df_iommufd_bind(df);
> +	} else {
>  		ret = vfio_device_group_use_iommu(device);
> +	}
>  	if (ret)
>  		goto err_module_put;
>  
> @@ -528,10 +530,12 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
>  	return 0;
>  
>  err_unuse_iommu:
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>  		vfio_device_group_unuse_iommu(device);
> +	}
>  err_module_put:
>  	module_put(device->dev->driver->owner);
>  	return ret;
> @@ -546,10 +550,12 @@ static void vfio_df_device_last_close(struct vfio_device_file *df)
>  
>  	if (device->ops->close_device)
>  		device->ops->close_device(device);
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>  		vfio_device_group_unuse_iommu(device);
> +	}
>  	module_put(device->dev->driver->owner);
>  }
>  

