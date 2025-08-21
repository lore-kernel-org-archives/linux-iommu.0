Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA2222564
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765247; cv=none; b=lp95aQxvCoUXqTxD1oGNniqQK7AyM0X9ybH6G72p7iBPmBvrb/CcRWZnsCOBZBlQgko3gLqE3aFKcAa6RPwE/J4FL9CQrljjXXEMpj1ITnlm3Q7nAEP5eZEwMudyqvs0CECzxadmj3hIxsvMZVr4oFesfW+gwKla5/8HQBl390I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765247; c=relaxed/simple;
	bh=wLUC/1W7EfFeUkMtGcj1FzsRd9x+m0ZbSOIe9wVACeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQzfvSm8OqVkhV5jVGy4wU0oA5CpxNfnqHUT+FVsBWpnz1AfjkWyFpGwBBEmmpwpIdJqRtJ5hqQolGOedlMhl87N5Iwf7bOHKvuucSz4poKkwUJIKSzsiRwI7J8ZdTKkzzcYWPs/qfYTKit1BDYjcWBwk3ehZgclI2m7QLPON7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emBXuFfJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emBXuFfJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso571944f8f.0
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765243; x=1756370043; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFk83CXRUT92P3+BiK0rArrXXY+KdlyqnAXLmJEMLjY=;
        b=emBXuFfJcfpe2AhhxCNKSbthRkwRIXiC5nF1uX4hrPD1d5k8KiajXp8g9mossvmH46
         KKbBZORn58x+CWlwwfINqxnXD2rB6J5+05oyUp5PDQinZ6iBxSV7eZMzpO0At+5Svvp9
         GcexPHpTOGugBUpVK8jqBXYQ8RlOaBbYUlhhzC4l/k7+g3cmA87f+u+tHtXpuZbVy+yW
         WXLGu2THm1zcuViK24gpQjigdNtwcEzSgpgq5MB7HtgQ88LxIDRzrZlTqNzZivOQRIfE
         MP4KlzLiRyBj8cTwnTC3foZolIL9q4tCqdW1XVT63YK+IOlZzeS8a7RbR8GV92RmqHgh
         +WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765243; x=1756370043;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk83CXRUT92P3+BiK0rArrXXY+KdlyqnAXLmJEMLjY=;
        b=bMUa2vxQH6c5hXcYODl1+PfZ+FEDGWNG9WAGztuLu0ArWUdaWVmqWpNQJptziuzAeH
         EWQisgeVZPQ0GIe+X8/fUWKvNpe3kYqFMm+OFio8JXSflds858mwvxUuNGYjjciqmevM
         vf0QcS/ZpRxEk6/mbo+ewho/jSWVbjTIa2A1kjRRvESty2V/V2WUgKwhZ/qrk3/Zl2cx
         gP7YOixW2A0tbzR6U9uwpQhSuQ3QwzmlwYIU1dCXX4VTNK8WGFfj4vonUKSn9nfYLN3e
         rLLTq540LzdbLGNhxn9tlklbHGIBqqgfXd8ZD74uSguKdpzXKlJIx8Mavs36XykOKydG
         Bnxg==
X-Forwarded-Encrypted: i=1; AJvYcCVulPfizbwI7VthJpiGurjGbft1io/3Ot3PS7NX89Ig/ZJAGXGpukHIk28TaLUzwK1v4hykMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxin52hvxwXdJldZCQhFEGn+AzosU9l1wT2n6H/9EoYfvd1Yoj1
	EOzZupKkIZFr8bAWO5BGdfXRKBx3EeBdMmaItxYErRo6ah05M3lxWlXrG16aOAK5KYc=
X-Gm-Gg: ASbGnctc6NXOteCtddh59JY+Ty7cNkaJ2LEXWrO7OOTSCiHFyHj0RPqh8QMX9k9fnS9
	eJ2inekqcpDaPivGyvSJaQsC9SturaaIk22s3jns6+9hlQ/e6G46UNWDJPl83gpwGlhUxzGRu/d
	WXfCLvSum9ZR4YP2N4b/klZU4jPE1F4yv3dgvtRCj/SXW1Olu8O7w6YdTYUoTwPJfk2O4yy0TTo
	DAInHtrYBZ4O2mXZcIcberr0/gGPz2BrB37T6jCkvuOlTeUMFFiA2JUF5t2q0ISwGxVN1Vh2Oi9
	GGucXdiEP3iB6Gr4lUiaD62HizoaliL8wi61jPo5mO51CIxT2+FFd3Z/GqAvKPHLlc3DMXhIuNs
	zEo0bxD4Qwez7TTpb29KikEPk+m5l+7nVKDCq
X-Google-Smtp-Source: AGHT+IHW+YsmBVfepjw0RvvbIvLuyUZUzNrK5+vJha1JHDeloaVHEaX39wtYCOugbW2Umy9rn6hFAA==
X-Received: by 2002:a5d:64e7:0:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3c497741f55mr1258810f8f.59.1755765243275;
        Thu, 21 Aug 2025 01:34:03 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:a59f:f2cf:3ca3:965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2a491sm18681295e9.8.2025.08.21.01.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:34:02 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 21 Aug 2025 10:33:53 +0200
Subject: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPDZpmgC/x3MSwqAMAwA0atI1gYaUSheRVyUmmrA+klRhOLdL
 S7fYiZDYhVO0FcZlG9Jsm8FVFfgF7fNjDIVQ2Oazljq0GnEFOOFp98junUtUqTgLXkytjUBSns
 oB3n+7zC+7wdtNni7ZwAAAA==
X-Change-ID: 20250815-arm-smmu-qcom-all-smr-1fc81c10840f
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Some platforms (e.g. SC8280XP and X1E) support more than 128 stream
matching groups. This is more than what is defined as maximum by the ARM
SMMU architecture specification. Commit 122611347326 ("iommu/arm-smmu-qcom:
Limit the SMR groups to 128") disabled use of the additional groups because
they don't exhibit the same behavior as the architecture supported ones.

It seems like this is just another quirk of the hypervisor: When running
bare-metal without the hypervisor, the additional groups appear to behave
just like all others. The boot firmware uses some of the additional groups,
so ignoring them in this situation leads to stream match conflicts whenever
we allocate a new SMR group for the same SID.

The workaround exists primarily because the bypass quirk detection fails
when using a S2CR register from the additional matching groups, so let's
perform the test with the last reliable S2CR (127) and then limit the
number of SMR groups only if we detect that we are running below the
hypervisor (because of the bypass quirk).

Fixes: 122611347326 ("iommu/arm-smmu-qcom: Limit the SMR groups to 128")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
I modified arm_smmu_find_sme() to prefer allocating from the SMR groups
above 128 (until they are all used). I did not see any issues, so I don't
see any indication that they behave any different from the others.
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 57c097e87613084ffdfbe685d4406a236d3b4b74..c939d0856b719cd2a5501c1206c594dfd115b1c5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -431,17 +431,19 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 
 	/*
 	 * Some platforms support more than the Arm SMMU architected maximum of
-	 * 128 stream matching groups. For unknown reasons, the additional
-	 * groups don't exhibit the same behavior as the architected registers,
-	 * so limit the groups to 128 until the behavior is fixed for the other
-	 * groups.
+	 * 128 stream matching groups. The additional registers appear to have
+	 * the same behavior as the architected registers in the hardware.
+	 * However, on some firmware versions, the hypervisor does not
+	 * correctly trap and emulate accesses to the additional registers,
+	 * resulting in unexpected behavior.
+	 *
+	 * If there are more than 128 groups, use the last reliable group to
+	 * detect if we need to apply the bypass quirk.
 	 */
-	if (smmu->num_mapping_groups > 128) {
-		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
-		smmu->num_mapping_groups = 128;
-	}
-
-	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+	if (smmu->num_mapping_groups > 128)
+		last_s2cr = ARM_SMMU_GR0_S2CR(127);
+	else
+		last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
@@ -464,6 +466,11 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 
 		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
 		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
+
+		if (smmu->num_mapping_groups > 128) {
+			dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+			smmu->num_mapping_groups = 128;
+		}
 	}
 
 	for (i = 0; i < smmu->num_mapping_groups; i++) {

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250815-arm-smmu-qcom-all-smr-1fc81c10840f

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

