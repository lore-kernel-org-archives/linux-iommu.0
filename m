Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F62C282DD
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:17:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1A72175B
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 01:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1A72175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 26EE310BE;
	Fri, 24 May 2019 01:16:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 572C2FF0
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DC415F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 01:16:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 18:16:36 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:36 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v4 09/21] x86/nmi: Add a NMI_WATCHDOG NMI handler category
Date: Thu, 23 May 2019 18:16:11 -0700
Message-Id: <1558660583-28561-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
	Andi Kleen <andi.kleen@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Add a NMI_WATCHDOG as a new category of NMI handler. This new category
is to be used with the HPET-based hardlockup detector. This detector
does not have a direct way of checking if the HPET timer is the source of
the NMI. Instead it indirectly estimate it using the time-stamp counter.

Therefore, we may have false-positives in case another NMI occurs within
the estimated time window. For this reason, we want the handler of the
detector to be called after all the NMI_LOCAL handlers. A simple way
of achieving this with a new NMI handler category.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/nmi.h |  1 +
 arch/x86/kernel/nmi.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 75ded1d13d98..75aa98313cde 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -29,6 +29,7 @@ enum {
 	NMI_UNKNOWN,
 	NMI_SERR,
 	NMI_IO_CHECK,
+	NMI_WATCHDOG,
 	NMI_MAX
 };
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4df7705022b9..43e96aedc6fe 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -64,6 +64,10 @@ static struct nmi_desc nmi_desc[NMI_MAX] =
 		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[3].lock),
 		.head = LIST_HEAD_INIT(nmi_desc[3].head),
 	},
+	{
+		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[4].lock),
+		.head = LIST_HEAD_INIT(nmi_desc[4].head),
+	},
 
 };
 
@@ -174,6 +178,8 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	 */
 	WARN_ON_ONCE(type == NMI_SERR && !list_empty(&desc->head));
 	WARN_ON_ONCE(type == NMI_IO_CHECK && !list_empty(&desc->head));
+	WARN_ON_ONCE(type == NMI_WATCHDOG && !list_empty(&desc->head));
+
 
 	/*
 	 * some handlers need to be executed first otherwise a fake
@@ -384,6 +390,10 @@ static void default_do_nmi(struct pt_regs *regs)
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
+	handled = nmi_handle(NMI_WATCHDOG, regs);
+	if (handled == NMI_HANDLED)
+		return;
+
 	/*
 	 * Only one NMI can be latched at a time.  To handle
 	 * this we may process multiple nmi handlers at once to
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
