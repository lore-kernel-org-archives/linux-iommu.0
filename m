Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F73E1CF3
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934869; cv=none; b=stWHiVsTdLzt2unOulH1h8FhpG15onYlNnk/2xr0kBwZI0sOo4D/SVHKAi3Yx3PF5p6Bl5fEmCHAV5LLJgQc2AjMhh2KeoN5uskxBTO7NTLRVFlz66BeR9YhpkYN16KOKmWEDH0RteXl7IQ+HCjlhrnX605QmfDos6XDOnM0qIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934869; c=relaxed/simple;
	bh=TpMlPRysp3w2m+ZFi+sTeXE10yR8wAdZPz/OYCwHJZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQ2nPzk2o+PcIZH03Mquy5kbJ4nR4RYlFShdpzQAoD9NFx9+6H0bJPeLRGM7JeN4p2A+lUEs/sgf/daRc09fXioivuqPenqDCDeao1rNYlzIBcNOQWBBG9gxcKWjhHfJMqHzCxny4M4RTliiCj0fQfOuje8ci5esRi8m3DShVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THkNH11J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4Uggfbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="THkNH11J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4Uggfbc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G4eMVn002789
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tMlahfmEth5dlLQRNO21reZ980LZhICbYSjGZLVRpM=; b=THkNH11JahRpcOQh
	cgkOrfRZ1nJ+n25nkWnaibToFf0oA+EAifIhnxO6Z3clJmVte+16rNYY6B71rEDk
	rEalt+HaLjbzvJsdOVg+KWNxw4q2QPa/fd8SjbrTOaotR/9m5mb7IoQrKaPpUuao
	otv0eTHg4hCexmnDuuQxTmOYPWaHEQ4Oj07yrRePtHwAe+4GMnQjzePEFnqB8IqB
	jKoYGHAMs/RlOwawWTZg2gyAO2ftmRS+PB+VR+U6gXuAqV1+bey0xqgE3t/du8Zo
	W3s2QNkmbZyXt3qiJ1T2vdqYJ+nd+FodzmhLo741Izch9T7opqkxdh8SJSHYuO4Y
	FTSJQg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hrggr55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso494292b3a.3
        for <iommu@lists.linux.dev>; Sat, 16 May 2026 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778934867; x=1779539667; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tMlahfmEth5dlLQRNO21reZ980LZhICbYSjGZLVRpM=;
        b=Q4UggfbcBzm1tojQMFzf/waFrO64WtpxruY3x78dbdBYXbP+AkM8fFwUR268abLvBq
         hqokCZNg9NOFFfQtkKG/mBnVfOf91xyR1HDClhlhU7pJpiUI9oejmvPJh9gSu7SeeTwL
         Y6wO4pyuxmphY7foIk2Rs9xE+G9AwiHYeFpqJa3lSO2hByCppgml0yc4yVapXtMQCvBF
         95mc1oSz+WWT23NAQJ3XATFY5TYcRTcon0Ygky4cXMwTUVF/BNGv0771Mg6qkTCNIM1o
         k3ONAkDGOGCfKT/5tODeG6qOU5KfwkPyelBsLAeCZF3PLdr2ICqH1Y7IXOEo2NwsnSZs
         BERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778934867; x=1779539667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tMlahfmEth5dlLQRNO21reZ980LZhICbYSjGZLVRpM=;
        b=IUdJNy2+ewnP0v6pMrgSwihnsTW2iGXU6Ol7Cp5GuTNLzVEJso8HzhAx5BKKQwO23m
         C+SRahEZYi1s/XnO9zA3hZWn+ggAoWj2A7SXKCH6/wAtAcxCrRJG/RByEWCNak9MNocC
         SXz/WEYceHY6dxWQAzFHkGS+kXDyETcbwRoAzz7YYKVlL4OEzunB80iiRWXnUF01yWoY
         uDX5EBFBAH/b6jbG8CG3ftVBF+l/5nRvdNTYgg2tcRSgFHtMUwU2xSC7jDhSQgwyJAXW
         1yXugzakGQQQHHf3db0E8arCGVuHT/KxoyXoYS6MNvnJYTEItq/W79NRjQlJ73JIsTJs
         2LnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Juwjp/2edJi+s7vKd7h2AzquCMvrNbfEvAK8s/fTdgHbsmk2AjIlt1MPs970zTYEIbsMiPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQB1iFF1TTl8LPZrX89bN/6KLCSnFAdXXXSa22HxQOa0XYMK2p
	jjlIfxiUXI6DNFw1SMpoYTeUvuKmnxQ5PMJS3h0e068zr1EUGJCslPBPSZxqFo9DXM835EyH9o6
	WuharXqJLuyCuw6bGggpGtlNhJ77RTMIsren2TDQlU9nCPCayEOYZEYTMyw==
X-Gm-Gg: Acq92OGfrh2PX9S1xQyE/6sYGCg8qaXemvtt8dTLsl/QFgWlaSVSHEv9w8XZOVFwF23
	u76VIwQVuuDLrb6E4viXjoZiLse4AxlF21EK5CxWWPPNHOoqSxa4KLXPOGucZyDuwavAmpbwBeW
	dw6BDpE7YMbOH8BnswkI/1agTdzR5LMLPiGdnsBSG0dqxcmmMtFJlBnpVedAMx5Z1NrIKOJvOT2
	fUT73FUpamxd8nRCpterdeFqWFgSlhf2d53gHzDn2Jux5XXV0caQ9yfH0C/QDkIUhKCZmgaOE6Z
	DTj2X452cISH+4qD9RkX9mOxjdmKOWj6Ygmg7Ah98YEdIOVnEFgKFgk4OOf0YxtrvABMAljiPob
	0n1UrhTsd/FaCsUQIDMXZaumzMg+i2tZo0jjmTjGKuPdTBhM4MeEp
X-Received: by 2002:a05:6a00:950f:b0:83e:6fde:54d3 with SMTP id d2e1a72fcca58-83f33f3d3f0mr7854670b3a.50.1778934866919;
        Sat, 16 May 2026 05:34:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:83e:6fde:54d3 with SMTP id d2e1a72fcca58-83f33f3d3f0mr7854653b3a.50.1778934866433;
        Sat, 16 May 2026 05:34:26 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm11405217b3a.53.2026.05.16.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:34:26 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Sat, 16 May 2026 18:04:04 +0530
Subject: [PATCH 2/2] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-smmu_interconnect_addition-v1-2-f889d933f5c1@oss.qualcomm.com>
References: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
In-Reply-To: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778934854; l=5165;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=TpMlPRysp3w2m+ZFi+sTeXE10yR8wAdZPz/OYCwHJZo=;
 b=yVvi3RjY40p22B42QDBaFIBVse8JGLs/A7douwNNONNIVhxQTgPq6cRhjnRT3p7MvcZ1o11+A
 IheV8q200YLDw6+xJEkE07G/1km2pLjSR1EpkJSR7EqLt4cgHI3mTcP
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-GUID: j8K8_bQYl9FElHa_RRbTJVrIsJZ2pFdV
X-Authority-Analysis: v=2.4 cv=ApLeGu9P c=1 sm=1 tr=0 ts=6a086453 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=taUV0mOn9u7JAoyayg0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: j8K8_bQYl9FElHa_RRbTJVrIsJZ2pFdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDEyMyBTYWx0ZWRfXz4CtTD/6mpn/
 GX6pE2mN7Q5xLcgQlbZUiExhf0M+eakUfPoldy0B5XqjXGJMqSYGgKcsau89qwhHFrusixWF4t4
 uFGCYYPrIMgiWItrIGAjEHZA/keqz5YGMyDuUfgLdvDutFrY4LN1AIwmHDzp/jFzm/xBLE4M2ak
 zrGoYG8biI83Yk4MQzrsZdY7BWVjCN6XhKvn7OJr/9fdwCoo9n1KGkLDBmistQ4UO1jbnxLuVN5
 M+VYw12oAgTsXvMNXj3HldkSzPvAPpUSgllX6Uqwx+vT/zgNR0zvZ3zG/cwSCSA69thhfcX8VCA
 kiTo/hQ1H7rvre41lNHD83kt8gsM+7PTYBPiVJQZnW16zO9VhfAHIeJnn0m4FCzyGss2sWg+L5D
 tdcRTLfzXUxyG48rBywRdNGKCmokt+ptgBZb88Iv9uPH8KuC5Mj296PWVFb2kB0VKhcVoEJ8iKp
 jBWd7IZUKdCqddI7EfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160123

On some SoCs the SMMU registers require an active interconnect
bandwidth vote to be accessible. While other clients typically
satisfy this requirement implicitly, certain corner cases (e.g.
during sleep/wakeup transitions) can leave the SMMU without a
vote, causing intermittent register access failures.

Add support for an optional interconnect path to the arm-smmu
driver and vote for bandwidth while the SMMU is active. The path
is acquired from DT if present and ignored otherwise.

The bandwidth vote is enabled before accessing SMMU registers
during probe and runtime resume, and released during runtime
suspend and on error paths.

Generally, from an architectural perspective, GEM_NOC and DDR are
expected to have an active vote whenever the adreno_smmu block is
powered on. In most common use cases, this requirement is implicitly
satisfied because other GPU-related clients (for example, the GMU
device) already hold a GEM_NOC vote when adreno_smmu is enabled.

However, there are certain corner cases, such as during sleep/wakeup
transitions, where the GEM_NOC vote can be removed before adreno_smmu
is powered down. If adreno_smmu is then accessed while the interconnect
vote is missing, it can lead to the observed failures. Because of the
precise ordering involved, this scenario is difficult to reproduce
consistently.
(also GDSC is involved in adreno usecases can have an independent vote)

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 ++++++++++++++++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..aedf5edf8f9b2b75f80a61af66727b52a5b3ad49 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -53,6 +53,11 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+/* Interconnect bandwidth vote values for the SMMU register access path */
+#define ARM_SMMU_ICC_AVG_BW		0
+#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
+#define ARM_SMMU_ICC_PEAK_BW_LOW	0
+
 static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
@@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 	}
 }
 
+static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
+{
+	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
+	if (IS_ERR(smmu->icc_path)) {
+		int err = PTR_ERR(smmu->icc_path);
+
+		if (err == -ENODATA) {
+			smmu->icc_path = NULL;
+			return 0;
+		}
+		return dev_err_probe(smmu->dev, err,
+				     "failed to get interconnect path\n");
+	}
+	return 0;
+}
+
+static void arm_smmu_icc_enable(struct arm_smmu_device *smmu)
+{
+	if (smmu->icc_path)
+		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
+				   ARM_SMMU_ICC_PEAK_BW_HIGH));
+}
+
+static void arm_smmu_icc_disable(struct arm_smmu_device *smmu)
+{
+	if (smmu->icc_path)
+		WARN_ON(icc_set_bw(smmu->icc_path, ARM_SMMU_ICC_AVG_BW,
+				   ARM_SMMU_ICC_PEAK_BW_LOW));
+}
+
 static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
 {
 	/*
@@ -2189,6 +2224,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/*
+	 * Acquire and vote the interconnect path before accessing any SMMU
+	 * registers (including ARM_SMMU_GR0_ID0 in arm_smmu_device_cfg_probe).
+	 */
+	err = arm_smmu_icc_get(smmu);
+	if (err) {
+		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+		return err;
+	}
+	arm_smmu_icc_enable(smmu);
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2294,9 +2340,13 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	int ret;
 
+	arm_smmu_icc_enable(smmu);
+
 	ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
-	if (ret)
+	if (ret) {
+		arm_smmu_icc_disable(smmu);
 		return ret;
+	}
 
 	arm_smmu_device_reset(smmu);
 
@@ -2308,6 +2358,7 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
 	clk_bulk_disable(smmu->num_clks, smmu->clks);
+	arm_smmu_icc_disable(smmu);
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 26d2e33cd328b8278888585fc07a31485d9397e2..c00606a416b2f4bb44a35e5d67f6ef801df68e1c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -15,6 +15,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
@@ -335,6 +336,7 @@ struct arm_smmu_device {
 	int				num_clks;
 	unsigned int			*irqs;
 	struct clk_bulk_data		*clks;
+	struct icc_path			*icc_path;
 
 	spinlock_t			global_sync_lock;
 

-- 
2.34.1

