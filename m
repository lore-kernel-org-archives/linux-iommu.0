Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B36CA9EC5
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 10:16:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80C620874
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 10:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9F5E9EE7;
	Wed, 30 Oct 2019 10:16:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 31462ED9
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 10:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D00598A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 10:16:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780E81F1;
	Wed, 30 Oct 2019 03:16:06 -0700 (PDT)
Received: from [10.1.31.194] (e121487-lin.cambridge.arm.com [10.1.31.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5EAA3F71E;
	Wed, 30 Oct 2019 03:16:04 -0700 (PDT)
Subject: Re: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Daniele Alessandrelli <daniele.alessandrelli@gmail.com>
References: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
	<d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
	<acf0dd2c-7e12-fba6-b7f8-dfd78c892fe5@arm.com>
	<417fa080-08f9-9f35-687b-c0b82a61628d@arm.com>
	<376133e3-25f2-ffe7-ef9f-4613388b2bf7@arm.com>
	<84747008-85e9-e71a-b9ad-cefcc6c0f661@st.com>
	<3305c91e-e630-b7fd-4c6f-598583504d67@arm.com>
	<6b024e69-f612-6850-8a04-9b3049549092@st.com>
	<2153b504-8c98-6c43-6ae3-9fb355d88417@arm.com>
	<CAA2QUqJcJuhnAEOirNYdM4W_+sskO=CvLB9R7PpCPg-hsBLBJQ@mail.gmail.com>
	<CAA2QUqJcZeaBhAzcmxK7=TvU9MyYosG3ZdfiTsdntzVm5=6+Jg@mail.gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <b346c5a6-f094-8963-aaaa-1eac1fc68568@arm.com>
Date: Wed, 30 Oct 2019 10:16:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAA2QUqJcZeaBhAzcmxK7=TvU9MyYosG3ZdfiTsdntzVm5=6+Jg@mail.gmail.com>
Content-Language: en-US
Cc: Alexandre Torgue <alexandre.torgue@st.com>, Arnd Bergmann <arnd@arndb.de>,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 10/29/19 4:52 PM, Daniele Alessandrelli wrote:
> On Tue, Oct 29, 2019 at 9:43 AM Daniele Alessandrelli
> <daniele.alessandrelli@gmail.com> wrote:
>>
>> On Mon, Oct 28, 2019 at 10:59 AM Vladimir Murzin
>> <vladimir.murzin@arm.com> wrote:
>>>
>>> @Daniele, it'd be handy to know if that fix issue for you...
>>>
>>
>> Apologies, I've been traveling for the last few days and haven't
>> managed to try it yet.
>>
>> I'll do it later today though and let you know.
> 
> Hi Vladimir,
> 
> I can confirm that your patch fixes the issue I was having. Thanks!

Great thanks!

Christoph, I've just sent it as a proper patch, please consider to apply.

Cheers
Vladimir

> 
> Regards,
> Daniele
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
