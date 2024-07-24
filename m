Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B26AB8
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785352; cv=none; b=X063M50tB2g/RcxZHGWplcV90T737xE09DcXJnflQDaJJZwHcyqklLT9PyLSM21SFVzhWOHWnoI3k6EJOfM3aTag2fgmjjlJpFVZrTF4lBCbggLGXB+0jmwfItsY08Mcp8cqa2H74OQK7++bCPlmoNWH1LFYvTsUBW633bXIstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785352; c=relaxed/simple;
	bh=VFVIpcmr5TxHmnFmmfIZ34n0BSxfcb1XxnLl0Jzxg1s=;
	h=From:Subject:To:CC:Message-ID:Date:MIME-Version:Content-Type; b=XcQuMmUOcvIucFC25ViHQapt2yEjHpPEObn7j6lZsNVZltHK31Xl4sJHX1gWXWnnO9XshxwEptkELRt7YTnmSwcEShFX9UgqwxuAy0K119cL+f848/VE3KaNqzrFdcZC3bHIuox85ukm2vD7ficJyhPC4UG2+ShNmcsBkFJlRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WTGtW6wn6zMqry;
	Wed, 24 Jul 2024 09:40:35 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id DC9A1180101;
	Wed, 24 Jul 2024 09:42:22 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 09:42:21 +0800
From: Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
To: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit
	<mshavit@google.com>, Mostafa Saleh <smostafa@google.com>
CC: "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
	<tangnianyao@huawei.com>
Message-ID: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
Date: Wed, 24 Jul 2024 09:42:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi all,

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
1797                 while (!queue_remove_raw(q, evt)) {
1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
1799
1800                         ret = arm_smmu_handle_evt(smmu, evt);
1801                         if (!ret || !__ratelimit(&rs))
1802                                 continue;
1803
1804                         dev_info(smmu->dev, "event 0x%02x 
received:\n", id);
1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
1807                                          (unsigned long long)evt[i]);
1808
1809                         cond_resched();
1810                 }

The smmu-v3 driver cannot print event information when "ret" is 0.
Unfortunately due to commit 3dfa64aecbaf
("iommu: Make iommu_report_device_fault() return void"), the default
return value in arm_smmu_handle_evt() is 0. Maybe a trace should
be added here?

Thanks,
Kunkun Jiang

