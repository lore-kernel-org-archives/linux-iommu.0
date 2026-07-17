Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEF38B122
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320957; cv=none; b=GELv+jec5jHxiwABMvk4mO5IicrtHh4skv6pF475S8nhDnEkmzBB5AiQ+pGHNhM9fFqQ+xYCD+99GzadbgxCOzSOSu90XEc6btgzhoF8J9GTHqkSVpsBacE5GhULxbWFn1KgFSdJBui+WlIt4zy5TtJlMYzmg38OtwsbkMJZpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320957; c=relaxed/simple;
	bh=9Brf+yWI1x+F65UFC9Bw1afbeyT16t4oVeyZuscMvkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jm+x0qjV1IoGXIUGHatbBcQuuG8dGsNxvs5E9QdxgMlhoNiwAyBtQuUQttsQ0q3Nk9HOlsX3RabvfM7FtGFFcsMhhumC+hRWar13YPvb6pkpdZf9jrmWca6P47Kx8IqhTotvjtakI88H7hTJl1Q+zLBX3Iv9X5ZvBzdriWS5sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1+sFPv3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aaOQoH9R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1+sFPv3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aaOQoH9R"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtPOS2751693
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=; b=S1+sFPv3oD8ZA4D1
	6NQJIZ1xqUfwllz50zIRqPmGzoEcg5+y2zpdUY6J3qfkScQ8DgHhkxXU27swrtcj
	tbBLWU0DDrKFCJPEtMiqll4uU1IQjxCjdKgApxmZEWMfJR5bPsPzojfj3rnxRzEv
	BcE1+0Aw15aX8ItF7etjkVQnPpRMDGUcvFa0b0cwVzCjKjMn0fkUs/1T33ZEHk4Q
	E31ptetYOI7hUXTz4KSjywLE64xSC78GVEgwYW2bQxit3gP+5Zcu6bYbaM7T6ov0
	fG/kEgxpKy43MxYDn26ajGVwP+olmkvIGDlEBGzBOTTsnKt/JW9TsrVH3Ui4OK6P
	oTdVhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug19xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so145242715ad.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320954; x=1784925754; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=;
        b=aaOQoH9RnIE2pHL193jrDsP9jOYgXlbBa9No1784g1oS26oqN/h7OapKEahOA60nqS
         v3NhF2+RRRkJ3mV5k5yFDLmbfODuLI05mgMzPGaV108cB1SUedZ7Ygx+X2fNu/UC47fx
         ul7c3Gkvlp5XT/ZS4QqemxoVhCX7wUL0sqSYcWdgRkcgkdg2F+c6+rclFKjBj0i2v+2i
         /9ZORI8XIPzM8hr0rtdbvpgG/cQioCPbBBxrRgBnxRxqK+0IqSn8x+cmWiruylnwNyBu
         0E5uEAzOQaaGVlKn81ogb4Q+skP2PzMj9yI2s6wOMqUI35RlfuI40OqANReqHZWf6KI9
         hIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320954; x=1784925754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q61K7rQL8TzxQSbcJjMDH84anlusBLwuWl2h6jLOOmQ=;
        b=NtPrzt9nwiS3LZ/gXD8Qhb3iLDaprVkodsJdXnovQken/Noq9Gvoct2P+BQgr67TvR
         Ma+LCewMieI+aHzUyczQWjIVKkCIK65cJMCGH1Y779oBxspmqP6ir9ePG8ppb/J7yrmV
         TSo7gIrAIezEkHZWmvjZcsHdrR6iJqha79a9Cik3ADt3F984mz4RDoGzd3vyLYPZA7Uy
         Rc9fTdOPgbuWbWB2lNPdEkieoZjEeUGnBdH0VDFis9+0/Y4ej96XYtYwpoZmEWj24DHq
         cyKNk5zZbSgZ/e0/RmKhDUID+Gs1Qw3WxTvvPfkZOlz1oy5rmVb4i7sa1kLAecXqrw+w
         Ns3w==
X-Forwarded-Encrypted: i=1; AHgh+RomthOkbExYyCrUIS188E1TQsck+hbQNwMjM4G7SpmK0A0iwiHQ6WeucyIlnxwWV1lSoYzUcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZHQwdh7uAY6laxioXFtzNFFA7QaZSULoXmOxUfzH2VgShGgtw
	D/KcEXoENW8xrGDPAxensb7qZieFmO/wHAzVHyOutcFoiPtCDb3VrwqU1mnK1ARgOcPR8p/rEbd
	RrBhfOkZxdVSCXI6abapkgoTiC7oXIvgqEr/k/70xSE6JQHNRLhrMdmR5NQ==
X-Gm-Gg: AfdE7ckwxHegSpHTn4h9z2RCUtcnuFkplkTGUj8hXonwnQbJ4IFH8OTl8aCZXmtNfN9
	Z5Z5Wtc4n+pAmMlJln9C3Wnb8QTJMLqZ28eYUlXs6tWKdNGyC3nC7ObAq/rM977BZsdnlOqi2EX
	2syQWVau3jGWk9d9TYmFCltbZzUe6L3bgGVnOrQxf/iTuZJnyJd1A7u3ae2Mf2V4+R14kSrih99
	1c6HpB9EPdHo02bytPtQyfC/OqMc6qGuoPU2f7eP14uCvwklaLY3Ad6OK2DUYiUAHabbJ0XuV7J
	x5LinDkC6yDVQJTVVeaSTWJLE490diKQwElWLC+nprkkemjlk5XnHcT0O1Xbo0n39SH/daLtGSq
	xU7IjZzXFLKyBji2fe+gX0NSd
X-Received: by 2002:a17:90b:3f85:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38e4b479ecfmr4276425a91.19.1784320953917;
        Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38e4b479ecfmr4276375a91.19.1784320953504;
        Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:33 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:30 +0530
Subject: [PATCH v2 5/9] dt-bindings: display/msm: Document Adreno 722 GPU
 and GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-5-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1977;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=H03u72Mj2+0Q/DcdLyrGjsdWiF04QoAQmREqPJ+DCmI=;
 b=SJZVRrqpECN/vKCAH/EzAokdNAPN9nODY536Kc/SKD/uVN/Wi+sIO/cXcpc14W8BcSLEm31gH
 3S8w7NqkDqRAHSQssaeMIUwci5dn3785frvA+sLtN95U3m9ljtJW6d2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX2T9ySYONrwLc
 6DQaq6bk1d1BXprmzCCjvcGIrKvLXxklT6UtfefDaOrtABiD78w3IYpFo9nazZslHZdgppHiAMm
 TZ1rlraRWJByf0Puby9dKc4vXNTDXYWv0/xicgyasf8lLJsK4h8XZW8oAzib4JBato81J5hjc1o
 6Cid4K58qEApGm/0Aj7rdcDHczRhbgESu9kI2jtGkpytMUSDdx6AfdBY4zaqvyJgHDv2uAiv/Ho
 zpT6YCur+phldw3m/RVvyQEZrldsUGW2KprTWb0WSuAXziGBfmyd0qthGVtQnLGPMOa3d2xekCU
 6WGTwqOaVv4w3S5T06hyKu5D+ff3DubGI6cCYZC542IFS3GWj/DujG3HwhFq8eTsVu4J/2HAWjS
 GFh3RkNMs/x9cRftaeYroRAuwY1s4xUY4sUcFJq5MUfbPx3Lql0n0QjYdjnwlUJoDu0uSOTzrtX
 8S4K6+gN2G3CfaVn+EA==
X-Proofpoint-GUID: U3NuGQh2fFyK2dLxCz8PEux-MnGXjgBB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX4cFYz9ohfKM+
 Psox07CtUanPtyAIyqdZaHP9uF36+BQNwOoESa60FkSl4R5fwhMz93LBWFoRJBUqa8JJqpzDf+x
 KVSBOMqkultrG4m8Wl0AqYULRBEm0Jo=
X-Proofpoint-ORIG-GUID: U3NuGQh2fFyK2dLxCz8PEux-MnGXjgBB
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a93ba cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=byR7QgRKzgUKQ7cIeKEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170212

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Update the dt-binding docs to document this GPU and GMU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 8578c2f8122e..9e459f12ce3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -262,6 +262,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-722.0
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
               - qcom,adreno-gmu-750.1
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d096632694c9 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -443,6 +443,7 @@ allOf:
               - qcom,adreno-680.1
               - qcom,adreno-690.0
               - qcom,adreno-730.1
+              - qcom,adreno-43020100
               - qcom,adreno-43030c00
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01

-- 
2.54.0

