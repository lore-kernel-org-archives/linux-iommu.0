Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AECC433FE
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B47E440C3F;
	Fri, 17 Dec 2021 22:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2w0piDAzvEy; Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8B4DB40C26;
	Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62D70C002F;
	Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 644BFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5060640C33
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbMuk0nj2Zum for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C85A40AB1
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639778517; x=1671314517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NHuCxyOdESdoiv75buH1o0WjIBI3bzfAYUCIy2K5lYI=;
 b=ceX/bRzDoKEvpGVipmRmh5esn2df7yfrx9jE6p6zLzoF5ZOmmMu+cNGq
 rfjRah+JTJuVqiaWHaHI2Pzf5gNfPalk51gjDoN2mFAj/gSR+NjrIbhXm
 66i+U073xBe5SHG1LQuKjHftTnhwTWIuKGkkVrY+9wvlWNKXydxnmqtmB
 44I1mJYZZflzinhZkc3a9mg0cg3gPzQlJNQ0LH0L8EtIxmm+o9vTclUgl
 oH851YTk2fiSONvQxxGfKO8ckN9Tm/j0BJGDXdGY+Un0Q+oNF+7shPDxB
 CXbzBQqSLGi04hOxMa9aRTwneFILpyzvgCLM3v+3KgjF9/Na+uwIbY2Mp Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239793573"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="239793573"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 14:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="506928076"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:47 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v2 02/11] mm: Change CONFIG option for mm->pasid field
Date: Fri, 17 Dec 2021 22:01:27 +0000
Message-Id: <20211217220136.2762116-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
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

This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
needed when CONFIG_IOMMU_SVA option is enabled.

Change the CONFIG guards around definition and initialization
of mm->pasid field.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)

 include/linux/mm_types.h | 2 +-
 kernel/fork.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..6d92121d5bd9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -643,7 +643,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..b33c52021d4e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1020,7 +1020,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 
 static void mm_init_pasid(struct mm_struct *mm)
 {
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 	mm->pasid = INIT_PASID;
 #endif
 }
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
