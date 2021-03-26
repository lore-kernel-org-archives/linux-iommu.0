Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039EC433E1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 09:37:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112C961A45
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112C961A45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98939414D6;
	Fri, 26 Mar 2021 09:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuWos1x-VPll; Fri, 26 Mar 2021 09:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3213A414D1;
	Fri, 26 Mar 2021 09:37:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60C9DC001B;
	Fri, 26 Mar 2021 09:37:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEB99C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADF7E40249
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ot_UT7nkqWNh for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 09:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 602D040239
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:37:01 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6GyR5LQszPn9Z;
 Fri, 26 Mar 2021 17:34:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 17:36:50 +0800
From: Zhiqi Song <songzhiqi1@huawei.com>
To: <will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
 <robdclark@gmail.com>
Subject: [PATCH 3/3] drivers: iommu/arm - coding style fix
Date: Fri, 26 Mar 2021 17:37:17 +0800
Message-ID: <1616751437-59956-4-git-send-email-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616751437-59956-1-git-send-email-songzhiqi1@huawei.com>
References: <1616751437-59956-1-git-send-email-songzhiqi1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 fanghao11@huawei.com, shenyang39@huawei.com
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

Fixed following checkpatch error:
- spaces required around '='
- space required before the open parenthesis '('
- "foo * bar" should be "foo *bar"

Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 6 +++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ca7415..53e24f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2479,7 +2479,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 		}
 		break;
 	case IOMMU_DOMAIN_DMA:
-		switch(attr) {
+		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
 			smmu_domain->non_strict = *(int *)data;
 			break;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d8c6bfd..1496033 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1261,7 +1261,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 	struct device *dev = smmu->dev;
 	void __iomem *reg;
 	u32 tmp;
@@ -1486,7 +1486,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);

-	switch(domain->type) {
+	switch (domain->type) {
 	case IOMMU_DOMAIN_UNMANAGED:
 		switch (attr) {
 		case DOMAIN_ATTR_NESTING:
@@ -1527,7 +1527,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,

 	mutex_lock(&smmu_domain->init_mutex);

-	switch(domain->type) {
+	switch (domain->type) {
 	case IOMMU_DOMAIN_UNMANAGED:
 		switch (attr) {
 		case DOMAIN_ATTR_NESTING:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 7f280c8..f3985f3 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -81,7 +81,7 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)

 static const struct iommu_ops qcom_iommu_ops;

-static struct qcom_iommu_dev * to_iommu(struct device *dev)
+static struct qcom_iommu_dev *to_iommu(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);

@@ -91,7 +91,7 @@ static struct qcom_iommu_dev * to_iommu(struct device *dev)
 	return dev_iommu_priv_get(dev);
 }

-static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
+static struct qcom_iommu_ctx *to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
 	if (!qcom_iommu)
--
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
