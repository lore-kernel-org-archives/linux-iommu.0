Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA66C2BA19
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 18:03:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB06A20767
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 18:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB06A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86F5087BC0;
	Tue, 14 Apr 2020 18:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ojNbAiCx3JQB; Tue, 14 Apr 2020 18:03:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BFBFF87B0F;
	Tue, 14 Apr 2020 18:03:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD90DC1D7D;
	Tue, 14 Apr 2020 18:03:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4219C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 18:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 991F387B48
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 18:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HkHWusbJHDoz for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 18:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2D1CC87B0F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 18:03:37 +0000 (UTC)
IronPort-SDR: 44yT8ehQ16dziTAhLZ9i3v8euoNWi2bHjPv9hRWeeQM9BTPD9nRWW6yTwkb3atDdVOFtx33336
 pdxl79Z2Wy0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 11:03:36 -0700
IronPort-SDR: SFfWWKn9a+9EaRfpA/3Wbs/x3kQaNMzka6GrGJ2jeWBmbZqBLlTRxdEhB2Ad2MBBRdX9vd5tu9
 ICwTpVsFz5Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="271475675"
Received: from swwoldee-mobl1.amr.corp.intel.com (HELO [10.251.15.118])
 ([10.251.15.118])
 by orsmga002.jf.intel.com with ESMTP; 14 Apr 2020 11:03:28 -0700
Subject: Re: [PATCH v5 23/25] PCI/ATS: Add PRI stubs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-24-jean-philippe@linaro.org>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b595b3a1-7444-eeac-412a-85d453c32095@linux.intel.com>
Date: Tue, 14 Apr 2020 11:03:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414170252.714402-24-jean-philippe@linaro.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 jgg@ziepe.ca, Bjorn Helgaas <bhelgaas@google.com>, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

Hi,

On 4/14/20 10:02 AM, Jean-Philippe Brucker wrote:
> The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
> support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
> unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
> adding more #ifdefs to the SMMU driver.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   include/linux/pci-ats.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index f75c307f346de..e9e266df9b37c 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
>   int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> +#else /* CONFIG_PCI_PRI */
> +static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> +{ return -ENODEV; }
> +static inline void pci_disable_pri(struct pci_dev *pdev) { }
> +static inline int pci_reset_pri(struct pci_dev *pdev)
> +{ return -ENODEV; }
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{ return 0; }
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
