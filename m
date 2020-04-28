Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805AC83002
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:20:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC09C2072A
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC09C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A6012262B;
	Tue, 28 Apr 2020 00:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TUUYHzjUZrP; Tue, 28 Apr 2020 00:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2FB6720336;
	Tue, 28 Apr 2020 00:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14E6BC0172;
	Tue, 28 Apr 2020 00:20:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F6EC003B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 015F7221B2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4JXyB7nRE2G for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 00:20:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A49220336
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:20:26 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jTDz0-00059c-SZ; Tue, 28 Apr 2020 02:20:19 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 56C23100FC0; Tue, 28 Apr 2020 02:20:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Luck\, Tony" <tony.luck@intel.com>, "Raj\, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F6070AA@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de> <20200427224646.GA103955@otc-nc-03>
 <3908561D78D1C84285E8C5FCA982C28F7F6070AA@ORSMSX115.amr.corp.intel.com>
Date: Tue, 28 Apr 2020 02:20:18 +0200
Message-ID: <877dy0pikd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
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

"Luck, Tony" <tony.luck@intel.com> writes:
>> Just for the record I also suggested to have a proper errorcode in the
>> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
>> instructions.
>
> Is the heuristic to avoid decoding the user instructions OK (you are just pointing
> out that you should not be given credit for this part of the idea)?

I surely suggested the approach, but at the same time I asked for the
error code and did not say that instruction checking needs to be
avoided.

This comment was just to make it clear that there were other options
discussed. IOW, the changelog should have some explicit explanations
why:

 - the error code idea does not work (according to HW folks)

 - the instruction decoding has no real benefit because $REASONS

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
