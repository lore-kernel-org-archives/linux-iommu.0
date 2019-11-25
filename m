Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD548C432C0
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 16:38:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE6A2068E
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="dsWokQo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE6A2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36A2787A2F;
	Mon, 25 Nov 2019 16:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GHqdJa8z4uQE; Mon, 25 Nov 2019 16:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CD8D87A12;
	Mon, 25 Nov 2019 16:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CF2EC1DD7;
	Mon, 25 Nov 2019 16:38:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6E71C0878
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 16:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9FA798610A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 16:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BanJQLVH13mW for <iommu@lists.linux-foundation.org>;
 Mon, 25 Nov 2019 16:38:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.80])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B3E0486165
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574699925;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=gq/GyN0XSt4ZyXeob4dkH3Ai2PFxE9jquzF6wyzI+SE=;
 b=dsWokQo9jAh7j5sCjnSbIqnXYaJm9odg8Kqc1bNNWv57bZiKbnDOVJCNLoXqQyY8nR
 x+VV1yZsON+/cKuzlPf8CN9Lz2iwGMfeA3BXjlG9XYGXGcGmc7FDA1M00vyoJxlnjDxm
 xTPW8/7GReJi26uU6ltwCNwj8OTv2r84Iwa1QSgqEz9FbtTm6JglUDqawPWrpBawcElj
 ciMa0A3zzCG+BJdQa68/UkHaRVgnZ1hRLJ2jGIKa/kyLibgbtgQid5L12ZsNHtUmGD2j
 jZu00uZiU/2dKwSt427Sp6u0F4GTqBve+rNf9HD35f0cNl7fmx84E7TABB48X9JsGCz+
 O2Wg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhXJixqXRlXNgnQNtnHeat+VHo="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:40cb:202:5c2:453d]
 by smtp.strato.de (RZmta 45.0.2 AUTH) with ESMTPSA id x0678cvAPGcX2cB
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 25 Nov 2019 17:38:33 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de> <20191125093159.GA23118@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <1521ec47-f358-0304-da23-313e6bebb66d@xenosoft.de>
Date: Mon, 25 Nov 2019 17:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125093159.GA23118@linux.ibm.com>
Content-Language: de-DE
Cc: linux-arch@vger.kernel.org, darren@stevens-zone.net, rtd2@xtra.co.nz,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, paulus@samba.org,
 mad skateman <madskateman@gmail.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Robin Murphy <robin.murphy@arm.com>, nsaenzjulienne@suse.de
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

On 25 November 2019 at 10:32 am, Mike Rapoport wrote:
> On Mon, Nov 25, 2019 at 08:39:23AM +0100, Christoph Hellwig wrote:
>> On Sat, Nov 23, 2019 at 12:42:27PM +0100, Christian Zigotzky wrote:
>>> Hello Christoph,
>>>
>>> Please find attached the dmesg of your Git kernel.
>> Thanks.  It looks like on your platform the swiotlb buffer isn't
>> actually addressable based on the bus dma mask limit, which is rather
>> interesting.  swiotlb_init uses memblock_alloc_low to allocate the
>> buffer, and I'll need some help from Mike and the powerpc maintainers
>> to figure out how that select where to allocate the buffer from, and
>> how we can move it to a lower address.  My gut feeling would be to try
>> to do what arm64 does and define a new ARCH_LOW_ADDRESS_LIMIT, preferably
>> without needing too much arch specific magic.
> Presuming the problem is relevant for all CoreNet boards something like
> this could work:
>   
> diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
> index 1b4f0254868f..7c6cfeeaff52 100644
> --- a/arch/powerpc/include/asm/dma.h
> +++ b/arch/powerpc/include/asm/dma.h
> @@ -347,5 +347,11 @@ extern int isa_dma_bridge_buggy;
>   #define isa_dma_bridge_buggy	(0)
>   #endif
>   
> +#ifdef CONFIG_CORENET_GENERIC
> +extern phys_addr_t ppc_dma_phys_limit;
> +#define ARCH_LOW_ADDRESS_LIMIT	(ppc_dma_phys_limit - 1)
> +#endif
> +
> +
>   #endif /* __KERNEL__ */
>   #endif	/* _ASM_POWERPC_DMA_H */
> diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
> index fe0606439b5a..346b436b6d3f 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -126,3 +126,7 @@ void __init mpc85xx_qe_par_io_init(void)
>   	}
>   }
>   #endif
> +
> +#ifdef CONFIG_CORENET_GENERIC
> +phys_addr_t ppc_dma_phys_limit = 0xffffffffUL;
> +#endif
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 7ee2c6628f64..673bcbdc7c75 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -64,7 +64,7 @@ void __init corenet_gen_setup_arch(void)
>   	mpc85xx_smp_init();
>   
>   	swiotlb_detect_4g();
> -
> +	ppc_dma_phys_limit = 0x0fffffffUL;
>   	pr_info("%s board\n", ppc_md.name);
>   
>   	mpc85xx_qe_init();
>
>> As a quick hack can you try this patch on top of the tree from Friday?
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f491690d54c6..e3f95c362922 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -344,7 +344,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>>   #define MEMBLOCK_LOW_LIMIT 0
>>   
>>   #ifndef ARCH_LOW_ADDRESS_LIMIT
>> -#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
>> +#define ARCH_LOW_ADDRESS_LIMIT  0x0fffffffUL
>>   #endif
>>   
>>   phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
Hello Mike,

Many thanks for your patch! I will test it tomorrow.

Cheers,
Christian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
