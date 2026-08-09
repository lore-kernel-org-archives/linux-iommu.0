Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BC375F7B
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306549; cv=none; b=R7p5u6iqhPsbvSq5DI43S+4RtAM2WXKbFIfa3aws7CeStEyGzY0VvFjz3UDpEyS62V211cajNXLoD87ug3pB6a7FqrF9W4ZFBv0k726vo+wKy0cpa57F8Ryrc2vCmeVN8z7bYjWdTKMsjiZSK68EzmokW6xbl0caDtd8sGqd/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306549; c=relaxed/simple;
	bh=iS0+HvRPMnjaMBIrBnifaAZYp0yH+UUeOB7gtsGay44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lGCK9UD7sRmgh8EvKxyvrs1fMHRP1EdbGgCwEH2gvatI6qIKlb7unLX3ew8vGcaPgZYLQBrgeRN46CNg6UWz5P07RTLBgGDq2rikPk1wkjM/IjrMkuF+Dij/FCOLOcYPUbIeAICSr9aKHZbFhbkuk9H4CzNVL64O4dCCCQ22URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UYv5r7tB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2ZgspS+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UYv5r7tB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2ZgspS+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679JHw7s3886180
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=C+Z6FeCC4nB3+cJ6p8StuQ
	NkGv86+RFH84uiGZyNiQA=; b=UYv5r7tBNQgTSSV196S3qJk5x5WPRoq92lhkBw
	f9+eckEVzDo0slwXABhzNjupK2uC1isRclH4rLLJRsedtgjLdyeg1z96Rteq/NzP
	WDm0HY75zv0hJYhqB2hndnfDClQC/6DaUywvv70UaJqy++W2GygYjLbpOyr+AKPA
	G5+G6S+iRAH/HXja1Bz3xsuoPZarNMcqJfyCzYhusPr5kwyI8GzAOWxdqBcahe9R
	dru/FTuNR2c2NiP+0BDfg63I9fxEixNwM2TVCTWulcSkUVxztGf6wgiQ/o6I2Bfq
	W8O0JHksA4GW4OGNstWaRSYS20stWgSEhA1HH1uRk5FkGBBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bjec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:15:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d137a68so30297641cf.3
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306546; x=1786911346; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C+Z6FeCC4nB3+cJ6p8StuQNkGv86+RFH84uiGZyNiQA=;
        b=H2ZgspS+Vz4+mu5DOaq6386Mphtz6P3Pcsq71nVC4blxzt8+7rFQjA3XQsu/HBYOR1
         JY5lKoxOeKDBScsp1vkcCkxwVcsvmq2cq9V6FVR+2cR36dTTmexZfKdlaCxknRopo7Re
         Xsgux14MhazWLyHC2GfHP/s+MGXSjZs9qGC63sunvJohTQZe8T3LvZStnCybzM/nlRRM
         NLYny8tUBf+vTUPoD0PuAvdUCQhTjQ1TV9Dqbs8wGXuwAX5qOZg6Z2NFwUXRsw9kD6l6
         93IBqGbR8R8WLl4dRT+Fw31ahmJE6tYiuTJ+48DZtmUs3u5/CC340QbN5dWZbeHp1RpW
         v9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306546; x=1786911346;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+Z6FeCC4nB3+cJ6p8StuQNkGv86+RFH84uiGZyNiQA=;
        b=RKAt+KjBMm43RnI7+3zktqiiaUvi1vAL36Vd1rTkzu/V7JEUN6DcifPnG2hqunv9Ar
         Y7G9Cyfwzgvx5zW9EAH4l9AAq70HyD1HMgeS6pGNK8UCsgP+L2qWiZGqBT6qEfCCxMN0
         iEbEDPV6p2os5ifQS92riM2+0VZOLiTX0jYWz8UJUZLhKoVVcvIWt7maTOsKoVMAlzL6
         Rf708UjA8WV11G0vwQZvCyYNFE4U6CHaGlmvVrIajheKIYGg8ufisEaiHX12MIxoQaAU
         PQ/wMjtErLeWNOOEzyRYVrT69fGO8JY3EsDGvq1PqvKrs6YIRskXlIr7JBZuNWY69dQl
         UR+w==
X-Forwarded-Encrypted: i=1; AHgh+RpMB8v2Dy+AffKdxgY07oEKxsxv/mhMG8WbzRB11SdCwX0Mv2497Efm/dWq84/EYZKC8AgcPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymTeo89hPAqhdVCVGTNA5NiH78ggyby6sJ8cS9Bonear4kEMn5
	Nap5UpkKOieHEn8ZujSC61bKFX14uH2/M/gKLsTsfXMRkfGENGeH6nFSoTaMhD49c/WlIFv75wH
	GEMwLUlvCCQwyxWkRN9kBX5vHArfFi2NNYn90BN4vfEs2ErebgMU2YYd66g==
X-Gm-Gg: AR+sD10zXnzeE+LNliiwj/e/3VUet+0b1DwnIhIlI5YpjnY0all4WY2BtzDpETT2LF0
	aYgU4Kjv2qDdJTmrZ+EXp1YihoApoWDZsLZdCefCBm6rqji7n0Bo+Wzbfxe6qpDEhR7NszagRGh
	nq1l2iEvg1P9ivtOorxEt/gVvyM6tPNmouMdNgLPPVuA5IVR5TPvHhqvFuPpWy0I/rHsIcXqjGY
	aFhxNAMqHR8wEYDOxBej8MPWjzawZCvvVS0sUJLTnwEVh5ECDMWmUZ43W/g1s8C9D7oDlryYhh2
	xSpMNOeGUO1GL7WX2G6tJGayK+haJnMptlSagEeduNFxoz8cHJfwg63MBsL8//8lJ2wKqjklfSU
	fx2BHmBDs7vEWuT8+PB3oz4X6O05Fd/XNrBeWqZqoX7Rs8IKQKTZrSxsYtISqiqR0jW6liJLw5+
	+TbsIYwu1atuHrAA==
X-Received: by 2002:a05:622a:e181:20b0:52d:354c:5b91 with SMTP id d75a77b69052e-52d354c5c6amr44062211cf.16.1786306545981;
        Sun, 09 Aug 2026 13:15:45 -0700 (PDT)
X-Received: by 2002:a05:622a:e181:20b0:52d:354c:5b91 with SMTP id d75a77b69052e-52d354c5c6amr44061871cf.16.1786306545490;
        Sun, 09 Aug 2026 13:15:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
Date: Sun, 09 Aug 2026 23:15:39 +0300
Message-Id: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvfeGoC/yXMQQqDMBBA0avIrB1IQtpqryIuoo7tFEYlY0QQ7
 960Lt/i/wOUIpPCszgg0sbK85RhywL6d5hehDxkgzPubipTo6hU9cMjzyIJ06JrpCBove8suWB
 vo4EcL5FG3v/jpr2sqftQv/5ucJ5fM3fzfXoAAAA=
X-Change-ID: 20260809-msm8974-iommu-upstream-144b1e2a15f0
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iS0+HvRPMnjaMBIrBnifaAZYp0yH+UUeOB7gtsGay44=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/tOrgOI16LA45x/Ox0EJO6o6/tsToKA7nIH
 +rrs2dtFRmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7QAKCRCLPIo+Aiko
 1TMTB/4rwEYJgew1e/uJmyrWp2cbYPFOFfOla5icjTzj9aO6/oWaxAgCvwjZE014WwleQQm3jWB
 /XXpBv143pWAnVsh8+QfyP6ZjyRTxfUuW8z7sdtfRUF2iyy6daa0UihSiv52mJFAZD0ihKeC79S
 C7BpuFB8+kq2hin2ZTcB7zmW76hN7+QaT0XqR5dBAtZJGGDO+vFCtJax1FE3cAQylv5Hs73qP98
 O/48zADmykv0wof7cpT1Og+qk/6Q6GJyT/pAQh9ij0T6cOBqx7tYP8rC79viohoMR1vngadtEtb
 FjKGLMxlcQryWwu63c7cPxPXVV7g5e4bfjfqD2wl5y8z5sg3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX8luAwM1d604e
 /IFrNi3jAmckREUQy9r8q5bY5eZQzSVI/wLt5snS/34CTSCKOkmequHl+bS0Bhx5k+1h8HFb6s1
 6bWDwZMlZquwNekhp7eG8yaim3AwiDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfXwCNwskyLnQ3d
 NDzW23hUz7O1AO7TviPS230A3bX2j1kZS+SohtTYaRCHU7psZ4nU4FHHKuWB9bu5kIT9ETpqCF1
 LBR2TvVBvo8VnJIVfdzWP44L5tiFMk1XAq47sN9NNe5jYfoOAhRn09d7yGXPLTO3sefLXdsFq3/
 FjiaVbVOvAJNd67AtbW/crJw5C+zXtyj3USHn6DCHreQWMQETIy/Ff5W/OhdswXzx3kK3jx1q9M
 HIdFey1UsFg/dNFk8n9plVqljeVna2xZFzQk2HeJx6VkQx9rWgX2fP0GVLhouoWbxnPZSWo3Y/H
 oO7S4hga901RZcnUn3dVXuqsB67mDPCj6oek/Sc8LHn1uZhxn38Zw0meVxirRex/kwGR+/Hp10l
 vM+dqazvK+CZYO8mvY0FZ7ibvTdCCt7/z6lKv4jhEwW62ODsZ6qtZlJAWL41+WzQcAkED4K8d+6
 709bVMyzMY04cj4yuEQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78dff2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=u2vn49mHtsTZZS3No3cA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: eLqylg4jidc8OupgcY0dJGjqi43pLs8z
X-Proofpoint-GUID: eLqylg4jidc8OupgcY0dJGjqi43pLs8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
spec, however they differ from other Qualcomm platforms in the
implementation-specific registers and also in interaction with TZ.
Venus, MDP and VFE SMMUs are secured and require programming only of
CBs, while GPU and JPEG require full programming.

This series skips IOMMUs which can't be tested right now (VFE and JPEG),
and adds only MDP, GPU and Venus (although untested, it is required for
display to work) SMMU instances.

Note, to get display to work properly one fix is necessary, [1]

[1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d2e@oss.qualcomm.com

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (12):
      dt-bindings: iommu: qcom,iommu: document the MSM8974 IOMMUs
      iommu: arm-smmu: add global register definitions used by the QSMMU
      iommu: qcom_iommu: extract context bank programming into a helper
      iommu: qcom_iommu: support the short-descriptor pagetable format
      iommu: qcom_iommu: handle the SMMU global register space
      iommu: qcom_iommu: support non-TZ-managed instances
      iommu: qcom_iommu: restore context bank state after power collapse
      iommu: qcom_iommu: halt the micro-MMU while programming context banks
      iommu: qcom_iommu: allow faulting transactions to terminate
      iommu: qcom_iommu: program BFP (prefetch) settings
      iommu: qcom_iommu: add the MSM8974 instances
      ARM: dts: qcom: msm8974: add the IOMMUs

 .../devicetree/bindings/iommu/qcom,iommu.yaml      |  16 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |  85 +++-
 drivers/iommu/arm/Kconfig                          |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  10 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            | 445 +++++++++++++++++++--
 5 files changed, 517 insertions(+), 40 deletions(-)
---
base-commit: 6c5c106bff878247a9cc7255077aab9040df8bf8
change-id: 20260809-msm8974-iommu-upstream-144b1e2a15f0

Best regards,
--  
With best wishes
Dmitry

