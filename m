Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89839B979
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674548; cv=none; b=NRIBiiGHhbOfmWp/yWOTeHo5MLr5xWBcVNNPMPsCN8cZVE9sV+0QVEQmjT4uXDCFwzrs8BZ38goGDe2IFqIi1NUtIkoexJic7QShjP74B8WeX+YjePqzEQiJuwGww+cYxOuWY3+hMyACRrqVhVaVPf3tImHzDadW4UGn/MaHYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674548; c=relaxed/simple;
	bh=T78JQ9XuwFC6VJEbhSrqz/ZlHDW5ApRQmYYffXxasCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GWtA3sFNct3ONagpgHwXmpFVhPvkuRxmhaqY4x7cV4+H9lINAV+j50dsvoBUmWOhpHGcvB1tKVRiH3ny+/9pibKZU1iFo5VbaSFQ6zQ96vJq+7hi5mDro2uTqrgWfchjI2xXTjjHg9QNQTXazbAmnU4OGuJZLqUoGh2hz9YYIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l39lPJUn; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l39lPJUn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XsiG+kTNf/QMEaWMVDL6EoUgMvPdLZhdxKE1/mgiJDQ=;
	b=l39lPJUnUsgcJ1gnQjhaS8JzsYuwfn5WLJ6xkqEpty/1ZQ76h9OxO5w1TOLWVrwW9941juFfP
	C9aX5zuDHrhkVL5OVp5qKgnvJc9FXyr87ojapcO3csqzC8KOrKMl05IcFPTW9Wqr7IJiA6qVhGD
	vgbT6G7yJJ791AvQS4VQAME=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fZJbb45ndzpStq;
	Mon, 16 Mar 2026 23:16:59 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 333DB40363;
	Mon, 16 Mar 2026 23:22:20 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 23:22:19 +0800
Message-ID: <c6d68e28-30fb-40cd-8f3e-5ad47c54b233@huawei.com>
Date: Mon, 16 Mar 2026 23:22:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add register display to
 debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-3-xiaqinxin@huawei.com>
 <abRxh24wATp9r6+F@Asurada-Nvidia>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <abRxh24wATp9r6+F@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/14 04:20:23, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On Fri, Mar 13, 2026 at 06:43:48PM +0800, Qinxin Xia wrote:
>> +/**
>> + * smmu_debugfs_registers_show() - Display SMMU register values
>> + * @seq: seq_file to write to
>> + * @v: private data (SMMU device)
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int smmu_debugfs_registers_show(struct seq_file *seq, void *v)
> 
> @v seems unused as well.
> 
> Nicolin
> 

Thank you for your review. All comments and function encapsulation
problems will be fixed in the next version.
-- 
Thanks,
Qinxin

