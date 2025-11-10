Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69231B810
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792854; cv=none; b=cFXLtYBBugIVJcjN3vRpVlKjnBakkbkS7Rm/7B8XnPHlMtP49WlBly4j8J0eniqiNDhIDZw4pzepib2fFurJiPhYkiUipxwqpAdkS2s+HY2zK+sKVomxHR5b2MNzl6Q8It8gtHJjdxQPNNKHrPrPypJP5og3FRRSfCgkLmiLV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792854; c=relaxed/simple;
	bh=i/XuvOyeT2JCaHOlG1NFL84HKMryUVDsLqPOa9zMe8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlQHjX4/hNxvk02WfI+VjP7cdfWUpMDPyplTUUL3JkbDnfwj7pHrnLuZUtTH0OqmRzrQPZmj+ZTU6xV2xiZt4UCvTFadrXVh4UVU02/HUps5Iy7M4VAy99UMmOKe6OkY2OzfgQVqOEkq0qxQg5GGhd+c2pX8XedyzwOOp1cqqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqDjD+Ax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7Kfl6WV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqDjD+Ax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7Kfl6WV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFwWIn2867933
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=; b=LqDjD+AxC0ozDLV3
	DZesPF2KWyNxNUxlnx6q8UyFS2ZMJU28gRU0nLSP0MoiEEFfbh2eao9SZtrUl0sd
	e8DgOZAVM3ynTyOaFIwBkTrjN+Soh6oYgFKKnunmsBUnnhv0/e1ytARgQU7DRV5d
	XhgK1sZJ9eME5jmY0pDBXVk8ovbQnPmosf//dauSBmhReO5lV/BQwBpRzAdvK4sl
	E+G6+JJ3/DKp2R7kefUfAshI04MU9P5vViXA+Xm8TgUopVg8HURmMPcprBMEYbnf
	Mbbzlv4t4Y+4YzwquiDoGYYFTMfRk12JjwwHetWzIdsPxs2H1WP+gbNHRjezsgXm
	AlhY1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd761bh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c261fb38so7451100a91.0
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792851; x=1763397651; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=;
        b=I7Kfl6WVotx4Fn6mnPj4nrcCkxAFnAjvk27jTqsw3IPGiC9tNwmbMBqSBskk2Fpj7N
         +r+fLvOLaY1bDuy/dJpi9YNdP43K56Wvgga6vP1y4rTwGCnFOqNaqnSkjeC98dWN5A21
         tZ88lapxOW9114eRsRr/qya31CzwX7ycaa87wSHmvj2X5d6iMDPMB85SAtXgQjwQwHBj
         Knx9McJjZ1MhmCKNFMxIzxZO+CF0EiDVvdAq8/b2j1n1fkd2Gb5aRR5LyHhAV+54l+Wr
         jW4/Rswg0ScN++5t1F9vxbTlzEefac7mAHtQ52TI3LmTjTP0qyb9XN0PyzOz8YpYNYAG
         iFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792851; x=1763397651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YW7kalD2buUlilIlPcd/kOSgkuR2289vzcuRgzPf1Wo=;
        b=B6n8UL+7klpCyhZVnWGFnpoEjTROGaIvjY2otYeps+qlxj601fhAYg2Ek+89cnuRbz
         yDU+YcW4r5xWtvSb1KMh5ifnyZEbYIRXcaY7mhAQ1HjzUuotIaRD7xs/hNBKmqEQUiL7
         x0s3DKFpm1kanInbec1MZXL+VqY5YxsqVPo4cch156K+IyVcDHOi/HfvLzN8j3tsTqUR
         l2MzgYwdvxBJA6M2jiASgxhcxAYA9G19MqUhhv3kO6vhY+eu1kad2kSMAsF/fGqMfjok
         JxpgPOYOl4XeyE8vmbFLr419lV1mRGkVCYKcvCYCV0U1UG/cHXpqcJ9cQE7Sy1AdD4cQ
         CMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAQThyls4/VzTfBxQO5HBCpZ2cqafZc2Dze3cCxhAYddYTSYzhl/2LC6vDHBAGenmx4KnPpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvyqCwzEeKQB8h/Sal1YbUun3aZlbxX99o2UrpwukGwe+b80UY
	g9LPyB4sdS4ez22vSPC7LI5aak+pze01aOzb0prKkEh/rcnCE1z+2dx0ziHFIdlhj4b1FGfCPQH
	iOZ3wFtbuVAChbVivNTtRqmJ+YOdTwvVCj+35h7knbxeNd67Vk3BaR6fdpA==
X-Gm-Gg: ASbGncvQ+PubpeJwJEiYNo6jbxsNzo9Osmi0VJ3U4kVqkOI2sOPFQjroW2tFPVZ5CCv
	Ip0HTDY390jrPigwn6weFGA8TlcXQ4nnKffg0EwbyGl+1dVk+3gQTo/I3BCZFU+wEs4xukB0/Ma
	IMUjhl7zuj4NuEq4Xn4Nv24rBVYgVqpOCPM3rFzMiuIxb/gvXT6QorqQPi9PggvPPHmiCQDBKHP
	b4mTU6OXrenEReVo39dXFi68e3QGIiyfsZQor4n10TuikEg6tRVWNoUzV81MtrfXyZsC1o+nXWR
	gy2fMLHeW7jkQ/0+bc6N/+n1+LbTZb1Kn6JsooaqXnO127ArJ3kdbBkMyZIskkWgsCkiTT/YUt2
	V5LGzvaJkK3C1ihcv/XpIMp4=
X-Received: by 2002:a17:90b:3145:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-3436cb118f4mr9615743a91.8.1762792850864;
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9pMY9BOOQfsUqFBoMftON8+gbyhMo9vgaZeaC/P2wd397OdPBRxrPP6VrHlsLz8Ax5SqN6w==
X-Received: by 2002:a17:90b:3145:b0:340:e529:5572 with SMTP id 98e67ed59e1d1-3436cb118f4mr9615700a91.8.1762792850322;
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:50 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:26 +0530
Subject: [PATCH v2 20/21] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-20-bef18acd5e94@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1613;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=i/XuvOyeT2JCaHOlG1NFL84HKMryUVDsLqPOa9zMe8U=;
 b=Rl0fX8fht+QUdLlWazjj2MS5zkr170ArJ5QP1nziu2DVWhQTh/19rZUXUtypkQfxsojWb1Q2h
 Ei7iatRwVopCf/T2t6JmwEaKOde31BcZ5fbInGGq30cfsAbYCW1oUR+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: -d1_L1NFN-D9fqj8qSrjMDT87D9Yd3Bj
X-Authority-Analysis: v=2.4 cv=OK4qHCaB c=1 sm=1 tr=0 ts=69121593 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_Uo5JhhLEGw40-SN2AoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX4Ak8t0r2xb+I
 nShZw1X0YsFEWLHL5Zz16O+T8yRmIz/o/eIB5lztVQwXi/YgR47I1/O/mI9QfpxnAzpKxtt9Qb2
 Endejrh7Vfl/oKpC+YTTL8ZDD++EnVkciqiTpgc+LCQdvxGcZZ0tt1wqjxVaCDEQu7zYE6bKeTG
 uWtFSU3ASrohj1V5SVDNfqNEGr1oF5iAn2pAkdQVuS3eIOwwlvJyu7JX7gJsl4JlejpTpj6BdJc
 6NSo3e3+adYiT2qUHVKkkkrMHbAwZoRmU6RPrVotW+0NgD7rHAjKC4jajuFCzMUx7Hon0m9heUJ
 OkBwt4Lw/j1aH5Q7QanJVgFLxrsRq+yzWnVfRipjfHJf2iaD+hCGWgh/6cJ/dig2MW0EUIEl5g+
 cy22xICDe4/XGJqUeQ9yzlsOVV1UUA==
X-Proofpoint-GUID: -d1_L1NFN-D9fqj8qSrjMDT87D9Yd3Bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Document Adreno X2-85 GMU found in Glymur chipsets in the
dt-binding specification. It is very similar to Adreno 840
GMU with the additional requirement of RSCC HUB clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 2ef8fd7e9f52..e32056ae0f5d 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -327,6 +327,36 @@ allOf:
             - const: memnoc
             - const: hub
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-x285.1
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
+            - description: GMU RSCC HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+            - const: rscc
+
   - if:
       properties:
         compatible:

-- 
2.51.0

