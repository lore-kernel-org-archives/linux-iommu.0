Return-Path: <SRS0=3WiH=XL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB0AC49ED7
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 21:42:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E8B214AF
	for <iommu@archiver.kernel.org>; Mon, 16 Sep 2019 21:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D48B213F0;
	Mon, 16 Sep 2019 21:42:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B809E77
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 21:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DD3CF7DB
	for <iommu@lists.linux-foundation.org>;
	Mon, 16 Sep 2019 21:42:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45BA7337;
	Mon, 16 Sep 2019 14:42:46 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF09C3F575;
	Mon, 16 Sep 2019 14:42:44 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
To: Doug Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
	<CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
	<20190916180021.cp2onwou7pbsrygd@willie-the-truck>
	<CAD=FV=Wx7zSqGSABfnG9B0yAcZvimub+hMcPRfUoFxr-FJeFew@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3e52e4e2-fb09-fa39-23be-b225194bd2c5@arm.com>
Date: Mon, 16 Sep 2019 22:42:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wx7zSqGSABfnG9B0yAcZvimub+hMcPRfUoFxr-FJeFew@mail.gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On 2019-09-16 7:19 pm, Doug Anderson wrote:
[...]
>>> 1. "By firmware" might be a bit misleading.  In most cases I'm aware
>>> of the problem is in the device tree that was bundled together with
>>> the kernel.  If there are actually cases where firmware has baked in a
>>> device tree and it got this wrong then we might want to spend time
>>> figuring out what to do about it.
>>
>> I thought that was usually the way UEFI systems worked, where the kernel
>> is updated independently of the device-tree? Either way, that should be
>> what we're aiming for, even if many platforms require the two to be tied
>> together.
> 
> It's my opinion that until there is a place in the kernel to "fixup"
> broken device trees that were baked in firmware that it's a bad idea
> to ship device trees separate from the kernel except if the device
> trees are exceedingly simple.  We'll run into too many problems
> otherwise, either because the kernel the device tree was written for
> had downstream patches or someone just made a mistake in them and
> nobody noticed.  I know device trees are supposed to be ABI, but
> people make mistakes and we need a way to fix them up.
> 
> ...but that's getting pretty far afield from Robin's patch.

Let's not get too hung up on devicetree - you can go out and buy certain 
ACPI-only platforms today that also fall foul of this, for which AFAIK 
the necessary firmware update is in the SoC vendor's hands.

>>> 2. Presumably booting with "arm-smmu.disable_bypass=0" is in most
>>> cases the least desirable option available.  I always consider kernel
>>> command line parameters as something of a last resort for
>>> configuration and would only be something that and end user might do
>>> if they were given a kernel compiled by someone else (like if someone
>>> where taking a prebuilt Linux distro and trying to install it onto a
>>> generic PC).  Are you seeing cases where this is happening?  If people
>>> are compiling their own kernel I'd argue that telling them to set
>>> "CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT" to "no" is much better
>>> than trying to jam a command line option on.  Command line options
>>> don't scale well.
>>
>> Hmm. Recompiling seems like even more of a last resort to me!
> 
> Depends on what you're doing.  If you're not in the habit of compiling
> a kernel and you're just trying to make one work then the command line
> is great.  If you're trying to manage configuration for a whole bunch
> of different hardware products then the command line is a terrible
> place to store config.
> 
> ...but I guess the summary is that we wouldn't want someone to
> actually ship a kernel with this option on anyway.  ;-)

FWIW the meta here is really "oops, you've just installed a new kernel 
and now your machine is unusable - you need to take it up with whoever 
supports your platform, but in the meantime this is the minimal thing 
you can do to get things back working as before."

Personally I'm less concerned about folks maintaining "hardware 
products", as I'd like to assume they would hit this in QA and have a 
relatively short loop back to kernel people who know what's up (or at 
least know enough to join the dots to punt it to my inbox). My main 
concern is end users of SBSA-ish platforms who are free to pick and 
choose distros - and/or kernel packages within their distro - and thus 
may bugger up their machine inadvertently if the distro package happens 
to have picked this option up from defconfig (from a quick look at least 
my preferred one has).

>>> 3. Any chance you could make it more obvious that this change is
>>> undesirable and a last resort?  AKA:
>>>
>>> "Stream ID x blocked for security reasons; allow anyway by booting
>>> with arm-smmu.disable_bypass=0"
>>
>> How about:
>>
>>    "Blocked transaction from unknown Stream ID x; boot with
>>     \"arm-smmu.disable_bypass=0\" to allow these transactions, although this
>>     may have security implications."
> 
> Fine with me if it's not too long for an error message.

Sounds good, I'll respin with a slight abbreviation of that (and minus 
the embarrassingly stupid thinko) tomorrow.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
