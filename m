Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE18C433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:15:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0F620674
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F5688763C;
	Tue,  2 Jun 2020 07:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7F2HE4ag5mc1; Tue,  2 Jun 2020 07:15:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9BAA875B6;
	Tue,  2 Jun 2020 07:15:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFCAEC0178;
	Tue,  2 Jun 2020 07:15:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7AECC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D608E875DC
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9PIrPDncp4O for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 07:15:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0B6AE875B6
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:15:19 +0000 (UTC)
IronPort-SDR: mtnca6oxcKIPPMYec6/tLhMOyU/QjjgqY8DYBu5umZfK42eWUxQBdaPh8ae3veWaRs9nGcY7uu
 3zxHf2CRF+mQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 00:15:18 -0700
IronPort-SDR: YBIAVbKL6Ewx0Yi4csv6WAPag/FZJw60XWTNrwPx9dLJoGlLBFbfyACfaPaeNkKAcrK4fOP4o5
 IHzxlehO/Uvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; d="scan'208";a="286547216"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.17])
 ([10.255.30.17])
 by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 00:15:13 -0700
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To: Rajat Jain <rajatja@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, lalithambika.krishnakumar@intel.com
References: <20200602054517.191244-1-rajatja@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ad238863-bef8-99bf-38c7-5839af1647e5@linux.intel.com>
Date: Tue, 2 Jun 2020 15:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602054517.191244-1-rajatja@google.com>
Content-Language: en-US
Cc: tbroch@google.com, rajatxjain@gmail.com, pmalani@google.com,
 mnissler@google.com, bleung@google.com, zsm@google.com, levinale@google.com
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

On 2020/6/2 13:45, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..f2a480168a02f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
>   
>   static void quirk_iommu_igfx(struct pci_dev *dev)
>   {
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> +		return;
> +	}
> +
>   	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
>   	dmar_map_gfx = 0;
>   }
> @@ -6255,6 +6260,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
>   
>   static void quirk_iommu_rwbf(struct pci_dev *dev)
>   {
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted dev\n");
> +		return;
> +	}
> +
>   	/*
>   	 * Mobile 4 Series Chipset neglects to set RWBF capability,
>   	 * but needs it. Same seems to hold for the desktop versions.
> @@ -6285,6 +6295,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   {
>   	unsigned short ggc;
>   
> +	if (dev->untrusted) {
> +		pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
> +		return;
> +	}
> +
>   	if (pci_read_config_word(dev, GGC, &ggc))
>   		return;
>   
> @@ -6318,6 +6333,13 @@ static void __init check_tylersburg_isoch(void)
>   	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
>   	if (!pdev)
>   		return;
> +
> +	if (pdev->untrusted) {
> +		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>   	pci_dev_put(pdev);
>   
>   	/* System Management Registers. Might be hidden, in which case
> @@ -6327,6 +6349,12 @@ static void __init check_tylersburg_isoch(void)
>   	if (!pdev)
>   		return;
>   
> +	if (pdev->untrusted) {
> +		pci_warn(pdev, "skipping iommu quirk due to untrusted dev\n");
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>   	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
>   		pci_dev_put(pdev);
>   		return;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
