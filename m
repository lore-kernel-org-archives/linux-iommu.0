Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E8376BE4
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651909; cv=none; b=jtzhVLK3aQlcSWB3emX4TWt3LtHqfi2ukJ215WXqm0dL91Rfj2MBagV6viQEtBYaOP7V06So5BHRKkJ42m5uY3B1SIXoV1Mp65GYBP+VpaexT9CeMar3rEkEMmRUhhAJoTXMYY/otJBGa8S3UNHg2OcCdCMq5dlGHgHdjmcHccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651909; c=relaxed/simple;
	bh=gjdrsWZchMvVDRdOArHg+2j1W7me7uY5LfhLda/2y8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOwBk9ipLtl+gaw0rGx05GBbMGCemSBGQ4txD5+YW86NLfX4bqNXRDv6cTGczkxhCu+0FYW9LJuaYA9Wjdkldr6JVzoOqFZzGhNQYFkTFYiVosVk8enkcj9xwM9k7ykRoK4ysvrpfqMqxoLyS+Oas6/2bqswn9nEbYVgCh5Vc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFxKoKhB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbL71MTy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFxKoKhB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbL71MTy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJqe8l4054361
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 02:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Pk9I2oqoNuOYaz6Q3ecto857QAUheGCoqJl
	UFcsvksw=; b=VFxKoKhB+bJltLipwO1q743jAwB9WAurlXDNYBBYKCtsQbNGot+
	RDlPAtecUgUdqL+1zc0cqOb+wzooAJ0KGdMEzLf3qRFdbr9xvIhcSFxZ2qIZYVMt
	frAaIibleI3HePvQCCbujz/Bmxc5ZGm99Wyes9wNccZ/RvnpWmvzUit89FuWIh/G
	f7wNXlaN4sYHIXjtiipQqaUq/iX54ScBSiD3CJQkR9wCwNb/gYS81Fz4r8JxZ8M/
	uEAW3PSsBeVbwnzGLmBEAD4xMepZ/wLjn6XVqFb6oHTZ7we2nPd4CWOT2oVrnTH3
	8qRARWwhBpmMiiQ670AlzhhOEtbmpkahEUQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyankx3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 02:25:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0ba59a830so3693094eec.0
        for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 19:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776651906; x=1777256706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk9I2oqoNuOYaz6Q3ecto857QAUheGCoqJlUFcsvksw=;
        b=LbL71MTy7Wa4vqhKAG7yI7lUX8qsvqMUUJqshNhd3XPit3RRQkGZIHNK1AVN41Q0lQ
         TZR59Cvk3fA0KusuS2TUDkf5NVfqHmQBC0pRq6XEeklGCT5gyJJ2G3ezn00ZirknZxG4
         dcuEcrN0ul/uUJsudlXO4mVE6KS4MulAxE0SYQnxfhvPhhkOjQJYajy1kq3SooLIWAvG
         itTnPXMljdan16ED8b1+0g+KaTlja8m6/2rSzO/Sv1kFcDQ3ajxA/5r+wdOgaZNslk9l
         Kl5VRakunZkMOI5OsQXvBHmS/jYCBzE7TaCh5Has4RcjY5zkwToLJfwLLdIklCkjuBfz
         gR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776651906; x=1777256706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk9I2oqoNuOYaz6Q3ecto857QAUheGCoqJlUFcsvksw=;
        b=HXgYsVvpxkwhZ6YuwxFoPJ8gff6ueyHgjBvh5JReebrP7VegWUNWIU/9c6iVRKEhjM
         hYivgHyLceox2UymyDK9ROj5CQxItW5ubgHc1zdsOv+Bl/unFc/W3+Q1Ia6Td9mWFrQT
         YRrTCoXuAzf+elU/JQFJiJm08E8RnkqbvXDFoR/T6h/nbIfy63ZKOZDW1eI3vAmPl/QK
         m43B0NDlS7rcykT9LmtwSqQFPGHj6nlQMwuJhvtUv/odhn3heU7FchA9LzNeeRBxN14c
         JJcLm/nN5S1IVOMmomFI2qLIJbWWZ2uBv3im6zw2QrvYOkq3cZN5eulKZ9hhVkSQ1ytc
         Eo3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9m/UtEK+OzAiZR8q2c//GbsSBs/lIdl2RVchZpBWNJ2zn+w4Q1JsLGl1F3DlVOYRzOyi+lpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbkzZxEi/aFZSc2BqC3CKmbRpShqJqrXLbV7mvHhHEBxhc0UgO
	F4nDnmNhVoLWO9aR9lkdSZ6qLEzD1TgkWRXHH39uBKY9J70MRoEu5U7I0rNqMp3FCmM/ywfwTZL
	v1mBNp5loKNc41P1lsUBq0dvONF2/yvq50nvsVL2E+byGFFG30ZwSueVTZw==
X-Gm-Gg: AeBDietUpDJlMwcsgi05irlWB/EDzretnkmf0cTXLcFPJB7c8+JEHdKm6wvTGPbVXT3
	a3Ld0411NrPQloqzre0NjOQb4L3yTOV31WwRimcuVDeSYKAGmrGJgW9vrjQTD9zkkYwYraOnojY
	sLQBZrCuDAwvOEItUAFdmUAhRN1SZMjYYN4Tbq5GRnjNUJADm7o3USUKilS6uDC4ZZ3ynjfmuzW
	yfVlooNJXFOcyp6/E1RXZVXCGwPH3TivNMypGOxCxpER2/OqEAfyallH6+O+eBfhd7RTUCrx5Ri
	taz7RrXu+FyVmbc//MC/fwg13hMYpQdh0nberxXs9NvqTz+H219nzqmJtWBGwlYDIyXu028vrRp
	NvG0sOMCXU7ExaoKufkn2sYb/+kDtaKeP4dG3sBFPMfMda+NJWpKQPdKwYceWwcF5b4MKrMIAuZ
	os1uZkMbd/xTq66bcv
X-Received: by 2002:a05:7300:6c28:b0:2da:9a3c:8062 with SMTP id 5a478bee46e88-2e479c042cbmr6708440eec.17.1776651906269;
        Sun, 19 Apr 2026 19:25:06 -0700 (PDT)
X-Received: by 2002:a05:7300:6c28:b0:2da:9a3c:8062 with SMTP id 5a478bee46e88-2e479c042cbmr6708424eec.17.1776651905709;
        Sun, 19 Apr 2026 19:25:05 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm11850392eec.23.2026.04.19.19.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:25:05 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
Date: Mon, 20 Apr 2026 10:24:52 +0800
Message-ID: <20260420022452.1239665-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wrki0VvZxhgiUBs4Ek8d32mFSnx6L8c4
X-Proofpoint-ORIG-GUID: wrki0VvZxhgiUBs4Ek8d32mFSnx6L8c4
X-Authority-Analysis: v=2.4 cv=SNFykuvH c=1 sm=1 tr=0 ts=69e58e83 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=z_hECjq365cVgtSHfckA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMSBTYWx0ZWRfX5Ls76cKFBC1b
 UCgDKiELTwa5ZwkA11dXB5ytbrKBRS/CPE3PJvTYjgSR6iEh6xPuc2ZoP7V4V/2VE6djLuEumid
 czT5MxM24RTC4o8xFGmd8sO7/4BoqEEFlGOsATyVV6z245XYyitsdHmYKeEmsOFqJnqopBKqBzj
 3LhgJfgimPAHic1lej2aFQxuHRvnfhepPndW2Q4WahTtZfA8yazPN1ygTsgqBLgazsr3p1zoYCj
 cLzzie3nCWoj3lv9hTOL+jmzFocdfAp6WCnZESdgfMKBdGfvplT48633E0CkNDyPrDAjJwp5Sio
 AZhohCc/CDrmGVNvXTB8iCMLcMtB1fXWxctR4xawnVsUY0GwVDrr2z71vblN723oaLEioe+ez4z
 YF3pPnWoJjqo6lAZhsXAePA0Q5YlzjJWFptLGYkmluNJtCa8wQst0jSf/IDWyQxn2fm6sDI59Hh
 NH7ceymeMF/z4zNx0sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200021

Document compatible for Qualcomm Nord SoC APPS SMMU, which has
a fallback on existing compatibles.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..bf29e453058f 100644
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
-- 
2.43.0

