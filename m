Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F00C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 17:11:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875D220656
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 17:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875D220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59EC78666C;
	Mon, 15 Jun 2020 17:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jn6a6wLdri0b; Mon, 15 Jun 2020 17:11:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6BA8864E6;
	Mon, 15 Jun 2020 17:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5F8DC0888;
	Mon, 15 Jun 2020 17:11:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A35CDC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 17:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E30D8861A2
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 17:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aw6tlCezz1i5 for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 17:11:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 40FC9850A3
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 17:11:05 +0000 (UTC)
IronPort-SDR: 0I4CDAJZSfEwMicah1Qji0IO6BqT84iSDC1uAtAlgJsIgVk/Y+AkA+axB0FMbdMsjAmPJ5yjih
 NKw31bPAQigA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 10:11:04 -0700
IronPort-SDR: RVNXESVvO6FWtMErjyjWNKs0+yP0qEGVpzaS46AsbhzCxBJ4pgFxBRHP0UsFn0BSa/WFZhIvwg
 gS0bY/MY5b0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; d="scan'208";a="449468052"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga005.jf.intel.com with ESMTP; 15 Jun 2020 10:11:03 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 10:11:03 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.61]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 10:11:03 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Thread-Index: AQHWQRt0fMmHYsE9aUKb3rSjyAIL46jZyC2AgACD5gCAAAQ1gP//m/aA
Date: Mon, 15 Jun 2020 17:11:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C290@ORSMSX115.amr.corp.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615160357.GA2531@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "Hansen, Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, David
 Woodhouse <dwmw2@infradead.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

>> The heuristic always initializes the MSR with the per mm PASID IIF the
>> mm has a valid PASID but the MSR doesn't have one. This heuristic usually
>> happens only once on the first #GP in a thread.
>
> But it doesn't guarantee the PASID is the right one. Suppose both the mm
> has a PASID and the MSR has a VALID one, but the MSR isn't the mm one.
> Then we NO-OP. So if the exception was due to us having the wrong PASID,
> we stuck.

ENQCMD only checks the 'valid' bit of the IA32_PASID MSR to decide whether
to #GP or not.  H/W has no concept of the "right" pasid value.

If IA32_PASID is valid with the wrong value ... then the system is about to
see some major corruption because the operations in the accelerator are
not going to translate to the physical addresses for pages owned by the process
that issued the ENQCMD.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
