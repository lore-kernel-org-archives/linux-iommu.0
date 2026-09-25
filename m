Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FA349CD2
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298799; cv=none; b=YXQ2Xa05WVdEr6H2Bry1yNSSAqHwnreP/CudwEN36p+BW97Ci4f3iXFPys6f1jKi5O0cZoyHaPinMs1+Dn0uWHjH389WgIIL8KlRs4/f7hvwsc6L1ZH4i+epnzsekcxHJvJYJmgtVWmdWNprIgrVgAZRp54txT0y6lb2wRAbwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298799; c=relaxed/simple;
	bh=olGKtxlwn+yhg4dpPmL5Bvr0U6JSMPIbqlhgOBWdrKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kXZMQ18iYY7csWnicBS37KpUEUQ+Cx0j6/dM0ZlqgEVTNNMSt1xCQL1ES8kGjyxG2wax8DRYsXGQTqBQC4yvUwkBuxhT9ABU0uL8D0W5sIKIqLmcnNJOJFB3MFW1vDP1B2/5RLgF/zK5N5hNwmKxTZCa3+L9lerjtenLdRN6Srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7KEpDfz; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7KEpDfz"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc72777faa2so198149a12.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790298794; x=1790903594; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wql0u/3ksmOdy8r//TkBURdk2dF75TPdcHGkWL4FBiE=;
        b=Q7KEpDfzljG9NAk9qm05jWtgJKN+VeN7Uo96d0yzagohbjmePRMeW8CIBw6jK4jvww
         V70YPnoQO4t6XC2fSD6dSJ37ftnuSnnYvvv0ZKgIlybcIl9zolTRUNz80X5n83ZJTrEg
         6BtNnVSTqhXlvQbNlh/KjZf28w87DH4TcE9PKJxIHxv8gHSMJch6qFcZo0mfo8WI7Du6
         Yw9P8QMJHX/Z1HffwxGHtt1N5yW9aCQq5EyONcDelxndRb9X3+wpITwyuPHYVomycIP3
         lkZIttZpjAiiXpeoaceKnA6aZsVuhEM5aoDnLZZkFw/CMfzpzdNWdOf9bH/pH9lgKj00
         Syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298794; x=1790903594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wql0u/3ksmOdy8r//TkBURdk2dF75TPdcHGkWL4FBiE=;
        b=X+21StS/wKwhF1b44n1nXSp6rWHNXmDZC2L255CGRqQ2O901/i7kB1SA4hKEmPsM4d
         usBQcHjNwGoiHBQ37ICNOsgkjgM/tzWvAsFeuwMt3BJRGLjNEmb799gP680kwzbkkRQj
         jxpRmyaYzc3mWfqz8RZr7DtdeNDJMG9Uoqqjbx/AQAvJb6BeK7mth/IY4UF7f4Abz0Fv
         8A37lr+BEr/DiTeTVETYr3sKHYFPwpbg6/fFuBY0OzaL46QyM9pdhG6xKnTX2mc8QiQp
         jtfiZKfUQviK7IIvlizHDTYaj2gbaoXoqxqxzlsEMnaSO7VFsqVLFSrls5e6n0ip1XFl
         eDaA==
X-Forwarded-Encrypted: i=1; AKwUvBzeQaHkHYXJyx95SFr/C2jYYhySgySx0JTm2DvSBUBMxqdzxz0bItIaxyp7ny/OXJvBdnZhKw==@lists.linux.dev
X-Gm-Message-State: AFuF++kFxJZRQTJN/qrPXj8BPSWIYDQAML9JwywX7Ej5Ltd3ajP1f9Y6
	WaveWcAl5u+0ZUmUHis/Kjvj/Pr4LDcCEn5O/ZI6fH+W2b+ib7lJx+DoQx3HZEACHiD63al+Qup
	w5dJ6H9Iql9xF5Q==
X-Received: from pgbbf22.prod.google.com ([2002:a65:6d16:0:b0:cc7:620f:a25f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7485:b0:3dd:a195:fa1b with SMTP id adf61e73a8af0-3de0e9a0863mr3871178637.64.1790298794332;
 Thu, 24 Sep 2026 18:13:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:13:07 +0000
In-Reply-To: <20260925011308.3381953-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260925011308.3381953-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925011308.3381953-4-skhawaja@google.com>
Subject: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless replace of
 S1 domains
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

S1 domains are programmed by CD entries in the CD table. During a new
domain attach these are updated using write_cd_entry. Since ASID and
TTB0 are in different 64-bit words, the write_cd_entry considers it a
non-hitless update and sets V=0. This means such an update is disruptive
and would generate translation faults if there are ongoing DMAs.

Replace the CD entries by using an unused temporary ASID in following
sequence to allow hitless replacement of CD entry,

- Update the CD entry with temporary ASID.
- Update the CD entry with the target TTB0.
- Update the CD entry with the target ASID.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..59f4b8cf89f6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1641,6 +1641,68 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
 }
 
+/* Invalidate every stage-1 TLB entry tagged with @asid. */
+static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
+{
+	enum arm_smmu_cmdq_opcode op = (smmu->features & ARM_SMMU_FEAT_E2H) ?
+					       CMDQ_OP_TLBI_EL2_ASID :
+					       CMDQ_OP_TLBI_NH_ASID;
+
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu,
+					  arm_smmu_make_cmd_tlbi(op, asid, 0));
+}
+
+static void arm_smmu_cd_set_asid(struct arm_smmu_cd *cd, u16 asid)
+{
+	cd->data[0] &= ~cpu_to_le64(CTXDESC_CD_0_ASID);
+	cd->data[0] |= cpu_to_le64(FIELD_PREP(CTXDESC_CD_0_ASID, asid));
+}
+
+static void arm_smmu_replace_cd_entry(struct arm_smmu_master *master, int ssid,
+				      struct arm_smmu_cd *cdptr,
+				      const struct arm_smmu_cd *target)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cd stage;
+	u32 tmp_asid;
+
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	/*
+	 * Nothing is translating through an invalid CD, and an update that
+	 * invalidates one cannot be made hitless anyway.
+	 */
+	if (!(cdptr->data[0] & cpu_to_le64(CTXDESC_CD_0_V)) ||
+	    !(target->data[0] & cpu_to_le64(CTXDESC_CD_0_V)))
+		goto write_directly;
+
+	if (xa_alloc(&arm_smmu_asid_xa, &tmp_asid, XA_ZERO_ENTRY,
+		     XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL))
+		goto write_directly;
+
+	/* Copy the existing cd entry and update only the ASID. */
+	stage = *cdptr;
+	arm_smmu_cd_set_asid(&stage, tmp_asid);
+	arm_smmu_write_cd_entry(master, ssid, cdptr, &stage);
+
+	/* Copy the target cd entry and update ASID to the temporary ASID. */
+	stage = *target;
+	arm_smmu_cd_set_asid(&stage, tmp_asid);
+	arm_smmu_write_cd_entry(master, ssid, cdptr, &stage);
+
+	arm_smmu_tlb_inv_asid(smmu, tmp_asid);
+
+	/* Update to the target cd entry as it should be hitless now. */
+	arm_smmu_write_cd_entry(master, ssid, cdptr, target);
+
+	arm_smmu_tlb_inv_asid(smmu, tmp_asid);
+	xa_erase(&arm_smmu_asid_xa, tmp_asid);
+	return;
+
+write_directly:
+	arm_smmu_write_cd_entry(master, ssid, cdptr, target);
+}
+
 void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_master *master,
 			 struct arm_smmu_domain *smmu_domain)
@@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		struct arm_smmu_cd target_cd;
 
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
-		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
-					&target_cd);
+		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
+					  &target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, state.ats_enabled,
 					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

