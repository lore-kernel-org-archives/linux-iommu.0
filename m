Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE4C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 11:50:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC8820748
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 11:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC8820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D1D1189383;
	Fri, 27 Mar 2020 11:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n3VadhSWB+uO; Fri, 27 Mar 2020 11:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B51989285;
	Fri, 27 Mar 2020 11:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8B46C1D7C;
	Fri, 27 Mar 2020 11:50:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60542C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5C37589383
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AR2jp1JI6geN for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 11:50:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E29B89285
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:50:05 +0000 (UTC)
IronPort-SDR: Yr3WrIWVQZql6O10ZYsxKa5IdINxTly7v2Gz3sinQeB2Xui6yxUq/V3jtPtACbgOsIjk4bng62
 7Gcy5J45pNKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 04:50:04 -0700
IronPort-SDR: LUZKfOpQcQ4yXvtqOrUK70YkU3GgWIeKGL2J86RQ/7W7tnqECktJK0YSwOx4xRSIYGln68IuV2
 OVpZkkq5gcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; d="scan'208";a="421077440"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 04:50:03 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 04:50:03 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 04:50:02 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Mar 2020 04:50:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.50]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 19:50:00 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH V10 02/11] iommu/uapi: Define a mask for bind data
Thread-Topic: [PATCH V10 02/11] iommu/uapi: Define a mask for bind data
Thread-Index: AQHV/w5fLuvDMYMRNEyiPRgmiPwyhqhcXWfg
Date: Fri, 27 Mar 2020 11:50:00 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8CA@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-3-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1584746861-76386-3-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, March 21, 2020 7:28 AM
> 
> Memory type related flags can be grouped together for one simple check.
> 
> ---
> v9 renamed from EMT to MTS since these are memory type support flags.
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4ad3496e5c43..d7bcbc5f79b0 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>  	__u32 pat;
>  	__u32 emt;
>  };
> -
> +#define IOMMU_SVA_VTD_GPASID_MTS_MASK
> 	(IOMMU_SVA_VTD_GPASID_CD | \
> +					 IOMMU_SVA_VTD_GPASID_EMTE | \
> +					 IOMMU_SVA_VTD_GPASID_PCD |  \
> +					 IOMMU_SVA_VTD_GPASID_PWT)
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest
> PASID binding
>   * @version:	Version of this data structure
> --
> 2.7.4

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
