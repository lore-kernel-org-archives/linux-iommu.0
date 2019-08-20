Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB09C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 11:18:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DB62070B
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 11:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p/8kRcVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BB059CD1;
	Tue, 20 Aug 2019 11:18:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1BBB8CCC
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 11:18:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 857CF8A0
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 11:18:03 +0000 (UTC)
Received: from zn.tnic (p200300EC2F0AD10084521F4194A0C4F9.dip0.t-ipconnect.de
	[IPv6:2003:ec:2f0a:d100:8452:1f41:94a0:c4f9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id
	2D7CD1EC0554; Tue, 20 Aug 2019 13:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1566299881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:in-reply-to:in-reply-to: references:references;
	bh=qLD0ExhlVQNU4tohbyQwZ28DUVLBgVJZM+C1XKxSUmQ=;
	b=p/8kRcVksfZDDobCZ0xUuotYx4yIstkcACTjuPPK0O1I2rI6BSoNl3e8ws3ScRov+kuec+
	hG+7O0p12EzbAhwnvxQnx7XAxRmF8tA6yE7IyCwsEUtBVSi5v/z1kzD2UvFMbSeWx1yloC
	zgHLgddrt3uiTUPogfl4HN91pmBF1J8=
Date: Tue, 20 Aug 2019 13:17:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 06/11] x86/dma: Get rid of iommu_pass_through
Message-ID: <20190820111753.GD31607@zn.tnic>
References: <20190819132256.14436-1-joro@8bytes.org>
	<20190819132256.14436-7-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190819132256.14436-7-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Aug 19, 2019 at 03:22:51PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This variable has no users anymore. Remove it and tell the
> IOMMU code via its new functions about requested DMA modes.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/iommu.h |  1 -
>  arch/x86/kernel/pci-dma.c    | 20 +++-----------------
>  2 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index baedab8ac538..b91623d521d9 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -4,7 +4,6 @@
>  
>  extern int force_iommu, no_iommu;
>  extern int iommu_detected;
> -extern int iommu_pass_through;
>  
>  /* 10 seconds */
>  #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index f62b498b18fb..fa4352dce491 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/dma-direct.h>
>  #include <linux/dma-debug.h>
> +#include <linux/iommu.h>
>  #include <linux/dmar.h>
>  #include <linux/export.h>
>  #include <linux/memblock.h>
> @@ -34,21 +35,6 @@ int no_iommu __read_mostly;
>  /* Set this to 1 if there is a HW IOMMU in the system */
>  int iommu_detected __read_mostly = 0;
>  
> -/*
> - * This variable becomes 1 if iommu=pt is passed on the kernel command line.
> - * If this variable is 1, IOMMU implementations do no DMA translation for
> - * devices and allow every device to access to whole physical memory. This is
> - * useful if a user wants to use an IOMMU only for KVM device assignment to
> - * guests and not for driver dma translation.
> - * It is also possible to disable by default in kernel config, and enable with
> - * iommu=nopt at boot time.
> - */
> -#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> -int iommu_pass_through __read_mostly = 1;
> -#else
> -int iommu_pass_through __read_mostly;
> -#endif
> -
>  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
>  
>  void __init pci_iommu_alloc(void)
> @@ -120,9 +106,9 @@ static __init int iommu_setup(char *p)
>  			swiotlb = 1;
>  #endif
>  		if (!strncmp(p, "pt", 2))
> -			iommu_pass_through = 1;
> +			iommu_set_default_passthrough(true);
>  		if (!strncmp(p, "nopt", 4))
> -			iommu_pass_through = 0;
> +			iommu_set_default_translated(true);
>  
>  		gart_parse_options(p);
>  
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
