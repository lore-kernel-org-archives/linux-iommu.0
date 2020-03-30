Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D1C2D0E5
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 12:46:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3EF206F6
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 12:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3EF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D66C2876D4;
	Mon, 30 Mar 2020 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVYkXpoxHIFF; Mon, 30 Mar 2020 12:46:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A9DD876EE;
	Mon, 30 Mar 2020 12:46:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0647CC1D7E;
	Mon, 30 Mar 2020 12:46:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 111B9C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EDA4A883C1
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ye1GoXN5RFET for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 12:46:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C544D88415
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:46:32 +0000 (UTC)
IronPort-SDR: OpldfeFu/P/mgAbU0jX1V6bvmUE5a8hS9wLu6p7nEmhDuMIxUftdS8FEcKj1+7RCj6onbJYq1p
 RxJ7C14p/Huw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 05:46:32 -0700
IronPort-SDR: ZmgTllH2rwYKqmQOBfQC+QNwWhRCYpdrhR0M93hh/e7Wb5IKq7PyOyUTbiZrHbNqtwc28kbtbF
 GFHJSvBVmpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; d="scan'208";a="395112191"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga004.jf.intel.com with ESMTP; 30 Mar 2020 05:46:31 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 05:46:31 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 05:46:31 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 20:46:27 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Topic: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Index: AQHWAEUdciXQImmqHUqKh8aSIRgOsKhhEgMg
Date: Mon, 30 Mar 2020 12:46:26 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF98F@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, March 22, 2020 8:32 PM
> 
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> VFIO_TYPE1_NESTING_IOMMU is an IOMMU type which is backed by
> hardware
> IOMMUs that have nesting DMA translation (a.k.a dual stage address
> translation). For such hardware IOMMUs, there are two stages/levels of
> address translation, and software may let userspace/VM to own the first-
> level/stage-1 translation structures. Example of such usage is vSVA (
> virtual Shared Virtual Addressing). VM owns the first-level/stage-1
> translation structures and bind the structures to host, then hardware
> IOMMU would utilize nesting translation when doing DMA translation fo
> the devices behind such hardware IOMMU.
> 
> This patch adds vfio support for binding guest translation (a.k.a stage 1)
> structure to host iommu. And for VFIO_TYPE1_NESTING_IOMMU, not only
> bind
> guest page table is needed, it also requires to expose interface to guest
> for iommu cache invalidation when guest modified the first-level/stage-1
> translation structures since hardware needs to be notified to flush stale
> iotlbs. This would be introduced in next patch.
> 
> In this patch, guest page table bind and unbind are done by using flags
> VFIO_IOMMU_BIND_GUEST_PGTBL and
> VFIO_IOMMU_UNBIND_GUEST_PGTBL under IOCTL
> VFIO_IOMMU_BIND, the bind/unbind data are conveyed by
> struct iommu_gpasid_bind_data. Before binding guest page table to host,
> VM should have got a PASID allocated by host via
> VFIO_IOMMU_PASID_REQUEST.
> 
> Bind guest translation structures (here is guest page table) to host

Bind -> Binding

> are the first step to setup vSVA (Virtual Shared Virtual Addressing).

are -> is. and you already explained vSVA earlier.

> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 158
> ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  46 ++++++++++++
>  2 files changed, 204 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> index 82a9e0b..a877747 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -130,6 +130,33 @@ struct vfio_regions {
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
> 
> +struct domain_capsule {
> +	struct iommu_domain *domain;
> +	void *data;
> +};
> +
> +/* iommu->lock must be held */
> +static int vfio_iommu_for_each_dev(struct vfio_iommu *iommu,
> +		      int (*fn)(struct device *dev, void *data),
> +		      void *data)
> +{
> +	struct domain_capsule dc = {.data = data};
> +	struct vfio_domain *d;
> +	struct vfio_group *g;
> +	int ret = 0;
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		dc.domain = d->domain;
> +		list_for_each_entry(g, &d->group_list, next) {
> +			ret = iommu_group_for_each_dev(g->iommu_group,
> +						       &dc, fn);
> +			if (ret)
> +				break;
> +		}
> +	}
> +	return ret;
> +}
> +
>  static int put_pfn(unsigned long pfn, int prot);
> 
>  /*
> @@ -2314,6 +2341,88 @@ static int
> vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
>  	return 0;
>  }
> 
> +static int vfio_bind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct iommu_gpasid_bind_data *gbind_data =
> +		(struct iommu_gpasid_bind_data *) dc->data;
> +

In Jacob's vSVA iommu series, [PATCH 06/11]:

+		/* REVISIT: upper layer/VFIO can track host process that bind the PASID.
+		 * ioasid_set = mm might be sufficient for vfio to check pasid VMM
+		 * ownership.
+		 */

I asked him who exactly should be responsible for tracking the pasid
ownership. Although no response yet, I expect vfio/iommu can have
a clear policy and also documented here to provide consistent 
message.

> +	return iommu_sva_bind_gpasid(dc->domain, dev, gbind_data);
> +}
> +
> +static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct iommu_gpasid_bind_data *gbind_data =
> +		(struct iommu_gpasid_bind_data *) dc->data;
> +
> +	return iommu_sva_unbind_gpasid(dc->domain, dev,
> +					gbind_data->hpasid);

curious why we have to share the same bind_data structure
between bind and unbind, especially when unbind requires
only one field? I didn't see a clear reason, and just similar
to earlier ALLOC/FREE which don't share structure either.
Current way simply wastes space for unbind operation...

> +}
> +
> +/**
> + * Unbind specific gpasid, caller of this function requires hold
> + * vfio_iommu->lock
> + */
> +static long vfio_iommu_type1_do_guest_unbind(struct vfio_iommu
> *iommu,
> +				struct iommu_gpasid_bind_data *gbind_data)
> +{
> +	return vfio_iommu_for_each_dev(iommu,
> +				vfio_unbind_gpasid_fn, gbind_data);
> +}
> +
> +static long vfio_iommu_type1_bind_gpasid(struct vfio_iommu *iommu,
> +				struct iommu_gpasid_bind_data *gbind_data)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = vfio_iommu_for_each_dev(iommu,
> +			vfio_bind_gpasid_fn, gbind_data);
> +	/*
> +	 * If bind failed, it may not be a total failure. Some devices
> +	 * within the iommu group may have bind successfully. Although
> +	 * we don't enable pasid capability for non-singletion iommu
> +	 * groups, a unbind operation would be helpful to ensure no
> +	 * partial binding for an iommu group.
> +	 */
> +	if (ret)
> +		/*
> +		 * Undo all binds that already succeeded, no need to

binds -> bindings

> +		 * check the return value here since some device within
> +		 * the group has no successful bind when coming to this
> +		 * place switch.
> +		 */

remove 'switch'

> +		vfio_iommu_type1_do_guest_unbind(iommu, gbind_data);
> +
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
> +static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> +				struct iommu_gpasid_bind_data *gbind_data)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = vfio_iommu_type1_do_guest_unbind(iommu, gbind_data);
> +
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2471,6 +2580,55 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
>  		default:
>  			return -EINVAL;
>  		}
> +
> +	} else if (cmd == VFIO_IOMMU_BIND) {

BIND what? VFIO_IOMMU_BIND_PASID sounds clearer to me.

> +		struct vfio_iommu_type1_bind bind;
> +		u32 version;
> +		int data_size;
> +		void *gbind_data;
> +		int ret;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_bind, flags);
> +
> +		if (copy_from_user(&bind, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (bind.argsz < minsz)
> +			return -EINVAL;
> +
> +		/* Get the version of struct iommu_gpasid_bind_data */
> +		if (copy_from_user(&version,
> +			(void __user *) (arg + minsz),
> +					sizeof(version)))
> +			return -EFAULT;
> +
> +		data_size = iommu_uapi_get_data_size(
> +				IOMMU_UAPI_BIND_GPASID, version);
> +		gbind_data = kzalloc(data_size, GFP_KERNEL);
> +		if (!gbind_data)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(gbind_data,
> +			 (void __user *) (arg + minsz), data_size)) {
> +			kfree(gbind_data);
> +			return -EFAULT;
> +		}
> +
> +		switch (bind.flags & VFIO_IOMMU_BIND_MASK) {
> +		case VFIO_IOMMU_BIND_GUEST_PGTBL:
> +			ret = vfio_iommu_type1_bind_gpasid(iommu,
> +							   gbind_data);
> +			break;
> +		case VFIO_IOMMU_UNBIND_GUEST_PGTBL:
> +			ret = vfio_iommu_type1_unbind_gpasid(iommu,
> +							     gbind_data);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		kfree(gbind_data);
> +		return ret;
>  	}
> 
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ebeaf3e..2235bc6 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -14,6 +14,7 @@
> 
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> +#include <linux/iommu.h>
> 
>  #define VFIO_API_VERSION	0
> 
> @@ -853,6 +854,51 @@ struct vfio_iommu_type1_pasid_request {
>   */
>  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE +
> 22)
> 
> +/**
> + * Supported flags:
> + *	- VFIO_IOMMU_BIND_GUEST_PGTBL: bind guest page tables to host
> for
> + *			nesting type IOMMUs. In @data field It takes struct
> + *			iommu_gpasid_bind_data.
> + *	- VFIO_IOMMU_UNBIND_GUEST_PGTBL: undo a bind guest page
> table operation
> + *			invoked by VFIO_IOMMU_BIND_GUEST_PGTBL.
> + *
> + */
> +struct vfio_iommu_type1_bind {
> +	__u32		argsz;
> +	__u32		flags;
> +#define VFIO_IOMMU_BIND_GUEST_PGTBL	(1 << 0)
> +#define VFIO_IOMMU_UNBIND_GUEST_PGTBL	(1 << 1)
> +	__u8		data[];
> +};
> +
> +#define VFIO_IOMMU_BIND_MASK	(VFIO_IOMMU_BIND_GUEST_PGTBL
> | \
> +
> 	VFIO_IOMMU_UNBIND_GUEST_PGTBL)
> +
> +/**
> + * VFIO_IOMMU_BIND - _IOW(VFIO_TYPE, VFIO_BASE + 23,
> + *				struct vfio_iommu_type1_bind)
> + *
> + * Manage address spaces of devices in this container. Initially a TYPE1
> + * container can only have one address space, managed with
> + * VFIO_IOMMU_MAP/UNMAP_DMA.

the last sentence seems irrelevant and more suitable in commit msg.

> + *
> + * An IOMMU of type VFIO_TYPE1_NESTING_IOMMU can be managed by
> both MAP/UNMAP
> + * and BIND ioctls at the same time. MAP/UNMAP acts on the stage-2 (host)
> page
> + * tables, and BIND manages the stage-1 (guest) page tables. Other types of

Are "other types" the counterpart to VFIO_TYPE1_NESTING_IOMMU?
What are those types? I thought only NESTING_IOMMU allows two
stage translation...

> + * IOMMU may allow MAP/UNMAP and BIND to coexist, where

The first sentence said the same thing. Then what is the exact difference?

> MAP/UNMAP controls
> + * the traffics only require single stage translation while BIND controls the
> + * traffics require nesting translation. But this depends on the underlying
> + * IOMMU architecture and isn't guaranteed. Example of this is the guest
> SVA
> + * traffics, such traffics need nesting translation to gain gVA->gPA and then
> + * gPA->hPA translation.

I'm a bit confused about the content since "other types of". Are they
trying to state some exceptions/corner cases that this API cannot
resolve or explain the desired behavior of the API? Especially the
last example, which is worded as if the example for "isn't guaranteed"
but isn't guest SVA the main purpose of this API?

> + *
> + * Availability of this feature depends on the device, its bus, the underlying
> + * IOMMU and the CPU architecture.
> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +#define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 23)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> 
>  /*
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
