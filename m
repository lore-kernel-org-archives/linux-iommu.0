Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223F3FB7DB
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266878; cv=none; b=mA0Zw4UHdkWEG5MbxhSpu8pe9HwpuOl5NOsqn0OOnmI3m4AeaPbs5TMsdu0f3Wt6Udi3OKVNkIAwPERbyd+KT0NsjIq8i83V72RH/4VMLT91Ykk0EgGB/Ez9p7ST1joA3dTl02qEQs725ZLI5s8utszsaZiWGkML1fozopV1mFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266878; c=relaxed/simple;
	bh=+CwAWBT56Jm+jcj2Q4UQDmpUtoIH5fpiVgKBMPwi0cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0yI9Zngy6RkxIi4tw0bw2SVlYgwA7UGzu0z0gOChN2jMTp32+2HpjFErp0fqJwT7lIShl1d3zSEaDnOgTgF+Y4htcmRg7zetYflNCH9vJogzuplzgbWQbN0ZAStbEeTs4KbNHK5OaDaWToiCPIrlm4QXKkVhQ9pj08zr3i5ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsQqT+jJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQcWEqWe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsQqT+jJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQcWEqWe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DXnLx317526
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/AT+OqvsZEGAlm5HKdKcAksd7hTIew5HyAoZ5502Tc=; b=AsQqT+jJK7OarVWi
	ZhySwme7r59hDAWJcia8xqZu71PeYYkKLhiWLwB9iPEMnF/ZFHaRVI4twNgu4SyA
	amYtJjue/VI/DZ0JvSTX2WZqKrj/i/w3cRT7iO6umaUPa/e0Eg1YAO0d6lhvomlI
	I+KfGWGTqTSWQCoQuqiDKa47huf/lwtPSGmB8sj2pXb9u6fFjayKAnmj/s/Z9iyJ
	YNqXLMj0WQgloWGtFGOz/QYnbWhwx2yALtyrpzaDwwK8PyBzbZz24FZjE/6D1q8l
	UuknzV7/IRXcLNTdAMxtf8suuC1wqhwkiTPYLWP3mjZGTHqgw8eJJsWuGdOluEn/
	5YliUg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc02tbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f85179263so2374734b3a.3
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266876; x=1778871676; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/AT+OqvsZEGAlm5HKdKcAksd7hTIew5HyAoZ5502Tc=;
        b=SQcWEqWeui/G61LeGIvVa+ypweA/3A8jxhfGKd9lVqou5PTVdCsOD4ya6CSVyb2gTH
         ckZHG4J+xKofK8rSLIisUHP7dgjUv5BSXzXTihpDGOyIG+J5uZndipklQHq90T7uprx1
         fiU9TSFILn0kyrGw2244Qa1H29BkocqPfkp0FfZAeOM9fj6aRU/OMdSqz8E1nJyrVgOs
         yHpM4W9Yndvj28T2gZjY/76qJYOT1WlnNhAiC9pd4nYFSsds19gebnowB6f7IWQq6jdQ
         UMyi5nPqWv3y3G1r+xn+myZ+VFK3kDdQhaVeY1q02LdSFRkaYJwSqOuyzawY8WYIa2tg
         9OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266876; x=1778871676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p/AT+OqvsZEGAlm5HKdKcAksd7hTIew5HyAoZ5502Tc=;
        b=rRUUt1SQd1qZV3tmoMoy4XKvEW8LHaUw0GSHmjwqA+oaTLs7UZrbPTAOkpXxaEqmMS
         Kp+1mlFWnaMpNG1lN+hpBECU/keXmB42KGVAUul4WakrmugE7jMtq5lFtJ9aU3+AN/je
         J/eBzAZHATwVOQXRo6f9vybZbt5F897IXwoGPQl8uQ7kzt5S4mayZ3O0/JUnuNLAQcFP
         uqP0aeEJETygn/RNb30iHeib9cV/g9awNt4vpntaDcM4PfMVbrZV8vh8i0EqZO9BaLjF
         AmlZxcZyhyOIB9/CJIIeCf0npmxcTKfsSTBnHT3//uDnWGnc8PaBm2Wh6xC/1SWxhK3n
         96hw==
X-Forwarded-Encrypted: i=1; AFNElJ+vcypd3CQx4cLSwe3YVIKhQG2XYt0cvMUJurLs8cHbNCyjQuyNXpb33sQteoS0940Irj9y3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP9E3dej856uYDdMHnJlQtE7OA+Bv1NfDAxErWQhYMfB0u3CSd
	pPEfFYF0MQmlhBfwN4HEI1thgLkmm15nekqqTIErsnRw81/ffHJ+OcgIdTaQP0106dIVd0dJIlK
	NgDUE+VmHsUpNdavWpB222Fct0JLmrqCncbYA1vgS1peo8lQV4V3B2Hf5TA==
X-Gm-Gg: AeBDievLAYBh1NuAh6d/GAkQUX7SJg1OH6scV6QpwbvQkhVqq6uNgL9sb5N/Tuutupn
	vLMCi2bRzsgV54g0IZIyomD3JB24x90FCRt/3IjAe7Id4IgR1vHyxHh+mJPHWTdFOs+rnA0R3pe
	vHTNswJg+ydaQqpe3rRktKeR+betPm8G01ODJitc8dSnkkpondjbsdCOwN8i6amZrnKEMwWbIDc
	fldyyWgl+lpZGenZlmV31mNTAFEp4Htp3zcVhL5hw0+h3NspuHbozknv6GGI5Evu8rCHIlBNrEF
	B352Z/zKrrdAtWGzXykVhj+OlxGwtlXeoqo6aDeOF98dYt/FPMjCSlqG6XuY3YGE3ISvLEXEQtD
	SpforypxHhKwl9Fbx3R4C8OSBO9+VjEmt2FQ1APwnuDGnT43ea3Q/GqE=
X-Received: by 2002:a05:6a00:2411:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-83a5df487e9mr13628358b3a.25.1778266876129;
        Fri, 08 May 2026 12:01:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2411:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-83a5df487e9mr13628308b3a.25.1778266875588;
        Fri, 08 May 2026 12:01:15 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:15 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:52 +0530
Subject: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=1360;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=+CwAWBT56Jm+jcj2Q4UQDmpUtoIH5fpiVgKBMPwi0cA=;
 b=kW/HQT/jSDBpkCUfRBqp0A5Yj4nOp80+ZwEGYSAUFspkAjZt561MKLpQwFXZzmu/dKkzVWx+9
 B7Tjefd1OYNBH8QV/X9SfxHeKATLIdHunm8LdBeO6zpdPfvRF4/MdRn
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX3an8YrxFtYNe
 ry0a1P1b4VinBSHC3szmeXQgkcu2dSv8q+sDjcon44ASqTdDmOOFmt4xRmjHZpH3u+ZlbvunTfO
 Ri/XVdRmuiCq4TsDZT5XIP3BN4VcAKeb6P0bWKw2aertpJHw1UIrwuyibR5FkkStpeQzuLBzVcs
 Q2dAtXUBNGAJus+h8DWa6KzDSuSijfT7j+m7YmVLSuoD3aAXof+KQ9XkLKiVOuNmgM4JCo9G8BL
 R9x5JRCIrcof7E5RODmfq9MZ2M86WOnuewO9V8zpf/4o0oMqK9er1Z2AdJeRsM7f4uXxhSvmV2c
 qskb/SCW3LOYDO+AU7eMqQ8jAV64xn30kAPoevWWrDuUGCgN6UqGW/nO23Ssn02HNoHwuN6fAwE
 bchhYP6+gqbkmzkpmw61ySRHtntEqkjfAkeBj5ke16ESXoAKntMCea5NWPqBWvqrzZvoAPR2Unr
 3ckva5w2dWGnMEFIbqA==
X-Proofpoint-GUID: vCy3e2Rcx0PWaInbwXF37yTKrYOpHkNw
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe32fc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: vCy3e2Rcx0PWaInbwXF37yTKrYOpHkNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 69e6126dc4d9..f1f9e04b7c31 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1

