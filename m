Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259F3ADB8D
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144252; cv=none; b=QKPbCjy7TJZKneLj1yV/CXvdYbh35yrYssUr17ZS5rZKlZhbo+1iZBhEEYiYvaztS/JYVgs4CJ+ZApxF3LyW6ABibedbF76/RCKqvhc1XB/xYOPeR5Pd7ett6PVDrjiOiHjYFhGBez0nxeSx8K6WdXN3gKT/QYNiYOeicJ/h4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144252; c=relaxed/simple;
	bh=PUDMY4WLXFBReBbRmBaTP6+PE4Cv4pgZHtjopE2nWgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qr9XuULYHmdHT2G28BJeUSTxM9soLVpGnPxT07+sErtL1Bsx30M6xrMTrjDgW5N06I9wGsiGi1T3ryFpq8wmHraHZA37bl3ztV44GINDoV2aTYBOUBIb6MrrkYsJxtC/QsXVVeOEq2W3sj0jM4l9v00yVUR1GDvwGiYKoIfU+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fFnrlXPD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=db22Gf//; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFnrlXPD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="db22Gf//"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V1bqgs1622032
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 02:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZhT897pRpBM+tJ1kem0SH3
	LVJgXDEhaNUrTZzsCdCzY=; b=fFnrlXPD9K3X/8Mh5DZSOKTSit6U3Mkn2qO8T5
	mLY0gVCWx/Sc7SAmVg7LezJ4mdTYBXdief200KjLzrRhYhR+kMT2nw2YAJB6upNw
	89X99tW/Hz+Xi4bbqw4bVhF2s3x8gMwShrnX/yeOkLjKALHOfJq37/YuAVSv1eKT
	dpvD3Zz5xNZMzG3+U39mrFwQ9qGoha5fGK0eOn3eIuMEXHLLWj5hZt8My4W/CY+M
	5megf/0LffzvB1a67XIjkifBqWKgeHdxWIpDv+MK8tL5nr7vN2n0G1GYKks38F65
	dT7LWu1u4cIYEWMJFGqw3EfuRDpnCykIjwokQmQx7MMiuz2A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dv58g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 02:44:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso42661115ad.0
        for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788144245; x=1788749045; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZhT897pRpBM+tJ1kem0SH3LVJgXDEhaNUrTZzsCdCzY=;
        b=db22Gf///0HzehX/LX8MfgXYtB4e2Zni7iyI7q5I9mfI1St/03OvlbCbz1x4zd430o
         FjyRhFDLceh6Bj078mp2R9dO6H2P7rhdGS41+dJxpPSW/r2fDbnr2QM0MpctK6B+S/n3
         u2/pwWyWo/qf6vAHEHGoJDhxcv7p0d/377qaolIFF+AnLU+oblZ3ZhC1UB0ojH+tiqL3
         KCvLHy6F7FzNP+ll87z5luHbABfDCHHtye5QdNSqMxPSX0Ny7AV9FSp3Hhy4EC0vjdJe
         knkv2VAIpgKFJ9NRLDBFzA9BP2fkOHJyBpC89c8Nm0Avylm/Z5eyuiY+AnhfK/mRCqAV
         h4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144245; x=1788749045;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZhT897pRpBM+tJ1kem0SH3LVJgXDEhaNUrTZzsCdCzY=;
        b=oBXY1NCjBCzqok4UG93bNG42s/y8SyD/oYIUXQgWJ6/gCsw+TM0Ukso6Uw1c49sVNQ
         siTdmx5L7cI+OzQkXJAQtJkpgA4+bptICeOkmV9EY+No/d7etZ1tfKWoU232q4VXFZEi
         p8JzAXU9d3o1Fj2EqSiZs4NXcbq11zwcu8BfwqVwXAt5mpp7EUiQxC2mf4cwJS1YQtWj
         ET1VxiMpolINIAds7zyVPppvLVRlBJpaeOnTBR+sEFfYTj88MPq2TsATE6frj1fC9wuN
         rtg3tFfB4p/9kixgrL/1UKA+JuYKg6fjQ22aKF13cxe2/6Btb0VXlJ2NUqYISGk6nq7A
         6DQA==
X-Forwarded-Encrypted: i=1; AKwUvBw7ol694aYx2l77DjMIzyTps1lO51DJJ/DUkGR7UEGNx3x3JwXCHyL7P9Y1S+cyEtGG+vyfrw==@lists.linux.dev
X-Gm-Message-State: AFuF++lJPHGA8OBvPdhRA7Fxzro+iGHRkcfP7RilRwshX3KCQdqGwTQd
	4A946zSQtTZyxhoOBfjLE095ITersxad0eMzpHSBL4NoNejMvDVJZ4qGcz7MM5felrOwPbFpbi3
	A9WGBguEq8CmN/TCULxKLFdqxODPNOd+8c4xOJFFDX94+8J50JdAIqLmhMA==
X-Gm-Gg: AYBFou2eLTJHp6vwWWUTuI8q78I776FN2gPb3mO/V6PyUJY/abV0pBrPPzOHTjZWoR9
	0uzUcFgdkjkEXVWhxPsDX2p7xJL5AkkmYDTlWCs69whzitMc0smdO1K5M0wbSi0WOAAqhpGJHvS
	Fj6MxGIWpjpdkNOiUH5H1XH+PgEQlDsPw5pOW8lxuFf+iS2eOyerVC/y7a5jz1vAwLVvPVp0Fbn
	gpCXJt+LjpAavza8B1I73jDL9sOSgjqDUcrBj+cK2lEA5mQgifWlHzi4fwxkIlotlvouAqxEVfR
	4GeVgtWHRs+oVNR10AckHmvZi/LadvBzURmk9M9bz9/v0fhTqKEcLte2Boci7BFTU5W0jUpOQAQ
	7K5NYvXvCxc/Baev9sACxp0GioT/M60cNwq0psdRG/VbXd2WsFic=
X-Received: by 2002:a17:902:f685:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2d93f94ccc6mr3407015ad.6.1788144245456;
        Sun, 30 Aug 2026 19:44:05 -0700 (PDT)
X-Received: by 2002:a17:902:f685:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2d93f94ccc6mr3406595ad.6.1788144244994;
        Sun, 30 Aug 2026 19:44:04 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm27982915eec.8.2026.08.30.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:04 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 19:44:03 -0700
Subject: [PATCH] dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm Maili
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHLqlGoC/x3MwQqDMAyA4VeRnBeI6dCyVxk71Bo1sHbSoAzEd
 1/n8Tv8/wEmRcXg0RxQZFfTT65obw3EJeRZUMdqYOKOvCNMQd+K87qhpbShcyNTbKd71zPUaC0
 y6fcaPl/VQzDBoYQcl/+GPHs4zx+Fon9wdwAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-3d134
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788144244; l=1316;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=PUDMY4WLXFBReBbRmBaTP6+PE4Cv4pgZHtjopE2nWgQ=;
 b=krsN/QHNnWo2ZNh6r/qHqaAjxKhPy5UC4KhZI3frkNdGfG0+mq/11lmoD+0xzxia4RJKXtfT5
 tlwXFEoOKHzDB4pbzbCndHHGOxah27KU6AAiho5NtqUTMk3egOPuUU9
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAyMiBTYWx0ZWRfX0cbTXha7k8pV
 kD5srcALrWtG0QrTQs3H9Z0DSKWnSEpFILeD0fSuBWu1fpJKhrTB1b0svsKaVbGS1Q0zBVEDTKm
 2hh8rwOG10Ga61Gh6KIicick+G67QYgKbHMLPMCRdwC13iDz3NoZWr6jezKNlfvGFk77J+C5muk
 u4qaOoqUxNnhkKwRUxCsaJhszT613RJ2VwwjYk3xNFHsyRb3YH14tFGqiKU8X7jyep8A+mwK/J5
 +jd6V6KR9bPmrinEJfRKWt+gmuA1Lgt77lrulKdGyMoxYzsABIGUYsh/VddfRsUIE7kEcJw7do8
 xsIa5FX4K9BW7IWD5NRYjO5dlCy2fpcYlMVhYxSE1Y4lJTXyS0h4Kr3/PchM4KwdLdHa1FBPuSm
 llsh8XJrknh01YOQeUfJv5WFVRfB4wPe1Q/LcEFXc6PmVJSlshactAeMAVDo1yqE23JgJNHfMGO
 I0If5l20fT+zHdhVwVQ==
X-Proofpoint-GUID: RWs9UZHG3ufyE5zt5lxHI_ypGFXxAi7Y
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a94ea76 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TpgbzC6p0oeasEHOM3UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAyMiBTYWx0ZWRfXzdEjbsIU7gc9
 aIPkd0lSLSGtevI0k/sbItMtv0z2VgfnLY/Vej2LInbWdJ8fQ7hPzPrthGa9JIFXk5tHDwEJZ93
 8b6LzG1A5L4kIwo5yhL0usghG7nX+7U=
X-Proofpoint-ORIG-GUID: RWs9UZHG3ufyE5zt5lxHI_ypGFXxAi7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310022

Document GPU SMMU which uses "hlos" vote clock on Qualcomm Maili SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ffa33b7f4a96..187710fcc567 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -101,6 +101,7 @@ properties:
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
+              - qcom,maili-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
@@ -579,6 +580,7 @@ allOf:
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,kaanapali-smmu-500
+                - qcom,maili-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500

---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260830-maili-gpu-smmu-33d20c1f4672

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

