Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22D3328FA
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371912; cv=none; b=CFeh32p6p/CXifEPQw+BGVNLumT1P0r8LU3kDn/F28K19MAMOqx86JLAFh4PiBQUSNOG7CDTzoRrp6rFzkFvhWDD7WCSvUyP2gnC1Ylhb+uo3kRsrrnnAz5nCrgqPNi1QH8t7vFfek23d5b81hShmvxkgeYPxSpO5g1dpWj143s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371912; c=relaxed/simple;
	bh=49NOvaGVwlvi581GKoxSpuUe/4IKdws2QDL7UFNjgdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcE0c1U/goAMA/Qs6RIUwFQlIKNsxnH+sV+bp91wcezofI2T7DoIYlNh0++T8LwEFRmiWp6ic4y1+B2bjIWD6KUvDNrp1soqQikRgxreGFSCE51wVf5S8kxVcBC8idVaYuXLxauhPtu1Zl7bRNIH9gz42OXoExYlwnHovNNFhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lkb4D/1X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uisl99ZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkb4D/1X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uisl99ZU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEMPK1429162
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=lkb4D/1XuVf9UMpQ
	BgU+KGNhS6iWu2lcOfX5GQ36WYrsSl18R5ZG74JTkUIbt8g7M64XiGMIgDLGMCmF
	8PjEYu/uy0TyMoB7bcj0rENYAY1HMLQhHKwXsHGY73TTMqtlPFSTsZA86gLqU3JN
	14VgrVo2Eg+mXxFka9uofvowzG2FT/gddAJfxxj7+nDP1hXyQ8LleIY8W6MIblMz
	dzXbGoALDZnzvHPZr7XeA5ArlwYHJoMFcywOfZvxj60WrfIlXAURgFKxYP0HCx4t
	WX7BSPXHvMvlIwwVnd59NQDSxl2geVbVvbSemyyk8NEoPHtVb3At1KO6y5Qjp0v/
	aD97iw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxuhb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:05:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6a20348ceso48805025ad.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783371910; x=1783976710; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=Uisl99ZUpIyVImSM0Vyh+YTS2dni3z1C6DlksGuztpWUPnFHNlj1p0iQAKPqz26VSr
         XsKA/AekWu8ScQhdaZl3ur/FKXpNYA2GUirXzN6X/0/YghXGjO8Owu42ws4alnaDC+MZ
         c/01Ag3jomoVnEhaWwUU+avlQ6u3ajt0TDenD9hMd8/vn9mnMMEM330hw8ZqvqQkn97J
         HezQbvvM9omdV+oEgG5ZcdwzaY1WuM1d0mnCk/F0aHV/wj5IKTIiAGu94QC/MZfbaA2Q
         d2pY8tTGf1Ff1vdFJLp2eA3MkOlaotM8wkXgpMFIiJnN1+H/t7oLdbSwNJQcy5ExY8Bl
         kuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371910; x=1783976710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
        b=WQRhOCzQJiBm5ykbDwIAuCDgB0nwDdcHdB2awzfcFg8U/C4+BT4FSGtCh8OMBxnNIN
         L2hw8dPZsvYmJg/oA7o76Aksvt1amPD7v08GCiCf7RHM69qxyGPIGA+LnXo8Z5G9zNqk
         WJ2w4wiy4r59W0B2bZbrzVPw5qp6Yk99b7m9q6mtkpxujPq5qzYc1pMGq87YO+wPKSKA
         YBq5/AFAT9bfSj+52iRdR+F7atkIL/UQyh3J/AQrGLFA8ipOIkfd7gKa22HAGHW7aHAc
         +UhuPSEysFZ0oAuLCFvkz/jQs8pVhZZjaJMTp6nf7hMkbhGhrdgLkGMEirvoHToM2Cm9
         oJYA==
X-Forwarded-Encrypted: i=1; AHgh+RpdAmDBXmiPaUEOp8YF0mOWnBIbnJDF1gT8Hx8m3/v2O4zpr6OISUEOJtejRGcqXLPhQarLmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4AQ+x+b7ViKiJf3yu5lmQoDWTKPpDd797h8TadRqRW9Kr/67P
	I/NpV5YRR3bWLJbS14TpE1BQkZYS+WBSj+b9LSq7p3LgibjMpmC9KRq6u0rU75XhmSryOGB101A
	Bi5Lzm9nPI1mMIdiALdLmdxuqUNiaD3wR8U7cVDOAYNL2okzX0KP2dX/2ig==
X-Gm-Gg: AfdE7cn104t4grXbKQgUEVMs6KTcmezcLM1CN1e2T+x6Fk2fGS7YY4byLWYC9X9+7jT
	AqT3A3Rv5BIYe+GlgCI0DUxq8fg3vPZ1t5xkNjPdt2uX8rl3WNVaiofbORBMmUAsCOROXPC7WZw
	lmtTbLjp5MBDUNA5XJXRIOwqzWQ6qqh8y/NVeRSa16eFHpTAKY4Gb/20QGbct9ZvriCg4vTPogX
	iLD1Y6gC/pzFXYhGLli0XiHc2F/PmGUM5Tf2ILa3AqDI4LkhP2wOV8A/aVNgRX+UGQjWrf9X1cp
	4uvHdJ0BvAcut+7KtjuSLXhxJcvrHiLNT8f+HVYfSIaXlHVXyIIEwZHs3hhhHM/l7tMEb6h6jMk
	hzmZFdakY/lA0lxMuYe4Z8J5unXbaEb/oZDk=
X-Received: by 2002:a05:6a21:2c11:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3c08ed578b2mr2371347637.22.1783371909929;
        Mon, 06 Jul 2026 14:05:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3c08ed578b2mr2371304637.22.1783371909486;
        Mon, 06 Jul 2026 14:05:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:05:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:33 +0530
Subject: [PATCH v5 1/7] drm/msm/adreno: Add support for A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-1-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=kpXC7qkSjgoy11voEpWm/qgJfUAZ4c17t4cpkQg5YXZd8lqbz6loooMhL15RODOHIRwzyL6tK
 a0+2Ku8Tb9eCjyNtiMNg36/Gls2eQ6ZhlTTCxX7OXHZ2QxAnkps9BWj
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: uHevOtS-Y-q41n-_669cHRmYxmtK-FrE
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c1886 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX5S+VGZyAZATA
 Tli0B6LSvFKBkfOECDznHHp62/xXbpGAuExq3Vu4qKWodScwFPfAw8t7vUbjnQwsX5kusyBq9bN
 0e2HvwDzleg6vzP+45ZUZF8nIOluHvI=
X-Proofpoint-GUID: uHevOtS-Y-q41n-_669cHRmYxmtK-FrE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX/uFmlfX8YPGg
 tp5sX4/a4W8XpXQG8PAao5049TRhhKQf/tMJtSOw5Bq/q1OXEnbbHyEtN8tCP5ipczkX1LMaqCx
 4weLPOT4ruh/m6+fAVQ9Av0yGcmCD15v7g7Zmcon8ziB/WZZ3Pe4HAwCFho3RJbl0O4ftTlNmu2
 BEvO+R02hwmAPreADgTnOHz9yL5j9kioKE/9AB1fbRC7Z2yI+pnxKX0nNKOxiSyj2j/Qnr62Md5
 REds4dlbZV3yk6nEfatC892q+y0HsDJeYEkF8Ro2eHRhFlEiabt7szwWB0M7XUmV/0lfMZcWHX3
 0y32fh+VlUOOY3QWGYaKG+4p0MF+FZlAj9Gm/UOUcFzjlofLC7Xez5HK9cJQ6KBWqVqEn1/KKHo
 sGUS4999YnSX4A12OZmKowcBz9I9YPe96bI+xI3WoUF+WVOZfCjQyOSdxcdhIm/2sYPQDjyRqlY
 QWnXVcK0aMOduBDos2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213

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
2.54.0

