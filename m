Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439348;
	b=u8q+U7pXN4Li2I1UVDFc/Q+lhmR29jt/CIgKvAMYSPnSIjTV2X0STUp3WOGSxW4pUgnL
	 asMQmIW8t9+7Fe5tsRLHlipros1VdTPR8hBwNDZlyXJtcVu1VgR7C7gtf5crnuvdCcBWr
	 LrULGRX6IWyeI0ogbK/86dCaQmpcCmlWNbOKEj5D+PtIFn3iQXW56sQ1cvf2KmRqvE6rx
	 2Ptp6no5DwKiQQk4Zvvo6eckU4ZXkPFW58DCqh9p1eKA/agtRUB5oZdCfY40p3SX6UVam
	 bI9q2MUwMwc0VqtryK9U+pViQ6x4S8KuY9XizF0hB3UV9ebhsr/rzwGEcPmyDRC3aMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ANfkCzqxV9oez3uXmoRvr8M+fH7rHon0FntvlHoB7hs=;
	b=fePUbMRP1dZJTIH3SFqL8LK4ayKaJLsAfhl7KDPg4mTbU5rZKKu+IxVIZhMwPj/R24Ud
	 cYhgRw2n2sRYhlXkV5oQyj92Uy3TVraMBry3lQFpq6vuyUajsN/zj2OQ8/MoaD8grsSFX
	 coFfo47wdo1qcBjFhxZFpsQEgkH5Ozbuu+mZnzZx4H9VUmwLQt3JRf6M+Dt2LuI6VHOC/
	 j+6Wd2jNwKvoblfwtTLAW+VMJCByXODyhgHZDv6bgNygGYgjnkoRL7nDqu8BgUg3KSz3z
	 A2ZmQWUWErxRK006+zP/TOixQNZLah75cOV4Oy7m54qMEa+9eMUuty15P1/QM/LR39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9EK2A+Q;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA32606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 13:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA32606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9EK2A+Q
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f04561ee04so18853645ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 05:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795439347; x=1796044147; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANfkCzqxV9oez3uXmoRvr8M+fH7rHon0FntvlHoB7hs=;
        b=U9EK2A+QcL9nJAqiln61dTDl9feO2RMttIkKfxy9hwUMsiSrawN6GD7Hw1J4ymHmOn
         WaD9Q6Te6F73QcRiWBQsx+qsWNskw6fM7Y9+d7ForhSLW8VR9gYXUpY2cU5ESGuYlkMR
         qjTrDLe4cS0GFRsnCfZ8lZQSs0CzydIW4zuL3YFUMAJLGI+TfaTTCgLDy/Yoh/3C0W88
         LwmtnCjx1kdjlA/BFkF/Pl/Q5PZ2blzdQnn/mKP0LKDjG4r6GSEOT/E7+SVSiQ9NY55P
         FjiQcEoopjwlzWnpgZuQHvrCTeYi8+unpgX9BkQUe2GgKyW3YxtZQeAUk+GhGqCkRtzD
         inlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439347; x=1796044147;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANfkCzqxV9oez3uXmoRvr8M+fH7rHon0FntvlHoB7hs=;
        b=MpRi5ESmIcMwGycKil/ohmlddIJDt2s8PVVycBus0zBtT8eQtmhWkvMACFKdQWhrqL
         32TiBdiJJvkE4xOvXalQ9clwIsvWLc8ZWde11TLIcJwoZioWbPlEXyHZ1Bn0eGjSZb43
         tYuz6ABhJiiJAgsjVxz+qmt4EfQWvUkNHfno1A+8u/c1pgcKDpNU31EyNUa0R/X64S/X
         PC7Ll8LP/FN1tZBMBPiUCnWxYUEEUG7JpYhKH2+hwvRcSkkWEAOBWSjspO7XPYXcYjVf
         jbYfROK63mgkGmDxw4cUZp+2qEhFaxUS5sX12BJVVm1XOmtJYo5ecK0HHYxDl4DdbWJI
         SnOg==
X-Forwarded-Encrypted: i=1; AL+hErGuslk9/wPQXNB+ht1S8BvIZ09lVWqBFphBlQBFgKp76ypIP9ULHg6etthXXmtCzu4fw17Tdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+tbyAdTBW7R013dWJkiNmZjj8GaYbeirL8t4EYJ+8uIpUTP4Pq
	7Ef6m36sO4gBXx+9J2NLT/SCrsnL3iWlpfPN+PPsxJcRFgDv8hNsSksm2AMn632fQlI99AsCEBI
	1Ln3uphto2mnHfaWmR7zUHvfgOQ==
X-Received: from plkh14.prod.google.com ([2002:a17:903:19ee:b0:2f0:31b2:9171])
 (user=amitamishra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0d:b0:2e9:3dd2:a8fe with SMTP id d9443c01a7336-2f03f1537bamr103175945ad.21.1795439346390;
 Mon, 23 Nov 2026 05:09:06 -0800 (PST)
Date: Mon, 23 Nov 2026 13:08:59 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123130859.3487100-1-amitamishra@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Support IOPF for masters with multiple StreamIDs
From: Amita Mishra <amitamishra@google.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Amita Mishra <amitamishra@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently arm_smmu_enable_iopf() rejects stall-capable master devices
with more than one StreamID because arm_smmu_page_response() hardcodes
master->streams[0].id when issuing CMDQ_OP_RESUME instead of tracking
which stream originated the fault.

Save the faulting StreamID in fault_evt.fault.prm.private_data[0] in
arm_smmu_handle_event(), use it in arm_smmu_page_response() to target
CMDQ_OP_RESUME at the stalled stream, and drop the single-stream check
in arm_smmu_enable_iopf().

Signed-off-by: Amita Mishra <amitamishra@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 100b34f07032..53c396d3187a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -954,10 +954,11 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
-static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
+static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	u32 sid = evt->fault.prm.private_data[0];
 	u8 resume_resp;
 
 	if (WARN_ON(!master->stall_enabled))
@@ -977,8 +978,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
-							 resp->grpid,
+				arm_smmu_make_cmd_resume(sid, resp->grpid,
 							 resume_resp));
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
@@ -2164,6 +2164,7 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
 			.grpid = event->stag,
 			.perm = perm,
 			.addr = event->iova,
+			.private_data[0] = event->sid,
 		};
 
 		if (event->ssv) {
@@ -3313,10 +3314,6 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
-		return -EOPNOTSUPP;
-
 	if (master->iopf_refcount) {
 		master->iopf_refcount++;
 		master_domain->using_iopf = true;

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.750.gf70dc682cf-goog

