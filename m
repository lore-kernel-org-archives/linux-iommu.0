Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF81AE877;
	Mon, 22 Jun 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145119; cv=none; b=R3OBgMUJ4VabF32Gaoqzf/vOcPHOu1HVk54YGZgKm4/v806AZ5ecktKrhNJz63537J5/ujDYRgLdfAzWvAesvysFyQ8jmxFZc+a/ePThy+176IqywCuV47ZNki/DU5wdQ5puQBJ4Ax3GT84Zx3aDHvv7ea4pCPQLdexe9AO+es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145119; c=relaxed/simple;
	bh=Xfj/GKcfUN60lJa0KVwkvKu98Hb3WHSEqu1XiMbs6wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C3s1s4Xrs0gQV+oBPBjM9ObbBDqSvZLjAfYkk39CgmjhvvPnNaYxH7S4PEjIthvjn1Fg1w+zeFhlsiE5P56fuhxZAXeUlHBbKI/m3Wg7vngY5aNl3lqsHrSbXZ+5RIE4HEz5TGfP4fEgDa4VJC9c3krda6ixKGv1QqmtTMQB0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aB/d3oZd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aB/d3oZd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=S7aEd5EX+YdrVp9yjK9xP6A7alsmVtEUOulKR2UA8VM=; b=aB/d3oZdTIWj2b7PH5y6DejBKh
	hM9/0pM7SLzKmf0oGnqAmrPyRxLQiLTsrAw7jsnoOSdRCkkSiZgZHUbeogsXR6TTlFIpC1GOGn2lD
	TRhCS5I99WiGQYHhPWmzBKblzTTsRAMKc2mCgcEs2/edCFaCZQNLF4KG2crdVADR944XZZN+psxDk
	O+EqJCGSCsapptvxCiQtEGfppvA+0GAd0Dne8m/vLq5IKnBCwxbgFJCCHQbVKNDQeAdPiN0Bar3K+
	vKrAqX1/a8riGKnjIH6E4ROngufSXdhayyvLZ04opdnINxRfQzp9SJprZ8Kn8mpNhiXCU+Ak8Grn1
	TU7uc28Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wbhLx-00105R-1v;
	Mon, 22 Jun 2026 16:18:29 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Jun 2026 09:17:03 -0700
Subject: [PATCH] iommu/arm-smmu-v3: Disable PRI when no priq IRQ is
 available
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-smmu_pri-v1-1-14ad92b6043f@debian.org>
X-B4-Tracking: v=1; b=H4sIAP9fOWoC/x3MSwqAMAwFwKuEt7ZQEyjYq4iI1KhZ+KFFEcS7C
 84B5kHRbFoQ6UHWy4rtGyLVFSEtwzarsxGRwJ6DD8yurOvZH9ncICIcGu+TCCrCkXWy+6/a7n0
 /XI5q4VoAAAA=
X-Change-ID: 20260622-smmu_pri-a33326900c33
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, rneu@meta.com, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xfj/GKcfUN60lJa0KVwkvKu98Hb3WHSEqu1XiMbs6wE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOWBRxW4cg8uASIBMlgSGZlN6WUBefTyJh2uTA
 VgOPZYjFBaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajlgUQAKCRA1o5Of/Hh3
 bfTdD/9Gzzcx4dDoWg0o7SyVITStwljS54RUi8UotFniXFwq7ysLmAK5t47D1WJPAPr9ZGrnusm
 2aP1c+f4EF+JwQUi/9dkmngYYUePtAn63450Of3l8yGdWT6PRbHW4AAGLzRNcEHGP7pjy2nd942
 s/rf2rlqaLOIHsH9YFaTbM2pb9pZtOfVcVwibyf6RbNrn5puo9X0Do6zTs184B1yToyRjStFZJu
 GypoOCd+F5uT60SDHRWGmuAqioFxVvh8MqLmBE+aSvAOTbp/V9ZnOqvPas7tuD9Z53dI9wQX0Kf
 rHasv/eOLeSrZbKkYS+brZK3/flOIZNh671dRwk3rKZUkc1XGe3ViLsNicI3Plr2KPLpH8CPw9e
 RAfAG8QtSWQH8s3+OdKDD2q3/cLw20vBQYTdINxM6fDIPY6uXPncrKIGAGVBXcc9kAQnFYvHvqn
 BTrQ2i7X7ocrz19Z2RgrsarLjPhfzpcAlXlezMoQs9TWx0+EYr8563RJzO7T7famh0rBtS6xmXl
 UpOo+vuNpt+OBwsYNJBm6MHh18BImKHFN5BW4/ZA5RW+JJ5o84ghqDTDX4JtGgSIdCpluTGZIUQ
 rzXz8q+oIQvG37qNeTCCVJ0HFUDYWc9y3A/AwKW7dhobslB326e/AfZAV0XyHlRkLD5j3zKNEzW
 Rp2neFe4N9Brc3w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When platform firmware advertises an SMMU as PRI-capable in IDR0.PRI
but does not assign a GSIV for its priq, arm_smmu_setup_unique_irqs()
warns and continues. ARM_SMMU_FEAT_PRI remains set, so the driver
still allocates the PRI queue, programs PRIQ_BASE/PROD/CONS, enables
IRQ_CTRL_PRIQ_IRQEN, and lets IOMMU_DEV_FEAT_IOPF be advertised to
upper layers. Page Request messages from devices land in a queue no
one drains, and SVA binds appear to succeed while silently dropping
every page fault.

Clear ARM_SMMU_FEAT_PRI in the missing-IRQ path so every PRI-gated
site in the driver consistently treats the SMMU as PRI-less, instead of
the half-baked stated.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..44bafbb38e242 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4659,7 +4659,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
 		} else {
-			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
+			dev_warn(smmu->dev, "no priq irq - disabling PRI\n");
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
 		}
 	}
 }

---
base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
change-id: 20260622-smmu_pri-a33326900c33

Best regards,
-- 
Breno Leitao <leitao@debian.org>

