Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604DDC2D0DB
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 23:56:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B102070E
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 23:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfuynleX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B102070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0F6BD221B7;
	Wed, 29 Jan 2020 23:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRc7KKcHCpzX; Wed, 29 Jan 2020 23:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 32E4B21563;
	Wed, 29 Jan 2020 23:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E888C0881;
	Wed, 29 Jan 2020 23:56:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C462C0171
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 274BB8659B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNTzz8M6qnGY for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 23:56:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 590DB86229
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580342205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FlUx/0EoEDOcXXUzpcXpnQOxR5qtEH6XDuKSHdNwAQ=;
 b=TfuynleXNs2ck5VXo9w6ZatE0dXFOAF/eNbqFuDYGC+OCsFPKUqjKattABi+ZTeauofMCT
 TiIvHp4MH1Sg41MTdgLNCWwaYQG+0sJFhYphj2OsJ3dBBfOO9vqfAQpMnqSPthu5o6ki51
 9XTYXDvkbo9m40g7HmAisFoY85PSLXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Bc17NHRPPPGl2sn0Hbfd7g-1; Wed, 29 Jan 2020 18:56:42 -0500
X-MC-Unique: Bc17NHRPPPGl2sn0Hbfd7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD621800D41;
 Wed, 29 Jan 2020 23:56:40 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 777451001B05;
 Wed, 29 Jan 2020 23:56:32 +0000 (UTC)
Date: Wed, 29 Jan 2020 16:56:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 2/8] vfio/type1: Make per-application (VM) PASID quota
 tunable
Message-ID: <20200129165632.5f69b949@w520.home>
In-Reply-To: <1580299912-86084-3-git-send-email-yi.l.liu@intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 jean-philippe.brucker@arm.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 29 Jan 2020 04:11:46 -0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> The PASID quota is per-application (VM) according to vfio's PASID
> management rule. For better flexibility, quota shall be user tunable
> . This patch provides a VFIO based user interface for which quota can
> be adjusted. However, quota cannot be adjusted downward below the
> number of outstanding PASIDs.
> 
> This patch only makes the per-VM PASID quota tunable. While for the
> way to tune the default PASID quota, it may require a new vfio module
> option or other way. This may be another patchset in future.

If we give an unprivileged user the ability to increase their quota,
why do we even have a quota at all?  I figured we were going to have a
module option tunable so its under the control of the system admin.
Thanks,

Alex

> 
> Previous discussions:
> https://patchwork.kernel.org/patch/11209429/
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 22 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e836d04..1cf75f5 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2243,6 +2243,27 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_type1_set_pasid_quota(struct vfio_iommu *iommu,
> +					    u32 quota)
> +{
> +	struct vfio_mm *vmm = iommu->vmm;
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +	mutex_lock(&vmm->pasid_lock);
> +	if (vmm->pasid_count > quota) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	vmm->pasid_quota = quota;
> +	ret = quota;
> +
> +out_unlock:
> +	mutex_unlock(&vmm->pasid_lock);
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2389,6 +2410,18 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		default:
>  			return -EINVAL;
>  		}
> +	} else if (cmd == VFIO_IOMMU_SET_PASID_QUOTA) {
> +		struct vfio_iommu_type1_pasid_quota quota;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_pasid_quota,
> +				    quota);
> +
> +		if (copy_from_user(&quota, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (quota.argsz < minsz)
> +			return -EINVAL;
> +		return vfio_iommu_type1_set_pasid_quota(iommu, quota.quota);
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 298ac80..d4bf415 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -835,6 +835,28 @@ struct vfio_iommu_type1_pasid_request {
>   */
>  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 22)
>  
> +/**
> + * @quota: the new pasid quota which a userspace application (e.g. VM)
> + * is configured.
> + */
> +struct vfio_iommu_type1_pasid_quota {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u32	quota;
> +};
> +
> +/**
> + * VFIO_IOMMU_SET_PASID_QUOTA - _IOW(VFIO_TYPE, VFIO_BASE + 23,
> + *				struct vfio_iommu_type1_pasid_quota)
> + *
> + * Availability of this feature depends on PASID support in the device,
> + * its bus, the underlying IOMMU and the CPU architecture. In VFIO, it
> + * is available after VFIO_SET_IOMMU.
> + *
> + * returns: latest quota on success, -errno on failure.
> + */
> +#define VFIO_IOMMU_SET_PASID_QUOTA	_IO(VFIO_TYPE, VFIO_BASE + 23)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
