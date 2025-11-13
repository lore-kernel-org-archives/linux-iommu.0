Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CC340D9D
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076732; cv=none; b=JwrerX9X1gFVJQ1jXw8wDi7dMGEp9zB4CmoktlUbAspsanjlh6zTwo7VJS/pro3Kk5ZmwJXQioRKdqf5iJlR5IX3EGCrid/VkgClmBAkulN3HiOt6p6CND2VavrhOB9N/k2XL6AV05/PNWXR6S/1t79A2F44UEbn4lcmqz74fb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076732; c=relaxed/simple;
	bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCfuqEYk40lFDzms3oAWHGI1idZr9/jxMouVHUBpP4A8Ip0sYlH42b43IZKVc8Bv+X8s21qxaj3afrtLafeoAFduaVZBIPBjyUARzsdzjhtiNpxOvWFgiYOIfKUHBPCu2K1rTlWvkbzldiwPsdhDLsHZp6a6tXYDZO0VSBArhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4d0xxhx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBic4HT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4d0xxhx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBic4HT6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMao2f1424135
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=; b=a4d0xxhxjAelyvzC
	14qB1RZU5SzKhTR/+8uaIytjkRy615Ki7P82uR95s3soKwi8eYt4+fVbmC68iRZ1
	cbe/m4YgKDZ5Qr+q0IEYv0hqlcQu9CxDIb9C43JVtTCoaRId43Hisw5E0Q/n4KoN
	/EVgjaHKveYm7TrD2OA4QrJ61Gc2nG3OYuth7Zq6XZWaeHFImep4FTP3BYgGQL5k
	ALEDs0hgul8ieiSqAoIJFPE0N3Bm823Na8XfbUWBaZW9MNXm1/6gZLJhjaXo7NCK
	0+72Fh1qLvBCq/a70+gXsIdjmjsYEHHTPQfcd6B0klU/bo/daVsp9Rira1EA52W4
	9VeP+A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g0477-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:32:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117fbda6eso1272641b3a.3
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076728; x=1763681528; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=HBic4HT6asowlFhMqNH8ztsu34B+CPif6jPz+UVPgcKd+q6fhnzATJ+MjUnRJGu7PB
         r816oznujgu8ZUDj+5P0MdlylrCKqGE2Pz8mWayl5Inp7FgppqGMQeomrKn/JHIXlUFW
         mnxZ5Ce+ReMngE/ReA8J7Qn/MdOBshJxvnma+x4SYuIo/yt9aXsqKljaLC5hmmH/7X0I
         ORwCn3zUGKUPOsek2mg0cSys/9vfJwVxAhGytc2uqSh90DMa5v7zt1sl/hZWb21mljC8
         gxdq1+hyKJ8hizA/vqMJi3hVnE+DSTs758gwbOTAc8LNDepwKoq2pXVFMqnwcmmdjukx
         r8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076728; x=1763681528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=B+K8iBaCGSKROkFERgvrd/Cw4MYejLriOeVO56KLmAOZ3p2L3RUBK6JpeN2fnEgJD7
         YEWOJCCvmlgIbTwnaCNQNjiowVphIHyv4M/EVrsgETXoDxKoncNegyKTbWvQVJOhMq54
         tSPnJvFdgHwdNr4xs19ZVSElxWX4o32VWHz6gVshWiFtNfGCMPwG9NiVviDGttLtUVD+
         8HhfoJEDeAemVkLF52jhlnwmAWLemay3c05p9CHCAMhWXyPmg4qCoUH25I0pPVfWUy3V
         BsOZ3PrDattAK6dP+mezFgeiUUxvOmrybd0i9FbIpoWDg4QRI1gxEt+bF8DhgDR1mG8h
         2eGA==
X-Forwarded-Encrypted: i=1; AJvYcCWa4ppRdd2202Sfhiq5Xxr/yD//b2X+QdQQGd2NLpDHyZltW/uu25JE9q4h6/Dra5ru1wQbHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1l6jShHs9wPAUqddwluK6UseuWe2qzHmLUCMaeRumqF8G3wuM
	tE68Pd1Gct2eAj8cRlHPjY9FJAmCGDfVrjsAE/rA3ot69c61InZkOSL12A2yOAsKlkoTFJLRSuw
	jhP3dhPoscCXFNWn1emUfBUkFbhM9gDDvLyHlcGvkv/PqvBU6Yb/afNcf3g==
X-Gm-Gg: ASbGnctrT/HLGyd/Mm7SGwnm4KJlvImybge+WxDi8LO4jZSfVarbYdZBXNcQ5f23r9s
	iSJNhfpXpDR2BwLoqi2fmaoUKYqwXKxy5xCTRlub/zQ5mS2H3YWIDPDzUCS0N75vExW5mevsjyz
	qt9RnX+dz36o24eJly5LsU2Z9xDdomEkrwA2/uyDK7WMjvFM/Y01p/SgorDq0rmH8hZrTK8iL4m
	b16bfuGX1SlIkuOH27E/awq9DX/LbICoF5hRJ1CAtU9rwj3WM+5ENSmzCJK4GyKCDPdssdUHs1K
	gr+7aa7zkiu+XqYbzc4eXLhTHXMpECiKbs23qqyTuN6S/Y0HOgJDQ20mzCJKdnJJqx2Yf8ZyaTP
	ynNr/kRLC9ELwoPQLRPO7ZeM=
X-Received: by 2002:a05:6a20:6a05:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-35ba22a50b8mr1324557637.33.1763076728261;
        Thu, 13 Nov 2025 15:32:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6uREXH/Pc10p/MC0DwkzSPYkXnu24e85a2vO48Pf1B0J1ZDbHns3wpDriZyiRRICYi3KciA==
X-Received: by 2002:a05:6a20:6a05:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-35ba22a50b8mr1324510637.33.1763076727731;
        Thu, 13 Nov 2025 15:32:07 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:32:07 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:16 +0530
Subject: [PATCH v3 19/20] dt-bindings: display/msm/gmu: Add Adreno 840 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-19-92300c7ec8ff@oss.qualcomm.com>
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=1792;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
 b=1I/n72yonmFfJu99nuC9pKcCGZtwySI6gaBDPVUw9OgLX+cy2aGKw/hC07Gf38Zy4Sr4ku1tk
 cZ+/e9WMsW/Bium1P82WjaCDgxrkdRPqz4svvg+Jow+9tYBM2ylPeAi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=L+AQguT8 c=1 sm=1 tr=0 ts=69166a79 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=e8idWDajkKX97RI96f4A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX9pcdTMliyAMX
 R1yX0k6bfhuXfIByGwgaOHfB4efmBV5B3xTJ0HTBQCZfGDshgcbnyG+PiGwjXVrp+zS3X+Wt2Ax
 QqMAkA3YXMaJpf/CSYWenz0nez1XyytZGhKpLVe4Jy2qGoZGBLMOTt6SBxLklr5lbPi0oBeqcJu
 4HJp6q/aD3xLoAT8WMOZ7eqRzzchlx47ZOKLbS0uNNrDhiL+Tb/O9q5J+dqqj9/+pj6W8oNHUla
 O1OBCB0lCgC15Vl8E/FIngQYZj2GJ8K597WonKfe/SyB6tnjnwOXA3Y1KQMh8Mva/9SnnMM61JS
 l8YOO0biniUvyH8QCSbeoNS9DR+5QR1bo2qGjPRBx9jj3UOzL4XWZS3BhAThdT5fBlwv0CPfmwo
 MHxnss8An4H6JYas7WxKRFXI/KD2vA==
X-Proofpoint-ORIG-GUID: o2T8XIjpHb3Jaiy7Q81qPd2mxov935YK
X-Proofpoint-GUID: o2T8XIjpHb3Jaiy7Q81qPd2mxov935YK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

Document Adreno 840 GMU in the dt-binding specification.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index afc187935744..2ef8fd7e9f52 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[6-8][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - items:
           - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
@@ -299,6 +299,34 @@ allOf:
       required:
         - qcom,qmp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-840.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+
   - if:
       properties:
         compatible:

-- 
2.51.0

