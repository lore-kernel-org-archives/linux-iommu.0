Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DC4657FD
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262128; cv=none; b=jEVZXvLYkjdxnn07L6zb/OTZs39v5Mh2OiLD1oossvaY0dYD6ZBMPU2UwxzJaxItIO086EROcfdK2L4c3oXw6nF3y49kAOJkUSCotyN15jsYp2wbYpuLGDvB9EbEOm/RdFAs2iyPUUYDpu8vi+bXzz0tyzFopRMuUEl4z+3Z6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262128; c=relaxed/simple;
	bh=v83hqGtuG2jdVK96PuCqzaQrovvfHs9jOZD3tAqzuk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF5/RJ+tuPFk2xmaYPqp3ISPslTF6/WEWXKBxSs+QoUWqyB/OjzWKDT+pCp9sqY66P2WHcCg1gp2DvOwrHICfRNuqymhpfoEe5lqgGBVFbRMjwnK9bOu1U4NxmGUZn4oUs36B2gBHyM1XytTVStDwRS1ZDCdYNLabYI3MQDDm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RfvY8Wcs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j3HFyhTG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfvY8Wcs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j3HFyhTG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK8alY160944
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qwULhjudGmx
	SOoYi+ERFWqMhOqB03wQScF80uC4a0ZI=; b=RfvY8Wcs3qLdq8oowJMXcR7z1nt
	JNP+PoPdC49U4oITFwviPEmlqZl/9CRhQkS+r4BkjIz5yhhmty6TPI475GXt2RBQ
	99H/h8uDrrc8AbS7hWceCdDQObMx0CZ3TX6KeFbN0BtBi1jHxG0bcq+guN5xIQFS
	fRX4AlUa0O5AgFDuf6zKUb6WGoEOuf7gz836iDigUoSHyp3MUt4e2eT9h9jWxsfs
	etcL+Byl9SRzkYQwlt4d0+5hNiJ/zpDbrTb3N8Oy4QSeIyf+YD7AENanCtGTaXoJ
	2qVktuRWtTAUmDNJsZf6DmoiwxYecuLyk3/FuZ3WcRd0z4mqr5uCz31o7LA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk386b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so54576485a.0
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262123; x=1787866923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwULhjudGmxSOoYi+ERFWqMhOqB03wQScF80uC4a0ZI=;
        b=j3HFyhTG14Oehx2kbCgA5GJx6LNH8ttD6wu1P5SO8WpFPbBMe9i6wtRj2tdIoC0cuS
         iqzmGLauunAPORj0hXSW0CLPD08DYxxyMpDhG33zK/7qMIsZWzTr9MT+FE5VhOHxUKXW
         XkgZ9t060G3bfH5rlFnpzVo9EPOqQFWV1wItO1p2jmZk6Zbv+ICz7bU9RwaV9JBsi80v
         KxYeyF0Q4Wjr6bCfP3MutDERWB3gMqSoG5M1naku8ZYoLzhpvRr2pGfWaiOpXRmMpcgo
         pCTVnru4mNoELgzqFCCH0brFYx41xoKQL4HlsBIn4vQjzMHihj8fhjwxvST+b6MsBQ3q
         UdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262123; x=1787866923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwULhjudGmxSOoYi+ERFWqMhOqB03wQScF80uC4a0ZI=;
        b=QUkC1smBHwL7G58NR0JVv3NZ5fwukr7eCbOtH0dbjp5Lhqb7ZTyxLV8LeQu/Tpd6c8
         L0xRnWcLEqBB88ITOG48K9p+V508GFyEtPRgfDA7ExH1NKDmjjGO6fUz2mFd109vkZwh
         KJXSCufdXUsFkKCm8LmkhpqpgVpyaifCZiqpTUcSuTXun0yfso60Lz8zzbwCNngwPZsC
         clL2w7VZ915qwTiGic1W5vqOmNzefSKbfW04QNMJRzOQn2HxJrK2Pkqdl4Wm7ioKsN4V
         SqCP9bWqZSsW6Pvu0xZL8GFxxcj1bQ2dzxvFksLp5pClZmfKmsMEkIBXrz/3id0yEfks
         jRCA==
X-Forwarded-Encrypted: i=1; AHgh+Rri8tvp0US6+Gz/xOT1j8mb+qvYOR+G5sRi1r6XZk8xvZGQaNuixloo2YYLTDLz3MRjLKZBjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwG5XxMuSGP5zizL1wx11hcOWFjBcri9LLgUteh9+aUQUsiGBgT
	i9SspiUoFNW6Ndm0bNNaSj64Jv0Ih7XTl0DmYLqJMHd0hE6gf+rcEMzMf5mjBV1P+tfJpdWhQfT
	8VMKUv1aPaRYH/gVIwK/LsoZ8M2jAEua/mbOM4QYwDdPtEdGbcOchTjW/0Q==
X-Gm-Gg: AR+sD10oBNbkhhLHU37vTa/R4v+EB5xBZSNCDuLb3mxuTN1q8BUaPwofT4kXpWQfxro
	cc0OcXcTYFfhfnF0Qjfm5gbpockziLauumM+jANj7/SzVaoH3SNk08kOGgKXTN8fp7/rG2mO9XJ
	V9sV7W+dbT9mqyLY4K5t/jScKDM615TV8ZH5izLJJeJd/m2JKbLw8gQRub1B3Y0UAiKtei+uv+b
	uHR7pSYxnxbupMzm9coLuiZbkRMBd+cJ4ozIdEc+cdqIn4H3G54L1AvFPhK22Kg40YE6F7vf2PH
	zaP2m1xmNaYxLapnT2eUUrdu5HzoGgBJWkgQYC4XIKJSmuGq8nuLVMfAT01S1DDogDKnElW3int
	NOciHhEhi
X-Received: by 2002:a05:620a:3952:b0:937:39a0:a15d with SMTP id af79cd13be357-93739a0a4e7mr100182785a.41.1787262123590;
        Thu, 20 Aug 2026 14:42:03 -0700 (PDT)
X-Received: by 2002:a05:620a:3952:b0:937:39a0:a15d with SMTP id af79cd13be357-93739a0a4e7mr100176985a.41.1787262123167;
        Thu, 20 Aug 2026 14:42:03 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9bb47b3sm293655e9.3.2026.08.20.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:02 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 05/21] iommu: Document MSI mapping during domain replacement
Date: Thu, 20 Aug 2026 23:41:34 +0200
Message-ID: <20260820214150.545737-6-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: t7jCvv3oQyL7NtPzKOJTL3qxAiBJAAg9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX05r+ZHv8rbHk
 zCpo78htPzzxzhETcChIPKcXlDRZzOcwXf4I3KXn1oaPSCZCCDVeSMGBrPea8Dw4RCfuKcdTnKc
 9oad98N++si2wUqOJIrDfdVysoPoPQQ=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a8774ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dE3YUn1xrUNcRiCJ4h8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXwEohX3QD07Va
 HbQMMeia2Nx8MKSYQLxYC/nR+7gqbaE+SzJhYtL/+So4euWX7yWa5E8wuDFvwi1t0Uph6bj7Mgu
 SPY4Uz3vZwLJrhLeO5hYSq4dMOnU/cn1tAtOoLz9yZMkTwKlJGB6RA4H3yBcgQf0zNvr527rkB2
 daC9wtCHCyBlwE72VnQA7eLhCPZXQjrHq+KVuVUnQqPUMZHaJaNri67196pveItgWKKOeVsvaP4
 +8FV9aSBX1BY6RJJkyaeTfkzgxz+TcuXyico5nxohy1ZdpviNpMdZZlQYFf9Ialtq6ZchgLpW/6
 Wk8FIFyMcTAUy5UJwrpwPp4HA8J5NL+UkI4gEWlYwjxV8r8GyahI69CHtlCyta8M0HE0GesMKAl
 BEV2AkdtA5RmDuqa/aN02twNiltRlRh1lqjR2lgfLNTqhgBZdwSuZxb6gkvNm14iwLQH1Vn1IVS
 lOgAl0hSPSmPV40t8dQ==
X-Proofpoint-ORIG-GUID: t7jCvv3oQyL7NtPzKOJTL3qxAiBJAAg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

Interrupt-remapping drivers may need to prepare software MSI mappings
for an incoming domain from their attach_dev() callback. At that point
the device is not yet attached to the supplied domain and, for an
iommufd replacement, the current attach handle still describes the old
domain.

Document that iommu_dma_map_msi() supports this use. Clarify the DMA
backend only requires a compatible device and that the iommufd backend
intentionally combines context from the current handle with the
explicitly supplied destination HWPT.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c      | 7 ++++---
 drivers/iommu/iommu.c          | 5 +++++
 drivers/iommu/iommufd/driver.c | 8 +++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 39ee5f0b1da9..030948a7e6b9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2252,9 +2252,10 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
  * mapping granule. Used for pre-mapping MSI targets before any MSI
  * descriptor has been set.
  *
- * The caller must pass a device attached to @domain and hold @dev's IOMMU
- * group mutex. If @required_size is non-zero then it must exactly match the
- * domain's MSI mapping granule. @msi_iova and @msi_shift must be non-NULL.
+ * The caller must pass a device compatible with @domain and hold @dev's IOMMU
+ * group mutex. @domain may be the incoming domain of an attach_dev() callback.
+ * If @required_size is non-zero then it must exactly match the domain's MSI
+ * mapping granule. @msi_iova and @msi_shift must be non-NULL.
  */
 int iommu_dma_sw_map_msi(struct iommu_domain *domain,
 			 struct device *dev, phys_addr_t msi_addr,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 84b60d0f8c23..389d67c4bda3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4272,6 +4272,11 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
  * stop the domain from changing between iterations, leaving the table
  * inconsistent. The caller locks once around the whole loop instead.
  *
+ * @domain may be the incoming domain of an attach_dev() callback. In that
+ * case, @dev need not be attached to @domain yet, but it must be compatible
+ * with @domain and the caller must keep the current group attachment stable
+ * until the callback completes.
+ *
  * Return: 0 on success or negative error code if the mapping failed.
  */
 int iommu_dma_map_msi(struct iommu_domain *domain,
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index b39796bc7251..358cc6d87941 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -281,9 +281,11 @@ int iommufd_sw_map_msi(struct iommu_domain *domain, struct device *dev,
 		return -EOPNOTSUPP;
 
 	/*
-	 * It is safe to call iommu_attach_handle_get() here because the iommu
-	 * core code invokes this under the group mutex which also prevents any
-	 * change of the attach handle for the duration of this function.
+	 * During a domain replacement this returns the current handle, not the
+	 * handle for @domain. That is intentional: the current handle supplies
+	 * the stable iommufd context and group MSI window, while @domain selects
+	 * the HWPT where the mapping is installed. The group mutex prevents the
+	 * current handle from changing for the duration of this function.
 	 */
 	iommu_group_mutex_assert(dev);
 
-- 
2.43.0

