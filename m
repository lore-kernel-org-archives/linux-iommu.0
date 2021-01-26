Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885BDC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 21:17:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1C4221EF
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 21:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1C4221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DC869204A7;
	Tue, 26 Jan 2021 21:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-YcY-UrQg2H; Tue, 26 Jan 2021 21:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0468420481;
	Tue, 26 Jan 2021 21:17:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E147CC08A1;
	Tue, 26 Jan 2021 21:17:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27DC9C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 21:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F39786F80
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 21:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yl-ZTuqjDhtW for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 21:17:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A980A86F77
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 21:17:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18856221EF;
 Tue, 26 Jan 2021 21:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611695862;
 bh=UbmeI7o4c0f9PuzT7IPtTzo1KawRnosAraDG3xQRw2M=;
 h=From:To:Cc:Subject:Date:From;
 b=A835RljsVkR1wcSCeDIDE9v1qroBvM9z6/k5pm3fcIKY8OChVWq7d5jkE8OyYO9Fc
 RBExcssqCTdqzE/4oGN0XWGyqHRxOGeyBcY25sLPNJ3ds8yzyJLmKM1uMaJz3xDBcq
 /lEo0L8yk6dYshG9WJIPyPmH3sqhVkTK7++jXVulo6I8n5UsW2NvZZFZtxARplcweb
 vg9WN+d3C3XxhaJ+byB2XGLgMNoZ6D5f4smegdGLwureHdeKbQD1WjvUvHGhzlS5hc
 UH0re7cDSlpe0w2jAJixDOsHZmoyebA8lBT4k1N8VeB/L0a70aAH01v43ocSfh3qyV
 5DuaWNk/0/Pcg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix 'physical' typos
Date: Tue, 26 Jan 2021 15:17:38 -0600
Message-Id: <20210126211738.2920789-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org
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

From: Bjorn Helgaas <bhelgaas@google.com>

Fix misspellings of "physical".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/intel-iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 09c6a0bf3892..3ae86385b222 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -662,7 +662,7 @@ static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
  * 7: super page
  * 8-10: available
  * 11: snoop behavior
- * 12-63: Host physcial address
+ * 12-63: Host physical address
  */
 struct dma_pte {
 	u64 val;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
