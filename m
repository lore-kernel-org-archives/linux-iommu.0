Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF66CC43333
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D1E20786
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUTHQuUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D1E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5174687316;
	Fri, 20 Mar 2020 16:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtYspsPmBGMw; Fri, 20 Mar 2020 16:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C1FF8872DD;
	Fri, 20 Mar 2020 16:11:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE259C1830;
	Fri, 20 Mar 2020 16:11:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF31C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3BA3E87300
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UG2yVCEP2R35 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C586872DD
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfkwkXd978FVQfp2tm/Q77JARSBPMPBee3xOehCW3DA=;
 b=eUTHQuUmr/6UVExqLozRdRBlpAuKckISTnad6LIKRBH6b210T7l7262snYzNqNg8UX//WR
 L8vkzRwfe+6XfIvP8nhDEKQKhdqw7IPTC0aSUM53GzX+7cwXEgzjywkM5XWNHbpSdtF7+e
 duKkJKgigyluWpG/dsEIoh+dVCJ+WLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-w8SAdKAhNbCv2E32Sbkhtw-1; Fri, 20 Mar 2020 12:11:15 -0400
X-MC-Unique: w8SAdKAhNbCv2E32Sbkhtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77A4C1088386;
 Fri, 20 Mar 2020 16:10:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 703785C545;
 Fri, 20 Mar 2020 16:10:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v10 07/13] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Date: Fri, 20 Mar 2020 17:09:26 +0100
Message-Id: <20200320160932.27222-8-eric.auger@redhat.com>
In-Reply-To: <20200320160932.27222-1-eric.auger@redhat.com>
References: <20200320160932.27222-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: marc.zyngier@arm.com, peter.maydell@linaro.org
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

With nested stage support, soon we will need to invalidate
S1 contexts and ranges tagged with an unmanaged asid, this
latter being managed by the guest. So let's introduce 2 helpers
that allow to invalidate with externally managed ASIDs

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 92a1a5ac5b50..39deddea6ae5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2301,13 +2301,18 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 }
 
 /* IO_PGTABLE API */
-static void arm_smmu_tlb_inv_context(void *cookie)
+
+static void __arm_smmu_tlb_inv_context(struct arm_smmu_domain *smmu_domain,
+				       int ext_asid)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (ext_asid >= 0) { /* guest stage 1 invalidation */
+		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
+		cmd.tlbi.asid	= ext_asid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
 		cmd.tlbi.vmid	= 0;
@@ -2328,9 +2333,17 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
-static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
+static void arm_smmu_tlb_inv_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	__arm_smmu_tlb_inv_context(smmu_domain, -1);
+}
+
+static void __arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 				   size_t granule, bool leaf,
-				   struct arm_smmu_domain *smmu_domain)
+				   struct arm_smmu_domain *smmu_domain,
+				   int ext_asid)
 {
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
@@ -2345,7 +2358,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 	if (!size)
 		return;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (ext_asid >= 0) {  /* guest stage 1 invalidation */
+		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		cmd.tlbi.asid	= ext_asid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
 	} else {
@@ -2405,6 +2422,13 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 	arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
 }
 
+static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
+				   size_t granule, bool leaf,
+				   struct arm_smmu_domain *smmu_domain)
+{
+	__arm_smmu_tlb_inv_range(iova, size, granule, leaf, smmu_domain, -1);
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
