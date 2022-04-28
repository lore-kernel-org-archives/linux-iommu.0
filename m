Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96D5C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 09:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DCA382F77;
	Thu, 28 Apr 2022 09:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iVfNCSlE1d5a; Thu, 28 Apr 2022 09:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24ACF817D3;
	Thu, 28 Apr 2022 09:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE399C0039;
	Thu, 28 Apr 2022 09:25:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFFA7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E75381839
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IEloCpxiyw5p for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38F3B817D3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:25:46 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id j6so8274945ejc.13
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=tl+Ew+p5mgOymRz/RzX6duiWCdA3k91nvN3DFpn2mvs=;
 b=OGsmf1aLisXy82JCX49AbNjFjZdEWzBM+EZoE6JolFugWYXM1l9os6OUsNciEZ5Fzv
 04HfA8eA3i8SK+37f2xlCpTBF1W1P7sNmOrGuZQUap7XFmxAhGmvW/PrBVRqTcYSS/Uo
 x3fy9G1x0dpRsBDyWXmx8UoUI389bgioMmY0vAvUwYHrYmn9PD9eAhYcnAe0STZUpYgg
 Sj9mSpvvNesXMdckw/4CH0/ZiQ3rcXGAWHqzRhOxaYE4cS+oI5+gX5ZfypYpXGXFd2DE
 ScznhXya/nzDpwSY2XPspwoiU8jok0TRF8CyLXddOKPu4bKRAXHxKUdPmnwdITfXIx6P
 9G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=tl+Ew+p5mgOymRz/RzX6duiWCdA3k91nvN3DFpn2mvs=;
 b=MhQZ7NtjBke8Q75ddJHdQ0iRw//E+Pxl292C7DYrWk9+ZCCojJyY5vnhS0yReWMmNo
 PGX7xfYONu0Ivas7ef8qp7KgreAqgIhjDDkPq66cH35g/PFikV8z8lZrLs/2MK6h5YrN
 8xN0/ZFVQPUrBnEc6QWJmfv0DmSqzG/e1Qw5BerHi/etTal8mbgIjBeFMwU8owC44Ibw
 AmrzmDM0zvp8byf6ihqYJXeqzkAyaZAb2FrLaRsf9cB4O2LGZCQ9Pjir5+0diThSjwBC
 pDv6pB+gxFj/Rq4FaH5rpErekhkvl+Xqz61bh1L/eKLvk1Bx9aN7d9S9BBN26LXgqAIz
 NVOQ==
X-Gm-Message-State: AOAM5312YLpHo6I1KCFBLgX658X7L3oDpBw2uBWZJRO6e+xLrG7cuLdm
 5B5uW4bs0TSNi7l0U1ReuSBjng==
X-Google-Smtp-Source: ABdhPJzZJWIUPFFcj9Xx/KzYR1+lOIN9SMD4blm0AjGKUJNRIbbf+q5YaPOC4uJ1WPlJsCnd4HG/Rg==
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr31340011ejh.77.1651137944365; 
 Thu, 28 Apr 2022 02:25:44 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 w14-20020a1709060a0e00b006f01e581668sm8019551ejf.209.2022.04.28.02.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 02:25:43 -0700 (PDT)
Message-ID: <5ff66242-31a6-113d-d49a-091b82b42a37@linaro.org>
Date: Thu, 28 Apr 2022 11:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: iommu: arm,smmu-v3: make PRI IRQ
 optional
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220427112528.4097815-1-andre.przywara@arm.com>
 <20220427112528.4097815-2-andre.przywara@arm.com>
 <4d37f41c-4463-73e4-7271-8d191e9953af@linaro.org>
 <7c5d39b2-7016-b6c6-ae88-b0f4a517f255@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7c5d39b2-7016-b6c6-ae88-b0f4a517f255@arm.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, iommu@lists.linux-foundation.org,
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

On 28/04/2022 11:23, Robin Murphy wrote:
> On 2022-04-28 07:56, Krzysztof Kozlowski wrote:
>> On 27/04/2022 13:25, Andre Przywara wrote:
>>> The Page Request Interface (PRI) is an optional PCIe feature. As such, a
>>> SMMU would not need to handle it if the PCIe host bridge or the SMMU
>>> itself do not implement it. Also an SMMU could be connected to a platform
>>> device, without any PRI functionality whatsoever.
>>> In all cases there would be no SMMU PRI queue interrupt to be wired up
>>> to an interrupt controller.
>>>
>>> Relax the binding to allow specifying three interrupts, omitting the PRI
>>> IRQ. At the moment, with the "eventq,gerror,priq,cmdq-sync" order, we
>>> would need to sacrifice the command queue sync interrupt as well, which
>>> might not be desired.
>>> The Linux driver does not care about any order at all, just picks IRQs
>>> based on their names, and treats all (wired) IRQs as optional.
>>
>> The last sentence is not a good explanation for the bindings. They are
>> not about Linux and are used in other projects as well.
>>
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 21 ++++++++++++++-----
>>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> index e87bfbcc69135..6b3111f1f06ce 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> @@ -37,12 +37,23 @@ properties:
>>>             hardware supports just a single, combined interrupt line.
>>>             If provided, then the combined interrupt will be used in preference to
>>>             any others.
>>> -      - minItems: 2
>>> +      - minItems: 1
>>>           items:
>>> -          - const: eventq     # Event Queue not empty
>>> -          - const: gerror     # Global Error activated
>>> -          - const: priq       # PRI Queue not empty
>>> -          - const: cmdq-sync  # CMD_SYNC complete
>>> +          - enum:
>>> +              - eventq     # Event Queue not empty
>>> +              - gerror     # Global Error activated
>>> +              - cmdq-sync  # CMD_SYNC complete
>>> +              - priq       # PRI Queue not empty
>>> +          - enum:
>>> +              - gerror
>>> +              - cmdq-sync
>>> +              - priq
>>> +          - enum:
>>> +              - cmdq-sync
>>> +              - priq
>>> +          - enum:
>>> +              - cmdq-sync
>>> +              - priq
>>
>> The order should be strict, so if you want the first interrupt optional,
>> then:
>> oneOf:
>>   - items:
>>      ... 4 items list
>>   - items
>>      ... 3 items list
> 
> All 4 interrupts are optional, though, since any of them could 
> potentially use an MSI instead. Do we really want to list out all 15 
> combinations?

Bah, I missed that part from commit msg. It's fine then.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
