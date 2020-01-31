Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB86C33CB2
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 12:41:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B61920707
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 12:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B61920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2619D20407;
	Fri, 31 Jan 2020 12:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8eBguVvRdl8; Fri, 31 Jan 2020 12:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3102C203D8;
	Fri, 31 Jan 2020 12:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B8AC0176;
	Fri, 31 Jan 2020 12:41:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C700C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E995386813
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apP7Hzwh_k7G for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 12:41:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B6F368679B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 12:41:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 04:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="309994884"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga001.jf.intel.com with ESMTP; 31 Jan 2020 04:41:09 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 04:41:09 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 04:41:08 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.141]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 20:41:06 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHV1pyWdXmNxNYiSUCDLwZiDlOrAKgBy+IAgALeXlA=
Date: Fri, 31 Jan 2020 12:41:06 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1993E8@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-2-git-send-email-yi.l.liu@intel.com>
 <20200129165540.335774d5@w520.home>
In-Reply-To: <20200129165540.335774d5@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODk5Y2JlYjEtZjRjMi00ZTI3LWJjNTYtY2NlZmMyZWZhYjBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaVZFb3VjY1ZoWEVKd3JcL1F1dEhIamZ3NDE2RzdISUZRdlZ2UzBlbzIzVmpqcDVxa3FSWDE5c3VDRFYxNkRrTVEifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>
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

Hi Alex,

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, January 30, 2020 7:56 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
> 
> On Wed, 29 Jan 2020 04:11:45 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > For a long time, devices have only one DMA address space from platform
> > IOMMU's point of view. This is true for both bare metal and directed-
> > access in virtualization environment. Reason is the source ID of DMA
> > in PCIe are BDF (bus/dev/fnc ID), which results in only device
> > granularity DMA isolation. However, this is changing with the latest
> > advancement of I/O technology. More and more platform vendors are
> > utilizing the PCIe PASID TLP prefix in DMA requests, thus to give
> > devices with multiple DMA address spaces as identified by their
> > individual PASIDs. For example, Shared Virtual Addressing (SVA, a.k.a
> > Shared Virtual Memory) is able to let device access multiple process
> > virtual address space by binding the virtual address space with a
> > PASID. Wherein the PASID is allocated in software and programmed to
> > device per device specific manner. Devices which support PASID
> > capability are called PASID-capable devices. If such devices are
> > passed through to VMs, guest software are also able to bind guest
> > process virtual address space on such devices. Therefore, the guest
> > software could reuse the bare metal software programming model, which
> > means guest software will also allocate PASID and program it to device
> > directly. This is a dangerous situation since it has potential PASID
> > conflicts and unauthorized address space access. It would be safer to
> > let host intercept in the guest software's PASID allocation. Thus PASID are
> managed system-wide.

[...]

> > +static void vfio_mm_unlock_and_free(struct vfio_mm *vmm) {
> > +	mutex_unlock(&vfio.vfio_mm_lock);
> > +	kfree(vmm);
> > +}
> > +
> > +/* called with vfio.vfio_mm_lock held */ static void
> > +vfio_mm_release(struct kref *kref) {
> > +	struct vfio_mm *vmm = container_of(kref, struct vfio_mm, kref);
> > +
> > +	list_del(&vmm->vfio_next);
> > +	vfio_mm_unlock_and_free(vmm);
> > +}
> > +
> > +void vfio_mm_put(struct vfio_mm *vmm) {
> > +	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio.vfio_mm_lock); }
> > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> > +
> > +/* Assume vfio_mm_lock or vfio_mm reference is held */ static void
> > +vfio_mm_get(struct vfio_mm *vmm) {
> > +	kref_get(&vmm->kref);
> > +}
> > +
> > +struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task) {
> > +	struct mm_struct *mm = get_task_mm(task);
> > +	struct vfio_mm *vmm;
> > +
> > +	mutex_lock(&vfio.vfio_mm_lock);
> > +	list_for_each_entry(vmm, &vfio.vfio_mm_list, vfio_next) {
> > +		if (vmm->mm == mm) {
> > +			vfio_mm_get(vmm);
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	vmm = vfio_create_mm(mm);
> > +	if (IS_ERR(vmm))
> > +		vmm = NULL;
> > +out:
> > +	mutex_unlock(&vfio.vfio_mm_lock);
> > +	mmput(mm);
> > +	return vmm;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > +
> > +int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max) {
> > +	ioasid_t pasid;
> > +	int ret = -ENOSPC;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	if (vmm->pasid_count >= vmm->pasid_quota) {
> > +		ret = -ENOSPC;
> > +		goto out_unlock;
> > +	}
> > +	/* Track ioasid allocation owner by mm */
> > +	pasid = ioasid_alloc((struct ioasid_set *)vmm->mm, min,
> > +				max, NULL);
> 
> Is mm effectively only a token for this?  Maybe we should have a struct
> vfio_mm_token since gets and puts are not creating a reference to an mm,
> but to an "mm token".

yes, it is supposed to be a kind of token. vfio_mm_token is better naming. :-)

> > +	if (pasid == INVALID_IOASID) {
> > +		ret = -ENOSPC;
> > +		goto out_unlock;
> > +	}
> > +	vmm->pasid_count++;
> > +
> > +	ret = pasid;
> > +out_unlock:
> > +	mutex_unlock(&vmm->pasid_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_alloc);
> > +
> > +int vfio_mm_pasid_free(struct vfio_mm *vmm, ioasid_t pasid) {
> > +	void *pdata;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	pdata = ioasid_find((struct ioasid_set *)vmm->mm,
> > +				pasid, NULL);
> > +	if (IS_ERR(pdata)) {
> > +		ret = PTR_ERR(pdata);
> > +		goto out_unlock;
> > +	}
> > +	ioasid_free(pasid);
> > +
> > +	vmm->pasid_count--;
> > +out_unlock:
> > +	mutex_unlock(&vmm->pasid_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_free);
> > +
> > +/**
> >   * Module/class support
> >   */
> >  static char *vfio_devnode(struct device *dev, umode_t *mode) @@
> > -2151,8 +2274,10 @@ static int __init vfio_init(void)
> >  	idr_init(&vfio.group_idr);
> >  	mutex_init(&vfio.group_lock);
> >  	mutex_init(&vfio.iommu_drivers_lock);
> > +	mutex_init(&vfio.vfio_mm_lock);
> >  	INIT_LIST_HEAD(&vfio.group_list);
> >  	INIT_LIST_HEAD(&vfio.iommu_drivers_list);
> > +	INIT_LIST_HEAD(&vfio.vfio_mm_list);
> >  	init_waitqueue_head(&vfio.release_q);
> >
> >  	ret = misc_register(&vfio_dev);
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 2ada8e6..e836d04 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -70,6 +70,7 @@ struct vfio_iommu {
> >  	unsigned int		dma_avail;
> >  	bool			v2;
> >  	bool			nesting;
> > +	struct vfio_mm		*vmm;
> >  };
> >
> >  struct vfio_domain {
> > @@ -2039,6 +2040,7 @@ static void vfio_iommu_type1_detach_group(void
> > *iommu_data,  static void *vfio_iommu_type1_open(unsigned long arg)  {
> >  	struct vfio_iommu *iommu;
> > +	struct vfio_mm *vmm = NULL;
> >
> >  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> >  	if (!iommu)
> > @@ -2064,6 +2066,10 @@ static void *vfio_iommu_type1_open(unsigned long
> arg)
> >  	iommu->dma_avail = dma_entry_limit;
> >  	mutex_init(&iommu->lock);
> >  	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
> > +	vmm = vfio_mm_get_from_task(current);
> 
> So the token (if I'm right about the usage above) is the mm of the process
> that calls VFIO_SET_IOMMU on the container.

yes.

> 
> > +	if (!vmm)
> > +		pr_err("Failed to get vfio_mm track\n");
> > +	iommu->vmm = vmm;
> >
> >  	return iommu;
> >  }
> > @@ -2105,6 +2111,8 @@ static void vfio_iommu_type1_release(void
> *iommu_data)
> >  	}
> >
> >  	vfio_iommu_iova_free(&iommu->iova_list);
> > +	if (iommu->vmm)
> > +		vfio_mm_put(iommu->vmm);
> >
> >  	kfree(iommu);
> >  }
> > @@ -2193,6 +2201,48 @@ static int vfio_iommu_iova_build_caps(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
> > +					 int min,
> > +					 int max)
> > +{
> > +	struct vfio_mm *vmm = iommu->vmm;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +	if (vmm)
> > +		ret = vfio_mm_pasid_alloc(vmm, min, max);
> > +	else
> > +		ret = -ENOSPC;
> 
> vfio_mm_pasid_alloc() can return -ENOSPC though, so it'd be nice to
> differentiate the errors.  We could use EFAULT for the no IOMMU case
> and EINVAL here?

yes, I can do it in new version.

> > +out_unlock:
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> > +				       unsigned int pasid)
> > +{
> > +	struct vfio_mm *vmm = iommu->vmm;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> 
> But we could have been IOMMU backed when the pasid was allocated, did we just
> leak something?  In fact, I didn't spot anything in this series that handles
> a container with pasids allocated losing iommu backing.
> I'd think we want to release all pasids when that happens since permission for
> the user to hold pasids goes along with having an iommu backed device.

oh, yes. If a container lose iommu backend, then needs to reclaim the allocated
PASIDs. right? I'll add it. :-)

> Also, do we want _free() paths that can fail?

I remember we discussed if a _free() path can fail, I think we agreed to let
_free() path always success. :-)

> 
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (vmm)
> > +		ret = vfio_mm_pasid_free(vmm, pasid);
> > +	else
> > +		ret = -ENOSPC;
> > +out_unlock:
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2297,6 +2347,48 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >
> >  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> > +
> > +	} else if (cmd == VFIO_IOMMU_PASID_REQUEST) {
> > +		struct vfio_iommu_type1_pasid_request req;
> > +		u32 min, max, pasid;
> > +		int ret, result;
> > +		unsigned long offset;
> > +
> > +		offset = offsetof(struct vfio_iommu_type1_pasid_request,
> > +				  alloc_pasid.result);
> > +		minsz = offsetofend(struct vfio_iommu_type1_pasid_request,
> > +				    flags);
> > +
> > +		if (copy_from_user(&req, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		if (req.argsz < minsz)
> > +			return -EINVAL;
> 
> req.flags needs to be sanitized, if a user provides flags we don't understand or
> combinations of flags that aren't supported, we should return an error (ex. ALLOC |
> FREE should not do alloc w/o free or free w/o alloc, it should just error).

Oops, yes. I'll add it.

> 
> > +
> > +		switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > +		case VFIO_IOMMU_PASID_ALLOC:
> > +			if (copy_from_user(&min,
> > +				(void __user *)arg + minsz, sizeof(min)))
> > +				return -EFAULT;
> > +			if (copy_from_user(&max,
> > +				(void __user *)arg + minsz + sizeof(min),
> > +				sizeof(max)))
> > +				return -EFAULT;
> 
> Why not just copy the fields into req in one go?

yeah. let me do it. :-)

> 
> > +			ret = 0;
> > +			result = vfio_iommu_type1_pasid_alloc(iommu, min, max);
> > +			if (result > 0)
> > +				ret = copy_to_user(
> > +					      (void __user *) (arg + offset),
> > +					      &result, sizeof(result));
> 
> The result is an int, ioctl(2) returns an int... why do we need
> to return the result in the structure?

In former version, it was. :-) I changed it due to the consideration of
potential extension of PCIe PASID bits. Currently, PASID is 20 bits width
per spec. If returning "int" to userspace, I'm afraid it will be limitation
in future when PASID is extended to be 32 bits. Maybe I should make all the
fields be 64 bits.

> 
> > +			return ret;
> > +		case VFIO_IOMMU_PASID_FREE:
> > +			if (copy_from_user(&pasid,
> > +				(void __user *)arg + minsz, sizeof(pasid)))
> > +				return -EFAULT;
> 
> Same here, we don't need a separate pasid variable, use the one in req.

got it. :-) Just copy the req and use the @free_pasid field in req is
enough.

> 
> > +			return vfio_iommu_type1_pasid_free(iommu, pasid);
> > +		default:
> > +			return -EINVAL;
> > +		}
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h index
> > e42a711..b6c9c8c 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -89,6 +89,21 @@ extern int vfio_register_iommu_driver(const struct
> > vfio_iommu_driver_ops *ops);  extern void vfio_unregister_iommu_driver(
> >  				const struct vfio_iommu_driver_ops *ops);
> >
> > +#define VFIO_DEFAULT_PASID_QUOTA	1000
> > +struct vfio_mm {
> > +	struct kref			kref;
> > +	struct mutex			pasid_lock;
> > +	int				pasid_quota;
> > +	int				pasid_count;
> > +	struct mm_struct		*mm;
> > +	struct list_head		vfio_next;
> > +};
> > +
> > +extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct
> > +*task); extern void vfio_mm_put(struct vfio_mm *vmm); extern int
> > +vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max); extern
> > +int vfio_mm_pasid_free(struct vfio_mm *vmm, ioasid_t pasid);
> > +
> >  /*
> >   * External user API
> >   */
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 9e843a1..298ac80 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -794,6 +794,47 @@ struct vfio_iommu_type1_dma_unmap {
> >  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
> >  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
> >
> > +/*
> > + * PASID (Process Address Space ID) is a PCIe concept which
> > + * has been extended to support DMA isolation in fine-grain.
> > + * With device assigned to user space (e.g. VMs), PASID alloc
> > + * and free need to be system wide. This structure defines
> > + * the info for pasid alloc/free between user space and kernel
> > + * space.
> > + *
> > + * @flag=VFIO_IOMMU_PASID_ALLOC, refer to the @alloc_pasid
> > + * @flag=VFIO_IOMMU_PASID_FREE, refer to @free_pasid  */ struct
> > +vfio_iommu_type1_pasid_request {
> > +	__u32	argsz;
> > +#define VFIO_IOMMU_PASID_ALLOC	(1 << 0)
> > +#define VFIO_IOMMU_PASID_FREE	(1 << 1)
> > +	__u32	flags;
> > +	union {
> > +		struct {
> > +			__u32 min;
> > +			__u32 max;
> > +			__u32 result;
> > +		} alloc_pasid;
> > +		__u32 free_pasid;
> > +	};
> > +};
> > +
> > +#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_PASID_ALLOC | \
> > +					 VFIO_IOMMU_PASID_FREE)
> > +
> > +/**
> > + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> > + *				struct vfio_iommu_type1_pasid_request)
> > + *
> > + * Availability of this feature depends on PASID support in the
> > +device,
> > + * its bus, the underlying IOMMU and the CPU architecture. In VFIO,
> > +it
> > + * is available after VFIO_SET_IOMMU.
> 
> Assuming the IOMMU backend supports it.  How does a user determine that?
> Allocating a PASID just to see if they can doesn't seem like a good
> approach. We have a VFIO_IOMMU_GET_INFO ioctl.  Thanks,

Do you mean checking PASID allocation availability via VFIO_IOMMU_GET_INFO?
If yes, I can do it. :-)

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
