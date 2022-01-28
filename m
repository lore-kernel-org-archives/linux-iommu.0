Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1453C43217
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 20:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8838340B1F;
	Fri, 28 Jan 2022 20:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvYeyhjEfdnu; Fri, 28 Jan 2022 20:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F041D405CF;
	Fri, 28 Jan 2022 20:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5CFEC001A;
	Fri, 28 Jan 2022 20:29:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CF4C001A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0198940939
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TM5uiaQB0ceo for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50AAA4022C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643401764; x=1674937764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6OsPHurfIhjKuFzgyw4DA47vvdGN8VlHRe3+l/zPVbY=;
 b=eOsSiTI7CE5maJbpJd1HcVVExMTnM4rxqGAUdQkAhyPFpoWxqRuvyjnO
 QIf+65X01pANCzlxEUUhqzTmsfm2DY8ZSWVXz0ZnAGQabJqQo336mRCdz
 jabrO0KWO58guoYg94EKkWSAcZ1g08k1vkN/NsBrJtgd0oXAKEEzqa2ym
 wHrgsJDDOJgLxCVNtnLUMgXLmc9yDYTHE16sQZUq7IvZzMDATJzVeCszX
 mjsYDa03jC2P/pgcGPNjbERyhrg0HQZb9Ychj5OArOFlNmnnj9TbNtRNY
 nAVmpCz2bEHZp7+HkuBdGiE3a36fV2EewKyaLG+23LyYLeY/CCl99zS1U Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227862443"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="227862443"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2022 12:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; d="scan'208";a="618827703"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:22 -0800
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
Subject: [PATCH v3 06/11] x86/fpu: Clear PASID when copying fpstate
Date: Fri, 28 Jan 2022 12:29:00 -0800
Message-Id: <20220128202905.2274672-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
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

The kernel must allocate a Process Address Space ID (PASID) on behalf of
each process which will use ENQCMD and program it into the new MSR to
communicate the process identity to platform hardware. ENQCMD uses the
PASID stored in this MSR to tag requests from this process.

The PASID state must be cleared on fork() since fork creates a
new address space.

For clone(), it would be functionally OK to copy the PASID. However,
clearing it is _also_ functionally OK since any PASID use will trigger
the #GP handler to populate the MSR.

Copying the PASID state has two main downsides:
 * It requires differentiating fork() and clone() in the code,
   both in the FPU code and keeping tsk->pasid_activated consistent.
 * It guarantees that the PASID is out of its init state, which
   incurs small but non-zero cost on every XSAVE/XRSTOR.

The main downside of clearing the PASID at fpstate copy is the future,
one-time #GP for the thread.

Use the simplest approach: clear the PASID state both on clone() and
fork().  Rely on the #GP handler for MSR population in children.

Also, just clear the PASID bit from xfeatures if XSAVE is supported.
This will have no effect on systems that do not have PASID support.  It
is virtually zero overhead because 'dst_fpu' was just written and
the whole thing is cache hot.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Rewrite changelog (Dave Hansen).
- Move xfeature tweaking into fpu_clone() and make it unconditional
  if XSAVE is supported (Dave Hansen).

 arch/x86/kernel/fpu/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..19821f027cb3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -612,6 +612,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
+	/*
+	 * Children never inherit PASID state.
+	 * Force it to have its init value:
+	 */
+	if (use_xsave())
+		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
