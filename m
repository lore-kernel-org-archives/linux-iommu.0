Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80763C43467
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 12:02:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C121D7F
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TKHmU4GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2EF486A46;
	Mon, 12 Oct 2020 12:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3E1j2LXlZpf; Mon, 12 Oct 2020 12:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 037C086A1D;
	Mon, 12 Oct 2020 12:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF063C0052;
	Mon, 12 Oct 2020 12:02:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9755DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 12:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 84D8686A1D
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 12:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56QotKfPU196 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8BE4086A27
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 12:02:12 +0000 (UTC)
X-UUID: ffba327e58714f71a6d76e7305d4bd5f-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Bm1nD1Rni6NjuejkSKF6tuW+1OZNvmAl+g7ZgtGLPq8=; 
 b=TKHmU4GJsUveGwDhBPx/LGSjxR3leBMs8N6y7bwJSxOlan0sk7oer/u9vRRlh3s8X7pSSOkMjjvVFrcXHQYITLDunKJ05E3CZDH3JfQSPA+Hjn/qPzO0MKzEwDmWiZq4c+B2nkb04cH3V8CaQuYNO+CUjBDthWz3zmRl1QjyOKU=;
X-UUID: ffba327e58714f71a6d76e7305d4bd5f-20201012
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1331938782; Mon, 12 Oct 2020 20:02:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 12 Oct 2020 20:02:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 20:01:58 +0800
Message-ID: <1602504119.26323.54.camel@mhfsdcap03>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>
Date: Mon, 12 Oct 2020 20:01:59 +0800
In-Reply-To: <20201012071843.GA1889@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com> <20201002110831.GD6888@pi3>
 <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03> <20201012071843.GA1889@pi3>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FA9AD3A565A7DE7F33FFEDBC7D6A606B4EFC4E07A07FFF66367021A06DDA1692000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-10-12 at 09:18 +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> > On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > > Convert MediaTek SMI to DT schema.
> > > > > >
> > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > ---
> > > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > > ...
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    oneOf:
> > > > > > +      - enum:
> > > > > > +          - mediatek,mt2701-smi-common
> > > > > > +          - mediatek,mt2712-smi-common
> > > > > > +          - mediatek,mt6779-smi-common
> > > > > > +          - mediatek,mt8173-smi-common
> > > > > > +          - mediatek,mt8183-smi-common
> > > > > > +
> > > > > > +      - description: for mt7623
> > > > > > +        items:
> > > > > > +          - const: mediatek,mt7623-smi-common
> > > > > > +          - const: mediatek,mt2701-smi-common
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    description: |
> > > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > > +      require gals: mt6779 and mt8183.
> > > > > > +    minItems: 2
> > > > > > +    maxItems: 4
> > > > > > +    items:
> > > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > > +          setting the register.
> > > > > > +      - description: smi is the clock for transfer data and command.
> > > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > > +          into the emi clock domain.
> > > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    oneOf:
> > > > > > +      - items:
> > > > > > +          - const: apb
> > > > > > +          - const: smi
> > > > > > +      - items:
> > > > > > +          - const: apb
> > > > > > +          - const: smi
> > > > > > +          - const: async
> > > > > > +      - items:
> > > > > > +          - const: apb
> > > > > > +          - const: smi
> > > > > > +          - const: gals0
> > > > > > +          - const: gals1
> > > > >
> > > > > Similarly to my comment to other properties, this requirement per
> > > > > compatible should be part of the schema within 'if-then'.
> > > >
> > > > I'm not so familiar with this format. Do this has "if-then-'else
> > > > if'-then-else"?
> > > 
> > > These are mutually exclusive conditions, so you can skip else:
> > >  - if-then
> > >  - if-then
> > >  - if-then
> > > It will be more readable then stacking 'if' under 'else'
> > 
> > Thanks. I will use something like this:
> > 
> >  anyOf:
> 
> Then it should be oneOf as only one condition can be valid.

I did do this at the beginning. But I get a warning log when
dt_binding_check.


Below is my schema and the detailed warning log:
//=======================================
  clocks:
    description: |
      xxxxx
    minItems: 2
    maxItems: 4
    items:
      - description: apb is the clock for setting the register.
      - description: smi is the clock for transfer data and command.
      - description: async is asynchronous clock.
      - description: gals0 is the path0 clock of gals.
      - description: gals1 is the path1 clock of gals.    

  clock-names:
    minItems: 2
    maxItems: 4 

required:
  - compatible
  - reg
  - power-domains
  - clocks
  - clock-names

oneOf:
  - if: #only for gen1 HW
      properties:
        compatible:
          contains:
            enum:
              - mediatek,mt2701-smi-common
    then:
       properties:
         clock:
           items:
             minItems: 3
             maxItems: 3
         clock-names:
           items:
             - const: apb
             - const: smi
             - const: async

  - if: #for gen2 HW that have gals
      properties:
        compatible:
            enum:
              - mediatek,mt6779-smi-common
              - mediatek,mt8183-smi-common
              - mediatek,mt8192-smi-common

    then:
      properties:
        clock:
          items:
            minItems: 4
            maxItems: 4
        clock-names:
          items:
            - const: apb
            - const: smi
            - const: gals0
            - const: gals1

    else: #for gen2 HW that don't have gals
      properties:
        clock:
          items:
            minItems: 2
            maxItems: 2
        clock-names:
          items:
            - const: apb
            - const: smi

additionalProperties: false 


//===========warning log=====================

Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml
.../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml: smi@14022000: {'compatible': ['mediatek,mt8173-smi-common'], 'reg': [[335683584, 4096]], 'power-domains': [[4294967295, 3]], 'clocks': [[4294967295, 1], [4294967295, 1]], 'clock-names': ['apb', 'smi'], '$nodename': ['smi@14022000']} is valid under each of {'else': {'properties': {'clock': {'items': {'maxItems': 2, 'minItems': 2}, 'type': 'array'}, 'clock-names': {'additionalItems': False, 'items': [{'const': 'apb'}, {'const': 'smi'}], 'maxItems': 2, 'minItems': 2, 'type': 'array'}}}, 'if': {'properties': {'compatible': {'additionalItems': False, 'items': [{'enum': ['mediatek,mt6779-smi-common', 'mediatek,mt8183-smi-common', 'mediatek,mt8192-smi-common']}], 'maxItems': 1, 'minItems': 1, 'type': 'array'}}}, 'then': {'properties': {'clock': {'items': {'maxItems': 4, 'minItems': 4}, 'type': 'array'}, 'clock-names': {'additionalItems': False, 'items': [{'const': 'apb'}, {'const': 'smi'}, {'const'
 : 'gals0'}, {'const': 'gals1'}], 'maxItems': 4, 'minItems': 4, 'type': 'array'}}}}, {'if': {'properties': {'compatible': {'contains': {'enum': ['mediatek,mt2701-smi-common']}}}}, 'then': {'properties': {'clock': {'items': {'maxItems': 3, 'minItems': 3}, 'type': 'array'}, 'clock-names': {'additionalItems': False, 'items': [{'const': 'apb'}, {'const': 'smi'}, {'const': 'async'}], 'maxItems': 3, 'minItems': 3, 'type': 'array'}}}}
{'$filename':
'.../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml',
 '$id':
'http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#',
 '$schema': 'http://devicetree.org/meta-schemas/core.yaml#',
 '$select_validator': <jsonschema.validators.create.<locals>.Validator
object at 0x7fb3df378908>,
 'additionalProperties': False,
 'oneOf': [{'if': {'properties': {'compatible': {'contains': {'enum':
['mediatek,mt2701-smi-common']}}}},
            'then': {'properties': {'clock': {'items': {'maxItems': 3,
                                                        'minItems': 3},
                                              'type': 'array'},
                                    'clock-names': {'additionalItems':
False,
                                                    'items': [{'const':
'apb'},
                                                              {'const':
'smi'},
                                                              {'const':
'async'}],
                                                    'maxItems': 3,
                                                    'minItems': 3,
                                                    'type': 'array'}}}},
           {'else': {'properties': {'clock': {'items': {'maxItems': 2,
                                                        'minItems': 2},
                                              'type': 'array'},
                                    'clock-names': {'additionalItems':
False,
                                                    'items': [{'const':
'apb'},
                                                              {'const':
'smi'}],
                                                    'maxItems': 2,
                                                    'minItems': 2,
                                                    'type': 'array'}}},
            'if': {'properties': {'compatible': {'additionalItems':
False,
                                                 'items': [{'enum':
['mediatek,mt6779-smi-common',

'mediatek,mt8183-smi-common',

'mediatek,mt8192-smi-common']}],
                                                 'maxItems': 1,
                                                 'minItems': 1,
                                                 'type': 'array'}}},
            'then': {'properties': {'clock': {'items': {'maxItems': 4,
                                                        'minItems': 4},
                                              'type': 'array'},
                                    'clock-names': {'additionalItems':
False,
                                                    'items': [{'const':
'apb'},
                                                              {'const':
'smi'},
                                                              {'const':
'gals0'},
                                                              {'const':
'gals1'}],
                                                    'maxItems': 4,
                                                    'minItems': 4,
                                                    'type':
'array'}}}}],
 'patternProperties': {'pinctrl-[0-9]+': True},
 'properties': {'$nodename': True,
                'clock-names': {'maxItems': 4, 'minItems': 2},
                'clocks': {'additionalItems': False,
                           'items': [{}, {}, {}, {}, {}],
                           'maxItems': 4,
                           'minItems': 2,
                           'type': 'array'},
                'compatible': {'oneOf': [{'additionalItems': False,
                                          'items': [{'enum':
['mediatek,mt2701-smi-common',

'mediatek,mt2712-smi-common',

'mediatek,mt6779-smi-common',

'mediatek,mt8173-smi-common',

'mediatek,mt8183-smi-common',

'mediatek,mt8192-smi-common']}],
                                          'maxItems': 1,
                                          'minItems': 1,
                                          'type': 'array'},
                                         {'additionalItems': False,
                                          'items': [{'const':
'mediatek,mt7623-smi-common'},
                                                    {'const':
'mediatek,mt2701-smi-common'}],
                                          'maxItems': 2,
                                          'minItems': 2,
                                          'type': 'array'}]},
                'phandle': True,
                'pinctrl-names': True,
                'power-domains': {'maxItems': 1, 'minItems': 1},
                'reg': {'maxItems': 1, 'minItems': 1},
                'status': True},
 'required': ['compatible',
              'reg',
              'power-domains',
              'clocks',
              'clock-names'],
 'select': {'properties': {'compatible': {'contains': {'enum':
['mediatek,mt2701-smi-common',

'mediatek,mt2712-smi-common',

'mediatek,mt6779-smi-common',

'mediatek,mt7623-smi-common',

'mediatek,mt8173-smi-common',

'mediatek,mt8183-smi-common',

'mediatek,mt8192-smi-common']}}},
            'required': ['compatible']},
 'title': 'SMI (Smart Multimedia Interface) Common'}
	From
schema: .../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml

=================================

Sorry, I didn't find a example of multi "if-then" in oneOf and don't
know how to fix this.

From [1], "allOf" looks also is allowed... In this case, both allOf and
anyOf have no warning when dt_binding_check. only oneOf has the warning
log above.

Any suggestion is appreciated.

[1]
https://elixir.bootlin.com/linux/v5.9-rc1/source/Documentation/devicetree/bindings/example-schema.yaml#L195

> 
> Best regards,
> Krzysztof
> 
> >    - if: #gen1 hw
> >      then:
> >        use apb/smi/async clocks
> > 
> >    - if: #gen2 hw that has gals.
> >      then:
> >        use apb/smi/gals0/gals1 clocks
> >      else: # gen2 hw that doesn't have gals.
> >        use apb/smi clocks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
