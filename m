Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99062C10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615D9218D9
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjfhBAP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615D9218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 35DD9DD5;
	Mon, 22 Apr 2019 19:45:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFF7ADD4
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 19:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 949A2F4
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 19:45:07 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
	[73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AB3DD21902;
	Mon, 22 Apr 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962307;
	bh=IAPikkAGx80dK1h5T9epE5Abk7jyy3k1wkTycyh9lBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjfhBAP9sWOr6bN6PcptyyaUHBWT6h3bhLSS6rxdJtiYCSAbJ2Rxa9zNe17yXiSrq
	PCwqA3SohJKWYv9HcCX/49nJF4DgD160stQee8UQwyUzaVUbSkLuEOT66W0Tz0Wi4q
	/fFlN4hZm6FCwr1dyyQoF8SsuxNQ51FI9861pTZM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 94/98] iommu/amd: Reserve exclusion range in
	iova-domain
Date: Mon, 22 Apr 2019 15:42:01 -0400
Message-Id: <20190422194205.10404-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422194201.-vJFezQQg-LwpLpkqqLWE3SMi_S1wqfHp3T_zaca5hM@z>

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 8aafaaf2212192012f5bae305bb31cdf7681d777 ]

If a device has an exclusion range specified in the IVRS
table, this region needs to be reserved in the iova-domain
of that device. This hasn't happened until now and can cause
data corruption on data transfered with these devices.

Treat exclusion ranges as reserved regions in the iommu-core
to fix the problem.

Fixes: be2a022c0dd0 ('x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c       | 9 ++++++---
 drivers/iommu/amd_iommu_init.c  | 7 ++++---
 drivers/iommu/amd_iommu_types.h | 2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e628ef23418f..55b3e4b9d5dc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3166,21 +3166,24 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
+		int type, prot = 0;
 		size_t length;
-		int prot = 0;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
+		type   = IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
 		if (entry->prot & IOMMU_PROT_IR)
 			prot |= IOMMU_READ;
 		if (entry->prot & IOMMU_PROT_IW)
 			prot |= IOMMU_WRITE;
+		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
+			/* Exclusion range */
+			type = IOMMU_RESV_RESERVED;
 
 		region = iommu_alloc_resv_region(entry->address_start,
-						 length, prot,
-						 IOMMU_RESV_DIRECT);
+						 length, prot, type);
 		if (!region) {
 			pr_err("Out of memory allocating dm-regions for %s\n",
 				dev_name(dev));
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 66123b911ec8..84fa5b22371e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2013,6 +2013,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (e == NULL)
 		return -ENOMEM;
 
+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
+		init_exclusion_range(m);
+
 	switch (m->type) {
 	default:
 		kfree(e);
@@ -2059,9 +2062,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & IVMD_FLAG_EXCL_RANGE)
-			init_exclusion_range(m);
-		else if (m->flags & IVMD_FLAG_UNITY_MAP)
+		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m);
 
 		p += m->length;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index eae0741f72dc..87965e4d9647 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -374,6 +374,8 @@
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
 
+#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
+
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
 #define IOMMU_CAP_NPCACHE 26
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
