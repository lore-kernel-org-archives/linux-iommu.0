Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89BC8C0
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303514; cv=none; b=iT4VsB6l0Hb4s2nVvaomEMYozgqoZwRTQx8YP7yLUvLAH2GcZ8K606VnVa3qO9Bo7k1SptuYqt06ClGCdpoAn8lDJwnDWeqx0H0InCxmMBAZVhkn5SitaE3gxM8oFULWEZk3PyZ2fnYo2vl6ihwan2qXdk4rJB0/Bm8JmQswiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303514; c=relaxed/simple;
	bh=qRI28A+73jOqlrtVWjD+2Jeg4Mi3y9f3Y16q9ww7zVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuXEIENt4tgpW1Vf8dLWeqVx0/5PkYBW9kbXF94yqhkeN7EcOyjjDomrxvlaEthiC4wzj3YBQXhKKhISVQ0JITpXfOBH/SaCWaTRjc+E+rgddkIJbKr+WjQiPhfBBkC77L8TWlORpRlYFOrHXuPhFpkrfSmrRKr0ZUQTNQDjly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNZc0ZXg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNZc0ZXg"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b796667348so31695866d6.0
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722303511; x=1722908311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74veV6gJihpFMmsZlJmkCJZZfUOt3SZScr7B4XrCCXA=;
        b=eNZc0ZXgpbfQl2udiMwMlwjtDqgAtblIogKzLuQi9kcKRBAhhsIOMUhTbLOTGom7gL
         5NurLk9K4/+bPsgX5SuhMgXrlmU2L/+uDkprJ2y9iOU59BisJOBTwsXGhIofN45TKBBT
         F8E5Uqb2n01+mNyCEqWqtZ1K3cNeh5KsH6kM2hOADzrgnCyguO8TKzszoQ0b2p7LOOXk
         VdTfsQVNzrpfBkbR5cAGxJGISgJhBMrZ6x4a5AaVuqQ25APMYq8t4G4XCQqJO5t0Pq/d
         0LzAd/w0spnpxhFmlT+6mX0uSxocLIfKQbOclTmaCSMgfueD7+yHUZKW34j/DrKILB5H
         XiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722303511; x=1722908311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74veV6gJihpFMmsZlJmkCJZZfUOt3SZScr7B4XrCCXA=;
        b=MtevRow0mDX+UddfR9jM8pzlW1ydkc+DO4RB4Mp/VyBQyjhRAIc1csDsMiuDCEcvxR
         fzdakZAYyOC0wJ0HH2y37IO3qLfDqr8unMZPZGOWdp7mszGGHCg9VVve3UGBsJqLWfie
         ZaGNoxxiuGuEp0MQYfnRPlQBY5IFf9C5m5Hp+MjSj6GKxJ2X02bvpTF9PodJk94QGAJS
         u5jla9Cs3Qci4hZ+awwlsAWqCPvbku/1JDyhSGH1o9wYzD8nA2YYmZAyZOb0OpLrewyQ
         ahuiWjWgCQ0hHke5xCRwdotY9CwY1dITi4RQTYh3dqrDN5sJF5Go+S8qh68fV6u8tKRZ
         Lg6g==
X-Forwarded-Encrypted: i=1; AJvYcCWVKv7wWufUNph3FnjQ7dEIfBATju2eqOlUJXwmesOPEPFu7ANusXlTASdpb5md9RS2/mEXzhmFy8T86atS2DXbx6OyIz4=
X-Gm-Message-State: AOJu0YybzSwFTVCC49IKtuGLg7jgX2TNi0zbydqKZ7vr7LVMwCf0HAEK
	5R1MWLK6gbqoOCYaKBLW/SFm9yIzA2ouEFBrNY2c8VN4M8P0OTKL
X-Google-Smtp-Source: AGHT+IE6Phiwsym7PisdY2IYYu9NzfCIcR4dhesQuNm3nR5IYh2ixJSNLKlDYlycfLQ1GUlV5uD+pg==
X-Received: by 2002:ad4:4c0c:0:b0:6af:c2ec:3313 with SMTP id 6a1803df08f44-6bb78104019mr9812076d6.26.1722303511400;
        Mon, 29 Jul 2024 18:38:31 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb79c4f3dbsm318286d6.30.2024.07.29.18.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 18:38:31 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible
Date: Mon, 29 Jul 2024 21:38:23 -0400
Message-ID: <20240730013820.41702-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730013820.41702-4-mailingradian@gmail.com>
References: <20240730013820.41702-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the separate IOMMU on SDM670 for the Adreno GPU.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 36c6b36ad4ff..7f4b15be4a11 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -539,6 +539,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
+	{ .compatible = "qcom,sdm670-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
-- 
2.45.2

