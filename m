Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B48376A10
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073042; cv=none; b=YVaRwNiVBoSaY0xr1br2lUs6vAatUGY9T13dHrlhmUYf/8cvVcb8sDVwYRxE2EdVOE/S5mdpI1Q8vBTkfh87t7Kvnpk1MmpwC8JCknolkYXNkyRxk+P0Nu1F/MKwRgZt3mKpxZrR+7CvyPBExTPgNdabSL6GFZtVE6ZXqDhDFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073042; c=relaxed/simple;
	bh=xu0XPQQrGgIcADZXkcWURUAsf1MnYM7xyMfECG6R4iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d72wv6O6+TNT2ZG5TjiCY2jEurdGwlGbvSh4VCaFjLWgCCjZcbRnZVp1TIxP+S62y360zweukfXXwskGCvE2dTPBaXGrVmIYQmlfEzJQHKzXVIAm46yZHxn8LTIXnAoutcLUhvixtSVTyX6YULwKLL+NJzy82mXtNVhCf/guQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AIu5OqaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U46k9dDM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AIu5OqaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U46k9dDM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2efT1241014
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yRWghUWFVPf3fPEbC/Fe3T/IcSJlI8g6PwLdmF+HWAk=; b=AIu5OqaU11VlkgCu
	io1f17qEYHMztmqZbaxrGPlMzRwhWQywIko15R9+cbIg8vahzI5f6+YPP+MajUj1
	6uH8UpoNEl1vWnRGWWdjkgeRb8ElZJlW52TEoIUYDKdEaY4B7g0Ht2jP+K91ocIc
	z09tNlRwKIAzqaU0/pacnpWWQ8in88PphDLZGdGN1yOjNp98mkcv+G/KsaIu9eoR
	dzWrlizqF5i0yMFTvssoe4bKEJI1wkOzSCm04OIiIg6aR1mdX7wcBLfbp3rQ4S+G
	0DNGPFGLdRDtzvNpxARHkEBwFb1IMgJWwT9l4HzcEop/ZQrbcDUPmJc9mX2VXewh
	NASfxA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukesk3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d98b74447so5037121a91.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073036; x=1781677836; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRWghUWFVPf3fPEbC/Fe3T/IcSJlI8g6PwLdmF+HWAk=;
        b=U46k9dDM4FgesuydiTj/t3VeEPwB1f/SLIuORgZpL1ZBgPUlqC7LSDFb6djLAeDu7V
         AfAjSA7HYmjrqHe7WGObYA0+spovoFWnXS/cLz5nhYxGawxLheQSRMuQhhnDHa597Kkm
         j+fw9n1vc7uoI+Tw7M0PcPzBZvG/az0W5Pfhs2Sq3zW3HW8IOD8Q5XRmImgRWqRgqO+H
         Md7fBWvira0VSh4NvswKZWsi3nGkYzzEMWeKtHydQR4Ph6o0h/u0U8TQc5PfzD5nANK+
         tQxksoKawc33UfiyaaFcBJdpZf9+jmdjZ2tMHWhT0X0SdI+0E1tJDNrQDZJGXu19TGrz
         MkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073036; x=1781677836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRWghUWFVPf3fPEbC/Fe3T/IcSJlI8g6PwLdmF+HWAk=;
        b=NYdfKmnGrhjoba+xIauXUfb/NwQhBlgqf/YySXvpPYiMkdnOG19Wm00mu5D1Lw4ohz
         1AQSVOQElJMkvJfa8SR6xxxnMgOh0r4alhfas4jl32yKWyYSVzJrp85J6yRTEBjcvYsd
         UnkBst35bEjtlWq95NGW9Pt7CKkNlcIU7ro00Q3kmKDOA6lPK+cnM7UcRWagYdLs5bwB
         qp3cound3cUUjBQqsc65a+EF/huMleCxREvG8M5c3wYGIgZntrBixKgkoUUJUXqYtiKh
         Ak4KM7/SuAEx1Utx6ga0/1bH/GzG8ChyUWZpf+F8oR1nFdkaUC6mAy3PHoIhrzoKzg5i
         9O2g==
X-Forwarded-Encrypted: i=1; AFNElJ9Q2xtcR7i94pF2PGd5H1d5vB5oe5WtceVl1ueLmfs9MN8s1qOXAjm3jD7qw29fs6W9FlEnMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmnUBycheBvwQz0Ft85GkqKw9XGBX8dLFL4frToNm90QfR4TeE
	Jn7pa2DgHDW3BzH8F2wAZ13JbVvWxiYUdPyM/KFjOZkDuDzik1iydnFTWJMFHqSSmPPBjkk+AAF
	RAlmYm1QpY8GJffcbfoN/OAXO5PA62dTsDq4hfz6t9YcNdYBuKCfDNfDahQ==
X-Gm-Gg: Acq92OFAvjOilQR6ygCVibeClAmcC3BWSrw8ZjYN90obV/0p4I2WeuAIhekSOYo5fI7
	/UOJctdSkZaFlQD1bxvNYHilz7ao0d3TsHyW+880QgBg96kYdaNCmjF+Y1Fro9Mv3U++H6UmNV1
	RlJWXPtODNL4oNfPLFWeDHXulqt2gEceKEQvH1dGp5rI2gubVVp5BkkLE7O+mKYOP5PhmPROK1X
	5KkgV1BVbXu/bAhOmdZgg6ynX4BRJfOCRyKbQUkyfHHAb1bWEKJLVjoDhhemsBKJ0UCpx7hTAie
	LltSeF3HI25/l/q9OKrD/H6qmKWytvLb96jE0g6ydaaoRqCGKpj4lVQF+sxJl+O+MIxSM0ep5lx
	amszeg7rjn6FyEgLM2idfxTqLar0Nwel2HYzgiWAWz04CN+hweLyyU0XY0igpsUhbmg==
X-Received: by 2002:a17:90b:3c4f:b0:36b:93f7:a903 with SMTP id 98e67ed59e1d1-370f057b7f0mr26101942a91.18.1781073035548;
        Tue, 09 Jun 2026 23:30:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4f:b0:36b:93f7:a903 with SMTP id 98e67ed59e1d1-370f057b7f0mr26101909a91.18.1781073035080;
        Tue, 09 Jun 2026 23:30:35 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:34 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:40 +0530
Subject: [PATCH v8 04/12] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-4-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=3955;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=xu0XPQQrGgIcADZXkcWURUAsf1MnYM7xyMfECG6R4iY=;
 b=bhxQGFLqPTHgIUNF7liZjSwOjDJVrophzNwIhKAIt7mP8Rj0AmnNn/j2fvNMuvpvvrPzTfDor
 Ok9eX9jBxT6DBvC+J8JzDCx4VCOhGvpkppCPigyec28OnF9HI+6Q93O
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX0rcLJzUTWUFB
 8PQx65RdOChWDyFsH70LMw/EOOM4vwN9x4HRDQMxSHdcBZi9XTDbQiN+u1+jGXyhYBQ2XP9A/xt
 ko92uLnz/cZDSannfNaK9fG2cGh6zFcqSdR8I4HGM8cMPGCwTQ7CYQbYuMh3C4OEtxdyEzfj6Q+
 PhNndhj1tZ4YMbDphfwkxKxHUv8cbgrpxOUr9AX6seT97rAxl3gdY/0VR88fRAZs/izQvNlKUK1
 zTYdXA0AgFSAg0SheTZ9BpI/bv3OquPmkEZZaPl0b4QSUBi+vCFTakh81vNl7U9ldvHHGPq9rjq
 HyjnF29ypqx5UEtPCAYf5ZbTIpn/STy1GL6Hd/Bf1/nP+PrPmGJbqtdqdQGRM0dtEgMtWxbREFC
 qGS4N1r6kkGB+FXre7UwtNNckTE66tV6DnLX43oSSFqBwoULuIaYXoXpeI/r8hQTrdFnslKMdA6
 NH3nLHgii0DzrBQnQ3A==
X-Proofpoint-ORIG-GUID: 0e47MRiEPgJonvVECm-gr3K8lvz5RlIZ
X-Proofpoint-GUID: 0e47MRiEPgJonvVECm-gr3K8lvz5RlIZ
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a29048c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZwZBACt1qYONU4SPBGcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100059

The glymur platform requires a dedicated firmware context bank device to
boot firmware where linux runs as the hypervisor and driver needs to
manually manage the firmware IOMMU mapping.

Add init and deinit hooks in the vpu ops for context bank setup. These
hooks allow platform specific code to initialize and tear down context
banks.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_core.c       |  9 ++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 14 ++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  4 ++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
index 52bf56e517f9..89dbe9bbf6b0 100644
--- a/drivers/media/platform/qcom/iris/iris_core.c
+++ b/drivers/media/platform/qcom/iris/iris_core.c
@@ -19,6 +19,7 @@ void iris_core_deinit(struct iris_core *core)
 		iris_fw_unload(core);
 		iris_vpu_power_off(core);
 		iris_hfi_queues_deinit(core);
+		iris_deinit_cb_devs(core);
 		core->state = IRIS_CORE_DEINIT;
 	}
 	mutex_unlock(&core->lock);
@@ -58,10 +59,14 @@ int iris_core_init(struct iris_core *core)
 
 	core->state = IRIS_CORE_INIT;
 
-	ret = iris_hfi_queues_init(core);
+	ret = iris_init_cb_devs(core);
 	if (ret)
 		goto error;
 
+	ret = iris_hfi_queues_init(core);
+	if (ret)
+		goto error_deinit_cb_devs;
+
 	ret = iris_vpu_power_on(core);
 	if (ret)
 		goto error_queue_deinit;
@@ -94,6 +99,8 @@ int iris_core_init(struct iris_core *core)
 	iris_vpu_power_off(core);
 error_queue_deinit:
 	iris_hfi_queues_deinit(core);
+error_deinit_cb_devs:
+	iris_deinit_cb_devs(core);
 error:
 	core->state = IRIS_CORE_DEINIT;
 exit:
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index ab41da1f47c8..8bdfee672954 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -319,6 +319,20 @@ int iris_vpu_switch_to_hwmode(struct iris_core *core)
 	return core->iris_platform_data->vpu_ops->set_hwmode(core);
 }
 
+int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->init_cb_devs)
+		return core->iris_platform_data->vpu_ops->init_cb_devs(core);
+
+	return 0;
+}
+
+void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->vpu_ops->deinit_cb_devs)
+		core->iris_platform_data->vpu_ops->deinit_cb_devs(core);
+}
+
 int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
 {
 	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 09799a375c14..e0dc109bbe6a 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -22,6 +22,8 @@ struct vpu_ops {
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 	int (*set_hwmode)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);
@@ -33,6 +35,8 @@ int iris_vpu_power_on_controller(struct iris_core *core);
 int iris_vpu_power_on_hw(struct iris_core *core);
 int iris_vpu_set_hwmode(struct iris_core *core);
 int iris_vpu_switch_to_hwmode(struct iris_core *core);
+int iris_init_cb_devs(struct iris_core *core);
+void iris_deinit_cb_devs(struct iris_core *core);
 int iris_vpu_power_on(struct iris_core *core);
 int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);

-- 
2.34.1

