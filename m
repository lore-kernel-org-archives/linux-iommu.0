Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D46C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:45:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133DD613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133DD613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C038640146;
	Wed,  2 Jun 2021 10:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dr0eYi4aJk03; Wed,  2 Jun 2021 10:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38C51400FE;
	Wed,  2 Jun 2021 10:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A13DC000E;
	Wed,  2 Jun 2021 10:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A115CC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8269440200
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:45:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ns-hNk2bjWKf for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 10:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AB6E401DF
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:45:02 +0000 (UTC)
Received: from mail-wr1-f69.google.com ([209.85.221.69])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1loOMu-0002OH-8r
 for iommu@lists.linux-foundation.org; Wed, 02 Jun 2021 10:45:00 +0000
Received: by mail-wr1-f69.google.com with SMTP id
 m27-20020a056000025bb0290114d19822edso821560wrz.21
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 03:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6l9d/plZ9XddbApdgPcRQ9TqJFyv+O7FipqUo+rW4CY=;
 b=tI9QRQh8Z3GEYh/nhkPyql0OmnwXYQMHDOY/EucKF5zqtTCPa6lGXyOwPBLioK7Zfz
 a4tppus5U3G7zODZAesTFzypo1Syb/M9i1yGhCHXOD4E7JroERwQNdpwPlWO/h4ZEzH9
 y4mOZi++m46ew4/3dBKwIN7zfWweXDkG1tBBc6CQa0svkfEBqsyz1Z6KlkGwksF0I+BQ
 adw+EAO825o03FyCTFuVZHahGrY24YdXlR7F+s2r+cHRQ+rIgrG7l8/XFYsGYYnde/Lt
 ZjloUMc6T7lgrz3CQvuJ26QgH/JqmMg9cmg43f9yBhSAUDI021eDuT1H2zAUq0trwb+/
 KlHA==
X-Gm-Message-State: AOAM531FWymMILkE9pGX5h3l+/n5unqIyEinLlhvJ9ofCL/6xg4XU4IG
 YZINUM4IK1s9H9BVMkjWZ+hjjlNH0zPSgfBNca/ds3QPVv/6sAxAAuO1f0Vdy45ftP9s8I7O6CQ
 j6gQJyQa0xLYne6iavJ6XEwILZbKLO4rb4JbiWC/wUT5Rj7k=
X-Received: by 2002:a05:600c:268c:: with SMTP id
 12mr4443148wmt.109.1622630699993; 
 Wed, 02 Jun 2021 03:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKpaGGlEr4Nw1dWfVjARZtOvA9UOz6mkAXdebnImW6ggQP7wJDJXxXkU+jNoC7yBdD30pCdQ==
X-Received: by 2002:a05:600c:268c:: with SMTP id
 12mr4443126wmt.109.1622630699811; 
 Wed, 02 Jun 2021 03:44:59 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id b26sm2323848wmj.25.2021.06.02.03.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 03:44:59 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box> <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
 <YLdGwD0dxfER4USn@orome.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
Date: Wed, 2 Jun 2021 12:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLdGwD0dxfER4USn@orome.fritz.box>
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

On 02/06/2021 10:52, Thierry Reding wrote:
> On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
>> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
>>> On 01/06/2021 20:08, Thierry Reding wrote:
>>>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
>>>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
>>>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
>>>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>>>
>>>>> Probably best if I queue 3-6 on a separate branch once you send a v3,
>>>>> then Krzysztof can pull that in if he needs it.
>>>>
>>>> Patch 5 has a build-time dependency on patch 1, so they need to go in
>>>> together. The reason why I suggested Krzysztof pick these up is because
>>>> there is a restructuring series that this depends on, which will go into
>>>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of other
>>>> and mostly unrelated stuff as well.
>>>
>>> I missed that part... what other series are needed for this one? Except
>>> Dmitry's power management set I do not have anything in my sight for
>>> Tegras memory controllers.
>>>
>>> Anyway, I can take the memory bits and provide a stable tag with these.
>>> Recently there was quite a lot work around Tegra memory controllers, so
>>> this makes especially sense if new patches appear.
>>
>> OK, I think I have now the patchset you talked about - "memory: tegra:
>> Driver unification" v2, right?
> 
> Yes, that's the one. That series is fairly self-contained, but Dmitry's
> power management set has dependencies that pull in the regulator, clock
> and ARM SoC trees.
> 
> I did a test merge of the driver unification series with a branch that
> has Dmitry's patches and all the dependencies and there are no conflicts
> so that, fortunately, doesn't further complicates things.
> 
> Do you want me to send you a pull request with Dmitry's memory
> controller changes? You could then apply the unification series on top,
> which should allow this SMMU series to apply cleanly on top of that.

Makes sense and it looks quite bulletproof for future changes. Let's do
like this. I will apply your patch 1/10 from this v2 on top of it and
driver unification later.

> I can also carry all these changes in the Tegra tree and send a PR in a
> few days once this has seen a bit more testing in linux-next, which also
> makes sure it's got a bit more testing in our internal test farm.
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
