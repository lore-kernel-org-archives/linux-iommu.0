Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796DC433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 15:43:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8597720782
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cUr6tPbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8597720782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5856D886C4;
	Tue, 25 Aug 2020 15:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUuJ6QopmuDq; Tue, 25 Aug 2020 15:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5B98886A3;
	Tue, 25 Aug 2020 15:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C24C07FF;
	Tue, 25 Aug 2020 15:43:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF755C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BBC1B87FB5
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e3whyDnYdgDb for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 15:43:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3683E876DB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:43:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598370230; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=vPjwRTcbHtJglbBEf+g+zBKRbHTS9GuM+a7BNj5yuBU=;
 b=cUr6tPbXgJUELQIvdJVT+LXeZE6owcZ4Wg5OFo4ywg9C4UN8p9oTiOyLLVbfRGEvAX4vC6U8
 tKEZbPpfuziG6JPozmjLHpSGSHspSArwlMCD5Alb3oJFLCxnoVIYB0nc8LOEZDRZaLazU1Tc
 BJ7vK1HBXsSoaOSQL12/25N02ZQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f45318d9b97d7ba7b2bcfd8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 15:43:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 69766C433AD; Tue, 25 Aug 2020 15:43:08 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 65BAAC433C6;
 Tue, 25 Aug 2020 15:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65BAAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] iommu: Add support to filter non-strict/lazy mode based on
 device names
Date: Tue, 25 Aug 2020 21:12:49 +0530
Message-Id: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Currently the non-strict or lazy mode of TLB invalidation can only be set
for all or no domains. This works well for development platforms where
setting to non-strict/lazy mode is fine for performance reasons but on
production devices, we need a more fine grained control to allow only
certain peripherals to support this mode where we can be sure that it is
safe. So add support to filter non-strict/lazy mode based on the device
names that are passed via cmdline parameter "iommu.nonstrict_device".

Example: iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..fd10a073f557 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,9 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = true;
 static u32 iommu_cmd_line __read_mostly;
 
+#define DEVICE_NAME_LEN		1024
+static char nonstrict_device[DEVICE_NAME_LEN] __read_mostly;
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -327,6 +330,32 @@ static int __init iommu_dma_setup(char *str)
 }
 early_param("iommu.strict", iommu_dma_setup);
 
+static int __init iommu_nonstrict_filter_setup(char *str)
+{
+	strlcpy(nonstrict_device, str, DEVICE_NAME_LEN);
+	return 1;
+}
+__setup("iommu.nonstrict_device=", iommu_nonstrict_filter_setup);
+
+static bool iommu_nonstrict_device(struct device *dev)
+{
+	char *filter, *device;
+
+	if (!dev)
+		return false;
+
+	filter = kstrdup(nonstrict_device, GFP_KERNEL);
+	if (!filter)
+		return false;
+
+	while ((device = strsep(&filter, ","))) {
+		if (!strcmp(device, dev_name(dev)))
+			return true;
+	}
+
+	return false;
+}
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1470,7 +1499,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 
 static int iommu_group_alloc_default_domain(struct bus_type *bus,
 					    struct iommu_group *group,
-					    unsigned int type)
+					    unsigned int type, struct device *dev)
 {
 	struct iommu_domain *dom;
 
@@ -1489,7 +1518,7 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	if (!group->domain)
 		group->domain = dom;
 
-	if (!iommu_dma_strict) {
+	if (!iommu_dma_strict || iommu_nonstrict_device(dev)) {
 		int attr = 1;
 		iommu_domain_set_attr(dom,
 				      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
@@ -1509,7 +1538,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev);
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
 }
 
 /**
@@ -1684,7 +1713,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
 
 }
 

base-commit: e46b3c0d011eab9933c183d5b47569db8e377281
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
