Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E24C43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 11:18:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66E4216C4
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ChwnxHd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66E4216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 488C82049C;
	Mon,  7 Sep 2020 11:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlbouqUEJwjP; Mon,  7 Sep 2020 11:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D7D73203F6;
	Mon,  7 Sep 2020 11:18:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C543FC0859;
	Mon,  7 Sep 2020 11:18:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4308EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 319F48670C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFNNySR-DZbf for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:18:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 93F04857A4
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 11:18:45 +0000 (UTC)
Received: from zn.tnic (p200300ec2f09090030eade31917bbe1c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f09:900:30ea:de31:917b:be1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3EF41EC0445;
 Mon,  7 Sep 2020 13:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1599477524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=IchRjOSRh+sRDrPo1JFsixmldHqDwOcJjES6CFnvA5o=;
 b=ChwnxHd8s84v/14/oxkZicv5CUVrwHYkZQqm7A5eHOdZS+/YBR9hlSCzhpTd2C/ZnVgQcH
 1gpukxVDisQlkBvU1SgGgTMooIysBYw8sw3khE5ZZHvz7eHDqO+1FObcRba/0VuTJMavQP
 8r8jOLU4hse5MHrYPwdI2OrHXjLt0rU=
Date: Mon, 7 Sep 2020 13:18:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200907111843.GC16029@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
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

On Thu, Aug 27, 2020 at 08:06:34AM -0700, Fenghua Yu wrote:
> A PASID is allocated for an "mm" the first time any thread binds
> to an SVM capable device and is freed from the "mm" when the SVM is
> unbound by the last thread. It's possible for the "mm" to have different
> PASID values in different binding/unbinding SVM cycles.
> 
> The mm's PASID (non-zero for valid PASID or 0 for invalid PASID) is
> propagated to per-thread PASID MSR for all threads within the mm through
> through IPI, context switch, or inherit to ensure a running thread has
> the right PASID MSR matching the mm's PASID.

That sentence has grown too large and confused. Pls fix.

> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v7:
> - Don't fix up PASID in #GP. Instead, update the PASID MSR by IPI and
>   context switch after PASID allocation and free. Inherit PASID from
>   parent. (Andy)
> 
> Before v7:
> - Allocate a PASID for the mm and free it until mm exit.
> 
>  arch/x86/include/asm/disabled-features.h |  2 +-
>  arch/x86/include/asm/fpu/api.h           | 12 +++++
>  arch/x86/include/asm/fpu/internal.h      |  2 +
>  arch/x86/kernel/fpu/xstate.c             | 56 ++++++++++++++++++++++++
>  drivers/iommu/intel/svm.c                | 28 +++++++++++-
>  5 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index 588d83e9da49..5861d34f9771 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -56,7 +56,7 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> +#ifdef CONFIG_IOMMU_SUPPORT
>  # define DISABLE_ENQCMD	0
>  #else
>  # define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))

That hunk belongs with the previous patch.

> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index b774c52e5411..dcd9503b1098 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -62,4 +62,16 @@ extern void switch_fpu_return(void);
>   */
>  extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
>  
> +/*
> + * Tasks that are not using SVA have mm->pasid set to zero to note that they
> + * will not have the valid bit set in MSR_IA32_PASID while they are running.
> + */
> +#define PASID_DISABLED	0
> +
> +#ifdef CONFIG_IOMMU_SUPPORT
> +/* Update current's PASID MSR/state by mm's PASID. */
> +void update_pasid(void);
> +#else
> +static inline void update_pasid(void) { }
> +#endif
>  #endif /* _ASM_X86_FPU_API_H */
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 0a460f2a3f90..2d737e02b59a 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -583,6 +583,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
>  			pkru_val = pk->pkru;
>  	}
>  	__write_pkru(pkru_val);
> +
> +	update_pasid();
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 67f1a03b9b23..556040e14f1c 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1402,3 +1402,59 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>  	return 0;
>  }
>  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> +
> +#ifdef CONFIG_IOMMU_SUPPORT
> +void update_pasid(void)
> +{
> +	u64 pasid_state;
> +	u32 pasid;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return;
> +
> +	if (!current->mm)
> +		return;
> +
> +	pasid = READ_ONCE(current->mm->pasid);
> +	/* Set the valid bit in the PASID MSR/state only for valid pasid. */
> +	pasid_state = pasid == PASID_DISABLED ?
> +		      pasid : pasid | MSR_IA32_PASID_VALID;
> +
> +	/*
> +	 * No need to hold fregs_lock() since the task's fpstate won't
> +	 * be changed by others (e.g. ptrace) while the task is being
> +	 * switched to or is in IPI.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		/* The MSR is active and can be directly updated. */
> +		wrmsrl(MSR_IA32_PASID, pasid_state);
> +	} else {
> +		struct fpu *fpu = &current->thread.fpu;
> +		struct ia32_pasid_state *ppasid_state;
> +		struct xregs_state *xsave;
> +
> +		/*
> +		 * The CPU's xstate registers are not currently active. Just
> +		 * update the PASID state in the memory buffer here. The
> +		 * PASID MSR will be loaded when returning to user mode.
> +		 */
> +		xsave = &fpu->state.xsave;
> +		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
> +		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
> +		if (ppasid_state) {
> +			/*
> +			 * Only update the task's PASID state when it's
> +			 * different from the mm's pasid.
> +			 */
> +			if (ppasid_state->pasid != pasid_state) {
> +				/*
> +				 * Invalid fpregs so that xrstors will pick up
							  ^^^^^^^

Not "xrstors" but the "state restoring" or so.


> +				 * the PASID state.
> +				 */
> +				__fpu_invalidate_fpregs_state(fpu);
> +				ppasid_state->pasid = pasid_state;
> +			}

What happens if get_xsave_addr() returns NULL? A WARN_ONCE maybe?

Ok, done with review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
