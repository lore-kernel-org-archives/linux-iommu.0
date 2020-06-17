Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E0FC433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D662082F
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D662082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C893F893BC;
	Wed, 17 Jun 2020 18:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mLKXI8uE4EZ; Wed, 17 Jun 2020 18:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C165E8887C;
	Wed, 17 Jun 2020 18:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEC11C0892;
	Wed, 17 Jun 2020 18:24:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE21C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A67887336
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ZFzeOp-odkg for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 18:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1D3EB87599
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:17 +0000 (UTC)
IronPort-SDR: XoVwWFHdfydejPJPAYSv3Ucp4/zXQn5ksfE8MkDeFCXxYHEz8YUm4giiL/lRe7xRXvbUIEYzCM
 gF0lrG+1Yy8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 11:24:16 -0700
IronPort-SDR: W5O+KUZsyM9+cj89LImiPTfluup41EtWBMFa81zH2fYgCXbd6rfdm/L99d+pucmEpgBFsZrvyG
 FOm4w4yQ7IAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="308874172"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 11:24:16 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "H Peter Anvin" <hpa@zytor.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradeed.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 07/13] x86/msr-index: Define IA32_PASID MSR
Date: Wed, 17 Jun 2020 11:23:47 -0700
Message-Id: <1592418233-17762-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
(PASID), a 20-bit value. Bit 31 must be set to indicate the value
programmed in the MSR is valid. Hardware uses PASID to identify process
address space and direct responses to the right address space.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change "identify process" to "identify process address space" in the
  commit message (Thomas)

 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..e5f699ff1dd6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -237,6 +237,9 @@
 #define MSR_IA32_LASTINTFROMIP		0x000001dd
 #define MSR_IA32_LASTINTTOIP		0x000001de
 
+#define MSR_IA32_PASID			0x00000d93
+#define MSR_IA32_PASID_VALID		BIT_ULL(31)
+
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
