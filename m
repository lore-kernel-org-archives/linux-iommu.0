Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8057FC433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 22:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14AF56072A;
	Mon,  9 May 2022 22:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9pdzLapR31D; Mon,  9 May 2022 22:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C7A5760596;
	Mon,  9 May 2022 22:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A0BC0039;
	Mon,  9 May 2022 22:06:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8D1C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 086A240484
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFCxaO-Z_ZfX for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 22:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E72C4000B
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:06:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293B21FB;
 Mon,  9 May 2022 15:06:44 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 369C03F5A1;
 Mon,  9 May 2022 15:06:42 -0700 (PDT)
Message-ID: <eff13777-bb3f-f1f5-d5e7-e2461c6e9238@arm.com>
Date: Mon, 9 May 2022 23:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <BN9PR11MB5276476BB203D8D61CA8849C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9f6680ed-77b6-8440-078c-623406c823aa@arm.com>
 <20220506131053.GA522325@nvidia.com>
 <27088ae5-05d6-122a-d9de-80e10eecac38@arm.com>
 <20220506135431.GC49344@nvidia.com>
 <0f838b34-460c-ed83-7b98-6cda444b10c2@arm.com>
 <20220509172654.GP49344@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220509172654.GP49344@nvidia.com>
Cc: Will Deacon <will@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2022-05-09 18:26, Jason Gunthorpe wrote:
> On Mon, May 09, 2022 at 10:59:11AM +0100, Robin Murphy wrote:
> 
>> IOMMU_DOMAIN_DMA_FQ now effectively takes over the original
>> semantics of IOMMU_DOMAIN_DMA as the one that depends on
>> driver-specific functionality.
> 
> If I grasp the FQ stuff right, it seems that this only requires the
> driver to implement ops->flush_iotlb_all()? I don't see anything
> obvious in any driver that is specifically _FQ related?
> 
> If yes, it makes me wonder why I see drivers implementing
> ops->flush_iotlb_all() but not supporting the _FQ domain during alloc?
> 
> Further, if yes, wouldn't it make sense to just trigger FQ based on
> domain->op->flush_iotlb_all being set?

The main thing drivers need to do for flush queue support is to actually 
implement the optimisations which make it worthwhile. It's up to 
individual drivers how much use they want to make of the 
iommu_iotlb_gather mechanism, and they're free to issue invalidations or 
even enforce their completion directly within their unmap callback if 
they so wish. In such cases, enabling a flush queue would do nothing but 
hurt performance and waste memory.

> It seems like there is some confusion here, because I see the sysfs
> default domain store path just does this:
> 
> 	/* We can bring up a flush queue without tearing down the domain */
> 	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
> 		ret = iommu_dma_init_fq(prev_dom);
> 		if (!ret)
> 			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
> 		goto out;
> 	}
> 
> Which will allow a driver that rejected creating DMA_FQ during alloc
> to end up with DMA_FQ anyhow???

Yes, I can't remember if I ever mentioned it anywhere, but that is not 
an oversight. The sysfs interface is a bit of a specialist sport, and if 
a user really wants to go out of their way to bring up a flush queue 
which won't help performance, they can, and they can observe the 
zero-to-negative performance gain, and maybe learn not to bother again 
on that system. It's just not worth the additional complexity to try to 
save users from themselves.

>> FWIW, mtk-iommu doesn't really have any need to reject
>> IOMMU_DOMAIN_UNMANAGED, they just don't have any relevant client drivers
>> that want it;
> 
> Ok..
> 
>> however arm-smmu definitely does need to continue rejecting
>> IOMMU_DOMAIN_DMA when it can't rely on the DT code ensuring the
>> correct probe ordering with the old DT binding (otherwise client
>> drivers are liable to get broken DMA ops).
> 
> I saw this code and wondered what it does?
> 
> smmu alloc_domain returns NULL, which if I read everything right
> causes NULL to become the default_domain.
> 
> But then what happens? This driver has no detach_dev so after, say
> VFIO does stuff, how do we get back into whatever boot-time state NULL
> represents?

Shhh... the main point of the arm-smmu legacy binding support is to do 
whatever the handful of people still using ancient AMD Seattle boards 
with original firmware need to do. Clearly they haven't been reassigning 
devices straight back from VFIO to a kernel driver for the last 
6-and-a-bit years since that's been broken, so I'm now discounting it as 
a supported legacy-binding-use-case. Don't give them ideas! ;)

> Is it OK because dev_iommu_priv_get() in arm_smmu_attach_dev() will
> always fail if legacy? If that is the case then why allow allocating
> any domain at all?
> 
> It feels like this really wants a 'IOMMU_DOMAIN_PLATFORM_DMA_OPS' set
> as the default_domain meaning that when that domain is assigned, the
> platform's DMA ops are handling the iommu? If I get it right..

Nah, we just need to actually finish introducing default domains. I'm OK 
to tackle the remaining SoC IOMMU drivers once my bus ops work meanders 
into the arch/arm iommu-dma conversion revival; it just needs people who 
understand s390 and fsl-pamu well enough to at least (presumably) bodge 
up enough IOMMU_DOMAIN_IDENTITY support to replicate their current 
"detached" behaviours and force CONFIG_IOMMU_DEFAULT_PASSTHROUGH on 
those architectures.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
