Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC310C433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:46:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947EC6109E
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 947EC6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7099D818C4;
	Wed, 27 Oct 2021 10:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFTAYLbJOZIU; Wed, 27 Oct 2021 10:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51E51818DC;
	Wed, 27 Oct 2021 10:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4A6C0019;
	Wed, 27 Oct 2021 10:46:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90D14C000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E8F2818DC
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2O3MffvJ1oTj for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 10:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF9D5818C4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635331568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wWoc6t6AOckXTnAZ7Ldd/3Pb194iKhVVhHdl2FeLkU=;
 b=IzI95/VrB9SvVUZbRKnnPQ37IIYWIeTbLd7H3WGWiVho84TWYDDzU0Ee95Lvwtgc0AlDFa
 9uw+zprhO9Ba5gR9ZkL0c3Lk3YcIRb3mWofPBli+U8vJ/i1hfFIcIrh8sc0J+uzaefdaLL
 RIAhSYtmCeHHxbuasFMtdz465y9z9K4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-IBd4Yo9MP-WEqWhBBS6iLQ-1; Wed, 27 Oct 2021 06:46:05 -0400
X-MC-Unique: IBd4Yo9MP-WEqWhBBS6iLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E07210A8E04;
 Wed, 27 Oct 2021 10:46:02 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E769610016FE;
 Wed, 27 Oct 2021 10:45:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
Subject: [RFC v16 5/9] iommu/smmuv3: Implement attach/detach_pasid_table
Date: Wed, 27 Oct 2021 12:44:24 +0200
Message-Id: <20211027104428.1059740-6-eric.auger@redhat.com>
In-Reply-To: <20211027104428.1059740-1-eric.auger@redhat.com>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 maz@kernel.org, vivek.gautam@arm.com, alex.williamson@redhat.com,
 vsethi@nvidia.com, zhangfei.gao@linaro.org, lushenming@huawei.com,
 wangxingang5@huawei.com
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

On attach_pasid_table() we program STE S1 related info set
by the guest into the actual physical STEs. At minimum
we need to program the context descriptor GPA and compute
whether the stage1 is translated/bypassed or aborted.

On detach, the stage 1 config is unset and the abort flag is
unset.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v14 -> v15:
- add a comment before arm_smmu_get_cd_ptr to warn the
  developper this function must not be used in case of nested
  (Keqian)

v13 -> v14:
- on PASID table detach, reset the abort flag (Keqian)

v7 -> v8:
- remove smmu->features check, now done on domain finalize

v6 -> v7:
- check versions and comment the fact we don't need to take
  into account s1dss and s1fmt
v3 -> v4:
- adapt to changes in iommu_pasid_table_config
- different programming convention at s1_cfg/s2_cfg/ste.abort

v2 -> v3:
- callback now is named set_pasid_table and struct fields
  are laid out differently.

v1 -> v2:
- invalidate the STE before changing them
- hold init_mutex
- handle new fields
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 93 +++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5e0917e1226b..bb2681581283 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1004,6 +1004,10 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
+/*
+ * Must not be used in case of nested mode where the CD table is owned
+ * by the guest
+ */
 static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 				   u32 ssid)
 {
@@ -2809,6 +2813,93 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
+static int arm_smmu_attach_pasid_table(struct iommu_domain *domain,
+				       struct iommu_pasid_table_config *cfg)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu;
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (cfg->format != IOMMU_PASID_FORMAT_SMMUV3)
+		return -EINVAL;
+
+	if (cfg->version != PASID_TABLE_CFG_VERSION_1 ||
+	    cfg->vendor_data.smmuv3.version != PASID_TABLE_SMMUV3_CFG_VERSION_1)
+		return -EINVAL;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		goto out;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		goto out;
+
+	switch (cfg->config) {
+	case IOMMU_PASID_CONFIG_ABORT:
+		smmu_domain->s1_cfg.set = false;
+		smmu_domain->abort = true;
+		break;
+	case IOMMU_PASID_CONFIG_BYPASS:
+		smmu_domain->s1_cfg.set = false;
+		smmu_domain->abort = false;
+		break;
+	case IOMMU_PASID_CONFIG_TRANSLATE:
+		/* we do not support S1 <-> S1 transitions */
+		if (smmu_domain->s1_cfg.set)
+			goto out;
+
+		/*
+		 * we currently support a single CD so s1fmt and s1dss
+		 * fields are also ignored
+		 */
+		if (cfg->pasid_bits)
+			goto out;
+
+		smmu_domain->s1_cfg.cdcfg.cdtab_dma = cfg->base_ptr;
+		smmu_domain->s1_cfg.set = true;
+		smmu_domain->abort = false;
+		break;
+	default:
+		goto out;
+	}
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_install_ste_for_dev(master);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	ret = 0;
+out:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
+static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master *master;
+	unsigned long flags;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		goto unlock;
+
+	smmu_domain->s1_cfg.set = false;
+	smmu_domain->abort = false;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_install_ste_for_dev(master);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+unlock:
+	mutex_unlock(&smmu_domain->init_mutex);
+}
+
 static bool arm_smmu_dev_has_feature(struct device *dev,
 				     enum iommu_dev_features feat)
 {
@@ -2906,6 +2997,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.attach_pasid_table	= arm_smmu_attach_pasid_table,
+	.detach_pasid_table	= arm_smmu_detach_pasid_table,
 	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
