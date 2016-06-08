From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Wed, 8 Jun 2016 09:04:17 +0200
Message-ID: <CAMuHMdUr6P=xiiw02wEeJdBw+K_q2ATE9jHgiQ0KCOangYv=tw@mail.gmail.com>
References: <20160607033918.28687.98260.sendpatchset@little-apple>
 <20160607033945.28687.70956.sendpatchset@little-apple> <10108662.fYf10pMtGa@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <10108662.fYf10pMtGa@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Wed, Jun 8, 2016 at 2:18 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- 0031/drivers/iommu/ipmmu-vmsa.c
>> +++ work/drivers/iommu/ipmmu-vmsa.c   2016-06-06 11:19:40.210607110 +0900
>> @@ -1074,7 +1074,7 @@ static const struct ipmmu_features ipmmu
>>       .twobit_imttbcr_sl0 = false,
>>  };
>>
>> -static const struct ipmmu_features ipmmu_features_r8a7795 = {
>> +static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>>       .use_ns_alias_offset = false,
>>       .has_cache_leaf_nodes = true,
>>       .has_eight_ctx = true,
>> @@ -1088,7 +1088,10 @@ static const struct of_device_id ipmmu_o
>>               .data = &ipmmu_features_default,
>>       }, {
>>               .compatible = "renesas,ipmmu-r8a7795",
>> -             .data = &ipmmu_features_r8a7795,
>> +             .data = &ipmmu_features_rcar_gen3,
>> +     }, {
>> +             .compatible = "renesas,ipmmu-r8a7796",
>> +             .data = &ipmmu_features_rcar_gen3,
>>       }, {
>>               /* Terminator */
>>       },
>> @@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
>>                ipmmu_vmsa_iommu_of_setup);
>>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
>>                ipmmu_vmsa_iommu_of_setup);
>> +IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
>> +              ipmmu_vmsa_iommu_of_setup);
>
> How about a Gen3 generic compatible string in addition to the SoC-specific
> ones ?

Do we want to specify the number of utlbs here?
Does it differ between r8a7795, r8a7796, and future members?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
