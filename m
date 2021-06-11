Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBBC4743D
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 06:43:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BC461285
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 06:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BC461285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CB5A403E8;
	Fri, 11 Jun 2021 06:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIccklLsDnuR; Fri, 11 Jun 2021 06:43:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF51A4017D;
	Fri, 11 Jun 2021 06:43:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE19CC000D;
	Fri, 11 Jun 2021 06:43:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFEFC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 06:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 799D283B8A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 06:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eXYsmGVFPaos for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 06:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7BDB83B82
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 06:43:31 +0000 (UTC)
Received: from mail-wm1-f72.google.com ([209.85.128.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lrat7-0000de-HY
 for iommu@lists.linux-foundation.org; Fri, 11 Jun 2021 06:43:29 +0000
Received: by mail-wm1-f72.google.com with SMTP id
 v25-20020a1cf7190000b0290197a4be97b7so4037320wmh.9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 23:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C6gfNxumQvAauUH0UC3BQ6OzW6ImVhOU0dXOw2iPMH4=;
 b=Co4Nd9J9BoOlAjXKWo5rsxsXe4a+kUY5IfPqXcndU6okHpSAKmeJHvkRXnHip7vJ1v
 x4dhF7RAAuuKr2BGZga7Ul6a9ewE/5rpx9AwMZ+nqJk/Mt/ycacX2EHlT4JY3axCKiUj
 bRBQU9aj6nlWYABUylJAB6b+ppHgLOPXjB4M8qRHrc3UyT9t0zbKDaHTnvTOrfSiPqFu
 0dM1n+HG3ZL7DYkI3dpNh+cJI+QG/hlYu+VmboH5TGKJ8NmK9kskNyI6+dDbdD044eH7
 wkcach2fOZDYpMueD914ycwPQuF+p8n19Diszy5/nYcL64M2RhF5S7KKzJmDVGN57puc
 Rdwg==
X-Gm-Message-State: AOAM531P4ktfN/eQSRGUekM6Yf734yDqlwBrWGWrB7lVp0qTvKDN05A0
 T6Y3cwPsBlupb3lNI7ublezwNqI4O23F7bvCvzHaz37bR8o1ItoH8pI/JABZpr3jX9bJFYzxuRh
 mkFDQ6tO0gZ1DeSyKwh2ALJOHHjYcY+gxsqaDNNTgztL1Wpw=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr2088752wrq.376.1623393809259; 
 Thu, 10 Jun 2021 23:43:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHIHXoAf7h4WnhTsz2rFmYQsfMYz4c84IeQVys+BC1mK1A1qd9wPsV+eWGDJaHAx4PsGcQwA==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr2088742wrq.376.1623393809106; 
 Thu, 10 Jun 2021 23:43:29 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id z5sm6018735wrv.67.2021.06.10.23.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 23:43:28 -0700 (PDT)
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
To: Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck> <YL+A+MPjjaa3nSwq@orome.fritz.box>
 <20210608164851.GB10994@willie-the-truck> <YMHZCaRiQNQCSsVr@orome.fritz.box>
 <8c18edeb-2e3e-9072-6bb4-11637d0ca3e5@canonical.com>
 <YMIqNynz29Z9fYi3@orome.fritz.box> <20210610172958.GA14188@willie-the-truck>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <583c33e7-562f-0b1c-72b7-71f008a721f4@canonical.com>
Date: Fri, 11 Jun 2021 08:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610172958.GA14188@willie-the-truck>
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

On 10/06/2021 19:29, Will Deacon wrote:
> On Thu, Jun 10, 2021 at 05:05:27PM +0200, Thierry Reding wrote:
>> On Thu, Jun 10, 2021 at 04:23:56PM +0200, Krzysztof Kozlowski wrote:
>>> On 10/06/2021 11:19, Thierry Reding wrote:
>>>> On Tue, Jun 08, 2021 at 05:48:51PM +0100, Will Deacon wrote:
>>>>> I can queue as much or as little of 2-6 as you like, but I would like to
>>>>> avoid pulling in the memory controller queue into the arm smmu tree. But
>>>>> yes, whichever of those I take, I can put them on a separate branch so
>>>>> that you're not blocked for the later patches.
>>>>>
>>>>> You have a better handle on the dependencies, so please tell me what works
>>>>> for you. I just want to make sure that at least patch 3 lands in my tree,
>>>>> so we don't get late conflicts with other driver changes.
>>>>
>>>> Yes, if you could pick up patch 3 and send out a link with the stable
>>>> branch, I think Krzysztof or I could pull in that branch and pick up the
>>>> remaining patches. It'd be good if you could also ack the remaining SMMU
>>>> patches so that ARM SoC knows that they've been sanctioned.
>>>>
>>>> Krzysztof: would you be okay with picking up patches 2 and 4-6 on top of
>>>> your memory branch for v5.14?
>>>
>>> You mean the iommu patches? Yes, I can take them and later explain to
>>> Arnd/Olof why they come through me.
>>
>> Okay, great.
>>
>> Will, can you provide that stable branch? Or would you prefer if I
>> prepared it and sent you a pull request? We're kind of running out of
>> time, since for ARM SoC the cut-off point for new material is usually
>> -rc6 and that's coming up pretty fast.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-thierry/arm-smmu

Merged, thanks.

I'll take ARM/SMMU patches from Thierry's patchset: 2, 4-6.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
