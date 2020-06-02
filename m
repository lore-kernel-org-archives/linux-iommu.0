Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE40CC433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 00:00:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF1F206E9
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 00:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E0d2Vlsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1F206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45AE0888F0;
	Wed,  3 Jun 2020 00:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eS+hlntJ13mI; Wed,  3 Jun 2020 00:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94354888AC;
	Wed,  3 Jun 2020 00:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78C48C0178;
	Wed,  3 Jun 2020 00:00:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3CBC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72EA88637A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZQ7NZQHrIdM for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 23:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A2505862ED
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 23:49:20 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id v2so279191pfv.7
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yVZeRlHhmAp/EMedhM3eoU5f2SVcU2Jx7IPSMK+7jJA=;
 b=E0d2VlsqPj91lO5CAD8WZ5itr9frJvtu8iuXkw+qeXzjXC4Uip1vmXF8oIE1I7Ca1o
 nLnMIdg/5ZCKqU7lKZatNBkCKQGp60QG+BjHdhq5P9nAYAe/BwYvIT4s+2hf33fbtaoV
 AIJ/rWolSjpPsy1jTpCDrfDl5YKIGGgJbCrlTbKuDeK1rByox2oTrtEs2PSQOaGTTv9H
 aEHjiE2Pq+23Wn48sELeokRlGixHU8DwSOmOEOYxqZ0tK1C7/qos/NvYDJr9luTBISav
 B1ACivJy1WwLPQb/z4fxEr6civ6H5q1ub1cNpfSastZNT2OOzT2q14oDz6HEx9WhmgzB
 UW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yVZeRlHhmAp/EMedhM3eoU5f2SVcU2Jx7IPSMK+7jJA=;
 b=egGGT1FXDf2UPBD1kEu2ht2jZ8gtHGUI8YGyps77MzS9qkGoYii/0Mxx8rYxCCJNo6
 u0kZ7xjbIdtxwWKmx3czPusmT+bli9+KQiD2jDooXrxn2dvwcXx/N9wsYY9wPIeI57RD
 YGx0m1kAtqYS9yZblfFBSLd9DPrNH46dynO2Aigj9CZz+Cig8cvc3QdNmtTnfVP/U7Wi
 puh2RvMwG5BRaJ5zzkJAXQ5FM4+2uMAMzZt6+UvN7N+1q5xlrixurk31W9/JVCNLfuGs
 JnhjjhNXaEq+xxTr7OHRZVp0JJuEJezUh/amqZ8dFkcLZQpjaPfws8Q3XHgqYBTeRLnt
 tXCQ==
X-Gm-Message-State: AOAM533InbZoGhhJeZ78ehhmAxQoBZfmMYmtJLOXU8Pf0aZcKeZRoELx
 ptxrCCDTFy6fncxv4X6Dssk62g==
X-Google-Smtp-Source: ABdhPJwhNjUMzKjWf5QCkLix8B4rbHeEW57Wy0OzwqsMIxXo0t1ac9T2bunWwjBSynyz5CU+162gow==
X-Received: by 2002:a17:90a:17e6:: with SMTP id
 q93mr1755037pja.133.1591141759693; 
 Tue, 02 Jun 2020 16:49:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
 by smtp.gmail.com with ESMTPSA id k7sm94000pga.87.2020.06.02.16.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:49:18 -0700 (PDT)
Date: Tue, 2 Jun 2020 16:49:12 -0700
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200602234912.GB109930@google.com>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
X-Mailman-Approved-At: Wed, 03 Jun 2020 00:00:43 +0000
Cc: tbroch@google.com, Ashok Raj <ashok.raj@intel.com>, rajatxjain@gmail.com,
 zsm@google.com, linux-kernel@vger.kernel.org,
 lalithambika.krishnakumar@intel.com, iommu@lists.linux-foundation.org,
 mnissler@google.com, bleung@google.com, levinale@google.com,
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
From: Prashant Malani via iommu <iommu@lists.linux-foundation.org>
Reply-To: Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Rajat,

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
minor suggestion: Perhaps you could use a guard clause here? It would save you
a level of indentation, and possibly allow better string splitting
(e.g keeping "untrusted PCI" together). So something like:

if (!pdev->untrusted)
	return false;

pci_warn(...);

I also hear the column limit warning is now for 100 chars [1], though
I'm not sure how it's being handled in this file.

Best regards,

-Prashant

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144

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
