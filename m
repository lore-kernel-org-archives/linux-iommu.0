Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F1290D83
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767766; cv=none; b=OORBe7H5T7+4g6vD5ZRUtqyhyu4udq/gd2wiuOcGgSmiGPbqX0oPy1kH28gfuCtGJufJWUbuzBqUlY6zCbQ2LsB4tzEIEpy2F6CCUmfJgrGU+ofHMaErNBtwyBM4EThgQ7e0ffaDuWczDO0l7y4hscdXhS7iDq6634sPQkYVhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767766; c=relaxed/simple;
	bh=MR4X/vqSPCpzHXBlHPwjTdycYDcqajyWXlyrIiTPhc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWHL5fCPGYopg3ROhoMxGGjE2kiyFVbUQ86FV0FB4BIjCTFM565fESfagTwD1XRFlqSxuQkT5D5NUIhWjvjIJSvLs302Fg/4atsCFdqlxeL32apFYOlICqMC+dmq1Dm4IvtyWAt1oKOs3RcaWyKe7NH6gi3opVaL/wtf8XvgoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFyM1rxG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFyM1rxG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0b3cc3c71so6169866b.2
        for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750767763; x=1751372563; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWhMh/5fYler3nhbWTRM07ex/VdP8S0PYvhv8obnGps=;
        b=RFyM1rxG9QXTXlD/qkjRZAAMEnh75RxjjHGkRBu90nSHPoHTOeE/jsHkCRMgKrX/YC
         EkOBG+MhMWNf625Hvm39ZdXWEAJluskSyuTdPNnOgIfGwJH0mnm3I1MZbD2S1XDbp5YH
         HxitjqX39Rf9d8vADtCSA6hziduB39KQ+4HqO8yBnOzkjwaOLCu34EM2nx+hdRSkxgIr
         YdinFq/f4cECr8sq7kQlqHT7FJVgAt0YC51Ex1hOh0MVIopvDotakK2zVa0aTsLgkCsd
         c/yGC+lYu4U42dpkDhJ+/YY9bS9TBKRH3qzSL3dTOmWng6mcrPTxyd6SLa3x1XomTGce
         o9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767763; x=1751372563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWhMh/5fYler3nhbWTRM07ex/VdP8S0PYvhv8obnGps=;
        b=Q9w43A1ff2iYOopl4hHyerLHnIawOGctdttYkhFzscgcTBUlUkggB21U3iBqqHlvI/
         QvFBh/jeK7XYGAp+Hiz+0hOV0OhVoZCFKsNz55MJftW8hz69ZlnhsegqKVAahDlwunpQ
         H8TJvJuB+cK6/O8guTPM5NhKAeS9DvOFgxD1haIpkHDWOxby7J6H0ivuxMaCAg7/ubT/
         iegYolFD+Yj9rQLB9nmRsz3e/i7n16IcVOMsxx3jLODMwcN9A6qJrSKVGJWReXjPY/6o
         HrR6RXmMeQNcC8Hlm+6ubUUCDRX9mX7BnQZPltNY+wiRi6kUzcxQe9kfpzk4nk4///Xc
         0X6Q==
X-Gm-Message-State: AOJu0Yxl+kb94A+PKCGjO/VTmZXLE0JfiK/vRYmvURxAx2I/KB2+KTxP
	wv4SlseK98z9yzmOvoL96BbgycXB6FdTf3kyrpoK52rGkeyv7wk0CJBkw65eoUxmGuY=
X-Gm-Gg: ASbGncvKWMgOZVKIK6P45eky8HIDDVgVAspVN0czsWiCM2M2jCs6DXhUm5RJ9EAxV1Z
	cEM5XIze5IGjq5qWDPKLzIaalOzk0QMyWO5CViEzAWUzn3nxXFlSJNGT6eB6o88pyKTyHvqlRfH
	aQkQnoHGkKYxjBE3+oz81WuITKmNBtZd4vVGw1SndBeZ6BleyV9QeYWps+asFhaqlJTeV/bG+Nl
	hPS8E9Mmo3dC6pL3tQdFwcOViIP5cvMPB/ypTBJp1Q0ylzFfS5QnARt4nm7e2IW349PwdV/EJi8
	hn/8xzXktzOO4MckEiVbiffDM8hk/EEYH5dtJkQpWdLD+SFLnXgvoSP2Vth4EJlJ1xh539Gos7o
	/rKNBgQ==
X-Google-Smtp-Source: AGHT+IGJeHAE5O/zwjKbt1rTA+c+TADFcI3NU88w3TmhhB+vtkSIGErnItgRWYP4ZJeQzbFZwyUKeA==
X-Received: by 2002:a17:906:7311:b0:ad5:2caa:cda0 with SMTP id a640c23a62f3a-ae0578e8100mr576222166b.2.1750767762491;
        Tue, 24 Jun 2025 05:22:42 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b3448efbsm56794966b.177.2025.06.24.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 05:22:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 24 Jun 2025 14:22:30 +0200
Subject: [PATCH v3 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-syscon-phandle-args-iommu-v3-1-1a36487d69b8@linaro.org>
References: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
In-Reply-To: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MR4X/vqSPCpzHXBlHPwjTdycYDcqajyWXlyrIiTPhc0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoWpiM6ARA2FxSObqWTe3UcZTFThPbO9BDoHWLU
 PhkHh1V/zeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaFqYjAAKCRDBN2bmhouD
 10LmD/9HpPHgdOhaRuuJrbNOYY6y9CLhs2idJGqV/EDv2qgsS8WG1i8N2cleWDdJPlajEelEsbK
 uYaR6Z+FIKU4TWCOtHXjkut3T8C5kKBQfrMWmCzFoA3Br3z+X5FssW76DmzfikShRZdMPIKAlyj
 VcTszq8nPqtvxu9MPR6AJrTkyWRr0CyOJG3fShHB6V3YaHccvBsGaEJkoFElPyKEUMcLK42Vyym
 Zrxd3svSy2w4Zz8vvKJgvjsUUBJ3dr9BMe8xng/sMQWX4Nqn1Qi9GTdMGsnMvKtergM97bwe7Rz
 Qzsfp5TnYpKP9zG8SnvZTJ1FCKnHRwsbJJbO8cjvoIxJkWykthRKQ9fxsRMXyxBPRnuELNnZsxC
 5edJu4QdKJpjs0famlCNyXA6AS9hh3aiTdU+RHXNyKSKjyRnJYLTKTAGIR3QfD2Ura7SpymfIFk
 mId46fu0g5s/ueNSgigZnt+qUJOiarAgsptFCQ0TFhvsIvCoxUWbilR0VYEnQtaWfOZpCRetqNB
 etOLco8RovGOUMrSiECRB6Oek6GPuca/SZOU+PJxTy3ULIfHlbRdmVTaoBp5N3oTW2ZK31yef3F
 2H6IuMznU0SzXzxW3BpTNuOvFqhBE21SupYWzzYU/DRIvtFvHr/Pyfuo/gLovJv9dOWV7mkbqo4
 B+5rkWKjyrOp7Tg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The syscon_regmap_lookup_by_phandle() will fail if property does not
exist, so doing of_property_read_bool() earlier is redundant.  Drop that
check and move error message to syscon_regmap_lookup_by_phandle() error
case while converting it to dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3c62337f43c67720a15b67e8b610da7886f6f39c..4448c0a512137c79195112eea25d762266c77bc3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1123,23 +1123,15 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 					      struct omap_iommu *obj)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
 
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	if (!of_property_read_bool(np, "ti,syscon-mmuconfig")) {
-		dev_err(&pdev->dev, "ti,syscon-mmuconfig property is missing\n");
-		return -EINVAL;
-	}
-
 	obj->syscfg =
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
-	if (IS_ERR(obj->syscfg)) {
-		/* can fail with -EPROBE_DEFER */
-		ret = PTR_ERR(obj->syscfg);
-		return ret;
-	}
+	if (IS_ERR(obj->syscfg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(obj->syscfg),
+				     "ti,syscon-mmuconfig property is missing\n");
 
 	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
 				       &obj->id)) {

-- 
2.48.1

