Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A529C4332F
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 18:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A32C240C0E;
	Wed,  6 Apr 2022 18:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzPwo4f7v0jb; Wed,  6 Apr 2022 18:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C5D140BD2;
	Wed,  6 Apr 2022 18:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AFDCC001D;
	Wed,  6 Apr 2022 18:07:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F86C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 18:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B027583E78
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 18:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qzIbDAzF8haA for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 18:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F382B8340C
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 18:07:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CDC912FC;
 Wed,  6 Apr 2022 11:07:03 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4A23F718;
 Wed,  6 Apr 2022 11:07:01 -0700 (PDT)
Message-ID: <0f7bf1c2-7a21-13a0-8734-c53f624e1edd@arm.com>
Date: Wed, 6 Apr 2022 19:06:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/tegra: Stop using iommu_present()
Content-Language: en-GB
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, thierry.reding@gmail.com
References: <25247f43672df0aa58c1952bf3df2bf948e9f8ae.1649168393.git.robin.murphy@arm.com>
 <49165024-5f33-b6e6-7ec9-1ede6f562748@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <49165024-5f33-b6e6-7ec9-1ede6f562748@collabora.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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

On 2022-04-06 15:32, Dmitry Osipenko wrote:
> On 4/5/22 17:19, Robin Murphy wrote:
>> Remove the pointless check. host1x_drm_wants_iommu() cannot return true
>> unless an IOMMU exists for the host1x platform device, which at the moment
>> means the iommu_present() test could never fail.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/gpu/drm/tegra/drm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
>> index 9464f522e257..bc4321561400 100644
>> --- a/drivers/gpu/drm/tegra/drm.c
>> +++ b/drivers/gpu/drm/tegra/drm.c
>> @@ -1149,7 +1149,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
>>   		goto put;
>>   	}
>>   
>> -	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
>> +	if (host1x_drm_wants_iommu(dev)) {
>>   		tegra->domain = iommu_domain_alloc(&platform_bus_type);
>>   		if (!tegra->domain) {
>>   			err = -ENOMEM;
> 
> host1x_drm_wants_iommu() returns true if there is no IOMMU for the
> host1x platform device of Tegra20/30 SoCs.

Ah, apparently this is another example of what happens when I write 
patches late on a Friday night...

So on second look, what we want to ascertain here is whether dev has an 
IOMMU, but only if the host1x parent is not addressing-limited, either 
because it can also use the IOMMU, or because all possible addresses are 
small enough anyway, right? Are we specifically looking for the host1x 
having a DMA-API-managed domain, or can that also end up using the 
tegra->domain or another unmanaged domain too? I can't quite figure out 
from the comments whether it's physical addresses, IOVAs, or both that 
we're concerned with here.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
