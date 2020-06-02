Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788FC433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B2E2067B
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 23:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B2E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B20C987EA8;
	Tue,  2 Jun 2020 23:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPZeyJBdKv4v; Tue,  2 Jun 2020 23:28:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E75C287EA7;
	Tue,  2 Jun 2020 23:28:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F9CC0178;
	Tue,  2 Jun 2020 23:28:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC92C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 485368887F
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:28:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6kx5VK-Jr-78 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 23:28:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A748887B5
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:28:51 +0000 (UTC)
IronPort-SDR: 54w9NuqEjC3WQyOpC4LHMbZ+8CGuVcxGIr41W1CON79fvnXzMQXBR1Tf/cF4i+xT0sCZYLPRsR
 sUDn/zTPRO6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 16:28:50 -0700
IronPort-SDR: OKjQEHjHSnkvSt2tRndVRvOSocqBUBfTrLaYv+V4qnwAfjFhPzrPDaLEvqVzCuAVrFxWPL3j6b
 gTYN6yObRsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; d="scan'208";a="257269222"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2020 16:28:49 -0700
Date: Tue, 2 Jun 2020 16:28:49 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200602232849.GA17696@otc-nc-03>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: tbroch@google.com, rajatxjain@gmail.com, pmalani@google.com, zsm@google.com,
 linux-kernel@vger.kernel.org, lalithambika.krishnakumar@intel.com,
 iommu@lists.linux-foundation.org, mnissler@google.com,
 Ashok Raj <ashok.raj@intel.com>, bleung@google.com, levinale@google.com,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@intel.com>
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

On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

With these changes

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
> v3: - Separate out the warning mesage in a function to be called from
>       other places. Change the warning string as suggested.
> v2: - Change the warning print strings.
>     - Add Lu Baolu's acknowledgement.
> 
>  drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ef0a5246700e5..dc859f02985a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>  	return ret;
>  }
>  
> +/*
> + * Check that the device does not live on an external facing PCI port that is
> + * marked as untrusted. Such devices should not be able to apply quirks and
> + * thus not be able to bypass the IOMMU restrictions.
> + */
> +static bool risky_device(struct pci_dev *pdev)
> +{
> +	if (pdev->untrusted) {
> +		pci_warn(pdev,
> +			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> +			 " PCI link. Please check with your BIOS/Platform"
> +			 " vendor about this\n", pdev->vendor, pdev->device);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  const struct iommu_ops intel_iommu_ops = {
>  	.capable		= intel_iommu_capable,
>  	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
>  
>  static void quirk_iommu_igfx(struct pci_dev *dev)
>  {
> +	if (risky_device(dev))
> +		return;
> +
>  	pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
>  	dmar_map_gfx = 0;
>  }
> @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
>  
>  static void quirk_iommu_rwbf(struct pci_dev *dev)
>  {
> +	if (risky_device(dev))
> +		return;
> +
>  	/*
>  	 * Mobile 4 Series Chipset neglects to set RWBF capability,
>  	 * but needs it. Same seems to hold for the desktop versions.
> @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>  {
>  	unsigned short ggc;
>  
> +	if (risky_device(dev))
> +		return;
> +
>  	if (pci_read_config_word(dev, GGC, &ggc))
>  		return;
>  
> @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
>  	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
>  	if (!pdev)
>  		return;
> +
> +	if (risky_device(pdev)) {
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>  	pci_dev_put(pdev);
>  
>  	/* System Management Registers. Might be hidden, in which case
> @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
>  	if (!pdev)
>  		return;
>  
> +	if (risky_device(pdev)) {
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
>  	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
>  		pci_dev_put(pdev);
>  		return;
> -- 
> 2.27.0.rc2.251.g90737beb825-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
