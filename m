Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E7CC433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 18:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD68740022;
	Wed,  8 Dec 2021 18:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23LmYZ_ukZz1; Wed,  8 Dec 2021 18:18:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A9ABA40196;
	Wed,  8 Dec 2021 18:18:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60593C001E;
	Wed,  8 Dec 2021 18:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B30F4C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CA4940196
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vylmSgHwBvSN for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 18:18:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49C7340022
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:18:10 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8QNm4dqMz67mM5;
 Thu,  9 Dec 2021 02:16:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 8 Dec 2021 19:18:06 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 18:18:06 +0000
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
 <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20211207094109.1962-1-thunder.leizhen@huawei.com>
 <20211207094109.1962-2-thunder.leizhen@huawei.com>
 <9da73d96-c61d-4ed2-607d-4861e6bfd696@huawei.com>
 <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
Message-ID: <4f296b55-a59a-49b4-ad4d-902bb83a203c@huawei.com>
Date: Wed, 8 Dec 2021 18:17:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <58e8e7c6-a47b-7816-ac74-aefa5b55dd17@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>> Did you notice any performance change with this change?
> 
> Hi John:
>    Thanks for the tip. I wrote a test case today, and I found that the
> performance did not go up but down.

I very quickly tested on a DMA mapping benchmark very similar to the 
kernel DMA benchmark module - I got mixed results. For fewer CPUs (<8), 
a small improvement, like 0.7%. For more CPUs, a dis-improvement - 
that's surprising, I did expect just no change as any improvement would 
get dwarfed from the slower unmap rates for more CPUs. I can check this
more tomorrow.

> It's so weird. So I decided not to
> change it, because it's also poorly readable. So I plan to make only
> the following modifications:
> @@ -237,7 +237,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
>          memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -       cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +       cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
>          switch (ent->opcode) {
>          case CMDQ_OP_TLBI_EL2_ALL:
> 
> This prevents the compiler from generating the following two inefficient
> instructions:
>       394:       f9400002        ldr     x2, [x0]	//x2 = cmd[0]
>       398:       aa020062        orr     x2, x3, x2	//x3 = FIELD_PREP(CMDQ_0_OP, ent->opcode)
> 
> Maybe it's not worth changing because I've only seen a 0.x nanosecond reduction
> in performance. But one thing is, it only comes with benefits, no side effects.
> 

I just think that with the original code that cmd[] is on the stack and 
cached, so if we have write-back attribute (which I think we do) then 
there would not necessarily a write to external memory per write to cmd[].

So, apart from this approach, I think that if we can just reduce the 
instructions through other efficiencies in the function then that would 
be good.

Thanks,
John



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
