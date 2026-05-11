Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348C383309
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538234; cv=none; b=pGCTCcC/R5DiE0i7n9OOMJzk2fFyDu79DztIv7c/rGSOdrRD61LM3edg/ZsAkk8YD88wCRmIYlg6AAbNTEK1zZTD96+a+IxEYROrGxjQ3BrcxZaEfjVqIXNjEJbVH+mkWC1zHbIxFP9DUYtclMgr4TmMKiqodFc3Hn8LVXNIgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538234; c=relaxed/simple;
	bh=j1uKoavk7LSXVTFpinQJ3L50+niGwfT5j/plxH9VxBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRVdf6u5NhAy2mDLJISekZonTD1u0wh8bUgTmYuqf4799foqN8tj5Z3UKeL6ZprsIYwF9YBCzxMZ+sQtg9GGuEhFG3oUVoT62D7VmDI12Y3so7KeEnQgPYWfa8W5Hj6TBJcPSEIKHcoamXFCzS1o0Z5rb9YijTXkGj/XrL3L5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n672HzHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KDye2lBO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n672HzHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KDye2lBO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6iwf2803779
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=; b=n672HzHxzEtRcoDf
	ir6x/ZJRlEfhbIJOMVkv4eyYqXy8MLDomiRPg2BnI9MdSgbrwtPlxGXcbQrE8ZMH
	Tm79PL/RiDti8cr5SSPqlKYIQPihvq+KgcpIznMhmQ3+VCQyPXo8icYNTV7yNUGw
	h+h/WaJFcROAZG4lMM10n7i6ntRQkn6Qa15zvkAvqPsJr0IFcJWkuhWOv4VUd9mO
	mHCMDbRSS2ZYZRzjxwjrs4HEctl0JYhJKxLP+Bv+3E0GTQiQrfhPpQicVPthpkXk
	WIoWEkPypH5zD1BNsC+BCVVeFbLjkTpgRepjdbQLjiZGJgp1Rarb11OFp2zFmNDq
	IJM12w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv38g59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:23:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso311018a91.2
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778538230; x=1779143030; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=;
        b=KDye2lBOuyja45RbwQDidYRYWwBTBEvDgdyDJbdUMaezaSwmaR5EMzf3/Aqd3oqECy
         jf88HfFXf6DFo+2nUaqkivaqt5AFe9nChkZO8iCsx7W41KbMMYyuVB8b9Gio+/xFqaJC
         MEr+CY0gPRkTuNqwBpTiIuGbMuNrLNCMmrFBoh/+/Uy+sTN8z2ATRoQoVHcEXvtxJySY
         tIme5iKATBB953zFBUSCchqfjDrjroyrF2Y4wkVFD9iG24ql5YWmVwsUCocaFrvwysNE
         92EFhTUxX9gzgnifpNofIJH87awZrEC4XGZLRjVCE2oYz4cc4l3rZjljQsLE2hi0ULM1
         9eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538230; x=1779143030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=;
        b=M4jYtvb6jBz2tlHMevyoSyzbad7E51fl3n2zg+Zcken66M7TlxDOE6HZEuCsu0+qRD
         czG9hQ7ABjO7W49zeAEYltB+eWej4tZmXxpv8ubjfdl1d64+EjU1fzNMX8ZLeFp0S6iv
         UPXj+B4P1HuRnhSdCcWsnaTPwGdi1wGE8fXUh/Uuz2wgeEg3HGbSOgmnsYT6uxvfVT0C
         gSTRamZzJ+V2Ms3ifmslZNGBys1uKcGYVT0XcZAscyabx+T1/fwbHIgoVdagodqqlrSO
         pLIwMPTyuNxWaolIflugtDWvrYVlmYU5USeV7w7HIMIG1Ux49qGrME8Ii9k8QOOn2reH
         9uEw==
X-Forwarded-Encrypted: i=1; AFNElJ9MlzKTSJhdcL7SWBjEIYJmcEwcVowIQdN7nU/rLLanS8lKvAMOfvv5h0U89TnWTa075KkL3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJKtsLjBs4Y9EqRhUQpx+eGlRp6byQtwwUyCv8a47FsUx+zGnF
	unc594v/riBvRog6GuodhVvkGNQGmIQ8yMd1SpkRqpbLuyBAfrLc7EBtOMjbG78wI5jPRgOfu1w
	s3utKatwIxbjnKDD8V9rDBNtZ6qQK+5Nv8pmQHJqeUuv6kD9p7f56I6fzrg==
X-Gm-Gg: Acq92OH5FtoFHwzKqBkXhy8B810vVaxdZqRcsJsFTZFOH3t9Dgmp4LQfX2Ecy1DA9qD
	NaJAo49mOvZ0T8dHZXVigZb+Oj5Ocshnag1wt+hKHSbpjC6HHH3IVk7nb2E2nSymzo4+gWAMIb8
	S33jW/CRXHPUsCK4Q6rFLz/oQNdukhcsqkIaAnzyPSqav1k3crX6VphAb0ptV3LqcKGjlLkPSzx
	c2RvW0Z+rX17/qsqBxoDnxhM0EznTULH5f8IcBZxAgILxNrUeJ7z+eE+QKdCrW3Fb32tNEDOsk7
	w1VjDPhyjf1CS42Vd3NItBSaCSgw8bMF+27mm1iWEfCFeRc1Xc43cQrGPgBXulQ9bY1LyfhQvWx
	6Hx824s0KaBc87BRWPNSjFx+PXsf7qxxJzHplRuc5NiSjDA==
X-Received: by 2002:a05:6a20:3949:b0:3aa:f7df:6146 with SMTP id adf61e73a8af0-3aaf7df68ecmr9095250637.46.1778538230340;
        Mon, 11 May 2026 15:23:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:3949:b0:3aa:f7df:6146 with SMTP id adf61e73a8af0-3aaf7df68ecmr9095222637.46.1778538229874;
        Mon, 11 May 2026 15:23:49 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:23:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:16 +0530
Subject: [PATCH 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-2-13e1c07c2050@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=1371;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=j1uKoavk7LSXVTFpinQJ3L50+niGwfT5j/plxH9VxBI=;
 b=dkSBw1s8Hl7c34xGexPilCuQxVMR0sBENGS+SZhwEMiavLDKfYoCy5dsAY7UhE8iKS0QVuwSG
 2dA6b55CTO7AU/2fkPlZlCpIFE/Ms/Ak81W1hhKN6X0xKKbaFWz5JnE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX+gmgvjnZOCDt
 ouX/xWec5gX/0iCyyZeKPGn5SZNgf19n532vkiiAl67zCMzwkVI+TqPsDPxc6aQ9CKdSbaZyaS5
 GzeHjA5kgqfGx4AhWqReLeB0UGMEJZ1idvRJk+W6M1wmQuFYt/mGFUCM+KZBxz04kgkKrng9t1T
 olD+KIZ7271q1srfDweFJmpWsu5L2GjsbnOPAPuOCxTuIhz65ydaLOLFJg/dZ30P3jLpyEe3/uY
 EEdifjgfyUkzvQmQGmrDJb2s6hVGhGOS5qxFydHh9Q0ubeep4lpyhLU1O+f+T7AVR0LOa86fnXn
 qyqpJ2YqsPUErOZS8IgI9ebkiEMqG7OqHA0EK5rA7gupoIEhHjRnR4WDJ9hvbm6kQdnFoLV3mW0
 cqzck/BSERStTO33MpaSwp07yJmuXA3NujANMVpAxpspRJEyaewO5b8D/GZgu9AwRKD0CYi4f+9
 r2jnVlKMp+tSnrlMMkQ==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a0256f7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=I2s05RQVLi5l9ras6fkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: G_7vQj1tclQToZDaCKZL9Gmjf3c1Zk6-
X-Proofpoint-GUID: G_7vQj1tclQToZDaCKZL9Gmjf3c1Zk6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236

Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
It is a new IP which features the new slice architecture with 3 slices,
raytracing support, and the highest GMEM size seen so far on a Snapdragon
mobile chipsets. Update the dt bindings documentation to describe this GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index e67cd708dda2..35c6d38dc379 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -415,7 +415,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-44070001
+            enum:
+              - qcom,adreno-44050a01
+              - qcom,adreno-44070001
     then:
       properties:
         reg:
@@ -450,6 +452,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.51.0

