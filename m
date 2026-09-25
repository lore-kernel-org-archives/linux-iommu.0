Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0B4BB7E3
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349453; cv=none; b=L+pyTeg2yQ2Z+MpOqzvJWlsGSyQfXtf1vmDy5u932DPzR2xj3S3jQ8V348VmQDR65bdLrNzH6zN6VL4ubsH9VAztpnysRlzfuHtqnxTcQt90JtNNGbbf7MqXTK76x7x2CZgV9Ty8V2j0pNnuqeiYSi67Nfzt6JxlkQLp/HjG8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349453; c=relaxed/simple;
	bh=7x194x6TKEYCzCkZ7SStghnb1PURNJmy8La0/uO/lGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/ZyuFSZFxb7Tb1Y6fTMdzWIHzihP60pOiYjwTUb+vEaSSxpw37za4QXQlcrRkh+dGGk7ZRU5CC39m5DCQKTUtDHInPP50e3UarnO+FmszGDFnazzsClPP1E+GydNOELIE3K96AmZSgZmK+AhIb43IsiZawdD4yh6ZiuDGLnCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cNGXHcQf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EW5b6fyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cNGXHcQf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EW5b6fyh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PCvxxB2911624
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=33RzoCUEUyB
	HwJoR1huHVUdUqsyeuuhOe1aSU0G4auc=; b=cNGXHcQfdJsS88Ah/zsvnLA3/qh
	Zk8IZVgtp/UzxegFgc/lssjOiYDUP7oWc5QEq7ynMc7oZDTTJzIR/KKICSQWWMnL
	XTUL3bu4eyEgF8U7cT9G6RR1Lrm6TTigTKCkWxRpThyZ0cDUTOKem/2qKf4M64VI
	TfN8RWrSPJao/LVLHTGCRKqBPvpZlDnB7aYe+5KEiDcLr7ED42DPKKJXVEdNDzhA
	JKNoy8lOosP2bYUASl75qeQh0LbUw78/Hf9tmSJ7FPXv6FY5lJnnV1Iw8GXTTbAC
	wjXtzxjbrFTBtmP5df1qYCFF84Q8K/vRngw75XgMmF8etHsDflMiuqFnryQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm523q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:23 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98537d1242aso918120241.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349442; x=1790954242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33RzoCUEUyBHwJoR1huHVUdUqsyeuuhOe1aSU0G4auc=;
        b=EW5b6fyhJ/5ONDrgqI4E6IP3fv05AL2GettAZXIpqO/zaCwT6ZXx3ogEKocKGBXULC
         bXlAQy6KtFBkcKAWHv9eEUwAoPFSv6io1z5E4NAln/3HjIKWc5D+u7QzE+nwAdYWu/Fw
         rHQ7QuUF08cWzH2WrB93V1wsnGAszOciw42+sKmh8membIT8pe1UkUI2YQE0Hx8lWjg+
         jZ0Zra0Rep0t9IB4UcfzI2jhN0Nrmdixqn8caBYEMrZHrBvv+8pJ1rIybLHrzMVqtEKa
         G+EHuqf6u0MhWX999jFPqjV8Nm21B8Lp+jciq860qEORfn3e+GE8ZTfLNyp/r9VtUI0r
         Fx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349442; x=1790954242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=33RzoCUEUyBHwJoR1huHVUdUqsyeuuhOe1aSU0G4auc=;
        b=YlrDKnOS2Spqujq3ZxZ1aVddBZI4mOfjjuYevqle+C+XecGYS/sv7YFwVdWkqx0vTb
         IUnQFGFQh7CluwnSMEuZIUSOW6JL9J78TwFn+eBsgQ7EN0QM7zW3qPNXmZDgWyqaxBG7
         U9jz295vZrOp8y2Ztk/lPck6vYDwwm0HEluwVh67OW6c6HKoefrU4u/lK8Swv+/332H6
         UDQfxmVo2YEJDrJWWOkLayCvWFwBFzAkE1wtQaEqsiBVFBQJeuq88y/HijRbBfUaxl5B
         uxgJoey6c3uWZzRVpoF13f3P6ZTjqjJinpvIb5yEhvtOsNAXb9HVK3BPBfRf7Ht+gZxq
         ewXA==
X-Forwarded-Encrypted: i=1; AKwUvBxUuK3ASzXAjWsp6WtkKw+2+Bm9cpX9PzfR/mRy+Ew9VrsnqF+FE3wgmWn7OvZp28A6kSzA4w==@lists.linux.dev
X-Gm-Message-State: AFuF++lbOZNdlFqvRqLEPKefwUgSen+J5ln6zUHRlfZbEmd3lrFQ01C/
	XeEpCyKiwZZLYBlN0WH2BI/L4E3xCmUo/qiS1b/JH2egNtzIfDpzlXxGNfyyw1/jGclzfb0zUHB
	fzcl6XR4Ay2tu4m7EK9yT1j/7Q9AHHfVzoesIzStnwZaxPfBcj/FydoaroA==
X-Gm-Gg: AYBFou1QfZ2Qki9nnrudUBkW4UYy6E59OfjZ0tjN9AerVxfHHOTvEvfy4vtcz9l2xmW
	7xbGnXZLdPM7JuPY2/CJO2L/y1F99C54QGN9kZmEZKK6LgexGps+yxeX8yJ4k8m1TuIO7ssZeIQ
	HgbaalwXqRPGstI+iwM0w7BP+boINhIn9wzYAOauELxxQXXAiTUNAKMACNAsL+xE20KLZaqqhcD
	16pCGcYh4UmY9M6LeyYLYG+/fNUmCxi5D3VWAB/vIexijh/K/G5LikfyivK3Ca8cpb1a+y+jWQx
	qdNpPqRrA2lFLmmZFYmDdEN9Pyt97DtLL+bJFTlVis/U34RNcHXXu/CLe3ddUIwfi2rVaEs1MY5
	U78pWVhycUkKtg9VI+xoXmZaGHpHLHrznfbGWFA==
X-Received: by 2002:a05:6102:f12:b0:7a1:4799:33eb with SMTP id ada2fe7eead31-7af1c684f67mr3145035137.5.1790349442232;
        Fri, 25 Sep 2026 08:17:22 -0700 (PDT)
X-Received: by 2002:a05:6102:f12:b0:7a1:4799:33eb with SMTP id ada2fe7eead31-7af1c684f67mr3145016137.5.1790349441793;
        Fri, 25 Sep 2026 08:17:21 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355826sm8069686f8f.18.2026.09.25.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:21 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
Date: Fri, 25 Sep 2026 17:16:53 +0200
Message-ID: <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ixtU1i75Mqr-OHeGmVcxVROiEun2fx_8
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab69083 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=iYRKoqeTzvuv0UILnrsA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX3vM9qRLt9Mpy
 LkBNZrcdAzn1X38ACFbGAG00319zbYmvtgb94mg+OJG7sNHXscXR4Q6jcxXEN9Mpg9ZxY3IDUPA
 +9caFWpdqPifv5qpbF8XusygkR963ugYDvibOd/b70pmNAiK6hHh4MNUx4132Iz8qvn12CcnNE+
 yX+c7x5Dq8c2fLtBjOBkPBtQWcXWXWqw5QqmeiLy1LInHqbyzN7kfjiURN00DhtU79txOrZWpP9
 NetEoagcwK88JpkoXzVWgdOS6bRsdNcB3RpjbhDl9GMJFYqsEFpXXGkFHjw5TWcU+KNnz2UBw/Q
 bsmBjX5IVxJMAuyag/haNiITkd0Lsj80oaI5GikK1/oZZSwemCD9nZ9t7xECqakbA3MefrLp0a3
 Ss+sGRbPHoocFuYl+anF5OHQWflwGVKNUFPsr+NilXp+mZUWCGZ5ynpPHh+otXhKPQqDDsVcE6a
 bN85slpseQjy+5GZjeg==
X-Proofpoint-ORIG-GUID: ixtU1i75Mqr-OHeGmVcxVROiEun2fx_8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXwLzhQXtvUyyY
 fQbkTp8+aHlCLu8L/PTZgtlvOPMyGLgaPMV5429rpu+R8FSVX5wLHocqJre1bn8UQz2NAmYKVMc
 dmbclCCd1fRkQGapntozGB2QejVolzk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
host IMSIC target into one contiguous MSI IOVA range. MSI message
composition then uses the target CPU's position within that range.

Build an IMSIC physical address array indexed by logical CPU.
Require every possible CPU to have an initialized IMSIC page before
publishing the array. This preserves physical address zero as a valid
target and guarantees the array has num_possible_cpus() entries.

The array size and each target's index can therefore be derived
directly, without storing duplicate count or per-CPU index metadata.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index df38a7670a89..abd1cdb640ea 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -709,6 +709,31 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
 
+static int __init imsic_init_msi_pa_list(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+	phys_addr_t *msi_pa_list;
+	unsigned int cpu;
+
+	msi_pa_list = kcalloc(num_possible_cpus(), sizeof(*msi_pa_list), GFP_KERNEL);
+	if (!msi_pa_list)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct imsic_local_config *local = per_cpu_ptr(global->local, cpu);
+
+		if (!local->msi_va) {
+			kfree(msi_pa_list);
+			return -ENODEV;
+		}
+
+		msi_pa_list[cpu] = local->msi_pa;
+	}
+
+	imsic->msi_pa_list = msi_pa_list;
+	return 0;
+}
+
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
@@ -959,6 +984,12 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 		goto out_local_cleanup;
 	}
 
+	rc = imsic_init_msi_pa_list();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize MSI address list\n", fwnode);
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
+	kfree(imsic->msi_pa_list);
 	kfree(imsic);
 	imsic = NULL;
 	return rc;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index c42ee180b305..e51c61dcced3 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -50,6 +50,9 @@ struct imsic_priv {
 	/* Global configuration common for all HARTs */
 	struct imsic_global_config		global;
 
+	/* MSI target physical addresses indexed by logical CPU for IOMMU mapping */
+	phys_addr_t				*msi_pa_list;
+
 	/* Per-CPU state */
 	struct imsic_local_priv __percpu	*lpriv;
 
-- 
2.43.0

