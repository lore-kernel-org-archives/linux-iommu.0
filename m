Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E666C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:47:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23C061503
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E23C061503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0B2B4071F;
	Wed, 29 Sep 2021 17:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PF1jG2J88ZCj; Wed, 29 Sep 2021 17:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53003406F9;
	Wed, 29 Sep 2021 17:47:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F0EDC0011;
	Wed, 29 Sep 2021 17:47:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC3F3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EF2B421F8
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgrn2GleBweM for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 17:47:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B8DA4218B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:47:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8312F6135E;
 Wed, 29 Sep 2021 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632937640;
 bh=jEX9WfFfE7uc4opv3Isth3zecI1A32dpxFg6mdU08xM=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=LM1gtvuF6QTPazoRV7AFt66j4gUjzHljkibHjf3/NEsFv2QZO9rjpxZGFe8/KAHD0
 riqHZLqqhJBcxYwr/VtdhRf5/H3W3qudXW+X1DfIR0wWVaYYaknxCnJRrYta4OSVFB
 EN0/wmE5CKyEHSKXmsREeDVezXzvHOuO+0MxFddJ51/+FBzyaDzys0EbVTvyMjn010
 TTCf1YJNsh7cmLlhe7AbaDDTsgqQFs1v7bMoshfxq26wI/iUMTWFAPqYCm3slv2Ojr
 cRSgHKh5aEDvQu4yD/pdxIZtUpJQaaSUypxgrbKJCdMyqAAKZalvvMuKBZT1FaaAcL
 +kXeAY7LxnvUA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id A0D8C27C0054;
 Wed, 29 Sep 2021 13:47:18 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Wed, 29 Sep 2021 13:47:18 -0400
X-ME-Sender: <xms:pqZUYejQq3gPSyw60Yb6EXfyWSApJf73Clf4YaPdF0O9ZDMh0IQgfw>
 <xme:pqZUYfB-rsxB-LzxzBvGaf2LAHgcozjNssTqFr4ckRLsXzPJLZGY3ZpGjwwsNSRRm
 Ub90KIr4QbCP_i-918>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekvddgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
 ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
 ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
 gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
 heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
 igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:pqZUYWEE-AhDha05eaxaCucivujcLnogeX3M-cOELrqzepcAL5T_xg>
 <xmx:pqZUYXRv2BG77WVKZqkHOjxw3-UzZNNQi8_2kxtVFsmQm6oDkI3hbw>
 <xmx:pqZUYbxwfaBvZ9yIQzQ8bUGxABvUdzbFPrdKS173fdDkftAbCMcazg>
 <xmx:pqZUYQKkcO3DxN1t_FdsEnYX4oeWKIQT27zLDIgLBSZvLs46YP0QtOZm6W8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6E53E21E0063; Wed, 29 Sep 2021 13:47:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <fe65a413-44c0-46c3-856f-ed4e554066f6@www.fastmail.com>
In-Reply-To: <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
References: <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org> <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
Date: Wed, 29 Sep 2021 10:46:58 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
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



On Wed, Sep 29, 2021, at 10:41 AM, Luck, Tony wrote:
> On Wed, Sep 29, 2021 at 07:15:53PM +0200, Thomas Gleixner wrote:
>> On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
>> > On 9/29/21 05:28, Thomas Gleixner wrote:
>> >> Looking at that patch again, none of this muck in fpu__pasid_write() is
>> >> required at all. The whole exception fixup is:
>> >> 
>> >>      if (!user_mode(regs))
>> >>               return false;
>> >> 
>> >>      if (!current->mm->pasid)
>> >>               return false;
>> >> 
>> >>      if (current->pasid_activated)
>> >>      	     return false;
>> >
>> > <-- preemption or BH here: kaboom.
>> 
>> Sigh, this had obviously to run in the early portion of #GP, i.e. before
>> enabling interrupts.
>
> Like this? Obviously with some comment about why this is being done.
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a848a59291e7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -536,6 +536,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
> 
> +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {
> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> +		return;
> +	}
> +

This could do with a WARN_ON_ONCE(TIF_NEED_LOAD_FPU) imo.

Is instrumentation allowed to touch FPU state?

>  	cond_local_irq_enable(regs);
> 
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
>
> -Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
