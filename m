Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E683381D1
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349779; cv=none; b=eZYSLJD/ZtSeuf1wncadgzd/g0aEJeyHwDSRrBLnzdVggXOH0Oay4HjVyaMefX+vAXXRTi5abyv1CGyWywUxUW3IktKkN1BMt0z2o90i4XOFkDSN0FbzVgFjR5GfDVcqSIIjFYgm0qrTUL2OzpkClda4k8vPlto1OnTxt/Hgqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349779; c=relaxed/simple;
	bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOFa5SciGazY4wQHpRNDDibS4c74B5MXcuK2kKDIWno3OiPuDJujbUrNOKWi5ZdLeYuiQAmD5bEgJQYHuk/ezBEZ3z+1yRV6qrJZDj3qgqoVUXG/sTpZziniNlXqH60hjoTReyUh/t2nXek+3UuY0bW33ka5czEtvZt+QN5mkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhMXgZIL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhMXgZIL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so3659731a12.2
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349775; x=1708954575; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=qhMXgZILlhZ2nbsUtFXzeNRtIvIIMnfMkk5zVDU9ElMwg+Mi9+ObucFtjChd0u13gC
         8/Cl2sn/vrMxzJUfF8ZGq12qyOAoA0F7STi1EgxMS+nBUEaPlCe2YYB06ilyRzBpyvf2
         WgM28un/pQEUYdqqiRC2PwjOiCiIGExPZc3j9ckATVmU5oI6tnlpm1rhsKoQ3K6DNFVt
         5OufxFPUZulBCh5pkfL7rNcLziZ2p9LU2KUPsoMTUBOD79Mu0xrFm/uUhjAWkxvXM8CS
         1PBA6dTn3tpE6la0UNRG4ckaVSNtbdyeLuY6RPhU/cQHC88SsSTZ0B6mPNHFMn3wG8Jb
         sB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349775; x=1708954575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=W2Qp5F40YISUXNG4+sKvsVtHqGJ+Oq0BeSm5vtbwtrKmzMP+sozZou1i2CmTg6R1hz
         PTddSt/ccGnpgX5Sw6mxMgb5kohjXldZXQwWta8gHpjmuslH02jtb1YjS+U3ODoMKqkn
         nELhmGVCLVPCnX5e5tB/Dz5/e9jWXTFCIh6aUATrNCa5DbFJFGaIMRPZAB+q0Gw/SuHp
         5gDL2s3M/3uhHzaRZMwAT4E0HPX+4ppg6wBAfjKlbIZ18ZJ1MIoW4PC0gE8douxTwE/H
         Kk2PatofsPXn32C83/vJzZCgGGv65QKI72TupDb8QFON+odf//bv0nxFfks4Mpoqcfsz
         Stbg==
X-Forwarded-Encrypted: i=1; AJvYcCXjeBWY2QUMkKDSWKQYSeWKwfcTB1MLtabAFETrL3fEA8S4LR6bb0rxTB1gNBE94sOFV4hStXoHcnjZEsFIZTboLAizwFM=
X-Gm-Message-State: AOJu0YxAD3/dQfmMw4g0dv7kdV6GY6zQH5foFH69q4XzvZZi6awEI5fC
	cMR/tl5oEbFIN0vk476J3LILMZPiw9VlfDW6/n0rZ8SY46q5+gAvp4UvbdySBD0=
X-Google-Smtp-Source: AGHT+IHMjM8WymNt4vEQq/mCWKYvpVNBNNxjTt8NZU0BjV3r5AoZ1THDhcM56s0PPBQZdIzF6HDHNg==
X-Received: by 2002:aa7:db59:0:b0:564:ad01:20b with SMTP id n25-20020aa7db59000000b00564ad01020bmr139795edt.25.1708349775056;
        Mon, 19 Feb 2024 05:36:15 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:50 +0100
Subject: [PATCH 5/8] drm/msm/adreno: Add missing defines for A702
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-5-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=1379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
 b=uy8b7slouVEaFRzlMDQaQuGj6/EdLKuvoxlWss5WCvpYfkQIMuuko+sE6v3X1yKkbgzKjx7sS
 Sr/e/dPpNpcCFZmvXDeCJmc5sQgAXJeQ/E2oSh1XTeW54gedzNfKZ7t
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add some defines required for A702. Can be substituted with a header
sync after merging mesa!27665 [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 863b5e3b0e67..1ec4dbc0e746 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1945,6 +1945,24 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE			0x00000122
 
+#define REG_A6XX_RBBM_CLOCK_CNTL_FCHE				0x00000123
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_FCHE				0x00000124
+
+#define REG_A6XX_RBBM_CLOCK_HYST_FCHE				0x00000125
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_MHUB				0x00000126
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_MHUB				0x00000127
+
+#define REG_A6XX_RBBM_CLOCK_HYST_MHUB				0x00000128
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_GLC				0x00000129
+
+#define REG_A6XX_RBBM_CLOCK_HYST_GLC				0x0000012a
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_GLC				0x0000012b
+
 #define REG_A7XX_RBBM_CLOCK_HYST2_VFD				0x0000012f
 
 #define REG_A6XX_RBBM_LPAC_GBIF_CLIENT_QOS_CNTL			0x000005ff

-- 
2.43.2

