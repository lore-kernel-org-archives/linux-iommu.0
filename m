Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C14DEC0C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606303; cv=none; b=XH3WFigLONxISwj97PefpA2CCH6jsi+94xAaiP9Q4UgINy+O9YWDOuHlAyPj9/PyLd0/zanQJtM3WwoJHtA2jRb8VOgPWxMtUC8PQDkKzu6ZFHGgxYnUjNIyx26SJK9DGlyg7uDSK8gpIUzNZIQ5I/clf+67j+aBHBvp5/d6cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606303; c=relaxed/simple;
	bh=cjRzePwWQclJUJKIhRKrEwy8caVabOEtV4kllClzkAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slugpSG9I9zejPV5xfePbt1gOaqWJ3Y9/j4YGRWL2/HhHUlgzHCtSitsUnver5f3RJ27qRRBvXjbjJsoP3xJptIIMwDsuHEToesxEJKBHMYLNeFNcBL3WB7G6oc9gJ5VKEJZIEVEyNpJ7wbbQHGZfTRlWzXzc7NuVZgLc36Aijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhsmkViQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZCylWnR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhsmkViQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZCylWnR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBA7o72404162
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qxLv+wRWUPQ
	akyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=; b=PhsmkViQJCQemOPtl3iSwfqxLSx
	H1fsXQFhaw0QaJgQtyvDTJgSLVVQuvDwsotMKk2pwtHckkciUEGML0xfKcPf98Wp
	vin8jKqi1SaP3eleGdOEg7yBW5QbMfx7RF+6LAzz/jgrPP/GPEPtVaDOS9ztH4Tv
	Oc0Jh4N4HkqvGf+tQV6HRr8Fr2WrrUVzV+N3FFwOGYpg25m09BYu/iyOM49vJfdX
	VepGC9OC6VN1I5a7UxNpNlab3ygBmiSIrbtw/zbYKGyKNusJj+NdOWILbS+hVQmF
	t3OrWlUdMCKh/SwOazWzwIoNyuHMOHjZJvuMPy3K9+N+QE8cTGWzVdm4HLw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1yuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:08 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-791463ed29dso2782286137.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606288; x=1791211088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxLv+wRWUPQakyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=;
        b=dZCylWnRIOj1jX2lsWaaNmLKueNGGCnr2yjBIxCqWrlNVAbWtNSZNWdhpkHZ2EB6GA
         V8UQ9oE8GKwlbIOoPODOeM/vEUNs9DCgwhsr2WWTTf3wdDtfwpjZpi4aPtL2SAWDc3bi
         4PfdVdYg3aT1ReJl4KA64tygUbimJxXrmDyfOCNcR0gXwPRtS9ssOAY9QA+EHxIFNFmA
         AT0o3f5QU1KJl37ifgrVF6lItLJBxhg9+IsQjWyL9lADtLVkO/Etg1cMq1pkupv8eawa
         pSISPwyHFCsJJV/ARanBRPPvtEFbglW5T9TXflPPZwpRtJwuDAfhywfqIfzf3uiZmmbr
         HeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606288; x=1791211088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qxLv+wRWUPQakyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=;
        b=Qaz+vzgpav59R+aLvSzNkHhofp0LjSCWwcPP5SDrOMktaS9lCy6yCChtbitFit41JT
         9BgioiSGTb1pS7WQAwYbPVDjQKDS3HkZsV1aiGjpWAmUUK1ys9+fTEuVzwi+6J48tMiq
         aa/zFWgRvKjrgkQsIFwHy/bavwtQFC8c6AETak/AYKuJE1G7+Nv+nd2Uop+9kt/HmDf2
         tmIVCEASkytKVTPxkd2kJqXYHGIQBsHTYISASIzjs6YSA5z6XNvpNpaQoLtmki1vpRNI
         dGolBJ5Ayvv6qJ+QVWi9gSjVCPG3hBJyjrVdH8/5N5rcItoeAm8B9kYxurTiq2uejxcC
         4HJg==
X-Gm-Message-State: AFq9FYJszY637ajoY708o22/AOsg46pTnLHj+ia7eJZO2vR6Qx3l2Ql9
	1KfGyF0u9PgtZMpK4DgadB/cen7MBUuvkK7+5ZlsEyERuEpRVMNc9EsK7aakAe4ITcWY3XrN0GE
	ka44Ecgg6KNUQpDEQ5yv4U5eR6OUL5IpHrUzHz2a020fQ4iic3ebuR2S4cXgOcOPH+A==
X-Gm-Gg: AYBFou0MuxOLQLDih0RVjC8xP0ioyKB60n5ihLRSq/DHEBX9toGMGMT5iYOpmAWobbc
	Fb4c7SIpZYfNJOQOZdhsM3DuzJ+uYIhmvWc6FpNYWjL6nGCTHIYFqHry9xiRha+wK5mPbiVW6jg
	4g5CN8vAxuBYFUMOEfD4oNXKFyqmEaCWjlGZ1J4F/QbGZMIT8dvni78Z7rvwm2Iv6UtiZkdhlFo
	G2wO+OIdo19eeWCZPYu+PqZmI2zR7aVol4xGMsm688PYBxEjZqjdIIu/mX5NrWWroDlB2d2meY5
	6lyzfnX+CjIa5U2l5rHq4sr1BBmzUtnoroKqnjhrlKjbuMQNpViQxQA/M9bBcWPoZLvBdIFkIyl
	RPoDtEZ0ipCrCteUlnIjnM0K5ERkDJkx9paA8qw==
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3274830137.29.1790606287838;
        Mon, 28 Sep 2026 07:38:07 -0700 (PDT)
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3265770137.29.1790605900321;
        Mon, 28 Sep 2026 07:31:40 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaecf2f62esm4040194a12.27.2026.09.28.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:39 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 04/14] iommu/riscv: Reject live S2 replacement with forwarded IRQs
Date: Mon, 28 Sep 2026 16:31:03 +0200
Message-ID: <20260928143113.49838-5-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX+uyqnfdRL4Ew
 WWXcpYnpgUMwZPhjg/vp6XLl9kiD8UeKxIcykRKV2tq6OZLJMRG/EOaTh3H3uJoN1MWJq7Dq5Ga
 IJ4ImESK8dwfVSf9BeCLUcSpB+DUufCm/pn+IBoKSiZYzhbT2zl0ocxEUgT5h06m/Z7awRBgSvU
 QloHuYLuxr9PPIwRkPpb5oo0s8kWWQdovWbz5n/rPqm9lLr04FkrGrlzBtc4qRM28gndq98nSg3
 rqqYlQDQSWn3mVQw6PVP4Tn+fhCU7TE1c+TPlh3V/NSah1rzjagjBjbkT/QVznTTU/4MNyglhwi
 nlQMCT8SFyley9l5lLtaUhFrqeDJ1DZoMZ4midMX2+46PGSQtt5YCfOeLrjwfofhbMU3pbR72ZO
 aUSZ4mwhfJIS/odfEnVlZiZZExGzy9otmei3v6P18+R/rFu/D1NKuu6eRwOwRh4OWQd0lB9KTel
 JaQX5U6Bao5UOZINSrg==
X-Proofpoint-ORIG-GUID: SbryGBtHYQzqxRwMxuw82Dqr2N7cLBU6
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba7bd0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=t97w11WlQ40Dee02AfYA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: SbryGBtHYQzqxRwMxuw82Dqr2N7cLBU6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXwQU4keReQ/R6
 zJtVnD21K1jmWw8P2gBBXoZUyz9Yvf8tDZKRU2aWo2iSOPZDSsDMR47A4cUsRk67kZc4gJ7YVOn
 wxrj/HE2AY9KOsCGGoYjVzVYoHdQcKA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

MSI forwarding state is tied to the S2 domain MSI table. Replacing a
device's S2 domain while one of its IRQs is forwarded would leave the
IRQ state referring to the detached table.

Reject direct S2-to-S2 replacement when the moving device has forwarded
IRQs. Introduce a per-device nr_forwarded_irqs counter, rather than
domain-wide accounting, so other devices in the same IOMMU group can
still move and can be rolled back if a later device fails.

Later patches which introduce interrupt remapping support will manage
the newly introduced nr_forwarded_irqs counter.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 57f2884dec42..d48667112cd9 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -872,6 +872,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	unsigned int nr_forwarded_irqs;
 };
 
 static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
@@ -1432,6 +1433,36 @@ static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
 	return 0;
 }
 
+static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_domain,
+						 struct device *dev,
+						 struct iommu_domain *old)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	bool new_is_s2 = domain->gscid;
+	struct riscv_iommu_msi_table *new_msi_table, *old_msi_table;
+
+	if (iommu_domain == old)
+		return true;
+
+	new_msi_table = riscv_iommu_domain_msi_table(iommu_domain);
+	old_msi_table = riscv_iommu_domain_msi_table(old);
+
+	if (new_msi_table)
+		lockdep_assert_held(&new_msi_table->lock);
+	if (old_msi_table)
+		lockdep_assert_held(&old_msi_table->lock);
+
+	/*
+	 * Per-device accounting allows other devices in the same IOMMU group
+	 * to move or roll back while this device has forwarded interrupts.
+	 */
+	if (new_is_s2 && old_msi_table && info->nr_forwarded_irqs)
+		return false;
+
+	return true;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1477,6 +1508,11 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	bond->dev = dev;
 
 	flags = riscv_iommu_msi_tables_lock(old, iommu_domain);
+	if (!riscv_iommu_can_attach_paging_domain(iommu_domain, dev, old)) {
+		riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
+		kfree(bond);
+		return -EBUSY;
+	}
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
-- 
2.43.0

