Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F32E1F11
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653718; cv=none; b=TumDNvN0dmhJbl3d1jZY8xFetbCHzjodAAmabtQASnOf5gZV185L7Dz4LBdvrML5JU8fzKaaUY+smMtbsKVj1t/VwA0X+e0IqTfBnthwQUZgkfix0q8+NLclFfD/j+jYWJpRK9OxdQcCg/jI6PrPmQ50S5YqwOhgPFmnL8j7Puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653718; c=relaxed/simple;
	bh=KQwk0Mdce+W21y7dALQ2Q9dpKAvtJUjSQiWHRa+1mjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pEERyU1f9keiFSKT+DaC4MOc6Gp6UXiQb23p558kWbdcImSK7O3TmxWeNF1uPt46PV4C8glR1UBxGKcXqVCdi+DT2OJQDHlW7FRSZaej8A2VO6oeF84X+//DYn3Lt2DfvX8Q/RV+jV0aDye6ldNkG7s7tQMtb2bsFPc+F90qLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hOQLOC4P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j1tQrJ4Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hOQLOC4P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1tQrJ4Z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638ABDU53362760
	for <iommu@lists.linux.dev>; Wed, 8 Apr 2026 13:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HntEs+8pzBI+y7qt7t4W2U
	rvZTm4MrVZ9wGejJw7xFA=; b=hOQLOC4Pqd9JJMAXOHmewoVLftRrhHPEDd1v17
	/ttW0cuJGyHHlKIj/bbk+ZTexlZVNa2np9A3PRrbFSU3YhqVR0i3MiOZXWMHEfit
	h9KX0UiWjHrhZC2Q+JkbpfmXD/okIiIO/wT6vEXmhY1lHzQRBErd5+OJJ8qXfNAA
	xX19ydjn5RP8VNfeyjmV/wZiumJntxPwCloADOXELg3GV/wiN/26ztsnXu2uZEWc
	zSLjdeBnjVLqwQmzDfdLKMLgvma6LK72EgL3s4R9cellB0Ss2jAXjhNbPVmHfR2s
	NbG50WP8K8M9ZJJX6Wdqg4vtX9vI+ORk6JJsXF3lm4QM7HMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkkg2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 13:08:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c63f85c84so3619590b3a.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775653715; x=1776258515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HntEs+8pzBI+y7qt7t4W2UrvZTm4MrVZ9wGejJw7xFA=;
        b=j1tQrJ4ZkguS5rZNJO6GUHhlpyYvwqx/HutsN+7K24mvIvIj7rxrnSHe24tcY6YBO5
         sGIiKcFBNYYyjSzaCf6HKCdDaAGlKbR72Ga1GIRngNZHV5YT1yM38D5pkuQsWZSipok/
         szFBr4RbMDvKSVAiWbyGfBJB48fbRXMx3dcQCMCfj22oO+rdjAvN6x+0vRUzlzSIUgWv
         NMNFNb0POPi4mYT2bJxbteMZuqbhD8n2hAnhQLqerwnaYqCLziuG3PnBYLCILQ55a3Wd
         /q2KN8Ojn6A58Kvqy4XDe2iZjwYLQYfzhWJHVbN/QUXwnkOAQYBo19hHTVy7IfFweduE
         7iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775653715; x=1776258515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HntEs+8pzBI+y7qt7t4W2UrvZTm4MrVZ9wGejJw7xFA=;
        b=lm4RhETs15ZJyXd+tuT4G5E34J5rg4FIXm6xuEtu1CbnEoEIzblsua2tT/HCKMiLDR
         5rNyG/woLkcOE5m9aNcVjqdjs46DLCDMk5i0gWOIeYjBWCR6NWG2Kt07bMTxfuJBczl5
         RZ+vah4biR/oeUdywLUhqf229BfbAWiGLuNeWelc5WGPrzsHyjS5tFgsZ+VKpssX0E22
         SYN+nazTXbxA0qXjPrNEUD5fkFd6lXLwFUI90kPGcIpjrXeOzDrN5KtSiE+petmkI2/I
         1RzKai1dGm4tCkURlVrWOEYODDMOTR7hYpnECT0Apu0i+FusJMDaJGf6cmknXJV5+uhp
         bQNg==
X-Forwarded-Encrypted: i=1; AJvYcCVxj5oiPTcDQ80paPrcK1Cc2gChbesowLh3uhhurEO5OXNegfyJxqLLImkoqVm5UgokOwcCTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMYr2xXfQ41GDkXygO0mK8V5MIDjUurKe/qXdDijrv44AmMCuq
	RIkTFZa9msHo8rqn3poUStDo9Hxx0WJgw7t022rubAU/SCeaXQW50bLhOVGTygZUF6I+b3IqH3v
	e1pE0PsR6Gjw4a6y/GrGyo3u6UqendWHWhWTIUf0r0pKX3nUydNQKUtTikA==
X-Gm-Gg: AeBDievSZkRZlTMItqgFn3sk1HZRY3Q0SGoo3iYN6XkB6bVNMzO2W8tkFNckIuHmAoP
	TaU8mBVHJq0pDVagGwrHUjImym2LTSIcPQyNPCsLiE34Cx9BT9gWpJpRRb2FGCt3hPaSbw+a6d9
	CbR9JpGg8qQap6l91S9jyLxenpfFLa/g2rMIA73gPIhcI0zWokFyn67x8sqQUQofag33Ve4ilw/
	7S5818bi+Z07sZT/UaDEtJq9Omn4vePeRzYwN2A99zYv+pRuz/LVsLnyGH+1O+bBJ8v1Wp7SY0i
	5aA3DIo7TezLbPezZE24+zUa6F+BIBKA3KecRVadvi+haSuHzhIM8HK2YSnlND1Bhkg5lWXQLd9
	nHoQLvyFCPEL7bwBc1YIR/0gF3uBhn38dKkTOIlPa6No1+dxLs92U
X-Received: by 2002:a05:6a00:2e85:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82d0da9dca4mr19823929b3a.23.1775653714528;
        Wed, 08 Apr 2026 06:08:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e85:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82d0da9dca4mr19823878b3a.23.1775653714032;
        Wed, 08 Apr 2026 06:08:34 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c4126bsm20426192b3a.36.2026.04.08.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 06:08:33 -0700 (PDT)
From: bibek.patro@oss.qualcomm.com
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible string in ACTLR client match table
Date: Wed,  8 Apr 2026 18:38:25 +0530
Message-Id: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d65353 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bCvnzbEyROO2_-PIDOgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: LJvgxqEPbr3yfPuuxec0W7RgiTfYjRAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEyMSBTYWx0ZWRfX5umc+vrFgFp/
 G1RmEhfy3oY5XBIdTejDfl88Dc/zrxCkogOu8OuCkCHY2X9LzQJlDTFS32RFnsXFZNVf4BalXfa
 HmOwpDltE9DIZ8m9TIOfx1pxJGiCPscM4H410dMWwKQgVRJ/EnBaTQhNGAUBsgEuKmRHazMRnGe
 Y/WkjthiLSpJ7Lm3h+n+5e9d6sMg3W4KTxEYWuQ2TWl/FaWfhh7hAeF/Qu53Ya+09LeynNW42eW
 AnQHwEvCbIUDHfX+QWn11gt8QKTgzxcKaUDW6fOzdDdSSiSo7TniBdQQCKqSBZD96D9HRYEwSWv
 3kaZcD5aOhhSRjVBk5RYHHQF649v9vFAOjSLZB1o2JbhC1yJl80iGRcvNJi4N1EMMl4g4sgHg5N
 Ajc2P9CCJwPx3C0MS6N7A17EuP5JAxdVgxyT0AFZ5Cgy+rKWWl5tSFO1ya+X6LvCEqiPC0BMpP5
 /H6LUwAUf9qp9Lg47LA==
X-Proofpoint-GUID: LJvgxqEPbr3yfPuuxec0W7RgiTfYjRAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080121

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

Assisted-by: Anthropic:claude-4-6-sonnet
Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---

While there is an ongoing discussion [1] on how to differentiate ACTLR
prefetch settings between compute DSP and audio DSP fastrpc devices, it
is necessary to first fix the compatible string to "qcom,fastrpc-compute-cb".
Both compute DSP and audio DSP fastrpc nodes use this compatible string,
so both will receive the ACTLR settings after this fix. However, for
audio DSP devices the effect remains the same as the current
state since they do not actively use prefetch — the write is effectively
a NOP for them. The fix is meaningful for compute DSP devices, which
actively use prefetch and were previously being silently skipped.

[1]: https://lore.kernel.org/all/9b4c895a-c822-40e6-bb92-8fdcd09c82d3@oss.qualcomm.com/

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

