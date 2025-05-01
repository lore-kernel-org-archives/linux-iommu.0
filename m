Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506120D516
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117443; cv=none; b=i8RadBQ/UTLK17qH2WHprAlOCJShfPhMrUsefi64CjCpvizzKOlKQ9YaC95yJAnGoQDVmlDr+hES6Ku0O0M1lRXEXhFSNndcqDbT3Z6uuXX7EWzkOIJUZAdDfQEXoytoq8JV0J5SFpwe0714ZQ+Dq1K2tbwC6Jji7ua+FzoioDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117443; c=relaxed/simple;
	bh=wSaZtA4bRYZs1G8waYvshbkAD9TzfZ9GbMZQt0pldJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKhDtG9tXqrNffD9xW3Z7WJIQRgEk8r24PM8T0deXLiMhOck4S/XCMd/mO4dEKwQ6LrMUqdAbXVZdadj3H/h+SoO2YJj5HdHmw/BGzuU3OiRMHQ9SRtpzHJTXCrTqlGHpeKEllN3hrpCmAKrLb2M6fPmRYq9mbPScDS0ziddXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kwmml7m/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kwmml7m/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce4e47a85so1641425e9.0
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746117440; x=1746722240; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9P1m7Y3z4d9rNoWAl6MknfdebV+lwfWdrXlwW8WNKhI=;
        b=Kwmml7m/Gw12xXmNAA3eYFUuIK22wDpwatCSiStQLZGVyKuLBxP/V6zkLF8kHCbkKx
         R9XRyWUFHQfII5Zo1E4tJoaGf19KqSCGyNLtqWYOJlNR5Q5ADKGhTimXBK3DzO0wdrvh
         QWlu7obgZ8StuaueiQmS5eGnm2taEXFZi5DuFhy85rAAp86OltPXQL+e4paqBMMvNcr0
         A+zQueTykNVdObKBhq1sdMsFOSOPSMoj+fDEiJYvWqByGO4kU3nIsvqdkeXBzY2GDR9+
         xzdfDBm6Sg9VX6KPrNvd4Y+aJF7CWDB8Y5jyX/9rYCLWYo+udo7zfjZYmmUCQI0mr2tX
         DDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117440; x=1746722240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P1m7Y3z4d9rNoWAl6MknfdebV+lwfWdrXlwW8WNKhI=;
        b=IfliU6wPyatgQoqEBkarW5WnD2mw/2rLp7XH0STW2ixIxTFwyS8hKJc371PS1JMvKG
         ll6VfpWkdJRTPBf9qEhKURSPGWe24qVcUfxXRBoMeix0tG5uChu7ZCBExt8rKMOnL2NL
         LMpYc3MGiROXdSIb/m8oA/2s9woVThoWpx1V4kyMbqiNuxPQk+v0uxkkmm6XkO3yj/Ga
         4ltEgAritFDeNXDIkYYU1KHVs5Adrj9sWyrTeYj/5L3OpF7EgUn5MNli4iKg9mATWtzM
         qVQmwcPceO30cgFWtGb2R4l7yPI+cUith9FWy+x4IqA/GfC4JlePETGrZo8MBK1gCkVQ
         LSgQ==
X-Gm-Message-State: AOJu0YwHcf4xqAkw4gtk3/PPT2zStgsn4EmbCH2fhs4UhqyM1OLQEHUW
	Nvnk3K85iIScXfEWUoP4P1ngyZgKF/GVL+snW30UPgre7k4z6V+TD4k449l7KBM=
X-Gm-Gg: ASbGncsqinSGGrVg27Ysq9kAID1Wuj+FfX1CN6EiaoRvc2M1Ms7H7emW0pNPAHbgLIK
	aNNEmaoYt3jzDNrn4Mvx+JZEltaaqwI7LqA/ZyDxUTy8kZT1NmtLtQLBXfy3UPCFPDe4EWAfSUs
	Ie5b653AyDBc2kgzdkru7CWgFYRtD3pWasolUj4XEstCH6nclvE2VOj2UFNzaTC39gLRVPFJ9Vf
	J6XYKUP1VxHahsgTNkxBi2JijriZLZ0MdNHd3lXf6KjcioTVBJ7y7sQ5pbyuzChnUmQ0ou5Xvjm
	q3c77MnQyOYQMrw6xiivR3aIRGHQ+IbkklCXpxsghTdZRp+9jFDcADZjNTw=
X-Google-Smtp-Source: AGHT+IGPpDqg1uqE8LFEWwLX435f56VDxCANn/R7sh63I65f2yRV/LXQryCMvr0tRZXQRAMZb4Q3cA==
X-Received: by 2002:a05:600c:1da0:b0:43d:fa5e:50e6 with SMTP id 5b1f17b1804b1-441b2dfce81mr23814815e9.9.1746117439733;
        Thu, 01 May 2025 09:37:19 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a288f0sm17166175e9.27.2025.05.01.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:37:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 18:36:56 +0200
Subject: [PATCH RESEND v2 2/3] iommu: omap: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-syscon-phandle-args-iommu-v2-2-5a3cab296972@linaro.org>
References: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
In-Reply-To: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wSaZtA4bRYZs1G8waYvshbkAD9TzfZ9GbMZQt0pldJQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE6M3dTz73g1hTqWpvm/RlUFFBhL88fh777FAU
 nRWt/u50OyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOjNwAKCRDBN2bmhouD
 14/1D/9qJJTAa6KNC4lnTB/UEBpK84vmumCpWTc11C3ByO2evXS29s7m1n4ZeLfrGzcrMmdIgev
 SlymAyZt1pL0HRWKb2lPzosqnhTpPMroFJltOQ9ZFiF89RGR+52847bWlrO2T3QhduCvBENWNcy
 gJucPsQ8IV8FsulSEYNSyk7wZwOD/zeCQrJg48ra6dJp5RBwKVfeVxMUKVb5BQ2U02MJZXCzvRO
 LJCgJhHs0cGBC8XRiTjCH0pc3PDZTlbUt7WyCDORjp1UzLrN7p3y2+rACVlW3Fr7gmGIDq/tRv7
 h6De2LgeQeZ/Jk4wRgQauPk+kOxC70aMXic7LzQ9zoe+FxBirV+x7veEsey+NsrDVCcUbNJQzlr
 w0FaKE6Tht0oesmD+iI4sETbNNt55JdQ8i0l3MkG0PAmKwSnFWT3sfCl7+ZBowY0j8b84fZQF/f
 P2fhWwsYBcxldooG/RmK9pSJYh0zCpTf7gRLFpoGELfB2PTRsXnjbqJFKDI2GfKxaRcNl4vPFcW
 6T60C0sLDvFfESa810o+xYVTroMqojApfAcU661dCx5WcdE/EO2UtOnX1HVCENEXYpM6GxArbJS
 r1ta56HmrhLEoAqeIamYOzHSQIRL05dpIQPQJWm2Nlc3B4sySF5cuV6D30iUdELbH/fX2yQedfG
 3ZTINBZ555xaPXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4448c0a512137c79195112eea25d762266c77bc3..30fdbabbc9c652990e6cd31d3c0a1a06633df9e6 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1127,18 +1127,12 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	obj->syscfg =
-		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
+	obj->syscfg = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-mmuconfig",
+							   1, &obj->id);
 	if (IS_ERR(obj->syscfg))
 		return dev_err_probe(&pdev->dev, PTR_ERR(obj->syscfg),
 				     "ti,syscon-mmuconfig property is missing\n");
 
-	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
-				       &obj->id)) {
-		dev_err(&pdev->dev, "couldn't get the IOMMU instance id within subsystem\n");
-		return -EINVAL;
-	}
-
 	if (obj->id != 0 && obj->id != 1) {
 		dev_err(&pdev->dev, "invalid IOMMU instance id\n");
 		return -EINVAL;

-- 
2.45.2

