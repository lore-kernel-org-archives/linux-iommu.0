Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8E2FCE3E
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172828; cv=none; b=lWRYS/riPoc4fNUvoLcyCoLBHfGdDQ88hnfPTSDz6m4ZpL2MfDUr9tf9F4NnUz1usNqYNIj5So9YbJpKK+9aqYw+krK2nQYTQC/Y4tuJOI4UphmdzmZ5m530tgbYhfyBOVt8AoSrjn1SFbL9Hcs9QYuO6Gxpsv3IMQuuN16A0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172828; c=relaxed/simple;
	bh=cbzc4DY0erk9H+IqggzndGyNYcKfTl0/PrlvEOS6xzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYxAWGaK0VOvfekRwxx0DstvFDe+Xf5UHMDFgwfyr3bNHDkmeYNcy0nq12fFzwy9gj32/Y/tBtIPdITwXy2fPMsh0Qi710/YD3EKHITAEHsApjs7CSTg+zRb7xKw0TcztmL4obrH/0kFEkF2jVjAWDQRV5/4HRudl/0/CSUucts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IIAJzycP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IIAJzycP"
Received: from DESKTOP-0403QTC. (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CB862016599;
	Thu, 10 Jul 2025 11:40:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CB862016599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752172826;
	bh=oRpUJ7H7KpE7ZaqAbd3XK00114roFBFMbOzlTE97RIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=IIAJzycPZLzjgvxyJ8xmwt954+EEqzUUAMuQiG8XuowILxDhBVOmXVRuZfwC/52+M
	 yUITfmNDZsNGi8cRUbhb3+ziWgPci4GivwjKbQA48It0VlD3r8auAlNWHZmtbL4KuP
	 1BR+t6OqzrBSQHLYJLIKbd7tJHQIzy/BkrJSlYJo=
Date: Thu, 10 Jul 2025 11:40:25 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>, Jacob
 Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3 1/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250710114025.513b0af4@DESKTOP-0403QTC.>
In-Reply-To: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
References: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Alex et al,

Just wondering if there are more comments?

Thanks,

Jacob

On Wed, 18 Jun 2025 16:46:17 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the
> group open path skips vfio_df_open(), leaving open_count at 0. This
> causes a warning in vfio_assert_device_open(device) when
> vfio_df_close() is called during group close.
> 
> The correct behavior is to skip only the IOMMUFD bind in the device
> open path for no-iommu devices. Commit 6086efe73498 omitted
> vfio_df_open(), which was too broad. This patch restores the previous
> behavior, ensuring the vfio_df_open is called in the group open path.
> 
> Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation
> out of vfio_iommufd_bind()") Suggested-by: Alex Williamson
> <alex.williamson@redhat.com> Suggested-by: Jason Gunthorpe
> <jgg@nvidia.com> Signed-off-by: Jacob Pan
> <jacob.pan@linux.microsoft.com> ---
> v3: Apply a concise fix from Alex
> v2: Use a fix from Jason
> ---
>  drivers/vfio/group.c   | 7 +++----
>  drivers/vfio/iommufd.c | 4 ++++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c321d442f0da..c376a6279de0 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,11 +192,10 @@ static int vfio_df_group_open(struct
> vfio_device_file *df)
>  		 * implies they expected translation to exist
>  		 */
>  		if (!capable(CAP_SYS_RAWIO) ||
> -		    vfio_iommufd_device_has_compat_ioas(device,
> df->iommufd))
> +		    vfio_iommufd_device_has_compat_ioas(device,
> df->iommufd)) { ret = -EPERM;
> -		else
> -			ret = 0;
> -		goto out_put_kvm;
> +			goto out_put_kvm;
> +		}
>  	}
>  
>  	ret = vfio_df_open(df);
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c8c3a2d53f86..a38d262c6028 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,6 +25,10 @@ int vfio_df_iommufd_bind(struct vfio_device_file
> *df) 
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
> +	/* Returns 0 to permit device opening under noiommu mode */
> +	if (vfio_device_is_noiommu(vdev))
> +		return 0;
> +
>  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>  }
>  

