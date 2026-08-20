Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF548A2CE
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262147; cv=none; b=dhsEYy8/TZqjvvsjtlVXqK7F5KsqbRfikQLOym8s52rno3gMsREY7GICTK9+D4PWFJI2Vne7t3p79HMWyi7v7nXZ5Oa6GouvVPyPFGINAfS7skUeBcyCLOoLKJVeoHxE5KoSB9jKpUz3uBwyQNsjpYAQOEkUFT7TFKqBhD2qZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262147; c=relaxed/simple;
	bh=Hjmkfw1o2Gw7AggUdgXAdm6nxECAcz0KTH18g6ZS9Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7+755IXe//6iOrYHhDjPGgVEnNE3kv3olWk15bkK1e/z1zG6nkptVsSOB9MCvYHu3gDvBze3G0p5VtnuUKpz2+BUCMLNTH0sE7IBKMDckTNgFHn6j7jzyySAPJzBEUEIvTB7W/vGT7JC1lD1yh74K3+hzrV+iAnat+yfNjRn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l7GeuEQA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNPd/hg6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l7GeuEQA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNPd/hg6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7kZj807455
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dlqDYRauZrd
	tzbPdixW6g/cCIJHkc6dtQCRANydj4Kk=; b=l7GeuEQA/Kqk6NCo0Js4snj8HmN
	Wf8v8aoXsL9TxUq+HEMfG0514vtTZipywQHua35F53Zk/sHh9mzmGsAMqkEuSDpk
	tUJkZQucFtZY8HrZ/FN0r7NR+vIKZq7SYpOrXNe4GHKYwtqMt77VBQbiFmsLct48
	RVLOtiiwjde7RXg+UBZRHG8mdKFaumBGuQ2JrXLIBpgFey7U+IVqVGcrIrKbhFKB
	8DDCqH9QIxlk4rAwnigG8WDZM7Tzpf4bh2Of129sGDJmEwXuDt+UZ/CSN712UU5c
	NlSJeKs4YsR4Ho1cW/K8PjphsIar4LX3yzRbR7TKhJ4rBX2mK69ifxWE/Sg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcbbuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494527488so49631285a.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262143; x=1787866943; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlqDYRauZrdtzbPdixW6g/cCIJHkc6dtQCRANydj4Kk=;
        b=WNPd/hg64EVMxtM6w8YAgRO04xn0Pk+czJHVvL4OUmk54IQ24b++eQ335ss5J/qlJj
         6e5ggR4tPZvceBxVatDCW4I2aAz18W0eplBarBzoOCrPUzU530AbYEuIYI6r+ubL8cA6
         w6EbqbK1on4bnFiESjazMMUF4yYbSweU6VCsGby4iFFFotWwbAGBE6w6wnP+mfKntrwi
         b6uPkYxzfLJJVPEJpFQ+T6bOEY4gcEh7ZbDShVkobWem+2Ram/Qwa95O8JNTZ7poQKd0
         BinovIpvf8zBmxPFBFybjqVCUowkp+Yj7sxsCni+QuEhf7arjwVk1+7b+MAeT1e8MS47
         YJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262143; x=1787866943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dlqDYRauZrdtzbPdixW6g/cCIJHkc6dtQCRANydj4Kk=;
        b=lFly+lleFJ6pEf9+YkBU0qI8hEWdkwsFVujMUHrkr9wKzWei0Re2AyokBhr73nH4V3
         uYcw95ClnURUoUfm4wVNGZYkk4ag4Y8vIY+73np3QyKUzgfks/kL3VrSawqZBa7Lj+Pq
         TYhghS3VkRjjoAFT3TFXOnMDnGpyAksR3725bxfDvII0NQCuxkRY2/Cya2p9piPoMbeA
         3OOek73nVrr81YxYiu4WxizVQ6HHRpalsorTECcq3+DhEFnPndoMXgqRNHiaeb7Tq+kO
         nqGLDWakygh0/JCJv6Xl1Gb5m2hO1mkXpByqnENJX98RaB9arwuyULqDsTeuKZhCHuY9
         FiLg==
X-Forwarded-Encrypted: i=1; AHgh+RqLNM9p9jeLZZWdh1z5zxlAF5z2g+QHnsQG7GNNFCDdAUzymOK5LgzG5p3+Dfaakp+Jg4CkeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHUSimnh9eokLSW4zc36MdcPHRQRGI17MrZIxVNAqRSuizM7KF
	Cf1mX2FzGkbj+oMD+RjD8+xFpj9zEJdVvHha53WEMRB9fGLEDP5fI1MprWyyiqyh1ieCR5Gz9aV
	L7TwuoH6xswGqiYNXmBzyqSV5LE5W4I+/vuY9tmgjF3MHWdjBTZGIYthwNA==
X-Gm-Gg: AR+sD12RTEa6sg2yhJ+d9y6mXZpBryxMAGz5k/Tni1/6KkTWnUNv8rbPb85r5P0+PsU
	jAuNWZ2Y8eC0FidzcmmQDeIYR4N5bQViyy6VSHUmwrUaqRGm220unw1SHOWonW4STmVhr9QEm6H
	MRniiL5qiZjxX5zPXsWNkmAykPCIV1/mOneGi4vO3cuxkp7YuHoTN6OWzO5IjPNZA9KiLKXQ6SD
	MaqVaHa7EjMb01Lhf87OqG6jACGrrpIGrAQ9YOd98rwGAWF7vvu76wnQYQs+/rK/LRnRInT7XKB
	dvQ5dFyeUUPGbqcgIVus+8OIg+ytf4sRtzLOkBIGni7i3oE9k0M/t4mmPgcpYn82P18EXV3O/zI
	wZVr6a6Th
X-Received: by 2002:a05:620a:459e:b0:936:cf5a:6061 with SMTP id af79cd13be357-937395d0e10mr115141885a.45.1787262143234;
        Thu, 20 Aug 2026 14:42:23 -0700 (PDT)
X-Received: by 2002:a05:620a:459e:b0:936:cf5a:6061 with SMTP id af79cd13be357-937395d0e10mr115136885a.45.1787262142839;
        Thu, 20 Aug 2026 14:42:22 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450fb9sm14977035f8f.14.2026.08.20.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:21 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 14/21] iommu/riscv: Gate direct identity boundary switches with live MSIs
Date: Thu, 20 Aug 2026 23:41:43 +0200
Message-ID: <20260820214150.545737-15-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a8774c0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=X3j97Jsqqw8C7WG5k1IA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fiB6mAUZ2I5wtxqcuC6OsPlyYfe3iBZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX0iGCSiH5BPI0
 EFcT/6++jDb+/lPLiUivIP8QVAvdweeEOj3sBJmKWzE+cx4XYlgHurGiTYX/ZZJNvdwJShjW2AH
 2MH9/h/zbJiWMkZiOOxB9BUri/SXBi/U5E/Sof8WCNiFSJtdSOpFxhAg1y52il69NtKflY0HaTQ
 MUk+fAm6maWWLVocNNXWkhocNQd2J6kGSvIkafnJNSuB75TqAbeAY9WGDAL3MJzKdkp+9vAYC2L
 0fZisKZMELPxHcy5iJZZh8XFpV8on6yVS/6Hrke43/IJeXPkxFmAmSND4vy5f6no/FmoyeJxdYH
 tBLZ6OtbCR6DCWldRaObtqb+uAGDDaxQbZS+R8TBvt3RhnwU8ZGLCwBF/rGz13QOJEzP0brSG9v
 qGHbAVawROeg/l0XJVhEmbrPksDutINWLuuA2OP85qgUdcdDWsTPr5Hxuf/vqeV5A2EH+GADln6
 Jsw0TLTP5LM7KbeY1cQ==
X-Proofpoint-GUID: fiB6mAUZ2I5wtxqcuC6OsPlyYfe3iBZN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX0eJV46mooPZy
 Qz4CD3x7VnIlcAtyei0ZQRpP5yIPlfI5/CiClAhVkeJYwpR6RkjJc6//qXBXebUCRne5jT5W6fd
 /RNeN9YhQMSAieD0bLOKKV38VSkefSg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

MSI composition may run concurrently with a domain switch and derives
the target address from the attached domain. A stale domain read across
a direct paging-to-identity or identity-to-paging transition can select
the wrong addressing mode, so reject these transitions while IRQs remain
allocated.

Keep the blocking domain available as an immediate fail-stop mode. Since
it does not retain the previous translation mode, transitions through it
cannot be checked reliably and still require callers to quiesce MSI
state. Paging-to-paging replacement remains supported because the new
domain's MSI IOVA table is prepared before attachment.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 38 ++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c    |  9 ++++++++
 drivers/iommu/riscv/iommu.h    |  6 ++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 5718f90affd6..f61b65f29888 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -278,6 +278,44 @@ void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_inf
 	irq_domain_free_fwnode(fn);
 }
 
+int riscv_iommu_ir_check_attach_paging_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev,
+					      struct iommu_domain *old)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	/*
+	 * IOMMU_DOMAIN_BLOCKED is intentionally not checked. The immediate old
+	 * domain does not reveal whether BLOCKED was entered from identity or
+	 * paging, so rejecting it would also reject valid same-mode restores.
+	 * IDENTITY -> BLOCKED -> PAGING can therefore bypass this check; callers
+	 * must quiesce and tear down MSIs before making such a change.
+	 */
+	if (old && old->type == IOMMU_DOMAIN_IDENTITY && info->nr_irqs)
+		return -EBUSY;
+
+	return 0;
+}
+
+int riscv_iommu_ir_check_attach_identity_domain(struct iommu_domain *iommu_domain,
+						struct device *dev,
+						struct iommu_domain *old)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	/*
+	 * IOMMU_DOMAIN_BLOCKED is intentionally not checked. The immediate old
+	 * domain does not reveal whether BLOCKED was entered from identity or
+	 * paging, so rejecting it would also reject valid same-mode restores.
+	 * PAGING -> BLOCKED -> IDENTITY can therefore bypass this check; callers
+	 * must quiesce and tear down MSIs before making such a change.
+	 */
+	if (old && (old->type & __IOMMU_DOMAIN_PAGING) && info->nr_irqs)
+		return -EBUSY;
+
+	return 0;
+}
+
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 1a30bac88101..22cccc69bd2c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1280,6 +1280,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	u64 fsc, ta;
 	int ret;
 
+	ret = riscv_iommu_ir_check_attach_paging_domain(iommu_domain, dev, old);
+	if (ret)
+		return ret;
+
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
 	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
@@ -1398,6 +1402,11 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	ret = riscv_iommu_ir_check_attach_identity_domain(iommu_domain, dev, old);
+	if (ret)
+		return ret;
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
 	riscv_iommu_bond_unlink(old, dev);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 24006c1c1722..19e2c0f29301 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -103,6 +103,12 @@ struct irq_domain *riscv_iommu_ir_irq_domain_create(struct device *dev,
 						    struct riscv_iommu_info *info);
 void riscv_iommu_ir_irq_domain_publish(struct device *dev);
 void riscv_iommu_ir_irq_domain_remove(struct device *dev, struct riscv_iommu_info *info);
+int riscv_iommu_ir_check_attach_paging_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev,
+					      struct iommu_domain *old);
+int riscv_iommu_ir_check_attach_identity_domain(struct iommu_domain *iommu_domain,
+						struct device *dev,
+						struct iommu_domain *old);
 int riscv_iommu_ir_attach_paging_domain(struct iommu_domain *iommu_domain, struct device *dev,
 					struct iommu_domain *old);
 void riscv_iommu_ir_free_paging_domain(struct iommu_domain *iommu_domain);
-- 
2.43.0

