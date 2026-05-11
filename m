Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9078383316
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538274; cv=none; b=sqTbehiTApN0tiaAMVR3sCVd4HgWpy9DrDDtRf6R5xEUVl8vC5f2dS2lhnkBgEQYjvq2poU1FDMDdUc6v4iZENM4rU1GhB9xkZBiKaCwTeBzrXo1Fw1G0Ifdu/WlrJUxRAI7TXsie8C+gsRtFVQT6vu+w9L0GJ5RXhglWQEYGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538274; c=relaxed/simple;
	bh=iDb2uz96prvOPreAW7V7qXKBMuEzgLkBJlRJSuUvUNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/Bj/GC7IO1N822nZf+ZsDNUDnxZkmTf54En2fMMXtABPC2N6O71ndLVHgPILlg5FW1vowTKt2WU5kHs7x52HMU/Bn2uSey0FBIBrFaKIm48moeuvMBbN4DVxTkjSLiei7wEuoW6zOPZrcXG/oavhWH4yOA3Kjo2AbjDtJ48QMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZC/G7Pte; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jG8PtcgV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZC/G7Pte";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jG8PtcgV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK8KSf2173351
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=; b=ZC/G7PteSvshWYCT
	9Gwui2laiuBm9kj/hxGxf0eIf9fBSDWUxRdNVW8o8iQdm2xptrgwbqmGyjFXV7sz
	2rAKbMI0yuhUcuWWjdHZkj1aCEC+MbP2wg0vBU//sD2XLss0pUYatEvYE6ThAHvb
	oo7R6TLFSPicTu2u4au4A/M+YAfdx6ahgcWIGZJufATwrp1LRJgsnk1YyBfVUR1T
	mw1EYv5f7wsHQVIAFww+tFdPDfkg27E6Zx1og0xYCBQ23ajaHWtVDUDK4vwxQTuC
	UhkJTt1KVYtIyi8fwV1+sUkgj9jXCVd/zqbXQzzWbx5gpyigYPwrAjnVlEBlHSEp
	xCKxsQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj8gn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:24:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so5966490b3a.2
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538271; x=1779143071; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=;
        b=jG8PtcgVBk9KuX2MrkuFCbmslK2sGT6AqzRsjvpD3/Cpbmx3aqxxeDfrvT2ANV5vml
         JV/tRrK3kqfnV21CdLM9VJxvSeZ9QOx9Tlj49WLQPcEO1ojRIK7Z+Nhg7z1Z98gZuW91
         P7Gaa4mxQGTGojWojGpYcTrYqzxVNmfc7a4pKQNl59/qGddNlFDvbRO0kfproLgxZTcj
         wTKAOCUelHaAq7Wf4ik1Emulc+u3Y3MP95mxz2ucLrDcfubP+G/ZRqn9ap2LOnnhxUrF
         h0nLVb5I2Fkt8JTSCiyxgj3MJxZ/8V7NYFPaaNWT6lFVjHbIAwMAbajyZRakzjN7SdLO
         PgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538271; x=1779143071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ZYG25c/7YbG2u9v/KfIESsCF0E346q2C6Uk/dm+SG0=;
        b=VWuXsdYaszk4MJyL91Op2XUUm8QMILpHmjVVtbRtzKE0M+1TaLP67Fx2wxsvzdeUIJ
         +Rc+LbAF8eRaFuhqlrAS0c+Tia72e6vWswAe3T/CbSge78zLuVe4lhb3jcT+HUq4jP1I
         TJPV3X97UZDaW+NiKCx/MJoEJUCrTXiMHPvJt8sCxfvhzmwD2qT2F8HHpqdxPAaBsDo5
         1Rf1E6eIBlOLdTSMDh3tjiiX02C3uWuOBbeU67sFuGSPbQUvYbos4yfZOrxqoTOyqpbl
         U2g9tf8/W7PWu3+rmyEvETQhRJlDmXoU4wUH8chdZm07r12KY9wn6e1pt7XZlrRuiYxv
         MM6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+x6D8TBiZCj4Zd4MWgPeQFdIMf5YstbRTNn5cPbTBy77uYa6+xHxsfgAOFlukHKYm0HaE3pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+Ah61aHcMPe2ZgUL37mS+4Es6aUzff7A5ZowIBmvBWPUsOAJi
	SIpJTDp+P0Mi6Zp6Iv78sk3JIqjzqx4W7w74skIAJjLWdtzQ8d8LW/MIzIAkiAkGdubcKI2kFSf
	wLQrowboUVVUUotoV59V+vyu0MvhHAr6FywE8kofTovQ7YeXqC+eLPguFqQ==
X-Gm-Gg: Acq92OH7W9Nji+WpC41MxmKbHkETyPq+x1EPZIuOe/S4SMTfKzfcuRxlIUntnE4g9te
	KcDOY3nPQk4OAPdG3fps6XBo0gYdeqgibvkRc+jltqIFXKa+Rxypc/um813rkIC8okXou6cmBX4
	XUl6B8tCQ1bmo6rhFHQH7ShkOA4VYN6YILpgU/9/aozZyUbYmQyPuOa8XS/fLm0tBu0bq+sKzoP
	BTYuhdIAoEUHAu+H5Paa4Aycyv67o/qYqgtaVavBhgh3fEZZ1isYY/XL+SfdN7VmGktJ0OanlVp
	X7YMlNdvMmyBOaXyVYIZPJ9Z4wQ76bmDBOPS9VVIs4s2FEjUm7msAONszNXvofKvlfNA3mzq7wN
	KcGBHtfySMh3qC7WsYGnaN9ZzO9nM3Pliyyr00mgKIr0AOA==
X-Received: by 2002:a05:6a00:35c3:b0:838:127d:a161 with SMTP id d2e1a72fcca58-83eebb5f055mr337128b3a.18.1778538270725;
        Mon, 11 May 2026 15:24:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:35c3:b0:838:127d:a161 with SMTP id d2e1a72fcca58-83eebb5f055mr337094b3a.18.1778538270230;
        Mon, 11 May 2026 15:24:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:24:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:21 +0530
Subject: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=783;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=iDb2uz96prvOPreAW7V7qXKBMuEzgLkBJlRJSuUvUNE=;
 b=4L1Wf2OEP3HGXs8rkRNKP6ek9eUFrozE8QJtVasyeMz6R2v98M71tEUIV3XtOxqXKwovkzpPV
 E/IxoUX+YlzD2Rsmsy46DBTmOK2mKwzeMLD8gf2BtnmIQ/LQd2gkE6P
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 7E1oEzhZqvYns8a4VwqyfN-t18i8HekD
X-Proofpoint-GUID: 7E1oEzhZqvYns8a4VwqyfN-t18i8HekD
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02571f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VHn1p_zO8-rooJRYzQAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX8DxSN5ALfe/x
 WdMFf4AoRZhKYq2fTZn57rSjagSXWdV7ACXh04QDMGVUy/2rpJP9S5OG8nO7Q0gGAdNXYMuOvxp
 gsEZW0wH8n1BJ8WkhiVpYYoOegNT5zu48iETEoLzDb5BPLWcJ0qo3u+QAS4g5DVAAoyB9oAqFNh
 UWdYP6OjfQfvvWXBTh3kpf8sMt2XAJ8t8oM7fsVzhMkBNhjtIrlUGSB5n1tcAjJO2aUg/YY+cfk
 iY2RgX4ljEv6JORP/PVmlvyR8DR1Q4DRacdGfkEZHiyIgxZulFL69Gp+FwS3VI1K6YWpL2FGwtF
 pAq1Jbu2DsOA4Au+DN6IZRj4DMVihN3WUCZAX7jFQe2vfXzHUSEVAHkUv02lm9yQsArO0p4PBhJ
 qljb7DIn/YFyyjpjMPYxo4pAyO80uzN5t1BBfiJUAf5B/5Vr6nyZ+ekrygUIDqOQqxsi5M7CzMC
 VG1B/SesEpfAwRXJX7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

Add the secure firmware name property and enable GPU support on
Kaanapali MTP device.

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
2.51.0

