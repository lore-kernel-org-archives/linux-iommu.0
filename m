Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64404C48BE5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 06:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E686102A
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 06:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E686102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C12F28301F;
	Mon, 21 Jun 2021 06:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEly3kzF78BF; Mon, 21 Jun 2021 06:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9321B82FAE;
	Mon, 21 Jun 2021 06:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 603A3C000E;
	Mon, 21 Jun 2021 06:47:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 835C1C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 06:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D42C400F3
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 06:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2niCfKrxYUw for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 06:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FE24400CD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 06:46:59 +0000 (UTC)
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lvDhx-0004mT-Lg
 for iommu@lists.linux-foundation.org; Mon, 21 Jun 2021 06:46:57 +0000
Received: by mail-ed1-f70.google.com with SMTP id
 l9-20020a0564022549b0290394bafbfbcaso435638edb.3
 for <iommu@lists.linux-foundation.org>; Sun, 20 Jun 2021 23:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HBV8dNLDqIEAfk7W6R3y2yg9WhGkmywydr9E1vv22xo=;
 b=jPkDS4T0ZIRv8bmVNgNm6FU+M+BGLOVPSq3+d+QIN5oLhBh9ix5Tx5ucKe1zr4d4gV
 30B03cpaDDzefea/miZCDvL8m//aShKxCRzV9wcZWWQpgRgrlMPJLnuuTycTk+qcVIc1
 ch+0+D96mmruTHREZTGIe415Vnqv6nE4Shuup57v92SSwZBKKBf3H9cLFOjAaDT8jnZL
 iuPfqV5q7Tp757v38FgFbbpQTYg65RR5KxlN2U/84yiHY5yp9kzgMSLMeGk6Mc8fZHe/
 4fEYk1C9vgQG54Gz3xQY44tbGmKHzL1ehqgXhnqqmeZ2tyh5O21noCrtEA1e8qB5sLjO
 Z4qg==
X-Gm-Message-State: AOAM530FV8cCwmI7bATGbcxXUhHMXidVKZtH3XJBcnACjl5D2ghkhVSS
 TjvkYrCqgI8gWOn/L6HunWxNT63M6CitRf1eqCxL0tKNX4kyhFVfWATPJxaHy9u2TKtGSJEzndc
 SvcW3lCJYBzlfps/yJApK6RnZT8VvX/p062rELleHW6zLBIY=
X-Received: by 2002:aa7:cb43:: with SMTP id w3mr11978035edt.126.1624258016711; 
 Sun, 20 Jun 2021 23:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW7f8aTJ93Kkruw0X6I/5OojOVeM3oazExumrI1P2lMRb9QkgVXDIlJDsddLfp5/Vdq5FSOA==
X-Received: by 2002:aa7:cb43:: with SMTP id w3mr11977987edt.126.1624258016218; 
 Sun, 20 Jun 2021 23:46:56 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id w8sm9950041edc.39.2021.06.20.23.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Jun 2021 23:46:55 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible
 string
To: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Will Deacon <will@kernel.org>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-3-thierry.reding@gmail.com>
 <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <14551e79-853d-471f-bb5e-0d2d6581a9b6@canonical.com>
Date: Mon, 21 Jun 2021 08:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
Content-Language: en-US
Cc: Jon Hunter <jonathanh@nvidia.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 18/06/2021 21:47, Rob Herring wrote:
> On Thu, Jun 3, 2021 at 10:49 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The ARM SMMU instantiations found on Tegra186 and later need inter-
>> operation with the memory controller in order to correctly program
>> stream ID overrides.
>>
>> Furthermore, on Tegra194 multiple instances of the SMMU can gang up
>> to achieve higher throughput. In order to do this, they have to be
>> programmed identically so that the memory controller can interleave
>> memory accesses between them.
>>
>> Add the Tegra186 compatible string to make sure the interoperation
>> with the memory controller can be enabled on that SoC generation.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 9d27aa5111d4..1181b590db71 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -54,8 +54,14 @@ properties:
>>            - const: arm,mmu-500
>>        - description: NVIDIA SoCs that program two ARM MMU-500s identically
>>          items:
>> +      - description: NVIDIA SoCs that require memory controller interaction
> 
> This is not valid jsonschema:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> properties:compatible:oneOf:4:items: 'anyOf' conditional failed, one
> must be fixed:
> None is not of type 'object', 'boolean'
> None is not of type 'array'
> from schema $id: http://json-schema.org/draft-07/schema#
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> must be fixed:
> None is not of type 'object'
> None is not of type 'array'
> from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> must be fixed:
> None is not of type 'object'
> None is not of type 'array'
> from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> properties:compatible:oneOf:5:items: 'oneOf' conditional failed, one
> must be fixed:
> [{'enum': [{'const': 'nvidia,tegra194-smmu'}, {'const':
> 'nvidia,tegra186-smmu'}]}, {'const': 'nvidia,smmu-500'}] is not of
> type 'object'
> {'const': 'nvidia,tegra194-smmu'} is not of type 'string'
> {'const': 'nvidia,tegra186-smmu'} is not of type 'string'
> from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> 
> 
> This was not reviewed nor tested since the DT list was not Cc'ed.

Ugh, I see now weird empty item on a list... and not only DT list was
skipped - Thierry did not Cc you either.

My bad, I did not check that patch thoroughly before applying.

Thierry, please Cc folks mentioned by get_maintainer.pl. Either sent a
fix or a revert, if fix needs more time.

Additionally, why the patch changes reg to "minItems: 1" for
nvidia,tegra194-smmu?

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
