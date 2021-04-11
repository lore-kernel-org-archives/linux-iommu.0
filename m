Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0EC43460
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:14:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453DA610E9
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453DA610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0490B608E5;
	Sun, 11 Apr 2021 11:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GuiG1YdM4nVk; Sun, 11 Apr 2021 11:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41989608DD;
	Sun, 11 Apr 2021 11:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27E0CC000C;
	Sun, 11 Apr 2021 11:14:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18E4DC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08C73839CF
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XVVA4rOxJfF for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 11:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F1AC839BD
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618139639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRYnhQhb05B8YhcVRfZApDTriNBnSPCrLNpmbX3DZG4=;
 b=X2s3ZuKWGvHVh4VyiLh/Ny4tqGboiqu7eZJgIckW+3uncsA3TSjpFoyy/IU8f5bgai+UFx
 g4Rf5CjGO1uVn4eKiTC+O+PMPFxGEie4lGrn8St4wYHinNXnRMD0O9oYP9UBBWbXxfDb9a
 4ZAeCZQ8eCI2zU60EGbZYCSYNs4NhOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-XJGgJKNXNuaVMQuWS6eKKQ-1; Sun, 11 Apr 2021 07:13:57 -0400
X-MC-Unique: XJGgJKNXNuaVMQuWS6eKKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99491006C80;
 Sun, 11 Apr 2021 11:13:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00708100164A;
 Sun, 11 Apr 2021 11:13:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v15 06/12] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Date: Sun, 11 Apr 2021 13:12:22 +0200
Message-Id: <20210411111228.14386-7-eric.auger@redhat.com>
In-Reply-To: <20210411111228.14386-1-eric.auger@redhat.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 vivek.gautam@arm.com, vsethi@nvidia.com, zhangfei.gao@linaro.org,
 jiangkunkun@huawei.com
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

v14 -> v15:
- Always send CMDQ_OP_TLBI_NH_VA and do not test
  smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H as the guest does
  not run in hyp mode atm (Zenghui).

v13 -> v14
- Actually send the NH_ASID command (reported by Xingang Wang)
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 ++++++++++++++++-----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 44cdc6df09c1..56a301fbe75a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1851,9 +1851,9 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 }
 
 /* IO_PGTABLE API */
-static void arm_smmu_tlb_inv_context(void *cookie)
+static void __arm_smmu_tlb_inv_context(struct arm_smmu_domain *smmu_domain,
+				       int ext_asid)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd;
 
@@ -1864,7 +1864,13 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (ext_asid >= 0) { /* guest stage 1 invalidation */
+		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
+		cmd.tlbi.asid	= ext_asid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		arm_smmu_cmdq_issue_sync(smmu);
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
@@ -1875,6 +1881,13 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
+static void arm_smmu_tlb_inv_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	__arm_smmu_tlb_inv_context(smmu_domain, -1);
+}
+
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 				     unsigned long iova, size_t size,
 				     size_t granule,
@@ -1934,9 +1947,10 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
-static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-					  size_t granule, bool leaf,
-					  struct arm_smmu_domain *smmu_domain)
+static void
+arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
+			      size_t granule, bool leaf, int ext_asid,
+			      struct arm_smmu_domain *smmu_domain)
 {
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
@@ -1944,7 +1958,16 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		},
 	};
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (ext_asid >= 0) {  /* guest stage 1 invalidation */
+		/*
+		 * At the moment the guest only uses NS-EL1, to be
+		 * revisited when nested virt gets supported with E2H
+		 * exposed.
+		 */
+		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		cmd.tlbi.asid	= ext_asid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
@@ -1952,6 +1975,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
+
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	/*
@@ -1990,7 +2014,7 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
-	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
+	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, -1, cookie);
 }
 
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
@@ -2531,7 +2555,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 
 	arm_smmu_tlb_inv_range_domain(gather->start,
 				      gather->end - gather->start + 1,
-				      gather->pgsize, true, smmu_domain);
+				      gather->pgsize, true, -1, smmu_domain);
 }
 
 static phys_addr_t
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
