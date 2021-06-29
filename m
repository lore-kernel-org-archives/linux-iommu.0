Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51064C11F66
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 12:04:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B4D61006
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 12:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B4D61006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95431836F0;
	Tue, 29 Jun 2021 12:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1TmVDPaE9AFS; Tue, 29 Jun 2021 12:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DD1B835A7;
	Tue, 29 Jun 2021 12:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A91C001A;
	Tue, 29 Jun 2021 12:04:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A73DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1640B402DA
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amazon.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q9TDwf-4fWGh for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 12:04:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34AB24037B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1624968260; x=1656504260;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4VTqRt/doBhcHug+DYEpXm+V0vDuSlC/ctdi9x/3mQY=;
 b=HbHk8tReUr8yitD8kESugPGJwL5QSKIbq7r5xKMHszY0nAlJYG88mv1N
 G3A+pSg0leTeZYIhHaUEd6PckzN/vyX4gYnZITua54r2iwr8SOkAWeUpJ
 /pUQs1mOHLD1gTcG/M4cn6FmvLOo6USks34zyLm6i0M4+jJM6KzqkqOEC Y=;
X-IronPort-AV: E=Sophos;i="5.83,308,1616457600"; d="scan'208";a="119057987"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.2])
 by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 29 Jun 2021 12:04:10 +0000
Received: from EX13MTAUWC002.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS
 id F07C8A1FD3; Tue, 29 Jun 2021 12:04:08 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 29 Jun 2021 12:04:08 +0000
Received: from [192.168.9.117] (10.43.161.153) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 12:04:05 +0000
Message-ID: <50d48c57-b6f4-aad9-2471-ea3d3066563d@amazon.com>
Date: Tue, 29 Jun 2021 14:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:90.0)
 Gecko/20100101 Thunderbird/90.0
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
 <3a43b2de-6a71-2373-8695-5e96657c8fc2@amazon.com>
 <fedb8d5a-a0f1-4216-bb46-1af31b716309@www.fastmail.com>
In-Reply-To: <fedb8d5a-a0f1-4216-bb46-1af31b716309@www.fastmail.com>
X-Originating-IP: [10.43.161.153]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Cc: Arnd Bergmann <arnd@kernel.org>, Rouven
 Czerwinski <r.czerwinski@pengutronix.de>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector
 Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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
From: Alexander Graf via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Graf <graf@amazon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 29.06.21 09:37, Sven Peter wrote:
> 
> On Mon, Jun 28, 2021, at 12:54, Alexander Graf wrote:
>>
>>
>> On 27.06.21 16:34, Sven Peter wrote:
>>>
>>> Apple's DART iommu uses a pagetable format that shares some
>>> similarities with the ones already implemented by io-pgtable.c.
>>> Add a new format variant to support the required differences
>>> so that we don't have to duplicate the pagetable handling code.
>>>
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>>    drivers/iommu/io-pgtable-arm.c | 62 ++++++++++++++++++++++++++++++++++
>>>    drivers/iommu/io-pgtable.c     |  1 +
>>>    include/linux/io-pgtable.h     |  7 ++++
>>>    3 files changed, 70 insertions(+)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>> index 87def58e79b5..1dd5c45b4b5b 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -127,6 +127,9 @@
>>>    #define ARM_MALI_LPAE_MEMATTR_IMP_DEF  0x88ULL
>>>    #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
>>>
>>> +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
>>> +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
>>> +
>>>    /* IOPTE accessors */
>>>    #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>>>
>>> @@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>>    {
>>>           arm_lpae_iopte pte;
>>>
>>> +       if (data->iop.fmt == ARM_APPLE_DART) {
>>> +               pte = 0;
>>> +               if (!(prot & IOMMU_WRITE))
>>> +                       pte |= APPLE_DART_PTE_PROT_NO_WRITE;
>>> +               if (!(prot & IOMMU_READ))
>>> +                       pte |= APPLE_DART_PTE_PROT_NO_READ;
>>> +               return pte;
>>
>> What about the other bits, such as sharability, XN, etc? Do they not
>> exist on DART? Or have they not been reverse engineered and 0s happen to
>> "just work"?
> 
> I'm fairly certain they don't exist (or are at least not used by XNU).
> 
> The co-processors that can run code also either use an entire separate iommu
> (e.g. the GPU) or only use DART as a "second stage" and have their own
> MMU which e.g. handles XN (e.g. the SEP or AOP).

Ok :).

> 
>>
>>> +       }
>>> +
>>>           if (data->iop.fmt == ARM_64_LPAE_S1 ||
>>>               data->iop.fmt == ARM_32_LPAE_S1) {
>>>                   pte = ARM_LPAE_PTE_nG;
>>> @@ -1043,6 +1055,51 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>>>           return NULL;
>>>    }
>>>
>>> +static struct io_pgtable *
>>> +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>>> +{
>>> +       struct arm_lpae_io_pgtable *data;
>>> +       int i;
>>> +
>>> +       if (cfg->oas > 36)
>>> +               return NULL;
>>> +
>>> +       data = arm_lpae_alloc_pgtable(cfg);
>>> +       if (!data)
>>> +               return NULL;
>>> +
>>> +       /*
>>> +        * Apple's DART always requires three levels with the first level being
>>> +        * stored in four MMIO registers. We always concatenate the first and
>>> +        * second level so that we only have to setup the MMIO registers once.
>>> +        * This results in an effective two level pagetable.
>>> +        */
>>> +       if (data->start_level < 1)
>>> +               return NULL;
>>> +       if (data->start_level == 1 && data->pgd_bits > 2)
>>> +               return NULL;
>>> +       if (data->start_level > 1)
>>> +               data->pgd_bits = 0;
>>> +       data->start_level = 2;
>>> +       cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
>>
>> Maybe add a BUG_ON if n_ttbrs > ARRAY_SIZE(ttbr)? Or alternatively, do a
>> normal runtime check and bail out then.
> 
> n_ttbrs can't actually be larger than 4 at this point already due to the
> previous checks.
> I can add a BUG_ON though just to make it explicit and be safe in case those
> checks or the array size ever change.

Ah, now I see it too. No worries then - I agree that you have all cases 
covered.

Reviewed-by: Alexander Graf <graf@amazon.com>


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
