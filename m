Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B47E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:46:32 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMwnN6JMYz67Y4M;
	Wed,  7 Sep 2022 16:45:28 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 10:46:28 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 09:46:28 +0100
Message-ID: <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
Date: Wed, 7 Sep 2022 09:46:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: Robin Murphy <robin.murphy@arm.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
 <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
 <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
In-Reply-To: <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 06/09/2022 19:25, Robin Murphy wrote:
>>
>> Caveat: on the chance that the IOVA domain init fails due to the 
>> rcache init failing, then, if there were another device in the group 
>> which probes later, its probe would be ok as the start_pfn is set. Not 
>> Good.
> 
> Yeah, there's a lot not to like about iommu_dma_init_domain() - I've 
> been banking on it all getting cleaned up when I get to refactoring that 
> area of probing (remember the issue you reported years ago with PCI 
> groups being built in the wrong order? All related...), but in fact 
> since the cookie management got pulled into core code, we can probably 
> tie the IOVA domain setup to that right now without much other 
> involvement. That could be a cheap win, so I'll give it a go soon.

ok, great.

On a related topic, another thing to consider is that errors in IOVA 
domain init are not handled gracefully in terms of how we deal with the 
device probe and setting dma mapping ops, ref iommu_setup_dma_ops(). I 
assume you know all this.

> 
>> - vdpa just fails to create the domain in vduse_domain_create()
>>
>>> That makes a fair amount of sense, but does mean that we're missing 
>>> the equivalent in iova_rcache_insert() for it to actually work. Or we 
>>> just remove it and tighten up the documentation to say that's not valid 
>>
>> I'd be more inclined to remove it. I would rather remove fathpath 
>> checks as much as possible and have robust error handling in the 
>> domain init.
>>
>> Afterall I do have the "remove check" craze going.
> 
> Sure, like I say I'm happy to be consistent either way. If I do end up 
> reinstating such a check I think I'd prefer to have it explicit in 
> {alloc,free}_iova_fast() anyway, rather than buried in internal 
> implementation details.

I'm not sure what you would like to see now, if anything.

I could just remove the iovad->rcache check in iova_rcache_get().  It's 
pretty useless (on its own) since we don't have the same check on the 
"insert" path.

Or also add this:

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0d6d8edf782d..e8f0b8f47f45 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -578,6 +578,12 @@ static int iommu_dma_init_domain(struct 
iommu_domain *domain, dma_addr_t base,
  			goto done_unlock;
  		}

+		if (!iovad->rcaches) {
+			pr_warn("IOVA domain rcache not properly initialised\n");
+			ret = -EFAULT;
+			goto done_unlock;
+		}
+
  		ret = 0;
  		goto done_unlock;


But I figure that you don't want more crud there now, considering the 
work you mention above.

Thanks,
John



