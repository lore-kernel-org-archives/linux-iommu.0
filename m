Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD7C04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 12:48:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68E4613AD
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68E4613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 687CF6070D;
	Mon, 24 May 2021 12:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uSVTIIFgM-8H; Mon, 24 May 2021 12:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B9760693;
	Mon, 24 May 2021 12:48:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20769C000D;
	Mon, 24 May 2021 12:48:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E531AC0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB3BA82F4F
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q4UHQfz7TSyk for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 12:48:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5425833FB
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 12:48:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1B7113E;
 Mon, 24 May 2021 05:48:33 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43B153F719;
 Mon, 24 May 2021 05:48:31 -0700 (PDT)
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
To: Lee Jones <lee.jones@linaro.org>, Will Deacon <will@kernel.org>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
 <20200108091641.GA15147@willie-the-truck>
 <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1a93ede6-7af5-dbc8-f655-8b96afa4a277@arm.com>
Date: Mon, 24 May 2021 13:48:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
Content-Language: en-GB
Cc: Patrick Daly <pdaly@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Pratik Patel <pratikp@codeaurora.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2021-05-24 13:03, Lee Jones wrote:
> On Wed, 8 Jan 2020 at 09:16, Will Deacon <will@kernel.org> wrote:
> 
>> On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:
>>> These patches implements the stream mapping inheritance that's necessary
>> in
>>> order to not hit a security violation as the display hardware looses its
>> stream
>>> mapping during initialization of arm-smmu in various Qualcomm platforms.
>>>
>>> This was previously posted as an RFC [1], changes since then involves the
>>> rebase and migration of the read-back code to the Qualcomm specific
>>> implementation, the mapping is maintained indefinitely - to handle probe
>>> deferring clients - and rewritten commit messages.
>>
>> I don't think we should solve this in a Qualcomm-specific manner. Please
>> can
>> you take a look at the proposal from Thierry [1] and see whether or not it
>> works for you?
>>
> 
> Did this or Thierry's solution ever gain traction?
> 
> Or are all the parties still 'solving' this downstream?

I think this particular series is what eventually ended up upstream as 
07a7f2caaa5a and f9081b8ff593 (plus a couple of tweaks later). Progress 
is slow on the more general solution, but still happening - I see there 
was a new version recently which I've not had time to properly look at yet.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
