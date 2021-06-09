Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03972C48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96234610A2
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96234610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2917560087;
	Wed,  9 Jun 2021 13:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tOtFcBtAOgIn; Wed,  9 Jun 2021 13:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 405FD607E4;
	Wed,  9 Jun 2021 13:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5611C0025;
	Wed,  9 Jun 2021 13:45:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01CE8C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD09940514
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynTeTO2uZ_Ze for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 13:42:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp4.osuosl.org (Postfix) with SMTP id 33106404F3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=OkHkIhhIF+nUZjZbINQyI6axCFfaFtk6/n5ulBOsI1c=; b=p
 1OJw7Oz6ZFv5QyUgpCZuL0ZJGG76QEDgucdurJoE+KKwV06vF6I1NBJlrGXV4kjp
 I1Q3WHuNYpMYNV+uCMz+6v4H1QE2qOHvI7xfnFXIP4Tu3bK8XN1xhEhLdASvKnBw
 k6XBKibVWx3TiCj7VlgtIyc9u8/LIa27i5ez2YLfKQ=
Received: from localhost.localdomain (unknown [10.162.183.236])
 by app1 (Coremail) with SMTP id XAUFCgAX+CCSw8BgN34+AA--.4410S3;
 Wed, 09 Jun 2021 21:35:14 +0800 (CST)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Krishna Reddy <vdumpa@nvidia.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak when
 arm_smmu_rpm_get fails
Date: Wed,  9 Jun 2021 21:35:07 +0800
Message-Id: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgAX+CCSw8BgN34+AA--.4410S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryxJw1kuFWDKr48XF1kKrg_yoW5JFykpa
 1Uu390vF4kGFy0yr1DAw40vF98W3yIvF9Fyr4xGas8ur13t3s8KF12y34a9a4kCrW8Ja13
 Ar42qr45CF15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
 0xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
 W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
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

The reference counting issue happens in some error handling paths of
arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
fails, the caller functions forget to decrease the refcount of "smmu"
increased by arm_smmu_rpm_get(), causing a refcount leak.

Fix this issue by calling arm_smmu_rpm_put() or jumping to the "rpm_put"
label when arm_smmu_rpm_get() fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..177ee54c5534 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -840,7 +840,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return;
+		goto rpm_put;
 
 	/*
 	 * Disable the context bank and free the page tables before freeing
@@ -857,6 +857,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 
+rpm_put:
 	arm_smmu_rpm_put(smmu);
 }
 
@@ -1153,7 +1154,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return ret;
+		goto rpm_put;
 
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu, dev);
@@ -1404,7 +1405,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		goto out_cfg_free;
+		goto rpm_put;
 
 	ret = arm_smmu_master_alloc_smes(dev);
 	arm_smmu_rpm_put(smmu);
@@ -1417,6 +1418,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	return &smmu->iommu;
 
+rpm_put:
+	arm_smmu_rpm_put(smmu);
 out_cfg_free:
 	kfree(cfg);
 out_free:
@@ -1438,8 +1441,10 @@ static void arm_smmu_release_device(struct device *dev)
 	smmu = cfg->smmu;
 
 	ret = arm_smmu_rpm_get(smmu);
-	if (ret < 0)
+	if (ret < 0) {
+		arm_smmu_rpm_put(smmu);
 		return;
+	}
 
 	arm_smmu_master_free_smes(cfg, fwspec);
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
