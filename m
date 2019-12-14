Return-Path: <SRS0=0Wzb=2E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51674C43603
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 01:43:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350312077B
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 01:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350312077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E1285203E1;
	Sat, 14 Dec 2019 01:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1h0IqV2W+oC; Sat, 14 Dec 2019 01:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 96B96203E0;
	Sat, 14 Dec 2019 01:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 871C1C1D7C;
	Sat, 14 Dec 2019 01:43:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24336C0881
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0597785DFF
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAe1Qak8hc65 for <iommu@lists.linux-foundation.org>;
 Sat, 14 Dec 2019 01:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E13B85A0E
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 01:43:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 17:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; d="scan'208";a="226461161"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 13 Dec 2019 17:43:15 -0800
Subject: Re: [PATCH] iommu/vt-d: Allocate reserved region for ISA with correct
 permission
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-kernel@vger.kernel.org
References: <20191213053642.5696-1-jsnitsel@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5ccaaec0-b070-b820-cebd-6b7ad179109c@linux.intel.com>
Date: Sat, 14 Dec 2019 09:42:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213053642.5696-1-jsnitsel@redhat.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
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

Hi Jerry,

On 12/13/19 1:36 PM, Jerry Snitselaar wrote:
> Currently the reserved region for ISA is allocated with no
> permissions. If a dma domain is being used, mapping this region will
> fail. Set the permissions to DMA_PTE_READ|DMA_PTE_WRITE.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: stable@vger.kernel.org # v5.3+
> Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..998529cebcf2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5736,7 +5736,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   		struct pci_dev *pdev = to_pci_dev(device);
>   
>   		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> -			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
> +			reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
>   						      IOMMU_RESV_DIRECT);


This also applies to the IOAPIC range. Can you please change them
together?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..256e48434f68 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5736,7 +5736,7 @@ static void intel_iommu_get_resv_regions(struct 
device *device,
                 struct pci_dev *pdev = to_pci_dev(device);

                 if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
-                       reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
+                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
                                                       IOMMU_RESV_DIRECT);
                         if (reg)
                                 list_add_tail(&reg->list, head);
@@ -5746,7 +5746,7 @@ static void intel_iommu_get_resv_regions(struct 
device *device,

         reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
                                       IOAPIC_RANGE_END - 
IOAPIC_RANGE_START + 1,
-                                     0, IOMMU_RESV_MSI);
+                                     prot, IOMMU_RESV_MSI);
         if (!reg)
                 return;
         list_add_tail(&reg->list, head);

Best regards,
baolu

>   			if (reg)
>   				list_add_tail(&reg->list, head);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
