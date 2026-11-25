Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645483;
	b=kMso0U1u6JxdnT4a06dI7yC03DPPeGZm8KQSbhaSvBdEyeO57yS1Li0Nyu6KkQ9LT2Gf
	 GE0MVLjRUdp26rXb6f2M4PLk3rIGll2U6fFh/Q0IOe2206kVFWepQ3o0EmPS+R2Qmukw2
	 pqyvhN0OONI4r6OSrklrIAuCdiru7TC8UOI1IHjnFxBOgm45wTlUIyNgpX10Wr9g1AGdP
	 6UhvWsnXzEZrXWkP330lKP0eehYBM4UoXALmxKUnNvQwLvs4Y8O4ykFqhXtXk2pJSqzFJ
	 jSroB0AckC4PNJDYGwe9poIBVhWkduTHUQgNmQOoIn+TtafUUMoTIwweKbTmdqMPuEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
	b=bDaXrDavPtdOhAOrsShmnXWdQhazB4Wapu12W2lQpbf625wi5iztSgTNqu8J558tFSQN
	 1iXYsc7BCh2bXx9IVBi+Y/tddZFdFhcsIWrdC5FkxnhFDF260ZpPRBmq5qbNkw9iKH4Si
	 puxnIxH+4asBBYyAuz3Eoe0eqFKEZAfZFUgzF/GjSBeqqXFr4VgtTBPGFCvQU5Ecu1GZZ
	 0mmlSkngM0nQ66vRDYRjzV4ciQi+zdBi/eslTUQjFHJA3jjLI0L2Ms+fl1754FLDaQXZP
	 YdlW8BqYuvV+OWQsNwncalloTjxzJoWekiciCK2Cl3/tPHRdzTfNQEWneVSW6R76sSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UUhzJ9qJ;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E57606A69D
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 22:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E57606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UUhzJ9qJ
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3846d5f54c1so7335664eec.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645482; x=1796250282; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
        b=UUhzJ9qJyo5nhJlRbw2kI6lfPuQSI/m4eWujS6L4+d3rl26OD6zAMJ8uJPlOW5RLNa
         otS34ed7bVN9cmXVql0kNnSdmncwyQF8LlSUu/0sYAa9+eEMqBJvw5SW4YB5jiWy3tBu
         ArEJXPwTHjt19T1KbjVP/FRjBz+Kanx5ZOmARtxfEMIxpUbMFEX4LYWThcpXSHQ33krV
         qYWCQdyT8C44s98fOU1sXeyTbe0zB68NGvDdwDIjL8F6JwMxnvjs7e/avStSy2LDOMr7
         zpLJGB9KkywiZS1OecIiql+/0lLsmI3zou7zoY0OJN63ucf2PR4o09oFHQ4xd1732sEK
         kJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645482; x=1796250282;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDuBt5Cw+ANUexZtA4dNwo8xhQaNML2KuCiDPiA1qKE=;
        b=bf7fXcUrD4sb9qjTCGAamV5ge29feFEcE9J7sHxf82jHrOQJMVwmYqxsy1m2NEszFB
         70Z0AKy8Q/W5ooQZS9w9jTD/k/aTyozvieh4b9U5DyeDWdEo12WYqtiCfGHFs+dtSAd8
         S+YSFfNOYiISvfXw82YhQ1LKFEYM1Ds5AohqVrvE5kKckmPKna2T1hbAblN3sbfpum2o
         d30z+JLIMm1iAIBCh16ofOaRzG0zw90M51+jdyVTl8QAt0ztgROcMecU/hwumWX93vdv
         SrrxT81q/aRuCtnaSBK5/yal71OtGDijWdLnXeQGsqaY6dCpURFX6rzXIon2TqpOZOfH
         AscA==
X-Forwarded-Encrypted: i=1; AL+hErHE7CgdwcBlq6ufrM2daWeXsx2uz9N23s6tr4w5mxhXewlimxOSwPH6+kXMTF1aAnwqDyrkgQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8mDiAdz6PO/fq9DCNtXHxQ5V7WE3Va4lk9S6R3gYhaEF7ySBJ6
	H07cE5maS/bF1DBBYOP3k9sTprGkiB8cy6pzwuQzfjt3Q71ctkvyEQB81SjFkomQM8ETTxAmDQZ
	x4w==
X-Received: from dycuf5.prod.google.com ([2002:a05:7300:105:b0:386:9be5:2d95])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:638d:20b0:375:c862:31c
 with SMTP id 5a478bee46e88-38571816d35mr18955075eec.40.1795645482015; Wed, 25
 Nov 2026 14:24:42 -0800 (PST)
Date: Wed, 25 Nov 2026 22:24:33 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222433.1442338-1-elkin@google.com>
Subject: [PATCH] iommu/arm-smmu: Fix use-after-free in nvidia_smmu_impl_init()
From: Elkin Cruz <elkin@google.com>
To: Thierry Reding <thierry.reding@kernel.org>, Will Deacon <will@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In nvidia_smmu_impl_init(), smmu is reallocated with devm_krealloc() to
embed it within struct nvidia_smmu. When devm_krealloc() moves the
allocation, the old smmu pointer is freed, leaving nvidia_smmu->bases[0]
dereferencing the invalid pointer.

Read base from nvidia_smmu->smmu.base instead of the stale smmu pointer.

Fixes: af9da91493e5 ("iommu/arm-smmu: Use new devm_krealloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 2fce4f6d4e1b..a3884966dc29 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -319,7 +319,7 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 		return ERR_CAST(nvidia_smmu->mc);
 
 	/* Instance 0 is ioremapped by arm-smmu.c. */
-	nvidia_smmu->bases[0] = smmu->base;
+	nvidia_smmu->bases[0] = nvidia_smmu->smmu.base;
 	nvidia_smmu->num_instances++;
 
 	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
-- 
2.56.1.839.g22a8290db9-goog

