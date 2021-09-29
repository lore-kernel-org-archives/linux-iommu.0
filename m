Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0684C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 20:07:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D594617E6
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D594617E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DD284010A;
	Wed, 29 Sep 2021 20:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nm2TMLZj5SBM; Wed, 29 Sep 2021 20:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A9F940730;
	Wed, 29 Sep 2021 20:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4C5FC000F;
	Wed, 29 Sep 2021 20:07:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5FFAC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 20:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEBFC606F6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 20:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="gvDSGy6E";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="icQDdrkt"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7OkTy-dCEUg for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 20:07:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E94760750
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 20:07:08 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632946025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlsVknWTVdSlZTHHBhOHbdQ8+OQgty9cJuZLKmK8P4Q=;
 b=gvDSGy6EoQ/SGIQIZFDmJHsfEB7eJkkPqMOISO+qHnFj07TZ3W58Un23BsrO2SJOP5oI/M
 aJO6guQUBAH8/Bk3qH6nN/ewix1KG2QJPceX0aA6/YB23G/6szPYeahrHYodGiUTa4sJw3
 /FZWsXw6mEh7VhBM6VWjUtpfmJ1MyBQ8gH/Kr4jh+xX9i1jTFxiEtMvT5ITfqV2Zdl2iut
 hDO+T4lF0i5fNNlgiuPwCsI0IT4sX4rI8ZFOy5cT5/HIqRV+vFvuNtSUEuzm/YJTXjGs+b
 b7pZjQr/eDgA9a/2lygRLPEDQUzWaXs9+DASg2sA1gUEIKFp2AwCtM3qayMPgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632946025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlsVknWTVdSlZTHHBhOHbdQ8+OQgty9cJuZLKmK8P4Q=;
 b=icQDdrktOulCIkwKp/cwu1bpceb+vYu4ltjmHgN1zZFbMrIXdWbqAISaG/oKDVP8Nru7Uq
 HTEWYV63v6AU54Cg==
To: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
References: <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org> <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
 <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
 <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
Date: Wed, 29 Sep 2021 22:07:04 +0200
Message-ID: <874ka387tj.ffs@tglx>
MIME-Version: 1.0
Cc: "Shankar, Ravi
 V" <ravi.v.shankar@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Sep 29 2021 at 11:31, Tony Luck wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..5a3c87fd65de 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -528,6 +528,32 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> +/*
> + * When a user executes the ENQCMD instruction it will #GP
> + * fault if the IA32_PASID MSR has not been set up with a
> + * valid PASID.
> + * So if the process has been allocated a PASID (mm->pasid)
> + * AND the IA32_PASID MSR has not been initialized, try to
> + * fix this #GP by initializing the IA32_PASID MSR.
> + * If the #GP was for some other reason, it will trigger
> + * again, but this routine will return false and the #GP
> + * will be processed.
> + */
> +static void try_fixup_pasid(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +#ifdef CONFIG_IOMMU_SUPPORT
> +	if (current->mm->pasid && !current->pasid_activated) {
> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid);
> +		return true;
> +	}
> +#endif
> +	return false;
> +}
> +
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> @@ -536,6 +562,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
>  
> +	if (user_mode(regs) && try_fixup_pasid())
> +		return;
> +
>  	cond_local_irq_enable(regs);
>  
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {

Amen.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
