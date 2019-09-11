Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF32C5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18DA2053B
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 17:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DA2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 577EDE1B;
	Wed, 11 Sep 2019 17:19:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DB6EDE19
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 17:19:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 7670F81A
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 17:19:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7942628;
	Wed, 11 Sep 2019 10:19:47 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE743F59C;
	Wed, 11 Sep 2019 10:19:45 -0700 (PDT)
Subject: Re: [PATCH 0/3] iommu/io-pgtable-arm: Mali LPAE improvements
To: Will Deacon <will@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>
References: <cover.1568211045.git.robin.murphy@arm.com>
	<d77047c2-1f16-eded-17ba-7463310d4bba@baylibre.com>
	<20190911162024.i2sda7uzy3pbrnyd@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <83c45e97-8398-349d-5593-03af23b39c59@arm.com>
Date: Wed, 11 Sep 2019 18:19:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911162024.i2sda7uzy3pbrnyd@willie-the-truck>
Content-Language: en-GB
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 2019-09-11 5:20 pm, Will Deacon wrote:
> On Wed, Sep 11, 2019 at 06:19:04PM +0200, Neil Armstrong wrote:
>> On 11/09/2019 16:42, Robin Murphy wrote:
>>> Here's the eagerly-awaited fix to unblock T720/T820, plus a couple of
>>> other bits that I've collected so far. I'm not considering this as
>>> 5.3 fixes material, but it would be nice if there's any chance still
>>> to sneak it into 5.4.
>>>
>>> Robin.
>>>
>>>
>>> Robin Murphy (3):
>>>    iommu/io-pgtable-arm: Correct Mali attributes
>>>    iommu/io-pgtable-arm: Support more Mali configurations
>>>    iommu/io-pgtable-arm: Allow coherent walks for Mali
>>>
>>>   drivers/iommu/io-pgtable-arm.c | 61 ++++++++++++++++++++++++++--------
>>>   1 file changed, 48 insertions(+), 13 deletions(-)
>>>
>>
>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> On Khadas VIM2 (Amlogic S912) with T820 Mali GPU
>>
>> I hope this will be part of v5.4 so we can run panfrost on vanilla v5.4 !
> 
> Not a chance -- the merge window opens on Monday and -next isn't being
> rolled out at the moment due to LPC. Let's shoot for 5.5 and get this
> queued up in a few weeks.

Fair enough, that was certainly more extreme optimism than realistic 
expectation on my part :)

There is some argument for taking #1 and #2 as 5.4 fixes, though - the 
upcoming Mesa 19.2 release will enable T820 support on the userspace 
side - so let's pick that discussion up again in a few weeks.

Robin.

(And at worst, I guess we could carry the "cfg.ias = 48" workaround in 
the DRM driver for the 5.4 cycle if need be)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
