Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A75C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252F1206D6
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F1206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE77C227E1;
	Tue, 28 Apr 2020 22:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id skrM+cp6rnn2; Tue, 28 Apr 2020 22:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7F35A20447;
	Tue, 28 Apr 2020 22:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F8D2C0864;
	Tue, 28 Apr 2020 22:13:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13B7FC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0FAE98688C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dM2BqEYJM5uC for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 22:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D07908688B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:13:06 +0000 (UTC)
IronPort-SDR: N1NuRWEKsUI7h/hvQOsMC+yo1kcGKlNkaOm2CA3XotmXQm3Rdoqv1x+nqQ3r4Tt4ib2kpx97/V
 jvDGhydXb1tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 15:13:05 -0700
IronPort-SDR: UrO7djlVD746mQgSPR9NNFNfA6Q93RtblZyn3IyDb/eLZWJ1jt5uCnmYQLA0JuXb00jYhZNGYP
 TE87jCla70kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="282293855"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.240.17])
 by fmsmga004.fm.intel.com with SMTP; 28 Apr 2020 15:13:04 -0700
Date: Tue, 28 Apr 2020 15:13:03 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
Message-ID: <20200428151303.00004fa2@intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>
 <20200428112113.000033bd@intel.com>
 <87tv13o306.fsf@nanos.tec.linutronix.de>
 <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
 <20200428134200.000010f7@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
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

On Tue, 28 Apr 2020 13:59:43 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> >> So the driver needs to use flush/drain operations to make sure all
> >> the in-flight work has completed before releasing/re-using the
> >> PASID. 
> > Are you suggesting we should let driver also hold a reference of the
> > PASID?  
> 
> The sequence for bare metal is:
> 
> 	process is queuing requests to DSA
> 	process exits (either deliberately, or crashes, or is killed)
> 	kernel does exit processing
> 	DSA driver is called as part of tear down of "mm"
> 		issues drain/flush commands to ensure that all
> 		queued operations on the PASID for this mm have
> 		completed
> 	PASID can be freed
> 
> There's a 1:1 map from "mm" to PASID ... so reference counting seems
> like overkill. Once the kernel is in the "exit" path, we know that no
> more work can be queued using this PASID.
> 
There are two users of a PASID, mm and device driver(FD). If
either one is not done with the PASID, it cannot be reclaimed. As you
mentioned, it could take a long time for the driver to abort. If the
abort ends *after* mmdrop, we are in trouble.
If driver drops reference after abort/drain PASID is done, then we are
safe.


> -Tony

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
