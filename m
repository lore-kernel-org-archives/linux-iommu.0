Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90741A79C
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417809; cv=none; b=W4peeOQyjB5tNHvitakavgCaKDND25eO6CfZdh7etPGIZa6H498oG64uIqsOIPqVKhqGgvlFy7ZiWa61kn8SiLbcTCmFXZIfIwZeye9VqChYxcSLivgDc9Id0S6fu5HfYu953YMqasZQKIcK4zvbp2KiUQdXSgrhN3qp7bErlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417809; c=relaxed/simple;
	bh=+NJ/ZAQp8Bx7gYX+ZPyJGQrkOCVSPqOKt90tXeMDGR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPnZGKDtYPFKjSCVubIspaK5IVce29DUuJhAc8nxWBAoI+MSf5C7cR3as6Y5wYEjjliTFztqAMwZ97Wb5vuuAT5OOi90a8rw4D78oI4qrDxYMU2kgttHL3WNBtTQqCVJjwqe/pnzN53w/F2tS5pG4BFebv2x+Vuz4LtUKgLDHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rj9xQsWB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4dizxOq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rj9xQsWB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4dizxOq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDHx92094009
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Cryef6XGMhXyLL9OOAsUdqXxAu5bllxJHnL
	yqgrWwsU=; b=Rj9xQsWBfDHrtfIiFeeuZILkzUXQCkLxt2VyV+k8neyxYJnqoXp
	7QRC4PWff65XnS/di9yXk2Kbz/VEikpDcyNESGfQKQteDhp4QznSyK22NMDsv0S+
	dmK1GzaVhbni9kKNscmtFTaaFP2ohapZKNxhCfaiKmIVCDBqSH4SGWJZG4ojr370
	wBoEa6V6FMFf0C0+qSi67FS7jLjRqsAU1A2HGkEJzehjoILduzKrThKFESPpb8CA
	V5vEM+MJ8ggRzrar4Yj6Or3NR18kuP22saEjG0wiMBfCOjnW6cfVGMAeWsCb/+2l
	c8Oeb9SAiZkceSsYCiQOtAdI4WMVoFO7YvA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ky87un-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:23:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-520a00c7a03so39337721cf.1
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785417806; x=1786022606; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cryef6XGMhXyLL9OOAsUdqXxAu5bllxJHnLyqgrWwsU=;
        b=V4dizxOqyGsKufYZziJw+UcbMWuOvfIL+buOtbOccBNUiyulhy1J2/YdvBjSlpVBwU
         Fxa/7FVYb5vSb087Ix0zla5WrdBo3ma7B5y2+shjeNg0SCcRedtLlmuW1cy2KGmpAPQS
         AyH+bSWaLK2iSmBWm4kAX4Rh8bKJ4/xID06p+uIJ2ff6ykEy4XDyqNfS572qbH8u8Xxa
         9Vn1L6/WnCEC5LKbuTfuGgdoZeTERGpcmn+KhL8S34uqO4FKWSVGkWqAwJtgsvuNCv6W
         1m9OJBknQ48ciVOIu0kPC1AzipKjSsSy04ZCzjfp2Ih0MsKltN9tH5DU3a3oBA1MFhTf
         pl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417806; x=1786022606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cryef6XGMhXyLL9OOAsUdqXxAu5bllxJHnLyqgrWwsU=;
        b=T6/qPS1AvfJMV/Ju7bvssc0YLHzlnz1oDePjzvaSFgzmwGuri7bvACQkiXxpgdqijp
         1SW7CZzkT85TpP4N0kRlz5G2MvbQxz3lkNVvfZW47ZFdx50fnTPUjSLpnIJvHEmJwshl
         PTN/1eG96R2in0i8vSHzNNd2p7OP7jOA1Ncob+6IVsoY17en9vmgyDEg2MvpDS6QImxf
         ZpOnVsGwP59Yr+QdfVY4Mc9ourUAvisM5aw3XGXvD5Issq3gA/xBj/10rtrql5gO/XN3
         DW7xrV2ppIyEYruCS3WXYTWFwmy03pQB+66UCuynSxw62NmwjlAmqqtM/UvHz+DDGdJF
         5gzQ==
X-Gm-Message-State: AOJu0YwLzjuuT8vJLV+1WbXJLvocQDSeuUh5ISD74Lo+sPbeWyTRPAQX
	9cz60oI/4dTlHJu/Uh/lGUlkHdRLaSOIMgGB38jtF4WR3fAzn0vlq5nlDTCozLCeL8ToYqH7Bde
	u4+OOCAbqq9q+sPJjxg4tPJphnXL9lnlTs+aM13N63LihLn104G92snHIkr7ud4MEhw==
X-Gm-Gg: AR+sD10sC4cBLGpKj0d61EmSPkvqXdtB2gdzRSnijCZdrjnoti5hPNv5EFxOm64HExF
	bjV4EZNqS/rf4JlUmnaAS5fDyU2nQlIUlMMy66oLrl3jFc353IgwVxQpWrXPxdHewad7iBUwsS5
	uSiW1V8GqCSLuEcphfDUH6AQtOTGD++Mvd/LKCEPCSwdL1CZ6v1xUtyCf5XyEInmoE9a5DKtBde
	2HuxkkDGsDMPbBIVckRO6vbbfNpDxyLXvA/EYIHPY5qDe3RBmTvOxDI4OhqIlBWppPJtiyuTvI+
	sGtuAL+Yzl2SH/g98YENVjWCcUwerpkzOXaGHdA/1rrrdiASzEBVnJ/nTOC9UdUnBQEWbkAwkvN
	asbZ87uhXBxTxPkuQ9WAW+ZBsDu1BXcmmBM7/dlw=
X-Received: by 2002:a05:622a:507:b0:521:987f:bf28 with SMTP id d75a77b69052e-52b386a9958mr28655741cf.46.1785417805948;
        Thu, 30 Jul 2026 06:23:25 -0700 (PDT)
X-Received: by 2002:a05:622a:507:b0:521:987f:bf28 with SMTP id d75a77b69052e-52b386a9958mr28655381cf.46.1785417805458;
        Thu, 30 Jul 2026 06:23:25 -0700 (PDT)
Received: from localhost (cst-prg-94-50.cust.vodafone.cz. [46.135.94.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6dd7sm67631066b.52.2026.07.30.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:23:24 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        nicolinc@nvidia.com, jgg@ziepe.ca
Subject: [PATCH v2] iommu/dma: Restore locking around msi_page_list
Date: Thu, 30 Jul 2026 15:23:23 +0200
Message-ID: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfX8Y2prUJiY1GC
 uDt+tGVC8foqcx4Zk8ndEOBaZRWFub7azADYSbRtJ6aEP0X+sEp9/yIip5MsPgrqAywo8t8bjb9
 gdjpJMTR0vnwAQPY1roKE/DxeWhsl9+NumGnwgIQuL35bFZDs03NrLOUTlBKMR3HCdJsFLYvcjA
 QaG0fNjOHwOT4mVfKTWyXIBV8tZ98xiu5SGcjFBRWwrt18/J7pkF0Fqo2rGHf/tShL67dIm6ak9
 nxvnTNGOKsK0CtU+CrRxvQdY/7+5/qLUFTcrOul8OQk1IhRLcUJUQSreRX+l1C4KEKDOSSF/6m2
 VjxpXMsi+tgTtWub/KUTXtd7d0CAKZNNVu8jtfS+IfC/P9HUNmB6HiSm1D2r1roUJYF7fMbIEXk
 ooMBke4f/ug8rgvzav0usD5G2QnXWA1vfM2uNOKcF7cwaiXDyJcuxPya9Ne1Ojk9sGy32/p726t
 qkWeO4oTRtiu/c0/rBA==
X-Proofpoint-GUID: -4S5GWzEv3j9QZ25dn3pI5Ne0Axcp5Mu
X-Authority-Analysis: v=2.4 cv=ctOrVV4i c=1 sm=1 tr=0 ts=6a6b504e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=K44ovq/QSKyRiRxWKRAbdQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VipQKgRDtvKhlPpv3xkA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: -4S5GWzEv3j9QZ25dn3pI5Ne0Axcp5Mu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMSBTYWx0ZWRfXzFbyap7tOgoC
 xwvlY+wXN23LVr1tYeVkAcYxWGq6w7Fz88nxyd1lre0YcNaxwt2QdiRPvF89zU+uwaOfSA2KUsM
 0z/Mnl+BCkxs0L8dHzsJN9tmTDYQYnQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300101

Unlike a group's default domain, which is always freshly allocated
and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
legacy container merges any newly attached group into an existing
domain whenever their iommu_ops and cache-coherency enforcement match.

iommu_dma_get_msi_page() only asserts the caller's own group mutex is
held (iommu_group_mutex_assert()). On an IOMMU that publishes
IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
through the legacy container can have their guest drivers probe and
allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
on a different device fd and group mutex, but both devices' domains
are the same merged domain, so both can enter
iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.

commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
generic operation") dropped the prior msi_prepare_lock on the
reasoning that "each iommu_domain is unique to a group," which holds
for default domains but not this VFIO type1 case. Restore the static
lock, since it's only guarding a corner case and will likely never
be contended.

iommufd avoids the equivalent problem by having its own callers
(iommufd_sw_map_msi()) take a ctx-wide sw_msi_lock before ever
reaching the shared list. VFIO type1 can't mirror that since it
dispatches to iommu_dma_sw_msi() which is outside VFIO's jurisdiction.

Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
Sashiko reported this issue while reviewing a riscv iommu series[1].
I've only compile-tested this fix.

[1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com

v2:
 - switched back to statick lock as 288683c92b1a had [Robin]


 drivers/iommu/dma-iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..9a07eb39336e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2204,6 +2204,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 	size_t size = cookie_msi_granule(domain);
+	static DEFINE_MUTEX(msi_prepare_lock);
+
+	/*
+	 * Normally a device's default domain is only ever attached to that
+	 * device's own group, and the group mutex held by
+	 * iommu_group_mutex_assert()'s callers is enough on its own. A VFIO
+	 * type1 container is the one case that breaks that assumption: it
+	 * can merge devices from different groups onto one domain, so two
+	 * devices' group mutexes don't serialize each other here. A static
+	 * lock is sufficient due to the expectation that this is a corner
+	 * case that will never be contended in practice.
+	 */
+	guard(mutex)(&msi_prepare_lock);
 
 	msi_addr &= ~(phys_addr_t)(size - 1);
 	list_for_each_entry(msi_page, msi_page_list, list)
-- 
2.43.0

