Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876AC433DF
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D4E207C3
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D4E207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E6DAB8861E;
	Tue,  9 Jun 2020 12:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WUoUZBxRL36; Tue,  9 Jun 2020 12:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CAEFF88606;
	Tue,  9 Jun 2020 12:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7D27C088C;
	Tue,  9 Jun 2020 12:35:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB593C016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 12:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF23786E26
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 12:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1I-8L4Gwa-G5 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 12:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0CED786D03
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 12:35:13 +0000 (UTC)
IronPort-SDR: bsSC/Qd2Wwt8vBPS1jQ7TwG6hZZjKhGG/eDa/SMQlFPeL0/ZwbrgqDm2HcKm6NdQ4YvmKA67zB
 J0QRiRz0KpfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 05:35:12 -0700
IronPort-SDR: c3Gq4jgpD1P0U/nhnJpthh+H0kg5i1mggj34q/eXOuRBSP0ANXFhu5AIkMrQfvREtM73cL88xK
 VMuM2TwGLrnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; d="scan'208";a="379724594"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
 by fmsmga001.fm.intel.com with SMTP; 09 Jun 2020 05:35:10 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Jun 2020 15:35:09 +0300
Date: Tue, 9 Jun 2020 15:35:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PCI ACS for platform opt in hint
Message-ID: <20200609123509.GP247495@lahna.fi.intel.com>
References: <20200608231720.27740-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608231720.27740-1-baolu.lu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Ashok Raj <ashok.raj@intel.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 09, 2020 at 07:17:20AM +0800, Lu Baolu wrote:
> PCI ACS is disabled if Intel IOMMU is off by default or intel_iommu=off
> is used in command line. Unfortunately, Intel IOMMU will be forced on if
> there're devices sitting on an external facing PCI port that is marked
> as untrusted (for example, thunderbolt peripherals). That means, PCI ACS
> is disabled while Intel IOMMU is forced on to isolate those devices. As
> the result, the devices of an MFD will be grouped by a single group even
> the ACS is supported on device.
> 
> [    0.691263] pci 0000:00:07.1: Adding to iommu group 3
> [    0.691277] pci 0000:00:07.2: Adding to iommu group 3
> [    0.691292] pci 0000:00:07.3: Adding to iommu group 3
> 
> Fix it by requesting PCI ACS when Intel IOMMU is detected with platform
> opt in hint.
> 
> Fixes: 89a6079df791a ("iommu/vt-d: Force IOMMU on for platform opt in hint")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
