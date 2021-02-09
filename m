Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C9C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:36:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2174B64EB1
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2174B64EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D05CC863A4;
	Tue,  9 Feb 2021 12:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-LfUVMKL-1W; Tue,  9 Feb 2021 12:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B98986303;
	Tue,  9 Feb 2021 12:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25A7AC0174;
	Tue,  9 Feb 2021 12:36:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A205C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1ED46865F6
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5+6Cf6i+yCDJ for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:36:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so15.mailgun.net (so15.mailgun.net [198.61.254.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D4C8286B2C
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:36:40 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1612874202; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=XA1/wY6qzZKfm1+w+nC9ectbnZF3AqmFvZoAzmlwiLM=;
 b=mXRoUBt/xVQj3PZcoplFicxr4iHlNoCA4mmY8Ndi0i1UPVDZlqJidA80lxuNOfPeG8ErXJYs
 po/PT5zXexlaktH+RR+rZ1/VgjpAM09Oa/Baj5hE5QOBy6aD4M2t9AYgTVfObAK5XIEK7zDY
 tRnwVWZ6yEwSIGifPrPfr2ZfZ3M=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 602281d3830f898bac1f7492 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 12:36:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E0CECC43464; Tue,  9 Feb 2021 12:36:34 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CD79C433C6;
 Tue,  9 Feb 2021 12:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CD79C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Add device name to iommu map/unmap trace events
Date: Tue,  9 Feb 2021 18:06:20 +0530
Message-Id: <20210209123620.19993-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
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

IOMMU map/unmap traces become hard to decode i.e., it becomes hard
to associate the map/unmap events with the particular device from
the iova/paddr/size parameters alone when there are multiple
devices attached. So it is useful to add the device name to iommu
trace events which can be used to filter out map/unmap traces for
a particular device when we are debugging iommu faults such as
context faults where we are interested with the map/unmap traces
for a specific device.

Before:
  map: IOMMU: iova=0x0000000ffff36000 paddr=0x00000001164d8000 size=4096
  unmap: IOMMU: iova=0x0000000ffff36000 size=4096 unmapped_size=4096

After:
  map: IOMMU: dev=1d84000.ufshc iova=0x0000000fffa88000 paddr=0x00000001063db000 size=4096
  unmap: IOMMU: dev=1d84000.ufshc iova=0x0000000fffa88000 size=4096 unmapped_size=4096

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/iommu.c        |  8 +++++---
 include/linux/iommu.h        |  1 +
 include/trace/events/iommu.h | 20 ++++++++++++--------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..37081b745f38 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1947,8 +1947,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
+	if (!ret) {
 		trace_attach_device_to_domain(dev);
+		strscpy(domain->dev_name, dev_name(dev), sizeof(domain->dev_name));
+	}
 	return ret;
 }
 
@@ -2440,7 +2442,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
 	else
-		trace_map(orig_iova, orig_paddr, orig_size);
+		trace_map(orig_iova, orig_paddr, orig_size, domain->dev_name);
 
 	return ret;
 }
@@ -2523,7 +2525,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		unmapped += unmapped_page;
 	}
 
-	trace_unmap(orig_iova, size, unmapped);
+	trace_unmap(orig_iova, size, unmapped, domain->dev_name);
 	return unmapped;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..6064187d9bb6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -87,6 +87,7 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	char dev_name[32];
 };
 
 enum iommu_cap {
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 72b4582322ff..44e48fb8b677 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -85,47 +85,51 @@ DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
 
 TRACE_EVENT(map,
 
-	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
+	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size, const char *dev_name),
 
-	TP_ARGS(iova, paddr, size),
+	TP_ARGS(iova, paddr, size, dev_name),
 
 	TP_STRUCT__entry(
 		__field(u64, iova)
 		__field(u64, paddr)
 		__field(size_t, size)
+		__string(dev_name, dev_name)
 	),
 
 	TP_fast_assign(
 		__entry->iova = iova;
 		__entry->paddr = paddr;
 		__entry->size = size;
+		__assign_str(dev_name, dev_name);
 	),
 
-	TP_printk("IOMMU: iova=0x%016llx paddr=0x%016llx size=%zu",
-			__entry->iova, __entry->paddr, __entry->size
+	TP_printk("IOMMU: dev=%s iova=0x%016llx paddr=0x%016llx size=%zu",
+		  __get_str(dev_name), __entry->iova, __entry->paddr, __entry->size
 	)
 );
 
 TRACE_EVENT(unmap,
 
-	TP_PROTO(unsigned long iova, size_t size, size_t unmapped_size),
+	TP_PROTO(unsigned long iova, size_t size, size_t unmapped_size, const char *dev_name),
 
-	TP_ARGS(iova, size, unmapped_size),
+	TP_ARGS(iova, size, unmapped_size, dev_name),
 
 	TP_STRUCT__entry(
 		__field(u64, iova)
 		__field(size_t, size)
 		__field(size_t, unmapped_size)
+		__string(dev_name, dev_name)
 	),
 
 	TP_fast_assign(
 		__entry->iova = iova;
 		__entry->size = size;
 		__entry->unmapped_size = unmapped_size;
+		__assign_str(dev_name, dev_name);
 	),
 
-	TP_printk("IOMMU: iova=0x%016llx size=%zu unmapped_size=%zu",
-			__entry->iova, __entry->size, __entry->unmapped_size
+	TP_printk("IOMMU: dev=%s iova=0x%016llx size=%zu unmapped_size=%zu",
+		  __get_str(dev_name), __entry->iova, __entry->size, __entry->unmapped_size
 	)
 );
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
