Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D3C2D0DB
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 23:57:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1670520658
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 23:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9E5Yxr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1670520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C85AC87614;
	Wed, 29 Jan 2020 23:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAzytj4tMhRi; Wed, 29 Jan 2020 23:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4A23875BD;
	Wed, 29 Jan 2020 23:57:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A95BCC0881;
	Wed, 29 Jan 2020 23:57:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C087AC0171
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ADB6F862DB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LuCWbfgUYyVi for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 23:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A52A78625F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580342233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+RBsRXk9UqoEKMvj3AN8EzyRStu7sEvnhflEiHsn+I=;
 b=S9E5Yxr7D2rQ1QZdIqjTIBz2mbCSHh6WQ/QX6aBr5MdjdO+05iQA7Q8/VsEpv1uoxfT5pG
 1OkiYj15mJ6g8cWCJBh41xLB1wKyGOmpwPVataLjEJAb1oSwytwthm6up2hpwMefGRYLAi
 QtGlxnfkzoeitkU2lHQIiI3crTwknfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-IpV70zEAN22XV2ppjF8Ejw-1; Wed, 29 Jan 2020 18:57:11 -0500
X-MC-Unique: IpV70zEAN22XV2ppjF8Ejw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4C31083EA6;
 Wed, 29 Jan 2020 23:57:09 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 648D119488;
 Wed, 29 Jan 2020 23:57:03 +0000 (UTC)
Date: Wed, 29 Jan 2020 16:56:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 3/8] vfio: Reclaim PASIDs when application is down
Message-ID: <20200129165640.4f1d42e0@w520.home>
In-Reply-To: <1580299912-86084-4-git-send-email-yi.l.liu@intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On Wed, 29 Jan 2020 04:11:47 -0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> When userspace application is down, kernel should reclaim the PASIDs
> allocated for this application to avoid PASID leak. This patch adds
> a PASID list in vfio_mm structure to track the allocated PASIDs. The
> PASID reclaim will be triggered when last vfio container is released.
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
>  drivers/vfio/vfio.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/vfio.h |  6 ++++++
>  2 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c43c757..425d60a 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2148,15 +2148,31 @@ static struct vfio_mm *vfio_create_mm(struct mm_struct *mm)
>  	vmm->pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
>  	vmm->pasid_count = 0;
>  	mutex_init(&vmm->pasid_lock);
> +	INIT_LIST_HEAD(&vmm->pasid_list);
>  
>  	list_add(&vmm->vfio_next, &vfio.vfio_mm_list);
>  
>  	return vmm;
>  }
>  
> +static void vfio_mm_reclaim_pasid(struct vfio_mm *vmm)
> +{
> +	struct pasid_node *pnode, *tmp;
> +
> +	mutex_lock(&vmm->pasid_lock);
> +	list_for_each_entry_safe(pnode, tmp, &vmm->pasid_list, next) {
> +		pr_info("%s, reclaim pasid: %u\n", __func__, pnode->pasid);
> +		list_del(&pnode->next);
> +		ioasid_free(pnode->pasid);
> +		kfree(pnode);
> +	}
> +	mutex_unlock(&vmm->pasid_lock);
> +}
> +
>  static void vfio_mm_unlock_and_free(struct vfio_mm *vmm)
>  {
>  	mutex_unlock(&vfio.vfio_mm_lock);
> +	vfio_mm_reclaim_pasid(vmm);
>  	kfree(vmm);
>  }
>  
> @@ -2204,6 +2220,39 @@ struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
>  }
>  EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
>  
> +/**
> + * Caller should hold vmm->pasid_lock
> + */
> +static int vfio_mm_insert_pasid_node(struct vfio_mm *vmm, u32 pasid)
> +{
> +	struct pasid_node *pnode;
> +
> +	pnode = kzalloc(sizeof(*pnode), GFP_KERNEL);
> +	if (!pnode)
> +		return -ENOMEM;
> +	pnode->pasid = pasid;
> +	list_add(&pnode->next, &vmm->pasid_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * Caller should hold vmm->pasid_lock
> + */
> +static void vfio_mm_remove_pasid_node(struct vfio_mm *vmm, u32 pasid)
> +{
> +	struct pasid_node *pnode, *tmp;
> +
> +	list_for_each_entry_safe(pnode, tmp, &vmm->pasid_list, next) {
> +		if (pnode->pasid == pasid) {
> +			list_del(&pnode->next);
> +			kfree(pnode);
> +			break;
> +		}

The _safe() list walk variant is only needed when we continue to walk
the list after removing an entry.  Thanks,

Alex

> +	}
> +
> +}
> +
>  int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
>  {
>  	ioasid_t pasid;
> @@ -2221,9 +2270,15 @@ int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
>  		ret = -ENOSPC;
>  		goto out_unlock;
>  	}
> -	vmm->pasid_count++;
>  
> -	ret = pasid;
> +	if (vfio_mm_insert_pasid_node(vmm, pasid)) {
> +		ret = -ENOSPC;
> +		ioasid_free(pasid);
> +	} else {
> +		ret = pasid;
> +		vmm->pasid_count++;
> +	}
> +
>  out_unlock:
>  	mutex_unlock(&vmm->pasid_lock);
>  	return ret;
> @@ -2243,7 +2298,7 @@ int vfio_mm_pasid_free(struct vfio_mm *vmm, ioasid_t pasid)
>  		goto out_unlock;
>  	}
>  	ioasid_free(pasid);
> -
> +	vfio_mm_remove_pasid_node(vmm, pasid);
>  	vmm->pasid_count--;
>  out_unlock:
>  	mutex_unlock(&vmm->pasid_lock);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index b6c9c8c..a2ea7e0 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -89,12 +89,18 @@ extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
>  extern void vfio_unregister_iommu_driver(
>  				const struct vfio_iommu_driver_ops *ops);
>  
> +struct pasid_node {
> +	u32			pasid;
> +	struct list_head	next;
> +};
> +
>  #define VFIO_DEFAULT_PASID_QUOTA	1000
>  struct vfio_mm {
>  	struct kref			kref;
>  	struct mutex			pasid_lock;
>  	int				pasid_quota;
>  	int				pasid_count;
> +	struct list_head		pasid_list;
>  	struct mm_struct		*mm;
>  	struct list_head		vfio_next;
>  };

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
