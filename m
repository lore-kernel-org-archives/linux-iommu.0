Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C33379EF6
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353234; cv=none; b=V5PLRCMTtw1ykximypUbTrTrVb3+KUsAw/DliiuzMhrtBUjriwA9sb7dX/PzKB/jwaDoi2x+1V++9B9oryN7wscFUY5GZ3ai++aTHDbWA7H/xooMkzbbkpjS3TyY7yt0HdnfZN1KLWArXqWrtVpoD8CtsFYOgsXTlsn1q5er7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353234; c=relaxed/simple;
	bh=/Hupkil2w1jlzYAGedFt2dhGhNfRNZcsPfGhYANNwHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOx3wSpcdYP4qEQ5U2/Ja/yTQYJUYSv38PtG0SBNVOuWWX7QfOTlocQR8s8d1CqTLNXmajNyvHVtNcYZt0uaYlth8CoSDbPl8YixhL2BoKpPr9SIYMLG0J7+OuJeY2/diNjTEiy/FuXWJR0W0Fb+IK2ln/GD3iRRimRiZQOUVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N4QzDrHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJ7jQhdP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4QzDrHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJ7jQhdP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GAXsgQ1245143
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 15:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=crb4nz8XNPGc0Lk5gNyVfV3JEg5cl6V/wbi
	uybD5Maw=; b=N4QzDrHJKu34XK8XQOl29ESk+b9/sCgDRkJsMLbxhkK1JW8oo3E
	jLouCvR5GI+GWII7tVlXZwc8200ZqKKsqgWnmJNKiFn6WGgoerOQoo22EcH3zc4Q
	kRgx2e4U7s8l3nIzHDSvcQepEj5tZShrWlrSstwFaso9ZTADKS3+Hjgg2isJ9AaR
	Bauf+DqyBdeenLXc4YTVFBbh4FRkuwN4mpKvvxCLlY6t1Uz+PF9dSi+u4CT56ONe
	hYc3etwaGxSksWUrsddRfTdjKlJJXR547QHQtYbt4QCyB8O7hAu+SXYoNqGGEjUQ
	Ut4HIXCQLWBK2s9iRbvh+imVLSvp4eY5KPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djx4k8yt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 15:27:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2de07c12745so744285eec.1
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776353231; x=1776958031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crb4nz8XNPGc0Lk5gNyVfV3JEg5cl6V/wbiuybD5Maw=;
        b=UJ7jQhdP+6kgtBi6ULr+KOFsfxLkVTWQFhP1NijFxMT6/m6JfQAVDXTDhaJ73VaCEP
         c31qRtc0oyOENUsaaLfDpI8/6+S+DbKQ5RYp0HtZvlDwF0Zk+BoxsGieZS4bjw1S8Ket
         rDxtK2ZnPxFL/Bwb0qisWzFFX6FIbhxyxrp8LmhEob91c0J9aMlAfnAJNVkICVQwjdIN
         SBa92Qjbm6DHoBkzLTqe3Az7MNhmyPxD3F97sTG06zM0lZi3e49a7PDxD+Oz3jV3WJpO
         T+wxez5oWisAdzaG3++F23ynaO/gE/fxPzBG+At9jo8N+E9qWrEaiXZUzyJJmdUQlZ8E
         2iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353231; x=1776958031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crb4nz8XNPGc0Lk5gNyVfV3JEg5cl6V/wbiuybD5Maw=;
        b=i1AlDqzAMPst707P0N/uLqjpyzvtC3NdpFu9Uu3J4s8/hHhj2DoMZlqsqd5jGAPp4t
         OAudaylc5wgpr19gniPMC1tQPbcx3EZV8xtlp9uFeI07wXwYLgf/6RmH3KBWKKVx6X1H
         BVhLhqMlHeeuiUkb8xs2hXm9xEXYk1QovgAeRYS8B4t+mdVn8XUiJs6o/K52s9GMfYIh
         tUm1BAbZk/ZSkb8sPAlh867XSyM6y2Bkhj66LjOLd4o2/8LnZ3sbOBkMQM94k4+1tlLn
         88F1K/dQDP5bWIpcYnRhT9gj4yF0EGI4orCtb7PUEpCPowUQoiA6iS0CYpKJ1Y2KJZh4
         3zKg==
X-Forwarded-Encrypted: i=1; AFNElJ+KgRMf5UJftpiu9eODw6s0R50iJXbM1GTGsy3g4p0iEmxuBa+1sNwz1CQuOImkgV97vKWA7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5kZ++fTeT1vKY4JbobrMkeA26pazSQUnGvaDUn1J6yX5FGwov
	7tAcADOMXlSy5gGsaAdCVpADClEQ70W1jkQk8pojsa3wZGqjLOqdXfB7Cdqevls7xiihu/+/Dn6
	h1D7Wk64S7ILnefKd1ubnz6irp6TacOdRTzPXUXLOOLLhH/3XWE7phYq8wQ==
X-Gm-Gg: AeBDieu6F5nbPWgHFbo5OTKD4Gvx4wq/RfrMn18Ma1yiG4hvAmE8pOjnOr7yDIDYOws
	iwUU0xG3LB5oRPGWX+kCbiF8qm331jjsGelI1bBwv6uR43SQP+JYcDU+vO5DWEOoi6bU+Asdt8n
	AL+X9cn1/SVlkvLVK5/uMtyGPzL4oZhWqrHaOttExnTmSZZ5fkRtCmLN52xSnrY+Ncbq8sAuuZ3
	oyV1tv0spXE7WTZjV1aCKAwo5VtSsszQU8vVMcxAFVU/QzM52DbLqIn5tTh6sbUxaWKyrfbCfmL
	ZRW9CEXReog4Wc+zR1Jd3Iwa7SE36lO2ZTU+hkRHE7lcmbWqzZSoYoVH+vjrZgbHKg/87NK6Iwf
	ppQ7QvAZzWuIYh3aSysFMFgDoVql2XYjzk+nG1vWHHjcxDRD6Xgn/12dA7brqKIIRQTXw3Uvbmb
	chAVHs1w==
X-Received: by 2002:a05:7300:8292:b0:2d9:32c8:2b69 with SMTP id 5a478bee46e88-2d932c83617mr7912751eec.28.1776353230691;
        Thu, 16 Apr 2026 08:27:10 -0700 (PDT)
X-Received: by 2002:a05:7300:8292:b0:2d9:32c8:2b69 with SMTP id 5a478bee46e88-2d932c83617mr7912728eec.28.1776353230005;
        Thu, 16 Apr 2026 08:27:10 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c016198sm7623545eec.1.2026.04.16.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:27:09 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible in ACTLR client match table
Date: Thu, 16 Apr 2026 23:26:52 +0800
Message-ID: <20260416152652.958229-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -LbmsGezv0GoRNjcbaSoqjE1whxWLuNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NyBTYWx0ZWRfX6Gz4KLTg9rVQ
 rvolNb/on/M1zJLp/75YznwNHoxZCaKxscGujqNAPcoq6PMUO6F/TJHrq0lXkdnSmKPUooqOJ4P
 z+DzNcxj4Xkskkip1QFjdtkrPXNINQ9T1bR5y5FTc2i2j+kh7eC4jIxZTfR7IWO+SjYK1JAB0cL
 c6nZYRUie29uTjx/0zpqnVxgyne/mQkicnZ9p75w+pmGsMYc0r794b7L8LrRlPI4qsxcYsYO89C
 PwLYSdHBGQTsWso9BV1h+Fpcb6wFPzdibvR87qazp2vyRuukuWs68MaPaOeIZ7/J/PmwcYeqxVV
 SofMmAvBCR9k1brxqukPNScXpgPz6sW+roxeNhgHswgGYM2ohEDQgID0a/Ieh4OCyVs9NeJFxBK
 i8/oWbaHtlFoSlD974Vce/iBS4yJo5X0QPuXEV/MKRvbjk9OVRxffCtd8RY1WYBLi0I5Sae+fb4
 M8XL6mS/20+zmK8addw==
X-Authority-Analysis: v=2.4 cv=H47rBeYi c=1 sm=1 tr=0 ts=69e0ffcf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=5nrg6hOtCwBaqtHYvE8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: -LbmsGezv0GoRNjcbaSoqjE1whxWLuNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160147

The qcom_smmu_actlr_client_of_match table used "qcom,fastrpc" as the
compatible to configure ACTLR for fastrpc SMMU clients.  However, the
"qcom,fastrpc" compatible identifies the fastrpc transport (glink)
device, which does not have an iommus property and thus never attaches
to the SMMU directly.

The actual SMMU clients are the per-channel compute context bank (CB)
devices, which use the "qcom,fastrpc-compute-cb" compatible and each
carry their own iommus property.  Replace the compatible string so that
ACTLR prefetch and caching settings are applied to the right devices.

Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index edd41b5a3b6a..2d006049dd61 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -39,7 +39,7 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,adreno-smmu",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
-	{ .compatible = "qcom,fastrpc",
+	{ .compatible = "qcom,fastrpc-compute-cb",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
-- 
2.43.0

