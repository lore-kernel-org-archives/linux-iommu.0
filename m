Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACB36A34D
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239346; cv=none; b=XbC8zgmmY3HUaXS11fFShBSR8WlBkI6O0oTop8u5U9K1lkpW6hbeZeE1wIvs6/JQ7ejW5VTP+lpiBgj7mFBu+IxljeVumSS/mDelyBotJa3mDiU9PJer47fxQZO52+ovzglqA8Ng14cYEINQHXbE4RfaUDM3DgV1t/eQ9DydVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239346; c=relaxed/simple;
	bh=zz8kQOzV0PuuiEtF3vaop3G8EsC5NffbLveQUA/TTGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZbKOU96YYPSZ5WfFQ/XvU3x6E/swwN/+0mqEq6Ygxvkg+hUzdNuawBUtV69jjga6vlOJYXxRVQF36enJDJCnrW6PzmcIqMRXV1+Y6EA7mOyoeqFjUYa2AMPMKDnIZJFxWd+VsCkMkdwN4ctgc8b1dSgHFYW6ib71TilVMDw6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx/nqlH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbZaeZOc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx/nqlH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbZaeZOc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6652gocC519328
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=; b=mx/nqlH+vQt38iZQ
	d28JFJ/cemI1rlkM9IGsruBz3FStlE2ismhLruTZkYLsHK/TAIDeWZvHAH67sOCn
	gNEXWi3bJuodCCA9h6F3LSX3oBr2HztIVG1Pnn9lDb6nMrr1mrSQ1BMF3BfMYay3
	So9w13jlRxMWddtwLFWb702CUBzfPj7+Gvc0lN8WNcpFm1sRd4+fbt29w4WiLza9
	keonQARIz/xuOcnA1icyyGgBSPfIstPNoYWlWaP7Co6w1pRXz7smtrNeYEHU9Irg
	ebAD27rNojNDVWOPktWa+NXGIHNhS6beGoxvZlp06mCqEowft93vcljxV/LWmzC8
	tN0/Aw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aase-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:15:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae455cf6dso23668585ad.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239344; x=1783844144; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=;
        b=WbZaeZOc9eWF+N71kVkcIcKU7auzpG1rQBuBWG1/AYjA+7sMb7h7s1hWZJzJR/tgZ5
         AklTrwlJMFglLg0R17RNRgFgDiRruqZ+Tj8oJ3g48yHTpcvt02pyQQeIyfgP6fwhjSu3
         QGr3I/HRNAgDti+6SLbTuVeWAW7mqeiysAZlrj3cnKQHjKJqD1sNCzOq9pDfoGgwufkl
         gfpy1pOOpdq9N9N6B0isnjpzWv77D9hudTZ6dg0wlRpSfif+NFr/knC+OJUnmp9Qkla7
         dOO5hAEuBLilqOQvzDDc/N303j8TUFt1lSSn9ayI2ufdtq4P0+7D2FwA1ByTRqz+9WEs
         UiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239344; x=1783844144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KnbrADbl03nZ3Cw89pBBXWj7vEWq4V7jAOOPfBK1kzQ=;
        b=eqimDzhP2Rt4k+ENvHXN2/RHU8cp6G8+KhiX3FIDbswF3HEgiEJ/+/QJT2mOPTXonB
         xu2dvKsQaGZJ/RxzPfZwprgcVNDijMZiigebztMFRPC/YcfKmZlfBAiNF56QUAfhInM5
         a28B2vFaJw0BranM8bs4zlEISAFQdxbKwXBKUvlu+L3B6erWy9RT37MM8PusQ7J8SHn8
         ZQW09HN6AodQeY22kyWOvRzlsShsZUQ8ZpjCCFwdxIwPb9SMTFrwhxmnAf4dCR0WpBbT
         gh5AUawDummCpC9zUwBfnh8aw7K6spfsnEY2J4C8po6meas7tuIYqBBo/UoEbYY8iGsp
         qKVg==
X-Forwarded-Encrypted: i=1; AHgh+RqO+drdTKd8nw0ns4OIwEU3mrAF5BGW2b4p5ao+2ceV08intfJbBqjv/yL8G15U4xPiTBEZbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+ZCQJ+vsswhkMo1MMDhW/ojA9CZE/7aSb41w9T0o7rLrWc0m8
	kBUhaAqUZNhrGJyJY4cz3waTvXCqfb/SuB35ibqLoUQiE2xCKbGhlOyax9VjIO9zaiJpmfoHKd3
	/Sk7ramN7jD0A3nD88uYmQM/sEfdw1ib5kT6f+1v4EumxWWqizn4dQ2hNcQ==
X-Gm-Gg: AfdE7ckmXUZ/7hmhZeP1YIlpQ9A2MwjYKGXJ8cVGRO7U4bGO0sJ4vuEmlgADPzZjfgc
	IQlbbGdrBApVfl8EQE0JZwlHn2/g8wKseswrf8PkYlMxeGBiLmKyFnEZPOalF3OPyWnlTnqh4hC
	ci2vRxKirpDiV8r03uxid6LbGhIOJUz4hJJBbOYvCLaUSzz1GIzeCAf9EsJl/q+w077u+faBow0
	s6oSD0i4bMDdNU5D5xRQlY5m76GJMPFy9ILLd+36rtdrRFQ3SeEXUl9ZTO4EP2aETQGG3j+W6k8
	mrMJpO4qikmXkG8R1TiraYiuKcWtzWrpdDwdxT0cBCJ6ON27uS1lyeB3jPG5GUIRzRJzy/hW2gX
	RefLxQ6cajQg9jEh2K2GHy6T0L8jxWbSRc6A=
X-Received: by 2002:a17:902:e746:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2cb97e47ac6mr62891415ad.7.1783239344086;
        Sun, 05 Jul 2026 01:15:44 -0700 (PDT)
X-Received: by 2002:a17:902:e746:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2cb97e47ac6mr62891115ad.7.1783239343645;
        Sun, 05 Jul 2026 01:15:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:15:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:23 +0530
Subject: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=765;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=7fFNa6LfUvVHEiiBGevq3c8n0UAvOooWHrhEPYn74wE=;
 b=6S8MpiE/YFAUGREvxnleOYfr3um2lofUcKuw1nfRX7A8mx3JwkxdgebU3v0OjfjzNtQWaFiAS
 /og6Rpi9tCdBjBax04qDhYpZnfbJh24WgKhT+Nh+02OcLdPzXBHjNLS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX9WDnnHh46hSj
 4IdhiV2eckIzK3XvU1c5jkj/p9nt68nP/jMdGyY+rfcwHrNge4nsVDVqXmfwbmKmAOw089xCoLo
 tIBmnfXfZg4+JHV0Sv1bE3iQtTYa27k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX+wQzrYr6WGB9
 QUlHp3tXxdL+pVHVCgQlWvCi7r40undommw3PfdvcHO7sZFxWyYBIEeHwsFF25r/PzVik2a0jFT
 y4pavWFxXXhotKJ9P9oazNlNsBputHeYg6SypJvWlV11/+CpbPZC0+FgWNqLpin+A/U0cJL2itV
 JFUHqG7QjTouT7UxZhQVyTqyrrqNmCHe8IahfW69U7GW7Zm5J3mh4CORHoAIvvqWt5aM0tsfCJq
 TeQ3M0mEHuLCKBeVheCf+ZYO/ohGXFhLyW2sisEhA8YDd8UbX3i0hIIcq0l9cs+XML9VrXZytBD
 DtweZO+jeXkrxrMAGqOR6WqruINo4T3qA2wA+PbS6ihZ/8At38GuK8ijb8MjFt0HEQkGc9UgMEe
 Oq1tmQrrsJFlZUbgpO5RwhPc9SvE1jGh+6llu+0noKqNrOJLeKsemWqp4W5L4bAjCnz2wgA2/bE
 RwilhAZl8a8LAXNZ/dw==
X-Proofpoint-GUID: -w0fom_0Xs9Q2JFoZvFUdLaEBKxsTIwp
X-Proofpoint-ORIG-GUID: -w0fom_0Xs9Q2JFoZvFUdLaEBKxsTIwp
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a12b0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
shader firmware path.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index 1374afd9d14e..b280d8e845b1 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.54.0

