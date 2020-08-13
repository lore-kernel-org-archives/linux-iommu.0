Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF151C433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B420791
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNxt9EDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B420791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5407C886A0;
	Thu, 13 Aug 2020 15:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GZO75n-jqnUS; Thu, 13 Aug 2020 15:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 64B8A88698;
	Thu, 13 Aug 2020 15:07:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41CDBC013C;
	Thu, 13 Aug 2020 15:07:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD61C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC9AF8869C
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D81jjA82MM7N for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 15:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 90B8988698
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597331242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPwFbRncPFmh8nq5xgCiG+oj3R4ni3pZQolykm6RrZs=;
 b=XNxt9EDPEPLtnAnEkvTfwZIkmORwh+VhDpAZIiFgS+29px3j+cKyOXg+JKkphOsiAZzs2M
 /PP61Do/eLn6VExRmFhj1cnUGkF8VuMesbAB1yY6RR4h6Jlp2VzPjFiIw3lO9u5gCkA4Vm
 gIfDzOkjKw78lM7kkJq7DiePTbq3KLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-tbFqeL__PTmS8vdEaApjCQ-1; Thu, 13 Aug 2020 11:07:19 -0400
X-MC-Unique: tbFqeL__PTmS8vdEaApjCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC4D1019624;
 Thu, 13 Aug 2020 15:07:17 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DAC95D990;
 Thu, 13 Aug 2020 15:07:07 +0000 (UTC)
Subject: Re: [PATCH v6 05/15] vfio: Add PASID allocation/free support
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-6-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <16e0aeac-d767-bca7-bf02-cb5eff5a92b7@redhat.com>
Date: Thu, 13 Aug 2020 17:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1595917664-33276-6-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Yi,

On 7/28/20 8:27 AM, Liu Yi L wrote:
> Shared Virtual Addressing (a.k.a Shared Virtual Memory) allows sharing
> multiple process virtual address spaces with the device for simplified
> programming model. PASID is used to tag an virtual address space in DMA
> requests and to identify the related translation structure in IOMMU. When
> a PASID-capable device is assigned to a VM, we want the same capability
> of using PASID to tag guest process virtual address spaces to achieve
> virtual SVA (vSVA).
> 
> PASID management for guest is vendor specific. Some vendors (e.g. Intel
> VT-d) requires system-wide managed PASIDs across all devices, regardless
> of whether a device is used by host or assigned to guest. Other vendors
> (e.g. ARM SMMU) may allow PASIDs managed per-device thus could be fully
> delegated to the guest for assigned devices.
> 
> For system-wide managed PASIDs, this patch introduces a vfio module to
> handle explicit PASID alloc/free requests from guest. Allocated PASIDs
> are associated to a process (or, mm_struct) in IOASID core. A vfio_mm
> object is introduced to track mm_struct. Multiple VFIO containers within
> a process share the same vfio_mm object.
> 
> A quota mechanism is provided to prevent malicious user from exhausting
> available PASIDs. Currently the quota is a global parameter applied to
> all VFIO devices. In the future per-device quota might be supported too.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v5 -> v6:
> *) address comments from Eric. Add vfio_unlink_pasid() to be consistent
>    with vfio_unlink_dma(). Add a comment in vfio_pasid_exit().
> 
> v4 -> v5:
> *) address comments from Eric Auger.
> *) address the comments from Alex on the pasid free range support. Added
>    per vfio_mm pasid r-b tree.
>    https://lore.kernel.org/kvm/20200709082751.320742ab@x1.home/
> 
> v3 -> v4:
> *) fix lock leam in vfio_mm_get_from_task()
> *) drop pasid_quota field in struct vfio_mm
> *) vfio_mm_get_from_task() returns ERR_PTR(-ENOTTY) when !CONFIG_VFIO_PASID
> 
> v1 -> v2:
> *) added in v2, split from the pasid alloc/free support of v1
> ---
>  drivers/vfio/Kconfig      |   5 +
>  drivers/vfio/Makefile     |   1 +
>  drivers/vfio/vfio_pasid.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/vfio.h      |  28 ++++++
>  4 files changed, 282 insertions(+)
>  create mode 100644 drivers/vfio/vfio_pasid.c
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index fd17db9..3d8a108 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -19,6 +19,11 @@ config VFIO_VIRQFD
>  	depends on VFIO && EVENTFD
>  	default n
>  
> +config VFIO_PASID
> +	tristate
> +	depends on IOASID && VFIO
> +	default n
> +
>  menuconfig VFIO
>  	tristate "VFIO Non-Privileged userspace driver framework"
>  	depends on IOMMU_API
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index de67c47..bb836a3 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -3,6 +3,7 @@ vfio_virqfd-y := virqfd.o
>  
>  obj-$(CONFIG_VFIO) += vfio.o
>  obj-$(CONFIG_VFIO_VIRQFD) += vfio_virqfd.o
> +obj-$(CONFIG_VFIO_PASID) += vfio_pasid.o
>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
> diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> new file mode 100644
> index 0000000..befcf29
> --- /dev/null
> +++ b/drivers/vfio/vfio_pasid.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + *     Author: Liu Yi L <yi.l.liu@intel.com>
> + *
> + */
> +
> +#include <linux/vfio.h>
> +#include <linux/eventfd.h>
not needed
> +#include <linux/file.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/sched/mm.h>
> +
> +#define DRIVER_VERSION  "0.1"
> +#define DRIVER_AUTHOR   "Liu Yi L <yi.l.liu@intel.com>"
> +#define DRIVER_DESC     "PASID management for VFIO bus drivers"
> +
> +#define VFIO_DEFAULT_PASID_QUOTA	1000
> +static int pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
> +module_param_named(pasid_quota, pasid_quota, uint, 0444);
> +MODULE_PARM_DESC(pasid_quota,
> +		 "Set the quota for max number of PASIDs that an application is allowed to request (default 1000)");
> +
> +struct vfio_mm_token {
> +	unsigned long long val;
> +};
> +
> +struct vfio_mm {
> +	struct kref		kref;
> +	int			ioasid_sid;
> +	struct mutex		pasid_lock;
> +	struct rb_root		pasid_list;
> +	struct list_head	next;
> +	struct vfio_mm_token	token;
> +};
> +
> +static struct mutex		vfio_mm_lock;
> +static struct list_head		vfio_mm_list;
> +
> +struct vfio_pasid {
> +	struct rb_node		node;
> +	ioasid_t		pasid;
> +};
> +
> +static void vfio_remove_all_pasids(struct vfio_mm *vmm);
> +
> +/* called with vfio.vfio_mm_lock held */
> +static void vfio_mm_release(struct kref *kref)
> +{
> +	struct vfio_mm *vmm = container_of(kref, struct vfio_mm, kref);
> +
> +	list_del(&vmm->next);
> +	mutex_unlock(&vfio_mm_lock);
> +	vfio_remove_all_pasids(vmm);
> +	ioasid_free_set(vmm->ioasid_sid, true);
> +	kfree(vmm);
> +}
> +
> +void vfio_mm_put(struct vfio_mm *vmm)
> +{
> +	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock);
> +}
> +
> +static void vfio_mm_get(struct vfio_mm *vmm)
> +{
> +	kref_get(&vmm->kref);
> +}
> +
> +struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
> +{
> +	struct mm_struct *mm = get_task_mm(task);
> +	struct vfio_mm *vmm;
> +	unsigned long long val = (unsigned long long)mm;
> +	int ret;
> +
> +	mutex_lock(&vfio_mm_lock);
> +	/* Search existing vfio_mm with current mm pointer */
> +	list_for_each_entry(vmm, &vfio_mm_list, next) {
> +		if (vmm->token.val == val) {
> +			vfio_mm_get(vmm);
> +			goto out;
> +		}
> +	}
> +
> +	vmm = kzalloc(sizeof(*vmm), GFP_KERNEL);
> +	if (!vmm) {
> +		vmm = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	/*
> +	 * IOASID core provides a 'IOASID set' concept to track all
> +	 * PASIDs associated with a token. Here we use mm_struct as
> +	 * the token and create a IOASID set per mm_struct. All the
> +	 * containers of the process share the same IOASID set.
> +	 */
> +	ret = ioasid_alloc_set((struct ioasid_set *)mm, pasid_quota,
> +			       &vmm->ioasid_sid);
> +	if (ret) {
> +		kfree(vmm);
> +		vmm = ERR_PTR(ret);
> +		goto out;
> +	}
> +
> +	kref_init(&vmm->kref);
> +	vmm->token.val = val;
> +	mutex_init(&vmm->pasid_lock);
> +	vmm->pasid_list = RB_ROOT;
> +
> +	list_add(&vmm->next, &vfio_mm_list);> +out:
> +	mutex_unlock(&vfio_mm_lock);
> +	mmput(mm);
> +	return vmm;
> +}
> +
> +/*
> + * Find PASID within @min and @max
> + */
> +static struct vfio_pasid *vfio_find_pasid(struct vfio_mm *vmm,
> +					  ioasid_t min, ioasid_t max)
> +{
> +	struct rb_node *node = vmm->pasid_list.rb_node;
> +
> +	while (node) {
> +		struct vfio_pasid *vid = rb_entry(node,
> +						struct vfio_pasid, node);
> +
> +		if (max < vid->pasid)
> +			node = node->rb_left;
> +		else if (min > vid->pasid)
> +			node = node->rb_right;
> +		else
> +			return vid;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void vfio_link_pasid(struct vfio_mm *vmm, struct vfio_pasid *new)
> +{
> +	struct rb_node **link = &vmm->pasid_list.rb_node, *parent = NULL;
> +	struct vfio_pasid *vid;
> +
> +	while (*link) {
> +		parent = *link;
> +		vid = rb_entry(parent, struct vfio_pasid, node);
> +
> +		if (new->pasid <= vid->pasid)
> +			link = &(*link)->rb_left;
> +		else
> +			link = &(*link)->rb_right;
> +	}
> +
> +	rb_link_node(&new->node, parent, link);
> +	rb_insert_color(&new->node, &vmm->pasid_list);
> +}
> +
> +static void vfio_unlink_pasid(struct vfio_mm *vmm, struct vfio_pasid *old)
> +{
> +	rb_erase(&old->node, &vmm->pasid_list);
> +}
> +
> +static void vfio_remove_pasid(struct vfio_mm *vmm, struct vfio_pasid *vid)
> +{
> +	vfio_unlink_pasid(vmm, vid);
> +	ioasid_free(vid->pasid);
> +	kfree(vid);
> +}
> +
> +static void vfio_remove_all_pasids(struct vfio_mm *vmm)
> +{
> +	struct rb_node *node;
> +
> +	mutex_lock(&vmm->pasid_lock);
> +	while ((node = rb_first(&vmm->pasid_list)))
> +		vfio_remove_pasid(vmm, rb_entry(node, struct vfio_pasid, node));
> +	mutex_unlock(&vmm->pasid_lock);
> +}
> +
> +int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> +{
> +	ioasid_t pasid;
> +	struct vfio_pasid *vid;
> +
> +	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
> +	if (pasid == INVALID_IOASID)
> +		return -ENOSPC;
> +
> +	vid = kzalloc(sizeof(*vid), GFP_KERNEL);
> +	if (!vid) {
> +		ioasid_free(pasid);
> +		return -ENOMEM;
> +	}
> +
> +	vid->pasid = pasid;
> +
> +	mutex_lock(&vmm->pasid_lock);
> +	vfio_link_pasid(vmm, vid);
> +	mutex_unlock(&vmm->pasid_lock);
> +
> +	return pasid;
> +}
> +
> +void vfio_pasid_free_range(struct vfio_mm *vmm,
> +			   ioasid_t min, ioasid_t max)
> +{
> +	struct vfio_pasid *vid = NULL;
> +
> +	/*
> +	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> +	 * teardown necessary structures depending on the to-be-freed
> +	 * PASID.
> +	 */
> +	mutex_lock(&vmm->pasid_lock);
> +	while ((vid = vfio_find_pasid(vmm, min, max)) != NULL)
> +		vfio_remove_pasid(vmm, vid);
> +	mutex_unlock(&vmm->pasid_lock);
> +}
> +
> +static int __init vfio_pasid_init(void)
> +{
> +	mutex_init(&vfio_mm_lock);
> +	INIT_LIST_HEAD(&vfio_mm_list);
> +	return 0;
> +}
> +
> +static void __exit vfio_pasid_exit(void)
> +{
> +	/*
> +	 * VFIO_PASID is supposed to be referenced by VFIO_IOMMU_TYPE1
> +	 * and may be other module. once vfio_pasid_exit() is triggered,
> +	 * that means its user (e.g. VFIO_IOMMU_TYPE1) has been removed.
> +	 * All the vfio_mm instances should have been released. If not,
> +	 * means there is vfio_mm leak, should be a bug of user module.
> +	 * So just warn here.
> +	 */
> +	WARN_ON(!list_empty(&vfio_mm_list));
> +}
> +
> +module_init(vfio_pasid_init);
> +module_exit(vfio_pasid_exit);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 38d3c6a..31472a9 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -97,6 +97,34 @@ extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
>  extern void vfio_unregister_iommu_driver(
>  				const struct vfio_iommu_driver_ops *ops);
>  
> +struct vfio_mm;
> +#if IS_ENABLED(CONFIG_VFIO_PASID)
> +extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> +extern void vfio_mm_put(struct vfio_mm *vmm);
> +extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> +extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> +				  ioasid_t min, ioasid_t max);
> +#else
> +static inline struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
> +{
> +	return ERR_PTR(-ENOTTY);
> +}
> +
> +static inline void vfio_mm_put(struct vfio_mm *vmm)
> +{
> +}
> +
> +static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> +{
> +	return -ENOTTY;
> +}
> +
> +static inline void vfio_pasid_free_range(struct vfio_mm *vmm,
> +					  ioasid_t min, ioasid_t max)
> +{
> +}
> +#endif /* CONFIG_VFIO_PASID */
> +
>  /*
>   * External user API
>   */
> 
Besides looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
