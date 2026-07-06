Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194447ECCB
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374096; cv=none; b=XtKDZm2qley/Wvd50pl8LrbF+Zs36ZUoXmnHyWz9P2zJIJ+7PlonMaf09EOy3kEt0O70HgTxfHbSMVWa+wN+pCkd4rAmtZASVDKMnJXo8izzAg1mlYEM7Pu6r+EedLsu/iX3xtNf8mc9XvcPQstR3OmBtdfTm6q5/XgTrq0AAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374096; c=relaxed/simple;
	bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcaY9FA0v2N8SKtbtjggaZgo82z6fGtZ2kaMY0crmIhgGFcyhM64lIZrTRplz/6K2dgp/YwRigvym0GD97VwE5sw9Z34a8ekxatpKVmnJECzVGis9CUslEKFPCv1U15a5KHuq4wkW2IPjLgrKsY8KjHvMqOt712eWwkuqFrcCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aF8cCuQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y45fUsev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aF8cCuQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y45fUsev"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KE5qI1428850
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=; b=aF8cCuQeNE/JRcAd
	bbZKBA9JgksxORNz0jvl+9V+WsgIqyei4LiWaABWQbKFSuc1ctnhTLNCBrqcGPiI
	NC455v2KZ5WRCVBTfiPwE031EFCZJrnYaIT61BxeEwlHjPkO3Qc1KqhC06XZPxef
	7Y0GASRkuIX2l2Ldcn8qEhv3eAmQZLSncEVUNNjE0I0JumatV4ZTY0i6fxOHt9Ib
	r9vCqAZclW4aTLVN2xklqwyKU0/9AA/PHLcAEszxSnR1uqaANj27lU20ZfyHSutA
	fBkS5gbEgxhclmFPZ1A/ic3Y7hAfaM+pCSFZWvFPUqNESZUxAhkl06ErXsETGFWT
	O19ZOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxunc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:41:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c79e5de32cso45894465ad.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374094; x=1783978894; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
        b=Y45fUseva3I+iKfljcO02rLa/SBuv1pk+uoJ0PtuL+FB3nC9TlkC2+Ie+03M78UBGY
         Zk21t67WzTDffVj0UVmOE8rn2iJiJZcorfxcwAmpW6c0ab2Y4jaJUCHehi8AzP1jWhLc
         7VUB8BQQinfYpXXjevsIYBpOos95GrYfq1Stvv+HjQpr2Z3Gm6faWTfFRjjStVDqLiVx
         gzV4lwVTlqd50j1EOxAjYJDc4DcmBoXLOM6MojLT9qHkZ1X+2hg/yspNU91BiPwzJxm7
         SkvD+ohi7Jkk6IYaF0wlnwc8Nb1vGx4QC/Q03o8nBtWEHMAVn5CCl8q4YlE1x2EYHDOR
         qxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374094; x=1783978894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4mB77oGh7s9Y0Uqowh6UFsEunZgz5Qm0N6N+M/Go50=;
        b=T/T32IAlhs2gLG2kafGWVt3HfRBl10dZResKkSfecS852QceKCIlkG3aXGvn8+D6Sy
         KINhCvRUeaC/j8xZparN9hagb4mkaXyvQGs/YM90H9/VLqfHt0rlsg02cTakDpCTvY/o
         lxkOPWCeXcxYdVei6WFE5urFJEVeXpy5bSkVkgwyVSgCSmn3ZSLi3/n/PNexFPBnOU8R
         WdqScxdil7IiECv0U+U9FFQtLsvpCAOvHs/prhoQT/WEk4FKqplxflWqEPcPdsJ8X678
         NhCCjG9v7q2uObTWHLAfsgAcYCvOKb6IxnBT4JEefIppUDmaHkiX0kQi1rsApjQTBE1w
         WUXg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0IaTeJN1wMJeGUG5RkxRr9TVY5tJd8oOpwfGzkFjXam+aXvsQ8ycq9PXWZ73H3iJBgN8Qkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNKy3ChSOv4X15kC4lzyj6prYIt4L9Q3FlUxj2ydLAcnolwZWr
	Rnu6AQMVpjm1aczzHTPerr8XeWV/SbqNKiW211jxvXbu3MVwk1744WnhXOCpMGopZsJr5iHspPt
	SIx6zTPDe5nIj4hwWfEVZRwSBrRsZmFNNWHakEj1Sq7ASfCI3MH54busg5Q==
X-Gm-Gg: AfdE7cn2ijEMvolUIGXjF6ajJqUuoTJIAZRrGFlGCVHP46Sg3VORCiGNWW8Ltk1sl+u
	bsETB5Yj4bp3+xAHr1eejLdWkyu3WioqO+vBizItlH3VmNKzl5alwWBxG+uk+R5iR+ZceS1RK4A
	QsRHeFR1RVy64aFN/O5iWMJQx76lej9DEfyo6MzvTY5TGD7GTZrPmRd53/nL8sBivBoO0q/dA4l
	AlY2QEDG5N9d9P+LM0E970WvhrFMqS6pk4BM07YJKpXFObg+he43VHC0EOuifDYbbzxRrug/6eA
	/uGYHYxaX8Mpbmxbxky0S4gX0gJpFAJp9j+dJwu1y2T6DOS2GPc6bKHHmckkAOxgX4mhg2vPAAh
	y+k7A21IwE/2+at64vgrJJUEl9jyRi65JsYE=
X-Received: by 2002:a17:902:d508:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2ccbf07a0bfmr24977915ad.46.1783374093654;
        Mon, 06 Jul 2026 14:41:33 -0700 (PDT)
X-Received: by 2002:a17:902:d508:b0:2c9:97a7:f548 with SMTP id d9443c01a7336-2ccbf07a0bfmr24977335ad.46.1783374093148;
        Mon, 06 Jul 2026 14:41:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:41:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:24 +0530
Subject: [PATCH v3 6/7] arm64: dts: qcom: kaanapali-mtp: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-6-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=911;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vUUf0SFe8a51kmB8FPrJBDQ5H++K+t9n0PvwI74fWXs=;
 b=aWOgXzjDLGOk6ap9wWT6nV8R25bUMhTcQZ8FX1FCMAyQ6W+IvA5VqINg1OxgXuse8gpeFkUWT
 zQiCbM3Ci4mBiSxjBmgJuTY4/9WT4cqs0AYsxWw6lJS2YMP3ONPEr6w
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: vDuRkMmE3i59u0mK3cf14MPub2cSFTBm
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c210e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX5nXY+sY4nVVD
 WL3vKhVpfeswXf7iclQXfkIhVq1mlrW9o8WPgSJKRAk4Xvs3wEZV8JS/wDiIHi2vyosQe/VMbtQ
 iul1cBw9LQ0X6l4s0Cu0euEqjJPqPco=
X-Proofpoint-GUID: vDuRkMmE3i59u0mK3cf14MPub2cSFTBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX+aJBUTEkBmeV
 g/vB9gBfoIAXeJEwRQ9PdZbaTxpB6xdarUKxLvxsJyUOW1BQNvTZIYxel5x70lBHJe7U2llLFZ/
 jCdyPRPI4KrQSGtpBAQPP6EJqE+6svqEs32ZSbq5mbFw6Kxz+VN9frld1CkS64FXhkDW1e+Rdfc
 4IZVFgud0+J2QyvLLRiIcjEFovEv195ByKHk/eHAFWYDyDMlnTZMX5WbdGgLXu7N1nTUg7EoYyf
 umU0/xZddCQ0D/DGpVpdi+/SzKBhS+TAyE942Tl+3QjLHKCGfg2/kCvmaQitikYB4WgEspAmDVq
 AFFbdLIWeHAqX4yuftOCFY5qIn+wLISDDON+k+ZsQ/nSQq7eNw866zygBcC92enqxbmeqZVcgEk
 iiul8B7Ki8WN+l3jv9JW9F2mP0dmpDi30xEjVW+qIQwRHR/FhVKabGZHEor7oKL/9T+KCUtG7iP
 OFPk/QOlqFr1ocMDW7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index f9b5b5718b90..ba256039dd3c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -865,6 +865,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.54.0

