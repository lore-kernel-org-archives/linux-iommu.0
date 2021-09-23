Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D3C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:17:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A5F61214
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88A5F61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 577B940774;
	Thu, 23 Sep 2021 23:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOr9Pi0GUQLz; Thu, 23 Sep 2021 23:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2892F40770;
	Thu, 23 Sep 2021 23:17:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3E36C0011;
	Thu, 23 Sep 2021 23:17:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3E66C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9653140774
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLippLU8bb-Z for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 23:17:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF04F40770
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:17:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4706A60F6D;
 Thu, 23 Sep 2021 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632439049;
 bh=N1k2L0eFFmHdGQ+536AMWs2lheeHX41QyFl2vSXo2M4=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=t9ccl5QtUK15m/wM43BIsAOFw1IA8KViK0bOPJwMJ0S07INA8FrwGpE/ympA5WrcZ
 /kkQCkmmg15/BBLNk23jJKHgTfKQdwctzfHTKXH92UBtw6ZjxL5dkboenKN9PyIJF/
 jDrUly7SOmlwCJIOHSD6SDe9M8reFa/HdzqZd+96e3aT0AKtpkAsEw/Hoetu0UEgTW
 nzyYUc151SKns+Xh7EK+6q5xgNmdeVWPKuWdou5v2I/8RcIjKYYVjHsTODIebTbllT
 znJYkMYRk1W+Nfwff7HOOOX9itdwq67XwvQN5UUoc7fjI4xCsyVLm7pDo7LHLo4tqL
 e9GV6yXCwxrWg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailauth.nyi.internal (Postfix) with ESMTP id 66FD127C0054;
 Thu, 23 Sep 2021 19:17:27 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
 by compute6.internal (MEProxy); Thu, 23 Sep 2021 19:17:27 -0400
X-ME-Sender: <xms:BwtNYdT_m3pViJfrKjlQVTv0dFNKlR9IhBAwSuSTDFNk43TigEmOCg>
 <xme:BwtNYWyBqlMEiKUGi21Up6v3RC-5NgLRLzY9-8QMqBJovb5QS-hwvqWMZO1StpiPg
 2tbs6g2mTRL6eKSwGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
 hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
 frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
 fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
 ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
 drlhhuthhordhush
X-ME-Proxy: <xmx:BwtNYS170L4EyeRwmu28PTihQxymH_x7P58_9x_tao5ph8i12PLG7A>
 <xmx:BwtNYVBMzmU_f50ZfqHKmKlxUbeuw5IKzLPF2nC18rQzPNO4C1KJpw>
 <xmx:BwtNYWgiaqeRoN4nOCIaJsBUZPYN5gFoUg2y51rN4SVliidBgf3a-g>
 <xmx:BwtNYW43gKI79SYwJ438GRXrWzpWwA6PWkxNFl9DwXTXBq6XTe55YQuwQos>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0B5DE21E0063; Thu, 23 Sep 2021 19:17:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
In-Reply-To: <20210920192349.2602141-5-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
Date: Thu, 23 Sep 2021 16:17:05 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Fenghua Yu" <fenghua.yu@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>, "Dave Jiang" <dave.jiang@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>, "Raj Ashok" <ashok.raj@intel.com>, 
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Cc: iommu@lists.linux-foundation.org, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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



On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:
> ENQCMD requires the IA32_PASID MSR has a valid PASID value which was
> allocated to the process during bind. The MSR could be populated eagerly
> by an IPI after the PASID is allocated in bind. But the method was
> disabled in commit 9bfecd058339 ("x86/cpufeatures: Force disable
> X86_FEATURE_ENQCMD and remove update_pasid()")' due to locking and other
> issues.
>
> Since the MSR was cleared in fork()/clone(), the first ENQCMD will
> generate a #GP fault. The #GP fault handler will initialize the MSR
> if a PASID has been allocated for this process.
>
> The lazy enabling of the PASID MSR in the #GP handler is not an elegant
> solution. But it has the least complexity that fits with h/w behavior.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/fpu/api.h |  6 ++++
>  arch/x86/include/asm/iommu.h   |  2 ++
>  arch/x86/kernel/fpu/xstate.c   | 59 ++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/traps.c        | 12 +++++++
>  drivers/iommu/intel/svm.c      | 32 ++++++++++++++++++
>  5 files changed, 111 insertions(+)
>
> diff --git a/arch/x86/include/asm/fpu/api.h 
> b/arch/x86/include/asm/fpu/api.h
> index ca4d0dee1ecd..f146849e5c8c 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -106,4 +106,10 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, 
> const char **feature_name);
>   */
>  #define PASID_DISABLED	0
> 
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +void fpu__pasid_write(u32 pasid);
> +#else
> +static inline void fpu__pasid_write(u32 pasid) { }
> +#endif
> +
>  #endif /* _ASM_X86_FPU_API_H */
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index bf1ed2ddc74b..9c4bf9b0702f 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>  	return -EINVAL;
>  }
> 
> +bool __fixup_pasid_exception(void);
> +
>  #endif /* _ASM_X86_IOMMU_H */
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8def1b7f8fb..8a89b2cecd77 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1289,3 +1289,62 @@ int proc_pid_arch_status(struct seq_file *m, 
> struct pid_namespace *ns,
>  	return 0;
>  }
>  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +/**
> + * fpu__pasid_write - Write the current task's PASID state/MSR.
> + * @pasid:	the PASID
> + *
> + * The PASID is written to the IA32_PASID MSR directly if the MSR is 
> active.
> + * Otherwise it's written to the PASID. The IA32_PASID MSR should 
> contain
> + * the PASID after returning to the user.
> + *
> + * This is called only when ENQCMD is enabled.
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

Let me try to decode this.

If the current task's FPU state is live or if the state is in memory but the CPU regs just happen to match the copy in memory, then write the MSR.  Else write the value to memory.

This is wrong.  If !TIF_NEED_FPU_LOAD && fpregs_state_valid, you MUST NOT MODIFY FPU STATE.  This is not negotiable -- you will break coherence between CPU regs and the memory image.  The way you modify the current task's state is either you modify it in CPU regs (if the kernel knows that the CPU regs are the one and only source of truth) OR you modify it in memory and invalidate any preserved copies (by zapping last_cpu). 

In any event, that particular bit of logic really doesn't belong in here -- it belongs in some helper that gets it right, once.

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

IMO "has_valid_pasid" is a poor name.  An mm can have a PASID.  A task has noticed or it hasn't.

If you really need an in-memory cache, call it "pasid_msr_is_loaded".  Or just read the field out of FPU state, but that might be painfully slow.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
