Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875653290AD
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238468; cv=none; b=G8M9wOrEznnJ9DvBgga1lVfvA94pAuIwgr1IonHaZUJakGjQuV7/HYHIl0Q1y53Ajae4HKobl1Zb7N7qg40zXZhCtSsiCWgBS50tv9dEZven5+hSpWuKrgS/QzPw1diokV454X7PND8si7dZtXD4TuwfUHVqlY2uJeAf3cxUcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238468; c=relaxed/simple;
	bh=rEVRE6tS8OEt2bDdC+eNcX3SJvvj+nz8Z0ZGM3xZAcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttSxBCnTHyubkUubRQSJXvs6fihF+yQMEVOJdZokfvkwg+tSr1O9/x/9qjy4YBPFTwU3/8lo6j9+ReFdvLN13lQulqHzqi6Y2+hBT1TRvipZOxV3N4xObCyH2lG4UfGNd19rcmO1WD02UNI90AXvNGk56wSOi+34C+/SSIdtsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BezB4TOk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LecmJC60; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BezB4TOk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LecmJC60"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6653WdWa616158
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=; b=BezB4TOkjvnOWtYw
	UkpcpbynKs/qu3POkRXnKFaGwJevrfu+kK/8Zu1sks6qnMGiD1WDvPTEGF7ZAAkH
	iA47ybIsJHYT7bgr27fVi1RV8SB+2OH+tYgooo+dsBdXi/4VcXmXesOT1skFK4gg
	2WMWz9oiq0fYfd2fO3cIjgCB3AONBBvQWYq+f9yxFqMLglGeZcJGVXYujWq0o5+O
	XQ2k5sWsADvSPN0Gfj9OL7FnWRpGmdHPgXuPXzKVQrA6vrSLrNwPYcRYuqfNpMJt
	KRqQfDRMCJghmhrTux9jVCys5W7L5gJ+vnLofnW8BWwJUALtSAbf84UTU5h+OtqS
	Vxn6sg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so1761665a91.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238465; x=1783843265; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=;
        b=LecmJC60NHXYZlvLFQtuSYXPcBuPu0iMc7GEQ5KM1u7rzcgh/Njf8xw/axqgjdi2RI
         eOSbtFKuLOGzfu4Qzw+6hjo+I2Zdme4KRMKJW89YyUfpdW2kEtX/0hk/qKKGk1lvGZLL
         mZWH7qX4cRGcmJ1F+8Yl1P1Sqg+YZ0K+8NFmoebZ/YHNPCPNSsKLxEKcw51nqei55Ox+
         sUSPdy3facxkZkC3rWobV4NA8GWnCFb/EJpqq0yAkVPFnpSryG8QUOdGllZMtMVaa+Iw
         c3LcC3CtX467Q0OmmdMqeZnbUZU3fOavP/Ma7Yq5ZvuCWEB0UcdSLF1v80L+P1tZvlzR
         fa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238465; x=1783843265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1GLzbMavJcBjpxSXBuazEchU/ZHqzUf3tHtHLBksp2U=;
        b=CHdu7AV1AdK9Ujuv64/Sy0AQzTJ1mXxd9xYpz/Ykhqwr/flvkS5vqbZKF6HheQnQj4
         ThUusPK8qjPmo0mi717IkrL+hi2xXvxUrMQE9IewEdIwqnUJ0XetFsqG6RwYFH29cRGH
         XzRgS1DpXAh+TXdQz1KNkxviyEO4RKapakoo+UbakDopDtfXrNZjUEm3QWOHVu9z/zUc
         dOnWn+Z1Vf0q3VcwG5tbYDeEs8zX3IW9F09dWjy7r6mjAhGph45IQg8QNFeZR1JVUdur
         jRu5cG5gDdlv8oPTfn8pI9vqmEUnh+A8odimPiUanSwhENZcsPEEvCO+RipWgmZrF12i
         jRHg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/GXIG2Tf4wVYwG2PZ9bv+yz4PjBu1DZ52xoit7XGYBF8igomG03sGu2QfhTnbebIuFKBwNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym0PXVgtG2rcL5Wyzi4z4vEtGjpcsYYZ09VU+CKRgcB8MKtwun
	vn2qYVWmEhRPvdJfSDNsUihCTWX+gNMjJ8Nbq0tAcRcY5E7LS6LTFZNyxiBluB8K4uhudYKWvIJ
	3esYNcUlJG3/ll7w8hBTt4i29/oGiZCqWW4uSuBtOSYSHQQPkvOlJiKk9vg==
X-Gm-Gg: AfdE7cnBY3gddB27XnxtGdqutbGnqtyXFX70WlFh5SeyZomU8NX4yFE9qPyekYLCptB
	SfCyuEuPU2Qx8A6tcz+4MG9X7o9DjljYztS5Lj6abDsMVjK5YT1UK1tAnyrUDIifF32Wcg+tWvl
	amSHz3eO6291/vw3ab1J3ZyhWYORwB7YZF+L+VSI9Ahqf3rMcznwieEattu3PtggO3JV8KzJyPD
	LStFwUjr4vC//gg3sGax5bHqQhJHHhLt75lzn7NU034rOehLsNQ7WktnI4k37vB4fng6Ugl5p+7
	keuqWLvcohRaLafRl4QeIZCS/tctLTqHZyqhTLD3WQuCAkbBtBLEmAG+sKOjZYd8c01IxZnC1PK
	a2RlSCER/dAlkLthjEioyOyfkaBDCoWrKCUA=
X-Received: by 2002:a17:90b:38c8:b0:37f:9cdf:f03c with SMTP id 98e67ed59e1d1-3829f7ece33mr5155151a91.31.1783238465257;
        Sun, 05 Jul 2026 01:01:05 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:37f:9cdf:f03c with SMTP id 98e67ed59e1d1-3829f7ece33mr5155121a91.31.1783238464724;
        Sun, 05 Jul 2026 01:01:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:06 +0530
Subject: [PATCH v2 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1293;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rEVRE6tS8OEt2bDdC+eNcX3SJvvj+nz8Z0ZGM3xZAcU=;
 b=GAsTe5la0ufNmjlUop0lHQSJGg7ejUO8suiNPoqkpIJfG+V5N92J7e6DKYQWZC8idtEXAlIcA
 yq80BjmwnsvBgjoxZvpwNTPTexaH1YVNCh0nbT5Gn+LBYJAXWitzzKO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f42 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2rxQ3qtc42-NlUa7jS8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: qnAy3IxhUyon6onqzI_D3JAmZLE3pa8f
X-Proofpoint-GUID: qnAy3IxhUyon6onqzI_D3JAmZLE3pa8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXyGwyYmCmlFLL
 FYxe0b25fO/+Sao5hBkYy3mu++YvrejBKJBa42Qkx9yJqQnL4PaGihoH9uOR3hj2mEy3u3eZrR5
 P9b8omD48z57HlnrsLzKdUNf//qnMQoC0m8rPkk+plLeB7qaWHW5t25MAfwAPnUkHh/veAWSIpX
 UOsz9dUNGcYezb7SMj8xoorawuYZ+zihb78ZzelKUGQl4rJCGLyFG1As5rY8Dl6aC6kfVnrzzqE
 ixB5RJe7bXvyruqYh2kwQO5qYwkpE/Ho2PMHsu5wREXjC5Gc7ZZGRIye84tQ2XmlkG/ZXjeV68x
 pckUrwcTo1KT40JgVxJTqjsz1aQQ0UddlMTlGsElmywIsgo+avg/5Y9X+6xLKDaJ4gJZteZXRhC
 aLI8Z2V6IHfmNuiybQebvkwy5qttH/nRRw92+7A38KU4I4DzeQzR7nCsnhd1FCxS3uu6lA6ylJ1
 gIIbJWxZVMFWMus5FIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX0dHAbSQLdWGr
 rdevSK0Vb668RIno49qSriu1Mquo4WZxOjC0U1jkrJ5TrSvyUyVUlsC4RUSBg195gotpdMKwiEF
 pSHC+MzfOzqSGOSg+BJTiGWTSCCUoGc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
It is a new IP which features the new slice architecture with 3 slices,
raytracing support, and the highest GMEM size seen so far on a Snapdragon
mobile chipsets. Update the dt bindings documentation to describe this GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d0b7304c17af 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -413,6 +413,7 @@ allOf:
           contains:
             enum:
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
     then:
       properties:
@@ -448,6 +449,7 @@ allOf:
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.54.0

