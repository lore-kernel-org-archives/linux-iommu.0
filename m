Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC6C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 20:55:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2605221EB
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 20:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr/ljTMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2605221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 948FD875F3;
	Fri, 11 Sep 2020 20:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zevUM5AE7EHM; Fri, 11 Sep 2020 20:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BE0A875C1;
	Fri, 11 Sep 2020 20:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D677C0052;
	Fri, 11 Sep 2020 20:55:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E46DC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4369787972
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZY0u97ctO4oA for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 20:55:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE06D878FA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599857698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wtrtuhaA+r7DbdnZ/0j1stVNspmVwJylrPKOFxHIIE=;
 b=Fr/ljTMabK0gJ3XEb8NyXzt4thVZXDuE+kAlDNm9EK1eQDIQ4DpEP9+SWIizSARkFBbmEF
 xqRl+18r1pqk65ZOlRGPi9GubkBPPWWG90mObsDFHsP3+uWSI+Jtp5NEnc90HnL0YBgy2m
 J7XI0ONCbJPmIzvX/ONi/R/Ed1MFDS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-HCk2L0IYNumDRK_x_TY2zw-1; Fri, 11 Sep 2020 16:54:56 -0400
X-MC-Unique: HCk2L0IYNumDRK_x_TY2zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E273107B26E;
 Fri, 11 Sep 2020 20:54:54 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B56445D9F3;
 Fri, 11 Sep 2020 20:54:46 +0000 (UTC)
Date: Fri, 11 Sep 2020 14:54:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 04/16] vfio: Add PASID allocation/free support
Message-ID: <20200911145446.2f9f5eb8@w520.home>
In-Reply-To: <1599734733-6431-5-git-send-email-yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-5-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jasowang@redhat.com, stefanha@gmail.com,
 iommu@lists.linux-foundation.org, yi.y.sun@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

On Thu, 10 Sep 2020 03:45:21 -0700
Liu Yi L <yi.l.liu@intel.com> wrote:

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
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
> v6 -> v7:
> *) remove "#include <linux/eventfd.h>" and add r-b from Eric Auger.
> 
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
>  drivers/vfio/vfio_pasid.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/vfio.h      |  28 ++++++
>  4 files changed, 281 insertions(+)
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
> index 0000000..44ecdd5
> --- /dev/null
> +++ b/drivers/vfio/vfio_pasid.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + *     Author: Liu Yi L <yi.l.liu@intel.com>
> + *
> + */
> +
> +#include <linux/vfio.h>
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

I'm not sure we really need a macro to define this since it's only used
once, but a comment discussing the basis for this default value would be
useful.  Also, since Matthew Rosato is finding it necessary to expose
the available DMA mapping counter to userspace, is this also a
limitation that userspace might be interested in knowing such that we
should plumb it through an IOMMU info capability?

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
> +	struct ioasid_set	*ioasid_set;
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


s/vfio.//


> +static void vfio_mm_release(struct kref *kref)
> +{
> +	struct vfio_mm *vmm = container_of(kref, struct vfio_mm, kref);
> +
> +	list_del(&vmm->next);
> +	mutex_unlock(&vfio_mm_lock);
> +	vfio_remove_all_pasids(vmm);
> +	ioasid_set_put(vmm->ioasid_set);//FIXME: should vfio_pasid get ioasid_set after allocation?


Is the question whether each pasid should hold a reference to the set?
That really seems like a question internal to the ioasid_alloc/free,
but this FIXME needs to be resolved.


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
> +	vmm->ioasid_set = ioasid_alloc_set(mm, pasid_quota, IOASID_SET_TYPE_MM);
> +	if (IS_ERR(vmm->ioasid_set)) {
> +		ret = PTR_ERR(vmm->ioasid_set);
> +		kfree(vmm);
> +		vmm = ERR_PTR(ret);
> +		goto out;

This would be a little less convoluted if we had a separate variable to
store ioasid_set so that we could free vmm without stashing the error
in a temporary variable.  Or at least make the stash more obvious by
defining the stash variable as something like "tmp" within the scope
of this branch.

> +	}
> +
> +	kref_init(&vmm->kref);
> +	vmm->token.val = val;
> +	mutex_init(&vmm->pasid_lock);
> +	vmm->pasid_list = RB_ROOT;
> +
> +	list_add(&vmm->next, &vfio_mm_list);
> +out:
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
> +	ioasid_free(vmm->ioasid_set, vid->pasid);
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

I might have asked before, but why doesn't this return an ioasid_t and
require ioasid_t args?  Our free function below uses an ioasid_t
range, seems rather inconsistent.  We can use a BUILD_BUG_ON if we need
to test that an ioasid_t fits within our uapi.

> +{
> +	ioasid_t pasid;
> +	struct vfio_pasid *vid;
> +
> +	pasid = ioasid_alloc(vmm->ioasid_set, min, max, NULL);
> +	if (pasid == INVALID_IOASID)
> +		return -ENOSPC;
> +
> +	vid = kzalloc(sizeof(*vid), GFP_KERNEL);
> +	if (!vid) {
> +		ioasid_free(vmm->ioasid_set, pasid);
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

!= NULL is not necessary and isn't consistent with the same time of
test in the above rb_first() loop.

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

Do we need to be using try_module_get/module_put to enforce that we
cannot be removed while in use or does that already work correctly via
the function references and this is just paranoia?  If we do exit, I'm
not sure what good it does to keep the remaining list entries.  Thanks,

Alex

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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
