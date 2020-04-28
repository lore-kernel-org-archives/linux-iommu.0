Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC163C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:32:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCCA206F0
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCCA206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F32A87694;
	Tue, 28 Apr 2020 22:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSDHzGqfBgn6; Tue, 28 Apr 2020 22:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4D9886E49;
	Tue, 28 Apr 2020 22:32:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA4D7C0864;
	Tue, 28 Apr 2020 22:32:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7AE8C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9109287689
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xL-YhMhZLYto for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 22:32:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 402B586E49
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 22:32:46 +0000 (UTC)
IronPort-SDR: JyplXokRENd2ZiSqlWbSc2L7aeC9M9yT8F6iyhjow6XrWMw/LBkc0xBW9zcE5nW2pscswzNA2V
 OeEgYHjfktxA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 15:32:45 -0700
IronPort-SDR: Wc3gxIdIiSNxc8tk/rkLqMzcR5i/1/GyPKsIAr8yMh5kaAmvh9G96jWv3wF4x3q3lHxH77oSMm
 qMjcQk2AahlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="458967943"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2020 15:32:44 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 15:32:44 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.56]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 15:32:44 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Topic: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Index: AQHWBtMgRqn1rM/ldEi9589O6eqhDKiMHSGAgANeKoCAAAkqgP//jPrQgACRMQD//44esIAAi1OA//+OJZA=
Date: Tue, 28 Apr 2020 22:32:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F6094E2@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>	<20200428112113.000033bd@intel.com>
 <87tv13o306.fsf@nanos.tec.linutronix.de>
 <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
 <20200428134200.000010f7@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
 <20200428151303.00004fa2@intel.com>
In-Reply-To: <20200428151303.00004fa2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar, 
 Ravi V" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
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

> There are two users of a PASID, mm and device driver(FD). If
> either one is not done with the PASID, it cannot be reclaimed. As you
> mentioned, it could take a long time for the driver to abort. If the
> abort ends *after* mmdrop, we are in trouble.
> If driver drops reference after abort/drain PASID is done, then we are
> safe.

I don't think there should be an abort ... suppose the application requested
the DSA to copy some large block of important results from DDR4 to
persistent memory.  Driver should wait for that copy operation to complete.

Note that for the operation to succeed, the kernel should still be processing
and fixing page faults for the "mm" (some parts of the data that the user wanted
to save to persistent memory may have been paged out).

The wait by the DSA diver needs to by synchronous ... the "mm" cannot be
freed until DSA says all the pending operations have completed.

Even without persistent memory, there are cases where you want the operations
to complete (mmap'd files, shared memory with other processes).

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
