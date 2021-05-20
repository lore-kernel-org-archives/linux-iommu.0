Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC8C433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:29:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CBE611AB
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CBE611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F26F60716;
	Thu, 20 May 2021 03:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouC2TvHZGXXI; Thu, 20 May 2021 03:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D39A66060E;
	Thu, 20 May 2021 03:29:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E05C000E;
	Thu, 20 May 2021 03:29:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40141C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26D2B60615
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LAurMEJzVzYj for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 03:29:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D27FD6060E
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:29:52 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlwCB1z6mz16QGL;
 Thu, 20 May 2021 11:27:02 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:29:48 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:29:48 +0800
Subject: Re: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Rob Herring <robh@kernel.org>
References: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
 <20210519191450.GA3469078@robh.at.kernel.org>
From: Xingang Wang <wangxingang5@huawei.com>
Message-ID: <cd453893-3e3b-93ec-b826-9103677ac4f5@huawei.com>
Date: Thu, 20 May 2021 11:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210519191450.GA3469078@robh.at.kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, devicetree@vger.kernel.org, will@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, helgaas@kernel.org,
 gregkh@linuxfoundation.org, frowand.list@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/5/20 3:14, Rob Herring wrote:
> On Mon, May 17, 2021 at 01:17:05PM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. This patch add check for IOMMU in of_core_init(), and call
>> pci_request_acs() when iommu is detected, making sure that the ACS will
>> be enabled.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/of/base.c        | 9 ++++++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> Change log:
>> v1->v2:
>>   - remove pci_request_acs() in of_iommu_configure
>>   - check and call pci_request_acs() in of_core_init()
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a9d2df001149..54a14da242cc 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>   			.np = master_np,
>>   		};
>>   
>> -		pci_request_acs();
>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>   					     of_pci_iommu_init, &info);
>>   	} else {
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 48e941f99558..95cd8f0e5435 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_graph.h>
>> +#include <linux/pci.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>> @@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
>>   void __init of_core_init(void)
>>   {
>>   	struct device_node *np;
>> -
>> +	bool of_iommu_detect = false;
>>   
>>   	/* Create the kset, and register existing nodes */
>>   	mutex_lock(&of_mutex);
>> @@ -180,6 +181,12 @@ void __init of_core_init(void)
>>   		__of_attach_node_sysfs(np);
>>   		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>>   			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
>> +
>> +		/* Detect IOMMU and make sure ACS will be enabled */
>> +		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
>> +			of_iommu_detect = true;
>> +			pci_request_acs();
>> +		}
> 
> Private DT internal init code doesn't seem like the right place for
> this. If this needs to be ordered WRT PCI device enumeration, then
> somewhere in the PCI host bridge or bus init code seems like the right
> place to me.
> 
> Also, shouldn't this be conditional on 'iommu-map' being in the host
> bridge or a parent or ??? rather than just any iommu-map anywhere in the
> DT.
> 

Thanks for your suggestion, I will fix this and move the modification to 
procedure of pci_host_common_probe(), and before pci_host_probe().

>>   	}
>>   	mutex_unlock(&of_mutex);
>>   
>> -- 
>> 2.19.1
>>
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
