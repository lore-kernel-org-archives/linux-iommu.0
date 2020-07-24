Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F27C433E3
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 02:37:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2BA2065E
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 02:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2BA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CE7CE230A4;
	Fri, 24 Jul 2020 02:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW6bF8tuD9xe; Fri, 24 Jul 2020 02:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ACC13203BB;
	Fri, 24 Jul 2020 02:37:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B749C004D;
	Fri, 24 Jul 2020 02:37:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC9DC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A84668822A
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cW89otTtkA7M for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 02:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93CDA8820F
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 02:36:58 +0000 (UTC)
IronPort-SDR: ea6A8Vrxh+VUnfge4M4Mevu7y/YsDI+TKUSDaNnWkuhoi0LJiXmM/rMfZ9OEsTKoOlhj3LJlXR
 y3U9GnIycPbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138149465"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; d="scan'208";a="138149465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 19:36:57 -0700
IronPort-SDR: VumJ4VEkWa/OzC1HjafHWG3PZMIWizMVXVztoxDHSS7WiXFyCR8JaetnBle565Tqk0tmfQOWpW
 8+Qiz+zmCQBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; d="scan'208";a="393186436"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2020 19:36:55 -0700
Subject: Re: [PATCH v3 1/1] PCI/ATS: Check PRI supported on the PF device when
 SRIOV is enabled
To: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@intel.com>
References: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4e14f3b7-fdd7-8710-5051-440597ea198d@linux.intel.com>
Date: Fri, 24 Jul 2020 10:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 7/24/20 6:37 AM, Ashok Raj wrote:
> PASID and PRI capabilities are only enumerated in PF devices. VF devices
> do not enumerate these capabilites. IOMMU drivers also need to enumerate
> them before enabling features in the IOMMU. Extending the same support as
> PASID feature discovery (pci_pasid_features) for PRI.
> 
> Fixes: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Joerg Roedel <joro@8bytes.com>
> To: Lu Baolu <baolu.lu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Cc: stable@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> v3: Added Fixes tag
> v2: Fixed build failure reported from lkp when CONFIG_PRI=n
> 
>   drivers/iommu/intel/iommu.c |  2 +-
>   drivers/pci/ats.c           | 13 +++++++++++++
>   include/linux/pci-ats.h     |  4 ++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e98..276452f5e6a7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2560,7 +2560,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   			}
>   
>   			if (info->ats_supported && ecap_prs(iommu->ecap) &&
> -			    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
> +			    pci_pri_supported(pdev))
>   				info->pri_supported = 1;
>   		}
>   	}
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index b761c1f72f67..2e6cf0c700f7 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -325,6 +325,19 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>   
>   	return pdev->pasid_required;
>   }
> +
> +/**
> + * pci_pri_supported - Check if PRI is supported.
> + * @pdev: PCI device structure
> + *
> + * Returns true if PRI capability is present, false otherwise.
> + */
> +bool pci_pri_supported(struct pci_dev *pdev)
> +{
> +	/* VFs share the PF PRI configuration */
> +	return !!(pci_physfn(pdev)->pri_cap);
> +}
> +EXPORT_SYMBOL_GPL(pci_pri_supported);
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index f75c307f346d..df54cd5b15db 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -28,6 +28,10 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
>   int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> +bool pci_pri_supported(struct pci_dev *pdev);
> +#else
> +static inline bool pci_pri_supported(struct pci_dev *pdev)
> +{ return false; }
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
