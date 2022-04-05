Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E09C433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 12:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3A5C405EC;
	Tue,  5 Apr 2022 12:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XZC3XWd37hLH; Tue,  5 Apr 2022 12:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AA4D740176;
	Tue,  5 Apr 2022 12:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF48C001D;
	Tue,  5 Apr 2022 12:37:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6767C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E30DF4055F
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLJvqwxApsWs for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 12:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D97540176
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:37:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BE56D6E;
 Tue,  5 Apr 2022 05:37:25 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44BC3F5A1;
 Tue,  5 Apr 2022 05:37:24 -0700 (PDT)
Message-ID: <e1dc64d3-d5b3-07f1-5fd6-c132fc247bb6@arm.com>
Date: Tue, 5 Apr 2022 13:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ALSA: emu10k1: Stop using iommu_present()
Content-Language: en-GB
To: Takashi Iwai <tiwai@suse.de>
References: <5ac9b54285b2189b848da2595408eb3cae8e5e9d.1649160813.git.robin.murphy@arm.com>
 <s5ha6cz7lxt.wl-tiwai@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <s5ha6cz7lxt.wl-tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 tiwai@suse.com, alsa-devel@alsa-project.org, perex@perex.cz
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

On 2022-04-05 13:29, Takashi Iwai wrote:
> On Tue, 05 Apr 2022 14:13:33 +0200,
> Robin Murphy wrote:
>>
>> iommu_get_domain_for_dev() is already perfectly happy to return NULL
>> if the given device has no IOMMU. Drop the unnecessary check.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> This will change the code behavior.  The current code does nothing if
> no IOMMU is found, but after your removal of the check, the code
> reaches to emu->iommu_workaround = true incorrectly.

Ah, right you are - I should have looked more closely at the second 
check, where of course "domain &&" wants tweaking to "!domain ||" as 
well. I'll send a v2 in a bit...

Thanks,
Robin.

> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>   sound/pci/emu10k1/emu10k1_main.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
>> index 86cc1ca025e4..5ffab343b89c 100644
>> --- a/sound/pci/emu10k1/emu10k1_main.c
>> +++ b/sound/pci/emu10k1/emu10k1_main.c
>> @@ -1751,9 +1751,6 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
>>   
>>   	emu->iommu_workaround = false;
>>   
>> -	if (!iommu_present(emu->card->dev->bus))
>> -		return;
>> -
>>   	domain = iommu_get_domain_for_dev(emu->card->dev);
>>   	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
>>   		return;
>> -- 
>> 2.28.0.dirty
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
