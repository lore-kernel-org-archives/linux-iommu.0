Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AF379980
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126669; cv=none; b=Xu7/gc8nn5NyZ6WDhSK0j0jb/lVdNM+RrYXoPmYOf8LLLHmmlTu73YXYWnTEWhxW1q8cb6NEa5M43NFbr1X5F7L8LfQhB8wQe7nzwlGUaVOMujCQ5t/W6Nd4l/Crml6RMwiyji+3xeQ6+Lm7mV2i4vMUiEtwQRn6O3Y8aClyw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126669; c=relaxed/simple;
	bh=exJeN/cX4zblIO6D/r8WFyD/s1uwVkENKQC5lCGkwCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX5eO9+yLpUap7HMyJ1oXw0g3kj+/zY6ZWocrlvRYnAF0vTtTsRleBliegBm3StRa2iu0oOccGOZaiaiAOIR4WX8/kcO4N4C/QeK+uDzrVhdgwVm/3b7ipDvqOr5CQ850fNWc3k2m4nfoO5Gx0T2OgE1WoFCB1XQN+AlOMvSjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mklB5Tnd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXmAd8SI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mklB5Tnd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXmAd8SI"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GO6Vg2039750
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iTv0jCwO912
	wmcL8qqcNPEkS/nj6dxhaU8WhrnHkojQ=; b=mklB5TndssjbeLVPCFCfEIhllbA
	AreDqEw4gr3Mwgw+YqGgOBNyfIsYx55VKpVUmUex3GvikjRw043eonkgweLZyIBi
	VvjrpLY88qVKZPR3zAfdkXTXxHOEqxiOfRJGyfgCyRY2cfIICLYIthjhnw2Q3+WV
	4aFSekA+gO2jQI3HvZW1gs5Nxi5zGH3G5u6oINJKW8LjvwpJ1iwC7xbJgNZRz8jZ
	xjIlStMlWknBUGBHTxW46YF0UYC56Kavo7+4ICFVNQy8wNzZvRwGKGNVObuGGpFi
	5iDndkOEhg1qjhQwzUXpHyWtiG5ZyvYp1LZyUEhnMq4ROnwKt9K7qcLkQXA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb2755-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso43901291cf.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126662; x=1786731462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTv0jCwO912wmcL8qqcNPEkS/nj6dxhaU8WhrnHkojQ=;
        b=MXmAd8SIrN8Wn2yQY9mfERTZs6io8wst5/m8NwOzkNU6chW629Bp4rCiBflJtG8lTd
         RPKPizjqlFHgInA9C/stYdFBi614Bq9REwMiLCGwOmi/QKchraqXb2J3R7lszi3+VJWl
         Z/S9SXNbwAlgO4jbYJ8WRNDiO/696B8eHjHBODY4egr1oIGlN8nD5bs4B91dKdxNVHj4
         aOS19DsyrBe297IdrnZ5nEL0b2VPDcvnZEUNSaJ4y0xwamyABsPtMkIYajxBL4vPePXc
         7TkuicG5PKy65JAznHZtPRr7YDlzS4p3lXJOJSTIp8NKXQPYTRUfM02Wbhe+huTYErgV
         GvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126662; x=1786731462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTv0jCwO912wmcL8qqcNPEkS/nj6dxhaU8WhrnHkojQ=;
        b=rAyzHzfU6WtrYXHaweW7YeSHYItrd0z52759KQMqyaatxO1XPKDHDxWhvWh8UtTthl
         AcT1eDUW8hlD2EAqRZFbzwYXToT/wtzZVv/MIL5T4jh5Z91MDgxEp0sMTSxuzSA8HisG
         o1jnWrzgS8wq6E7r+lRlE6z7W3F31ji20mgtaAIoSQ6ykoCJZNos8MMgGv8clS3jGvkl
         fhRKwJcABOafXA6sXMtxFQZCZ4xOmwNIyYyKAddRFz6X2f7uoESI1YyNkfZFc1nHO6vH
         OcTUo0mxQhtUgfk7KNRcJNsqmi+y9eHBX/RgEkfySwMVgiiWS5+EbFlPHx9y08uCRzr0
         linA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp1dY/1OVZPRLsUXQo0fUavRk3mcMjjaAgJ554VHNK2WWnnUtpWtVrK56h0pqZqC+qA25IOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYV+UMtCa70c0TF9Wuy9azIgMFRym9xYYJcRDrMUOpFnh05o1V
	lmK5NNQuwIDNMyxNr5lCL8CRdfAX+nvb26KQURRrADv0FerI28vNg4SIjL7a+uXELQgvy2FPV30
	/njKHN0hytnI8r8vf1X7jTOBPFKILK2nGNhicO7Ci2D2Rkev8pVZxs2YwxvancMdUFQ==
X-Gm-Gg: AR+sD10UUiVSVfJui/LWRJhhWWkhNCmFXPcYDN8PGMxRM7+UHylRCVGh4oPf/1sti4j
	k7IHSAeR4pLmBOZXsf6SDePUYFvIhJde5vUzisaWxDtYbL7yi7/+FiBCJtz21KTPRXdItIrV6Xr
	r4mbkmoO4twq9XeCtOrJTRUGJ+ccMpAv8TzVO2iom3PJjbX3r5YvqVyyNw5VtsVUVz+bW7uZCnl
	5B5ETFGqCHTgpl6EqX6pV+kuJWT1sYgXUuGqgoWZxNguHd/fJaJGsCud9MUe1yk6JSJlITgVGx+
	7mTwMIbxPw9FXEnw9qvSnncgnL0ZEzyL0lfKkXqp+vlT1koFJqqxFFA7o9G2/8Po62GE6cjfSav
	2cINwfCCeGoCLMq/Y5qtXAYpQZD0AxolCNmg6nVw=
X-Received: by 2002:ac8:5ad3:0:b0:51b:fb4f:afdf with SMTP id d75a77b69052e-52ce5f612dbmr250077011cf.9.1786126661452;
        Fri, 07 Aug 2026 11:17:41 -0700 (PDT)
X-Received: by 2002:ac8:5ad3:0:b0:51b:fb4f:afdf with SMTP id d75a77b69052e-52ce5f612dbmr250076111cf.9.1786126660848;
        Fri, 07 Aug 2026 11:17:40 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48dcasm833503a12.15.2026.08.07.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:39 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 12/19] iommu/riscv: Gate identity boundary switches with live MSIs
Date: Fri,  7 Aug 2026 20:17:06 +0200
Message-ID: <20260807181713.228535-13-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX/FMxzbn974DA
 FVcqBEdM3wmHEwZO1dB35AWq88tzwKkra+n5/D7MZwWXjRwqZRmEZ35O5ZGnFdVePVSlTIptloW
 D5U/YlMkkdw5f/1tAghBuVWg8Ab5SAudsHeIpTRxl2bPMB6tpQEsl3MUwhEEp9OrFsvKEzL3puY
 5W5NxKZ1IURkiqd49+OVyexen+z7geockAvl0pvE+aSWNLo4n5TxEOyVRLuHbXseV1nX+cHMFbe
 AiKdvtj6fyd7p/KcHNT4IltUZVwGdGRs8Kh8WQxBlIbOjQ3G6jrby+VmnwwIHGJCkatrNH+Ib8l
 8aR1Fpe6E831oluqGTNPgJz68rgLtXmiM2rJ1buKWSiF6A4aq90Izcp9ETp0xW6asvRa2BHtSIo
 WQQ2tMgxDb8aSB41UcgorfDguzqqEwlK0ofBxOw7P+k1tEsVlpMNNQJRWHbEjDik/S2FQNQNxvC
 9EyUaa4qA4/6hketluw==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a762146 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=RNHjlBfCUNiOovmqR6wA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXxtzluVUqILxD
 YyYZQtfM1LYSjo6Dk0CNI8XpnYi7u37ggs6BSb65+xZI66FlO38PSTRZ9o6sn/oV1bVgTSLnfUA
 ew4NnqHyRUtTa+l/tHsWfLM0JyGqqSo=
X-Proofpoint-ORIG-GUID: XCvUVHYPc8s-Pe7-VjQSL1Ygpp-9lGqc
X-Proofpoint-GUID: XCvUVHYPc8s-Pe7-VjQSL1Ygpp-9lGqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

Reject identity-boundary domain transitions while a device still has
allocated MSIs.

The RISC-V IOMMU MSI compose path can run concurrently with domain
attach and derives the MSI address rewrite policy from info->domain.
Across an identity boundary, a stale decision can turn into a wrong
addressing mode (IOVA vs PA), so require nr_msis == 0 when crossing
between paging and identity domains.

This is just a defensive guard since MSI state should be quiesced
before crossing the identity boundary anyway.

Do not gate paging <-> blocking: blocking is the fail-stop mode and
must become available immediately, even with live MSIs.

Do not gate paging -> paging: that path already uses nr_msis to
ensure new-domain MSI table readiness before install.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 07287c0e72e7..f40db2cda417 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1272,10 +1272,14 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	bool old_identity = old && old->type == IOMMU_DOMAIN_IDENTITY;
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	u64 fsc, ta;
 	int ret;
 
+	if (old_identity && info->nr_msis)
+		return -EBUSY;
+
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
 	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
@@ -1394,6 +1398,10 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	bool old_paging = old && (old->type & __IOMMU_DOMAIN_PAGING);
+
+	if (old_paging && info->nr_msis)
+		return -EBUSY;
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
 	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
-- 
2.43.0

