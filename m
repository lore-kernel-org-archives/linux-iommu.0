Return-Path: <SRS0=oJoh=OB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E6C433EF
	for <iommu@archiver.kernel.org>; Sat, 11 Sep 2021 10:10:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3214611F2
	for <iommu@archiver.kernel.org>; Sat, 11 Sep 2021 10:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3214611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E5E982E19;
	Sat, 11 Sep 2021 10:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SI1Y5FtVqz7I; Sat, 11 Sep 2021 10:10:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 858F781B8A;
	Sat, 11 Sep 2021 10:10:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACFFC0011;
	Sat, 11 Sep 2021 10:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A4D4C000D
 for <iommu@lists.linux-foundation.org>; Sat, 11 Sep 2021 10:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76C6D4044C
 for <iommu@lists.linux-foundation.org>; Sat, 11 Sep 2021 10:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mKmgcpLfLUnY for <iommu@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 10:10:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7970640449
 for <iommu@lists.linux-foundation.org>; Sat, 11 Sep 2021 10:10:30 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1e14001f3479bbc118498e.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1e:1400:1f34:79bb:c118:498e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0AD71EC0136;
 Sat, 11 Sep 2021 12:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1631355022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=HR27o8pZq+/+uFK0n68ub/mxfkE1ISiJNZUKmCms7j8=;
 b=I197+52KgpqBBgLvuSMSrQpQNRo13IqV+FgdnGwdscix9JqjZo6kiEOakrW3iQQS6u0uVD
 WzR3O2CXEOh8ZykdepQmAsy+NBoupC0qZ8IdrqxtxuX9zNND17uAXyBpIh83Qsid6C7Ugn
 zY+/3Zj7u8+b/OQlEkEddX/RceOjyqA=
Date: Sat, 11 Sep 2021 12:10:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/8] x86/sev: Add an x86 version of cc_platform_has()
Message-ID: <YTyAhmPf39Vqd7G9@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Wed, Sep 08, 2021 at 05:58:34PM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> new file mode 100644
> index 000000000000..3c9bacd3c3f3
> --- /dev/null
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#include <linux/export.h>
> +#include <linux/cc_platform.h>
> +#include <linux/mem_encrypt.h>
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{
> +	if (sme_me_mask)

Why are you still checking the sme_me_mask here? AFAIR, we said that
we'll do that only when the KVM folks come with a valid use case...

> +		return amd_cc_platform_has(attr);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ff08dc463634..18fe19916bc3 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -20,6 +20,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/virtio_config.h>
> +#include <linux/cc_platform.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -389,6 +390,26 @@ bool noinstr sev_es_active(void)
>  	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>  }
>  
> +bool amd_cc_platform_has(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return sme_me_mask != 0;

No need for the "!= 0"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
