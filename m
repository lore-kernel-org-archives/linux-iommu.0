Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C403C47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:14:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC72613D0
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC72613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D712D60A95;
	Wed,  2 Jun 2021 10:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDPg2AqzJM6T; Wed,  2 Jun 2021 10:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F585605AF;
	Wed,  2 Jun 2021 10:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D42FC000E;
	Wed,  2 Jun 2021 10:14:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E30C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D37D84022B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4eegbf2kboJ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 10:14:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8846340123
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:14:14 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0f0e00cc90e218be681080.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:e00:cc90:e218:be68:1080])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11F341EC03F0;
 Wed,  2 Jun 2021 12:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1622628851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=xt5EUbqzEORoKlt8WOnIt9jfniFBapo1gRFEx/SuRsU=;
 b=rcEUDc9ldr9G8e8bFrixjmZ23ayGa3XpiTj+CJ/bDSZSrqRjQ/EXee5UNQ3Vuh0AfkAwGx
 kJ9dDvuOqwlqyptbzAXCcf0xzamU1o4kaGA4sV5iswPDdTM6pLEfUTPvEHo3wl2mmh6TV8
 wt3PNqJT79Op6SKdGrS7v6gsH0Z0nZQ=
Date: Wed, 2 Jun 2021 12:14:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLdZ7bZDPNup1n9c@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, dmaengine@vger.kernel.org,
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

On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -56,11 +56,8 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> -#ifdef CONFIG_IOMMU_SUPPORT
> -# define DISABLE_ENQCMD	0
> -#else
> -# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
> -#endif
> +/* Force disable because it's broken beyond repair */
> +#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))

Yeah, for that to work we need:

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 2 Jun 2021 12:07:52 +0200
Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()

When testing x86 feature bits, use cpu_feature_enabled() so that
build-disabled features can remain off, regardless of what CPUID says.

Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
---
 drivers/dma/idxd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2a926bef87f2..776fd44aff5f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -745,12 +745,12 @@ static int __init idxd_init_module(void)
 	 * If the CPU does not support MOVDIR64B or ENQCMDS, there's no point in
 	 * enumerating the device. We can not utilize it.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_MOVDIR64B)) {
+	if (!cpu_feature_enabled(X86_FEATURE_MOVDIR64B)) {
 		pr_warn("idxd driver failed to load without MOVDIR64B.\n");
 		return -ENODEV;
 	}
 
-	if (!boot_cpu_has(X86_FEATURE_ENQCMD))
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
 		pr_warn("Platform does not have ENQCMD(S) support.\n");
 	else
 		support_enqcmd = true;
-- 
2.29.2

For the newly CCed parties, pls check

https://lkml.kernel.org/r/87mtsd6gr9.ffs@nanos.tec.linutronix.de

for more info.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
