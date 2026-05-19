Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69F2571C0
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154801; cv=none; b=jtLhgiwQJQ1DplTHS9HG5D0Pa5T+JN8wL2G2o6m982B3sAJO/Sd2bjVg8dnAO6H9DDcZpFtQnUMFUn4oTpWNzcHrzi6DpjEa4iXW3B4gjJWbXvpNwhzvGLUnLL1g5soCaJlA+QiJKwAz+r3nYm1uksJqrrj/DdZZnRMRvxH8jtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154801; c=relaxed/simple;
	bh=rdqFFX8N+4qr/XgMumEnNZhfJ/InPl8ppDP+C1Ieuvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n83LWJH1UyMLardqUGa0Qs9vUKnljUNjxIkqXSDDrt4Zh/oAt8y2idQYPQIs64t/g/eAKvInSNJKaFW2ml5S2JK0LMOxqa6UIMSkTiIgFYWCO0uGevYKA+9AWFNt1TUlYUbamAbwA06l8UCbYYpgNBdHdQNGbUVL8pQQ/S3wX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVx2smja; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DaWTzaAR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVx2smja";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DaWTzaAR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IKUO222891887
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wgPypg1Qf/Pou8SVUQCZbAHgIOaAO16+RxG
	yCR2OXIA=; b=OVx2smjaYnOQgXZDJVqY3gog5aN4oKOT/P3NZ4i5kmG+yrSEIKw
	C1UGikQzvCl5CeAUqwkz1IaC0owy0vD83o0wHXDMEYQm+sgBdBFvxqBmtMJl9mlT
	VvIEf0dF262ht3pMy67d3J1Yyjuy0Tjh5BRHiRRBdDG46er01ObB42y7pbQDan+h
	P0+RY7+hVWRWTq38UuKAKgh7iNF4/OlB/+UzK+zp8BuPoZPnL2uqjZ4fFrfcY35L
	0KYHCc/Bm7qKSo8gtX5aCdWt3HgH7VbcGCAJRpm8fHBOhWsp492eB+M0e93MvX/h
	fSGBMLk9owMiHt+VIgDwqYOtI2RtjHIU07A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk1bu13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:39:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c16233ee11so4147487eec.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779154799; x=1779759599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgPypg1Qf/Pou8SVUQCZbAHgIOaAO16+RxGyCR2OXIA=;
        b=DaWTzaARzqXcsSX753V29azSMpMDXGW5Q0rHQqvSBSUpVbHvQlJftgXO2swtzWnlSh
         83Zb+MSFsfeeMyAnAHQvyUtoDIM+KwjvIcyhW0q1BhB5p3mRXZ1MnFqtgKEuTmKa/6nz
         +Uzdpp3NT65O/frI+qffiPKpyyzYNh9Kvy8tMD9ZTpsNZAz0jxCHmKvde8lkYNMd9EUY
         Wzr83SWWPlCfZuakvYsb0DUnbneuBw+Haqz6iuCOLND1XTmgB3fOxgokjbQ5My+x2Ye6
         +q7Fjj5v280KBAjHyKseFZ6G9yU+944fVNMbzsBrYlrtCPMphWop2ntH265BeWNbggEH
         4b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154799; x=1779759599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgPypg1Qf/Pou8SVUQCZbAHgIOaAO16+RxGyCR2OXIA=;
        b=gcB2NdZjCSUjiyUJVSUsG6BHQKjjFAbwNr5r4mocFhHZEfSXZWyl25JR4WAmLutrQp
         3O6GbbQNKcVDFl6x90sS9F8DuUNdWkmY5ljwZ6A4yX6CIMvgtgatgi3iOuWnEOOtBNnG
         93aMPV8FTmAanMK/Xoo3KK2cHO6iATG86M2q3/vYDTkS70txgDf0OPGUTu7N2GvZ/suX
         76/OGxJi8bLvzcYrxgyXsFAYpvgSl6fLGMgw/tIL3p73iXZRoSwtt5hEfyME5xTgidx6
         119T3ZhlXMKd1jTSXUUeO7hKwsEedhrfzbYoCY2Y4eHc0Wl6u1MWA8+801n+Lw7iyRWd
         qozg==
X-Forwarded-Encrypted: i=1; AFNElJ9wg+OlNstnDbtP5xUzR4NGWtD3MxtrymMfD8OWI7JMOFTqc+61KTX/tDNueDqSDzMxRzq2nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOiUEAUkcTvNlsDWSkhDXE033cieUlZKlcXWrTgIU54LLDm1YK
	iki3VJIZxAs6P3ghLW4m6H1orw0oDd843vFOcwqYcNQA3kY6EjGfCEs55YRDFPXV4coi8d1PVU9
	VruXGbv1YdVfv2mV8i9fqJc0iQN8adGu6eRh2ibDshK4t7XPq/uIv7o3VsA==
X-Gm-Gg: Acq92OH5zH6bfhjSFmyZkeZiEiVueonEqGVXYqbtKPiyEm9PgBrDjXgAJucpCSQPcP+
	VaL+CVCHz/RJSgMqD8llfmq8gTsozwlUeDJTt7ktQRml1CxI9ooo6gSb9wrPa2utZy4z40aPuvt
	ueSkKwa+j21Axw8iid/cxOP1Z8zS4UkZSg71rsf2LNbebJXRLGJCi8ycQARRe6BOPRxd8o/9//9
	JkMfZuSMgV0qhCPYoXL+NLnhZVa2kSxr7dG4IWv+OMvlK/zn/LE6lXZl+/zySUaTQfh19XLbwth
	Xtfrno8XTXG6I2zTmLSnZ976aGtOVZ0UvjyyB2BasM1Gn0g7epb+mn2fdz8+1E+8nTGyNYMgmdb
	OECtAefp2JrjWdyIptWQSqqi+Seuqu7t72Qflc+ofxghoz6Qj9efndrVcB0DAjnYLyceILayy57
	q3t2foXQ==
X-Received: by 2002:a05:7300:7494:b0:2ed:e12:3768 with SMTP id 5a478bee46e88-303986a1287mr7399143eec.30.1779154798900;
        Mon, 18 May 2026 18:39:58 -0700 (PDT)
X-Received: by 2002:a05:7300:7494:b0:2ed:e12:3768 with SMTP id 5a478bee46e88-303986a1287mr7399132eec.30.1779154798356;
        Mon, 18 May 2026 18:39:58 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30297bbc9a3sm15025592eec.31.2026.05.18.18.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:39:58 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v4] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
Date: Tue, 19 May 2026 09:39:50 +0800
Message-ID: <20260519013950.873105-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tnBjKyfBBjbHUI4q0jZZ3L-YRTl5YjZB
X-Proofpoint-ORIG-GUID: tnBjKyfBBjbHUI4q0jZZ3L-YRTl5YjZB
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0bbf6f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAxMyBTYWx0ZWRfXw2+U1EPNfw+4
 70SyoeyqFfaGMnKkkM99CMZEf+wKL/IYpu2B9IilObkEZmog7MNU5BXGqyX4y44Lxh4Yabz/WEr
 j9Tpao4AlgMTAe/d2SgimfG6dxa77QmGVMDI+tYf4A6sCIPKHDDiUtLJn4Ynw84WS2OC9PRVsOv
 /KjrEE6HPcbDww9vydgSO/XpSeu/VFUMjlsxmkgq00JBYnF57EI5FGMxkEAO3JBp1tVT5riW+ba
 N2G5aATljXz/qVbSwPeBv9p+MbdVrMRNO9RQZKLpaFuodT3uA22IzjdEBd2E+5dExPsgx4nZP40
 DElXzf5GFZcE+tVzVKkY3F1N4VgZFd5TnU98UVsCcoOPHA6AdGhRUGmPYpkSNE6GhNiy8G6Ri0w
 oySO2/vinycF+mk7xLeMqQgS8iV2QDZdeqUFNrcRfZrEzTHUIi8S01oupX4caC2klcI9GBs/Hlr
 gk2h1GsjghS6nkxfOJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190013

Document Applications Processor Subsystem (APSS) SMMU on Qualcomm
Nord SoC.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Hi Will,

It has a dependency on Krzysztof's clock constraint change [1].

[1] https://lore.kernel.org/all/20260505071453.34000-2-krzysztof.kozlowski@oss.qualcomm.com/

Changes in v4:
 - Rebase on Krzysztof's clock constraint change.
 - Link to v3: https://lore.kernel.org/all/20260504080943.825496-1-shengchao.guo@oss.qualcomm.com/

Changes in v3:
 - Improve commit log to expand APSS and drop "compatible with" part
 - Link to v2: https://lore.kernel.org/all/20260427011728.231026-1-shengchao.guo@oss.qualcomm.com/

Changes in v2:
 - Improve commit log to make the compatibility explicit
 - Link to v1: https://lore.kernel.org/all/20260420022452.1239665-1-shengchao.guo@oss.qualcomm.com/

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ed0d10157bd6..35d251259214 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
+              - qcom,nord-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
@@ -616,6 +617,7 @@ allOf:
                 - qcom,glymur-smmu-500
                 - qcom,kaanapali-smmu-500
                 - qcom,milos-smmu-500
+                - qcom,nord-smmu-500
                 - qcom,qcs615-smmu-500
                 - qcom,qcs8300-smmu-500
                 - qcom,sa8775p-smmu-500
-- 
2.43.0

