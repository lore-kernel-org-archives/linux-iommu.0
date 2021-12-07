Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD4C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04D3840366;
	Tue,  7 Dec 2021 12:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKtBvZLqxRK6; Tue,  7 Dec 2021 12:48:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFFFE4034D;
	Tue,  7 Dec 2021 12:48:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A57F5C002F;
	Tue,  7 Dec 2021 12:48:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC920C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98D6E40176
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oUoGCCmY3DbG for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:48:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67B8E40137
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:48:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90CAF11FB;
 Tue,  7 Dec 2021 04:48:18 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01BAF3F5A1;
 Tue,  7 Dec 2021 04:48:16 -0800 (PST)
Message-ID: <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
Date: Tue, 7 Dec 2021 12:48:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, leo.yan@linaro.org
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
 <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
 <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, uchida.jun@socionext.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2021-12-07 12:28, John Garry via iommu wrote:
> On 07/12/2021 12:04, Robin Murphy wrote:
>>>>
>>> So is there some userspace part to go with this now?
>>
>> FWIW I've not looked into it - is it just a case of someone knocking 
>> out some JSON from the MMU-600/700 TRMs, or is there still mroe to do? 
> 
> That should just be it.
> 
>> I had the impression that *some* part of the process was stalled until 
>> implementations can start providing meaningful IIDRs, but I wasn't 
>> sure whether that was tooling or just data. I just work the low-level 
>> enablement angle :)
> 
> Tooling should be ok, but I would just like to see more of these JSONs 
> so any tooling issues can be ironed out.

Sounds good - Jean, Leo, is that something Linaro might like to pick up 
as part of the PMCG interest, or shall I make a note on my to-do list 
for the new year?

Thanks,
Robin.

> 
> Cheers,
> John
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
