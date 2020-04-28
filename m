Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A555C83002
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FCE2087E
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FCE2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE23B85F8D;
	Tue, 28 Apr 2020 00:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14eXn3XsfZDi; Tue, 28 Apr 2020 00:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4014085F89;
	Tue, 28 Apr 2020 00:13:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 256A4C0172;
	Tue, 28 Apr 2020 00:13:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC3D7C003B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C608622219
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:13:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDuVIfKm17On for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 00:13:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 17A11204A0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 00:13:23 +0000 (UTC)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jTDs8-0004yZ-8l; Tue, 28 Apr 2020 02:13:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id B194C100FC0; Tue, 28 Apr 2020 02:13:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <20200427201141.GA242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
 <20200427201141.GA242333@romley-ivt3.sc.intel.com>
Date: Tue, 28 Apr 2020 02:13:11 +0200
Message-ID: <87a72wpiw8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

Fenghua Yu <fenghua.yu@intel.com> writes:
> On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
>> > @@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
>> >  	int ret;
>> >  
>> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>> > +
>> > +	if (user_mode(regs) && fixup_pasid_exception()) {
>> > +		cond_local_irq_enable(regs);
>> 
>> The point of this conditional irq enable _AFTER_ calling into the fixup
>> function is? Also what's the reason for keeping interrupts disabled
>> while calling into that function? Comments exist for a reason.
>
> irq needs to be disabled because the fixup function requires to disable
> preempt in order to update the PASID MSR on the faulting CPU.

No, that's just wrong. It's not about the update itself.

> Will add comments here.

Factual ones and not some fairy tales please.

>> > +bool __fixup_pasid_exception(void)
>> > +{
>> > +	struct mm_struct *mm;
>> > +	bool ret = true;
>> > +	u64 pasid_msr;
>> > +	int pasid;
>> > +
>> > +	mm = get_task_mm(current);
>> 
>> Why do you need a reference to current->mm ?
>
> The PASID for the address space is per mm and is stored in mm.
> To get the PASID, we need to get the mm and the
> pasid=mm->context.pasid.

It's obvious that you need to access current-mm in order to check
current->mm->context.pasid. Let me rephrase the question:

   Why do you need to take a reference on current->mm ?

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
