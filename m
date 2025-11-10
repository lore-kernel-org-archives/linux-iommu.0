Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2947313E0D
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792748; cv=none; b=PK0eO0m+RH3qQUl+I6WLcHRc3wWGQnMF26HgRIt+X1E+xdIqnbxGP3cpmM0e7HxacbRVD7DPr7X0yacXidPIQrSWVk3d4kQ07xNhxqC34x3wYCwyI9eyED4BV8GXziRLq87IkweqNAGDD92wZjtFlQLS1Uopd0TN2Ng18FNd9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792748; c=relaxed/simple;
	bh=FV6xLDthA453vaD5oogIe+3kjmqh0dTIHuw+y3wfzsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqX7SqLIYrpE4zAPBQkODNfI6cBKJwQR0KViCg5IaJ/HTPLjHR4M07umWv+XnLIp4QTKosT6J2r3yFU4D9f4obnLDz6Qi1DG4NIF5FYYnrI4ZAnQ76BEx1Hi7kymRtiQNAGFszENy1p/Be7olcz7oPAu9IGqv+xpkPoe8VcXb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQUKhzqo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jp2oq2EO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQUKhzqo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jp2oq2EO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZWne3271032
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WKibWSrUWripKfBtWsfTympYKLBOlYD+nhQZn/FVCxg=; b=EQUKhzqokJW3UCgb
	lUStWYh9MO6cD+zNjSDLutwBmspsn+lVBRiz3s/hwSJFUslCm9kDSciti1HaANoP
	0LCGEVCgprEznyG7HIHI4yzb3CNH9ki/rmaDjF+b/mHxMAS9/A+2uLhYNg2i5USw
	55F3Yd5/SwwrbMy6zuvZy6Z3vta0X9NkW8xCBjUY7GT3i66/VXXCB61IczV4prcv
	hrt88dFaLWyyB74vxtE7p7xfkSuJ2nmeuz/9W57knNx8O0cb1OQdfGHuQr8bNO1x
	VAxGBvArQLAf3LpRIoNimzupM5SOqYGfRMSh/YWTJQqtTwOzQWJH2s1w8FBb7nKJ
	3N2Iww==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafrvmy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341aec498fdso5189814a91.2
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792745; x=1763397545; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKibWSrUWripKfBtWsfTympYKLBOlYD+nhQZn/FVCxg=;
        b=Jp2oq2EOGgEmuAZbUthMZg0pIMl15HMe0FEdGKfiSAPrHk5+KKe+SVsH8zyhcAmWkU
         Fvde9cxZqCxvz1uJ7YmeQg/o6mN4SXbAN6YrUZaYlyCMhjmI9cJjkKEPOB/F6vAXsNdL
         zfAejyCvkMW/gPkK4nXkC0Hun3Z20XYiF7pZe/siNSVrhubTadeTJfHtIdQmnI8Q7Zhs
         ueo0zgwqjbFnwn3YcQb5mK0d+Yo/g2XCju25iDOM7g6GNrTZFaoD1iKrm20+GxxNPnxr
         aFB5fxjdeUxih96she23eZiYZ5gnme391I7KaG21rZ86UeEbvbTmca3zJl58Drj8HKUF
         oFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792745; x=1763397545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKibWSrUWripKfBtWsfTympYKLBOlYD+nhQZn/FVCxg=;
        b=cXSUHbghH91/gitWKsRoZVfTkM3SLoIzTAP4mXfThicCcnyW4949wEjGe78GZ7b62s
         eg+QCdU2lvjXhJj6Ql4SWTlWNT52qQt8SRFiYU1q3Q1Qz9VjxNjoLgRRogCP4G9ZG/1U
         MELy4dTAOUlD8DK5YGSUWTlKERdmK5TjVTZ/GwTAmF+rg7DWCojIL3O+HGTERmEacahB
         FfBuYZSOCSxkrbNQQXWiNJTkW3RVPeq7vg+ki2oFI3NR21kvAECtZYB2MxkaNUr9P2le
         RSaOpWorTfanGzvNMsFcFNdgzJ9voqFutorKsZnJdAuQWgQ1M4h0cieYBXG36f3gLrj9
         SkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4pn5jeikx/VXHZFfUYt8x/6AMNNWJ3eVPILgKEORgqba9A+AXQh7x2vOaHKONmegbFbUoKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzaojl51Ma3IfIoNfTiXZv22zu3vWKn7A3Q96IwGUzU+9DY0H3
	WCpZlH7HXc/npPn43ZFW+ghBkNWrEIgN4w+z/DFGwqE9fuq9lT/HS7UrzoB/vxxJ4VTzf7E1cK1
	rnOZZoa+Gv2ZqF/o7gvaSwWFo9Hhjne1ofWJBM2FZ78ogDDpDHVYQe+UfSQ==
X-Gm-Gg: ASbGnctjXYQhZ2LXxskgGUqITXdD5fJ1Q6JrJyHAG0lWFFV0NXdl5x8+kmI7+wInK57
	wtDcVaSsflFSL1iAovBpGFsUaRyXDNVoWXVJiD0740aFnMFSljpbzxanm0va5Pz7eGn/5/TGjPE
	JSC/0fUYkvpNUq0iV9V1r/zMxWqFRuqIv9WN/chlboBqYHZjPV5tgUqc0D6v1Ww0cqQcO3H0WSB
	wNKRNVpqsOpmTt/LmoyitN5mrv94UzMRr4osZtQqf+uSBv73+S3AT14NRSGFFub/g9WtvOk9GDy
	9aKrEJIVnd3nGz57kD+XATUbq2vgyzhtSsIjLI7LZzMocQbQlwXbBv7piirjVrvbHeSccBxAnOl
	SUZNEY6yQDq1mJJ+H3nY4Jw8=
X-Received: by 2002:a17:90b:1c8e:b0:340:ba29:d3b6 with SMTP id 98e67ed59e1d1-3436cb1209fmr12752610a91.6.1762792745224;
        Mon, 10 Nov 2025 08:39:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHQA2IWMXamJLpaNer6zgOuLzI6Ik83UCBpaA75HoppwknGF27iOTm6iO2NwkR1P9RuzAm7g==
X-Received: by 2002:a17:90b:1c8e:b0:340:ba29:d3b6 with SMTP id 98e67ed59e1d1-3436cb1209fmr12752559a91.6.1762792744693;
        Mon, 10 Nov 2025 08:39:04 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:39:04 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:13 +0530
Subject: [PATCH v2 07/21] drm/msm/adreno: Add MMU fault handler to
 adreno_gpu_func
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-7-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=2490;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=FV6xLDthA453vaD5oogIe+3kjmqh0dTIHuw+y3wfzsc=;
 b=TbMQN2jeHbfSzsXvNtITuiiGmAIjAd8wamkBaIOa6vE0PSVAN1N+TZjArgXIn5hVVUYEREIPx
 e9HotsFB4BODpcPk1sAT2+SANyLk02r+uI0pgfpOwVIuHYPptV6085/
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: yhRMEUgwvAg7jO33hl2Lm4DTc0559Y1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX9DR00rrla8s9
 SRuLmtLMGms1eVQ2tIJgzp2f7OymtUitxiMCieLUz3sg+4Jyw4bwTQXNwySdwzJR62J91gHSOnX
 zgMeMoKYC60DGNqt6iPY3kJx3QpeTROHHLTufx9wY+XZ1uYbO3hzqEQUcwTZhSs86xAgbhE0Mki
 jdr+sL3tKT4xbmaq44bI6xIc7Ztz8ksRR380Kijjo+ONe19K4Fcw/WUFmPEe70i7YoFfrEXB7xH
 059htS74DxmaJAhmVTcRXT+1Qe7//1n4bh3OiOYfBwUlUPUvRdZF9WQUoHwAWGRDlgJDa4jcnVk
 XG+aEFm+RrM/e8k8CKdYbN4FnpfN0ken0gRi5uTJSOcxkwVfWE440+gyNagK/LTBoXBs49idfQu
 K2vmMGZZyMkDdbO/n9xInaOEfWoGQg==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=69121529 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=i9YFFn0sWQDpYGFnbDoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: yhRMEUgwvAg7jO33hl2Lm4DTc0559Y1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100140

Move MMU fault handler for each generation to adreno function list. This
will help to use common code for mmu pagefault handler registration between
a6x/a7x and a8x layer.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 5 ++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7a87f6407abf..51d32c66512e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2619,7 +2619,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
-				  a6xx_fault_handler);
+				  adreno_gpu->funcs->mmu_fault_handler);
 
 	ret = a6xx_calc_ubwc_config(adreno_gpu);
 	if (ret) {
@@ -2665,6 +2665,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.submit_flush = a6xx_flush,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2697,6 +2698,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.get_timestamp = a6xx_get_timestamp,
 	.submit_flush = a6xx_flush,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2731,4 +2733,5 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.submit_flush = a6xx_flush,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index acdc51dbec79..50359f2be5d5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -79,6 +79,7 @@ struct adreno_gpu_funcs {
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
 	void (*submit_flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
+	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 };
 
 struct adreno_reglist {

-- 
2.51.0

