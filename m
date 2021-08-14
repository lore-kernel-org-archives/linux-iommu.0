Return-Path: <SRS0=e2ZE=NF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3739C4338F
	for <iommu@archiver.kernel.org>; Sat, 14 Aug 2021 15:24:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B526103A
	for <iommu@archiver.kernel.org>; Sat, 14 Aug 2021 15:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76B526103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B43E4023C;
	Sat, 14 Aug 2021 15:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8ncTu-Qkotq; Sat, 14 Aug 2021 15:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A8224023F;
	Sat, 14 Aug 2021 15:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E08FC001A;
	Sat, 14 Aug 2021 15:24:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A0DC000E
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 15:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5569880C18
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 15:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1uVwO53WFkF for <iommu@lists.linux-foundation.org>;
 Sat, 14 Aug 2021 15:24:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00CD680BCE
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 15:24:32 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1db9002f4996680da31890.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1d:b900:2f49:9668:da3:1890])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4181EC0570;
 Sat, 14 Aug 2021 17:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1628954665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=sbUZXYrGBCnkdsaMVDuLw+c4h20LmEtsdOYx/LANX0Q=;
 b=C00yjn7cBmQqRpOaWrEEj5l68AxFibYiJHAi3z1eBk5RnJifb6ywdjAO9bEEyQcQGDqW2O
 EISCtsZnVhg2cwZvHYBEu32siB+BgLQO9Fc7VRjIta+kozXWnAdLDck7yaUcVc1AXUpVdO
 qhH8pNHGUmDKEa/M9P+kxf+ZpIhdVbo=
Date: Sat, 14 Aug 2021 17:25:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 01/12] x86/ioremap: Selectively build arch override
 encryption functions
Message-ID: <YRfgTzhKCn7otSzy@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <a4338245609a6be63b162e3516d3f6614db782a4.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4338245609a6be63b162e3516d3f6614db782a4.1628873970.git.thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, linux-graphics-maintainer@vmware.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Fri, Aug 13, 2021 at 11:59:20AM -0500, Tom Lendacky wrote:
> In prep for other uses of the prot_guest_has() function besides AMD's
> memory encryption support, selectively build the AMD memory encryption
> architecture override functions only when CONFIG_AMD_MEM_ENCRYPT=y. These
> functions are:
> - early_memremap_pgprot_adjust()
> - arch_memremap_can_ram_remap()
> 
> Additionally, routines that are only invoked by these architecture
> override functions can also be conditionally built. These functions are:
> - memremap_should_map_decrypted()
> - memremap_is_efi_data()
> - memremap_is_setup_data()
> - early_memremap_is_setup_data()
> 
> And finally, phys_mem_access_encrypted() is conditionally built as well,
> but requires a static inline version of it when CONFIG_AMD_MEM_ENCRYPT is
> not set.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/io.h | 8 ++++++++
>  arch/x86/mm/ioremap.c     | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)

LGTM.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
