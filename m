Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A6ECE58D
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A721218AC
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A721218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 661F0DDF;
	Wed,  9 Oct 2019 22:57:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D441CDCA
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 362A914D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:57:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Oct 2019 15:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; d="scan'208";a="193017895"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2019 15:57:06 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
	by linux.intel.com (Postfix) with ESMTP id D516B5803E4;
	Wed,  9 Oct 2019 15:57:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] PCI/ATS: Move pci_prg_resp_pasid_required() to
	CONFIG_PCI_PRI
To: Bjorn Helgaas <helgaas@kernel.org>, David Woodhouse
	<dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20191009224551.179497-1-helgaas@kernel.org>
	<20191009224551.179497-3-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <67a573e9-3e04-5fca-6b8b-018b7bc75df8@linux.intel.com>
Date: Wed, 9 Oct 2019 15:55:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-3-helgaas@kernel.org>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
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
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


On 10/9/19 3:45 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_prg_resp_pasid_required() returns the value of the "PRG Response PASID
> Required" bit from the PRI capability, but the interface was previously
> defined under #ifdef CONFIG_PCI_PASID.
>
> Move it from CONFIG_PCI_PASID to CONFIG_PCI_PRI so it's with the other
> PRI-related things.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
>   include/linux/pci-ats.h | 11 ++++-----
>   2 files changed, 30 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index e18499243f84..0d06177252c7 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -280,6 +280,31 @@ int pci_reset_pri(struct pci_dev *pdev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pci_reset_pri);
> +
> +/**
> + * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> + *				 status.
> + * @pdev: PCI device structure
> + *
> + * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> + */
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	if (status & PCI_PRI_STATUS_PASID)
> +		return 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -395,36 +420,6 @@ int pci_pasid_features(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_pasid_features);
>   
> -/**
> - * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> - *				 status.
> - * @pdev: PCI device structure
> - *
> - * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> - *
> - * Even though the PRG response PASID status is read from PRI Status
> - * Register, since this API will mainly be used by PASID users, this
> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> - * CONFIG_PCI_PRI.
> - */
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	u16 status;
> -	int pos;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pos)
> -		return 0;
> -
> -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> -
> -	if (status & PCI_PRI_STATUS_PASID)
> -		return 1;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> -
>   #define PASID_NUMBER_SHIFT	8
>   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>   /**
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1ebb88e7c184..a7a2b3d94fcc 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   void pci_restore_pri_state(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else /* CONFIG_PCI_PRI */
>   
> @@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>   	return -ENODEV;
>   }
>   
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
>   void pci_restore_pasid_state(struct pci_dev *pdev);
>   int pci_pasid_features(struct pci_dev *pdev);
>   int pci_max_pasids(struct pci_dev *pdev);
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else  /* CONFIG_PCI_PASID */
>   
> @@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>   {
>   	return -EINVAL;
>   }
> -
> -static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	return 0;
> -}
>   #endif /* CONFIG_PCI_PASID */
>   
>   

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
