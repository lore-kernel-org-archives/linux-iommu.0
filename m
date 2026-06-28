Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87A30C154
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671091; cv=none; b=XD596fpvoBuIRRD5LAUM/0kbofvIPFPCUm+B4AensliFgWbJGNiG3jokWOgfoxz7DjVGBwYnZBKwucZaBZF+PoJjdES4ZKVM7bUtCqAFyjvXtPw3kzUEkjWjqqSSPjGGtCtTvxx1giHwk1ALR7PRWu4VNiSmjr7R9lXH4jfWg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671091; c=relaxed/simple;
	bh=PzLpTH0pbzRF9OZWwPiqESEYa/drXlg0Ml5pqQ2y7Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXdWY5+5CiUW7b6JDNrenCYRxJL4tmdtqH0VcvrR67iO0yAJey5DbiuWIXEO1hBNjKqIGQiM3dBO9kiz0G571mEJHmSPNyYzbx0hOp/o7m6Gzw22rhKCCW6E20Tt8iYluBPgHESODUOC1R+ORpYTorDGgAeffMVdHayhlxNLwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilWAAZOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlvWKQDf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilWAAZOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlvWKQDf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHisRx423740
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=; b=ilWAAZOfBhBzCFZb
	hQXPU2IHDPhZvPfe1PqWl8u9gK6zCsOvHAI8y+u9c9gtTG4jOQoJ4tpfm3sO6mEo
	xc30qaUKFlAz5+xqmZslKmMQCUEBN3yfMULQvChnGob2uZ8BBZ0EOkfLxgOjKiyZ
	UihblrL4LyigsylWQIX2SYXhLPcdo6Um4+Cu8JXfsZDJUb1CZEfQ+K+w63jU8tQv
	4FP2SNE87g6m7cFdAoQie1TWhOo4jgQN/++eGW+5+AADTpB7Ob2QEonVOFR8XTk5
	RmECGeVhcL+I7bioixGx3FOG3KFhWPR5ZPdbLBa5xwPcBVSmcGn9Mk0g35SJIhwr
	Jsg1bg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279ckb6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bccca5620so3792664eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671089; x=1783275889; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=;
        b=PlvWKQDffy5HgHc/nNDFth003L1+IWHYISlr3yAtGkBrCasQlblUCgdRnlCGNru+Fi
         kOjsS2ylJVGXTyG/SNFQhIaSdqe764sTXtxfAj/5KrOOYe48wCyVONKqpvfufF/RoTYh
         J15xiow7BLvfvRAXhjVK52SVgFLOO5+QKwWwe6AXPhcATtgb1NDXJXSB2eJgn3Rqdf3k
         AkCbFpkdD/mJcFX3//zLVEvbpraeVlQVevGoZOAM9WCb4ZDserR5lko+9lIlQ1qXw8pZ
         olOzPvP7CFhwWKlVQtzYFjdGrQG0K3o7YmKVLhz9OWMtfwR2qSdnonyrJrg00VWSdGYd
         6QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671089; x=1783275889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X9p3oCZzvqstazXxppdDmSZcGrd5rTD5PgWo89uABCs=;
        b=bsv4e0aS53xluwj506JFaXy3/6xbAqerjtMI9CppUbZeM8vRzB1reWrprzffLbsQ8C
         scirT0MuWGIk8Agic625Uk0eSymW0NADikpie4d1kYIlTo2xOWBHSEfq0EIk86eaXdvB
         WPwvKTAHjuL92UfBRuE+ai2enT2cYaFObdfw0aw5teKzEexijK5faekKVD4enc0mMgFh
         HpPEj/zOATRvJzJ4ILd6SgpZV6phdElJhgAstdUZlXn8ULwup/jICua+t0NYnzQG/mzD
         9VXA8c2ugrcGRO2FRoc9fKS9aTrJtp1kpl+/grG4t/nrqgZE0Nx9DfK++aq9REtT4iCw
         kDVQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHXb09d6Rc1VitTtVrFFMMmhKVu8TnodbyputZEJ9MYL0dOZy8f2id9XAW85c/3mTtjgYCQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9ilRG+72iye0xsfdFv6lI8eSj3vOKyY8522OOtT+XiF8/h5dD
	zW0nTMmbAiQrKpEjMOA8OcrxiqFQCpaw/GkJrpfD9jHVX4xMQ9oMigq+zxPcbMbWKNZIvHQhOKP
	n6AOxhdE31wlakbEl6R6tpYmHv9u0l4+Iu4VTyHkwH2SR698Kot5Ke81byw==
X-Gm-Gg: AfdE7clpObDZNovWWFBw6Ev9S1t6JOggcI5TY/tDte2YxoElUhMot6GmUaiTeP4JWc7
	A0WeRkveBBrmWftU9q7GU+PIApV0X/rACKruuE3sPEfx/Gbha0rNlr475VO+Xgv+jZKqeL5o9rg
	Nz0CDB4+HxVrR4X39y8vRefCELsr6upgbk/Cwuu0HrAxoHe0OU3/XuIvFvXxH2AkYxEf/5v5tUa
	zl3aGeZJ9PTXFNk7gV/Ntm9Rkg6fIjtAeQHklLnNqsHdkr1OP8mzTgd+VMnuQ1YW8HMmNeVe01j
	Vj4vLWMvblAuACDlKfJrNYpInvMPpfYYrDFj23/K4PrZ05GLh4Yf5FuRn+LsNmqy14a9F6tJEwr
	k/DcR+EiKhqi0CZT/0riBT1NFcIDlMfR8SZ0=
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30c84f77b05mr14159294eec.29.1782671088541;
        Sun, 28 Jun 2026 11:24:48 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30c84f77b05mr14159282eec.29.1782671088092;
        Sun, 28 Jun 2026 11:24:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:24:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:56 +0530
Subject: [PATCH v3 3/8] dt-bindings: arm-smmu: Document GPU SMMU for Shikra
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-3-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ab2FJciDIqw7/jxV1YWmBTVegZUhQ2SXaZRIypzuWaI=;
 b=DtAI8ypsLKBEX36oBYU18khootZJoi9iiNXb/fY1RbtwZTn86qyHcgIO51NjZJDUqackd5Lan
 UFQMxskGcxLBwd0K8GC7ROWRU2OWVZkcEAJqKGI7ITqTZV+Phs2p2eS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a4166f1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX5/GZVcpOF6jO
 fMSKozp2emXfRPMJ5TtqPs5DBdYndChqDFORLg0DsLO2f0HoWlvNkUVO6TryFUkqGvVU6HQzeKM
 7DKWSfTOEDLoCy9uVIGmfQiSYwkeHP4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX2ry8AN1/heev
 jj1OkgYJfJwFc0n5Io9DIf4QrwFzUuZV6BAg2qDIuUcddxCb3F1g5/ZbmaMKyv6rA02BSJ/WoJ+
 KnxzPbgaZlR/c7lynpBZX1+IiCW9dyoSbf8AFa3WYtRWSvNAfVMmxoABThMCKPd7t6t/mmu2nsS
 /dOjm/b8tznEPGQ0WQpcXqJz3rTaicNIZ0KlYAecIQYgsIcyvl3wt44p+sxou8uBeZT84hA0yXr
 rgyiMU4aWpo9rND9YoF3g+NYgONgvjFAp4abkgU7vJ/6GT5s+tjuOWl766V7dNAd1oXXrD/pIHL
 uvwq9K3h25zBvk8YYi8Y3LFm5MixFdQIQKizH4A/wnUvws3pSXq/frD33USYfeEmlKyYaC5RXC8
 JpERqzwPHbfQH5c+F1YfuIvwBZE2uU3GINThkDYLoJkT6OPUqjaIp5hIOvpqTiTz/7z9MpYfb8a
 hnsBg0az53CY6oHlXSw==
X-Proofpoint-GUID: qo47uARdRShdaB1NnAAvP-8JbwYSgZ4F
X-Proofpoint-ORIG-GUID: qo47uARdRShdaB1NnAAvP-8JbwYSgZ4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.51.0

