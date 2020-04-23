Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546DC2BA19
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 07:30:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5650F2076C
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 07:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5650F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1172387D9D;
	Thu, 23 Apr 2020 07:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmimNTXprgnl; Thu, 23 Apr 2020 07:30:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66D37877D3;
	Thu, 23 Apr 2020 07:30:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45FF8C1797;
	Thu, 23 Apr 2020 07:30:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F6CC0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 07:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5316686739
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 07:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caNM7Wlujg2r for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 07:30:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E93CE85F6C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 07:30:14 +0000 (UTC)
IronPort-SDR: q1A7yeWSIB5FHKX9zrb/yUlK4WO2D2xXOpMhEQP9PqnG3wZPGVRwcuz4U1aQqqxE7j7CHRiAQG
 r5XWRWLuip2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 00:30:13 -0700
IronPort-SDR: 5nWklFsLj8V+HPKfgDgkg+qhYZpUR6WsZFxOaqMu8KKW2eEaKoS9dEfu8FUT6uBctg/FZkDkd9
 qOtaavvisRbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="274148072"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga002.jf.intel.com with ESMTP; 23 Apr 2020 00:30:12 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 00:30:02 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 00:29:59 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Apr 2020 00:29:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Thu, 23 Apr 2020 15:29:57 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH v12 2/8] iommu/vt-d: Use a helper function to skip agaw
 for SL
Thread-Topic: [PATCH v12 2/8] iommu/vt-d: Use a helper function to skip agaw
 for SL
Thread-Index: AQHWGA061s2Otz/cL0WDDwOKAajsVqiGUa+A
Date: Thu, 23 Apr 2020 07:29:56 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D878FBA@SHSMSX104.ccr.corp.intel.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1587495165-80096-3-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1587495165-80096-3-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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
> Sent: Wednesday, April 22, 2020 2:53 AM
> 
> An Intel iommu domain uses 5-level page table by default. If the
> iommu that the domain tries to attach supports less page levels,
> the top level page tables should be skipped. Add a helper to do
> this so that it could be used in other places.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-pasid.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 22b30f10b396..d9cea3011b58 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -500,6 +500,25 @@ int intel_pasid_setup_first_level(struct intel_iommu
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
> +		if (!dma_pte_present(*pgd))
> +			return -EINVAL;
> +	}
> +
> +	return agaw;
> +}
> +
> +/*
>   * Set up the scalable mode pasid entry for second only translation type.
>   */
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
> @@ -522,17 +541,11 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
>  		return -EINVAL;
>  	}
> 
> -	/*
> -	 * Skip top levels of page tables for iommu which has less agaw
> -	 * than default. Unnecessary for PT mode.
> -	 */
>  	pgd = domain->pgd;
> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> -		pgd = phys_to_virt(dma_pte_addr(pgd));
> -		if (!dma_pte_present(pgd)) {
> -			dev_err(dev, "Invalid domain page table\n");
> -			return -EINVAL;
> -		}
> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
> +	if (agaw < 0) {
> +		dev_err(dev, "Invalid domain page table\n");
> +		return -EINVAL;
>  	}
> 
>  	pgd_val = virt_to_phys(pgd);
> --
> 2.7.4

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
