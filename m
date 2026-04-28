Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80B338925
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348568; cv=none; b=DO+oxWOTAKp35ifYGufT7B2yGLALG+8M8LbgTF4b+Bv+PMuRgLIBc+EdrkXNMutadI1xOmGW5LcHA04O7wEZZRmYkzggRNPoh7TYtjPBjN/ny29/Dgm2o6Y1sJS+HLAWNA9xkBm10pmgiR9XLnzHT3PipSb1+pl0MtkDY7dLF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348568; c=relaxed/simple;
	bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENOeto3w7WYH/aQ10H9xblbgptnTw95xIeh+xky01jwQmEX0w+ohJUbDofH/SkEIF1tTx1wSRc9VPKPW3eQo6ITCjTyK28ikNsBwYCxy6Kye7Nivhj2M1Y0m8aJ7Osk8SB0SBqeIcfBxRfxO9kCIDQ+UyQF9eLdSZYCPeiO/DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzxslg0g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DquUdBFh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzxslg0g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DquUdBFh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S1vGhT3123751
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=; b=mzxslg0gP7zoCWL8
	HK1m+jk/GCKz0EfmxyinXpZzoW0GwVrVBWb3dCbH7fX9eSQKEifMf0PES3zfNDn/
	5tuL1k1R6zmNzWMSO5Xc8ow40h5IIUCE0GI5HvhcKp8YURwnqK3Ib7iJpAxj54/s
	GycsCfsj1noxB3KlHZMbUFPErqmGt2RrQ2Q9JUZN7MKqnZWp5W+I5HQYL3F5uv88
	j/Z5YH5pHXd9X4S5LHwxNiAshXjO3isBmizvU3qpadfv5M4ijL+OBebeXyjDlZjy
	KkuU1o8DLzXLP9qVmI2sw/e5OWENrpwWdnx/c8sylXD+tFruEC1A4Lq0fdqZVAwP
	+eknaA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgkm9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso21288631a91.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348566; x=1777953366; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=DquUdBFhmqqppw/YHsZjpcr+c1c8W8hMkeWNitoPwyAZbO5ptb5O+ZrvOP2mmxaSUh
         b+3xpCQIhqZmc2UfudjZJ1GH1gG1yDU0G+J+7IA84icIPDHnBDAqACx0eVxDeBc0KMt6
         jGUdWY4La1oQL4TfFD232nRwQoAw2dhnGgZNvA9MrRRd6Ttd4EXk/xT1q7soK4GPqtwM
         +AqBkvHfDErhv4tsQIQDq1EPLg4f7NjN+Ygbd7Puc1pylJjBtvATPHGob+TYa4ANc3eW
         W+haiIXZMegPS6/+7m9dXkjXgxeQ7PACFClhla2izonNWCP3HFdxcSyLGlXEvBWC0yWH
         5+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348566; x=1777953366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=mIltrmxafS1sb1DW3NHqJ18chcNeizaznLNycMCTABbEgWYmksQs5/X2RGaa8mxbK3
         aKrojrYb2dQKJgJji2BZJGAfnALqhkIZTbjNJuW945mz8IRfo9k9ModIpfP/AfS8nTEJ
         U2QBIbCGbxKgShZSadXnMvxeGJoAi20PT5hMkVVeJxa76GP4jnTV0ImLrCCmID65CSOX
         hzBVzSUntgS2JLD0qrKi3xeM3KLL8RC8HMchbKuvrLi70pwCDH6XUJWOgK4z9fm6UZtC
         w7xi7Y9M0ubWE4fMWxWRO2emBySyq+F2QW5DzRzj6GZdyZqsy01FibUEZjQOSC50xsep
         WVww==
X-Forwarded-Encrypted: i=1; AFNElJ+U5T1dGXXxy1G/iSs7YNABknQkgodFaD1jvW3USVL1Hei4tTY8sVxTv+DwjRYp1/tR3anV8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdYxgN//5k0rLUo24JhM0Cosu65Gec3YsFYO/5ZhwVffpBdUJB
	HucLP3vPApxwSWLtgePNWDMOK9HHrv/DWhAAdUlziLZyUxCvK1y2TgDViM6rrpIP1ekXHLZkFyj
	INufgW89TKeHv+tKIsAvKrJhvJ9BBW3CpA4tRXW0OEkpfxSh+kiwA0KFdGQ==
X-Gm-Gg: AeBDiesb6zCOR9x4UgJq1Of6FqDfmTe1aEf/2NR5AsjT4B+us7qzaiXW09+fD/xt3P8
	GetWWiGIK4Lsc1Yg40iYdm+jIsT4kEnSM9x4IpyTFmQ9qXJVk6YgUq5jgwnGLcBCaiJ9T7yTCd7
	T9Gzn1bHsPLuzFYvExSwchbARq7Et13/x4w4voamypwBfRrmSIKVQznpP0Sar3E3YZtioodoYZV
	FyhqrrrH98flnsRNp6BcV6Ll/Eqi2vg4nAwnddPrKKowu75jrFkOVKjshhQT8wvj4lrHX1S1Z8Y
	CuqEE5dNrwK/dnE9jQKOnTcZFGiwRF1oQmrxQX4svepo2A9sa1RviCDMGgKZ9qb1lENVujD7ua/
	pOejG8RGrXARyQq8i42YESwH0XoH0Jieo1SaVenGKBAD30LFwq7zaVm4k7xp28eL+3A==
X-Received: by 2002:a17:90a:d646:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-364921b0f18mr1617206a91.20.1777348565585;
        Mon, 27 Apr 2026 20:56:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d646:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-364921b0f18mr1617163a91.20.1777348565020;
        Mon, 27 Apr 2026 20:56:05 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:07 +0530
Subject: [PATCH v3 01/12] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-1-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
 b=ay0dYnshvA44WROZCAGWy4lKalYgcb7yDOo0fRviOiuhVcATuyWxdErrTpNeQbm6pWWNnv4X6
 u3mbWherdU6BTtXEW7QFWSFFg8yQ+9jQhUvkN+qqjo9clshZxPEAcC6
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfX0qTkJ+a27Iw5
 vl905hK3+NgNRuMq/5nwdNHKyfzoCYqBJfFwagbtTlkmXVRSi6FAtJiCLQRxWupnAv7Y24Cfif6
 CmnsSS7sTFgBUoQRhCFx4r96KQUtWfIMIhCpXoXNIJmNHtPf96jUGtPVTH8u2qSAhEURZEONZUM
 9QGnuQQ66FiUWaJfGrftWnya+wKZuevsg+O1G1ETtDNVX4r92tOkqcNYuiO5TvrjSj3SktSrB1U
 nq8eVRnm1ftxjVs3XmFkExARAorRKvI48+9igkaQBri7bNTkAEKDl/5S2PtbVMIS/8Tx1gAhgHD
 IXy0C/Lm+yEUSGTSLMMmI2J+DXBK8HD3yPdSDf0XmfTCgIUU+JdoThEYG1Wv5Gju5D9wjr2YTuq
 HuMnN7RoUJnS5EGTpupyWGy1mShkofHIADmjDA81fmjJe2lkAM23/3FeDhXT4xZEqk+BLzeA1H3
 6jyCwt8/Z5tIg7CG1Zw==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69f02fd6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: OXnQf1_EG7FntL-7EpFvo1q4pTKTI849
X-Proofpoint-ORIG-GUID: OXnQf1_EG7FntL-7EpFvo1q4pTKTI849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280033

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..bfd1e762c38e 100644
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

