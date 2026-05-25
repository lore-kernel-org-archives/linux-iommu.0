Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDE405E7
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689867; cv=none; b=K4hNxnMHgnlNs6hsmBuHu2PYC2FTMp2kh8QXkKvh1zh+8rYQFF/FkQSnone60kdgAWvKE7Nkvxju7BnyMnOOhLRKDzX5/14yJ/RWkPugcypBZlfDgvuVCS1TZ/rLsLVGCsaGsXlXtKe30WiSU/aax9scIbXaKKImOy9tZ7ovAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689867; c=relaxed/simple;
	bh=+m9rqksL9CcrcdAyKNuiMdVbpebT0DR9bi9FjEL4MaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D+Fa2FeafOO1TqoepmhUU6ZfGAdfNfMfB5ujg3xvBb7joWBInfHQsFr7xNhlN81Yqc6i4wb5s9NFmhuazgRu+EUAyQT2TOxYyoWLHnV7ClLhMp1wF/mbZa6jmZYKE2pk5p5iLgtOFHMfjp0R2t451yfsW4C3pAbJaUI83lhrQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifskVIAY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q8ME3+cO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifskVIAY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q8ME3+cO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ONKCVa1707573
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LJX57Ht5s74mV+xzZtIacn
	VMiPk98gL3JtBjflkMkrQ=; b=ifskVIAYtzSY5iQodV85d/BVjSRUCbYtKjXITA
	gn00aJalBMgzbZyZmkCDiue4ol4Xi4dZXJaOfpobcTVS0RLvAM9d7WRNIYEhw7Ae
	pWkiJCfZW/leaW99R4r6fDSMu5fS2uhuQK1xiWVP0SWtAu2PLkQOlH1vbCMi/AL+
	NHAOX6n3NAqUetz/Us/vDgAkWqSmITqSIjutljM6Lxzrq4kuB2b715VRWrTWwa0X
	zW/dI+zebApoWKmd2QEeJjGzO8bGfdsxzg6X2m3VD8mJ7nkTD1x6UbeRTjBYmpJV
	wsOH5tgZvSJA9Mz+9Ic8jB6W9sZDPn4YVgMoGBcxDNv36Glg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txn7g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:17:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f5943ca81aso2397582eec.0
        for <iommu@lists.linux.dev>; Sun, 24 May 2026 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779689864; x=1780294664; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJX57Ht5s74mV+xzZtIacnVMiPk98gL3JtBjflkMkrQ=;
        b=Q8ME3+cOGmixTIgdUqDqFDHTk/vJ6NljUDVCzf1ZQ3PN85jLpg/gjcMFMJ4VGRFLXo
         CKoH8GK44E3ZiMd9VTfsRTIyG86yhjD2mvhzVuwvcQeE9PjWsPfCrdocx3kc36SH4LjG
         RlNGoXWINXtTValvKHCRz4JcpiXRjcsgLKO15ooukkJKcFeDwcuiEzBbJV0rO5ssheEm
         O6LN0HDOocm3miuzsPThugO6cQYjvn9eYdayUIsrpglDRKnv2x5n6qeuom6Rxpx+zfHa
         WUiPoxBfav+ep/VLoxyrvHhtCFbcUSds9BXVT8apmzuWxIUwt9jePMwIV6Hq0McU0Hkt
         wzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779689864; x=1780294664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJX57Ht5s74mV+xzZtIacnVMiPk98gL3JtBjflkMkrQ=;
        b=Z+0P1lqeRuFW9Vwc9rbHFn+8WDMuVNpS86hvXY9wOyXTgrmHuK53K3qrcdYvQ1NsIP
         9xAc4fPPqD2iUbiVWfa1KYDW1rE30I66SS5vRNmONK/QJGMHkjjp/SIZHbFcfWyMr0Ci
         3oiO132gKGzMHeRnqIpuXgW83IFQ9rgbJWGFKxXxqGiEEFORu+UDGGXMPujoZwMCrJJp
         vwFjHz+lt1hYX8Lb0aCDL0kPAoaoWiGJEapn3nRl8fBIBkk2BTlcTH7OzX2kGQIXW9V3
         PGDq55otQ0BqqOcFquc0Fi1KV5pXC8FIUuwnc8Kn26TLCPErX0ezcYabBk6/7I0YUND+
         VFAg==
X-Forwarded-Encrypted: i=1; AFNElJ/DKW10JMjirq9ybb7AvB5gTP7VVLWFCAq5uy/bwfb0yDfvyXLu1lk5Ps6iBQBPI8UFVsuKtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjnYyWbYZdvns0IpeRhl5sOMXaFdmeuXvuuAN+q1LdtDbu8amb
	bD26b50D7cXUyPKJFu46dzFwmLC2VBdrhtLjnJnpxghvisRF6xcDlXFEItzY1ffMa5g5h3L5xyK
	5/+Gre3+srz5U0PYkHvizBYHI+WO7Gk/0dT3xdDV9JhplwSkJDY3rINSF0w==
X-Gm-Gg: Acq92OEAZDUCAgOVEyb76k9dUr2bnrvD3p75L6DqK2GtvaulZqQJEW6Q+8TvxlxUNew
	cbdM8YfF2af/rSHtewfqmwXby6oF0wUaY/48xvgIA2WitvLRRkDxNpT41y6BSW8PHsfP+uQP5eT
	fXENQJclKE2PsIW901Q/3wG4sP7Fy0nHjQIVCLsTMT6pyOoUQgAMkpo40CZzHGxbgsys4BCo30+
	2n3R+Cjb5doobvWHh+gta4wYPZDMs3DWzr1NzHitGABd18njrhB5XG9MTJDGIQD9MOeWvisEoVk
	ZCIFpikgr2g188lzxJd08Igr3kX3lFtQtwejpfeXTLWFLiCx1WCB+/inxVwMRMlNp4eom7loHfG
	hkw7/Zd9uimWO8esqKRMEUSNiLeI/RM7UxsQ1D9/9YcTmwjp/tJyq+SafET65ckQoY8LggHdNOW
	0xLI/yyYQ=
X-Received: by 2002:a05:7301:578a:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-3044915ff8fmr5978851eec.22.1779689863607;
        Sun, 24 May 2026 23:17:43 -0700 (PDT)
X-Received: by 2002:a05:7301:578a:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-3044915ff8fmr5978831eec.22.1779689863079;
        Sun, 24 May 2026 23:17:43 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230f1bsm6942271eec.14.2026.05.24.23.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:17:42 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Sun, 24 May 2026 23:17:34 -0700
Subject: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for Maili SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH3pE2oC/x3MTQqDQAxA4atI1g1kfmyhVyldzGisgc60TFAK4
 t0bXX6L9zZQbsIK926DxquofKrBXToY5lRfjDKawZO/Uu8jliRvQS1lQUcUp+hyoFsAC76NJ/m
 ds8fTnJMy5pbqMB8Lyz3s+x/fMR/mcwAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-3d134
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779689862; l=1104;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=+m9rqksL9CcrcdAyKNuiMdVbpebT0DR9bi9FjEL4MaM=;
 b=FdaYxV0ad4yvCaLBOHVjfmVKs1TzMIdM2JDbZ/NmYG2SZFVmfunAdmtiOXIT/hElu2NtLGciP
 TEpgiOa7sdHBSYd3m1iunT8kG0Pp/vBgvtUts92OpXv1+0EvTN9L3Lr
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2MCBTYWx0ZWRfXzlylzAeeXWTT
 +cYv6uYUBIQ7TabcO2GIOeVRTL8nAhjaiHVPGvYS+gmRX1UeGdHOQl4iaKsZm4lVTxaBpq3yfGX
 XjGF9udp4op0WSuN8RNZHPPxp+SJW2eU5Rslgf+whGtBxgnV5bARIxBHdK1oFAPnI04pXTeVI08
 VR4fR6xAIctzaN/lMGYJvBcYMMgFr7POyQwjEEc9Nf5GglFD/ZAJG2nMVi7A04cDHuIw1ySlfye
 Vn2Uhme4V9gXbmVTXMlsj7rX33p7FOx46SyXnRJJui4+qsi9UeuAxGNMHmATmjEpotuUDMUj2za
 w1MqMfirrymWeXkWo4xcmTKjteAMHOVl8K2DYyIovgPs4V3ytVVAiLEBb4My0txQC0U3EwAXk//
 7aEew3CO4XouA4OzaU1lGy2xRU5OK8++nwTEVAYiFd2qpnGvkzljTjhiG16fylaAc7wYoxtOjv2
 T2kSoqZo91RHpcr3qfQ==
X-Proofpoint-GUID: suTLd0GOPpZc2HoF0H_mybaIhhnA2Da2
X-Proofpoint-ORIG-GUID: suTLd0GOPpZc2HoF0H_mybaIhhnA2Da2
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a13e988 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0vWZlYpcnXXQiWOWdZUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250060

Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
which is used to translate device-visible virtual addresses to
physical addresses. Add compatible for it.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..4bd31aadc405 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
+              - qcom,maili-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260524-maili-smmu-1004f41b3073

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

