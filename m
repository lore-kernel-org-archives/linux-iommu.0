Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09830F811
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455944; cv=none; b=fcpYMlGD9+hhohiTqMlRdjXhwfjjIxwDShbQxg3I8AvNcDN0Kku3vEj0zq6ldtqvJWY0+oA7oy66Rnrp6hI7nEZY2c0a5KlnTizok5XOYP3LxdSSKIRtHbF6uDB0mTxBF+5tntAzNMamFO//XaswQ5Zumfi5bMImyL3hkt1G4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455944; c=relaxed/simple;
	bh=ye3E3o4bkNQLrLn0I1sQjG1xLLVdg0W9qxVP6kAlZGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9gvdUhhOyazhlkF/ZpRCKuZ6wY5OQ9eGS5SyqPdtkcjREwUnxbM8rMCIYFagfYGaNUUQtcxMyNUZnj/tnGA0ZLU/AbWqSOCNS20hD5vwGi0NNuoJDNRWcv2sBbbGq1y/qkl1B2/AMmrFROrn4lb8syUdcS6/m6w/6rWu0jIf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PbrWAn92; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YNy5+AOu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PbrWAn92";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNy5+AOu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5M84A3916552
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	knMij2ystjWIyfW63qfz5ONy7pXmsUWRejuLgPEDZyg=; b=PbrWAn92/UAvnxop
	hVL8WnJV+jyrdZzcyx1IT/cxgRshVWUIpNNYmpgd0uNI8bQUiI6E/wR/5qbJuMli
	g4WnDzjNychYcH1QO3cuNwZ9T7MUPXucS7v5Iks/Yf1HuFscEtsB/Arevxk0WlIy
	dzHEaJFVzJevTlVtzBF9+JCLxTJzJUvvbkswwb4TtyTKWKz1PCrkDHJHPYwpoTYC
	CIBzRN8fSp1fVTZPmm6F5vrFtfHBbhXPb4TWUNy5HZ4OCW2ckXGxtk0rU7rzzB/t
	GebM6rn1rYpxTwISucZzRRXNd1PkicUaaqIHjuNqrZiakCW4N002lOqMde/ZBhbn
	bz6J7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2fxbd1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e66542afso177392195ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455940; x=1764060740; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knMij2ystjWIyfW63qfz5ONy7pXmsUWRejuLgPEDZyg=;
        b=YNy5+AOu0qInlcyBBp/oDj9x77LwH3uX9KpP7jLcdlDkb56hhjcWVO0Y21+tvdKMu7
         Z2XDa7H/rYdoXIawtkLXzYWk7BiJLiNZd4MRS8rEjnL4WZHhdrw9/mbXIILnhfQhtifE
         572qVN7rMQmS0Ooo9vok+odm8ARBkQp7yIObn0O3boJmaV0fPNbAiaw+ZRatsdnu6OGJ
         4jGUnJkfQleStCU4UZ18vrwuQp4ifMNnQ8KBUeIUkqx9LTrDFtri8+VdvOD69UYYaoOF
         wPPKeGngR4+MSgLrkOdXJWQZHb+70E87oBZz5HTgaKJhNcSras9VSRE9xNIomZVsv+hs
         2HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455940; x=1764060740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=knMij2ystjWIyfW63qfz5ONy7pXmsUWRejuLgPEDZyg=;
        b=O6QeW7WmY8tHUbbrcBv8RHjpRvU9BqAARw9FkTGuViBbclRhwmoYScd5MWmQSjTO9w
         WxFaHxgjCNyZXb4UwgdQUvtzh1LIDbsvsv92lMqoldvFQzM/lgSQe7yiSc240slvgcUA
         alaxt3s0+3nOyAmiNUqUdtxcGsixp1fpHG48yXXqIbfkq6jeZQmObUnUkuWjQEP5QQby
         fB6rm1zRHwSEoKsVlDR4A9YeewPHSmrMUS7s13rZyL+wIQcEDXmn/cG40ap00G3oLwFE
         /FgRx0lj5hO0HCzHs98g7VqKlpDwV4WYtqJoENbbk4daE8wW/0zyuETJOb6Djw78QK69
         J+QA==
X-Forwarded-Encrypted: i=1; AJvYcCWyIW9RuxKvbfLJmSCH4sBti8tbtnff6DLnhO4D1drAqeo3Td3TfR/Cii1lyH6Gs1jHxdj4aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YygKB+aFtP1f8itD33HdYyu5sqaRWjfL+rmcHIZaeX1+xaRLcMT
	qmzekWij2ebDf6KJn8Rnk6ShHfN4H/NL6OZhq0q1wOZx/kRdKH+uJAdXEOHImEs1gclU7m+hpGs
	qxcOHa6WdhIx4ubmXY/haF1Ed59uj8YkUV+iRx0g81QA3gCvs9NdbGSWzdw==
X-Gm-Gg: ASbGncu+4j7AW6U+sMaVxf3mbWtq2Ga2Q7oGsM6sk9gw7ksRgRMWbOAKLKCEofNHRhV
	o6gKVjayTDRuEZQJadUhXKWeuxelD9zsLMS/v/4PbwqG/hZQRpDfBZLMhnlO3kENIpUkqchAzNC
	rf6waSYwIkBxe/iQuT8ycx+Hjsli7q69fxGWyxR3WFPFEoupj5YVotk/xbQK7Rm6b6O/0WtDFHj
	XYTsn5Y7I2Xv1dFxOZzZESpjh3DPcLZMqAnIzLLBnnmgFa7XNPPvC0Vp/0A4AQr1dm3spjkFd8n
	P5qepkDd/bGwWMa43TgbWQLvavpdA3c6SQSfTAghZ+9JgJBMF0N6+D4wUycsihx/wszKj+SszR6
	WptUE9z0hZp1oy7c0o51JhYo=
X-Received: by 2002:a17:902:d4c4:b0:26a:8171:dafa with SMTP id d9443c01a7336-2986a6d225dmr192585125ad.21.1763455939702;
        Tue, 18 Nov 2025 00:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY5DSlIVYM8XbzjgfaGaoj0qv84BBjOFWR74NO9yqLaQacZkB3oED8rW587lTo9DK6YDF0CQ==
X-Received: by 2002:a17:902:d4c4:b0:26a:8171:dafa with SMTP id d9443c01a7336-2986a6d225dmr192584645ad.21.1763455939244;
        Tue, 18 Nov 2025 00:52:19 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:52:18 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:35 +0530
Subject: [PATCH v4 08/22] drm/msm/adreno: Add MMU fault handler to
 adreno_gpu_func
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-8-86eeb8e93fb6@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=2452;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ye3E3o4bkNQLrLn0I1sQjG1xLLVdg0W9qxVP6kAlZGU=;
 b=uO/b3x2yM+ErviiHC5Yiqi/gnDy9JSeF3Bmq3OXfo8eK4rnUn7HPMORG4OtVFdsgLXpz3DYe2
 wILpk1MLNgzC4XeeECdd+yI2O2WBC6cJabZuE7vqvTFBDIx8LII4tbD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 5DS-wiYUrO9BgqrHDn_vhtXoeQuUAP-e
X-Authority-Analysis: v=2.4 cv=EIELElZC c=1 sm=1 tr=0 ts=691c33c4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=i9YFFn0sWQDpYGFnbDoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5DS-wiYUrO9BgqrHDn_vhtXoeQuUAP-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX7ksUi+4mmzr2
 h39izC0k4xoTDaA5MgpmtVJCJ/4Y/4gcP4L3KuE2PckibKa9OQptVFGJsoeZHTLY+m0B0ry6zFK
 7wQtYUqr6JS1QfD2s1hvfffxz0/dGf/6PVyXoPC1Kt3N4UeY3P70akaFsKLBimb8OzaQbAWabiS
 hV9ykFeTpJuIEdWLa4h1CTa0/kICeYBdQRNMWXueG/ezdo86jSD822can5rUDILmsZOleCUeYO/
 M9zRBhg8mEqLCHPI7gvYXOCPOZ8Sf1Yk2z2CRrrvYhvfsrGZ7b+zwey62TtX0AUblqLk+gFlj8a
 XBXk50VTsL4bdG05hbdSbhZKOL2jfQmaLoIP9S2svLgPEZBKVIGPqt9VliNPKwc2s1615K0tT7/
 z92vxNZ0b1cejSkS/gV4DGdz2hxMcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

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
index 575f2f9d3b1d..9edd23d419ec 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2641,7 +2641,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
-				  a6xx_fault_handler);
+				  adreno_gpu->funcs->mmu_fault_handler);
 
 	ret = a6xx_calc_ubwc_config(adreno_gpu);
 	if (ret) {
@@ -2686,6 +2686,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2717,6 +2718,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2750,4 +2752,5 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 08bb601b3bd3..922d2dee70fb 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -78,6 +78,7 @@ struct adreno_gpu_funcs {
 	struct msm_gpu *(*init)(struct drm_device *dev);
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
+	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 };
 
 struct adreno_reglist {

-- 
2.51.0

