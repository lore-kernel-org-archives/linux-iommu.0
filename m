Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4D12F588
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094442; cv=none; b=EWBx7czGJBFq/7NZQ63CNitZc/93DZ9xnZgk+XNw1NMjrX5a2/nT81Aw8ulteeJJZ9EzXyMEZ+gXot6e45OAr63jxkdWalj/diM+hQlDO4AB2Pgz4m6ZOirkB4lqCG41msR9f7GDhdmNgRX82bwpG4B7YOptD9stsE4yTbyYPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094442; c=relaxed/simple;
	bh=pD34V4Xis6XvSKzWyAyrm6YM5UjXrZYGLUr4MspUCqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9qOdr6kouWJCHuCSv2sJLhJ9r9vYJUItELeI1/erO9JWmAqfxays4y23+bkzeKjlNlE67Kp0ILDc11MoNyOBunkf+B9zjFCE5zGWeXwDpiGcjkqNV6hwK55hzRYjj5E3+qm00XJMTA5V39CcKw9Wfnejet46+lbv7e/UxpGr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0e704WZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0e704WZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso632211a12.3
        for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 06:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708094439; x=1708699239; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddHRp/a7ql2hO4wtU3P1Kr5z86y1yTWMkn8d+hM85z0=;
        b=o0e704WZqBAoT7ZniIW6xFY6GPfc2/ZCGqVr+wF9ZF5A0SK0nNcHuYmtV+0hTTDB1D
         Y6WEJcvuxxQLPbLQImofWPzH0WUQhubx4Yd5XenyZqFZFZw7UQhl7mJ+8muVuFAMmb/8
         xKe/LqxNoRtsZC+acdjRTs1iHDjSwekOMJLfJcgFw0xa/94K6uHbwxCXf3OoAm3kUyEV
         jJQnRWLZUzKFuoBVl/umlJke+b18vQU5AqjK/c79FaN7YmuUOnKXmJP4YPieskdO30Q3
         YyMF8zFJVuV8RJiVbAA8a6q8BCK/txzZfCNcQUKc5gF5BstTudu4rQp6MLhs4kcHqD2p
         mRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094439; x=1708699239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddHRp/a7ql2hO4wtU3P1Kr5z86y1yTWMkn8d+hM85z0=;
        b=Zw/vyhJiBXg0/R2fVnxG/ZTeOViZsNzhOE/yzfVdSG7BF1K1ncO3VUGEuHTXV3RHdy
         FvC2ZJNNqQnItG2FbjnVrHkkRtm7CrkS8fiNeq8/5F5QvNwxCbFK+233hNyrNd9E41Z6
         vPFKZAa8KEEAbD69e/G727abfXgMJl11NtjalEK8g5ncj1WpM9C/TCFmpA1i3IMMOX6D
         UlnQUvNb3+QuQUsZge0ihiXv0st1hl/pYr1rfLHCX1nAvtg4fnioB61s+YjDG73P4Kec
         PYlNFLfGbC4M/aEga8MV6wFW+XOpk7ccdP6CVfM6IZElJsr3YGtzYNAM7zmHiI11cUrL
         Zkgw==
X-Forwarded-Encrypted: i=1; AJvYcCXyIv5E+vTk/QLmj81TSS2kWt9zQ7vwXDzbI/X97wswXDH8CDjMf3n6XAs1z8ggb6sRWZhOITomP/TfYy1YDFvVDHmk1ws=
X-Gm-Message-State: AOJu0YwluusIMPZ9BkjndzU6Wo244dtBtGEJKp/UCtuQLk86LCxFw7oi
	GC4ILMz5tlUDtT0m6Ab4tDeC93Hygr2x4K4YtblZj2GG1EVncYo2xWWDTDtzpMU=
X-Google-Smtp-Source: AGHT+IFjUr0pwHx7I9NJd2MhgZLwiZF/Q3I4EAlN6VBXxRxf0gB7BEu6U93gT2kjFbtxE6rZ4t4ByQ==
X-Received: by 2002:a17:906:d7bb:b0:a3d:704:d688 with SMTP id pk27-20020a170906d7bb00b00a3d0704d688mr3675983ejb.47.1708094438802;
        Fri, 16 Feb 2024 06:40:38 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906670800b00a3ce3c5b2a4sm1592942ejp.195.2024.02.16.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:40:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 4/4] iommu: re-use local fwnode variable in iommu_ops_from_fwnode()
Date: Fri, 16 Feb 2024 15:40:27 +0100
Message-Id: <20240216144027.185959-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
References: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_ops_from_fwnode() stores &iommu_spec->np->fwnode in local
variable, so use it to simplify the code (iommu_spec is not changed
between these dereferences).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 719652b60840..3afe0b48a48d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -29,7 +29,7 @@ static int of_iommu_xlate(struct device *dev,
 	    !of_device_is_available(iommu_spec->np))
 		return -ENODEV;
 
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	ret = iommu_fwspec_init(dev, fwnode, ops);
 	if (ret)
 		return ret;
 	/*
-- 
2.34.1

