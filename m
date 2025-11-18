Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568D30F939
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455897; cv=none; b=pOjMJYyh5s18wwO0FD79v3z3JRrQ5fS/TexWoroe9TWsqsDZ/oPd1jiYYC3ewnvbFvfpFvg4mYHvKQguoUR0sTs/KVRrz5koHxFKya6A8Pd/eusu5FzqY2+MP3Veg7DGSeWcVm6eyavJt9PWX3bjK9X2/YdpD2upTgqgJqCEoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455897; c=relaxed/simple;
	bh=U6hCxZZPt/0oNlBV0Loqbw+1ONR49vXzGV9kkJKQhe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hb9vkDYZRYojdviW7Yt80XfFuo5Hiw5aXFoZ2TdZPvEWDPyaW7cabvUrIKbeaboew/dvZfpJlA812I/YSPahV7YyioQcbjLOlviuXMgLx9KancAYzHt1rRdzoB9rulRmA9XmwZ0DE8gyytKlYtICUUjpZOwK92Pz2fkpuGTph5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGCKO1TT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GeldwzYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGCKO1TT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GeldwzYN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VOST2249881
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8PgB48It9l4+bkgeIQSRAK2mU0wwCQ3DP0FmhMvQ2U=; b=BGCKO1TTAyU069p/
	i4rb15w2jCE/nVofuquIXNRUsAqggCHFPmaCEjpn6NtGJYbXj4aJf7ezqTXvf0H0
	2aYhQ13cJNQxscyaDZn+zuEuAGFxzVKJi8LoWki9L2Ex1Xr9gQPTrCYDcyUS5Vvo
	UfIzKwpQMphc/UrF7lKMV2kwV+qvZS5c91nU3tDte9O73C3LPKyd1nO8Nf2bL3F4
	CqBYJgzeHVjdhFR2sUfwZXRrRhB5szA/oYEjgcbBst4y0crwdxl1OkKynAXXmqvf
	7Gp81+i7JsItbb2Mp8ryR2T/j8UnFWnI1dG/HZ7GakP6HxYbjF1+sWtJcvEANy58
	rJefgQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5g1nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297fbfb4e53so94965325ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455893; x=1764060693; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8PgB48It9l4+bkgeIQSRAK2mU0wwCQ3DP0FmhMvQ2U=;
        b=GeldwzYNEqSaGGt04xtJpqvU4Ix6ozIk0IbA36bszUnbyxm0XvUEHxP8r9mooMN4L4
         NBvBir+X6qIZShukbAfXWeQmBNlkvro9QcBPjy8eE3nfZTaweg1hVwPxtVCRKk88nloS
         t8Ae6HEnEbsPbOASYVpIWu1ARJWmG8mfUiR7wwDKGch4Mp1xPTlmGGSev5BosfPpnocI
         IWrPeyQ7kRA8Xivj4Dod5/iZqxcT0L75vPucsHD4P8N0P6JqTK52rgFVbstpkRWULBac
         9us3WC3U7cG/i2xwkBJX6kdfyZ9m2BA207vrTPp2XYY/9YzhfLJJ2mCny4505VJSgkEI
         3fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455893; x=1764060693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8PgB48It9l4+bkgeIQSRAK2mU0wwCQ3DP0FmhMvQ2U=;
        b=fnGl3RPePnGq+jkj+g5zbs8UUIBAXTf4BqM5eorvbQ7ffuZsc8yB2qiQ4PT+AKuoc0
         VVAlSjHwgGMlWTB4JzWwm9UHl8s1R8FIElrH1WzvV0cEYhxxyf4n6YeY5XqpfzNjM3/u
         iKKhE64Okqj/5DnrLJBlVaFyvwFnKCZo3F1gHzJ83q+y54KkcBFg1Cf6Txbt6HbNR6Vv
         XuQnz5UdpKzPZIgLwBrV2U9jZoxPPvxXoeB4fuS0GTIlS9fHu8r2myf6jLDntqe8BWp+
         Pp5sZqO0XCe3sQywKbdYr6pjttXK7mMQEpTsIc9bFLdA0PN53CQ4uoGszv6DKICceY2D
         HHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUeTBd4AxV8qKtLEf6ZXAHAEp1ujtTWcWcfZkSsCu+MihZIMwr/DfCDlpuBL3FDknUFLGQgKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnLGOwwBFwIyC/ecvvpHYXcIDm3Zpw2TlHny5vOcHfYHP+ONDV
	lk9YrRc6WzfxLO7BM+B/MJazK+oAs2FyqO+k7iilcHPdKrwv1pL0BC0Vk0KiaN8jc8o031pV/iT
	7USgyYqpmFlFC46gXtBAPqr5dt1EU1Uzu4cnHiDRyJivG4yKJ/OCFW3w0bA==
X-Gm-Gg: ASbGncucz22L/hNCFC7oLlyUS8iHd+Q+n9+HiSUzvjXV6P0/rHzkv3czOgTKMw+KjV7
	Zn/P7L9eAB6zVk/8tNy/uVT18pmDMNXxfOmYl2aoMRM+fxatrNyIkuze2wo9GqHtrqtgM4kbNIj
	64u+bi2lHy3UEZ4qeAOTA5A1rkkdoaqLZt3b0IUfMqH0gwX4okrl2DrUP+DYcIrVVP6MQFk0zfu
	Cu9CfWWN9NgpPRABSd9LX+a6N3AuLyVGZTROjRTuWRWgnRzaPRtQAsReK9BaauksdWMOmWDY8Jt
	XzSqAlKfMtxShwDSzit168Jf5PJJnU6IKW98EI5p0+QoBGGor5QSVqPQBFwoGwf8FAO3lPZWXib
	tkkvlccJ8VH7DDOAVWO972bc=
X-Received: by 2002:a17:902:ec84:b0:295:269d:87cf with SMTP id d9443c01a7336-2986a6b56a9mr192322365ad.5.1763455892990;
        Tue, 18 Nov 2025 00:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/1w2jno1zLyed+Q2GzLtuvbQPSdeph5rJVVJKuzROZehmddk/3K1qPE4B4EcyW57S867iOQ==
X-Received: by 2002:a17:902:ec84:b0:295:269d:87cf with SMTP id d9443c01a7336-2986a6b56a9mr192322055ad.5.1763455892479;
        Tue, 18 Nov 2025 00:51:32 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:51:32 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:29 +0530
Subject: [PATCH v4 02/22] drm/msm/a6xx: Flush LRZ cache before PT switch
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-2-86eeb8e93fb6@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1701;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=U6hCxZZPt/0oNlBV0Loqbw+1ONR49vXzGV9kkJKQhe0=;
 b=C/pQ042VX0YsNIUePu8RhYDT4KrYwopA1aJuj7t79NKSGb6UQ5wtIm4sVjq3irgGDqFwMiXFh
 6bDOXlnFvndDYd0I6mseZ7fkw9MQk6CD38MF/bxLZlvdHiqWoo3qp2V
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: qLltoSMf59DG_fdcTAFTegjB_Jxnl3zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX6ZssEasjoVlr
 SGjECaLc4NL5Ep+Gj8JpSMj/zdyGzy2z5NVHD8/Gj2deXxjmLmlYqu5a1eVVkBNr0ZDV1DIqo1c
 BhmfBiNI5WE1QMwAmxdne3wMow14CteAAKZwlYSFkHBT0WhBKehcE2zmLRRYXwratZ2l2C/al7v
 pYdeKAptnZIbwIw46SrjkhZ5apK+dac8Hne6UZgrl340tl+pkH/4yfAIUoYkdRXT5FuAF7qqO13
 cW/jdiQyu8kuLKmIjLBJRc8NkqauM+d32YcFfeQhoCuNhsHboniPGaeHAJ1fSzkBbhpZh/C7okd
 4sfLa16yjVIlVzTwUz1FQhFgAVUv1pDlEaYmMPY8MlHosq9pkXYBYXkP8J+byTqnb59MO7FXfzV
 9DDqE6B0zja3eo5jVjM71DZIl0wi5Q==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c3395 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bBR9okFf-Jgdumx6fEkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: qLltoSMf59DG_fdcTAFTegjB_Jxnl3zN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

As per the recommendation, A7x and newer GPUs should flush the LRZ cache
before switching the pagetable. Update a6xx_set_pagetable() to do this.
While we are at it, sync both BV and BR before issuing  a
CP_RESET_CONTEXT_STATE command, to match the downstream sequence.

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 779c1da7c46d..e6393ef0fd78 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, submit->seqno - 1);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BOTH);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
 		/* Reset state used to synchronize BR and BV */
 		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
@@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
 		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_SET_THREAD_BR);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, LRZ_FLUSH);
+
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
 	}
 
 	if (!sysprof) {

-- 
2.51.0

