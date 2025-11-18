Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AA32B9A7
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456036; cv=none; b=gv3BBFePWd5kZowp4Jj81Sgg+ntLpeorYRhwIr+Jlr0bCOS/PCY9rVU5PsH17NybX0f1+kJuqXM6jn1bRVLKj8+phEUZWyJaXBs6CvgJwQNh7YHUWF278xh0JNupyTZPj7Y8Gc5n8hQrlxYBV77FFCLAcL7sINc9E/X0ofHyJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456036; c=relaxed/simple;
	bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2iQPftRQPJOXkGWWWC1+P/Dt4NZ6hyyuuzRo4KOQXQXUyW9M5v/v1Y3qDkmnYoVZo5em5dgGnFVJfXyDWBn9BrBMBTM+UZpI9RAS6e7O2ao7O6QSQnrs/q2GVShCe/wK5Ke22FWUHraUwNo1lz9HrD/VBH5HICZEpTuWF8vJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=acW4vh2C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOa4rKnp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="acW4vh2C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOa4rKnp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8DqPm2193872
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=; b=acW4vh2C0OBfNK+0
	49zxa4PHlVX/A2qjaLVG/Ltde/DKv2Q8gYXmRe9mSmhL0WU44TeCRR+t1HZ3dSPg
	goarJ/7XHxjsCkDNpR4SmgxNJQwfRey9hFcQDQYG36ZVeNWSjsS4nxCstUQGGx7g
	WD+MbDEcOsXqJ9PUZfbZC2orkJqCu1oyF3hDhP8+qy+ocrDF1zck813KYG3sTxOD
	yqB8MTSbwq/TYvVvePacP2UB1gHNek3BIpXm1o2dJdx0OtuX3Oa5Y6ACWSu+4RZA
	uDZztcrI2M+P8rojhfCjits1PxtYkU+qcJau3x4/m7VGHFlz9Jg9UIxFG+HH0lkM
	qTF1nA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agn3y83r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-299ddb0269eso27186005ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763456033; x=1764060833; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=JOa4rKnpk68Vy3ZJVPqPMlRem29GCIYLm/3vKDSl2M4EMkdRulmRaV+KA9GVf0KuTP
         FVE6SNqueul0pJrqTwpAiWH8Q2uhIjFTCpxfAIBz/7aU4zNq58AZIIsHGHCEpm0BMmlQ
         GTxFbh+FbwoUP5M1Io4OKh2jhrHWMfUqsHoxMh02Y+CCwL2s0E6uICvP+DXZhyycFTDM
         92xcrE6z5k6lKv7M2LNWjGolT+PJ0vMAJEhGCu5AmyPPyccx1BWfjsuKd0NEfc7FpmGE
         NgO2cVadLe/kEuAa4r1/T5iImRCyMjBSZlj8kOpsbZwu5U1tgmYcgazooJ+XgMrK8TcV
         2Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456033; x=1764060833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK80NgI1LQ+xDyFsHtTpc6wl2L9uxC1wWhpBghxroMY=;
        b=eQayPrm1m1278pZbRCejBQ18sjU97dHyrW4vKi7XQ5gpYpZXzjglIyuCE0+y/3rih7
         LhmG+SQxqwcgYPzpTsg6TsjW9Km+vMTDw2G1YJPzB/zwSAkSPqlJHcwOJfi04MFh+oZs
         YtQpeVQ5zfFrPn6Jv1ud0H5TaxmcpMyWMW++8AZEw+l5OwihWfNblHh7DMAY7mUGpd8l
         1pPg1HRhlmOFjU4+prSNQX9YKhyhIr4Is2kFPCLOiLGEv3ems04eoI+PtGL8PRauB/aM
         Hnmv6e9bIj9zL7JHsnSpfd6u8+kSu0hu64IeDATYDKTTks/d8omZ2tKDv6ovWF5qG4ug
         u9fw==
X-Forwarded-Encrypted: i=1; AJvYcCX4p7dkci/9slyR0veoH0UqJD8KULmI542ZT8tqMEF48zwt7gFnhZu/AYJp1xtovMf7kSotwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4R1a8f0qvPWqelaMz3u8cwa5rkBtRJHqPvpfo+e1n79t0ugEB
	6HQx+nyAnvZqkL12DIVe7qwKZ9jQMYOdKANy7yTTILs64QZ95U+ujMpFWYyOX7tgT8dw6MhfSan
	y0OwAHePxaYZCgN/szcbMWzH9FL0PcYJo+bHpsRcSatiZ++k5KZGcFJwpmCvaBesBvw==
X-Gm-Gg: ASbGncvqitPlIrX5jf6blcHwnGCS4WVqiQ5FGhmZj8YoaXr8GgW58RW9s8JGsOlioUJ
	Up9SaTO3WoNX5QWUIE6HVDIbyVjKRwTAb+asbMG0bnkzAA0ocRYym5N6uVF785PCUTosiCatYww
	WVizJlwUZ9Wv+KGqmB2nbTD01V3gJ0Q+OUyPDZP6V99HaRnMl+80MEEpoOZN0Mc6C0ya9amHeiX
	PYlLuzi/Y/N8AHXgKTYVev+pzxTFLTB0NCL7+kAmbRd8NrIvAlb/gxn34gP0FoL9W3lxCvhOT+c
	0+LTE//DicwqeGaksa8beQm1ZQ7RFynjJLWZyF8DZ5hcbTYccDBE4x/9+AzfaXByEge/h1u4B1t
	dhc5E2aqLMzNSfOVAenYpJyY=
X-Received: by 2002:a17:903:1a2e:b0:295:f508:9d32 with SMTP id d9443c01a7336-2986a733373mr199739895ad.37.1763456032913;
        Tue, 18 Nov 2025 00:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAYYS70u+Ee2zagd/j5aTO/ulost5I9qswBrR/l8KD04TpBbwpgzQvRoU7wV90gj86EvfwBQ==
X-Received: by 2002:a17:903:1a2e:b0:295:f508:9d32 with SMTP id d9443c01a7336-2986a733373mr199739635ad.37.1763456032365;
        Tue, 18 Nov 2025 00:53:52 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:53:52 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:47 +0530
Subject: [PATCH v4 20/22] dt-bindings: display/msm/gmu: Add Adreno 840 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-20-86eeb8e93fb6@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1792;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NcxT59isJ8a73ABBo5632Wjovo4V8SjmsWcRhDa2gQw=;
 b=j7F8HzU/j38mbjoyk5aE6lcoDgwRxl8yKHoa/I9iVW6SXOUfEtgqkULnZ3q2RFEcVTcBHYZqN
 5H9tDBA4YdZBkuxB8GVxkab8xAf7MHBF8hHFiFj7sxlD9y89W4liF17
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX9WJG1kjsHig/
 vStiO2lmK5R1XrVsb5xLg1VKUBYMP0HOgw6tnXoe+TrwIr1ap9COgrIIAIRpAkywtMHeWPbxWsM
 NTZOr88lDGqVRf070jzYJquwCp5tULdOm5+aYZDQFQVpcjeipB/gXKtzQH+44fAFn2Qx3US/kFr
 K+3jHvAAaMfz5kwwop251v4AXXkcy3HBFo+pmA5P/ChJWphqyyorUC6y8y6wTqDz82zNNi/MF11
 L0uWYZHA0n2u5t3sSj/uCv2DOtmxC3+Y7+VQV10nLuxJ3gzL+ieCjkJk0qYjKKeWfag6NsKxFnO
 RVhrHpYRfdISGBgrk8G4InjDQeVMNc07bBQUBVk4KlAVDvVWHX6Tu5dApNmLYF+ePMOkyxpbPQI
 AcNyjTzUJlwcNvWjWTQ7jMTjCPl4gQ==
X-Proofpoint-GUID: C9ov_XOGeFtn-lWim63itt7fjunsjLkV
X-Proofpoint-ORIG-GUID: C9ov_XOGeFtn-lWim63itt7fjunsjLkV
X-Authority-Analysis: v=2.4 cv=FtIIPmrq c=1 sm=1 tr=0 ts=691c3421 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=e8idWDajkKX97RI96f4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180069

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

