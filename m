Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4979C04EBF
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 11:05:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4B2206C2
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 11:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4B2206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 42474C2C;
	Mon, 23 Sep 2019 11:05:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5FDD2C2A
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 11:05:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 08F578AC
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 11:05:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38646142F;
	Mon, 23 Sep 2019 04:05:05 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27D83F694;
	Mon, 23 Sep 2019 04:05:00 -0700 (PDT)
Subject: Re: [PATCH 0/3] iommu/io-pgtable-arm: Mali LPAE improvements
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Will Deacon <will@kernel.org>
References: <cover.1568211045.git.robin.murphy@arm.com>
	<d77047c2-1f16-eded-17ba-7463310d4bba@baylibre.com>
	<20190911162024.i2sda7uzy3pbrnyd@willie-the-truck>
	<83c45e97-8398-349d-5593-03af23b39c59@arm.com>
	<20190919083035.tv446nelad6ki6db@willie-the-truck>
	<CAAObsKCja0xTaiayNq5TWE7YJ0RPiJbq5OqOdEtpKdCQivR0uw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f2dfd90a-9f9a-b16f-7d03-85f169cff0c0@arm.com>
Date: Mon, 23 Sep 2019 12:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAObsKCja0xTaiayNq5TWE7YJ0RPiJbq5OqOdEtpKdCQivR0uw@mail.gmail.com>
Content-Language: en-GB
Cc: Rob Herring <robh@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Tomeu,

On 23/09/2019 09:17, Tomeu Vizoso wrote:
>>> There is some argument for taking #1 and #2 as 5.4 fixes, though - the
>>> upcoming Mesa 19.2 release will enable T820 support on the userspace side -
>>> so let's pick that discussion up again in a few weeks.
>>
>> Ok, I'll include those two in my fixes pull to Joerg at -rc1.
> 
> Hi Will,
> 
> Looks like this didn't end up happening?

Don't panic, there's still another week until rc1 is even out to base a 
PR on ;)

FWIW I was planning to rebase and resend these with the review tags 
included early next week, once the dust has settled and queues are 
opening again.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
