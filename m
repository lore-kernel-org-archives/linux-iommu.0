Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0D315785
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655109; cv=none; b=Glm6rAPNHqV01nISEbmAqXyhquMtyDc8CMLKaJVxYgEHMsgISlNpw+nyifQovurnxVgsVMumcwdxEIe2IGhMX5Sa4Ogqs8CLeYEDl5ylyrXXSaCIefz+SeGXX9YL+zNj5xxCs/MprR0EEyff4M3gNmhZQbUC11gtwF/hLQ/+zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655109; c=relaxed/simple;
	bh=Mf8h+h03L2bzW9mDWJu5js5WAT5mXmT3aoXz60/jCXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LPiHHdgTWuzF4vufc80d9jjul3adP3CjxPvLn+pJJJ5tfmHjMUubE5drFWkPAy37GpjuxTumf8QHhuXX+x0VakUaqmrE+w1Gxk9wu66UtW85EhkK2Ml9AIin61qNc3JwqlZCDsF4PdJlXkSmUrqBPt0vD/QcblOdP7fMyESGrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QhzSoO5Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhzSoO5Z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso30474765e9.2
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761655105; x=1762259905; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HQWTTzmS8TT5Tb3R6tEELAasWZz7XbENUTZplMJ86A=;
        b=QhzSoO5ZZWMjERDfz4UaGx0mWDy8Rb32CD7esm/7lxWKNvW/Ox8wSTMK7BBPqWnb0r
         r21Ip5e+VGs9M85MFQ8EI8ikxYk0ySG+4NIL2wrDuMG+K8oxqZrQoITf6cYoq/RfxE/J
         Y3ysLaHdTj3Ft2MwP3a5r7R2TSq9uBWCpW/S1A+5oL9HRq2OOkku/1LiEEa8DqGsaIP0
         0DHqr1OAehm4g0HHZnllSK2HQ1xUm2WoeGbW/SPocemModZSCdSriqHG9yzyGUYQqiz0
         tkX/0PTXgKNWaKeeGVkmeCROtgQ9YAJTWXwBKAoWV4webTF3QXo01MahhLN7cZgRwVjK
         reUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655105; x=1762259905;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HQWTTzmS8TT5Tb3R6tEELAasWZz7XbENUTZplMJ86A=;
        b=MkV8LU7d3xyYPC+L8fJq3WYre9ymoll8nQqQZMbR/12QASwyW/DybLZgSFIawb0l3c
         yRCmJ2d8DFTGhdZTbJ7pQRN92kCkR/LIAhgkdV7enA8L0+b8YHM7mGuuGM6XsepJZL2Z
         KLv8T9XLCI9SiIBy3e8GdxkGxydXnMYa2b3jcF22psn7/GO5qqK4lQu31eoqIyowLf/5
         uHIZOyhBxKDwIYyecCeGPr0l7+aRnGly3WnoA0JeFl7oL8QmU+IPLjT5wDk5uJQW7AWn
         ZfGH3OwfQ8blFWWE7angFlpa9mc3ftp7bqsBgr9LeXG13VSEbM3LrJ+ijb7nL6Jl2hDe
         3wMw==
X-Gm-Message-State: AOJu0YwwY2j3iWTZxM4Tulcpzg1qGoRbr7nIPFTFg7MTU0LdSMUSgYk9
	YjwzdCw5bVpO3x3skg4kir3CF9+dkkii3rGHTEFPt8SJdGZQeFkEpy1jSyjhShQabhG5dwF+9gH
	G6QxR
X-Gm-Gg: ASbGncvCyN84nCPOo4N1A48eQ22gDZr/ihXHMa38cIIRBNBWOPqi2d8ouHwse8HDNu7
	VWmYG5ybv9x0bvNf6T3t+2I2HYDP6KIrFXRll0zDmKZv+XCueei2DMLGMjDZQ+DVeXhpabIhhYu
	z/EOf7s+vHHJZbFMVAluC5XcLzQka5VAQpBAbTG9KBlvs1whIJE4vuihT6vyaWVkJv1NJmIOtDn
	rvNzSpyW6jB1Dr3HMhdyN7/Zd6SqIL25nymYJLP/vW/cPRBEFVsw4Jb3XihnaeiZNfduWiN0hp0
	ykQr7owyACLUoJsASpT8IS/Z4eE27L/y1SSHUvzCNS2zehFE2TmHZBQ0F3OxFBhQJDtzPoQYEHI
	IVJcB450p6zmtiaZ7TSpSQKi1C6K1MdVPQxc+LC5N2KqtGmekUWV1l4x1CA1Wifhmj6PVpTP6Dg
	==
X-Google-Smtp-Source: AGHT+IGyxD6kxKArelGRFtmyoU+oQyoUCEToyxb454tLZ6do6Faoc5fje7htOPBCBaso+JeJcI0k3A==
X-Received: by 2002:a05:600c:548b:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-47717dfa90dmr28285375e9.10.1761655105404;
        Tue, 28 Oct 2025 05:38:25 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm21087888f8f.26.2025.10.28.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:38:24 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 28 Oct 2025 14:38:19 +0200
Subject: [PATCH] iommu/arm-smmu-qcom: Add Glymur MDSS compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-iommu-arm-smmu-qcom-add-glymur-v1-1-73f8f884c9b4@linaro.org>
X-B4-Tracking: v=1; b=H4sIADq5AGkC/x2NQQqDMBAAvyJ77oKmDTb9SvEQklUXXNNuUCzi3
 xu9zVxmdsikTBle1Q5KK2dOc5HmVkEY/TwQciwOpja2qc0TOYks6FUwn/ANSdDHiMP0k0WxJWf
 vIT6s8w5K5KPU83YN3t1x/AE2YNXUcAAAAA==
X-Change-ID: 20251028-iommu-arm-smmu-qcom-add-glymur-7e953cd459a9
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Mf8h+h03L2bzW9mDWJu5js5WAT5mXmT3aoXz60/jCXA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpALk+kUF8P0aVK/w8f0AM9SlSRvIOPU68KBcGK
 PM7XHH7f1+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQC5PgAKCRAbX0TJAJUV
 VsnWD/9BDr2abdk3/NrmmBGMD8VxoWsJxnPo4WRfEjpZxhrNa0p0ISrW79FWqyUm35dCaVmQFvO
 wCiGBC3jHNfOYMIdWGnMCJAP7y9uttfzGyWW7j494avIDvuQKTa/IFQoUa+nqaHa0JdOklX+nPl
 OonLpbwdsJ/6tjmbnIyVG3lqeas14RPcZ0rKKS7SJADHJDxVjIKKpF1mgqpwPnr6DLQaqUxXW1K
 0SApilA0nJhYIT5fqkI3i2lBE+6FpcftOIYxyx5ce8PSRZz9zLE4QKCtuDhIVPZ752RHj4f3z86
 wAAsUkqK6tIk5n22bAY2awmTSp6eggnWs1EiHqgkjyohDOsqMSah8gQCnA8bl44tHEUkYooNJj2
 GrBCKGJEqdkiL1cBOgvSk6WPPGtaGAVq1PzyGeo7Rwzs21hEpTJZEbGChzpBjXoyUnIdf8878S/
 6Vfjl+nOB6ybpcRBLICWuQD0H7GxD61mJTWutk6NuBtjaB4DerA7dDbYk0IjNSkiaCsmoQnQoAI
 nCVyBHKU9BYfkb+raWMcy2rr5IBubLD4ZBqpVs+auH3UXE/dtTIzWhc+CsewgiMuJN1E+GRQmIP
 eBbJk2HseHGPuxVxtneYp4l45JDvFwng9ST9WfAZ/S1RISXMMJNwhXj1VtSmcfOcGQWm96QvGTl
 V2Hx3ejMmtlE/uQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the Glymur DPU compatible to clients compatible list, as it needs
the workarounds.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
The compatible is documented here:
https://lore.kernel.org/r/20251027-glymur-display-v3-1-aa13055818ac@linaro.org
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 57c097e87613084ffdfbe685d4406a236d3b4b74..c21a401c71ebe768115364bf282dd324f8222109 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -367,6 +367,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-gmu" },
+	{ .compatible = "qcom,glymur-mdss" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },

---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251028-iommu-arm-smmu-qcom-add-glymur-7e953cd459a9

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

