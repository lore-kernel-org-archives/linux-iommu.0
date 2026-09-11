Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDC3D6CD8
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165554; cv=none; b=uA13DdmhuxOBSNTfbjFTNb9P2gSHYASLQEjaXLdQ0JZ7jH7uEzJ47CiHptMyYfqKv9gAG215P2e9a5IP0BJDzyKk9xmKFrAGJhOy4WEESwl1vHCLhs2SuZY3KaC1sUC4qyCnerptYH393OBUIlm8u+aggQNWVyqW7YaDuQNXxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165554; c=relaxed/simple;
	bh=ZL2A2cFHlRhAKSuQ9oyrYwVIfm2ZzCci0b8JvPtYKrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uS8MS4wT+xKdF9w1slJe/1vwSzsassJofVCjb93qY/vjVs0IEaQjpejHOXGLlqb5X1Ehw7xNW2IVyhZRi7NkdNxDcFw/IAHbeQ0GmyOAM38kcTtEpz3ymkG6QnqSOZb7NIjkt9+CFRyAaPGfu3JI9d/LKfeLW20Fro7FTuq5NC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nz4fFmc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W2chY7mS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nz4fFmc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2chY7mS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWBjp809371
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 22:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zrkXTFmlVQPcnpPC8U/nG2
	oDFHYiPrW26FCuVN6FIbM=; b=Nz4fFmc+3q+4nYFt4RGFkV8rHsuq9n7y0j/sT9
	6RBjPxeI7LETEmQx0wMaKjK5zN9HbHV3qWtGgXdaQweVtAvJkoy4jfQfBPurC9OE
	D4TGEi930v87yr864sGf8EI6Q/b8ssQ3er447C2YMnr6PoLar8y6GbBe2vUWIBZd
	U56U7UP7axarq8JU/UwW12/Hl84C2Fv5RAhwkmxmaCUBAo3PVdTWR64T0ZCuodKv
	xUcth9ZfBDiqv14PkaEVnDycK8PVEVVrGSCQNCLXi2gtaEZtiGZisYXhOO2jatss
	ZvV32ym29jvOUiMKwHMtmnzqPov8GqH/aWsI+9SAzEZ+XJlA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmnv212fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 22:25:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso1328755a12.1
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789165547; x=1789770347; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zrkXTFmlVQPcnpPC8U/nG2oDFHYiPrW26FCuVN6FIbM=;
        b=W2chY7mSNtSr63dSkBatpql4ggzbA0N/AUfNHL5J0TVO56zKFZrGt6h9BzIJKmFwe+
         mDiWd/54O+odLy5opuZQVoFRUpXoUyDDdJbE0jEkKMtSpgNmmFR1bnez8PIgt3YNFfa8
         TtWGH6EXlZQ4hdGKOlm+HUXmSQ8aTFXENor3m1qD72gLGJJD8vlhToQqyhhJCDABbNpf
         UVF/W6dadwThiX+s4LR8iO0OjpWNA8IS+eFKEaTU9+NuU9/btB+k6RpZajjsXqzZawLT
         ZOKPsFu96csDynJenszkgHaz9aHq4uMW91sDAIkFhlHf8u697Xwoei4EsDYMhIRyw72h
         +Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165547; x=1789770347;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zrkXTFmlVQPcnpPC8U/nG2oDFHYiPrW26FCuVN6FIbM=;
        b=Nx+VGsncgPwijQqRYAY2R0foyMf3Ul1d/9jhw9lmtR02ZzQYQmJ1BVkw6ezdNv7dhb
         NSEu07wNagNk2rpjvsqYhUmyVsVun+iCHWgH79+82h2ToqNudBwxscG81YAR6kEZZbNV
         4H2K6yWrWMfk052xGNBQsis83vVsCp8QpYpjjSgOlkxrl773sIuCftWl3jhwO82uQAyU
         hMYT/kZDOZukUYT+kXIeaWRLBoIQCeJVGFPcK1poTHTlBzyiaVIGVAm1KIdqFf93Id7Y
         8Opnx0AzUwWhCkYrArywSupq4TrLzPDVZyvYwwnbddaKXg4Yd0O2+9a90ufB330wasKc
         gcDg==
X-Gm-Message-State: AFuF++my7pR6ADv2WBeQk8JwyycQvwuyLB2yjwPjfqCTWB/SlzdbyrQt
	PSQYbFF86Nd7n/0t1E9iP14pIumksgbLHQ/+eJ6/SPpvqpVLpwI+5FcjgaGI7Prw+cxh66rCHJc
	yEL52Eho0y8wBys82hbV4TdbJrMntnAzBvMWNjsHRV+UL+vX4JBL9irG2Gg==
X-Gm-Gg: AYBFou2gJ5zpH8HGHhSyABR7f4aHzMYXCfNmEI550Gp1t4czARQWO0YIuyXwtso5uKa
	tE1tqd2E01R+z2tu8Qpz3/zewFhU9cYj6EzcdsZnsydBqeDLpavAaMnPZOMzVyoVaWPglfRdTSr
	C9Tbx8DKdNBQb5qCc0tm3Zl8JJz3DuHRHOxm4WVnmJI2YgEQH3MoI4cvLKztDlkGENMJjSdvsj/
	PvK3q5mnW0RT4gOXLhwVO1+6A/Cb5J19wd7hG2VJNB55cFfKCgkJPDQMhcBzf/DWWZ1blI5PJVg
	YXlUsIMUkZMzCIJWf1GPMA5zJveEnrL5M343GtwnXBiTVUQZkIjgMpFD7hx2IXhrKwfSz0KbE5c
	i/ql+Fit2oJhgRD+H2x6oQmmEPQyVniI=
X-Received: by 2002:a05:6a21:138e:b0:3d3:b00a:7082 with SMTP id adf61e73a8af0-3db0e48256bmr382364637.28.1789165546947;
        Fri, 11 Sep 2026 15:25:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:138e:b0:3d3:b00a:7082 with SMTP id adf61e73a8af0-3db0e48256bmr382332637.28.1789165546468;
        Fri, 11 Sep 2026 15:25:46 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f739b5sm9213321eec.25.2026.09.11.15.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:25:45 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 03:55:38 +0530
Subject: [PATCH] iommu: arm-smmu-qcom: Skip fault-info reads when suspended
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-priv_call_runtime_handlers-v1-1-fc0c3a17523f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOF/pGoC/yXMQQqDMBBA0avIrA3EGCt6FZFg49hOiVFmVAri3
 Zu2yweff4IgEwq02QmMBwktMaHIM/DPIT5Q0ZgMRpubbgqjVqbD+SEEx3vcaEaXsjEgi6qnsrJ
 1Za22GtJgZZzo/Zt3/d+y31/ot+8RrusDGsMagn4AAAA=
X-Change-ID: 20260912-priv_call_runtime_handlers-7f3547544040
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789165542; l=3706;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=ZL2A2cFHlRhAKSuQ9oyrYwVIfm2ZzCci0b8JvPtYKrc=;
 b=wtl28Fbdd6qYisueH5Nk753b3YTVUJyX0jmUcgObLW99BpkEMzkerPCmXfpJNlpCsF2blsOhf
 aSlOmE9xVBnB3e3iXcUCRaQvOyaulsDfn9heSVcHUyAhbNIgn7IHefe
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMxNyBTYWx0ZWRfX3aBhxI5WfGWT
 1blXiFzhP3USLSGeGGvBVAbXNEzx07+YAxIpKn161EN8mflyDqRPKGTPbZfxi5pgJOP/usOOSyV
 ZycHRmlKMzmxIPBK5mjwxvf7KOriKIs=
X-Proofpoint-GUID: X6hzwFr2wqjBzJKJWhV_zb43ExxReAUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMxNyBTYWx0ZWRfX6cfJt2c+wgoX
 FG61pmjJ4qXSS8QSakJuiU/JvnJ5++AcKV+KTMw0Oaege5Iw0KuDPnfzkXc6BfhNfp3i6P/Qtwy
 mq/jAG/1Ih+W96UPRgFVF4vfj/bWYQtbioM4ycoWQCf8CLnwSahoOBX4ggoDRStBISVUm0cMKXF
 YKoQ89FbSt7cLhBU1xjZpJ78Xg7rTqCzwmjWv9gipJNOPpf5WQc12gMu+aZcLgsTF88YXlGzYWv
 eU2C8VI8CoPLGRcjvykRH3D2esL+68TagOy+WtBJjLT5XY2J0H/BSSE3QdI6EVHGqSGlk0xDG6B
 vueRjzsVzLKm6DWTxqCJlNUg6Ka4Ou111VDjRAT8NhqmyPk3fTzk6lxPqHM3Zsw4kS8P0ENZzKU
 EKVfo1f+wyWh/rXc8YltVEKqdC1/xdy7xoXYTC5vApMpy3bM2Ge4pqXn3W5hnSlB/wv5sJY1SB0
 i6DSKfylujCYc3dVuYw==
X-Proofpoint-ORIG-GUID: X6hzwFr2wqjBzJKJWhV_zb43ExxReAUH
X-Authority-Analysis: v=2.4 cv=XvdvqlF9 c=1 sm=1 tr=0 ts=6aa47feb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FyyklSoAK86a5T4BgM4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110317

qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
holding a runtime PM reference. A fault is raised while the SMMU is
active, but the GPU may drop its power vote before the threaded fault
handler reaches the callback, allowing the SMMU to runtime suspend.

Accessing the SMMU registers after suspend has started is unsafe and
may cause subsequent register accesses during runtime resume to fail
with a NoC error and an asynchronous SError.

Use pm_runtime_get_if_active() to keep the SMMU active while collecting
the fault information, and skip the register reads if suspend has
already started.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
qcom_adreno_smmu_get_fault_info() accesses SMMU registers without
holding a runtime PM reference. A fault is raised while the SMMU is
active, but the GPU may drop its power vote before the threaded fault
handler reaches the callback, allowing the SMMU to runtime suspend.

The failure sequence:

  GPU context fault
          |
          v
  qcom_adreno_smmu_get_fault_info()
          |
          | GPU drops its power vote
          | SMMU starts runtime suspend
          v
  SMMU register access without an active RPM reference
          |
          v
  later Adreno PRR private-interface operation
          |
          v
  pm_runtime_resume_and_get()
          |
          v
  arm_smmu_runtime_resume()
          |
          v
  arm_smmu_device_reset()
          |
          v
  SMMU register access
          |
          v
  NoC error / asynchronous SError

Use pm_runtime_get_if_active() to keep the SMMU active while collecting
the fault information. If suspend has already started, skip the register
reads instead of accessing the SMMU while it is being powered down.
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..b1787a4ba0d3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -129,6 +129,18 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
+	/*
+	 * A fault can only fire while the SMMU is active (GPU is issuing
+	 * transactions). Use get_if_active so that if by a rare race the
+	 * device has already suspended, we skip the register reads rather
+	 * than triggering a cold resume which would call device_reset and
+	 * destroy the fault state we are trying to capture.
+	 */
+	if (pm_runtime_get_if_active(smmu->dev) <= 0) {
+		dev_warn(smmu->dev, "get_fault_info: device not active, skipping\n");
+		return;
+	}
+
 	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
 	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
 	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
@@ -136,6 +148,8 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
 	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+
+	pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)

---
base-commit: f61bb3920fa8cb44b84d32e0fa9fbaab4eb00c80
change-id: 20260912-priv_call_runtime_handlers-7f3547544040

Best regards,
--  
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

