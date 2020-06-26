Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517BC433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 01:47:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6FB2081A
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 01:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6FB2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AFADF87D36;
	Fri, 26 Jun 2020 01:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mTsSVFgjJzpX; Fri, 26 Jun 2020 01:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9803887D99;
	Fri, 26 Jun 2020 01:47:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81997C0863;
	Fri, 26 Jun 2020 01:47:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A123CC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 82D7920416
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQg1K9mUT2UJ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 01:47:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 75E3A203AE
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:47:21 +0000 (UTC)
IronPort-SDR: PwLQxI/fdTdFb54onELu5JYyzLsOEE782krfmRLk6TyKBdl++cFvfnUMEftCMnf/oVdm+IEaD5
 RHt3tJA5aOug==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144238678"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; d="scan'208";a="144238678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 18:47:20 -0700
IronPort-SDR: QkbeGJYjarT9/nRx/tv4Z/bREXs9OPm8HkllLMmOoVh97LamZ2CdC67cXJWP5+T4+JzesCF75z
 CqmUaHV5OjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; d="scan'208";a="385637678"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.172.117])
 ([10.249.172.117])
 by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2020 18:47:16 -0700
Subject: Re: [PATCH v4 12/12] x86/traps: Fix up invalid PASID
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 H Peter Anvin <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, Tony Luck <tony.luck@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@infradeed.org>, Ashok Raj <ashok.raj@intel.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f8b020a6-827c-cb36-b148-8c6015d5e4df@linux.intel.com>
Date: Fri, 26 Jun 2020 09:46:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Fenghua,

On 2020/6/26 4:17, Fenghua Yu wrote:
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in the current thread's PASID MSR. The
> #GP fault handler will initialize the MSR if a PASID has been allocated
> for this process.
> 
> Decoding the user instruction is ugly and sets a bad architecture
> precedent. It may not function if the faulting instruction is modified
> after #GP.
> 
> Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
> without a valid PASID value programmed. #GP error codes are 16 bits and all
> 16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
> choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
> when loading from the source operand, so its not fully comprehending all
> the reasons. Rather than special case the ENQCMD, in future Intel may
> choose a different fault mechanism for such cases if recovery is needed on
> #GP.
> 
> The following heuristic is used to avoid decoding the user instructions
> to determine the precise reason for the #GP fault:
> 1) If the mm for the process has not been allocated a PASID, this #GP
>     cannot be fixed.
> 2) If the PASID MSR is already initialized, then the #GP was for some
>     other reason
> 3) Try initializing the PASID MSR and returning. If the #GP was from
>     an ENQCMD this will fix it. If not, the #GP fault will be repeated
>     and will hit case "2".

For changes in Intel VT-d driver,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v4:
> - Change PASID type to u32 (Christoph)
> 
> v3:
> - Check and set current->has_valid_pasid in fixup() (PeterZ)
> - Add fpu__pasid_write() to update the MSR (PeterZ)
> - Add ioasid_find() sanity check in fixup()
> 
> v2:
> - Update the first paragraph of the commit message (Thomas)
> - Add reasons why don't decode the user instruction and don't use
>    #GP error code (Thomas)
> - Change get_task_mm() to current->mm (Thomas)
> - Add comments on why IRQ is disabled during PASID fixup (Thomas)
> - Add comment in fixup() that the function is called when #GP is from
>    user (so mm is not NULL) (Dave Hansen)
> 
>   arch/x86/include/asm/iommu.h |  1 +
>   arch/x86/kernel/traps.c      | 14 +++++++
>   drivers/iommu/intel/svm.c    | 78 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 93 insertions(+)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index ed41259fe7ac..e9365a5d6f7d 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -27,5 +27,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>   }
>   
>   void __free_pasid(struct mm_struct *mm);
> +bool __fixup_pasid_exception(void);
>   
>   #endif /* _ASM_X86_IOMMU_H */
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index f9727b96961f..2352f3f1f7ed 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -59,6 +59,7 @@
>   #include <asm/umip.h>
>   #include <asm/insn.h>
>   #include <asm/insn-eval.h>
> +#include <asm/iommu.h>
>   
>   #ifdef CONFIG_X86_64
>   #include <asm/x86_init.h>
> @@ -514,6 +515,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>   	return GP_CANONICAL;
>   }
>   
> +static bool fixup_pasid_exception(void)
> +{
> +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> +		return false;
> +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +	return __fixup_pasid_exception();
> +}
> +
>   #define GPFSTR "general protection fault"
>   
>   DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> @@ -526,6 +537,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>   
>   	cond_local_irq_enable(regs);
>   
> +	if (user_mode(regs) && fixup_pasid_exception())
> +		goto exit;
> +
>   	if (static_cpu_has(X86_FEATURE_UMIP)) {
>   		if (user_mode(regs) && fixup_umip_exception(regs))
>   			goto exit;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 4c788880b037..4a84c82a4f8c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1105,3 +1105,81 @@ void __free_pasid(struct mm_struct *mm)
>   	 */
>   	ioasid_free(pasid);
>   }
> +
> +/*
> + * Write the current task's PASID MSR/state. This is called only when PASID
> + * is enabled.
> + */
> +static void fpu__pasid_write(u32 pasid)
> +{
> +	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> +
> +	fpregs_lock();
> +
> +	/*
> +	 * If the MSR is active and owned by the current task's FPU, it can
> +	 * be directly written.
> +	 *
> +	 * Otherwise, write the fpstate.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		wrmsrl(MSR_IA32_PASID, msr_val);
> +	} else {
> +		struct ia32_pasid_state *ppasid_state;
> +
> +		ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> +					      XFEATURE_PASID);
> +		/*
> +		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
> +		 * is enabled.
> +		 */
> +		WARN_ON_ONCE(!ppasid_state);
> +		ppasid_state->pasid = msr_val;
> +	}
> +	fpregs_unlock();
> +}
> +
> +/*
> + * Apply some heuristics to see if the #GP fault was caused by a thread
> + * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
> + * is the problem, try initializing the IA32_PASID MSR. If the heuristic
> + * guesses incorrectly, take one more #GP fault.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +	struct intel_svm *svm;
> +	struct mm_struct *mm;
> +	u32 pasid;
> +
> +	/*
> +	 * If the current task already has a valid PASID in the MSR,
> +	 * the #GP must be for some other reason.
> +	 */
> +	if (current->has_valid_pasid)
> +		return false;
> +
> +	/*
> +	 * This function is called only when this #GP was triggered from user
> +	 * space. So the mm cannot be NULL.
> +	 */
> +	mm = current->mm;
> +	pasid = mm->pasid;
> +
> +	/*
> +	 * If the PASID isn't found, cannot help.
> +	 *
> +	 * Don't care if the PASID is bound to the mm here. #PF will handle the
> +	 * case that the MSR is fixed up by an unbound PASID.
> +	 */
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR_OR_NULL(svm))
> +		return false;
> +
> +	/* Fix up the MSR by the PASID in the mm. */
> +	fpu__pasid_write(pasid);
> +
> +	/* Now the current task has a valid PASID in the MSR. */
> +	current->has_valid_pasid = 1;
> +
> +	return true;
> +}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
