Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57883C432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:42:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FAA60FC4
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18FAA60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA7783AC9;
	Fri, 27 Aug 2021 17:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8F-ae_rXRXKL; Fri, 27 Aug 2021 17:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B9E3B83B2B;
	Fri, 27 Aug 2021 17:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9172EC001A;
	Fri, 27 Aug 2021 17:42:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6309C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A15554279D
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZi3G8zDFuIS for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:41:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2A544279B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:41:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7637B60EE4;
 Fri, 27 Aug 2021 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1630086115;
 bh=ZsFbmBg1xrV855YRdCxqtna6KwKkyi+rrK0yjGIPz1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tAoRxLGO5DnbrNK6U9xEs9WlHAvzjRip71ZReY2rVojbEHBxz5UZCAhzNuSfQrq+H
 NW+m9//bXB9q8WmPpnjwe7GaHGSsWoaCI2kiaLUV22U2rWtqqEyfxPGxudzsUZIsk1
 7ymJ9YdMdMPv0H2UDG2Oy5uVcz9iAViPwTG6WK/0=
Date: Fri, 27 Aug 2021 19:41:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V4 05/13] hyperv: Add Write/Read MSR registers via ghcb
 page
Message-ID: <YSkj2kvYoYW8kDiF@kroah.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-6-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827172114.414281-6-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 dave.hansen@intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com,
 martin.petersen@oracle.com, saravanand@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, ardb@kernel.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
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

On Fri, Aug 27, 2021 at 01:21:03PM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyperv provides GHCB protocol to write Synthetic Interrupt
> Controller MSR registers in Isolation VM with AMD SEV SNP
> and these registers are emulated by hypervisor directly.
> Hyperv requires to write SINTx MSR registers twice. First
> writes MSR via GHCB page to communicate with hypervisor
> and then writes wrmsr instruction to talk with paravisor
> which runs in VMPL0. Guest OS ID MSR also needs to be set
> via GHCB page.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>          * Introduce sev_es_ghcb_hv_call_simple() and share code
>            between SEV and Hyper-V code.
> Change since v3:
>          * Pass old_msg_type to hv_signal_eom() as parameter.
> 	 * Use HV_REGISTER_* marcro instead of HV_X64_MSR_*
> 	 * Add hv_isolation_type_snp() weak function.
> 	 * Add maros to set syinc register in ARM code.
> ---
>  arch/arm64/include/asm/mshyperv.h |  23 ++++++
>  arch/x86/hyperv/hv_init.c         |  36 ++--------
>  arch/x86/hyperv/ivm.c             | 112 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  80 ++++++++++++++++++++-
>  arch/x86/include/asm/sev.h        |   3 +
>  arch/x86/kernel/sev-shared.c      |  63 ++++++++++-------
>  drivers/hv/hv.c                   | 112 ++++++++++++++++++++----------
>  drivers/hv/hv_common.c            |   6 ++
>  include/asm-generic/mshyperv.h    |   4 +-
>  9 files changed, 345 insertions(+), 94 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index 20070a847304..ced83297e009 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -41,6 +41,29 @@ static inline u64 hv_get_register(unsigned int reg)
>  	return hv_get_vpreg(reg);
>  }
>  
> +#define hv_get_simp(val)	{ val = hv_get_register(HV_REGISTER_SIMP); }
> +#define hv_set_simp(val)	hv_set_register(HV_REGISTER_SIMP, val)
> +
> +#define hv_get_siefp(val)	{ val = hv_get_register(HV_REGISTER_SIEFP); }
> +#define hv_set_siefp(val)	hv_set_register(HV_REGISTER_SIEFP, val)
> +
> +#define hv_get_synint_state(int_num, val) {			\
> +	val = hv_get_register(HV_REGISTER_SINT0 + int_num);	\
> +	}
> +
> +#define hv_set_synint_state(int_num, val)			\
> +	hv_set_register(HV_REGISTER_SINT0 + int_num, val)
> +
> +#define hv_get_synic_state(val) {			\
> +	val = hv_get_register(HV_REGISTER_SCONTROL);	\
> +	}
> +
> +#define hv_set_synic_state(val)			\
> +	hv_set_register(HV_REGISTER_SCONTROL, val)
> +
> +#define hv_signal_eom(old_msg_type)		 \
> +	hv_set_register(HV_REGISTER_EOM, 0)

Please just use real inline functions and not #defines if you really
need it.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
