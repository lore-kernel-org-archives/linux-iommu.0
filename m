Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057AA30648C
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920661; cv=none; b=l+iHaOz9lqNZsScuqlk2tJeEesoDCnI7ADIiw3SMII5yWkMHJtBmYvSDELb6e26wkBmDdBSNf7HsFDEqEx5Nc4eMGBtVRZ0Fxq/8z44hiQGA6zbn+Y8T6PqTM8e63gmemz614kdOiYx757iEjxWUp6ZHqAPdM+WHKJGVXWhZCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920661; c=relaxed/simple;
	bh=Xt2L6F/bT+LJxx/TIsAR7YPjVPf9bHwzT5NI0Z7ymg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biu7koyRVGSajaPTfl9Bu2TiMkURlFkKlSMQ6bvkKDUqUxyGWsI7xvD6LSl+y91IKW4Maqem9nKeM1oogQsvU8T/2g7ZmV0WXu2jNVR7fbgnrC1F3GWDcs2kJire/YMRMHg9jWrXjqiZYiasZG9n6q/IWD5+dGFKT67ms7Z25DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y910v+Y5; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y910v+Y5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CgZCf1MgQGSCarsBSZXbw8T1G4s93KyaAhqYm1OiBLo=;
	b=Y910v+Y5eABPY8kElCpbNXnpm2xezNE4Caxux5KPcjkB2OiwgCEPofiZ4H39hZMotPTUZ1pT0
	QwODdXsF1+whgUYKAkKsA4181r7iNN2j4YjofMgWa+hWK1KS287eBD7b2GTPI75c6P18wQFBKnu
	KbWB+IMvJADzkKZ1CpMkGkg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hfkqg298VzLlX5;
	Wed,  9 Sep 2026 10:13:19 +0800 (CST)
Received: from whupemk300003.china.huawei.com (unknown [7.152.185.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D79C4048B;
	Wed,  9 Sep 2026 10:24:13 +0800 (CST)
Received: from huawei.com (10.50.87.204) by whupemk300003.china.huawei.com
 (7.152.185.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 9 Sep
 2026 10:24:12 +0800
From: Zhang Yuwei <zhangyuwei20@huawei.com>
To: <quic_vjitta@quicinc.com>
CC: <zhangyuwei20@huawei.com>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <robin.murphy@arm.com>,
	<quic_prakgupt@quicinc.com>, <chenjun102@huawei.com>
Subject: [RFC] Partial iommu_unmap issue with contiguous PTE hint enabled
Date: Wed, 9 Sep 2026 10:18:55 +0800
Message-ID: <20260909021855.520173-1-zhangyuwei20@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk300003.china.huawei.com (7.152.185.49)

Hi Vijayanand,

I have a question regarding the contiguous hint patch set:
https://lore.kernel.org/linux-iommu/20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com/

We encountered an issue during partial unmapping when contiguous PTE
hints (CONT bit) are set. Here is the scenario we observed:

1. Setup / Mapping:
   - Under 4 KiB page granule, a 64 KiB memory region is mapped via
     dma_map_page() (or iommu_map()).
   - Because the 64 KiB range meets the contiguous hint requirement
     (16 x 4 KiB PTEs), all 16 PTEs are programmed with the CONT bit set.

2. Partial Unmapping Trigger:
   - Later, iommu_unmap() is invoked to unmap a 32 KiB partial range
     within this 64 KiB block.

3. Observed Behavior:
   - Calling iommu_unmap() triggers a kernel WARN.
   - Only 28 KiB is successfully unmapped before the operation halts.
   - The remaining memory in this region can no longer be unmapped,
     leading to leaked/stuck IOMMU page table entries.

4. Questions:
   - Is partial unmapping supported when contiguous PTE hints are
     enabled, or is caller-side alignment enforced?
   - Should io-pgtable (or the SMMU driver) handle clearing/splitting
     the CONT bit prior to partial unmap, or refuse the unmap gracefully?
   - What is the recommended fix or expected behavior for handling
     non-64 KiB aligned unmaps over CONT-hinted regions?

Any insights or guidance on how this should be handled would be greatly
appreciated. If needed, I can provide additional logs or help test
potential fixes.

Thanks,
Zhang Yuwei
