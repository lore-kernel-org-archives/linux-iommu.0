Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64952C49EA7
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B960613FA
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B960613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 709B140553;
	Tue, 15 Jun 2021 17:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rcu_EA7ijYiD; Tue, 15 Jun 2021 17:16:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50575402F4;
	Tue, 15 Jun 2021 17:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5765DC002C;
	Tue, 15 Jun 2021 17:16:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A67BC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FB9B4041A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QERW52vd4_Mn for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 17:14:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57A1D40527
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1623777297; x=1655313297;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=BYgsDpGVXiNQKbjx1zEY4QnnueERRkwQ3EUBgFLcp1s=;
 b=Er/Nd3anUD6RDaaX7fCZ+20AFXAQwIpH1pALG+4nICS/hR//gJeBZw04
 CGKphXC/Xdp7/NCuQfLAb2rjYlua9SYEZ2iRKk5GNfwZR8NaoSVFFMf8H
 FVaLbTqiwWNP/QlQxqTYf/PDx4mZH4tAIheFwnFEE7HDpY4pOUOxIbQvg o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:55 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Jun 2021 10:08:54 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:54 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v6 15/15] iommu/arm-smmu: Implement the map_pages() IOMMU
 driver callback
Date: Tue, 15 Jun 2021 10:08:33 -0700
Message-ID: <1623776913-390160-16-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
X-Mailman-Approved-At: Tue, 15 Jun 2021 17:16:44 +0000
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Implement the map_pages() callback for the ARM SMMU driver
to allow calls from iommu_map to map multiple pages of
the same size in one call. Also, remove the map() callback
for the ARM SMMU driver, as it will no longer be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 593a15cfa8d5..c1ca3b49a620 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1193,8 +1193,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int prot, gfp_t gfp, size_t *mapped)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -1204,7 +1205,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		return -ENODEV;
 
 	arm_smmu_rpm_get(smmu);
-	ret = ops->map(ops, iova, paddr, size, prot, gfp);
+	ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
 	arm_smmu_rpm_put(smmu);
 
 	return ret;
@@ -1574,7 +1575,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
-	.map			= arm_smmu_map,
+	.map_pages		= arm_smmu_map_pages,
 	.unmap_pages		= arm_smmu_unmap_pages,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
