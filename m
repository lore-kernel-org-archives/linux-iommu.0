Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224841108
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 02:55:23 +0000 (UTC)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qs3036WD9zqTHZ;
	Thu, 29 Jun 2023 10:52:35 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 10:55:20 +0800
Subject: Re: [RESEND PATCH v8 04/11] bus: platform, amba, fsl-mc, PCI: Add
 device DMA ownership management
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Kevin
 Tian <kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220418005000.897664-5-baolu.lu@linux.intel.com>
 <6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com>
 <ZJxFZkxvPNj74uQe@nvidia.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c453353f-6fe7-df66-91ee-5b6a36e7d84b@huawei.com>
Date: Thu, 29 Jun 2023 10:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZJxFZkxvPNj74uQe@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected

On 2023/6/28 22:36, Jason Gunthorpe wrote:
> On Mon, Jun 26, 2023 at 09:02:40PM +0800, Zenghui Yu wrote:
> 
>> It looks like on device probe, with DEBUG_TEST_DRIVER_REMOVE,
>> .dma_configure() will be executed *twice* via the
>> really_probe()/re_probe path, and *no* .dma_cleanup() will be executed.
>> The resulting dev::iommu_group::owner_cnt is 2, which will confuse the
>> later iommu_group_dma_owner_claimed() call from VFIO on guest startup.
> 
> Does this work for you?

It works. Please feel free to add my Tested-by if you send it as a
formal patch. Thanks.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9c09ca5c4ab68e..7145d9b940b14b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -693,6 +693,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  		device_remove(dev);
>  		driver_sysfs_remove(dev);
> +		if (dev->bus && dev->bus->dma_cleanup)
> +			dev->bus->dma_cleanup(dev);
>  		device_unbind_cleanup(dev);
>  
>  		goto re_probe;
