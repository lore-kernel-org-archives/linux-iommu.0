Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3554156F27
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812992; cv=none; b=YDApEpn2HuW+VJvip2yOCLxqAm/UkLCdMoGwzGZYgsY5BqUTjP7FVjJtb8aBhL8arn5peJB35YN2S/Ht8jGe8bb1WG/FeiJkx1R+AdPQV4R//u8+HMUDEnXgARAws+yYhEnvc7j2eInuMciEPQaaXD/K+3hG7wJin5vSjP5LRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812992; c=relaxed/simple;
	bh=jQjLqFWu1Xw/tSUobdyWwC1K5JFom4ClBwkQnU07OH4=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N1h0UZlTyQefooZL0H0JPhiL+b6M+zI0ig/imWfrK1n5kclojC4jiZzHtFQwSoUHQgCuysocmD+cHNKX8ulmxzQ2nvNtuBvoXRkkuhz/6K63GTUh+DfoHBMqa/RVKd8oTHxhFAk+CEVPgEogQSlz6h0SJK5cvTRxRqqSFSPjCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WTT6726sPz20lW6;
	Wed, 24 Jul 2024 17:21:19 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 489111A016C;
	Wed, 24 Jul 2024 17:23:01 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 17:23:00 +0800
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
From: Kunkun Jiang <jiangkunkun@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit
	<mshavit@google.com>, Mostafa Saleh <smostafa@google.com>
CC: "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
	<tangnianyao@huawei.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
Message-ID: <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
Date: Wed, 24 Jul 2024 17:22:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi all,

On 2024/7/24 9:42, Kunkun Jiang wrote:
> Hi all,
>
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> 1797                 while (!queue_remove_raw(q, evt)) {
> 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> 1799
> 1800                         ret = arm_smmu_handle_evt(smmu, evt);
> 1801                         if (!ret || !__ratelimit(&rs))
> 1802                                 continue;
> 1803
> 1804                         dev_info(smmu->dev, "event 0x%02x 
> received:\n", id);
> 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
> 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
> 1807                                          (unsigned long 
> long)evt[i]);
> 1808
> 1809                         cond_resched();
> 1810                 }
>
> The smmu-v3 driver cannot print event information when "ret" is 0.
> Unfortunately due to commit 3dfa64aecbaf
> ("iommu: Make iommu_report_device_fault() return void"), the default
> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> be added here?

Additional explanation. Background introduction:
1.A device(VF) is passthrough(VFIO-PCI) to a VM.
2.The SMMU has the stall feature.
3.Modified guest device driver to generate an event.

This event handling process is as follows:
arm_smmu_evtq_thread
     ret = arm_smmu_handle_evt
         iommu_report_device_fault
             iopf_param = iopf_get_dev_fault_param(dev);
             // iopf is not enabled.
// No RESUME will be sent!
             if (WARN_ON(!iopf_param))
                 return;
     if (!ret || !__ratelimit(&rs))
         continue;

In this scenario, the io page-fault capability is not enabled.
There are two problems here:
1. The event information is not printed.
2. The entire device(PF level) is stalled,not just the current
VF. This affects other normal VFs.

In addition, the same problems exist in the bare-metal scenario.

Thanks,
Kunkun Jiang

