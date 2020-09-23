Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A3C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 14:50:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC98206D9
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 14:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC98206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42A3386700;
	Wed, 23 Sep 2020 14:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqOzukOTl-rS; Wed, 23 Sep 2020 14:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B07308653D;
	Wed, 23 Sep 2020 14:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D103C0859;
	Wed, 23 Sep 2020 14:50:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1CC6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A36E887285
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oI3ypBHF-mcZ for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 14:50:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1064886FF5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:50:12 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id E82B372EE1393A03E283;
 Wed, 23 Sep 2020 15:50:09 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.162) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 23 Sep
 2020 15:50:09 +0100
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To: Will Deacon <will@kernel.org>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
 <20200921134324.GK2139@willie-the-truck>
 <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Message-ID: <37734fe9-8b67-3cf3-2925-2fee549cb45a@huawei.com>
Date: Wed, 23 Sep 2020 15:47:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.2.162]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

On 21/09/2020 14:58, John Garry wrote:
> 
>> Could you try to adapt the hacks I sent before,
>> please? I know they weren't quite right (I have no hardware to test 
>> on

Could the ARM Rev C FVP be used to at least functionally test? Can't 
seem to access myself, even though it's gratis...

), but
>> the basic idea is to fall back to a spinlock if the cmpxchg() fails. The
>> queueing in the spinlock implementation should avoid the contention.
> 

So I modified that suggested change to get it functioning, and it looks 
like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7196207be7ea..f907b7c233a2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
  	atomic_long_t			*valid_map;
  	atomic_t			owner_prod;
  	atomic_t			lock;
+	spinlock_t			slock;
  };

  struct arm_smmu_cmdq_batch {
@@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
arm_smmu_device *smmu,
  	u64 cmd_sync[CMDQ_ENT_DWORDS];
  	u32 prod;
  	unsigned long flags;
-	bool owner;
+	bool owner, locked = false;
  	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
  	struct arm_smmu_ll_queue llq = {
  		.max_n_shift = cmdq->q.llq.max_n_shift,
@@ -1387,26 +1388,42 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
arm_smmu_device *smmu,

  	/* 1. Allocate some space in the queue */
  	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
  	do {
  		u64 old;

-		while (!queue_has_space(&llq, n + sync)) {
+		llq.val = READ_ONCE(cmdq->q.llq.val);
+
+		if (queue_has_space(&llq, n + sync))
+			goto try_cas;
+
+		if (locked) {
+			spin_unlock(&cmdq->slock);
+			locked = 0; // added
+		}
+
+		do {
  			local_irq_restore(flags);
  			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
  			local_irq_save(flags);
-		}
+		} while (!queue_has_space(&llq, n + sync));

+try_cas:
  		head.cons = llq.cons;
  		head.prod = queue_inc_prod_n(&llq, n + sync) |
  					     CMDQ_PROD_OWNED_FLAG;

  		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
+		if (old == llq.val) { // was if (old != llq.val)
+			if (locked)   //           break;
+				spin_unlock(&cmdq->slock);//
  			break;//
+		}//

-		llq.val = old;
+		if (!locked) {
+			spin_lock(&cmdq->slock);
+			locked = true;
+		}
  	} while (1);
  	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
  	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
@@ -3192,6 +3209,7 @@ static int arm_smmu_cmdq_init(struct 
arm_smmu_device *smmu)

  	atomic_set(&cmdq->owner_prod, 0);
  	atomic_set(&cmdq->lock, 0);
+	spin_lock_init(&cmdq->slock);

  	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
  	if (!bitmap) {
-- 
2.26.2

I annotated my mods with comments. Maybe those mods would not be as you 
intend.

So I'm not sure that we solve the problem of a new CPU coming along and 
trying the cmpxchg immediately, while another CPU has the slock and will 
try the cmpxchg also.

Anyway, the results are a bit mixed depending on the CPU count, but 
generally positive compared to mainline:

CPUs		2	4	8	16	32	64	96
v5.9-rc1	453K	409K	295K	157K	33.6K	9.5K	5.2K
Will's change	459K	414K	281K	131K	44K	15.5K	8.6K
$subject change	481K	406K	305K	190K	81K	30K	18.7K

(Unit is DMA map+unmap per CPU per second, using test harness. Higher is 
better.)

Please let me know of any way to progress.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
