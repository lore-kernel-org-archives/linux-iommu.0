Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D0C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:31:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1768D60E54
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1768D60E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D75EB84391;
	Thu, 23 Sep 2021 11:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pb9pWm0KmMFe; Thu, 23 Sep 2021 11:31:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8334281DA0;
	Thu, 23 Sep 2021 11:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59D3DC0011;
	Thu, 23 Sep 2021 11:31:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EAD7C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DFFB614A2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="mihvJjq0";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="qKlkmtb7"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BD8Pfxpc3Jlj for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 11:31:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C1D1605D9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:31:34 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632396690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODvcRdqn5ATZUTeAZX+QVSmK4LQTW4+KuKCMEOCTHnY=;
 b=mihvJjq0xBrdJF20Pl4fHXAR4ntgK2dUB5CvTkzcc13YVxoVeLCVf3EV5fxvhJMj0vtFKq
 a7dh84nwqekkbDFBEeNn2A5N8PlDdCW7HPFuaIEh2u9XTYyfrKkj6gu8h23E+QHeWUdqVZ
 nlzupnpG8TyuIQPX4G5q7XeFxiIqCOHQqKwVlZNe0aD7IxpU3cn2ythKd+v9RMyyRS3Kzv
 3TLN6dE+gFuGHOEtiUXlWV43YUfU9Yj5RsKZIPYAALrjzGNy9eTMsT3UIYhVoiy9gZxnmS
 e+Q3tY8BnfuV5zsxQynC5Ir5mIABWym5CjcoWD59NHJD9srDuxLWztN228OKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632396690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ODvcRdqn5ATZUTeAZX+QVSmK4LQTW4+KuKCMEOCTHnY=;
 b=qKlkmtb7K2F7dLV38+9K6R1qwFrPd7IEUwkXsR/I5SVdsR/NJsgge39R7HS+dyiTsmVM9a
 RjLF05CVJlBQ/4Cw==
To: Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Tony Luck <tony.luck@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Dave
 Jiang <dave.jiang@intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
In-Reply-To: <20210920192349.2602141-5-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
Date: Thu, 23 Sep 2021 13:31:29 +0200
Message-ID: <875yurh6jy.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8def1b7f8fb..8a89b2cecd77 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>  	return 0;
>  }
>  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +/**
> + * fpu__pasid_write - Write the current task's PASID state/MSR.
> + * @pasid:	the PASID
> + *
> + * The PASID is written to the IA32_PASID MSR directly if the MSR is active.
> + * Otherwise it's written to the PASID. The IA32_PASID MSR should contain

written to the PASID? What's 'the PASID' ?

> + * the PASID after returning to the user.
> + *
> + * This is called only when ENQCMD is enabled.

Well, yes, but it does not explain why it is called and from which context.

> + */
> +void fpu__pasid_write(u32 pasid)
> +{
> +	struct xregs_state *xsave = &current->thread.fpu.state.xsave;
> +	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> +	struct fpu *fpu = &current->thread.fpu;
> +
> +	/*
> +	 * ENQCMD always uses the compacted XSAVE format. Ensure the buffer
> +	 * has space for the PASID.
> +	 */
> +	BUG_ON(!(xsave->header.xcomp_bv & XFEATURE_MASK_PASID));
> +
> +	fpregs_lock();
> +
> +	/*
> +	 * If the task's FPU doesn't need to be loaded or is valid, directly
> +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
> +	 * the MSR will be loaded from the PASID state before returning to
> +	 * the user.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
> +	    fpregs_state_valid(fpu, smp_processor_id())) {
> +		wrmsrl(MSR_IA32_PASID, msr_val);
> +	} else {
> +		struct ia32_pasid_state *ppasid_state;
> +		/*
> +		 * Mark XFEATURE_PASID as non-init in the XSAVE buffer.
> +		 * This ensures that a subsequent XRSTOR will see the new
> +		 * value instead of writing the init value to the MSR.
> +		 */

This and the above wrmsrl() assume that @pasid is valid which might be
correct, but I don't see any information about pasid lifetime. I assume
that there is no way to drop a PASID, right?

> +		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
> +		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
> +		/*
> +		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
> +		 * was set just now.
> +		 *
> +		 * Please note that the following operation is a "write only"
> +		 * operation on the PASID state and it writes the *ENTIRE*
> +		 * state component. Please don't blindly copy this code to
> +		 * modify other XSAVE states.
> +		 */
> +		ppasid_state->pasid = msr_val;
> +	}
> +
> +	fpregs_unlock();
> +}
> +#endif /* CONFIG_INTEL_IOMMU_SVM */

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a25d738ae839 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
>  
> +static bool fixup_pasid_exception(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +	return __fixup_pasid_exception();
> +}

Ok, so here is the hook into #GP which then calls out into:

> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1179,3 +1179,35 @@ int intel_svm_page_response(struct device *dev,
>  	mutex_unlock(&pasid_mutex);
>  	return ret;
>  }
> +
> +/*
> + * Try to figure out if there is a PASID MSR value to propagate to the
> + * thread taking the #GP.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +	u32 pasid;
> +
> +	/*
> +	 * This function is called only when this #GP was triggered from user
> +	 * space. So the mm cannot be NULL.
> +	 */
> +	pasid = current->mm->pasid;
> +
> +	/* If no PASID is allocated, there is nothing to propagate. */
> +	if (pasid == PASID_DISABLED)
> +		return false;
> +
> +	/*
> +	 * If the current task already has a valid PASID MSR, then the #GP
> +	 * fault must be for some non-ENQCMD related reason.
> +	 */
> +	if (current->has_valid_pasid)
> +		return false;
> +
> +	/* Fix up the MSR by the PASID in the mm. */
> +	fpu__pasid_write(pasid);
> +	current->has_valid_pasid = 1;
> +
> +	return true;
> +}

What is INTEL SVM specific on this? Nothing at all.

If there is a valid PASID in current->mm and the MSR has not been
updated yet, write it. Otherwise bail.

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
