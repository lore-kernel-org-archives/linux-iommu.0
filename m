Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F966C83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F181C2085B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA614875CF;
	Tue, 28 Apr 2020 20:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOGZU654fKnL; Tue, 28 Apr 2020 20:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 762778493F;
	Tue, 28 Apr 2020 20:42:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 559CDC0864;
	Tue, 28 Apr 2020 20:42:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5FEEC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B28AD84AFB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xTr5yQWCUUBQ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 20:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 022E18493F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:42:01 +0000 (UTC)
IronPort-SDR: gz8bkZs0cQpStMCL9Tfjk43Dthbmre6qCtxbg6DnF//PT9h3wn8Ag10HlsQRGxg1WVadmC6fI2
 K70CJ1MT+3+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 13:42:01 -0700
IronPort-SDR: xagcZJWK38zXxA6Ieuy00Ct62Fx2wWHz9vTb6SOF2J+n3Zp70Y7WRrXkYEqW+/S3sb23RIPidX
 V9CDHy8qkx/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="246625188"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.240.17])
 by orsmga007.jf.intel.com with SMTP; 28 Apr 2020 13:42:00 -0700
Date: Tue, 28 Apr 2020 13:42:00 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428134200.000010f7@intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>
 <20200428112113.000033bd@intel.com>
 <87tv13o306.fsf@nanos.tec.linutronix.de>
 <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar, 
 Ravi V" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 jacob.jun.pan@intel.com, H Peter Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, 28 Apr 2020 12:07:25 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> > If fd release cleans up then how should there be something in
> > flight at the final mmdrop?  
> 
> ENQCMD from the user is only synchronous in that it lets the user
> know their request has been added to a queue (or not).  Execution of
> the request may happen later (if the device is busy working on
> requests for other users).  The request will take some time to
> complete. Someone told me the theoretical worst case once, which I've
> since forgotten, but it can be a long time.
> 
> So the driver needs to use flush/drain operations to make sure all
> the in-flight work has completed before releasing/re-using the PASID.
> 
Are you suggesting we should let driver also hold a reference of the
PASID?

> -Tony

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
