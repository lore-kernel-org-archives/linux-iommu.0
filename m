Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2F1C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08C334091C;
	Wed,  4 May 2022 14:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzXc7YlZI57Z; Wed,  4 May 2022 14:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D000940128;
	Wed,  4 May 2022 14:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4FB8C0039;
	Wed,  4 May 2022 14:55:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0FD0C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFADC61050
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMhqo_a5JLE7 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:55:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41B6B60C1C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651676105; x=1683212105;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EH8sTyMxctEgJGyNea830TavUO863USp3+LCZGp1MPs=;
 b=gDB4DMgHnz6m6oHzx55WRTjqjwXjdOIhcES9sU1XYurYioL80Z965u7m
 OmTt4b76+lrzt50A9GJsWQermODm5Cwc1dpxdHJh5ptj81KQNbKkmm2FZ
 UukW60gbXqxibR9k4VTNi0DeBBWlLZ6SK1lFX/rl/baNInPnW+6Xo7E3c
 Bl4+jIXqE2//GDT1zKETyLEaJmjyRI77meLdXBi5kSsSxRc+pkO2eZAd4
 OATAACy5bmdMBT91W/q43zmCeNcQcNKVfSi6zJYLRmgzsSF0ABZTmImiE
 kb6Xh8r3nRaF4gZKVTan6vTnJD1LHYSzzzGsSJjdyLoux6SVG78HTl33H A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="292977928"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="292977928"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:55:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="734427542"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:55:02 -0700
Message-ID: <a783ff02-6406-0e31-679a-77d43b848a72@linux.intel.com>
Date: Wed, 4 May 2022 22:55:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <8449a6fd-32f1-7cd3-6a4f-31f71df606a1@linux.intel.com>
 <20220504143833.GH49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220504143833.GH49344@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Qian Cai <quic_qiancai@quicinc.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 2022/5/4 22:38, Jason Gunthorpe wrote:
>> @@ -3180,7 +3181,9 @@ int iommu_group_claim_dma_owner(struct iommu_group
>> *group, void *owner)
>>                  ret = -EPERM;
>>                  goto unlock_out;
>>          } else {
>> -               if (group->domain && group->domain != group->default_domain)
>> {
>> +               if (group->domain &&
>> +                   group->domain != group->default_domain &&
>> +                   group->domain != group->blocking_domain) {
> Why do we need this hunk? This is just trying to check if there is
> some conflict with some other domain attach, group->domain can never
> be blocking_domain here.
This is *not* needed. Also verified with real hardware.

Sorry for the noise.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
