Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D6329E54
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456015; cv=none; b=j0jrsNsxjEoz03/HRjBwaCmHwNjlMZqhhLfNq90nPe/Bp9O5miRohABNbo0+lUAlLhA5dh8q0pYQVJKclSSOuVSpTdbBncIUKOppdE9f8doWFWNvbbx/pf7ZsjdGAA6molpkus/TJOze8NIVxrVvlUY5T43DbpCffqN202ZI06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456015; c=relaxed/simple;
	bh=h1Lp619d7jYhqHAcWpvd1UDDc2lrhjlOV9smlZulYLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9fR4BfFXmSq8zUNAFt3apk6B1n+2FrhnN15TQELpr4BSjvv3Hg8nxvdPaGID4K3Rp5/lN+pc8DqwrgbC+Om7A6fSsd3rbFaZaOQ7uFZaWoNXuFF6pwf4Hg16r7jraiJq2y8bj3yrfY58J3lngVQ49VeRdnWL92c2oy1NAq9fTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1900Cpn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QDcNECQ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1900Cpn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QDcNECQ3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6fW1S2343444
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmLvkUJXliHeumILkiajqzMsfEq5vICTPsOl2BmOn9U=; b=U1900CpnwPDwOFtg
	Kgfpw45iKZUrqbwf8kx+RNs+I+wNzE41ofvV0FL2pRdBGnqyuq/WPtgxQo627ONG
	0+D724LYWo0A29pDkYJ4pu4/82rdOkp6SpiHVhTIUPg828l7JHwA0x+RALH6rE+Q
	kVaYidd28LPFIXwJB0FRfKTOYSQj906mEZQAl5FMBfuAKEgqGxrWp4hxGwgBSZr/
	Wvdz96ZxKDI7PpGHZ5r23EuszdniUsMFUVn+jafK9+kDhnh59k1I65dQ5R03VSNH
	QUqjPgEun5B7tHFCOWIOpQnna1nvZW0nVLAtEye+FEcCThkHQ0Th0JiaVE4452kF
	ClOELw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agkrn0c76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297f48e81b8so85701955ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763456010; x=1764060810; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmLvkUJXliHeumILkiajqzMsfEq5vICTPsOl2BmOn9U=;
        b=QDcNECQ3s7zQwtiJm0Jwv7FZnnOsv0/yDYKu2v8RBar2TsNUJcBbVGMKC1YDOMsYoE
         WNApcKBNW7kv9k8MX97iPSjQWfqBuJ0CV+G3VnHn+hZPcWd/+g6HXcSGtIZpnnMuZi7Y
         FpBd+Cw/zotv0Jv7ZipikD2kB0+QQ+K4bhpvjrlRZSZ51LZXdqqR+q+1E3nHQJJwEP0g
         YVtSuCRCjdMf9/tXgcFY9/+Z0we60yHAlsQnBGEzzOZWmf+cx7ogG1JXSnskMMn57ML3
         wGmdD8Hmwu5IhutFZEPYvTyksHEDura2zqlLEclQMY64hhDpZTGyE/ygLH+35Vr3rCv4
         nLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456010; x=1764060810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmLvkUJXliHeumILkiajqzMsfEq5vICTPsOl2BmOn9U=;
        b=IH1ENE0hp6HeJgcD03Vq9VOf+g12B8YtuVU3Vp/3g7a+UQ47Ykgi2xICrdbWjF9PYe
         cEghrX+BrOXisYRpnK6VfHyaCXSJQvsBD/Vwjf4jeppJXedCwZZ/f9RPxr6FsYu2EOlh
         oPMT4r84FVsxhCiUogIDEsvxAM/bH1YF+HLaGGvZpkrlD60QmK42VQujQLoz9XyjrFDa
         sIJ3VjOK9v9TDiMgZ37UsiYFgmdKtGKwi/oO+G0rCDgbg8Sjtih0KFmIOR2wCthogICq
         mA5pR19CUJRrK3x1OanAalr62lnI7W70Tj4gWWQe+tE8ejDfxU675umyEqErjQDOf62k
         4VEg==
X-Forwarded-Encrypted: i=1; AJvYcCXC/pfWRqpRRyCyULFKvcsiGJQ8SC6URk8uEVb7bO0N5tGSbvNdSlBxiWe2P36l0aLylbgcbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yycm4lcBL+nMzow88vb0C7AzbiUb1yxGr2FHYlaZLL5AP0LqJ3V
	QWdbfpQQgHXDYQU1dmLE0JOAn85EwoE29lPJ0g/HKIHX8fHoH9LrspK9wPC5a7Utlr4AfwNQ2LY
	VDCjA3ZEyxm9Kp8BAw2ApMU1LsVOCYTEVa2PQe64zVWsNGD8PHrMflswpoQ==
X-Gm-Gg: ASbGncuwO6Ms2W0KQfTpqGZcN1XsjvEHMd1lQYcjjEJg9nD6Y+LCBkVYCkmeWJ72eTS
	qJ//g25dHFtdoWjCtNi46k/7WTfoqcZn1xK3Vwcvm33Ns5cgdq2Iauz91tX7T58hxviOqiaZxX3
	2QdxccAm6Rh9Wfn7a4g3c5OPuW/h/mvQBeUrhJRb6oLovkJUezholU8h2yGewDM2ep058hB6JrK
	wbl0vop4GAvWYJHXCAxvI6AmwDGiQCls14PPFZZSyh8y4S/EYRmaucNGDN54HHKc6IbFEcS2OfY
	H0LmWRc9QiBtbIWTa10PBqRJOQeQueERtonzJ+F7126lj3lOUU9o1ILRGjh3tKiVw48wjonuVMD
	s4KmSMRZt3o/2Haq2p0U1Tg8=
X-Received: by 2002:a17:903:40cf:b0:266:3f63:3500 with SMTP id d9443c01a7336-299f55269d8mr29953395ad.12.1763456009963;
        Tue, 18 Nov 2025 00:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmBHDdkClqMd+Gcz2v9j9rAbZtFuN9/a70zu8YSvIHuY052TxPvYA/z3DMqYWeJmLLJcxqpg==
X-Received: by 2002:a17:903:40cf:b0:266:3f63:3500 with SMTP id d9443c01a7336-299f55269d8mr29953195ad.12.1763456009398;
        Tue, 18 Nov 2025 00:53:29 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:53:29 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:44 +0530
Subject: [PATCH v4 17/22] drm/msm/adreno: Do CX GBIF config before GMU
 start
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-17-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=10309;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=h1Lp619d7jYhqHAcWpvd1UDDc2lrhjlOV9smlZulYLk=;
 b=i58vssrUKU1gbNMxrtDkq77zKNRGwq/p/6rNQ4VigbitQy8fsJMXAkJ7c8lMfRhPbnD/82Wg5
 8P5MUrKb3gGDEsDAS7lkYOi2o1TOOj0Jq/+yXY4EJpOBCL7jRKSoOhU
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: MSakaucYLirncTkzJP9oF7zh32EhSOyL
X-Proofpoint-ORIG-GUID: MSakaucYLirncTkzJP9oF7zh32EhSOyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfXz/gQfwERBmS0
 d4B2mNu2Co0frf7UJISJMG/TWgiH50egmZbC3KvQpGyBpViGCSPwOsxPeyPGq89Mu8U8FuvIEAS
 8jm9UsWi6WZa9bqs1gN6OGzRjHiD0sMsQLVhLjnkeTyINgEulgTW6A1W/RtIlYKCsB0xb3tR5WT
 IJtj9bJcLq8YNyHeKnaW/Ag/ZnquT4n9r3t2/cYUKLtXvchzOQ0gXRd2OwUDmaFmytB67P4itjI
 l+ZbocTMNiOC1TcGCyZPXWYox9g+DYaEtyA/HH1oGkhHw00nIl4CNxwoJSgfQcvRc3RMjFL3Wn+
 hCzSTDLv9ZvAw50/mg9nsl3O8ObCfKgFART/m1tpEjTnheZtA8SOBRi5Vg/BfHcOH3TaWhLFTPZ
 K9hflwg+WizrMVR8ZqINGbXOQxBiXA==
X-Authority-Analysis: v=2.4 cv=L+kQguT8 c=1 sm=1 tr=0 ts=691c340b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=n9xrOOQmU7Ya-mewsesA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180069

GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
configurations before GMU wakes up. This was not a problem so far, but
A840 GPU is very sensitive to this requirement. Also, move these
registers to the catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 32 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 11 +++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 +++++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  7 -------
 5 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 94ac792fb796..e0bb2c334301 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -672,6 +672,14 @@ static const u32 a690_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a690_protect, 48);
 
+static const struct adreno_reglist a640_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071620 },
+	{ },
+};
+
 static const struct adreno_info a6xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
@@ -688,6 +696,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a612_hwcg,
 			.protect = &a630_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00080000,
 		},
@@ -894,6 +903,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a620_hwcg,
 			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00010000,
 		},
@@ -916,6 +926,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
 			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00010000,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -998,6 +1009,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a650_hwcg,
 			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00300200,
 		},
@@ -1024,6 +1036,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a660_hwcg,
 			.protect = &a660_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020000,
 			.prim_fifo_threshold = 0x00300200,
 		},
@@ -1042,6 +1055,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
 			.protect = &a660_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00300200,
 		},
@@ -1066,6 +1080,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a660_hwcg,
 			.protect = &a660_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00200200,
 		},
@@ -1112,6 +1127,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
 			.protect = &a690_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00800200,
 		},
@@ -1447,6 +1463,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a702_hwcg,
 			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x0000c000,
 		},
@@ -1474,6 +1491,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a730_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020000,
 		},
 		.preempt_record_size = 2860 * SZ_1K,
@@ -1495,6 +1513,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1529,6 +1548,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7050001,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1570,6 +1590,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7090100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1602,6 +1623,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x70f0000,
 			.gmu_cgc_mode = 0x00020222,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1749,6 +1771,15 @@ static const u32 a840_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a840_protect, 15);
 
+static const struct adreno_reglist a840_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071e20 },
+	{ REG_A8XX_GBIF_CX_CONFIG, 0x20023000 },
+	{ },
+};
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44050a01),
@@ -1766,6 +1797,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a840_protect,
 			.nonctxt_reglist = a840_nonctxt_regs,
+			.gbif_cx = a840_gbif,
 			.max_slices = 3,
 			.gmu_chipid = 0x8020100,
 			.bcms = (const struct a6xx_bcm[]) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index d5e000676258..5903cd891b49 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -894,7 +894,9 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	const struct a6xx_info *a6xx_info = adreno_gpu->info->a6xx;
+	const struct adreno_reglist *gbif_cx = a6xx_info->gbif_cx;
 	u32 fence_range_lower, fence_range_upper;
 	u32 chipid = 0;
 	int ret;
@@ -990,6 +992,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 			  gmu->log.iova | (gmu->log.size / SZ_4K - 1));
 	}
 
+	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
+	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
+		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
+
+	if (adreno_is_a8xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
+		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
+	}
+
 	/* Set up the lowest idle level on the GMU */
 	a6xx_gmu_power_config(gmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9a643bcccdcf..4d6f47666ff6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1279,17 +1279,20 @@ static int hw_init(struct msm_gpu *gpu)
 	/* enable hardware clockgating */
 	a6xx_set_hwcg(gpu, true);
 
-	/* VBIF/GBIF start*/
-	if (adreno_is_a610_family(adreno_gpu) ||
-	    adreno_is_a640_family(adreno_gpu) ||
-	    adreno_is_a650_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu)) {
+	/* For gmuwrapper implementations, do the VBIF/GBIF CX configuration here */
+	if (adreno_is_a610_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
-			  adreno_is_a7xx(adreno_gpu) ? 0x2120212 : 0x3);
+	}
+
+	if (adreno_is_a610_family(adreno_gpu) ||
+	    adreno_is_a640_family(adreno_gpu) ||
+	    adreno_is_a650_family(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
+	} else if (adreno_is_a7xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
 	} else {
 		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 0ec265d4b91a..6820216ec5fc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -46,6 +46,7 @@ struct a6xx_info {
 	const struct adreno_protect *protect;
 	const struct adreno_reglist_list *pwrup_reglist;
 	const struct adreno_reglist_list *ifpc_reglist;
+	const struct adreno_reglist *gbif_cx;
 	const struct adreno_reglist_pipe *nonctxt_reglist;
 	u32 max_slices;
 	u32 gmu_chipid;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e011e80ceb50..43b886ff576d 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -519,13 +519,6 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE, 0x00000000);
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-	gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
-	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
-
 	/* Make all blocks contribute to the GPU BUSY perf counter */
 	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
 

-- 
2.51.0

