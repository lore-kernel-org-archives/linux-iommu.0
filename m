Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FBCC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 09:34:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5302074F
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq0Nl5Xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5302074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B758862AB;
	Mon,  6 Jul 2020 09:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIUJoV2xSFKz; Mon,  6 Jul 2020 09:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5B398204B;
	Mon,  6 Jul 2020 09:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30CCC0893;
	Mon,  6 Jul 2020 09:34:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 168CBC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 09:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F32602036E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 09:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GP2zfn0LSKst for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 09:34:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 3B5C220029
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594028078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXJx1qpbfVbAj/VWczfs0WOvGfiINR1HbPqQDklC3XA=;
 b=cq0Nl5XsUIOwxCOCmSb+JDV9C7j8R2tpEPX0WECC1WUMyK/0HV/0t9fUCT7m0JL/mWl6cV
 sQIRHStYHLuh73TUJrQ2l3OR5ycHWS/OEqdeYhD62IPneBnh2R3BNr/RiFnkiwZFyxgeiX
 u+znDMBk718BzHP3IBEewxSQ7h1cUGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Zdh8rqKPNx-qOLPflH5qHg-1; Mon, 06 Jul 2020 05:34:35 -0400
X-MC-Unique: Zdh8rqKPNx-qOLPflH5qHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69532107ACF3;
 Mon,  6 Jul 2020 09:34:33 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 766BF5D9D7;
 Mon,  6 Jul 2020 09:34:24 +0000 (UTC)
Subject: Re: [PATCH v4 02/15] iommu: Report domain nesting info
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b9479f61-7f9e-e0ae-5125-ab15f59b1ece@redhat.com>
Date: Mon, 6 Jul 2020 11:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
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



On 7/4/20 1:26 PM, Liu Yi L wrote:
> IOMMUs that support nesting translation needs report the capability info
need to report
> to userspace, e.g. the format of first level/stage paging structures.
> 
> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
> nesting info after setting DOMAIN_ATTR_NESTING.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v3 -> v4:
> *) split the SMMU driver changes to be a separate patch
> *) move the @addr_width and @pasid_bits from vendor specific
>    part to generic part.
> *) tweak the description for the @features field of struct
>    iommu_nesting_info.
> *) add description on the @data[] field of struct iommu_nesting_info
> 
> v2 -> v3:
> *) remvoe cap/ecap_mask in iommu_nesting_info.
> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
>    suggestion.
> ---
>  include/uapi/linux/iommu.h | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 1afc661..1bfc032 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -332,4 +332,82 @@ struct iommu_gpasid_bind_data {
>  	} vendor;
>  };
>  
> +/*
> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> + *				user space should check it before using
> + *				nesting capability.
alignment?
> + *
> + * @size:	size of the whole structure
> + * @format:	PASID table entry format, the same definition with
> + *		@format of struct iommu_gpasid_bind_data.
the same definition as struct iommu_gpasid_bind_data @format?
> + * @features:	supported nesting features.
> + * @flags:	currently reserved for future extension.
> + * @addr_width:	The output addr width of first level/stage translation
> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> + *		support.
> + * @data:	vendor specific cap info. data[] structure type can be deduced
> + *		from @format field.
> + *
> + * +===============+======================================================+
> + * | feature       |  Notes                                               |
> + * +===============+======================================================+
> + * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
> + * |               |  device. When a device is assigned to userspace or   |
> + * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
> + * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
> + * |               |  the assigned device.                                |
> + * +---------------+------------------------------------------------------+
> + * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
> + * |               |  explicitly bind the page table to associated PASID  |
> + * |               |  (either the one specified in bind request or the    |
> + * |               |  default PASID of iommu domain), through userspace   |
> + * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
> + * +---------------+------------------------------------------------------+
> + * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
> + * |               |  explicitly invalidate the IOMMU cache through uAPI  |
> + * |               |  provided by userspace driver framework (e.g. VFIO)  |
> + * |               |  according to vendor-specific requirement when       |
> + * |               |  changing the page table.                            |
> + * +---------------+------------------------------------------------------+
Do you foresee cases where BIND_PGTBL and CACHE_INVLD shouldn't be
exposed as features?
> + *
> + * @data[] types defined for @format:
> + * +================================+=====================================+
> + * | @format                        | @data[]                             |
> + * +================================+=====================================+
> + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> + * +--------------------------------+-------------------------------------+
> + *
> + */
> +struct iommu_nesting_info {
> +	__u32	size;
> +	__u32	format;
> +	__u32	features;
> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
In other structs the values seem to be defined before the field
> +	__u32	flags;
> +	__u16	addr_width;
> +	__u16	pasid_bits;
> +	__u32	padding;
> +	__u8	data[];
> +};
> +
> +/*
> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> + *
spurious line
> + *
> + * @flags:	VT-d specific flags. Currently reserved for future
> + *		extension.
> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> + *		register.
> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> + *		extended capability register.
> + */
> +struct iommu_nesting_info_vtd {
> +	__u32	flags;
> +	__u32	padding;
> +	__u64	cap_reg;
> +	__u64	ecap_reg;
> +};
> +
>  #endif /* _UAPI_IOMMU_H */
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
