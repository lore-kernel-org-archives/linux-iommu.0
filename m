Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EBFC4332F
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 23:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD6A240253;
	Mon,  7 Feb 2022 23:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FylHvHJhwTJH; Mon,  7 Feb 2022 23:03:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F4064052E;
	Mon,  7 Feb 2022 23:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2038DC007E;
	Mon,  7 Feb 2022 23:03:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1F29C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6B5F404CD
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lw1raJZIbQjK for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 23:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8985400D3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644275030; x=1675811030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pSiI5bRDWKZ8wcmfvSwFj0dyl6gbbkbtffSYluVkHLo=;
 b=Dflciez+66v4ikdYlHaEbBwutdllHoEhfINiVoUkCZBiMcgHVR8zPBdA
 Jv/JvCJwrx42U9Fv1+FsqRs4wzUVmUYGnLXhM0VRThmtVrVSuyc+HLL2I
 rrfSZTsdnNuXh5SF8fJIAwpZncnwOBAeZOVNHZbjeDf4XSjZzhyyKpxYP
 a4HAZWEPESrbsw7KVaj8tm6fGoYRXFOXYScbHZpnYkMRLziiy8Xbr7Plf
 nNxs6S1WqqwjKQXViiKufp0QxUW9S3ySs/3p7cWBb3YYh5OMw0WSdtQ1R
 S6D4vqq1k+rDH9SiGL8hdXHJYazD9NwCs4hE+MK1+bCNkTiF5Avz5QTef g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248774764"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="248774764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 15:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="540324061"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:04 -0800
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
Subject: [PATCH v4 06/11] x86/fpu: Clear PASID when copying fpstate
Date: Mon,  7 Feb 2022 15:02:49 -0800
Message-Id: <20220207230254.3342514-7-fenghua.yu@intel.com>
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

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
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
