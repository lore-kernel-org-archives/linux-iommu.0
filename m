Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7D1DD529
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274243; cv=none; b=PxNj88ISiDqET4zT+GhYUygeTKhIcnuy1dqT3qQ7rDM5kTrVQO4RGXCqmXyVUbM2i517NLsFRifYaricpDkadIiqWAlBLgfVh1a/Li3ZOgbe7Piq7BTohLeL9jz2Pldx12IQbsu+2tADqUGv1hETMag7tuHk49J9ZiUuE4lUsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274243; c=relaxed/simple;
	bh=qYP/iGjLnpgD3InKq+jEENsxYWOj3Hd8bC9doHLoCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bp8HWwL3saVmS7D+mu/68qMjeWZPfTuZuJqTY0Gzu6wYL0gaHtnsA8gf0DoKRGRBBVItHxe0ZpmDfNarzHBG5pIYZ3USY9KhIPKc8W0Bi2TJ0MrTU9jVnnGZBD4RPo6Iq9PJMuKX35gDzoRCr+kjEZi5Y6/1DVWBmrJwU1e8t6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+toPbGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+toPbGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752274240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYBwdTFr6UYn+pTQMaNURbPHGMcyuBfNo7zVfzGq+M=;
	b=B+toPbGDzZWEzMYIpYGFQyP8raaEpn2TB9/TTYeKIPWrrO7A9fXNiVB7SV/aUPPh46G0e/
	J9CiQ0PtLXFG/VEvIJdQX8hC7U4DE2QirMnZBQAY+84Na48En4fHXyVRkDME4GACrPnwxA
	w8a4nCW84XCeUz54yjcSYFmvTVH/5B0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-Xwv5bGt3PC2ZmNCEBilqRw-1; Fri, 11 Jul 2025 18:50:37 -0400
X-MC-Unique: Xwv5bGt3PC2ZmNCEBilqRw-1
X-Mimecast-MFC-AGG-ID: Xwv5bGt3PC2ZmNCEBilqRw_1752274237
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df359a108bso4935625ab.3
        for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 15:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752274237; x=1752879037;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiYBwdTFr6UYn+pTQMaNURbPHGMcyuBfNo7zVfzGq+M=;
        b=KTpfM3y7fp4VU9Szmw4R0MQxDittXffqup5nD4jeqEf1odM+hfn51JWTvtgvaqcRk+
         ZmrKzikI0M8iIcHAUBLzJA9qZomuK2EPi6mb4gOySwu01n4OG2uCqt4Tq01kNRBu72RZ
         hModdlG4G30k2od2n9Qj33ebpTanfC9AUAvYQc7QK/dGHDxwQ17IXXq3xrqRviTuGmw0
         Y10zyPmUcpJ893lswXZ0oXCR1PDNx41MVWrJZEha9lwaskT0jxu8OSPhq3WuiexODqwM
         N1eV6i/k+rAqhQymZdvxW818PtzcMVoE85fv0dEbEyLDSVSyYFuKm1OuSTKwJI3t8040
         GRkg==
X-Forwarded-Encrypted: i=1; AJvYcCWFG75HXPoRLbm20PIMMWZIbnJq8ELwB8K3C/9WJ3gdmJeI713OOOxKvtKzghxGkg8wG3p3Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoT0S7BqbhsVO42IMEOjuFKKJKFQRaxA63YBJQmgD3CeZaOl6G
	7A6pYWaaxUP19p16rJcvsXmBllSjEzEQl1k1NYd83kd0hgj7Eo+rSSUzNz9lapDGzwe0I2ZdtWr
	JckvamcmWDgtV4GP/fZtZQs5zFZdQbB00xbZ45wkZYEHkb81drOThF5WW
X-Gm-Gg: ASbGncu+bDm38azHvku+Yvn66zhIEmbodGEVg01uPYve4k47utoTvyjTcrOkQsdoJcP
	xr3ojnuB/X4x39z9Gaf3H37MFtFDmaMa0mDMhkdWPKx96+5d40n0eDL2Fp4J39JLKicL523zxB/
	COeSAmLPr8aL0z+64Ns3yy87QVoS1gb7QDAnieslaC7DT7VSCPcR306eEOynj1WN9shg6eJkRoD
	6B057ziNN8dgyXf2pw9Zf8WQv0rb+8CqaNf7lac+pHub8vdN61qhcYhGmHgmIBeEpNa5oX60iSW
	2DTBTc1Ef/pZq2/h8WjMnma/43tCLu0nXxVbXL7Layc=
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr18674535ab.5.1752274236854;
        Fri, 11 Jul 2025 15:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjwjYtI+ErmAwmWa/FqoT9OKqNB7tntH55hciTWbq8HIF2pSRrgP859jsyuWc6atNz+5+cJw==
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr18674455ab.5.1752274236383;
        Fri, 11 Jul 2025 15:50:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2461573a0sm14745155ab.31.2025.07.11.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:50:35 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:50:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3 1/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250711165033.010efe96.alex.williamson@redhat.com>
In-Reply-To: <76681.125071014402700656@us-mta-395.us.mimecast.lan>
References: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
	<76681.125071014402700656@us-mta-395.us.mimecast.lan>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nUxKL2CWAHv5YxVEchIhwlH577UJIEG45NCUzyD9iKc_1752274237
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 11:40:25 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Alex et al,
> 
> Just wondering if there are more comments?

Seems not.  Sorry for the delay, these just fell early in the cycle and
other patches are going through various re-spins.  Applied to vfio next
branch for v6.17.  Thanks,

Alex
 
> On Wed, 18 Jun 2025 16:46:17 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the
> > group open path skips vfio_df_open(), leaving open_count at 0. This
> > causes a warning in vfio_assert_device_open(device) when
> > vfio_df_close() is called during group close.
> > 
> > The correct behavior is to skip only the IOMMUFD bind in the device
> > open path for no-iommu devices. Commit 6086efe73498 omitted
> > vfio_df_open(), which was too broad. This patch restores the previous
> > behavior, ensuring the vfio_df_open is called in the group open path.
> > 
> > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation
> > out of vfio_iommufd_bind()") Suggested-by: Alex Williamson
> > <alex.williamson@redhat.com> Suggested-by: Jason Gunthorpe
> > <jgg@nvidia.com> Signed-off-by: Jacob Pan
> > <jacob.pan@linux.microsoft.com> ---
> > v3: Apply a concise fix from Alex
> > v2: Use a fix from Jason
> > ---
> >  drivers/vfio/group.c   | 7 +++----
> >  drivers/vfio/iommufd.c | 4 ++++
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > index c321d442f0da..c376a6279de0 100644
> > --- a/drivers/vfio/group.c
> > +++ b/drivers/vfio/group.c
> > @@ -192,11 +192,10 @@ static int vfio_df_group_open(struct
> > vfio_device_file *df)
> >  		 * implies they expected translation to exist
> >  		 */
> >  		if (!capable(CAP_SYS_RAWIO) ||
> > -		    vfio_iommufd_device_has_compat_ioas(device,
> > df->iommufd))
> > +		    vfio_iommufd_device_has_compat_ioas(device,
> > df->iommufd)) { ret = -EPERM;
> > -		else
> > -			ret = 0;
> > -		goto out_put_kvm;
> > +			goto out_put_kvm;
> > +		}
> >  	}
> >  
> >  	ret = vfio_df_open(df);
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index c8c3a2d53f86..a38d262c6028 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -25,6 +25,10 @@ int vfio_df_iommufd_bind(struct vfio_device_file
> > *df) 
> >  	lockdep_assert_held(&vdev->dev_set->lock);
> >  
> > +	/* Returns 0 to permit device opening under noiommu mode */
> > +	if (vfio_device_is_noiommu(vdev))
> > +		return 0;
> > +
> >  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> >  }
> >    
> 

