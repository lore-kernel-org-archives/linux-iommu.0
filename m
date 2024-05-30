Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F81176222;
	Thu, 30 May 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077144; cv=none; b=kvzdxWMYoiWqyngpxmcJT2b1HyLsWtONlcdQT0Ih4t9reqE60hbTP5T6Wiwb+RU1ksMEITNrcYG0Yfwt/Lknljct5mOo7IkI8L0MFsm/A2JGeZrMwUTZa9TbFDQVUrAA3p2TyMFDGr4ZRVaDLZzfa/9gF8QD4SuG5VJJeKgbky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077144; c=relaxed/simple;
	bh=dJk1hw65s2M5BumD/q/+fzgJ264MkZ64H9w8F8thEdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uIOLy0BTFphkm/bXsSa80oYViWsHcfeRHx6b5lUrfm3Y4ArDVUBO7yF9QJDkus5jJSYnOjfC63j/HsIYwLb0qtgkrMVUD0+VxsZ2ZzPq/bJKJeQpQuhjCh5J0IsaMQbkAdUQ2g0+2bsosbANvpwdX2/6bh7onu5Dqs5E/75drnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WZnkqbdb; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WZnkqbdb"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UBNCHx009437;
	Thu, 30 May 2024 12:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=cc:content-type:date:from:message-id:mime-version:subject:to; s=pps0720;
 bh=tIqaGLJOOjfMcTh/JD+veKn193AI6E0EN44ddHZZtjo=;
 b=WZnkqbdb7JZaqKMOxQc1yTK06IMWbMNeG23paKq3UNBOVABX1ueQFywilAOKZKNIp8H6
 h/bDyzp+pef7PBc3P3HZ2CGqF7o3FA8vSRbEEw4m+sqw52dWwMRChi4HPdtFxGEQ3iNB
 0FgTzjbxDqGXP4U3L/wHfsk4yvokN+lAGHl+RNtb/kqEjn3qCLts+k9AOLNKZlFT3dip
 5My52RWHn2Vn8idmBhGGzfnPc19lZvqmZ1YrqPTv2EnuPQZZmURzT/7Z+a1VcDWxj2iB
 jCv2769hSc4vC2UiGkqndYh9F4YsBa7ItiBd/CJAgm2/cJkaR/uvU34Acu7jRfcIuyg4 lw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yerha0pcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 12:57:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 21F4912B7C;
	Thu, 30 May 2024 12:57:08 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 236A28005DD;
	Thu, 30 May 2024 12:57:04 +0000 (UTC)
Date: Thu, 30 May 2024 07:57:03 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Wang <00107082@163.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dimitri Sivanich <sivanich@hpe.com>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] iommu/vt-d: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <Zlh3nz2Ij06TY4cr@hpe.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: Oq7tHGyOC6XVrpmMOk2OTieqjTrVKiOM
X-Proofpoint-GUID: Oq7tHGyOC6XVrpmMOk2OTieqjTrVKiOM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300098

This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
DMAR fault interrupts locally").  The panic happens when
amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a18e74878f68..b02b959d12af 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
 	return 0;
 }
 
-int __init amd_iommu_enable_faulting(unsigned int cpu)
+int amd_iommu_enable_faulting(unsigned int cpu)
 {
 	/* We enable MSI later when PCI is initialized */
 	return 0;
-- 
2.35.3
