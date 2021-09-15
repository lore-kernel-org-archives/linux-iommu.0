Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E6DC433FE
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 17:26:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748CB611CA
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 17:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 748CB611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26ADB4263B;
	Wed, 15 Sep 2021 17:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JYMsldcb1z0C; Wed, 15 Sep 2021 17:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91CFA42565;
	Wed, 15 Sep 2021 17:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40B10C000F;
	Wed, 15 Sep 2021 17:26:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83C84C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5638783133
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VeLQ5LXs25P for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 17:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CACA84D58
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 17:26:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="219204860"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; d="scan'208";a="219204860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 10:26:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; d="scan'208";a="434215304"
Received: from rlad-mobl.amr.corp.intel.com (HELO
 skuppusw-mobl5.amr.corp.intel.com) ([10.212.118.184])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 10:26:08 -0700
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <YUIjS6lKEY5AadZx@zn.tnic>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d48e6a17-d2b4-67da-56d1-fc9a61dfe2b8@linux.intel.com>
Date: Wed, 15 Sep 2021 10:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUIjS6lKEY5AadZx@zn.tnic>
Content-Language: en-US
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 linux-graphics-maintainer@vmware.com, Dave Young <dyoung@redhat.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 9/15/21 9:46 AM, Borislav Petkov wrote:
> Sathya,
> 
> if you want to prepare the Intel variant intel_cc_platform_has() ontop
> of those and send it to me, that would be good because then I can
> integrate it all in one branch which can be used to base future work
> ontop.

I have a Intel variant patch (please check following patch). But it includes
TDX changes as well. Shall I move TDX changes to different patch and just
create a separate patch for adding intel_cc_platform_has()?


commit fc5f98a0ed94629d903827c5b44ee9295f835831
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed May 12 11:35:13 2021 -0700

     x86/tdx: Add confidential guest support for TDX guest

     TDX architecture provides a way for VM guests to be highly secure and
     isolated (from untrusted VMM). To achieve this requirement, any data
     coming from VMM cannot be completely trusted. TDX guest fixes this
     issue by hardening the IO drivers against the attack from the VMM.
     So, when adding hardening fixes to the generic drivers, to protect
     custom fixes use cc_platform_has() API.

     Also add TDX guest support to cc_platform_has() API to protect the
     TDX specific fixes.

     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a5b14de03458..2e78358923a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
         depends on SECURITY
         select X86_X2APIC
         select SECURITY_LOCKDOWN_LSM
+       select ARCH_HAS_CC_PLATFORM
         help
           Provide support for running in a trusted domain on Intel processors
           equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/intel_cc_platform.h b/arch/x86/include/asm/intel_cc_platform.h
new file mode 100644
index 000000000000..472c3174beac
--- /dev/null
+++ b/arch/x86/include/asm/intel_cc_platform.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation */
+#ifndef _ASM_X86_INTEL_CC_PLATFORM_H
+#define _ASM_X86_INTEL_CC_PLATFORM_H
+
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
+bool intel_cc_platform_has(unsigned int flag);
+#else
+static inline bool intel_cc_platform_has(unsigned int flag) { return false; }
+#endif
+
+#endif /* _ASM_X86_INTEL_CC_PLATFORM_H */
+
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3c9bacd3c3f3..e83bc2f48efe 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -10,11 +10,16 @@
  #include <linux/export.h>
  #include <linux/cc_platform.h>
  #include <linux/mem_encrypt.h>
+#include <linux/processor.h>
+
+#include <asm/intel_cc_platform.h>

  bool cc_platform_has(enum cc_attr attr)
  {
         if (sme_me_mask)
                 return amd_cc_platform_has(attr);
+       else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+               return intel_cc_platform_has(attr);

         return false;
  }
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..ab486a3b1eb0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -11,6 +11,7 @@
  #include <linux/init.h>
  #include <linux/uaccess.h>
  #include <linux/delay.h>
+#include <linux/cc_platform.h>

  #include <asm/cpufeature.h>
  #include <asm/msr.h>
@@ -60,6 +61,21 @@ static u64 msr_test_ctrl_cache __ro_after_init;
   */
  static bool cpu_model_supports_sld __ro_after_init;

+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool intel_cc_platform_has(enum cc_attr attr)
+{
+       switch (attr) {
+       case CC_ATTR_GUEST_TDX:
+               return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
+       default:
+               return false;
+       }
+
+       return false;
+}
+EXPORT_SYMBOL_GPL(intel_cc_platform_has);
+#endif
+
  /*
   * Processors which have self-snooping capability can handle conflicting
   * memory type across CPUs by snooping its own cache. However, there exists
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 253f3ea66cd8..e38430e6e396 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,15 @@ enum cc_attr {
          * Examples include SEV-ES.
          */
         CC_ATTR_GUEST_STATE_ENCRYPT,
+
+       /**
+        * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
+        *
+        * The platform/OS is running as a TDX guest/virtual machine.
+        *
+        * Examples include SEV-ES.
+        */
+       CC_ATTR_GUEST_TDX,
  };

  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
