Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F271DC4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFE56138C
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE56138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80500831DB;
	Wed,  2 Jun 2021 07:35:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Drf0FJ5_xXUD; Wed,  2 Jun 2021 07:35:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B38983168;
	Wed,  2 Jun 2021 07:35:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC70DC000D;
	Wed,  2 Jun 2021 07:35:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75A1CC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D7B14031C
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wV_rHw5Lytwz for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:35:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81D7F402EB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:35:16 +0000 (UTC)
Received: from mail-wr1-f72.google.com ([209.85.221.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1loLPG-0002G5-SI
 for iommu@lists.linux-foundation.org; Wed, 02 Jun 2021 07:35:14 +0000
Received: by mail-wr1-f72.google.com with SMTP id
 m14-20020a5d4a0e0000b0290117148ba384so634947wrq.15
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 00:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JvJXLe7wuDMo4dMeJTK8HPwncAx/5KQ4VsWbJ9RYVb4=;
 b=ZROXwaCalHBwhshCkf3RkZRGqYwZD6zgeL9CFV3qjkV00nTzQcqNWFwhL+Zq0TkwWs
 pUKTGlEnmeMnyfWjrb+RjBv3jKwlWZQCURVK3xnHfViBOkxrMX1Xm3Bk9+ZhAkqfOCtf
 Xm0XkxOmVO/vPpdJPsjl6vDMPcB7Uima1Nvs+DbXQEWdpyOmxhOUJ86fpA/j4nZeHU5G
 EMl0VkKpcshTEq1P9sqQmKmB6cQxWb0EcVZ/0t3AzeAR6ovxtWqpvPkuviJhueHgoB8m
 boITKhh040P+Qim0LWtnxDqa436Na9Xfm8F1A9W1bTTRqpojZHhHavBk+q6sb33VDOtv
 MnDA==
X-Gm-Message-State: AOAM532UvOpxgybL+1V6dLnsa+V8ZoY2oweMlRn2OMtWygRdQSlqC6KV
 5yVG/8878HtQkspfbPmWKENTiiYWMspV8s8ASx5aR0HpSZw/ZupQ50J2o8mQxYgO5wnQYZtoWWb
 W1iMxLkMSFE00ynCQgMhmAqBb/imXQBHL8Pp6MefidrVKEzI=
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr24690736wrm.305.1622619314614; 
 Wed, 02 Jun 2021 00:35:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf8k2Z7YB6EATdP0kZ4y/LXCdi7h0gVgiRlY0k3OM3TxL9je0FyaeHuVa+vh7PhXaPmFjJtA==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr24690721wrm.305.1622619314454; 
 Wed, 02 Jun 2021 00:35:14 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id w13sm1785599wmi.4.2021.06.02.00.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:35:13 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box> <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
Message-ID: <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
Date: Wed, 2 Jun 2021 09:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
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

On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
> On 01/06/2021 20:08, Thierry Reding wrote:
>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>> Probably best if I queue 3-6 on a separate branch once you send a v3,
>>> then Krzysztof can pull that in if he needs it.
>>
>> Patch 5 has a build-time dependency on patch 1, so they need to go in
>> together. The reason why I suggested Krzysztof pick these up is because
>> there is a restructuring series that this depends on, which will go into
>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of other
>> and mostly unrelated stuff as well.
> 
> I missed that part... what other series are needed for this one? Except
> Dmitry's power management set I do not have anything in my sight for
> Tegras memory controllers.
> 
> Anyway, I can take the memory bits and provide a stable tag with these.
> Recently there was quite a lot work around Tegra memory controllers, so
> this makes especially sense if new patches appear.

OK, I think I have now the patchset you talked about - "memory: tegra:
Driver unification" v2, right?


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
