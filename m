Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72DFC83001
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932372070B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932372070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6530E87DBA;
	Tue, 28 Apr 2020 00:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqiAEHNn+V8P; Tue, 28 Apr 2020 00:55:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 846A487D9E;
	Tue, 28 Apr 2020 00:55:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D7CBC0172;
	Tue, 28 Apr 2020 00:55:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B868C003B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5460D85F98
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcrAv7cTNKBB for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 00:55:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA45E85E0B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:55:12 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jTEWa-0005tv-2h; Tue, 28 Apr 2020 02:55:00 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 45FC7100FC0; Tue, 28 Apr 2020 02:54:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Raj\, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <20200427224646.GA103955@otc-nc-03>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de> <20200427224646.GA103955@otc-nc-03>
Date: Tue, 28 Apr 2020 02:54:59 +0200
Message-ID: <874kt4pgyk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
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

Ashok,

"Raj, Ashok" <ashok.raj@intel.com> writes:
> On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
>> Just for the record I also suggested to have a proper errorcode in the
>> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
>> instructions.
>
> We certainly discussed the possiblity of adding an error code to 
> identiy #GP due to ENQCMD with our HW architects. 
>
> There are only a few cases that have an error code, like move to segment
> with an invalid value for instance. There were a few but i don't
> recall that entire list. 
>
> Since the error code is 0 in most places, there isn't plumbing in hw to return
> this value in all cases. It appeared that due to some uarch reasons it
> wasn't as simple as it appears to /me sw kinds :-)

Sigh.

> So after some internal discussion we decided to take the current
> approach. Its possible that if the #GP was due to some other reason
> we might #GP another time. Since this wasn't perf or speed path we took
> this lazy approach.

I know that the HW people's mantra is that everything can be fixed in
software and therefore slapping new features into the CPUs can be done
without thinking about the consequeses.

But we all know from painful experience that this is fundamentally wrong
unless there is a really compelling reason.

For new features there is absolutely no reason at all.

Can HW people pretty please understand that hardware and software have
to be co-designed and not dictated by 'some uarch reasons'. This is
nothing fundamentally new. This problem existed 30+ years ago, is well
documented and has been ignored forever. I'm tired of that, really.

But as this seems to be unsolvable for the problem at hand can you
please document the inability, unwillingness or whatever in the
changelog?

The question why this brand new_ ENQCMD + invalid PASID induced #GP does
not generate an useful error code and needs heuristics to be dealt with
is pretty obvious.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
