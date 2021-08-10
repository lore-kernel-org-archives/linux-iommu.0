Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB052C4320A
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 11:04:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C73960F25
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 11:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C73960F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B16140486;
	Tue, 10 Aug 2021 11:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2syPx9oHdEr; Tue, 10 Aug 2021 11:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4DC340435;
	Tue, 10 Aug 2021 11:04:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A981BC001A;
	Tue, 10 Aug 2021 11:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70CCBC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 11:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59D23402A8
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 11:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQuAzMw6rppu for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 11:04:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F48D402A3
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 11:04:03 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id u15so12743486wmj.1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h9AyImD9UvKdyZgMt8rSQ3Uk0c9+Og7qG6N7oOE6PXA=;
 b=r/Jad4T0ZVJnfuwXsl/SNuEXYPHwt4mc2p+uC2fUYQiR300ci0a25mpWqbSQbfIH02
 WKwqpHWrPfXCcThsRncsJFXSZYr63TSwT+wmJ0Pd0ELEsqaI67/AltiBG/v4CwdW1utg
 KA4uWYSHtmhUs8Ny8A+R8DuqqJc/rID1JgIFMILHm8VOrq5ouQFTl71ZluTex4bV6DQp
 eRuYkLDspi1/n2lWFDx0VeW2NQiujG13fNNMZ9hB9iqPsPOyUycwx8FSMoqvxVifEYHX
 b5EfRx+zlgE0yakA0I3u9abQCAGDoE6l6hPvAJlzEayARJClkXHmTyo0Q8Lwazxb1d0F
 My8w==
X-Gm-Message-State: AOAM531xVO8H0GT3uTlHtbiicMVkm6gVIRNcNAybfKtpNzIXFyijhxxg
 yDhyUDDAW2a10fybDjKchZU=
X-Google-Smtp-Source: ABdhPJyrk1wBfHB9MekkHvpHW9x6fYmFebxaC/tx0zZS+XISdOGMjx9hLm+CPvA9MFZ9+dQ3n/YQhA==
X-Received: by 2002:a05:600c:3798:: with SMTP id
 o24mr4061437wmr.18.1628593441621; 
 Tue, 10 Aug 2021 04:04:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id q3sm3504575wmf.37.2021.08.10.04.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 04:04:01 -0700 (PDT)
Date: Tue, 10 Aug 2021 11:03:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 03/13] x86/HV: Add new hvcall guest address host
 visibility support
Message-ID: <20210810110359.i4qodw7h36zrsicp@liuwe-devbox-debian-v2>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-4-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210809175620.720923-4-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 tj@kernel.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
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

On Mon, Aug 09, 2021 at 01:56:07PM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Add new hvcall guest address host visibility support to mark
> memory visible to host. Call it inside set_memory_decrypted
> /encrypted(). Add HYPERVISOR feature check in the
> hv_is_isolation_supported() to optimize in non-virtualization
> environment.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v2:
>        * Rework __set_memory_enc_dec() and call Hyper-V and AMD function
>          according to platform check.
> 
> Change since v1:
>        * Use new staic call x86_set_memory_enc to avoid add Hyper-V
>          specific check in the set_memory code.
> ---
>  arch/x86/hyperv/Makefile           |   2 +-
>  arch/x86/hyperv/hv_init.c          |   6 ++
>  arch/x86/hyperv/ivm.c              | 114 +++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  20 +++++
>  arch/x86/include/asm/mshyperv.h    |   4 +-
>  arch/x86/mm/pat/set_memory.c       |  19 +++--
>  include/asm-generic/hyperv-tlfs.h  |   1 +
>  include/asm-generic/mshyperv.h     |   1 +
>  8 files changed, 160 insertions(+), 7 deletions(-)
>  create mode 100644 arch/x86/hyperv/ivm.c
> 
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 48e2c51464e8..5d2de10809ae 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y			:= hv_init.o mmu.o nested.o irqdomain.o
> +obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
>  obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
>  
>  ifdef CONFIG_X86_64
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0bb4d9ca7a55..b3683083208a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -607,6 +607,12 @@ EXPORT_SYMBOL_GPL(hv_get_isolation_type);
>  
>  bool hv_is_isolation_supported(void)
>  {
> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +		return 0;

Nit: false instead of 0.

> +
> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		return 0;
> +
>  	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
>  }
>  
[...]
> +int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
> +			   enum hv_mem_host_visibility visibility)
> +{
> +	struct hv_gpa_range_for_visibility **input_pcpu, *input;
> +	u16 pages_processed;
> +	u64 hv_status;
> +	unsigned long flags;
> +
> +	/* no-op if partition isolation is not enabled */
> +	if (!hv_is_isolation_supported())
> +		return 0;
> +
> +	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
> +		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
> +			HV_MAX_MODIFY_GPA_REP_COUNT);
> +		return -EINVAL;
> +	}
> +
> +	local_irq_save(flags);
> +	input_pcpu = (struct hv_gpa_range_for_visibility **)
> +			this_cpu_ptr(hyperv_pcpu_input_arg);
> +	input = *input_pcpu;
> +	if (unlikely(!input)) {
> +		local_irq_restore(flags);
> +		return -EINVAL;
> +	}
> +
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	input->host_visibility = visibility;
> +	input->reserved0 = 0;
> +	input->reserved1 = 0;
> +	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
> +	hv_status = hv_do_rep_hypercall(
> +			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
> +			0, input, &pages_processed);
> +	local_irq_restore(flags);
> +
> +	if (!(hv_status & HV_HYPERCALL_RESULT_MASK))
> +		return 0;
> +
> +	return hv_status & HV_HYPERCALL_RESULT_MASK;

Joseph introduced a few helper functions in 753ed9c95c37d. They will
make the code simpler.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
