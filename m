Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A13D88E3
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306566; cv=none; b=E2MAn4zc8w/ehdt6mzpH+RCcTJoFhG2DguZYiA30XtysYF3l+Cr1SeC63/Dn0aNySsSBskol3dkqIua4C1Wenes/9klvhGmPvpIn+AtZOiAIhne/Q4PGCWikBLTtd51AiDWOY5NeRULjiVbSPly4ISZU5ckFrnVJUzD8miZ/Zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306566; c=relaxed/simple;
	bh=GXiPIZglCzQ57hkuCOyXRgoYx4cKxjmC6a7IKdJwtLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3EM6g2L2lUi3eL6xt2cRddYDPuN1d0E8pIVvTnL124GcZ1ox+lX7yfeEiU/q41ztBjTyoX1StYOGbsxUt3z0n9wz6hB4tLNUXNtZ+pP6gHOfPDCT7rlXJAnnHOj23ACkX1gNeRhfR9Y04srty7+PFVrY1q3BEywkXD16ffxBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6ifMYWn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h5gPI3O/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6ifMYWn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5gPI3O/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679IAlG32694518
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rry4GguH7Meqgz11UcFuJ1AWrZzOU1PZecUYu+VWlPA=; b=f6ifMYWnVZIcKQF8
	TCEfTy166WQUM5RlhwY7s/HwgiDZb2UQjHtwn4kYzBKiDtK4kBjd4dpqEl4trbQk
	oBeJb6y+jkUFGu6PnNIbIGEFLxfN0FUV2mFaLk++Uedvxz7mHtH90fm6xYuOHbMD
	4FflWeAZWFkDQDj33GtU94N55zr+azKXaz1Ztr42jfvpph2nwTINTvNVIKN9sMni
	8us5SwYrw6DV6IZ5X+tlS6QvLnraNlPhAj7X3Nm+3R4+xk47V7DtKqoVndDZI1vk
	gPay5Sr1+BUCCDwMc7UhYJQtciKOyjDQWIxwT+p2ZRlq+TL+gZ9gyKD5jzW44X2+
	uJYhDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwmgucw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52b4f6ac06aso22823311cf.1
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306562; x=1786911362; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rry4GguH7Meqgz11UcFuJ1AWrZzOU1PZecUYu+VWlPA=;
        b=h5gPI3O/K4qsQObSqhZ08Axp8DqLqH/3C5o2KlmUsupKBRCtOiBl2WkACKgGkyhRgH
         5T3qR4auXmr63xsxWiJrR2R4qkdD9t5k+QBZniZy2+Pl6iyE9mAlBsqGvvv2A+KbXtkg
         OsLHeH3gOJCX7Kgr0vHCWGA2OXrM+VHA3poH9PKWQuKmUHIbtwSLaUhSrcWDlYSwBcXY
         UOp4X8eLeWqq0oROZyskHi/CkTqtINyiHYqqLuP3R1iOtJzPEaEVQUJblGeZYhYU9PKB
         winb2YqFApXXLZ5YsspA8vinIZLiVDm/3+6jHhR33nOYkXfLbxWSFyszW/D8eOJOm8fH
         s3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306562; x=1786911362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rry4GguH7Meqgz11UcFuJ1AWrZzOU1PZecUYu+VWlPA=;
        b=IEgKo+nDiMUx7n/9iurnhZ9ZT1colB+Jej+RYrjxR0KfFQTnPtdg6uKUc8hOF3fO6v
         /nRGid6IHMgIDoLiAH9zdXY/RE/zCuZ4aDv0kReWnVww6rczuAJqxuIwQlxQCP8nW26C
         QaqMwJRPoCxFEUkAvmM4NMIBAqRddCyBD26L75Yt843rffDM6lD31gM/TX2pzyKwG6XK
         B0w2EcKWP0pGoXe1jg9JDxnropd7OVFqy2FEkE0SwLpoy43U2clk2UV2eX/rxJCen61Y
         8NK0Fj/1AaRY36f5AWFORachbBBvOFQZAZSWNz97IFg0s4NoeoTvOUmk90uW1Pgt+ZXo
         HXkg==
X-Forwarded-Encrypted: i=1; AHgh+RpdrIUww1FAdePHsMluYZUl8Oi0lTnt4aTbzKA0k2L4PF/xoaM8nRq7ho8NlIFfQTOtttBNFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNNnyg10KKMK4GlAe6/qfjd1yA7peRlBHHnQLE4APYtypRLm0k
	3/qdTIF/U48y5b7TkKOEYb8Q7qLQffuc8CTa1n2GhHq7Zz4nSrHaLjsVn5WOAHSQvl1hqY23Tiu
	8UNZGbQWGsSzvP3UzzjXyBaJ+3bnKh4G/rf/jup7IDH6jGB/i40UEWHVksQ==
X-Gm-Gg: AR+sD12zLpfsYdvBLj4Kz9p7w71LTVsIX845TXPRyZjcyMtjJGLwxKA7cBg+V1lLyQA
	OrboujrEtd2xGM9qGQXLNUNBC3yiPJXoTSnfBlMNqWZKXTd+Bft3lX1oEaj7hoeuzEls9QX1p95
	BK6642cPtYcdkkwL+Gu3uQuOoZmUk/pdOaJzafxD9pHFvy0cWR0Qad7DavGhBedRnwHy44UfKQA
	d0J0aoDdJS4hLwdmk/0kTlKB5ynZmVZQFtC7fQhaMVC8OLNl2JeMQwbSEpt8Qt9QRtKbTdFUXJW
	foSagBHQ5+89BL4rDHfSoB1GHjS464Viu0URUG/C8lJp5+gZNWnjq5IX8Rpiof2/BantQkXdgU+
	pzgFmVkzb5MxyqAFYNpdfNGYJiQKmeHt8SwV3BPQGBdGLDqjW/vDkek9od3UuefrjpH6zyOpL9o
	LkNaE/+LZPninjKA==
X-Received: by 2002:a05:622a:295:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-52d0b04c1d4mr255757921cf.11.1786306562255;
        Sun, 09 Aug 2026 13:16:02 -0700 (PDT)
X-Received: by 2002:a05:622a:295:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-52d0b04c1d4mr255757591cf.11.1786306561854;
        Sun, 09 Aug 2026 13:16:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:45 +0300
Subject: [PATCH 06/12] iommu: qcom_iommu: support non-TZ-managed instances
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-6-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8021;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GXiPIZglCzQ57hkuCOyXRgoYx4cKxjmC6a7IKdJwtLo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uChgqZG3WWQT+NkfhYIemGVi4SeH4M9Loa
 b8wCfB3QRaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1SyUB/kBncagbuWWJlhIctG68KKAARV2R4j44ig3zbUgnJR6HMbSoX8P+5TMSGfD8t6XEfy0T+m
 zibX2U1bMqIdkRQzFrWkNnP1llgcnJc5oVlOASoDx4IlX0+gKGv9XSV1SYA7jByQ5w5qLfq135P
 9oyqfKrb6Tqt4+xaf9IbfK/JfOEaK94ICzEXk6oVkXuzGpJgcAG6Dpjm6pQsNq09KrWatRYMcL5
 pNJdula8C+b4jevA0ysfoRW4zBLLjgPFs2ENqkSTrGozUe9fk+/8TsP+X4qU6HYaeneGA1xBO4x
 Uq/xKbOECYLsTR4bYWNDuVH+SBlkeoAwGua1HW0i+yq7DHGv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX0ONKHWoqfFTg
 ODdIe6OwpsjC9D7He2xCUAR9rftLctCjPjtsCLvYpKPW13C8bCkTmMvxiacnzVRKznmyyCBVlD4
 kmy53d6T5w4hWWMlN7HAwWvd2041grc=
X-Authority-Analysis: v=2.4 cv=HodG3UTS c=1 sm=1 tr=0 ts=6a78e003 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=9TCwowKhpjj2XBowZ20A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Z8MnNzij9H7O5vZVNa8vyF9vAml0jR-s
X-Proofpoint-GUID: Z8MnNzij9H7O5vZVNa8vyF9vAml0jR-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX9R4lULsQNdY8
 YONM+UyxYMpkcHmeug8cAeMnTOgCf+PrD5IZ4CHw2Tc/w5EXX4K3cavaLFGoh90f4qKdoyoS+A/
 y5CNdRXvRR848+aLx1JF/1NOMkmm7a/1e9kv1oANduA5b5mh4Hu/yMJmzceyxtNiFPtARX8fTce
 AHX5BPt1F6MvRLuJqoMBLWTeuge39zh03lqftQx/QYgA9zouFm1EWsIeW/6k5uULfBAuaff8Td1
 uf/4Ku0ryRyWgkuLoeDCPYhJgz7mjhrdliko3xR8mqV8GD/srPuTGS/cMO1I96FW4YEM0tMGt0l
 AdHgJKWimrgHzmEy1XzB3VrIw3CQXEcdrOr/dJ7GyKRuq43p3p4ncTNOrPqxKHU3+05Ae8M++Ew
 k/YnNExoV3pT5SWsQwBomxjkshvI78hZ5geAGEo6F6+u2uCts7WiaZvpRFDEOX1poQVuTT0wlyk
 iuU3QToeoCOj8yGwERg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

The GPU on MSM8974 has never been usable upstream because its IOMMU
cannot be driven: unlike the MSM8916-style instances this driver
supports, where the secure world owns the SMMU global register space
and the OS programs just the context banks after a restore_sec_cfg SCM
call, the MSM8974 GPU IOMMU is not managed by TZ at all. Nobody sets
up its stream mapping, so attaching a domain leaves every transaction
unmatched and the GPU faults on its first memory access. Verified on
the APQ8074 dragonboard: restore_sec_cfg is only accepted for the
secured instances, while the GPU instance exposes its ID registers to
the OS (IDR0 0x78034404 / IDR1 0x10000003).

Add a non-secure programming mode, derived from the downstream
msm_iommu-v1.c driver. When qcom,iommu-secure-id is absent, reset and
program the global space at runtime resume instead of calling into TZ:
clear sACR/sCR2 and the global fault state, invalidate the TLB and all
SMRs, install the per-instance stream mapping (SMR/S2CR/CBAR, with the
downstream MEMATTR/NSCFG/VMID/IRPTNDX values) and enable the SMMU with
fault reporting enabled and stalling disabled (sCR0.STALLD, matching
the downstream terminate model). The stream ID map is per-instance
configuration data since it is not discoverable from the hardware; the
SMR index allocation keeps ASID == context bank index, which this
hardware requires (downstream msm-3.10 commit 4d92ea10aac3 ("iommu:
msm: Use CB index as ASID")). Also set CB_ACTLR to redirect cacheable
requests to the L2 slave port, as the downstream driver does for every
context on this IP generation - on MSM8916 TZ owns CB_ACTLR, so the
driver never needed to touch it before.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 107 ++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 428b18697244..3b07c4cf23fe 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -37,6 +37,9 @@
 /* GR1 sits one 4K page above GR0 on the msm8974 QSMMU */
 #define QCOM_IOMMU_GR1			0x1000
 
+/* Redirect all cacheable requests to the L2 slave port */
+#define QCOM_IOMMU_ACTLR_BPRC		(BIT(28) | BIT(29) | BIT(30))
+
 enum qcom_iommu_clk {
 	CLK_IFACE,
 	CLK_BUS,
@@ -46,11 +49,23 @@ enum qcom_iommu_clk {
 
 struct qcom_iommu_ctx;
 
-/* Per-instance configuration, absent on msm8916-style instances */
+struct qcom_iommu_sid {
+	u8			 cbndx;
+	u8			 sid;
+};
+
+/*
+ * Per-instance configuration for instances whose global register space
+ * is at least partially OS-managed (reg points at the global space and
+ * SMMU_INTR_SEL_NS must not be written). The stream ID map is only used
+ * on non-secured instances.
+ */
 struct qcom_iommu_cfg {
 	enum io_pgtable_fmt		 fmt;
 	/* the walker faults on the AF bit despite it being set */
 	bool				 no_afe;
+	const struct qcom_iommu_sid	*sids;	/* one SMR slot per entry */
+	unsigned int			 num_sids;
 };
 
 struct qcom_iommu_dev {
@@ -62,6 +77,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	void __iomem		*global_base;
 	u32			 sec_id;
+	bool			 non_secure;
 	u8			 max_asid;
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
@@ -256,6 +272,71 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Reset and configure the global register space of an instance the
+ * secure world does not manage: global fault state, TLB, stream
+ * mapping (SMR/S2CR/CBAR) and the global configuration register.
+ */
+static int qcom_iommu_reset_ns(struct qcom_iommu_dev *qcom_iommu)
+{
+	const struct qcom_iommu_cfg *cfg = qcom_iommu->cfg;
+	unsigned int i, num_smr;
+	u32 reg;
+	int ret;
+
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sACR, 0);
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sCR2, 0);
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sGFAR, 0);
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sGFAR + 4, 0);
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sGFSRRESTORE, 0);
+
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_TLBIALLNSNH, 0);
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sTLBGSYNC, 0);
+	ret = read_poll_timeout(qcom_iommu_gr0_read, reg,
+				!(reg & ARM_SMMU_sTLBGSTATUS_GSACTIVE),
+				0, 5000000, false,
+				qcom_iommu, ARM_SMMU_GR0_sTLBGSTATUS);
+	if (ret) {
+		dev_err(qcom_iommu->dev,
+			"timeout waiting for global TLB SYNC\n");
+		return ret;
+	}
+
+	num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG,
+			    qcom_iommu_gr0_read(qcom_iommu, ARM_SMMU_GR0_ID0));
+	for (i = 0; i < num_smr; i++)
+		qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_SMR(i), 0);
+
+	for (i = 0; i < cfg->num_sids; i++) {
+		const struct qcom_iommu_sid *sid = &cfg->sids[i];
+
+		qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_SMR(i),
+				      ARM_SMMU_SMR_VALID |
+				      FIELD_PREP(ARM_SMMU_SMR_ID, sid->sid));
+		qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_S2CR(i),
+				      FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_TRANS) |
+				      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, sid->cbndx) |
+				      FIELD_PREP(ARM_SMMU_S2CR_MEMATTR, 0xa) |
+				      FIELD_PREP(ARM_SMMU_S2CR_NSCFG, 3));
+		qcom_iommu_gr1_write(qcom_iommu,
+				      ARM_SMMU_GR1_CBAR(sid->cbndx),
+				      FIELD_PREP(ARM_SMMU_CBAR_TYPE,
+						 CBAR_TYPE_S1_TRANS_S2_BYPASS) |
+				      FIELD_PREP(ARM_SMMU_CBAR_IRPTNDX, 1) |
+				      FIELD_PREP(ARM_SMMU_CBAR_VMID, 3) |
+				      FIELD_PREP(ARM_SMMU_CBAR_S1_BPSHCFG, 2) |
+				      FIELD_PREP(ARM_SMMU_CBAR_S1_MEMATTR, 0xa));
+	}
+
+	qcom_iommu_gr0_write(qcom_iommu, ARM_SMMU_GR0_sCR0,
+			      ARM_SMMU_sCR0_SMCFCFG | ARM_SMMU_sCR0_USFCFG |
+			      ARM_SMMU_sCR0_STALLD | ARM_SMMU_sCR0_GCFGFIE |
+			      ARM_SMMU_sCR0_GCFGFRE | ARM_SMMU_sCR0_GFIE |
+			      ARM_SMMU_sCR0_GFRE);
+
+	return 0;
+}
+
 static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
 				   struct qcom_iommu_ctx *ctx)
 {
@@ -266,6 +347,9 @@ static void qcom_iommu_program_ctx(struct qcom_iommu_dev *qcom_iommu,
 	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
 	iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
 
+	if (qcom_iommu->cfg)
+		iommu_writel(ctx, ARM_SMMU_CB_ACTLR, QCOM_IOMMU_ACTLR_BPRC);
+
 	/* TTBRs */
 	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, ctx->ttbr0);
 	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
@@ -327,7 +411,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
-		if (!ctx->secure_init) {
+		if (!qcom_iommu->non_secure && !ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
 			if (ret) {
 				dev_err(qcom_iommu->dev, "secure init failed: %d\n", ret);
@@ -907,8 +991,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
 				 &qcom_iommu->sec_id)) {
-		dev_err(dev, "missing qcom,iommu-secure-id property\n");
-		return -ENODEV;
+		if (!qcom_iommu->cfg) {
+			dev_err(dev, "missing qcom,iommu-secure-id property\n");
+			return -ENODEV;
+		}
+		/* The secure world does not manage this instance at all */
+		qcom_iommu->non_secure = true;
 	}
 
 	if (qcom_iommu_has_secure_context(qcom_iommu)) {
@@ -981,8 +1069,15 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (dev->pm_domain)
-		return qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
+	if (qcom_iommu->non_secure) {
+		ret = qcom_iommu_reset_ns(qcom_iommu);
+		if (ret)
+			return ret;
+	} else if (dev->pm_domain) {
+		ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }

-- 
2.47.3

