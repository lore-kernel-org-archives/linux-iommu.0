Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E7C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6409613E6
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6409613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A42FB83498;
	Wed,  2 Jun 2021 14:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wafBcuofrWV8; Wed,  2 Jun 2021 14:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71D5583438;
	Wed,  2 Jun 2021 14:57:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CBBBC000E;
	Wed,  2 Jun 2021 14:57:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE44BC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC6326089C
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JrEYWkNhjYfC for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 14:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D731C607FA
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:57:27 +0000 (UTC)
Received: from mail-ed1-f71.google.com ([209.85.208.71])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1loSJB-00064J-KX
 for iommu@lists.linux-foundation.org; Wed, 02 Jun 2021 14:57:25 +0000
Received: by mail-ed1-f71.google.com with SMTP id
 h18-20020a05640250d2b029038cc3938914so1563407edb.17
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 07:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5UZTctpyMU1tqV2bWypkWi0vBIdQnzmdQjPZbkJkFxI=;
 b=sbElWvGoNqYXtPrXnRNtGiIkYnlX/uQoCpMz2GOEcKGTU3bTuWRumEIqheynfMyWDt
 UcIoRypscNITpsNd1HnpecuyjZbD0OqM4sJmpkKBwD1i1o5Y4GJxF5u7Qwgz+f1cUXcm
 Bl9HYdskW8RrhHzw9f5x+DkJdeSBb49PgOvcs7KNCYaTtVyZQCFZzmfLS/hjQB6R3RdN
 rna11gBBFsNYFXCwb5Acm19LMCqPc+Gh4hTw7TvRZCerhzHGP9PIAMqLNZWb0oHufCfQ
 shhHJ54W4Dn3u4PB6gSds8B6Bqj3RxVyqr7tRxI/6KYt2hT88k6A2rVyRp2WtjUbIQgU
 IJfw==
X-Gm-Message-State: AOAM531ih7mXUhPy5B7q5EktqBwNMrGH+TTjAuNSod8juNbqcAiA+8hz
 R0beBeLHJm7g7m35CT6L9djh+saSpR8t85MOVFYnK9PYSqvMxLryekkbPh8FfYObgodtRrSpgB8
 Y+4Yoc5jr1AC6fvgQS74hO/JdP62Wziv1KlP68MTdeK1ZCNY=
X-Received: by 2002:aa7:db90:: with SMTP id u16mr38474948edt.106.1622645845380; 
 Wed, 02 Jun 2021 07:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ4i0LSt+XF3nCHErp4gakUgDnSABZ0NbDv6a/+Sefs1zN5Oq3E+RJsFlG2lB5k+sufWAKwg==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr38474927edt.106.1622645845191; 
 Wed, 02 Jun 2021 07:57:25 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id f7sm131546ejz.95.2021.06.02.07.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 07:57:24 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box> <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
 <YLdGwD0dxfER4USn@orome.fritz.box>
 <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
 <YLebbQZlROtSq124@orome.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6cc79313-30b9-8223-b346-931ceea301d6@canonical.com>
Date: Wed, 2 Jun 2021 16:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLebbQZlROtSq124@orome.fritz.box>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On 02/06/2021 16:53, Thierry Reding wrote:
> On Wed, Jun 02, 2021 at 12:44:58PM +0200, Krzysztof Kozlowski wrote:
>> On 02/06/2021 10:52, Thierry Reding wrote:
>>> On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
>>>> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
>>>>> On 01/06/2021 20:08, Thierry Reding wrote:
>>>>>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
>>>>>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
>>>>>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
>>>>>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>>>>>
>>>>>>> Probably best if I queue 3-6 on a separate branch once you send a v3,
>>>>>>> then Krzysztof can pull that in if he needs it.
>>>>>>
>>>>>> Patch 5 has a build-time dependency on patch 1, so they need to go in
>>>>>> together. The reason why I suggested Krzysztof pick these up is because
>>>>>> there is a restructuring series that this depends on, which will go into
>>>>>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of other
>>>>>> and mostly unrelated stuff as well.
>>>>>
>>>>> I missed that part... what other series are needed for this one? Except
>>>>> Dmitry's power management set I do not have anything in my sight for
>>>>> Tegras memory controllers.
>>>>>
>>>>> Anyway, I can take the memory bits and provide a stable tag with these.
>>>>> Recently there was quite a lot work around Tegra memory controllers, so
>>>>> this makes especially sense if new patches appear.
>>>>
>>>> OK, I think I have now the patchset you talked about - "memory: tegra:
>>>> Driver unification" v2, right?
>>>
>>> Yes, that's the one. That series is fairly self-contained, but Dmitry's
>>> power management set has dependencies that pull in the regulator, clock
>>> and ARM SoC trees.
>>>
>>> I did a test merge of the driver unification series with a branch that
>>> has Dmitry's patches and all the dependencies and there are no conflicts
>>> so that, fortunately, doesn't further complicates things.
>>>
>>> Do you want me to send you a pull request with Dmitry's memory
>>> controller changes? You could then apply the unification series on top,
>>> which should allow this SMMU series to apply cleanly on top of that.
>>
>> Makes sense and it looks quite bulletproof for future changes. Let's do
>> like this. I will apply your patch 1/10 from this v2 on top of it and
>> driver unification later.
> 
> The SMMU series here depends on the unification series, so the
> unification series needs to go first. It'd be a fair bit of work to
> reverse that because the ->probe_device() callback implemented by the
> first patch of this SMMU series is part of the tegra_mc_ops structure
> that's introduced in the unification series.

Right, you already wrote it in the first email in this thread, I just
reversed words in my head... Then as you wrote - take Dmitry's changes
and share them via pull to me. I'll put on top the unification series,
then #1 from this SMMU series and finally I'll provide a pull request
for Will so his SMMU can go on.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
