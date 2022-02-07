Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D05EC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 23:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBE9860A97;
	Mon,  7 Feb 2022 23:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aaBme8ahKsIx; Mon,  7 Feb 2022 23:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA99C6059C;
	Mon,  7 Feb 2022 23:03:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E2AEC0011;
	Mon,  7 Feb 2022 23:03:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B666C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A35180BC2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxdwvf_GF4ik for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 23:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B19580B81
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644275029; x=1675811029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZQuX/1pAiBPvBMAccFCq7xa5FLVExUm2Q9ePeODXOtk=;
 b=hG70KZtenuc33DjqFo+Gs4AbonSyfMMuxFv4uIxWHTVjkHmxV3Ktf9ze
 8wqJU+KlPpJPHlmTB0BT8FkWZPNXzkM8o9GkuEl6OC3gb+7khHd2ILbUF
 l70YoFlVs7KFxArQsw9pVZ/ndmrBzkFQF2GDJauTIdRVR/rDyZxOG0Pgi
 NXaypAB0pouv0ZhDIYAaxfwAnagB0MSRBNlGUBd3LfLPXOLf+Doy4SHW0
 5D7NkkSBoqeSqVzdWi2iRFeCFu5pIgbGFj+eVxkJx5Wd+XLXZiVe6rDJ7
 Bc7BshsqEppdEBGDc8A7IwZkmtw/oExhVGmlQZBWaeIumGX4P6BL1JCTt g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248774753"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="248774753"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="540324016"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:02 -0800
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
Subject: [PATCH v4 02/11] mm: Change CONFIG option for mm->pasid field
Date: Mon,  7 Feb 2022 15:02:45 -0800
Message-Id: <20220207230254.3342514-3-fenghua.yu@intel.com>
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

This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
needed when CONFIG_IOMMU_SVA option is enabled.

Change the CONFIG guards around definition and initialization
of mm->pasid field.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)

 include/linux/mm_types.h | 2 +-
 kernel/fork.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..c5cbfd7915ad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,7 +631,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..6ee7551d3bd2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1021,7 +1021,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 
 static void mm_init_pasid(struct mm_struct *mm)
 {
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 	mm->pasid = INIT_PASID;
 #endif
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
