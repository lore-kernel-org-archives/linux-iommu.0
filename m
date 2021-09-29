Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB7C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:51:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D061440
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D0D061440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D75C8400E7;
	Wed, 29 Sep 2021 16:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MDTgGLT5H-L; Wed, 29 Sep 2021 16:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9309C40723;
	Wed, 29 Sep 2021 16:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67AFEC000F;
	Wed, 29 Sep 2021 16:51:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5883BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DFDA60762
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VCmJvR1QTwuB for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 16:51:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DC84606DE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:51:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221783162"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="221783162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 09:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="476702306"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga007.jf.intel.com with ESMTP; 29 Sep 2021 09:51:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 09:51:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 09:51:15 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 29 Sep 2021 09:51:15 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Subject: RE: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Thread-Topic: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Thread-Index: AQHXrlppKq1JNDzwUU2jIMumR+OY2auyKYcA//+tUICAAIgmgIABRuYA//+7QwCAAOhhgIAG/wKAgAArB4D//9OUcA==
Date: Wed, 29 Sep 2021 16:51:15 +0000
Message-ID: <57d0e4efcf2d4e9abb91801520a3f386@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
In-Reply-To: <87r1d78t2e.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, the
 arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Pan, 
 Jacob jun" <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>
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

> There is zero requirement to look at TIF_NEED_FPU_LOAD or
> fpregs_state_valid() simply because the #GP comes straight from user
> space which means the FPU registers contain the current tasks user space
> state.

Just to double confirm ... there is no point in the #GP handler up to this point
where pre-emption can occur?

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
