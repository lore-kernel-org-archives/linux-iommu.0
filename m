Return-Path: <SRS0=ltgl=33=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7594C2BA83
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 19:38:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A687520726
	for <iommu@archiver.kernel.org>; Fri,  7 Feb 2020 19:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A687520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7309086E71;
	Fri,  7 Feb 2020 19:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDTolCsxp+fM; Fri,  7 Feb 2020 19:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29AFE8673C;
	Fri,  7 Feb 2020 19:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC09C1796;
	Fri,  7 Feb 2020 19:38:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A909C013E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 19:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5FD8587E7B
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 19:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOo+gdBMN-EQ for <iommu@lists.linux-foundation.org>;
 Fri,  7 Feb 2020 19:38:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4DCE585EB4
 for <iommu@lists.linux-foundation.org>; Fri,  7 Feb 2020 19:38:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Feb 2020 11:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; d="scan'208";a="236456658"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 07 Feb 2020 11:38:26 -0800
Date: Fri, 7 Feb 2020 11:43:45 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 2/8] vfio/type1: Make per-application (VM) PASID quota
 tunable
Message-ID: <20200207114345.2071a482@jacob-builder>
In-Reply-To: <1580299912-86084-3-git-send-email-yi.l.liu@intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-3-git-send-email-yi.l.liu@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 jean-philippe.brucker@arm.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org
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
> 
One issue we need to solve is how to share PASIDs at the system
level, e.g. Both VMs and baremetal drivers could use PASIDs.

This patch is granting quota to a guest w/o knowing the remaining
system capacity. So guest PASID allocation could fail even within its
quota.

The solution I am thinking is to enforce quota at IOASID common
code, since IOASID APIs already used to manage system-wide allocation.
How about the following changes to IOASID?
1. introduce quota in ioasid_set (could have a soft limit for better
sharing)

2. introduce an API to create a set with quota before allocation, e.g.
ioasid_set_id = ioasid_alloc_set(size, token)
set_id will be used for ioasid_alloc() instead of token.

3. introduce API to adjust set quota ioasid_adjust_set_size(set_id,
size)

4. API to check remaining PASIDs ioasid_get_capacity(set_id); //return
system capacity if set_id == 0;

5. API to set system capacity, ioasid_set_capacity(nr_pasids), e.g. if
system has 20 bit PASIDs, IOMMU driver needs to call
ioasid_set_capacity(1<<20) during boot.

6. Optional set level APIs. e.g. ioasid_free_set(set_id), frees all
IOASIDs in the set.

With these APIs, this patch could query PASID capacity at both system
and set level and adjust quota within range. i.e.
1. IOMMU vendor driver(or other driver to use PASID w/o IOMMU) sets
system wide capacity during boot.
2. VFIO Call ioasid_alloc_set() when allocating vfio_mm(), set default
quota
3. Adjust quota per set with ioasid_adjust_set_size() as the tunable in
this patch.

Thoughts?

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
>  drivers/vfio/vfio_iommu_type1.c | 33
> +++++++++++++++++++++++++++++++++ include/uapi/linux/vfio.h       |
> 22 ++++++++++++++++++++++ 2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index e836d04..1cf75f5 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2243,6 +2243,27 @@ static int vfio_iommu_type1_pasid_free(struct
> vfio_iommu *iommu, return ret;
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
>  				   unsigned int cmd, unsigned long
> arg) {
> @@ -2389,6 +2410,18 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data, default:
>  			return -EINVAL;
>  		}
> +	} else if (cmd == VFIO_IOMMU_SET_PASID_QUOTA) {
> +		struct vfio_iommu_type1_pasid_quota quota;
> +
> +		minsz = offsetofend(struct
> vfio_iommu_type1_pasid_quota,
> +				    quota);
> +
> +		if (copy_from_user(&quota, (void __user *)arg,
> minsz))
> +			return -EFAULT;
> +
> +		if (quota.argsz < minsz)
> +			return -EINVAL;
> +		return vfio_iommu_type1_set_pasid_quota(iommu,
> quota.quota); }
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 298ac80..d4bf415 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -835,6 +835,28 @@ struct vfio_iommu_type1_pasid_request {
>   */
>  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE +
> 22) 
> +/**
> + * @quota: the new pasid quota which a userspace application (e.g.
> VM)
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
> + *				struct
> vfio_iommu_type1_pasid_quota)
> + *
> + * Availability of this feature depends on PASID support in the
> device,
> + * its bus, the underlying IOMMU and the CPU architecture. In VFIO,
> it
> + * is available after VFIO_SET_IOMMU.
> + *
> + * returns: latest quota on success, -errno on failure.
> + */
> +#define VFIO_IOMMU_SET_PASID_QUOTA	_IO(VFIO_TYPE, VFIO_BASE +
> 23) +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU
> -------- */ 
>  /*

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
