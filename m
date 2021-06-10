Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E49C48BE0
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:24:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726ED613E7
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726ED613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4417383D4D;
	Thu, 10 Jun 2021 14:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGJmWmXyXcdE; Thu, 10 Jun 2021 14:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BD8B83D56;
	Thu, 10 Jun 2021 14:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 004F8C000E;
	Thu, 10 Jun 2021 14:24:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3329C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8399040637
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oIKCushUcghj for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4019640633
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:24:00 +0000 (UTC)
Received: from mail-wr1-f72.google.com ([209.85.221.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lrLbC-0002JX-4H
 for iommu@lists.linux-foundation.org; Thu, 10 Jun 2021 14:23:58 +0000
Received: by mail-wr1-f72.google.com with SMTP id
 n2-20020adfb7420000b029010e47b59f31so957312wre.9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+wqZL59v8SDuZCGAvgfZHpaTUmd/SqDTBj4hRdNKBbo=;
 b=Dzusu0H2fYBenxeQwSIDHjII80T/efXnj4d+x8giqZTRu2dmVx92rbl3T1BhFzyuKW
 M4OZHZLLLUfDHYQXNwBpnqqFDJHp0T0dHzZOqRSP/xqq9CrW6B8KclE5SAbPdUYzKRa8
 lFejDH+3X4AVf85Dg5SiBjImLdJWAn1uLtoSa+klntlG84xlJPxSDWzs5BoRx8NlxrtS
 Yp4gKgWkOTPeoWKlYiU18l8F5GZQtpIIykc2kQHQ5R4KWk73U5bEX/7hWf/UxsWqUX+/
 /pjieuECMkxHWR0Jq9XhFGVgyqw3xOqjdH/upPeiErHq9MDLkBbIVF66Vq1f4MAi+vak
 XFpQ==
X-Gm-Message-State: AOAM532tElLRGef+czk+jA1erTopjLYj0rkP2pTBKR2Qzj8kYUNhq0+M
 dGC72QicUUX2vcWLTeN7pj+QK5jqlCqsWIxTAZOcwD7qs3ZM0izq1P2l3KoFE87BHI1LEAMlAME
 455V89Fb8T2md9iI1HS13rgIgajZbHj8wf1mD3HIls1vLgC8=
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr5916074wro.164.1623335037669; 
 Thu, 10 Jun 2021 07:23:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWLlTc3t66M+OqJpzcEjLbLm8rLUWjRR9mtinW1Hr3buaD1/RibxYzmB57pMJb/ZxfXIgvyQ==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr5916040wro.164.1623335037448; 
 Thu, 10 Jun 2021 07:23:57 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id p5sm3834669wrd.25.2021.06.10.07.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 07:23:56 -0700 (PDT)
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck> <YL+A+MPjjaa3nSwq@orome.fritz.box>
 <20210608164851.GB10994@willie-the-truck> <YMHZCaRiQNQCSsVr@orome.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8c18edeb-2e3e-9072-6bb4-11637d0ca3e5@canonical.com>
Date: Thu, 10 Jun 2021 16:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMHZCaRiQNQCSsVr@orome.fritz.box>
Content-Language: en-US
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/06/2021 11:19, Thierry Reding wrote:
> On Tue, Jun 08, 2021 at 05:48:51PM +0100, Will Deacon wrote:
>> On Tue, Jun 08, 2021 at 04:38:48PM +0200, Thierry Reding wrote:
>>> On Tue, Jun 08, 2021 at 01:01:29PM +0100, Will Deacon wrote:
>>>> On Mon, Jun 07, 2021 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
>>>>> This is the pull for you to base further SMMU aptches (prevent early SMMU
>>>>> faults).
>>>>
>>>> This is a tonne of code for me to pull into the SMMU tree given that I only
>>>> want one patch!
>>>>
>>>> Thierry, if I just stick:
>>>>
>>>> https://lore.kernel.org/r/20210603164632.1000458-4-thierry.reding@gmail.com
>>>>
>>>> on its own branch, can you stitch together whatever you need?
>>>
>>> I'm not sure I understand what you're proposing. For reference, here's
>>> the set of patches that I sent out:
>>>
>>>   1. memory: tegra: Implement SID override programming
>>>   2. dt-bindings: arm-smmu: Add Tegra186 compatible string
>>>   3. iommu/arm-smmu: Implement ->probe_finalize()
>>>   4. iommu/arm-smmu: tegra: Detect number of instances at runtime
>>>   5. iommu/arm-smmu: tegra: Implement SID override programming
>>>   6. iommu/arm-smmu: Use Tegra implementation on Tegra186
>>>   7. arm64: tegra: Use correct compatible string for Tegra186 SMMU
>>>   8. arm64: tegra: Hook up memory controller to SMMU on Tegra186
>>>   9. arm64: tegra: Enable SMMU support on Tegra194
>>>
>>> Krzysztof already picked up patch 1 and I was assuming that you'd pick
>>> up 2-6 because they are to the ARM SMMU driver. However, if you're
>>> primarily interested in just patch 3, which is more "core" ARM SMMU than
>>> the rest, which are Tegra-specific, then I suppose what we could do is
>>> for you to give an Acked-by on the rest (2, 4-6) and then Krzysztof or I
>>> can pick them up and take them via ARM SoC, based on the stable branch
>>> from your tree that only has patch 3.
>>
>> I think you previously said that patch 5 depends on patch 1, so I can't
>> take 2-6 without also pulling in the memory controller queue.
>>
>>> Patch 6 touches arm-smmu-impl.c, though it's a two-line change that
>>> touches only the Tegra-specific matching bit in arm_smmu_impl_init(), so
>>> the likelihood of that conflicting with anything else is fairly small.
>>>
>>> Is that what you were proposing?
>>
>> I can queue as much or as little of 2-6 as you like, but I would like to
>> avoid pulling in the memory controller queue into the arm smmu tree. But
>> yes, whichever of those I take, I can put them on a separate branch so
>> that you're not blocked for the later patches.
>>
>> You have a better handle on the dependencies, so please tell me what works
>> for you. I just want to make sure that at least patch 3 lands in my tree,
>> so we don't get late conflicts with other driver changes.
> 
> Yes, if you could pick up patch 3 and send out a link with the stable
> branch, I think Krzysztof or I could pull in that branch and pick up the
> remaining patches. It'd be good if you could also ack the remaining SMMU
> patches so that ARM SoC knows that they've been sanctioned.
> 
> Krzysztof: would you be okay with picking up patches 2 and 4-6 on top of
> your memory branch for v5.14?

You mean the iommu patches? Yes, I can take them and later explain to
Arnd/Olof why they come through me.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
