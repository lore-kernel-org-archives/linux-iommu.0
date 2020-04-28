Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C845C8300B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734D12072A
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734D12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AD45868E7;
	Tue, 28 Apr 2020 20:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32aGwkv59HJG; Tue, 28 Apr 2020 20:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A100F862CA;
	Tue, 28 Apr 2020 20:59:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87650C088E;
	Tue, 28 Apr 2020 20:59:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95B80C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8535F876C2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IStXPNlU2Xt1 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 20:59:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7D62876B6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 20:59:48 +0000 (UTC)
IronPort-SDR: M1buybIOTey+BmXCcyoV6FvripQSnz5Bq8kax0EZDM3NLQ+BW0u/0KmviQcEupcxJSSbB9rrtI
 AOMvmPzOElUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 13:59:45 -0700
IronPort-SDR: +Q8PjyVutkue3EcjsUEaFZlOavwMvvK+V+3ei0OrSYFlhTsGbOvqnexFpbIZZpuVkMvs1zSr4N
 AbzGg5ky6H6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="246628978"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga007.jf.intel.com with ESMTP; 28 Apr 2020 13:59:44 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 13:59:44 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 13:59:44 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Topic: [PATCH 5/7] x86/mmu: Allocate/free PASID
Thread-Index: AQHWBtMgRqn1rM/ldEi9589O6eqhDKiMHSGAgANeKoCAAAkqgP//jPrQgACRMQD//44esA==
Date: Tue, 28 Apr 2020 20:59:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F608EE2@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
 <87pnbus3du.fsf@nanos.tec.linutronix.de>	<20200428112113.000033bd@intel.com>
 <87tv13o306.fsf@nanos.tec.linutronix.de>
 <3908561D78D1C84285E8C5FCA982C28F7F608BE9@ORSMSX115.amr.corp.intel.com>
 <20200428134200.000010f7@intel.com>
In-Reply-To: <20200428134200.000010f7@intel.com>
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

>> So the driver needs to use flush/drain operations to make sure all
>> the in-flight work has completed before releasing/re-using the PASID.
>> 
> Are you suggesting we should let driver also hold a reference of the
> PASID?

The sequence for bare metal is:

	process is queuing requests to DSA
	process exits (either deliberately, or crashes, or is killed)
	kernel does exit processing
	DSA driver is called as part of tear down of "mm"
		issues drain/flush commands to ensure that all
		queued operations on the PASID for this mm have
		completed
	PASID can be freed

There's a 1:1 map from "mm" to PASID ... so reference counting seems
like overkill. Once the kernel is in the "exit" path, we know that no more
work can be queued using this PASID.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
