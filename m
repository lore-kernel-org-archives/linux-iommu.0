Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB04AC43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 10:59:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8A120663
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 10:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8A120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EBC087C16;
	Tue, 10 Dec 2019 10:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjaPScMVywQ6; Tue, 10 Dec 2019 10:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 823BD87B3C;
	Tue, 10 Dec 2019 10:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6973BC1796;
	Tue, 10 Dec 2019 10:59:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E291C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 10:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27E3487B48
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 10:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I0M5z1Sf3NxR for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 10:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 159EB87B3C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 10:59:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BBC41FB;
 Tue, 10 Dec 2019 02:59:07 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D713F6CF;
 Tue, 10 Dec 2019 02:59:06 -0800 (PST)
Subject: Re: [PATCH] iommu/dma: Use a better type for dma_limit
To: Stephan Gerhold <stephan@gerhold.net>
References: <1276b72dec7803b377ede9030027a23aa4861d0c.1575896866.git.robin.murphy@arm.com>
 <20191210092832.GA80115@gerhold.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1804ef2b-c007-1d46-32c2-82470fcd9da8@arm.com>
Date: Tue, 10 Dec 2019 10:59:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210092832.GA80115@gerhold.net>
Content-Language: en-GB
Cc: Nathan Chancellor <natechancellor@gmail.com>,
 iommu@lists.linux-foundation.org, nsaenzjulienne@suse.de
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

On 10/12/2019 9:28 am, Stephan Gerhold wrote:
> On Mon, Dec 09, 2019 at 01:08:32PM +0000, Robin Murphy wrote:
>> It makes little sense for dma_limit to be a dma_addr_t when we only use
>> it to pass u64 arguments, and combine it with another u64 along the way.
>> Just make it u64, and head off any possible size mismatches.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 0cc702a70a96..4acc4199a740 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -399,7 +399,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
>>   }
>>   
>>   static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>> -		size_t size, dma_addr_t dma_limit, struct device *dev)
>> +		size_t size, u64 dma_limit, struct device *dev)
>>   {
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	struct iova_domain *iovad = &cookie->iovad;
> 
> Just wondering, maybe you should do the same for:
> 
> static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 		size_t size, int prot, dma_addr_t dma_mask)
> 
> since that passes on the dma_mask as dma_addr_t instead of u64?
> 
> 
> Also FYI, this fixes the warning on arm32 reported by Nathan [1],
> but introduces another similar warning on the min() macro below:

Oh bums, I guess it's time to do a proper type audit and some more 
exhaustive build-testing then - no point in just moving warnings 
around... Thanks for the heads-up!

Robin.

> In file included from ../include/linux/list.h:9,
>                   from ../include/linux/kobject.h:19,
>                   from ../include/linux/of.h:17,
>                   from ../include/linux/irqdomain.h:35,
>                   from ../include/linux/acpi.h:13,
>                   from ../include/linux/acpi_iort.h:10,
>                   from ../drivers/iommu/dma-iommu.c:11:
> ../drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
> ../include/linux/kernel.h:844:29: warning: comparison of distinct pointer types lacks a cast
>    844 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>        |                             ^~
> ../include/linux/kernel.h:858:4: note: in expansion of macro '__typecheck'
>    858 |   (__typecheck(x, y) && __no_side_effects(x, y))
>        |    ^~~~~~~~~~~
> ../include/linux/kernel.h:868:24: note: in expansion of macro '__safe_cmp'
>    868 |  __builtin_choose_expr(__safe_cmp(x, y), \
>        |                        ^~~~~~~~~~
> ../include/linux/kernel.h:877:19: note: in expansion of macro '__careful_cmp'
>    877 | #define min(x, y) __careful_cmp(x, y, <)
>        |                   ^~~~~~~~~~~~~
> ../drivers/iommu/dma-iommu.c:427:15: note: in expansion of macro 'min'
>    427 |   dma_limit = min(dma_limit, domain->geometry.aperture_end);
>        |               ^~~
> 
> min_t(u64, dma_limit, domain->geometry.aperture_end) seems to fix it,
> but not sure if that is correct.
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-iommu/20191123165108.GA15306@ubuntu-x2-xlarge-x86/
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
