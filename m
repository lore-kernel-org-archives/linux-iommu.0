Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A8C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 13:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8C09409ED;
	Wed,  1 Jun 2022 13:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kdrnCXRG0Kne; Wed,  1 Jun 2022 13:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1483C4109F;
	Wed,  1 Jun 2022 13:32:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA9F8C0039;
	Wed,  1 Jun 2022 13:32:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F671C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 13:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3940D404F4
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 13:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsbQw8TivV-O for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 13:32:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC03A4013B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 13:32:07 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id l13so2740988lfp.11
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6AmNd1uoVJElSSIZ5NcicKz1NijvWaHzL3bjyTaCTH4=;
 b=ldSt7vIuRD+IuLgBfjyNqBye32eNJ62ST9orWrrQ7xCyXt5nToDaIro4j7IujIzZIw
 zgZ8vXfHbYGORoIsxAJLQvjkcc6sykEM9L1EyLORHH6oaIcpSY1IUyFUk03VKLCwnPN6
 +6LwGg/O5yk6KhmJNaozXZv2nmZ9jjdhr218OF8Xzfva6FguxwE3Hdd8DrotuQXxODYV
 ocw8FcfH9d/LPrBKVlTYvsTkJqyYatVMDZ+6eGYRZc3e5wOgbRaPB/gd6lX7imnGwALe
 3Zrzu6o06WNYbgVRgdyOI4ykt7Tb46alUg5IEUKgeCqhd4Re1nl50dMdjR8kh7X+CtQR
 trgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6AmNd1uoVJElSSIZ5NcicKz1NijvWaHzL3bjyTaCTH4=;
 b=DuyP9zCZQZ7gcu/LsXZ66HtWKcfzioHpZiypOCPLJlBI+4EL103VAc3fTLSwtR5cYZ
 wOxJXcQ2ZKE29AuoMl1GkHwwXC6FM7klqqJJMQUqEe4jWAulpL1jdRhKKp8nTTlpVgj+
 fE2oM+HsDU7UpRDzkAbuGA0TzA/obXjWOLDKcYbatSJzvEkaJ3LkBI2uiHv2m5nYXP2N
 yJJ/HFsgx4Apr0HxXBmOAKMhguA93znEYb71ujiy2oFAYiQsADXWUqptm8RHqFUBOHej
 rDiB360lEdLfR3ZrI+Zx0XWDX9q2KIc6zKuviv1+2HPMmkD8LdGWE2+Xz3fN8z5KvNXL
 qEQQ==
X-Gm-Message-State: AOAM5325ZOPKv9ozpGvc2LPEeeeIMMUm2p2VX2BrjbFj7pPWRrxiksKK
 0mBuotBQdii2vEG7yOI448Y=
X-Google-Smtp-Source: ABdhPJxB3fNJrJkKRrllMC2ycuvNXzvXlHnLWls/OtCzWnm+TxujSRcM7FqomSJRwMxSqo/CEZZNhg==
X-Received: by 2002:a05:6512:1041:b0:478:afc6:5846 with SMTP id
 c1-20020a056512104100b00478afc65846mr24643051lfb.132.1654090325618; 
 Wed, 01 Jun 2022 06:32:05 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a05651233d400b0047255d2115csm366642lfg.139.2022.06.01.06.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jun 2022 06:32:05 -0700 (PDT)
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
To: Stefano Stabellini <sstabellini@kernel.org>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2205311726000.1905099@ubuntu-linux-20-04-desktop>
From: Oleksandr <olekstysh@gmail.com>
Message-ID: <31c21ef0-3847-a896-a387-c2e1cc0f9467@gmail.com>
Date: Wed, 1 Jun 2022 16:32:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2205311726000.1905099@ubuntu-linux-20-04-desktop>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>, devicetree@vger.kernel.org,
 Julien Grall <julien@xen.org>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 xen-devel@lists.xenproject.org, Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 01.06.22 03:34, Stefano Stabellini wrote:

Hello Stefano

> On Tue, 31 May 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> The main purpose of this binding is to communicate Xen specific
>> information using generic IOMMU device tree bindings (which is
>> a good fit here) rather than introducing a custom property.
>>
>> Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
>> to be used by Xen grant DMA-mapping layer in the subsequent commit.
>>
>> The reference to Xen specific IOMMU node using "iommus" property
>> indicates that Xen grant mappings need to be enabled for the device,
>> and it specifies the ID of the domain where the corresponding backend
>> resides. The domid (domain ID) is used as an argument to the Xen grant
>> mapping APIs.
>>
>> This is needed for the option to restrict memory access using Xen grant
>> mappings to work which primary goal is to enable using virtio devices
>> in Xen guests.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> Changes RFC -> V1:
>>     - update commit subject/description and text in description
>>     - move to devicetree/bindings/arm/
>>
>> Changes V1 -> V2:
>>     - update text in description
>>     - change the maintainer of the binding
>>     - fix validation issue
>>     - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
>>
>> Change V2 -> V3:
>>     - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
>>     - use generic IOMMU device tree bindings instead of custom property
>>       "xen,dev-domid"
>>     - change commit subject and description, was
>>       "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
>> ---
>>   .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 49 ++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>> new file mode 100644
>> index 00000000..ab5765c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xen specific IOMMU for virtualized devices (e.g. virtio)
>> +
>> +maintainers:
>> +  - Stefano Stabellini <sstabellini@kernel.org>
>> +
>> +description:
>> +  The reference to Xen specific IOMMU node using "iommus" property indicates
>> +  that Xen grant mappings need to be enabled for the device, and it specifies
>> +  the ID of the domain where the corresponding backend resides.
>> +  The binding is required to restrict memory access using Xen grant mappings.
> I think this is OK and in line with the discussion we had on the list. I
> propose the following wording instead:
>
> """
> The Xen IOMMU represents the Xen grant table interface. Grant mappings
> are to be used with devices connected to the Xen IOMMU using the
> "iommus" property, which also specifies the ID of the backend domain.
> The binding is required to restrict memory access using Xen grant
> mappings.
> """
>
>
>> +properties:
>> +  compatible:
>> +    const: xen,grant-dma
>> +
>> +  '#iommu-cells':
>> +    const: 1
>> +    description:
>> +      Xen specific IOMMU is multiple-master IOMMU device.
>> +      The single cell describes the domid (domain ID) of the domain where
>> +      the backend is running.
> Here I would say:
>
> """
> The single cell is the domid (domain ID) of the domain where the backend
> is running.
> """
>
> With the two wording improvements:

I am happy with proposed wording improvements, will update.


>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks!


>
>
>> +required:
>> +  - compatible
>> +  - "#iommu-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    xen_iommu {
>> +        compatible = "xen,grant-dma";
>> +        #iommu-cells = <1>;
>> +    };
>> +
>> +    virtio@3000 {
>> +        compatible = "virtio,mmio";
>> +        reg = <0x3000 0x100>;
>> +        interrupts = <41>;
>> +
>> +        /* The backend is located in Xen domain with ID 1 */
>> +        iommus = <&xen_iommu 1>;
>> +    };
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
-- 
Regards,

Oleksandr Tyshchenko

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
