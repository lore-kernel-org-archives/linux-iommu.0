Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A4C433DF
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 16:52:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A49A20739
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A49A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A8CC87AD9;
	Thu, 16 Jul 2020 16:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIYkW6oYZ67x; Thu, 16 Jul 2020 16:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1695487AD0;
	Thu, 16 Jul 2020 16:52:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D75E6C07FF;
	Thu, 16 Jul 2020 16:52:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA8EC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 16:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 991D58A876
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 16:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XAPW1CpW5mHj for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 16:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 667D58A5FB
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 16:52:33 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 845DA1299124E69D3125;
 Thu, 16 Jul 2020 17:52:30 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 17:52:29 +0100
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
 <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
 <20200716113234.GA7290@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <cfd36aff-94ae-2019-3331-d43fba01070b@huawei.com>
Date: Thu, 16 Jul 2020 17:50:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716113234.GA7290@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

>>
>> Perhaps a silly question (I'm too engrossed in PMU world ATM to get properly
>> back up to speed on this), but couldn't this be done without cmpxchg anyway?
>> Instinctively it feels like instead of maintaining a literal software copy
>> of the prod value, we could resolve the "claim my slot in the queue" part
>> with atomic_fetch_add on a free-running 32-bit "pseudo-prod" index, then
>> whoever updates the hardware deals with the truncation and wrap bit to
>> convert it to an actual register value.
> 
> Maybe, but it's easier said than done. The hard part is figuring how that
> you have space and there's no way I'm touching that logic without a way to
> test this.
> 
> I'm also not keen to complicate the code because of systems that don't scale
> well with contended CAS [1]. If you put down loads of cores, you need an
> interconnect/coherence protocol that can handle it.

JFYI, I added some debug to the driver to get the cmpxchg() attempt rate 
while running a testharness (below):

cpus	rate
2	1.1
4	1.1
8	1.3
16	3.6
32	8.1
64	12.6
96	14.7

Ideal rate is 1. So it's not crazy high for many CPUs, but still 
drifting away from 1.

John

> 
> Will
> 
> [1] https://lore.kernel.org/lkml/20190607072652.GA5522@hc/T/#m0d00f107c29223045933292a8b5b90d2ca9b7e5c
> .
> 

//copied from Barry, thanks :)

static int ways = 64;
module_param(ways, int, S_IRUGO);

static int seconds = 20;
module_param(seconds, int, S_IRUGO);

int mappings[NR_CPUS];
struct semaphore sem[NR_CPUS];


#define COMPLETIONS_SIZE 50

static noinline dma_addr_t test_mapsingle(struct device *dev, void *buf, 
int size)
{
     dma_addr_t dma_addr = dma_map_single(dev, buf, size, DMA_TO_DEVICE);
     return dma_addr;
}

static noinline void test_unmapsingle(struct device *dev, void *buf, int 
size, dma_addr_t dma_addr)
{
     dma_unmap_single(dev, dma_addr, size, DMA_TO_DEVICE);
}

static noinline void test_memcpy(void *out, void *in, int size)
{
     memcpy(out, in, size);
}

//just a hack to get a dev h behind a SMMU
extern struct device *hisi_dev;

static int testthread(void *data)
{
     unsigned long stop = jiffies +seconds*HZ;
     struct device *dev = hisi_dev;
     char *inputs[COMPLETIONS_SIZE];
     char *outputs[COMPLETIONS_SIZE];
     dma_addr_t dma_addr[COMPLETIONS_SIZE];
     int i, cpu = smp_processor_id();
     struct semaphore *sem = data;

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         inputs[i] = kzalloc(4096, GFP_KERNEL);
         if (!inputs[i])
             return -ENOMEM;
     }

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         outputs[i] = kzalloc(4096, GFP_KERNEL);
         if (!outputs[i])
             return -ENOMEM;
     }

     while (time_before(jiffies, stop)) {
         for (i = 0; i < COMPLETIONS_SIZE; i++) {
             dma_addr[i] = test_mapsingle(dev, inputs[i], 4096);
             test_memcpy(outputs[i], inputs[i], 4096);
         }
         for (i = 0; i < COMPLETIONS_SIZE; i++) {
             test_unmapsingle(dev, inputs[i], 4096, dma_addr[i]);
         }
         mappings[cpu] += COMPLETIONS_SIZE;
     }

     for (i = 0; i < COMPLETIONS_SIZE; i++) {
         kfree(outputs[i]);
         kfree(inputs[i]);
     }

     up(sem);

     return 0;
}

void smmu_test_core(int cpus)
{
     struct task_struct *tsk;
     int i;
     int total_mappings = 0;

     ways = cpus;

     for(i=0;i<ways;i++) {
         mappings[i] = 0;
         tsk = kthread_create_on_cpu(testthread, &sem[i], i,  "map_test");

         if (IS_ERR(tsk))
             printk(KERN_ERR "create test thread failed\n");
         wake_up_process(tsk);
     }

     for(i=0;i<ways;i++) {
         down(&sem[i]);
         total_mappings += mappings[i];
     }

     printk(KERN_ERR "finished total_mappings=%d (per way=%d) (rate=%d 
per second per cpu) ways=%d\n",
     total_mappings, total_mappings / ways, total_mappings / (seconds* 
ways), ways);

}
EXPORT_SYMBOL(smmu_test_core);


static int __init test_init(void)
{
     int i;

     for(i=0;i<NR_CPUS;i++)
         sema_init(&sem[i], 0);

     return 0;
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);
MODULE_LICENSE("GPL");

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
