Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF887C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 05:30:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB5B206E6
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 05:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB5B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CEEC8627B;
	Wed,  3 Jun 2020 05:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlAlnJpeth1C; Wed,  3 Jun 2020 05:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C351586292;
	Wed,  3 Jun 2020 05:30:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE268C0888;
	Wed,  3 Jun 2020 05:30:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADC2BC016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 05:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BDAB87EA4
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 05:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vbRTLAdOrrmX for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 05:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2102D87E0A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 05:30:14 +0000 (UTC)
IronPort-SDR: uuyybMWSM7iaFt4RB/tcUhtSzWz1jVjT5tnLLkYz/39nrAcecGgcvYShKt3XTKQWKXTAiakg5v
 SOhoG37ohilw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 22:30:13 -0700
IronPort-SDR: 0cWYtPZtBHwgk1szY2u3scGNdBUAiggIUcHJKs3Tae7sEL3mHr97A1ldF8/iuLLoTu0Z8e7ecn
 HOqM/ahP/yKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; d="scan'208";a="377986062"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
 by fmsmga001.fm.intel.com with SMTP; 02 Jun 2020 22:30:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jun 2020 08:30:08 +0300
Date: Wed, 3 Jun 2020 08:30:08 +0300
From: Mika Westerberg <mika.westerberg@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200603053008.GR247495@lahna.fi.intel.com>
References: <20200602232602.156049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602232602.156049-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: tbroch@google.com, pmalani@google.com, Ashok Raj <ashok.raj@intel.com>,
 rajatxjain@gmail.com, zsm@google.com, linux-kernel@vger.kernel.org,
 lalithambika.krishnakumar@intel.com, iommu@lists.linux-foundation.org,
 mnissler@google.com, bleung@google.com, levinale@google.com,
 David Woodhouse <dwmw2@infradead.org>
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
> +static bool risky_device(struct pci_dev *pdev)
> +{
> +	if (pdev->untrusted) {
> +		pci_warn(pdev,
> +			 "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> +			 " PCI link. Please check with your BIOS/Platform"
> +			 " vendor about this\n", pdev->vendor, pdev->device);

You should not break user visible strings like this. It makes grepping
for them harder (see also CodingStyle). You can write it like this instead:

	pci_info(pdev, "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted PCI link\n",
		 pdev->vendor, pdev->device);
	pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");

Also I guess pci_info() might be better here after all. Your call :)

Rest of the patch looks good to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
