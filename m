Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAF2FC037
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671082; cv=none; b=ZFIRBq0+2uEJSflHmNwVYABniTKWpyAFhuZThuG2+iAJmmCLaYvxKkXeQIHRELDghvo9/9Apsx0tbMtgeKeqm/tkIHP41drDd61XmHCIkqJoFagG2HzoWKHZv6+viWYZrL9cB6sasfvOHMpjcpRnXv0EyGK71TT/hVdYRLBWXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671082; c=relaxed/simple;
	bh=PqBOkMlKBD9SPkXLSG+SxQ4C+QJ2OeUPUwMzbiApxz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDHLIMmKtiROrBdT+rw1Iwq7EmAAB444aNHPfG+nJ0JnbalVG1dyhb8qLSHdbCd0PMtz8ugIh1+g6HID7xYZ369RLZhq0Vdy0Xqj/8e9kIZ1bwpsjg5YVKMTybt1Hu2WKMDOn4cr2aBXv7Ccf4sMXP+GLjENeAoG7w2EtW7Xpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AtoMHTsG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRdSgVm3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AtoMHTsG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRdSgVm3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHifgr444251
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+gh29NgtToLExo4FWXGHYjdoYSLAME9bGv9CYiniEKo=; b=AtoMHTsGd4iaZpmE
	HlcRrS8Fm3n6rjsVRFw1cpmHhlqUA1Ryga0NblfhcIGWPstxJd1/46MZKhpl+DKf
	x8p2WKigW0tgWbf5u2U1sbqeNcbYaqCqZma+EA9rRsOHRy6G/MbNMElGD9Ipye5O
	r6B80xwMQvXeg3hwGp89NpxuA3WkNOmfM01LwaajwRWbFa6beqI+dpgdl8c8a1FO
	Z3Bns/RP4x/h9m7+CR0l1pg5OfobXfrP8yNfycl6o8IjriDXIy+lpj8/1lEFaD1R
	XofeE38AyJF6/Hcmw7TyOUO59c19YaE1psOISv8vsZGxdXjcOkDQTmFtm0arbWt1
	pldu0A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27083cr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30e773699d6so1226209eec.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671080; x=1783275880; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gh29NgtToLExo4FWXGHYjdoYSLAME9bGv9CYiniEKo=;
        b=BRdSgVm3NDsAbJOIJOj1qBW5014X8MOK25VSMiF6gVKUlvXJP0SxXGBr9dIPpMmTJg
         KzBSFRT7NuQqMOHztaN8g/yQS4yaRwijnQGBZIM8owwrIVAbA198P44K/z7z4NiLimVj
         bZXp4e8kghaNJIMnIYbIEtRV1XMwdCEsnMSaEwAMsR5cfLUHW5/AM019rX1mkPbAD5eD
         RlLBkGzPZix6LoY1fndvSoonKzOFYljew7J0y4DHGRk5w3M/a72ONMGu/iYZRVrJsugJ
         qMXd3K4jeQLYYVYf5zx17H7cGR0WXeicO8BfUcVS8McsGyiPJZZdwPhOvQTa4Ojpiol+
         GtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671080; x=1783275880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gh29NgtToLExo4FWXGHYjdoYSLAME9bGv9CYiniEKo=;
        b=ZKAKFJbfz/Et8mgc0AkzY18Z7+rZ5ZA2zeGJfC/P3OsyoSv3ujMDitXz0Up2dcQhc9
         kf2cjPRoTKcvfYdqIZw7uomlg/f0WO22qkKPcs07pz3bEIOQdeP6nMAclOfM5PGTSEGg
         eKpRWI0HN0ccjuaIYgcnShTlN7REalRQhvziHSxDJsy/1T+dJxEp0bsll15xWZx4+NNI
         BmHBVelhKUFE1oI3eWF0kvVYYM3TxjtNEU+hKc1LlejVq4u8iR8FvHKid3j/dgChje0P
         zfJhGIS4oB0aGtQo/Wg9ubYPdo8FffbKwhcXCmU5jN1YD/XqxnF26Uu/F7ClpYxFpNyC
         T8kA==
X-Forwarded-Encrypted: i=1; AHgh+RpI+XH7Y8fhfXfXTqMb7ZbJ3F5EsVwnXJkgbWpSvWUyT1xAHeaytbBeCmGm2XhQqK3RWVMq2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCTWbU67XBhpw5W+W33gJPk/ptzcygVj0u9+chcjwzg67fNxzj
	tPfnEgLbhRLfLNQEBs0YrsjPyWtbGw3vIEPyPsRIQsWC2m27d1VqOWKu1IR5EJA8D8rtiPkrk2O
	9d57JlRRbiCgPwZhzRpQTeAJ0n6jhqfQNmtgJr/KUHLWLmkBhREqTG3A1xQ==
X-Gm-Gg: AfdE7cmWr3pVaNVRcAn1rpJ1pdDnPAbwSJpJTNAW7dAVEym/AOJ5URUvwnm9joTGWx5
	sZPrrQPeSeX5rJy8KAUpqDiDm7zRvIBRS8j+ubIVmsIdQs5a+9aPJTDQUz37t1i8COsmzdi+jnH
	8KFHuKBde2kGWu4fQX6HWAzeD0L37nKvCzY21A5r60lBR7GxkjQmWtByB4R8x5Pfe0D/TB6Pcf5
	+1FQDcAgLcSX3cpdGYMPerA/iCjkh5mGmQKV4JiwrV6LkNXpABG+ALbeqNyY+GgsB4/MMDT0OwK
	CgzOYaqeqpkn6Nhtdbk82kjvJ5wvi98I9zSvAw9cjmCI0A6Kcd/mSGRd6EHhe47lQ1h249OzW9/
	4Z1x+hZldF6Q3eQgaZZk8dPyuL9vfg34RxMY=
X-Received: by 2002:a05:7300:ad24:b0:30e:cb91:659d with SMTP id 5a478bee46e88-30ecb916ac9mr771759eec.22.1782671080093;
        Sun, 28 Jun 2026 11:24:40 -0700 (PDT)
X-Received: by 2002:a05:7300:ad24:b0:30e:cb91:659d with SMTP id 5a478bee46e88-30ecb916ac9mr771720eec.22.1782671079570;
        Sun, 28 Jun 2026 11:24:39 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:24:39 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:55 +0530
Subject: [PATCH v3 2/8] drm/msm/adreno: Add support for A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-2-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ondYi/J4omUToWNmj2nWqhqOf0wePhpZeJylLHwGXfY=;
 b=OaXvuIBH77BLABfsoVUiK2SLQPCijRGfyZFTJz+EP3d0PLXtC5KchOfPnFq6mXlqMb9xG8H0l
 xRhibSzgX5bBOSyhyra8+uMdkhad7ffYZ+5n3w/9rcsw4uJq3KId5uZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a4166e8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXxHmKgxraADUs
 sqY0DdWA6BcOFbdlTdoA/udqkOBhWJsGPctl0bnEUWjB1N+Nm3i4C8ry+LtRCcL8cGugrPk9S7L
 UQGNjgdKsqpcx7xtSUtwlyuUjIvEg3y4BeENRDFbI9SO98sYZNkD3ImRKNUGiyP4mYfKmfaAc0T
 roI4MqVdDeHXDR9PpCFeESJ9dhMKSyUFhzJqS5EiKw/TV++p7mixvy8bBNZ0m+5vOqtrAo8X3eh
 OaNA2QiWgfMQfMc0qDhQ3aMXT5lUy8LFNskAujCprKUPDtiTbX3pQf1wqVT18JqIWgUjAsrg8Et
 xxH9lW6x+RhTuqZ4wHWwrneDR7qEjVNlOkTra+SQy38UFKEneryS6yPe/cu27HstEjRE9ZZ6EbQ
 FfUJrKwJytrKvB03udrUFJJEOkO9EbjC9zrXqbEAwIwZw3CA5crNcSZ5IbkUiH3pz5ItD3MPigY
 uHddW8vUTAH9Fw9sYgw==
X-Proofpoint-ORIG-GUID: EpLkJTxPC5GM59B8XqwVvSXJj1vb5EPF
X-Proofpoint-GUID: EpLkJTxPC5GM59B8XqwVvSXJj1vb5EPF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX6VJnTqkPsKuh
 0N1USNT3BaEdl8PQeK1nGJJzuia1HpZfki2uhMSH2DV5ckH92dmflc6RDM7dPyHdQAXAtCKPKds
 pljBkxtKvVWymhqhMpQuo94M8uxasnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.51.0

