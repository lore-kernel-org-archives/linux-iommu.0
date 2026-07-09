Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DE44470E
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622568; cv=none; b=TS3Km+y37z1qiAm8G+gdKGwrYN+QRMS3pMzVbtNSMDSMuanucbgy4SGxcMDToewkgkAx/ZcwqDn9KHk1pIyCnoNvohZ/R9HYOT5Hbew0Ecl7zS0O+rl70Nwepa5OBUX9bWT79cpd77qeLSTTiI1Z7ikHwoMK/1FaNOob3hTbLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622568; c=relaxed/simple;
	bh=rYZUtLoMbkIwkI8yFMTr/hVq0ZeMXm4yVfo/qe4LXmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvBmZm8KlFZ6Y6jvNLdLykYHnT8NGUuDcGhQ2ZnqQBhuJTxKO5CIuVB4z/8uBHD9KsVbVrIMgsfhyDprpCXUAJQ6fWxNZu5p77XyXiiRnmAkaELpQlyMiQrVOd0XDOSd71NxLGVFV1yGXdIIr5j/TTjEM2giWdzJ7pKRhlXnmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXBqxrOa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I0yjEXiW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXBqxrOa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0yjEXiW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HY8xD2475045
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 18:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=WXBqxrOaqkH3Gwi7
	ynIky3z5jsmrx6eW1ol8QXMfbBkHdq0Fo/t1FgDFME6hbvhhLUC3XFMsrar/swQJ
	FOQOjeFamd2ipwcVMyQnGiI5i0MkkINOC2QQqMTb2ei0OMkVCMzWB5f5A2rzC5O5
	8b6hyFb/D5Fic+DbEa/aax+aXxDqQz6Q94skVrr+LfXNp+sW0C+MmsrWUDMntbKD
	lu6cyJWPNtmdqTJKnZ0ON8c0W+wpJA6kcnMcMNvQpTJs6i4ToEIpmO8pAcIhQ6+i
	9ubALVyFK/yMyZ5llIbwQ3/ObPzRPtWItKkS4Y/e/Aj97o/JPSKz+Op0ipn4pbhC
	46qdVg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqphgqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 18:42:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3810e5c5871so311714a91.2
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622564; x=1784227364; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=I0yjEXiWzklKEaqAYG5FMW6vsuZ7GCM6+sl5dDj0IzmUNTlJ8sihgRREPzEFYjX30c
         o/6iGgJIILpbczPYzy6m92lD+dCDEkYIlBqpGdW2EZ2b9bajrzD2Yc+u0mtKaGxmclvA
         OjrQfxygt/3UmCsjTECLcJpjDdAkqsb1Sr1808deDJxLB9cq0BlurK2KdsmXQc8CwDBC
         B2zne8g1Sz55c11AOlc7IRpPkPn4z51kT8hZ4SnuyfvziPQKRp2bpCDxUrT5YElU1RGX
         vsS8WlXzfmIhcG09CajygrV+9qtez4gJ0dwx4xRQJT9TRIxTWrfPDJWJfdaHbJ52Vc2w
         WM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622564; x=1784227364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
        b=iTM4Hl8PuxTUF4PaNfYAXBrHEwFBDTeWGoplE8qZXlki08b276aaZIkgYMp4M/Un+8
         iDcqQ+1W1UUsKYzuG7Fxogta8LG6KD844efiezVUScY0F4igI6U2PUoW9FBHfOnVGaiL
         QNj8m10QDlhNqKgzGUbO2rJRBPWfcoKb3NGIMUZ2hN1kdYaPoXsb4Rg0du3JXPOHq51t
         OrQILqNf+3X18ZxWxMbk11txKW3T2t97J1zxhXRx0dv/LuTGP1FmrN8oyERlpjHO0rN1
         oZfWCcZRc4jIoTFeXNUpqMElvM1FzJ5VIlFW2TVtn/QRvWB46ZfQTMNZSjUwKwCgFLe4
         7EeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGjEjT1lfj7CAzjXdQFTzxejhEmPJ+fkrF3qEdRY+EAlFeODs6JKr7tBVdgD64ubxBCrtkWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyegpBJdn/WxAqlLWqxOjGRs3ZNS4pnBoYg/MTjiAYIfDqwr2Zo
	8d4EyXIruW2wyMwo93QIlLtbEDqimOQDGIkN2RHZ9dArax42NcU9yF6LR4Ie6zLwCwIzf7TOBDf
	2Dgq1EdGKMfC8sqxLIjlBwCp2xrTGaqMMyviQN9ZOMAoCHotCGEXDLOEOFw==
X-Gm-Gg: AfdE7cnqZiwpnxKl/PTBsxLBsi8OTry62LHsK3ZXKhTYDnKfHcskJbu4G3zcb/HRkOP
	GASl7hfnqeXh/DcF9zJ+WZbXOZBXnbfE5MrYtdn+NVaCbkaAdW3iqBZpodoi+GC6NTYY2NZBsRf
	qCnpdpoSw/Cv9T0dGNs2X25LqPBVyaBHIEUJy7j2I2gMT5HDpGNMMUzFtxVCrqaG7A6MkLPgmin
	MUOqhBCNtsrA9RU0v4gPKSwcOM87GM95TKlri8hw1wJTNdATlkTJO363vCv5Uu0ZieHfYOHIFq8
	AS6U9n1bxJPksxnXwMBd4mkIQQtQsZ76YhVto4QOaBQ/OJ3gNDooujvk9IeUdrGaCeiOJvZKw5c
	WnzXf4Z1thqJzDJixk2E1G+g4U/JP38x7abY=
X-Received: by 2002:a17:90b:4d8d:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38942f7105cmr7852554a91.22.1783622564135;
        Thu, 09 Jul 2026 11:42:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4d8d:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38942f7105cmr7852522a91.22.1783622563682;
        Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:01 +0530
Subject: [PATCH v6 2/7] dt-bindings: display/msm/gpu: Add support for A704
 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-2-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=U1bXBRrZl0X7p4f7phkaOBLRRIm0dBDAxAxqeraekRPEoZjymcovUAG/9AJRQPrN14gyQCzS0
 cOS+uX42ydIBnzzAcoCdQhe1IOFCJGt5PmboodpVnhVnhZ62hx9ApLI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX+Co0gX4JeCAu
 I3ZuRASUexZjJWnX9tAiI7PVhgq581X8z9pral8Fu3MMFLudJCG5gatLnywAoFcB1tPIaXKVaKg
 q7nt0fi0c6ZTQY3tf2hB6jYLaZNkT3xspbZ/BKrzsg4CkTcuvok0D9JlcSyJZCDzhnTo3eyZfRY
 oMf49x6MN/xqlqeEa3OENLgRkbdhW1jKbqASP7NxD8VEiMgD2cupZSXlLzZjS+HIyyLYUxJNHUj
 YYdU0THbruuasIipAVsimirKb6jNkJEHBub5+zjZXoTx+x1BDePIZEQmWG+vYfDPAo3pN9J7W/c
 Vhy0OiDQw5/ItlreKNcrx7xpVS1jJh/b9PNEDHedqwnDguvU3UkBDRh6+Ip0qpuvPtU9VDI5Rwa
 F+FTuN+aobHIw+qWhndpAkU4l9jeUQ+lYCKOvoquvsL/QEHrp+0eljxkBb6gYLw17xYJYiaEY1p
 XV0bFoGM+3b6pRbw+Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX3BtbNBE/BLOK
 1TjxxasunDzmR4zLjfILl40w7oGLvjlj8Z46zs6vRzBMWLxIT5gSywsAxYJ3YZnC9CfFnOhUlbl
 egH22omnFqeHFSLOgSs5h9EhV8h8tuM=
X-Proofpoint-GUID: vtoULNchr_wW1CgUfsAfYQTAqa3jlVAE
X-Proofpoint-ORIG-GUID: vtoULNchr_wW1CgUfsAfYQTAqa3jlVAE
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4feba5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090184

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.54.0

