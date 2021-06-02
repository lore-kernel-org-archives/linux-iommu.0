Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361AC4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:58:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99565613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99565613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69D6F83C64;
	Wed,  2 Jun 2021 14:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9SyXZ5Jyj5n; Wed,  2 Jun 2021 14:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9F5483438;
	Wed,  2 Jun 2021 14:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0581C000E;
	Wed,  2 Jun 2021 14:58:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAAE4C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9E9983438
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jVsUnpqXh1u for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 14:58:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5B3283490
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:58:14 +0000 (UTC)
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1loSJx-0006C8-5H
 for iommu@lists.linux-foundation.org; Wed, 02 Jun 2021 14:58:13 +0000
Received: by mail-ed1-f70.google.com with SMTP id
 dd28-20020a056402313cb029038fc9850034so1580296edb.7
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 07:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=752p4tr8om9PZTkMN+y5OaTny2tseRBiO4Qw5qPX/uc=;
 b=ao6KZLezQYjOTsdP53HN5Eq5dDre3qti/N1Le+y+VrPsUX/T3J5R0uIQ649YhbO02/
 CMuiOw4zDjGaugUh7EtrXlUElNi9OQDsJE6fwCeIwdunINn51+A5A/M4DXQgvxfx+mT6
 v7aHJ7uTqQmAx6H5/ZWn78zOpN8/5Zxt0HHbqEIlarZHmrcTZRzWcgSCeq2f96ZZ8gfO
 zvlWsaJ9nc+lAozaceu6chvAXavEoygoVy1D6UwczEpqC6VtXO1eYewOqZVzrf6UfKGZ
 WOBUnAzWFmrBBXnxCc8OAYb72Nlm5+YWNu3iJyPWjrpA+hPBnng+yZ+nH01j+NKXGPOH
 qLdg==
X-Gm-Message-State: AOAM530sU2mmcBpjtWn/sGkORjgcMIG550ZetD+zqpBwDLpy9UVFzWZ6
 eTxGUJNBAGWNR8lZfcIKA95/CLRtYQBZR8QlYLB8nG5/XqzXv/o6bTNKFwHp9iKQoANA3XNHGbV
 dRIX+fvcLV46Sx2nHSSsz7qBeg8p2a6P+aH7SgS/gKCAePMo=
X-Received: by 2002:a17:906:c0da:: with SMTP id
 bn26mr34977228ejb.437.1622645892872; 
 Wed, 02 Jun 2021 07:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkFWWKXUi9uF3fTYTqDvU90HNZjSch1pOOs5UUihZd7KkSvKKBSG8U5eE+iM6V9QT5ZvntNg==
X-Received: by 2002:a17:906:c0da:: with SMTP id
 bn26mr34977219ejb.437.1622645892708; 
 Wed, 02 Jun 2021 07:58:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id u15sm115179edy.29.2021.06.02.07.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 07:58:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box> <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
 <YLdGwD0dxfER4USn@orome.fritz.box>
 <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
 <20210602114049.GF30593@willie-the-truck> <YLeclZlP8l3dMX4o@orome.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cc37b000-74f9-696a-e7f6-964b8f948743@canonical.com>
Date: Wed, 2 Jun 2021 16:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLeclZlP8l3dMX4o@orome.fritz.box>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 02/06/2021 16:58, Thierry Reding wrote:
> On Wed, Jun 02, 2021 at 12:40:49PM +0100, Will Deacon wrote:
>> On Wed, Jun 02, 2021 at 12:44:58PM +0200, Krzysztof Kozlowski wrote:
>>> On 02/06/2021 10:52, Thierry Reding wrote:
>>>> On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
>>>>> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
>>>>>> On 01/06/2021 20:08, Thierry Reding wrote:
>>>>>>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
>>>>>>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
>>>>>>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
>>>>>>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>>>>>>
>>>>>>>> Probably best if I queue 3-6 on a separate branch once you send a v3,
>>>>>>>> then Krzysztof can pull that in if he needs it.
>>>>>>>
>>>>>>> Patch 5 has a build-time dependency on patch 1, so they need to go in
>>>>>>> together. The reason why I suggested Krzysztof pick these up is because
>>>>>>> there is a restructuring series that this depends on, which will go into
>>>>>>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of other
>>>>>>> and mostly unrelated stuff as well.
>>>>>>
>>>>>> I missed that part... what other series are needed for this one? Except
>>>>>> Dmitry's power management set I do not have anything in my sight for
>>>>>> Tegras memory controllers.
>>>>>>
>>>>>> Anyway, I can take the memory bits and provide a stable tag with these.
>>>>>> Recently there was quite a lot work around Tegra memory controllers, so
>>>>>> this makes especially sense if new patches appear.
>>>>>
>>>>> OK, I think I have now the patchset you talked about - "memory: tegra:
>>>>> Driver unification" v2, right?
>>>>
>>>> Yes, that's the one. That series is fairly self-contained, but Dmitry's
>>>> power management set has dependencies that pull in the regulator, clock
>>>> and ARM SoC trees.
>>>>
>>>> I did a test merge of the driver unification series with a branch that
>>>> has Dmitry's patches and all the dependencies and there are no conflicts
>>>> so that, fortunately, doesn't further complicates things.
>>>>
>>>> Do you want me to send you a pull request with Dmitry's memory
>>>> controller changes? You could then apply the unification series on top,
>>>> which should allow this SMMU series to apply cleanly on top of that.
>>>
>>> Makes sense and it looks quite bulletproof for future changes. Let's do
>>> like this. I will apply your patch 1/10 from this v2 on top of it and
>>> driver unification later.
>>
>> Okey doke. Thierry -- please let me know which patches I can queue. Having
>> the SMMU driver changes in the IOMMU tree really helps in case of conflicts
>> with other SMMU changes. As I say, I can put stuff on a separate branch for
>> you if it helps.
> 
> Given that the SMMU patches have a build-time dependency on the first
> patch in the series, and the series depends on the unification series, I
> think Krzysztof would have to pull the memory controller branch that I
> have with Dmitry's work, apply the unification series on top and then
> take patch 1 of this series on top of that. That's the state that you'd
> have to pull into the SMMU tree to get the right dependencies.
> 
> The SMMU pieces are the leaf of the dependency tree, so technically no
> separate branch is needed, because I don't think anybody would have to
> pull from it. However, a separate branch might make it easier to back
> any of this work out if we have to.
> 
> Krzysztof, I do plan on sending out a v3 of the unification series to
> address the two cleanups that Dmitry and you have pointed out. After
> that I can send out v3 of this series to fix the ordering issue that
> Krishna had mentioned. After all of those are applied, would you be able
> to provide a stable branch for Will's SMMU tree?

Yes, I will provide a stable branch/tag.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
