Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F228C31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 12:38:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B83121473
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 12:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B83121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0A342E97;
	Fri, 14 Jun 2019 12:38:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 781F9EA7
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 12:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E7346822
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 12:38:50 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Jun 2019 05:38:50 -0700
X-ExtLoop1: 1
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
	by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2019 05:38:50 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
	fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 14 Jun 2019 05:38:50 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
	FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 14 Jun 2019 05:38:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.185]) by
	SHSMSX103.ccr.corp.intel.com ([169.254.4.83]) with mapi id
	14.03.0439.000; Fri, 14 Jun 2019 20:38:48 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
	<eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jean-philippe.brucker@arm.com"
	<jean-philippe.brucker@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH v8 23/29] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v8 23/29] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHVE93Q8d5+5ci7G0aw2gcwp36iKaabMJKQ
Date: Fri, 14 Jun 2019 12:38:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439EFB432@SHSMSX104.ccr.corp.intel.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
	<20190526161004.25232-24-eric.auger@redhat.com>
In-Reply-To: <20190526161004.25232-24-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODVjM2QxZTItNzI3Yi00MjQwLTk3MTgtZTViZDk1OWViYmY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblRpVHE0eTBjczlYM2VKQnVFWFwvNENsdlZzR05BeUFMbkRnUVJmWDhRUXJEeWY0bmZCc2I0S3pnZ3dBRGdhNTQifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Tian,
	Kevin" <kevin.tian@intel.com>,
	"vincent.stehle@arm.com" <vincent.stehle@arm.com>, "Raj,
	Ashok" <ashok.raj@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Eric,

> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: Monday, May 27, 2019 12:10 AM
> Subject: [PATCH v8 23/29] vfio: VFIO_IOMMU_CACHE_INVALIDATE
> 
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> When the guest "owns" the stage 1 translation structures,  the host IOMMU driver
> has no knowledge of caching structure updates unless the guest invalidation
> requests are trapped and passed down to the host.
> 
> This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims at
> propagating guest stage1 IOMMU cache invalidations to the host.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v6 -> v7:
> - Use iommu_capsule struct
> - renamed vfio_iommu_for_each_dev into vfio_iommu_lookup_dev
>   due to checkpatch error related to for_each_dev suffix
> 
> v2 -> v3:
> - introduce vfio_iommu_for_each_dev back in this patch
> 
> v1 -> v2:
> - s/TLB/CACHE
> - remove vfio_iommu_task usage
> - commit message rewording
> ---
>  drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 13 ++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index b2d609d6fe83..6fda4fbc9bfa 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -120,6 +120,34 @@ struct vfio_regions {
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
> 
> +struct domain_capsule {
> +	struct iommu_domain *domain;
> +	void *data;
> +};
> +
> +/* iommu->lock must be held */
> +static int
> +vfio_iommu_lookup_dev(struct vfio_iommu *iommu,
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
> @@ -1795,6 +1823,15 @@ vfio_attach_pasid_table(struct vfio_iommu *iommu,
>  	return ret;
>  }
> 
> +static int vfio_cache_inv_fn(struct device *dev, void *data) {
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct vfio_iommu_type1_cache_invalidate *ustruct =
> +		(struct vfio_iommu_type1_cache_invalidate *)dc->data;
> +
> +	return iommu_cache_invalidate(dc->domain, dev, &ustruct->info); }
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)  { @@ -
> 1881,6 +1918,24 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  	} else if (cmd == VFIO_IOMMU_DETACH_PASID_TABLE) {
>  		vfio_detach_pasid_table(iommu);
>  		return 0;
> +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> +		struct vfio_iommu_type1_cache_invalidate ustruct;
> +		int ret;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate,
> +				    info);
> +
> +		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (ustruct.argsz < minsz || ustruct.flags)

May remove the flags field?

> +			return -EINVAL;
> +
> +		mutex_lock(&iommu->lock);
> +		ret = vfio_iommu_lookup_dev(iommu, vfio_cache_inv_fn,
> +					    &ustruct);
> +		mutex_unlock(&iommu->lock);
> +		return ret;
>  	}
> 
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
> 4316dd8cb5b5..055aa9b9745a 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -785,6 +785,19 @@ struct vfio_iommu_type1_attach_pasid_table {
>   */
>  #define VFIO_IOMMU_DETACH_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 23)
> 
> +/**
> + * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 24,
> + *			struct vfio_iommu_type1_cache_invalidate)
> + *
> + * Propagate guest IOMMU cache invalidation to the host.
> + */
> +struct vfio_iommu_type1_cache_invalidate {
> +	__u32   argsz;
> +	__u32   flags;

Looks like there is no more usage on "flags". is it?

Regards,
Yi Liu

> +	struct iommu_cache_invalidate_info info; };
> +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> 
>  /*
> --
> 2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
