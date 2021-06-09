Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A723C48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:45:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FDF6101A
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FDF6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A895483C42;
	Wed,  9 Jun 2021 13:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RXdfbsfWKID; Wed,  9 Jun 2021 13:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCE7283C21;
	Wed,  9 Jun 2021 13:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 949E4C000E;
	Wed,  9 Jun 2021 13:45:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEA3CC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9A7F404F5
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkXSKLU6IJP8 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 13:42:57 +0000 (UTC)
X-Greylist: delayed 00:06:59 by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp4.osuosl.org (Postfix) with SMTP id 31D35404EF
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=mpWgQxD/es1HAvw4vQKokeYKFNfj/Tm+Idn8T6cKuKs=; b=o
 KwoOt0lSJ1oFPH3WfdLLIcDlZCw26xNgOQZAEUZZdrrQVELkm+bRyPbMho4k0Ypj
 YbvFhVA68pu/STaGmDpseXkOKjaQ9gDLz47FFz3O4Ih/UqEmw6296nijK31iJWaL
 IfNT6aSqFW0K47j+2GuuTwuwTwXUItT/4/arePD2Zk=
Received: from localhost.localdomain (unknown [10.162.183.236])
 by app1 (Coremail) with SMTP id XAUFCgD3_QGGw8BgAX4+AA--.4490S3;
 Wed, 09 Jun 2021 21:35:03 +0800 (CST)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Krishna Reddy <vdumpa@nvidia.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak in address
 translation
Date: Wed,  9 Jun 2021 21:33:24 +0800
Message-Id: <1623245616-11057-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgD3_QGGw8BgAX4+AA--.4490S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxJw43ZF1kKr18Cr47XFb_yoW8ur13pF
 48Wr9YyF1rW3WUJFyDJw4vvF90vayIyFyjgFW7Gas8Cw15trWrK3WrKF9IgF1kCry8Cw43
 Zr12qFW5uF4UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
 0xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
X-Mailman-Approved-At: Wed, 09 Jun 2021 13:45:11 +0000
Cc: Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn,
 Xiyu Yang <xiyuyang19@fudan.edu.cn>
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
From: Xiyu Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
refcount of the "smmu" even though the return value is less than 0.

The reference counting issue happens in several exception handling paths
of arm_smmu_iova_to_phys_hard(). When those error scenarios occur, the
function forgets to decrease the refcount of "smmu" increased by
arm_smmu_rpm_get(), causing a refcount leak.

Fix this issue by jumping to "out" label when those error scenarios
occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..023dcd72ed35 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1271,10 +1271,11 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	u64 phys;
 	unsigned long va, flags;
 	int ret, idx = cfg->cbndx;
+	phys_addr_t addr = 0;
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return 0;
+		goto out;
 
 	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
 	va = iova & ~0xfffUL;
@@ -1290,6 +1291,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		dev_err(dev,
 			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
+		arm_smmu_rpm_put(smmu);
 		return ops->iova_to_phys(ops, iova);
 	}
 
@@ -1298,12 +1300,14 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	if (phys & ARM_SMMU_CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
 		dev_err(dev, "PAR = 0x%llx\n", phys);
-		return 0;
+		goto out;
 	}
 
+	addr = (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+out:
 	arm_smmu_rpm_put(smmu);
 
-	return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+	return addr;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
