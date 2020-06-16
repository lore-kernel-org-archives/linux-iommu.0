Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3383C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63399208B3
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRxIqLR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63399208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3423A893AE;
	Tue, 16 Jun 2020 14:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yc9GV9kOxYcF; Tue, 16 Jun 2020 14:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FE728937D;
	Tue, 16 Jun 2020 14:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D2FFC07FF;
	Tue, 16 Jun 2020 14:49:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53050C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 418F7877A6
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vJAsinmJ4jF1 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 14:48:58 +0000 (UTC)
X-Greylist: delayed 06:20:26 by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 50C858779C
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:48:58 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id gl26so21775812ejb.11
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6zJ1ro/1WnNh9ke4tywP5KbL3kzsxhy9IOq2L8+wSs=;
 b=dRxIqLR/l7U/1wiuNrWXAuxmWaS8Kz3utjBr+naKr/fAnhgPXGs03Df2912obU/1bf
 WadnmoMXmmdUZ9EqCn/HniUvnGaZB4bKHcL/mm/zY3lnt8vIJ2CbZtfKyxieOwjeDrvp
 xXQDAnJrXrLoGa+NcRXczCWenow54qu31pqXb2DbWS3z23GDSN4PVFYytjNq4AJos71y
 gbmvwExnyksPD9dJaKTEumJFxGXC+AeS0ABIC+qm13/ybBqDrKsozre/9+Ktu993icLD
 OONWnKdS7zlXHKk8jYBTjgFj6k0bYdZgYTG6OW5OyzKf93WWToB1CDgiqMt4QL69BFjr
 u0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6zJ1ro/1WnNh9ke4tywP5KbL3kzsxhy9IOq2L8+wSs=;
 b=PJ/ZQ8CUmLddBDxdTjabRtq7MV6H6h7vC1JMnitzGcmCCQ7+XSg6Hpz3ntSM5u5nze
 q0tBH8lGYLVqyWpNmuC8IWb3B5D7CJFr7DNNG1XjaxndlMvW2Wfdqqiq4RL02BPieqhx
 /29k3CtukZ4YhTsL+asmK6IKgz2PgELVUAlExOC14+ad0fHYd5fQHJa4g5xgCXV5u6KB
 JvRjDUlapCyTl6TfJTIrvA3RKJLU7+vA7uigC6r9T7iQxn8yh/t/xzM4M2qqTk+aVTKO
 LeiL918E8cnam9sJbVPDNjzRT7Xhadr0XU+yujEVV0rOWDiR89qczZqkytqUb1Vn81rq
 BRew==
X-Gm-Message-State: AOAM532p5A2A4nF0PtZ/ld53j62d7dV6HG2t3/IVMfW5uaZNdsyKXBuD
 RvPgrrUypqYtR6hKpT2WZc4LtA==
X-Google-Smtp-Source: ABdhPJwQ0QgG8PR9DeG1zwjqB8x7BMt2H8ZKhJzACJ0pukGEzpbQuwJ4SuzV2QdwhFBTISWRUVRKqQ==
X-Received: by 2002:a17:906:1c8e:: with SMTP id
 g14mr3160606ejh.136.1592318936607; 
 Tue, 16 Jun 2020 07:48:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h9sm10175109edr.65.2020.06.16.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 07:48:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH] iommu: Allow page responses without PASID
Date: Tue, 16 Jun 2020 16:47:14 +0200
Message-Id: <20200616144712.748818-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
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

Some PCIe devices do not expect a PASID value in PRI Page Responses.
If the "PRG Response PASID Required" bit in the PRI capability is zero,
then the OS should not set the PASID field. Similarly on Arm SMMU,
responses to stall events do not have a PASID.

Currently iommu_page_response() systematically checks that the PASID in
the page response corresponds to the one in the page request. This can't
work with virtualization because a page response coming from a guest OS
won't have a PASID if the passed-through device does not require one.

Add a flag to page requests that declares whether the corresponding
response needs to have a PASID. When this flag isn't set, allow page
responses without PASID.

Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/iommu.h |  6 +++++-
 drivers/iommu/iommu.c      | 23 +++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index e907b7091a463..c2b2caf9ed412 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -81,7 +81,10 @@ struct iommu_fault_unrecoverable {
 /**
  * struct iommu_fault_page_request - Page Request data
  * @flags: encodes whether the corresponding fields are valid and whether this
- *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_* values)
+ *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_* values).
+ *         When IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID is set, the page response
+ *         must have the same PASID value as the page request. When it is clear,
+ *         the page response should not have a PASID.
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
@@ -92,6 +95,7 @@ struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
 #define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
+#define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 3)
 	__u32	flags;
 	__u32	pasid;
 	__u32	grpid;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d43120eb1dc56..1ed1e14a1f0cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1185,11 +1185,12 @@ EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 int iommu_page_response(struct device *dev,
 			struct iommu_page_response *msg)
 {
-	bool pasid_valid;
+	bool needs_pasid;
 	int ret = -EINVAL;
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
+	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
 	if (!domain || !domain->ops->page_response)
@@ -1214,14 +1215,24 @@ int iommu_page_response(struct device *dev,
 	 */
 	list_for_each_entry(evt, &param->fault_param->faults, list) {
 		prm = &evt->fault.prm;
-		pasid_valid = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		if (prm->grpid != msg->grpid)
+			continue;
 
-		if ((pasid_valid && prm->pasid != msg->pasid) ||
-		    prm->grpid != msg->grpid)
+		/*
+		 * If the PASID is required, the corresponding request is
+		 * matched using the group ID, the PASID valid bit and the PASID
+		 * value. Otherwise only the group ID matches request and
+		 * response.
+		 */
+		needs_pasid = prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+		if (needs_pasid && (!has_pasid || msg->pasid != prm->pasid))
 			continue;
 
-		/* Sanitize the reply */
-		msg->flags = pasid_valid ? IOMMU_PAGE_RESP_PASID_VALID : 0;
+		if (!needs_pasid && has_pasid) {
+			/* No big deal, just clear it. */
+			msg->flags &= ~IOMMU_PAGE_RESP_PASID_VALID;
+			msg->pasid = 0;
+		}
 
 		ret = domain->ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
