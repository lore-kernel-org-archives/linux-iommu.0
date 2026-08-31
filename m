Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD654A6CCE
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188407; cv=none; b=pdBnqOu/ftKJhUkULVmOrfxHcXk4caheR2VBGHnq2P2+dGUlTBYbFx+SDVriYhpvc0UDixivnRxWQ4LRprzcmjVYVpqdBGWiYj+jyt6RuQ85ecbY8OUJWUFVAzMjzjmVio0N9vFgrOQ3DK6Tc454OmkAI8EmIWVNRsYz3GYTV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188407; c=relaxed/simple;
	bh=6dK+l3e+dnI9ZnhfdSOfWWzT8YyCzelSdF8e2LcUoOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhbomSSmwaO/umtIX17adHevAbqcRDwgOFimHlj/gsWPbfHvW8nGBcJnVFgTCPs8l73/Kgg1Mvk3x0D76xCbQdx49KAKFxessGMlwvDlFRbOmmkInBonG+8L0jbUcKSAUc0uJF5sWMjx8hpMbJFet8ZUkL7bHQ49oqNNZiFWKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f2PLfl0T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VhWZ6HAi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2PLfl0T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VhWZ6HAi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETWUT3807953
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o07feOcyhDQ
	/W09lIWlOcU9Y+oBFCGekfKPNEriMHlQ=; b=f2PLfl0ThuPJJ5IvyzAL32bL6+z
	ebwjCRLavaKdEY2BXjjKdm3BXXokMuh7ta3Ptmm4WuWmPbdkRWTDW/uyZb3QHt9V
	/9XHRkWxEMHdlETT0rtr85PYI139lGX7dvrTN6A3w4w7LmOa5V+Yksc9MEuZid4X
	ZKOXsLulYjb+LP/XLj/aDzIS4AvZzHlblx6RrekjFZUZAnr+YoMsWmCO+N9/8Nh7
	Ppuq5UqGlMdCF+ly7bNUuXn0lcKnThL5/POhEv02xPTUepOTJJ9AnxlFJcEFQ2sY
	Mry1LnLc12RQ8K7sXbufCxX6w9zAIjOHSd/RR+lC7Svdt9V8cDfJjzrmOcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wbakd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e38fbc5so520284285a.2
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188404; x=1788793204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o07feOcyhDQ/W09lIWlOcU9Y+oBFCGekfKPNEriMHlQ=;
        b=VhWZ6HAioAHEJ0w54HBAn5E5PUQC0aU0P76taKzJycdbWY5W5lUdsL5Ad6Ku+hD5ZB
         Bn1qBbW3DqRfrjn07bTirUbcaynapTXU0qIAlI3T3FymdSbOmYmgQNyJhDJCLGP5kDF1
         EyKy/chDb0x506bFxPi4ykRsCcRNU0FV6IPO0C4gLk+usB4JURpkfKn5NMKY9ZGtVIFf
         NyAn+jYORNy3lWSksl3uEOsJFKfu5nnPJnH1wyoCPHjk+yGwUi6Dd89Kn/3ABSaxlWc/
         E0RH5639sJh+U/zdUvfmBtpwbGvi/0/VwxoLlW3VJMR7V/qVmGCX3WIuE+oh4WWEt1D3
         VIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188404; x=1788793204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o07feOcyhDQ/W09lIWlOcU9Y+oBFCGekfKPNEriMHlQ=;
        b=UpS/Uw5UcA9Xs2KIIx533g2Q4KarIbGf8LjG0px6YPY5sPkIA5tpcdP+vLHUqvTQW0
         jlUHrXkg6wul2BZ4gdW3V8cCYAZUMeO44LPe+HUT2NhsL2k2TKcLP6vrpqvITJOBYRH7
         ZLoUbiLDdDdwymxjomqNjwyrHaN2zhjhauqmvW8lFXA7BAT9Q9p5iR994Yqktso4kZFr
         nD5r0Q1uKQR21MQu8KUViT8lyQ5r1DC+QW1gSy0ssJHJ0FqeJShUFKLSdR/J2d3qUlE/
         qG05fHt4XRxeLAihdVyu5UwlV0bXbcVbs/48NXmOUfQENMJXauEJqVgUpdh5tdbjKpwY
         eQhg==
X-Forwarded-Encrypted: i=1; AHgh+RpgAnJpSF5wDkhAMfOccf15EjSiJMrwHhczebW8SpCGT2h30iDngjHIiwiGFsH3tau3mQ8rtw==@lists.linux.dev
X-Gm-Message-State: AFuF++n76QB9RUoyiGi8dgoI1Ovm++zRWBIeVajGhSSsJicKC9lTk3sX
	QmUa0h4YKg1+EEJUurEwwAgIBivQTGUj3M7/oldqRmUGzeG472VOK0NdrNN5QM/XXgyD0Puixzm
	6+uWg3uofQtsMz4e325he+My3HqlsIdh5urOszAW+1TulHZEOFSwcTkLgow==
X-Gm-Gg: AR+sD13UcmOMR0ZyOVs4soMgsgpcx1Xm3Ht9Ywbe81Z9NBZCYYBwHPsVHXy7N7MoFe5
	OQafzM5hhTx35rXFkenlgbe6DAGUflHFq7a4L0zqTr2A3nKgdvdVQKTY4rxcXhJkwf3yRkJ6Uwi
	xY7Uf2lROkRiUeIPPNLaqCaU8vmKN35/mkBaPtzfeYMShr3PUx9WszwExSFd4dYIfej0kJQUXdx
	4MVHx5mQdwE3eYTSuwBuAo63UOt2TsqB3HNItyw0QJnz4sgrADRb5cjOXy+NFhZioFdjZC5gC2X
	HUreG8DjF6+L6EzMjOXbfmnfl5eXnUw4RSbLkRka4nrdvXmnRjkGMQKvfNtEpgBae+UBT9Z8oY5
	34noStGIm+Amu/0BAsoTGx0nQeL2AojeuDjE=
X-Received: by 2002:a05:620a:2807:b0:939:4209:d5ff with SMTP id af79cd13be357-939480f8988mr221161185a.33.1788188403904;
        Mon, 31 Aug 2026 08:00:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2807:b0:939:4209:d5ff with SMTP id af79cd13be357-939480f8988mr221146685a.33.1788188403218;
        Mon, 31 Aug 2026 08:00:03 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b90f78244sm333359565e9.10.2026.08.31.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 11/17] irqchip/riscv-imsic: Add S-mode MSI address list
Date: Mon, 31 Aug 2026 16:59:37 +0200
Message-ID: <20260831145943.313726-12-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9596f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=yikt5F2n8VKCXyCzpw0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXzvTdsF+QJASp
 DGLHTR8OqCrLTcyx8T2mHUKEecgNyF6aMxwxuI8Eh2jc67Qc/WrniiCNZcIJ2azrVngCbNJokWz
 r0aXWMaTvu8yfp6RWpB9HqFpt/Ee8ig=
X-Proofpoint-ORIG-GUID: BEj7gb9bqh7KvtkmXBacNV9uewUdbVwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX3RCItDLrhA9w
 AdtZkXCDeTRX1LgTibIuOgn2255sCyyEo9Gc7LSoX5ViusET3BtG9I5Q7enhN0RVhajYauZlrqz
 QlRl1h1fjmMORiOQaL/YNQ1P2GjWSIgjvmpOV+VRHK6+KcarHHf2hIGpXeBE89M1DBrlu6INUMY
 0I7ZIDXyZC5nniU6E5Ys7bU93UiPrZ6iXrU7vsRFz5H74AJhFdqBdGsmuFE7tg7sA9uGtPM59a+
 b2A/hTLeCrykleO4rjzyM2vb8a/KHEHvSgoizGX2G6bcscvydd7hWsmUH3qx3qmilcjZu2ua+wC
 pkax7vD/HJt4n7H7FWbOKbSzPYHwiNDypE1AVLzjmWUkiTMLovV/BTV+n5Q7nvobTy4tnOy6GgJ
 UfdPxGt2kzyoyKoy4Asas5nYrjYyMDLOduO/QV4zcW7jVNQWG97ovOMxKTKzl5TPmGbCcUDf2at
 4eYJad8+j9YNhNLIJUA==
X-Proofpoint-GUID: BEj7gb9bqh7KvtkmXBacNV9uewUdbVwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310129

Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
host IMSIC target into one contiguous MSI IOVA range. MSI message
composition then uses the target CPU's position within that range.

Build an S-mode IMSIC physical address array indexed by logical CPU.
Require every possible CPU to have an initialized IMSIC page before
publishing the array. This preserves physical address zero as a valid
target and guarantees the array has num_possible_cpus() entries.

The array size and each target's index can therefore be derived
directly, without storing duplicate count or per-CPU index metadata.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index df38a7670a89..c7ebddd308ec 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -709,6 +709,31 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
 
+static int __init imsic_init_smode_msi_pa(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+	phys_addr_t *smode_msi_pa;
+	unsigned int cpu;
+
+	smode_msi_pa = kcalloc(num_possible_cpus(), sizeof(*smode_msi_pa), GFP_KERNEL);
+	if (!smode_msi_pa)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
+
+		if (!local->msi_va) {
+			kfree(smode_msi_pa);
+			return -ENODEV;
+		}
+
+		smode_msi_pa[cpu] = local->msi_pa;
+	}
+
+	imsic->smode_msi_pa = smode_msi_pa;
+	return 0;
+}
+
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
@@ -959,6 +984,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		goto out_local_cleanup;
 	}
 
+	rc = imsic_init_smode_msi_pa();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize S-mode MSI addresses\n", fwnode);
+		goto out_local_cleanup;
+	}
+
 	/* Initialize matrix allocator */
 	rc = imsic_matrix_init();
 	if (rc) {
@@ -984,6 +1015,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 out_free_local:
 	free_percpu(imsic->global.local);
 out_free_priv:
+	kfree(imsic->smode_msi_pa);
 	kfree(imsic);
 	imsic = NULL;
 	return rc;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index c42ee180b305..11352f14e32d 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -49,6 +49,7 @@ struct imsic_priv {
 
 	/* Global configuration common for all HARTs */
 	struct imsic_global_config		global;
+	phys_addr_t				*smode_msi_pa;
 
 	/* Per-CPU state */
 	struct imsic_local_priv __percpu	*lpriv;
-- 
2.43.0

