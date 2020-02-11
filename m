Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F2FC352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:03:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951B120714
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951B120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5994F8776C;
	Tue, 11 Feb 2020 16:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uovr+f4j6w3Z; Tue, 11 Feb 2020 16:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C72F86E2C;
	Tue, 11 Feb 2020 16:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78088C1D80;
	Tue, 11 Feb 2020 16:03:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6CBBC07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC3EB87554
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5hlq3oqRLFV for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 16:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AA20486E2C
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:16 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 08:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="431997930"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2020 08:03:15 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.106]) with mapi id 14.03.0439.000;
 Tue, 11 Feb 2020 08:03:15 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "drake@endlessm.com" <drake@endlessm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Thread-Topic: [PATCH] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Thread-Index: AQHV4LuaPOrgufmY8EeIqTygVzTcT6gWriuA
Date: Tue, 11 Feb 2020 16:03:14 +0000
Message-ID: <bf9337f8c4336ee3bdb123ff381ec1330bdc8150.camel@intel.com>
References: <20200211091352.12031-1-drake@endlessm.com>
In-Reply-To: <20200211091352.12031-1-drake@endlessm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.201]
Content-ID: <7329083AA3C05E4E86A3ED0FD9D56989@intel.com>
MIME-Version: 1.0
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux@endlessm.com" <linux@endlessm.com>
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

Hi Daniel

On Tue, 2020-02-11 at 17:13 +0800, Daniel Drake wrote:
> The PCI devices handled by intel-iommu may have a DMA requester on
> another bus, such as VMD subdevices needing to use the VMD endpoint.
> 
> The real DMA device is now used for the DMA mapping, but one case was
> missed earlier, when allocating memory through (e.g.) intel_map_page().
> Confusion ensues if the iommu domain type for the subdevice does not match
> the iommu domain type for the real DMA device.
Is there a way to force this situation for my testing? 

> 
> For example, take the case of the subdevice handled by intel_map_page()
> in a IOMMU_DOMAIN_DMA, with the real DMA device in a
> IOMMU_DOMAIN_IDENTITY:
> 
> 1. intel_map_page() checks if an IOMMU mapping is needed by calling
>    iommu_need_mapping() on the subdevice. Result: mapping is needed.
> 2. __intel_map_single() is called to create the mapping:
>   - __intel_map_single() calls find_domain(). This function now returns
>     the IDENTITY domain corresponding to the real DMA device.
>   - __intel_map_single() then calls domain_get_iommu() on this "real"
>     domain. A failure is hit and the entire operation is aborted, because
>     this codepath is not intended to handle IDENTITY mappings:
>         if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
> 	     return NULL;
> 
> Fix this by using the real DMA device when checking if a mapping is
> needed. The above case will then directly fall back on
> dma_direct_map_page().
> 
> Fixes: 2b0140c69637 ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> 
> Notes:
>     This problem was detected with a non-upstream patch
>     "PCI: Add Intel remapped NVMe device support"
>     (https://marc.info/?l=linux-ide&m=156015271021615&w=2)
>     
>     This patch creates PCI devices in the same way as VMD, and hence
>     I believe VMD would hit this class of problem for any cases where
>     iommu domain type may mismatch between subdevice and real device,
>     which we have run into here.
>     
>     However this hasn't actually been tested on VMD (don't have the hardware)
>     so if I've missed anything and/or it's not a real issue then feel free to
>     drop this patch.
> 
>  drivers/iommu/intel-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9dc37672bf89..713810f8350c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3587,6 +3587,9 @@ static bool iommu_need_mapping(struct device *dev)
>  	if (iommu_dummy(dev))
>  		return false;
>  
> +	if (dev_is_pci(dev))
> +		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
> +
>  	ret = identity_mapping(dev);
>  	if (ret) {
>  		u64 dma_mask = *dev->dma_mask;
This will be a problem. We really want to use the subdevice's dma mask
in case there's a situation where the subdevice only supports 32-bit
dma (with the real dma requester having a 64-bit dma mask)



Would this work?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc3767..8f35e6b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3582,19 +3582,24 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
+       u64 dma_mask, required_dma_mask;
        int ret;
 
        if (iommu_dummy(dev))
                return false;
 
-       ret = identity_mapping(dev);
-       if (ret) {
-               u64 dma_mask = *dev->dma_mask;
+       dma_mask = *dev->dma_mask;
+       if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
+               dma_mask = dev->coherent_dma_mask;
 
-               if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-                       dma_mask = dev->coherent_dma_mask;
+       required_dma_mask = dma_direct_get_required_mask(dev);
 
-               if (dma_mask >= dma_direct_get_required_mask(dev))
+       if (dev_is_pci(dev))
+               dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
+       ret = identity_mapping(dev);
+       if (ret) {
+               if (dma_mask >= required_dma_mask)
                        return false;
 
                /*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
