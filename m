Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC515A8
	for <iommu@lists.linux.dev>; Sat, 30 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711761590; cv=none; b=tRaXURYcNsDw8Y535r6aNNb+E+gHSP5LrcKYWmplvEnLxUy8NThE/POwKBqnrXPYEY9yjhhqL0gXTYWZQBOXkcAHVxKvmjFNTjwsIwxp09KGcuzwG+AGcKK2QLDRaZbq7D9CefMPA+J4Ld+cv7cfT6wN76qrzOFMLgMV/IkbwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711761590; c=relaxed/simple;
	bh=SzSwPqnfalelzzooJos0UDdLGmQNrWe+krnbkhcDrLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z3hnVGmWVi3MRJqtnJB0u7h6QnsUSKqC1AW7+zNdtpTCJFdmIbFB9iAPSI1M7sj8/cMmMDcqo9WK4FcgLvMtZovrDc/klzUZtjVQ6S9AmIJ+GLM9qYVuWy5Ns+hpemAJegGjTuMZSo++B8BWWOOSR0J6KAJDeLRXVLYQuuvykW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V5ztt1rQtzbdZy;
	Sat, 30 Mar 2024 09:18:46 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 423D3140382;
	Sat, 30 Mar 2024 09:19:39 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 09:19:38 +0800
Message-ID: <8c424dfd-8ca0-6614-903f-a37dac818d27@huawei.com>
Date: Sat, 30 Mar 2024 09:19:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Content-Language: en-US
To: Dexuan Cui <decui@microsoft.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<mhklinux@outlook.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240329192809.17318-1-decui@microsoft.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/3/30 3:28, Dexuan Cui wrote:

> Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
> io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
> which is actually a negative number if we use "%ld" to print the number.
>
> When swiotlb_create_default_debugfs() is running from late_initcall,
> mem->total_used may already be non-zero, because the storage driver
> may have already started to perform I/O operations: if the storage
> driver is built-in, its probe() callback is called before late_initcall.
>
> swiotlb_create_debugfs_files() should not blindly set mem->total_used
> and mem->used_hiwater to 0; actually it doesn't have to initialize the
> fields at all, because the fields, as part of the global struct
> io_tlb_default_mem, have been implicitly initialized to zero.
>
> Also don't explicitly set mem->transient_nslabs to 0.
>
> Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water marks in debugfs")
> Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient pool usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: ZhangPeng<zhangpeng362@huawei.com>

-- 
Best Regards,
Peng

