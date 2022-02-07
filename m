Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6A6C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 23:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2916281292;
	Mon,  7 Feb 2022 23:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZqzlx2Q4Hpr; Mon,  7 Feb 2022 23:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D159181258;
	Mon,  7 Feb 2022 23:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA3ECC0011;
	Mon,  7 Feb 2022 23:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D1EC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5050E80BC2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmcbLL_9IxSL for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 23:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A207380B91
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644275031; x=1675811031;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=exni2nSl44fcOYxYrJayxLKBv/TSBnKt2khR1kpp+yw=;
 b=oFbqffrBlR6hi1Zyn0R6hkEnzVGNce0pLDKd1yXw6JsIXXHRwMFbTQgF
 k/nu0/JX99f9Jzxy7zMUAhAJYz27MbgE053AdWsWQi18h1BMFPgtEUBMe
 DPs80QZXyTVRQXNiDbBRTMjw9UdHmLEWGtE6Z7KWHSSrt2BnVdGWN8GTs
 LKa4NZQj+3F112qZM/H83i3pUHMzUrrCDkvxOFFce8Zv4dS5cSRjhrNSS
 4mjegOLU/QGTBV041yUJ7D3CltIA8VwE4BqEhErFdJWfvLTkOOumhf+hz
 ytd2pznwRnlpW2m02lWesd+Y3NLbC9YVr3RX/S5tP3aZaLbnFtZ/SmFt/ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248774779"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="248774779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 15:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="540324097"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:06 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v4 10/11] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Date: Mon,  7 Feb 2022 15:02:53 -0800
Message-Id: <20220207230254.3342514-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
of the descriptor being submitted to an accelerator. But there is no
precise (and stable across kernel changes) point at which the PASID_MSR
is updated from the value for one task to the next.

Kernel code that uses accelerators must always use the ENQCMDS instruction
which does not access the PASID_MSR.

Check for use of the ENQCMD instruction in the kernel and warn on its
usage.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v3:
- Add Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

v2:
- Simplify handling ENQCMD (PeterZ and Josh)

 tools/objtool/arch/x86/decode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c10ef78df050..479e769ca324 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, op3,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -139,6 +139,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
+	op3 = insn.opcode.bytes[2];
 
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
@@ -491,6 +492,14 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x38 && op3 == 0xf8) {
+			if (insn.prefixes.nbytes == 1 &&
+			    insn.prefixes.bytes[0] == 0xf2) {
+				/* ENQCMD cannot be used in the kernel. */
+				WARN("ENQCMD instruction at %s:%lx", sec->name,
+				     offset);
+			}
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
