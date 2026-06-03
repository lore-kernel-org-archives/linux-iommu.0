Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD947D92D
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496445; cv=none; b=LcbH/rbjwJ31bJ9VlmCaQ2V5JAnJUy3YviSX4ytK/e1W9rZ629OeUuqJ0VAhgFX1IRqc/U1e817wAH85007Bou6O+c+PJVC7LVAcEQh8O3KvHb+u/r0k1ZyCDh2lBHEI0Y1ZDn/nepNj1FXE0MafqRhd48CbhTHpuTZPVgq/QKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496445; c=relaxed/simple;
	bh=PuMrtg0kXudsgBTKAPN0KLjJcY60dOingG5L6cBwKzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvtXrMg4mk2MhVHBOMf44x1jN/C9Sbg7YhtqsnG0ndgaP1NvVNgRW5vvMVTx8VgsZed1KLxBxQDcGkLXh4Xpo2SV4x7oDLkEz9Sbjeh0mbbhzeqlT5/opehSCpDqlp/vYcWTgp0wFjh9Zhgv7LQop55Cnw0va4xkRF2lHG3HHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeVMENjn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOzO6d7C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeVMENjn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOzO6d7C"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CZss6380669
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f3qz5dCqPWjHtxCe7c5xxtbgRMST42WBTL9nTD2Ij+s=; b=YeVMENjnBWQmrFyP
	+1uuS7BWiskrHzBkPXIuJPW1kOKQxFQ7WjoqN8LPviGbpOhcu/8ztJppoE+2Aid7
	QNxszLXYtKLQ7v//ZwEV3IxUFZeOH0fPuHfaJ1dIVk2FQoGlYBYpLu9vTZWLCb65
	YspUIqzqI4/EyGDbesz81yFtpH/tsC/IjZ85WHsSbCov6hqp4epQrEZExJKGXfxF
	XX0NU0NdpK6QKKq//HJ7nI94b1gyk5COUF8lWx26SNFoAcH/2VqEnXyBSHbNiXUa
	2+/QowN6dpnC8wmMBZHEasRcSzx2t3f0hHVwi1b1qPSrKGjsAbrZ1PExDVvu4/ZM
	lzg11A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejewhsvnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:20:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf3636d6c0so50015945ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496443; x=1781101243; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3qz5dCqPWjHtxCe7c5xxtbgRMST42WBTL9nTD2Ij+s=;
        b=TOzO6d7CU2xy8fWwuL2dqSZMdNKf1sp1R0GsCK2Q1KRw+a+lboa3nzJN3jGDEUr7xG
         QiPezkjEqKk1y7Ei4nCaBLlCk+RW5r+pswOZEz8GP+cFDlE/9bYhPRI9/JwSeCv8J+IC
         Qv4A2irnJhPCHaQ4mepjW14cz+uPbISWNVFjBEAjPZ2gtq+OKDpV5r5w0pME2SDnwzs9
         YnOGJf1fn2N8T6Neg12+0BZiRzW8f+2xbY8bhGRqdMJbAQ8LIcMKQEC6FtlVxyI0l4yw
         APVy6q9UJqm9D9wzabD3Nb6xA6JHoUphPp8XYXxeGr+UbazhGemETbP+b4gY7+8O2ebm
         1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496443; x=1781101243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f3qz5dCqPWjHtxCe7c5xxtbgRMST42WBTL9nTD2Ij+s=;
        b=WmBDu6jqEebavo+hhYoKGcWkiaWfGcGTa3OgtvT4p3azfRugEZyeLTUCV5wxNen2uO
         LtXlhGEeH3onL45AA6EMRX1Ge7D3O63eadVBb3fQK7aUWJ3Z06EQ2cBzsh4nA8QR9kRs
         DZbsRhpX35THbKnbKzFIhS+nYNIra/O7E9wGmj45P0wxuDr6QEvkqAbNPJ9+ZsY7Rl34
         om1t8qfs5pIsxXPfzh2DIKhDqY7VZHahcPAlKf0qMbmvgrdvxml5D6aS0beBSVyD++58
         7h3kM3xjWhWL/4i/ddmwTTao0daafUgfHzp86uvdlC1niy0HWB+ZHZIN5TSRLoqfEfV7
         +txQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+auaEzGGX3AoVk/PzRefa1FOevvoPvcVUO2085ipzCqS3H7NP79eKjTpR4fUUPg0f6XDShA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRmkSoREzkkZpyJEnjfizgB8SjOkawNJ+ppY1KRO7t3vThiRWB
	7Hi6XqMI110pyzjLYobxKvgY9L5e3njjkztofFK+mwIKfMxl2dHC7dtNPngDjyhLcMoDzVPkqLu
	/naHRqmMCKGVbM1gq/vzHXsWF1qKBuT2q2eMKIxZnSKpy8IcEhK84fg8BVw==
X-Gm-Gg: Acq92OHnp6gBPgVrnMUTqiuItLeDQEVxG4QmieXnmgtPsbezcePVzBoxhc/X4OSYfZj
	hxTU6dsAQmDCTTcaFGdOga9zPkm3LgxZ5C6YkCOSYEpVnkY43D9Yk9SrijinPvz32w8uSbqxTR0
	1qSXURPd+IBiVLZzV5baMLTbUJFyUob6ZmUdKUtP/nOcyvB3uUddlvWiTiSR/U6NBXTqk93T942
	TDLb9P3xD7hTTQvuia/wWY2FmSYgbZ9+UCoWUW/Ndkf0iH1sReo8HVnG5TxFEAtgWBMUh1f+9pC
	EvN6CDdXloB54iryHoTBNfUPgBe9CAebABTXSFfpsmDmSgWSPE9KOdsFar9O1p8aKIUHDTvuPQa
	Nad+vPMxJAxG/27Y5icMNW4XVmeyDHSxzNGA+f6kETwLxpaBVywCNvo5LT8F8akn3Kw==
X-Received: by 2002:a17:902:d48d:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2c163c527c5mr36692645ad.15.1780496442745;
        Wed, 03 Jun 2026 07:20:42 -0700 (PDT)
X-Received: by 2002:a17:902:d48d:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2c163c527c5mr36692235ad.15.1780496442248;
        Wed, 03 Jun 2026 07:20:42 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:20:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:42 +0530
Subject: [PATCH v7 04/12] media: iris: Add context bank hooks for platform
 specific initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-4-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=3955;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=PuMrtg0kXudsgBTKAPN0KLjJcY60dOingG5L6cBwKzg=;
 b=7JmGH5FUMoJdANbTLdv601LbY01dHrrguK95asQPYHBDW39sAXKNEk96RLOS9UnFMalL4vuw6
 Gb1VFN/2sagDYKgssxyssKQskUmJYaDOHEcwtf+LfXwXiSk115DSfu7
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfX+QuX41QyLKD/
 j8GkeIk38ZYQww0ZDERt3TsOe6MBz6bDK4U/5znIR6E3/lZizMBr9Wax2X6I1ojCZqr7Rv0zOvI
 hUaTKQj8HmuP6xZ0ejHP7O5VW3MZmde3qg+jsiIrt/FhmIuVCipetNEmg8fXcF4G8giYWHwiJ+C
 iUnpF+v+Nssi0Iue/qqGSMfN5ZinpzlZBHQLrniRh2VH2K5hhtoaI5eflh0zMXc0ZRIzkXWnYH1
 5NzU1pPNWBpWG1nSlo5QEdTzJ/mxlznUwW4BEd7v7Z8XKJP3RdGOPUMJWRNeX5vD5EqVQ0Khbg/
 n3VcBFckjPoSsypTHnmRinR1aQpNBA3/2gEAbQFS1oWIf99zUUZfz1ROFOO8bHILEJ0c1mwjhre
 4FdnYzuWSNjoOdedGi2cqRUaLT01Uw8H/lDDSPw5JdwZ2z7w9l2zWl7tHxPyeSfzGG/iY29hdYO
 nELpaRvuQFg7hPU9oJQ==
X-Authority-Analysis: v=2.4 cv=Zewt8MVA c=1 sm=1 tr=0 ts=6a20383b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZwZBACt1qYONU4SPBGcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: bAYHpjaaKkO30LDlnu3TPJmTgf21zHEw
X-Proofpoint-ORIG-GUID: bAYHpjaaKkO30LDlnu3TPJmTgf21zHEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

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
index b6acab5a8978..23a7ce3ecb2d 100644
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

