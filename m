Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81845C43465
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 23:53:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC49620770
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 23:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC49620770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 94135204AC;
	Thu, 17 Sep 2020 23:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1INzenKWTVMe; Thu, 17 Sep 2020 23:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 509CF20033;
	Thu, 17 Sep 2020 23:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2061DC0888;
	Thu, 17 Sep 2020 23:53:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1F00C0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 23:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D4E7D876F3
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 23:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d42xlXmlGhw2 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 23:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A16C876CB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 23:53:23 +0000 (UTC)
IronPort-SDR: QSJ00c74/y82I+C5xIyQiG3kPffqhHeeM3Rq8KUcdEw4ht+bfKyIWk3nUJ/2KAM8D2A2XpHhwZ
 4Rj8AMmOF4gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157203993"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="157203993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 16:53:19 -0700
IronPort-SDR: Nr+0mGubviR84swXz/m+U+I6g2bFEXpFYPMqMU7WZWTG1kByWVYLJaKP8s9IKEEkHsHSW/00G0
 uzHsiXwh/nQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="332358452"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2020 16:53:18 -0700
Date: Thu, 17 Sep 2020 23:53:17 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 0/9] x86: tag application address space for devices
Message-ID: <20200917235317.GA443277@otcwcpicx6.sc.intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <20200916080510.GA32552@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916080510.GA32552@8bytes.org>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi, Joerg,

On Wed, Sep 16, 2020 at 10:06:02AM +0200, Joerg Roedel wrote:
> On Tue, Sep 15, 2020 at 09:30:04AM -0700, Fenghua Yu wrote:
> > Ashok Raj (1):
> >   Documentation/x86: Add documentation for SVA (Shared Virtual
> >     Addressing)
> > 
> > Fenghua Yu (7):
> >   drm, iommu: Change type of pasid to u32
> >   iommu/vt-d: Change flags type to unsigned int in binding mm
> >   x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
> >   x86/msr-index: Define IA32_PASID MSR
> >   mm: Define pasid in mm
> >   x86/cpufeatures: Mark ENQCMD as disabled when configured out
> >   x86/mmu: Allocate/free PASID
> > 
> > Yu-cheng Yu (1):
> >   x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature
> 
> For the IOMMU bits:
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

Thank you!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
