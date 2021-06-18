Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D137C49EBD
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 16:07:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D031613F3
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 16:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D031613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AB26400DC;
	Fri, 18 Jun 2021 16:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0yV0Km1GA633; Fri, 18 Jun 2021 16:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2B2940251;
	Fri, 18 Jun 2021 16:07:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2451DC002B;
	Fri, 18 Jun 2021 16:07:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74373C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C1CC83B27
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SeRTefq3aydy for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C80283B15
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 16:07:19 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15IG26av010929; Fri, 18 Jun 2021 16:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2j4DFmaqTg7mJII5mjXL3wo0zAK/9f6Mm+ri23jZ0dk=;
 b=Uz9Z6JJQ8ROB/Vco+gOwLn4gXHx/W6iZAg2KPPYebakmWrLiFNrgYj2mnFHC/4/6tYgi
 FyrvMEgO1WqPdJcL8+MkT7PLmw1jwAiWLhEKSHOOD7uaKIolhayMPd5n8vyuKnH60Q/l
 xkp2PsjOLjcVxMenCA1pllqKzZ8KyEP3kqCSXcynRnXdjBjNgxFKKPPUg3J5PMEFALD3
 g6tSa/tTZnJDPdA7IlBO6H6E/9iTqu84Yz7RkahXri9mYiz7sTOx7z7ZVf1TDE6HohDZ
 mBTgqC+Zk3yj6LMaHYNs5k2lBjLwfLUAzsuEuQIslZ5dQ9GI7ylsq/jnajA1hXxlmK/3 gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 398xmp00cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 16:06:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1Pvn108711;
 Fri, 18 Jun 2021 16:06:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 396wawv2rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 16:06:58 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG3fFt114314;
 Fri, 18 Jun 2021 16:06:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 396wawv2q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 16:06:58 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6tHa021864;
 Fri, 18 Jun 2021 16:06:55 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 18 Jun 2021 16:06:55 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with Secure
 Launch
Date: Fri, 18 Jun 2021 12:12:57 -0400
Message-Id: <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: 2dcc9vhgXW8othlKgr_oTBs9RkM_O--n
X-Proofpoint-GUID: 2dcc9vhgXW8othlKgr_oTBs9RkM_O--n
Cc: dpsmith@apertussolutions.com, ross.philipson@oracle.com,
 luto@amacapital.net, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 tglx@linutronix.de, trenchboot-devel@googlegroups.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IOMMU should always be set to default translated type after
the PMRs are disabled to protect the MLE from DMA.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/iommu/intel/iommu.c | 5 +++++
 drivers/iommu/iommu.c       | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284..4f0256d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -41,6 +41,7 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device *dev)
  */
 static int device_def_domain_type(struct device *dev)
 {
+	/* Do not allow identity domain when Secure Launch is configured */
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		return IOMMU_DOMAIN_DMA;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d..d49b7dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/slaunch.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
 {
 	if (cmd_line)
 		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
-	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+
+	/* Do not allow identity domain when Secure Launch is configured */
+	if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
+		iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 }
 
 void iommu_set_default_translated(bool cmd_line)
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
