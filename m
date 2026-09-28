Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F64DEC0C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606400; cv=none; b=WCsUoXca2cqO2JG4/CcxktLXBbK+IixuCMt/WBS6EJyhcBG51uWJH31iYQMOaGm6mK7tnMoifo6AlPQJSwFODfBeKDFb68ovKw5SABiTyCknkHTsU1sC1tQ1bhrqgeoC7SFGqeGcGYecbr8WOCnkkluar6GLshOYCnAih/74+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606400; c=relaxed/simple;
	bh=x/6Mj8dzphmWlnSGBe6+AGxpWwqp9NycJT4FTm8Zu80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg3juFIEGhiXEqVyEN+EPVupg5sJDRmkKKrmX3VibH3n+Y+xCaNpFIBo32hnuDVkOsQx2eFQ/XhGfDIuxKSDXVQYPtKQ3BuFPUwE0M8PzD4Mj2/abDHG3aElq2e5ojKW2HzvQAQR2QZCCgt5a1JxQuFtBSdOWmE/bjXsX/6QMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c73uNlh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbfKy/qA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c73uNlh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbfKy/qA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAVBI1042595
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cTgrUnplzPT
	siEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=; b=c73uNlh2ZtQ7oej8s2yZmevZ3k7
	REywjteFYrK1X5Mt2oFWX74+RMx/ANasUOMEci/WYpFAXC3eDSM5KKAzRlk3ReD7
	NUZtqsG30imxmipV6zJe4iKrMnyIydGyy5CtfKz83zRJXFTE9OM969wZ2NXR5Otv
	NAIQbJtoaIKI6VIJsMCp6Qw8twxVRMN/oM3cmg5y/rJX49tS6VfHXrbIsMlLtvre
	iX79BU25HrE3sHCpqucTiplywvFHg7xkKlgxy/GHBb+IBd7JAdfRd4vtTxc5ZUER
	GbzudQZgtsGlq26wWi4UY2xGnSHc4G2L9c73XXMYhDJooGSRemk8PoT7n/g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mss38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:39:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91430af782dso71092586d6.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606390; x=1791211190; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTgrUnplzPTsiEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=;
        b=DbfKy/qA94PVbc1K52Gz+jfw4xbDHUefo6sIBCy+mCVk4lp39mXDNravx1Tnzym4Lo
         uLAwtMM2+dfYPlN33UpwZSK2TVqmZSQPrPI4UK0uufNBTdk2PPpvHkflsl3fNrS3YGga
         hAYCWzO/zRosb14LZua7WO83LYukigZTc/PNvv+QRyOFHdFElOWvW9HKJo/0xig9ik0f
         gjx3Pbs4WWN3ACicWYv74J901L3pGHsECHkhxOKJNQI9X1Mw3VMBGDdjABdjvTEXJARv
         S7TTLqOlRc3cbXDSAwDhHDVkC62D4xQo0XRVLfZBi2XMdAGkDP+h7FoZ8gtEIh0SfAwv
         /vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606390; x=1791211190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTgrUnplzPTsiEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=;
        b=bOORQU/ZNg0WuPcgw2Dbin19xSqRea2NgBhZ57yHaSG3McgmUAaar34/HTcYWGuc5Z
         A5z4YZKYklvkwNpSNxtFXlnHWmls0sonq6do7bnuhMblHmLy/HSLiS7SW7H5WjPHLUBz
         NpYK56KTxKtq1OBbI+pf8vMBuWtOBOXXmS0PwVKpqHLbkEwhGII+u9w5azp/YB1V6s0M
         3Vq5+6meJSEmyBzcsL4u08Nj8dxQmUdtLCX28b4Wdwx5eToN3YW6pvIUb7oVgNehFz39
         HGs/+oX3g0HudzB5oLpYn0G9sBp1b1F/VetkgzGh0zE5evfWBvxsmQH+gcSTwQUkBH2S
         SSSw==
X-Gm-Message-State: AFuF++l3Av0c6brVazkz5WSLNUIWfpZYBYzE3Gk3cRqLc8B8W//ALOC0
	+xopcil2FBxM/nx5RnDbAxqhN8l4oSOKUk7XYnQNBXNZDJFUQ4TqxE9aSdbfPV98rgeGFETXq2H
	LYewReNq7lNVG62Jl2A5djep2YW3SwIMOFmW01CN/4UN5v2PZvFm5+57qnQG+D3J+Nw==
X-Gm-Gg: AYBFou3kNIqijRoRzdBi/KcXHR3Jups/lmMyWnW5XZh2vwsIh3VfLGzh+KSZ2Rq0EsH
	xKT0m9ym0VAApA+BD8M/8CgW/fxJju5UCltLkfPad+4fQe3RJeIjYuwmzycVZHiDokf28LjODUt
	BRjh8ZkUII17tmgXvDZ6rZfDmcIIHd4MBRjIXBe21OvJlkCqiPE54z5iISlVW2aGdPPHfZvfOcM
	otspm/n2QGKPsxUk9MctxVixkI/JigKA9udhSjUtF+IKFNJbMNAAJYUtlTbmeapuGfF6dNlFwkN
	N5/Ec6Pj4w+CzE3XU8bA3cD3N94kSTt1F1qma95UbKVjkVVN8d7OnQPmMmAnwen6k5chshY3BOD
	Lzt/1xNrzafqUYNJ24yFilXLMz1iGy/m2XwF7Lw==
X-Received: by 2002:ad4:4ee4:0:b0:914:521e:7d94 with SMTP id 6a1803df08f44-914521e8335mr118904216d6.5.1790606389793;
        Mon, 28 Sep 2026 07:39:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:7b7:6dec:6eb0 with SMTP id ada2fe7eead31-7b76decd903mr718307137.15.1790605931408;
        Mon, 28 Sep 2026 07:32:11 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbed87650sm291164166b.50.2026.09.28.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:10 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 08/14] irqchip/riscv-imsic: Define IOMMU IRQ bypass protocol
Date: Mon, 28 Sep 2026 16:31:07 +0200
Message-ID: <20260928143113.49838-9-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CUtknoIEYgb7Nqee_z1K-zpgTW_gOzKc
X-Proofpoint-GUID: CUtknoIEYgb7Nqee_z1K-zpgTW_gOzKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXzUJLzbc5Z0xC
 JQ0NVNkBjQf5LDGyGtEBjZus4PUB/ab6KyEPUKkClTvXc8vajRpfTFLa8H2MOb0kin6QotGy7Py
 Ye0Gegz9ORyqwGM17mXdcOpNP1vBdWFc3nd6QF0EtUgE2lXDfs9JRMkEppfVXOGp06pU0OyVLVg
 GEIcmXolgH/notek3q6KoJbdzQke9Pj1th+G0sXYIT9YWnR3c9Vq2r1ZNeYTkvnfeXtjgFh+Tgr
 DXCr14xW2KwgqKznf9wT+5xRIrcIbpkYnzagcOSPXGBpssGDHGH6Jav30rCTuQXJEBd5G5Qib23
 UgutfeEEHOnCQPf4rYZ4P+P0qSnn2rMpLNYGOSDLdgo8OEcoZj/ApzG7FDN3V7uOoAMt4PBagxj
 naVbV5IBumK/rhcbQswOPSe1zhE/PTaHQIqHzPjrdjmtuIaGRy02S0dr9TkU5Wl1pLHE58vAkZi
 gIsz1PbGlLAvU8k1wCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXzIZpM80p7Zsw
 i1LK5qTPrllvTDyjE9cEBsd8Y4sHyEoYW+8Vc6IlzAq+VjW1GeZ92Pfw7hvqHI1oI8nYkNZA6OO
 9s0ORmcXBuACm5HEsfQMx0fFZ1M2lhE=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba7c36 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4AuT_VmNVbg3FCPyVe8A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

Define the RISC-V IOMMU payload for irq_set_vcpu_affinity(), including
domain-wide target setup and individual target updates for IMSIC and
MRIF targets.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 include/linux/irqchip/riscv-imsic.h | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 662cb0442424..d024a6524baa 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -104,4 +104,56 @@ struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
 static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev) { return NULL; }
 #endif
 
+enum riscv_iommu_ir_cmd {
+	RISCV_IOMMU_IR_INVALID_CMD,
+	RISCV_IOMMU_IR_FORWARD,
+	RISCV_IOMMU_IR_UPDATE_TARGET,
+};
+
+enum riscv_iommu_ir_target_type {
+	RISCV_IOMMU_IR_TARGET_INVALID,
+	RISCV_IOMMU_IR_TARGET_IMSIC,
+	RISCV_IOMMU_IR_TARGET_MRIF,
+};
+
+struct riscv_iommu_ir_target {
+	u64 gpa;
+	enum riscv_iommu_ir_target_type type;
+	union {
+		u64 hpa;
+		struct {
+			u64 mrif_hpa;
+			u64 notice_hpa;
+			u32 notice_id;
+		};
+	};
+};
+
+/*
+ * FORWARD enables forwarding for one IRQ and provides the complete target array
+ * so the first forwarded IRQ can initialize the domain MSI table. UPDATE_TARGET
+ * replaces one target without changing per-IRQ forwarding state. The caller
+ * must quiesce all MSI producers using the table when changing both words of a
+ * live MRIF PTE because the update temporarily invalidates the entry. A NULL
+ * vcpu_info disables forwarding for the IRQ.
+ *
+ * A well-formed request which is incompatible with the producer or current
+ * domain configuration returns -EOPNOTSUPP, allowing the caller to fall back
+ * to host delivery. Invalid payloads return -EINVAL and operational errors are
+ * propagated.
+ */
+struct riscv_iommu_ir_vcpu_info {
+	enum riscv_iommu_ir_cmd cmd;
+	const void *owner;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+	union {
+		struct {
+			const struct riscv_iommu_ir_target *targets;
+			unsigned int nr_targets;
+		};
+		struct riscv_iommu_ir_target target;
+	};
+};
+
 #endif
-- 
2.43.0

