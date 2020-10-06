Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C68C41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 04:27:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A565720757
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 04:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QJQJa2D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A565720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 668F0865AB;
	Tue,  6 Oct 2020 04:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUA6AA6OgzEm; Tue,  6 Oct 2020 04:27:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7772864FB;
	Tue,  6 Oct 2020 04:27:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEC37C016F;
	Tue,  6 Oct 2020 04:27:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9578BC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7F6FC86FAC
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XtDD0fugQ9g1 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 04:27:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 709BB86F9A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 04:27:14 +0000 (UTC)
X-UUID: 657d3555277e4a10a234b2323b8e721e-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=WnWWZYGTcT78KXIBsHhsNiz4yOOrVWJfS9BpjfICDfU=; 
 b=QJQJa2D0jmGMReLrgvHiPoPkdBPEcEBEATpZ0iMhRqKBCeVTvX6IyfXv8wIuzCvC4LoGZyGctB8pPsCa+F/t5a3qgNz77wRWkKMHi8rlk9PeDetPwwgQ9lMda8beYsK7snSqhGy1LzwqoNn9UDcfJtMBJE8G867AdoAkVtL/HZY=;
X-UUID: 657d3555277e4a10a234b2323b8e721e-20201006
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1586165562; Tue, 06 Oct 2020 12:27:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Oct 2020 12:27:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 12:27:07 +0800
Message-ID: <1601958428.26323.26.camel@mhfsdcap03>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Oct 2020 12:27:08 +0800
In-Reply-To: <20201002110831.GD6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com> <20201002110831.GD6888@pi3>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 07CA81F1F3F14B41F4FC092F2B44C4679867F49762ADB54295A5B01FD53386612000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > Convert MediaTek SMI to DT schema.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../mediatek,smi-common.txt                   |  49 ---------
> >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> >  4 files changed, 191 insertions(+), 98 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
...
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - mediatek,mt2701-smi-common
> > +          - mediatek,mt2712-smi-common
> > +          - mediatek,mt6779-smi-common
> > +          - mediatek,mt8173-smi-common
> > +          - mediatek,mt8183-smi-common
> > +
> > +      - description: for mt7623
> > +        items:
> > +          - const: mediatek,mt7623-smi-common
> > +          - const: mediatek,mt2701-smi-common
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > +      gals(global async local sync) also is optional, here is the list which
> > +      require gals: mt6779 and mt8183.
> > +    minItems: 2
> > +    maxItems: 4
> > +    items:
> > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > +          setting the register.
> > +      - description: smi is the clock for transfer data and command.
> > +      - description: async is asynchronous clock, it help transform the smi clock
> > +          into the emi clock domain.
> > +      - description: gals0 is the path0 clock of gals.
> > +      - description: gals1 is the path1 clock of gals.
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - items:
> > +          - const: apb
> > +          - const: smi
> > +      - items:
> > +          - const: apb
> > +          - const: smi
> > +          - const: async
> > +      - items:
> > +          - const: apb
> > +          - const: smi
> > +          - const: gals0
> > +          - const: gals1
> 
> Similarly to my comment to other properties, this requirement per
> compatible should be part of the schema within 'if-then'.

I'm not so familiar with this format. Do this has "if-then-'else
if'-then-else"?

I tried below instead of the clocks segment above:

===================================
if:
  properties:
    compatible:
      enum:
        - mediatek,mt6779-smi-common
        - mediatek,mt8183-smi-common

then:
  properties:
    clock:
      items:
        - description: apb is the clock for setting the register..
        - description: smi is the clock for transfer data and command.
        - description: gals0 is the path0 clock of gals(global async
local sync).
        - description: gals1 is the path1 clock of gals.
    clock-names:
      items:
        - const: apb
        - const: smi
        - const: gals0
        - const: gals1
else:
  if:
    properties:
      compatible:
        contains:
          enum:
            - mediatek,mt2701-smi-common

  then:
    properties:
      clocks:
        items:
          - description: apb is the clock for setting the register.
          - description: smi is the clock for transfer data and command.
          - description: async is asynchronous clock, it help transform
the smi clock
              into the emi clock domain.
      clock-names:
        items:
          - const: apb
          - const: smi
          - const: async
  else:
    properties:
      clocks:
        items:
          - description: apb is the clock for setting the register.
          - description: smi is the clock for transfer data and
command.    
      clock-names:
        items:
          - const: apb
          - const: smi
================================

But I got a warning when dt_binding_check:

CHKDT
Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
  SCHEMA
Documentation/devicetree/bindings/processed-schema-examples.yaml
  DTC
Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml
  CHECK
Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml
.../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml: smi@14022000: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
    From
schema: .../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml

Any suggestion about this?
Thanks.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
