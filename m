Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC02C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 11:53:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B2220748
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 11:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B2220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2514F20446;
	Fri, 27 Mar 2020 11:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pn3jd75Wyc1I; Fri, 27 Mar 2020 11:53:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BCEBA20395;
	Fri, 27 Mar 2020 11:53:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D397C1D7C;
	Fri, 27 Mar 2020 11:53:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE299C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9D6058831D
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlOll2uEBR57 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 11:53:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A90CC8815C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 11:53:49 +0000 (UTC)
IronPort-SDR: 0oTo3y6p5dZk0o53d+EV5QkovV5mgzsUd+/9Nu1Na20amzk34Ok738iubRDnej4rchiO7UV7Gy
 GVLrtM8HJJ3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 04:53:46 -0700
IronPort-SDR: NLgMxE9hfwqowLfcGcaKbY5YYEJ7W0hHxj73PYZCoYn/EkB4dV2B6w1rWXDsJ/nGwvyJT9NVXO
 FW4rmDKgqE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; d="scan'208";a="421078383"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 04:53:45 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 04:53:45 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.144]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 19:53:42 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
Thread-Topic: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
Thread-Index: AQHV/w5eE2ECFEEmSk27LCUrIv3j86hcXZwQ
Date: Fri, 27 Mar 2020 11:53:42 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
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
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

could you elaborate in which scenario this helper function is required?
 
> ---
>  drivers/iommu/intel-pasid.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 22b30f10b396..191508c7c03e 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -500,6 +500,28 @@ int intel_pasid_setup_first_level(struct intel_iommu
> *iommu,
>  }
> 
>  /*
> + * Skip top levels of page tables for iommu which has less agaw
> + * than default. Unnecessary for PT mode.
> + */
> +static inline int iommu_skip_agaw(struct dmar_domain *domain,
> +				  struct intel_iommu *iommu,
> +				  struct dma_pte **pgd)
> +{
> +	int agaw;
> +
> +	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> +		*pgd = phys_to_virt(dma_pte_addr(*pgd));
> +		if (!dma_pte_present(*pgd)) {
> +			return -EINVAL;
> +		}
> +	}
> +	pr_debug_ratelimited("%s: pgd: %llx, agaw %d d_agaw %d\n",
> __func__, (u64)*pgd,
> +		iommu->agaw, domain->agaw);
> +
> +	return agaw;
> +}
> +
> +/*
>   * Set up the scalable mode pasid entry for second only translation type.
>   */
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
