Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63193C10F12
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 09:28:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5AA2073F
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 09:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Se66Dvjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5AA2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DCD35CA1;
	Wed, 17 Apr 2019 09:28:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 314ECAD7
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 09:28:17 +0000 (UTC)
X-Greylist: delayed 00:15:07 by SQLgrey-1.7.6
Received: from m50-132.163.com (m50-132.163.com [123.125.50.132])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0CE4AF4
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2SxV/BhUZVREHKWzjf
	qPFkoNwq53MrugvQ4cnZWBR08=; b=Se66DvjpGrci6kcX4GoTapOYDhvK3F2Xh9
	bqtXVxMkezHucvoYFxeYyxK4Ke0zWUa1MYJ8XpEvpQV3t9nSRBC7VrHnq+Iyn7J1
	AMHOUZR4FgIoOCP+MK9dVj4+6VMqYN0i1+5oFxfQIVDSSiV/5X6qnG7h5ed/wD99
	VUiz3F+0A=
Received: from bp.localdomain (unknown [218.106.182.174])
	by smtp2 (Coremail) with SMTP id DNGowADn9RIa7rZcdfJRAA--.23S3;
	Wed, 17 Apr 2019 17:13:01 +0800 (CST)
From: Pan Bian <bianpan2016@163.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: iommu/vt-d: drop mm use count if address is not canonical
Date: Wed, 17 Apr 2019 17:12:57 +0800
Message-Id: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowADn9RIa7rZcdfJRAA--.23S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4kAF1xJw17JrW7ZFy5Arb_yoWfurcE9a
	48ursrXr90yr13W3WFyFyxZryv9a4j9FyxX348Kas3tFy7XFyfGasaq34DX34fKr4UtrnI
	g3s7Wa1rZry2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUURnQ5UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVAGZclUMH9evpAAAsk
Cc: Pan Bian <bianpan2016@163.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417091257.Pe7lm6zH2bShDjtUnVPdJ9y_AHuMihN-Zra_QOIr7TA@z>

The use count of svm->mm is incremented by mmget_not_zero. However, it
is not dropped when the address is not canonical. This patch fixes the
bug.

Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check if
address is canonical.")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..2630d2e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
+		if (!is_canonical_address(address)) {
+			mmput(svm->mm);
 			goto bad_req;
+		}
 
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
-- 
2.7.4


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
