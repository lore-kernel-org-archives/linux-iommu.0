Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558D1B87D4
	for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622016; cv=none; b=LUWhY5FuKHTX0Dt4mcfWLw9rHF7Z8VYzNx6I6znLbGZrIQEtuBOJRGwv64I4DxTEo7gkP1QJUICGmbbojAc9NDbH58rsO05AAQfkUp/159vUNzdUjmeFWeBUOUL7r496ccBtyNWAQNcw/qA/wAQQySvihOQn76zAuZzYenF0IRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622016; c=relaxed/simple;
	bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9SW47NDM4PsumSG7os2D5H1kpId7EhL3dxl43t0udzalcKwBIx+fR5q48S/Vq5IgfSOLZuMNbZUOlZgt1lMkSzjnhY7S4hg6JZyDTwDqt54WqYzipbyJKudxE+PeaiuCk5N7oORGUSzPCIyRrBzjBB4oxnbeCFnwlC7ltknjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJZAoKC/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJZAoKC/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43616bf3358so4187705e9.3
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736622012; x=1737226812; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=QJZAoKC/4s/y99UqomvI6rYMsgzG0zTiaUf/aAf9nolRB9N6LSxtXPHdhqgzHoaYV6
         mT/uBIpN5yf4vuJ1nbiEHzWQ+q8h45u8joocZVYyKA4jJac59cuDTsA3TzEKoqtbf5v4
         P+KF8/dlBQQg2qWg6kCE+ibUOddpAqRMbYqLrlILCS2GIcUC8+4td+YLlmPj2z+HQDC2
         JOv2xJkMz00vuOV0lLW0ngS1BTORkIJ8U1cK96rNLd/l8SoyGxk10YbLi3lLsVanybh4
         oK16rdv3Em7x+iyogr7b5MrW3k4mJ97GGNiF1l67WLfHPdgvREV7UzaSfpiXS3LgQ5SE
         +sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622012; x=1737226812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=QqXWpTGmS73fceRYSrFr4Jx8jAHZ3QIWCi0YLCYrbs1NR3ubSp8Em7D2xjREwX9xL8
         cU4A3Paw4tJujskKtIqwZ0qz7wq6o2hhUQNEFPy7K9+DvsiLUJMCYLusM4xCUKT/PYRc
         9U8UPVSkuKfPZa3Tt1XbJ4sa/Q2e4yvR1fBC8EbOg8rghZlWYvfAKbWkwxflbvgtLuka
         xDFRv2dc3xVSZHuMgRFEdjSq9F/Jp6dNqZqPviJ1JyfPg1AjfNQE7fantpSqMgwUewiX
         B4qM882BNZPfe9hJHfIs40hpPP56diy1QkumbpGUrqxdTfFq34cScCgLsEpDm1ux7NEE
         lIuA==
X-Gm-Message-State: AOJu0YyiIFXXhJRldC4B+2AsZz6hHwLuVugSg5sRc1eI9HqUGjPynFSb
	XAg2V03hHdXfbpatK+zfs5x96Q1Ps81PdKnh4djspL4OkCwR2xd1oSE5LNwnwkQ=
X-Gm-Gg: ASbGncuT5+mPhp/rdxPg3bob2m/wMk/XZGOlQuLj7k8jwt4hidvlJ8BmK8+qLN/n52O
	+QDibTzmM+nHovs7rKEJnSCFTfZ/88TFU9+Aaq+jLQ+dpxhBapLr/Kg96t+4kdhmkWmJPrEMjWj
	1hvGWFsMgQZJ9v7YUJgJ0qEqOddRtfrhSbQ0TnMk0iLkS4Jlmq5rvk8u6cSNcCXZV8CzFYrB8rg
	o2KZqYjuR16B30RHT5LakbPKYnn4uB47Hd5JT9gB22kgbw+9F7pQ5C566kSBKYK1DHw1iPu
X-Google-Smtp-Source: AGHT+IEv1jVX6MaPzk9YWfFxPvpNhk7sVFVmQJQcQZ0AS1vBJC2okXilLS60NBRzCp5RCoDqcFh77g==
X-Received: by 2002:a05:600c:1d0e:b0:436:17f4:9b3d with SMTP id 5b1f17b1804b1-436e26e271amr57227255e9.4.1736622012604;
        Sat, 11 Jan 2025 11:00:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm91309075e9.5.2025.01.11.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 11:00:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 11 Jan 2025 20:00:03 +0100
Subject: [PATCH 3/3] iommu: omap: Use syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-syscon-phandle-args-iommu-v1-3-3767dee585a6@linaro.org>
References: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
In-Reply-To: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBngr+154iJVDr6Bek6vf/Pmrauxc84a8nAup5US
 /XFRH/vaTuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4K/tQAKCRDBN2bmhouD
 14woEACFdhHyjXi0vi9iVENRVyPy3ikrkEw41a3m2x0SBGK+HiWoDzPoCInQr2DvPP2ASOuOzlA
 1fC0UM4T1d+hVbe6osM3LzwXAv+mFDD/QUyugOVdn0SfJr16/m4QWWo9TPzOJYWCF02A6PDENvy
 8sZ0GBSQiVTVN6VwzHXh5Uz9xLskgc7iHDOHE3P3TSqV04Sm3tzb4n5CXIbn2rZVRha+G7FrhGA
 akLPeFi83AwKIHZPRBX4sCByOWRYAnGSSbukYgXskw0x0hyI3jurgqd6hY5PvnczkpLuKSFLDuA
 k80Zl7ErDIK9AUv2bmuKpNMQchjwI7U+tONa7bS+GBs4YT7yXNLgihDTeL3bDzlrwOpNo/vMD4R
 Vx1lc4ePMiM8i5v09vU74ik/+FZuZwF9tuGzAfgfVQcQkK4jsQZFKw/CiodsSZO4sctHnnJZuKt
 /oi0fjbJxFjCKxIZIPl7ad81JtB8Ll+btjsm8VJExar9NbYSgDtqVdMnVtKNFDl+e7lMzMzJ6lr
 N44D++a/ZXAxtDCVjn6SWJhVBjs7HQWr9Zrzdb7CYOFwTwguXE2LWCryMb3AG7OS4pkdxyuaIEP
 GNdjGmz+0cArwVPH6eFmvU+UnNXfOos7GlypMPJF4AuCnNmHBmdxUX8YaKuKhUCmoOrKNGO3VBo
 a1tz5uWcg3TioOA==
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bce27805805010ae473aa8dbd9e0cb903dd79bba..f12812d3f828ad382c7a84f6ecd604c8f35a6d10 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1127,19 +1127,13 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	obj->syscfg =
-		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
+	obj->syscfg = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-mmuconfig",
+							   1, &obj->id);
 	if (IS_ERR(obj->syscfg)) {
 		/* can fail with -EPROBE_DEFER */
 		return PTR_ERR(obj->syscfg);
 	}
 
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
2.43.0

