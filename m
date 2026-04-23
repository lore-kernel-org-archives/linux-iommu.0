Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EB377ED9
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938564; cv=none; b=NHr5SJji6q2G/jzrYn5v3Q+HA12mVJ8zZGAbYq2ipRzF/Vf1f0Bwfq1/Fg8REwL/xpDEsd+lpcwdb26Iv0QrqsQOIT0rSQn6He/mx7sVD2+SIwWPa+C519V78wP+WNTZ+z35xiUKw+Q0Q994UHQYdroc9poO6uwJNET3zSREH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938564; c=relaxed/simple;
	bh=hJODFl24L8xrJVFL+o40ttsrmgaKsOOKBfRA9fMFVBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ePcewVwLu9xmor/jfvmYzSWR8Bwcrsl73YiZUIXBZyOgBjvy9zOUPkcnqbg0Rk5LoB8Mqcx4ct2ux36lP/OsiyL/8x0DB38hnQcdT3GdtmJ/7k/O4rhtFS4puLQ2OQhMU01jAWZ3R7dBKjTDj4UkNXKQ5Dy4zbGM1CmKhCdmmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CeovaRx0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XNEI3QEs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CeovaRx0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNEI3QEs"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uMU71565714
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SBrLvxov8RzEUMj28YZTWG
	Q4HpP1x3kOvuEW3FT/Sd0=; b=CeovaRx0W4fRn0yj0D2XxEzfbE1KXzM/O4ffBb
	Hb+QxupCo1yNxcE86lPBaxlv8yaWj6M+xYt3Tc3HB3jUqftPbNLQi6UCG4/zJfTQ
	C32Z75wwVZOq2JE+1zfemivU4/+6WkgqeE2c3losG+WYkMa0hoENGfM/nI7Gel6j
	g3CiVD9zjvm8jnskQNK3nAhea3I/6Qf5aUZk4HMn8o10lFYdLut3mQ83MDw/nZtW
	NueTtlTpKd92qLEIaJSB94pqxvMGM6Eg1IvsIeNBCM9g+l+7UrHLKC+hlX74OABK
	yRKUL7CfRGSjOTtk2m9BZqA7Hk0JiGB5C66yX3/9iUxr0qJg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wuejv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:02:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e91add2aso56518575ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776938561; x=1777543361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBrLvxov8RzEUMj28YZTWGQ4HpP1x3kOvuEW3FT/Sd0=;
        b=XNEI3QEsFvo6plWZyN11XzYgRoDs8IV8+tXHdmn5IAz+Wu1fYqfq7IEKvyqw2qjXoc
         WgrZO9BbCtxV+gqqZWzcOT31AE+EM5Ds4V16BL1QOqIAnDGAC91M824WFeUSfeRpx2gv
         BRQbohICDb1qzYOnHpaXTjr6pqxsPWPLDEu6IAiWodDyfsY+R4BNHGnHDq1YthUFaiKW
         uV2X9QtLNgXUV32tzt+OHUhFLu4hkAtfbu/kSzBVva9KJbW22+/Bbz+PoJ8P9LSKWCGs
         4aRxIpMSMaRfs/HLA9Oz8QAcdOFiQ8ekDvisHvOmQF5srU9mD1Jc7qkVONVmip04/fTP
         NGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938561; x=1777543361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBrLvxov8RzEUMj28YZTWGQ4HpP1x3kOvuEW3FT/Sd0=;
        b=CXbBIdfEvo8HWri/26zvzkNhSYEUk4+FwWOFUsGTT8O4n23XD73zixblWoy5A7Naqo
         4fzVRVaZpQ0RyUGA4e6WjrKhJX+1f7PHXZ7WbUmUGP4pcOwMhCuaAskpDuIAlyzcn6t9
         o5zkpqgxBexKVAlbHaZWGCgo8miaeykwNhfJV3OlZQIKoXKvTRHRf4VTMqfRu6zPexj8
         SokgarmbKDHkpjb0TIEz3KGrv//w3LGdZqimkuI9YW/53FaRn9K0VigW4MfbtF9KG3Vp
         dxaEca4YIkgbmlhxS3d4D2yQ/QgvlaKJtpeip93YAV+HywAnaulukshOxDPIBc1/B5aI
         ujNg==
X-Forwarded-Encrypted: i=1; AFNElJ9udM+Qve556eLVAS77aF0Gl9ysWS66c8hQA40CfIXf+FM0B5HOVmOA4UNCnvmmcKpYPtMrJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd2O2dIXHwHKX+VjkkZGyxaivAdETtbw9Ehn9Yc7MTkF3/WFCa
	pToQpez1nCyKcV+tx1O97e1zgY31Z/9fezlIRbIwtf8mWodviP63UVjSlRsv5r5pOeU0K035Y+y
	+XnBUPENHWk2xb2C3alqybohQbDw4G/oNKCPrL1G9Ag7M51c2WRbv/R3qrA==
X-Gm-Gg: AeBDieuZ+cVhstJF6KRyT5mjeqNbe3+2ylcpCJc7YP+g3kHIFsDm9xwMlvgOqWphlaS
	2bL/RNbgzzQ2ByqlDNub3iRqGiK8Z635ioVga6ahXFqUAcKDQUK9+rDzR131PlOD19ErMUrZIt+
	jhwNP+TlhJduiceamf3D3UfFIOuWVjjd29I8i2lPwVQN+p+ybZXF83wmpXcOckwHy41QkHpkVnH
	lyZ7n9uJ84+8a+0l88nFfwB8GSfcV2RH0eXp6WFyshM81IFm3ajbd9+F2rmzLxq7Uim5xbicADg
	7R8xvjeo3gNj0NMKKaP0xV9b1aHg52ZolkmI0Jon+rSregvnXoDDj+LPOdoT14KDjkJlQ4Y8KbA
	jhNo+6QLS+PQxvKnNWyrqb4M1odB5hawrOI77lIxT1yA8Dc8ZTsI7QHuGPhqiBzc=
X-Received: by 2002:a17:903:3204:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b7895f4214mr101858285ad.21.1776938560579;
        Thu, 23 Apr 2026 03:02:40 -0700 (PDT)
X-Received: by 2002:a17:903:3204:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b7895f4214mr101857205ad.21.1776938559257;
        Thu, 23 Apr 2026 03:02:39 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab29398sm194785095ad.66.2026.04.23.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:02:38 -0700 (PDT)
From: bibek.patro@oss.qualcomm.com
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2] iommu/arm-smmu-qcom: Fix fastrpc compatible string in ACTLR client match table
Date: Thu, 23 Apr 2026 15:32:30 +0530
Message-Id: <20260423100230.3462214-1-bibek.patro@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA5OCBTYWx0ZWRfX1N445cykCGz+
 /Ghws08MuJ/yoMutvF2EIdFmPMddEF18kQVgGLVVeUmAA+2zrYYIQC9g2VLoi7kOhG6TUZDUIck
 HPOImPOtpQNrXLUeunvMQc0SglpamOfbuDTNDiJV969F6myq6/loy2wsEEfLLm6oU9QpeWkL/NH
 pKHX3xAYqL9BNOsMQuaLPkJjMafF4pdwSOfKvTBtkB1beco9NdZZ+qjM4jF6Mm+Ma3CooXzU9Y/
 Dk7BKE0NIvHmuo0pKs7zS6tMyoW8Y0YhT7H2h8BvWyNHuIjCvt3Elkhg8PZodHRc0zU8a9ukhAJ
 xNvO/ra0mxitpg2n8UeEywSZrzgADuaRHz2anbWxRbFW5FkiK4nqU5aiENkQTzM3XemhWsnhM1B
 VgnBa8YE/tGgG8VxJ0Pd4OdamBEpzBSN+q45ctMRdZ6j9K2Y1JInFeZI7uIzxiclcIwOAwilj8P
 xtPagR+69JDX0rdmytA==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69e9ee41 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bCvnzbEyROO2_-PIDOgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: euNoUb8A00C9sdk-jrGRKRp_jDWJRrFk
X-Proofpoint-ORIG-GUID: euNoUb8A00C9sdk-jrGRKRp_jDWJRrFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230098

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

The qcom_smmu_actlr_client_of_match table contained "qcom,fastrpc" as
the compatible string for applying ACTLR prefetch settings to FastRPC
devices. However, "qcom,fastrpc" is the compatible string for the parent
rpmsg channel node, which is not an IOMMU client — it carries no
"iommus" property in the device tree and is never attached to an SMMU
context bank.

The actual IOMMU clients are the compute context bank (CB) child nodes,
which use the compatible string "qcom,fastrpc-compute-cb". These nodes
carry the "iommus" property and are probed by fastrpc_cb_driver via
fastrpc_cb_probe(), which sets up the DMA mask and IOMMU mappings for
each FastRPC session. The device tree structure is:

  fastrpc {
      compatible = "qcom,fastrpc";        /* rpmsg channel, no iommus */
      ...
      compute-cb@3 {
          compatible = "qcom,fastrpc-compute-cb";
          iommus = <&apps_smmu 0x1823 0x0>;  /* actual IOMMU client */
      };
  };

Since qcom_smmu_set_actlr_dev() calls of_match_device() against the
device being attached to the SMMU context bank, the "qcom,fastrpc"
entry was never matching any device. As a result, the ACTLR prefetch
settings (PREFETCH_DEEP | CPRE | CMTLB) were silently never applied
for FastRPC compute context banks.

Fix this by replacing "qcom,fastrpc" with "qcom,fastrpc-compute-cb"
in the match table so that the ACTLR settings are correctly applied
to the compute CB devices that are the true IOMMU clients.

Assisted-by: Claude:claude-sonnet-4-6
Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---

While there is an ongoing discussion [1] on how to differentiate ACTLR
prefetch settings between compute DSP and audio DSP fastrpc devices, it
is necessary to first fix the compatible string to
"qcom,fastrpc-compute-cb".
Both compute DSP and audio DSP fastrpc nodes use this compatible string,
so both will receive the ACTLR settings after this fix. However, for
audio DSP devices the effect remains the same as the current
state since they do not actively use prefetch — the write is effectively
a NOP for them. The fix is meaningful for compute DSP devices, which
actively use prefetch and were previously being silently skipped.

[1]:
https://lore.kernel.org/all/9b4c895a-c822-40e6-bb92-8fdcd09c82d3@oss.qualcomm.com/


v1->v2:
  - Collect "Reviewed-by" tags.
  - Address nit on "Assisted-by" tags format.
  - [v1]:
    https://lore.kernel.org/all/20260408130825.3268733-1-bibek.patro@oss.qualcomm.com/

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
2.34.1

