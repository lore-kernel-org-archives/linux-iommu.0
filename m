Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B63FF9
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 17:13:56 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id z18so11685381qts.7
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IYYxWUkQ4C0EsxoWOU79iFj20ViO8vkpHbae7xo5rcs=;
        b=Na0/xpW50l0p2LWBaIM/XHkvizf5pdNgEm4MPvDGNs4tfXsVzy3nI2WggDrVrrfbfR
         8vmNnBl+TiJloFytXKKx8ij7l7JHUAO5qqumCGMHz6gej+TwY2yY1uOnd6rQDW/onfEy
         mhfMenDe81IYCFu4mQwRrjZDNi+aIw2ZMXMs+lAyEOjSqv3xEgtOBhmny+WULZS0YZpw
         ZcZTsS7nWNzFQLBA2LcSPlF+DsEm3gxpzQ/M7fhQy4+5Bt/EF4tS+d1c9J4vprzq2WbL
         WOk5WKySaKYD+sBXvttDusj4zJ0fsKNQJHk9ppoZkcp4ZXt4nHQMWhY5rTa+LYvW5jK+
         LGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IYYxWUkQ4C0EsxoWOU79iFj20ViO8vkpHbae7xo5rcs=;
        b=Ac7dy9XLV6a1IfNJdO7g1zv2xoprRyoJ0L5tb7DtfK6Agbl/9b2Bw/pQx3BlwEyIZC
         SBnXRUq0mrHsVM9ABZRzPPjXQhe8kR24ZpiBlvXnbc3sdWgMBHsehLjVQmzLnAPWwNCj
         ftClxXkjT30o/moHS0DZdzxtd0BKlYXEAD82i9co7Gx1sBUtvE5b1sBQD4DfHcMx/6GV
         DsC+4m7aZxd5JZTzC6C+QtabriCha4s5c5q6jGrglwGLz/3SpI/ERJCgmgKMGAeo0i2Z
         gJ40hZymaC7YcweZi3y+6vqWDD1zqSxpHIu9rWo7OwBzM59nkzVPhgLEUYtMj31wRMNV
         /f4Q==
X-Gm-Message-State: ACgBeo0BShaP1t799FXvLvny8m277eLLiGpvhcqaBDWQwf8Rw5lHPX44
	G2LD+RvxvZKdGOGaEF3fBgI=
X-Google-Smtp-Source: AA6agR6pteFhhNot1KtRms4GIZpWVbQhIx9TFnmz61Z566R8w8B0323kiW2uAkt7jf8sPbn99v0wlg==
X-Received: by 2002:ac8:5e51:0:b0:343:483:f9d6 with SMTP id i17-20020ac85e51000000b003430483f9d6mr33904642qtx.244.1663175635331;
        Wed, 14 Sep 2022 10:13:55 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h16-20020ac85850000000b00342f8d4d0basm1990133qth.43.2022.09.14.10.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:13:54 -0700 (PDT)
Message-ID: <57f19774-39a1-03a6-fe68-83d7e4b16521@gmail.com>
Date: Wed, 14 Sep 2022 10:13:51 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
 Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Florian Fainelli <f.fainelli@gmail.com>, David Hildenbrand
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, - <devicetree-spec@vger.kernel.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
 <20220914145506.GA2149379-robh@kernel.org>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20220914145506.GA2149379-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/2022 7:55 AM, Rob Herring wrote:
> On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
>> Introduce designated-movable-block.yaml to document the
>> devicetree binding for Designated Movable Block children of the
>> reserved-memory node.
> 
> What is a Designated Movable Block? This patch needs to stand on its
> own.
As noted in my reply to your [PATCH 00/21] comment, my intention in 
submitting the entire patch set (and specifically PATCH 00/21]) was to 
communicate this context. Now that I believe I understand that only this 
patch should have been submitted to the devicetree-spec mailing list, I 
will strive harder to make it more self contained.

> 
> Why does this belong or need to be in DT?
While my preferred method of declaring Designated Movable Blocks is 
through the movablecore kernel parameter, I can conceive that others may 
wish to take advantage of the reserved-memory DT nodes. In particular, 
it has the advantage that a device can claim ownership of the 
reserved-memory via device tree, which is something that has yet to be 
implemented for DMBs defined with movablecore.

> 
>>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   .../designated-movable-block.yaml             | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>> new file mode 100644
>> index 000000000000..42f846069a2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: /reserved-memory Designated Movable Block node binding
>> +
>> +maintainers:
>> +  - devicetree-spec@vger.kernel.org
>> +
>> +allOf:
>> +  - $ref: "reserved-memory.yaml"
>> +
>> +properties:
>> +  compatible:
>> +    const: designated-movable-block
>> +    description:
>> +      This indicates a region of memory meant to be placed into
>> +      ZONE_MOVABLE.
> 
> Don't put Linuxisms into bindings.
I will avoid ZONE_MOVABLE if this commit is included in V2 of this patch 
set.
> 
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reusable
>> +
>> +examples:
>> +  - |
>> +      reserved-memory {
>> +          #address-cells = <0x2>;
>> +          #size-cells = <0x2>;
>> +
>> +          DMB0@10800000 {
>> +               compatible = "designated-movable-block";
>> +               reusable;
>> +               reg = <0x0 0x10800000 0x0 0x2d800000>;
>> +          };
>> +
>> +          DMB1@40000000 {
>> +               compatible = "designated-movable-block";
>> +               reusable;
>> +               reg = <0x0 0x40000000 0x0 0x30000000>;
>> +          };
>> +
>> +          DMB2@80000000 {
>> +               compatible = "designated-movable-block";
>> +               reusable;
>> +               reg = <0x0 0x80000000 0x0 0x2fc00000>;
>> +          };
>> +      };
>> -- 
>> 2.25.1
>>
>>
Thank you for the review!
-Doug
