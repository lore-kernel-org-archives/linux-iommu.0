Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9811C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:16:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B80A61052
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B80A61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 050D54158A;
	Wed, 29 Sep 2021 17:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id quCsVMwp_azT; Wed, 29 Sep 2021 17:16:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D930C406A6;
	Wed, 29 Sep 2021 17:16:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BE3BC0011;
	Wed, 29 Sep 2021 17:16:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A44B6C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A516406A6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZjNRfDo4qICN for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 17:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B183F414B9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:15:57 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632935754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWWcnqFRj6zAdMYEtH1XJ/oTMuUhVW1AUdTmaVur7iM=;
 b=I+VUN/NO1vuxg+Pjaj8NRFrhYq8XGcu1jaIKvk85LuwNRoAx/Coz54CjHgN3arWWAj3bNg
 +GjgtYsxpX+j8gP3aNjsx16XhaDNcCEdikGgs87YD4sMWRm4V/mjNkOZry8//CVn1gp2zJ
 wEbK1WfQmideZAl0wwjvCcf/JMa1dtnF+TJc/mWR7+u8mDadL9shQ8EfosbIMFv5J+Tuye
 rmn5G44VX+ujVE7tjF5yY3PkKVBFpK2sBdh1NEMDZEuClioQsr0xtrXRExLZRN13IDWN4D
 nrpi/DSXSNZEI0nUQcARd1/FnAz+ZbmpTbmhEu+0Xmu3oZTxrLHC2bn/gNhjaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632935754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWWcnqFRj6zAdMYEtH1XJ/oTMuUhVW1AUdTmaVur7iM=;
 b=bQbMHfGUYpufXmcUgOg7LH/S9ywiZ5cAMhdRpm4DuazNhhpeW0HP/J4ta6RZJtsEj/+oHg
 PICI3Mv2scapi+CQ==
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
Date: Wed, 29 Sep 2021 19:15:53 +0200
Message-ID: <877dez8fqu.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
> On 9/29/21 05:28, Thomas Gleixner wrote:
>> Looking at that patch again, none of this muck in fpu__pasid_write() is
>> required at all. The whole exception fixup is:
>> 
>>      if (!user_mode(regs))
>>               return false;
>> 
>>      if (!current->mm->pasid)
>>               return false;
>> 
>>      if (current->pasid_activated)
>>      	     return false;
>
> <-- preemption or BH here: kaboom.

Sigh, this had obviously to run in the early portion of #GP, i.e. before
enabling interrupts.

For me that's more than obvious and I apologize that I failed to mention
it.

>> 
>>      wrmsrl(MSR_IA32_PASID, current->mm->pasid);
>
> This needs the actual sane fpstate writing helper -- see other email.

And with that there is no fpstate write helper required at all.

Stop this overengineering madness already.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
