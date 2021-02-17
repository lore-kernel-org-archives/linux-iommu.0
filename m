Return-Path: <SRS0=1/MC=HT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB81C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Feb 2021 15:08:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04F664E28
	for <iommu@archiver.kernel.org>; Wed, 17 Feb 2021 15:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04F664E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B91F87170;
	Wed, 17 Feb 2021 15:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hnD9rhaj1PR4; Wed, 17 Feb 2021 15:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AECDC847B8;
	Wed, 17 Feb 2021 15:08:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1147C0174;
	Wed, 17 Feb 2021 15:08:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FADDC013A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 14:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A2AB86111
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 14:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 288LMe3lnxkx for <iommu@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 14:35:04 +0000 (UTC)
X-Greylist: delayed 00:06:03 by SQLgrey-1.7.6
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net
 [77.88.29.217])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 241CD86F7E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Feb 2021 14:35:03 +0000 (UTC)
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E89CE2E0C61;
 Wed, 17 Feb 2021 17:28:57 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 bPjqwWRHUA-SvxaPpXq; Wed, 17 Feb 2021 17:28:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; 
 t=1613572137; bh=/M/W/rry6PW248aDe81ggUEdVdPjrAZqjQQ99mtBe3k=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=0tTT32VPUOg0z6LDzc8HPZL7d+d+PsB/jnFYWLRT2W3Nx0ZQqEhQPu5Vgl4mDACv/
 jzmSZRbdIPVH/coLWDDW0dtNFTi8c2sWCb1xIobGnBma8wAzB5fNXbw89N0R5+FF0K
 zxVqX78wxQq6HHVH0faWVIV2B4F9FvO1C2lJLueg=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6619::1:17])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 IlngOxqDDd-SuoS9OgN; Wed, 17 Feb 2021 17:28:57 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Andrey Ryabinin <arbn@yandex-team.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: Fix sleeping in atomic in increase_address_space()
Date: Wed, 17 Feb 2021 17:30:04 +0300
Message-Id: <20210217143004.19165-1-arbn@yandex-team.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 17 Feb 2021 15:08:55 +0000
Cc: Andrey Ryabinin <arbn@yandex-team.com>, valesini@yandex-team.ru,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Qian Cai <cai@lca.pw>,
 Will Deacon <will@kernel.org>
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

increase_address_space() calls get_zeroed_page(gfp) under spin_lock with
disabled interrupts. gfp flags passed to increase_address_space() may allow
sleeping, so it comes to this:

 BUG: sleeping function called from invalid context at mm/page_alloc.c:4342
 in_atomic(): 1, irqs_disabled(): 1, pid: 21555, name: epdcbbf1qnhbsd8

 Call Trace:
  dump_stack+0x66/0x8b
  ___might_sleep+0xec/0x110
  __alloc_pages_nodemask+0x104/0x300
  get_zeroed_page+0x15/0x40
  iommu_map_page+0xdd/0x3e0
  amd_iommu_map+0x50/0x70
  iommu_map+0x106/0x220
  vfio_iommu_type1_ioctl+0x76e/0x950 [vfio_iommu_type1]
  do_vfs_ioctl+0xa3/0x6f0
  ksys_ioctl+0x66/0x70
  __x64_sys_ioctl+0x16/0x20
  do_syscall_64+0x4e/0x100
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by moving get_zeroed_page() out of spin_lock/unlock section.

Fixes: 754265bcab ("iommu/amd: Fix race in increase_address_space()")
Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Cc: <stable@vger.kernel.org>
---
 drivers/iommu/amd/iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f0adbc48fd17..9256f84f5ebf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1502,6 +1502,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	bool ret = true;
 	u64 *pte;
 
+	pte = (void *)get_zeroed_page(gfp);
+	if (!pte)
+		return false;
+
 	spin_lock_irqsave(&domain->lock, flags);
 
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
@@ -1513,10 +1517,6 @@ static bool increase_address_space(struct protection_domain *domain,
 	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
-	pte = (void *)get_zeroed_page(gfp);
-	if (!pte)
-		goto out;
-
 	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
 
 	pgtable.root  = pte;
@@ -1530,10 +1530,12 @@ static bool increase_address_space(struct protection_domain *domain,
 	 */
 	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
 
+	pte = NULL;
 	ret = true;
 
 out:
 	spin_unlock_irqrestore(&domain->lock, flags);
+	free_page((unsigned long)pte);
 
 	return ret;
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
