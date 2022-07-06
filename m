Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B275C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 06:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3A6260F84;
	Wed,  6 Jul 2022 06:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3A6260F84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3-Ah2E8OySQ; Wed,  6 Jul 2022 06:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA17C60F74;
	Wed,  6 Jul 2022 06:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA17C60F74
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8016CC0077;
	Wed,  6 Jul 2022 06:19:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75E27C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 06:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49188833C6
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 06:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49188833C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVH5Ga01eqra for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 06:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F17E483372
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F17E483372
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 06:19:15 +0000 (UTC)
X-UUID: 428c1ce0bf624f339c07c6100c280249-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8, REQID:8cd32d2b-4b91-407e-a898-52462391aa23, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:50
X-CID-INFO: VERSION:1.1.8, REQID:8cd32d2b-4b91-407e-a898-52462391aa23, OB:0,
 LOB:
 0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:50
X-CID-META: VersionHash:0f94e32, CLOUDID:7b7abcd6-5d6d-4eaf-a635-828a3ee48b7c,
 C
 OID:15dc4aa8751e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 428c1ce0bf624f339c07c6100c280249-20220706
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1551361263; Wed, 06 Jul 2022 14:19:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 6 Jul 2022 14:19:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 14:19:08 +0800
Message-ID: <b5667c052447d1b3c3498131af98d80a07ed4767.camel@mediatek.com>
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
To: Rob Herring <robh@kernel.org>
Date: Wed, 6 Jul 2022 14:19:08 +0800
In-Reply-To: <20220705205739.GA2599256-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-4-tinghan.shen@mediatek.com>
 <20220705205739.GA2599256-robh@kernel.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, Enric
 Balletbo i Serra <enric.balletbo@collabora.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will
 Deacon <will@kernel.org>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Tinghan Shen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 2022-07-05 at 14:57 -0600, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 06:00:15PM +0800, Tinghan Shen wrote:
> > Extract duplicated properties and support more levels of power
> > domain nodes.
> > 
> > This change fix following error when do dtbs_check,
> >     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:
> > power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not
> > match any of the regexes: 'pinctrl-[0-9]+'
> > 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../power/mediatek,power-controller.yaml      | 132 ++----------------
> >  1 file changed, 12 insertions(+), 120 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 135c6f722091..09a537a802b8 100644
> > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -39,8 +39,17 @@ properties:
> >    '#size-cells':
> >      const: 0
> >  
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> >  patternProperties:
> >    "^power-domain@[0-9a-f]+$":
> > +    $ref: "#/$defs/power-domain-node"
> > +
> > +$defs:
> > +  power-domain-node:
> >      type: object
> >      description: |
> >        Represents the power domains within the power controller node as documented
> > @@ -98,127 +107,10 @@ patternProperties:
> >          $ref: /schemas/types.yaml#/definitions/phandle
> >          description: phandle to the device containing the SMI register range.
> >  
> > -    patternProperties:
> > -      "^power-domain@[0-9a-f]+$":
> > -        type: object
> > -        description: |
> > -          Represents a power domain child within a power domain parent node.
> > -
> > -        properties:
> > -
> > -          '#power-domain-cells':
> > -            description:
> > -              Must be 0 for nodes representing a single PM domain and 1 for nodes
> > -              providing multiple PM domains.
> > -
> > -          '#address-cells':
> > -            const: 1
> > -
> > -          '#size-cells':
> > -            const: 0
> > -
> > -          reg:
> > -            maxItems: 1
> > -
> > -          clocks:
> > -            description: |
> > -              A number of phandles to clocks that need to be enabled during domain
> > -              power-up sequencing.
> > -
> > -          clock-names:
> > -            description: |
> > -              List of names of clocks, in order to match the power-up sequencing
> > -              for each power domain we need to group the clocks by name. BASIC
> > -              clocks need to be enabled before enabling the corresponding power
> > -              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > -              SUSBYS clocks need to be enabled before releasing the bus protection,
> > -              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > -
> > -              In order to follow properly the power-up sequencing, the clocks must
> > -              be specified by order, adding first the BASIC clocks followed by the
> > -              SUSBSYS clocks.
> > -
> > -          domain-supply:
> > -            description: domain regulator supply.
> > -
> > -          mediatek,infracfg:
> > -            $ref: /schemas/types.yaml#/definitions/phandle
> > -            description: phandle to the device containing the INFRACFG register range.
> > -
> > -          mediatek,smi:
> > -            $ref: /schemas/types.yaml#/definitions/phandle
> > -            description: phandle to the device containing the SMI register range.
> > -
> > -        patternProperties:
> > -          "^power-domain@[0-9a-f]+$":
> > -            type: object
> > -            description: |
> > -              Represents a power domain child within a power domain parent node.
> > -
> > -            properties:
> > +      required:
> > +        - reg
> >  
> > -              '#power-domain-cells':
> > -                description:
> > -                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> > -                  providing multiple PM domains.
> > -
> > -              '#address-cells':
> > -                const: 1
> > -
> > -              '#size-cells':
> > -                const: 0
> > -
> > -              reg:
> > -                maxItems: 1
> > -
> > -              clocks:
> > -                description: |
> > -                  A number of phandles to clocks that need to be enabled during domain
> > -                  power-up sequencing.
> > -
> > -              clock-names:
> > -                description: |
> > -                  List of names of clocks, in order to match the power-up sequencing
> > -                  for each power domain we need to group the clocks by name. BASIC
> > -                  clocks need to be enabled before enabling the corresponding power
> > -                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > -                  SUSBYS clocks need to be enabled before releasing the bus protection,
> > -                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > -
> > -                  In order to follow properly the power-up sequencing, the clocks must
> > -                  be specified by order, adding first the BASIC clocks followed by the
> > -                  SUSBSYS clocks.
> > -
> > -              domain-supply:
> > -                description: domain regulator supply.
> > -
> > -              mediatek,infracfg:
> > -                $ref: /schemas/types.yaml#/definitions/phandle
> > -                description: phandle to the device containing the INFRACFG register range.
> > -
> > -              mediatek,smi:
> > -                $ref: /schemas/types.yaml#/definitions/phandle
> > -                description: phandle to the device containing the SMI register range.
> > -
> > -            required:
> > -              - reg
> > -
> > -            additionalProperties: false
> > -
> > -        required:
> > -          - reg
> > -
> > -        additionalProperties: false
> > -
> > -    required:
> > -      - reg
> > -
> > -    additionalProperties: false
> > -
> > -required:
> > -  - compatible
> > -
> > -additionalProperties: false
> > +      additionalProperties: false
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/mediatek,power-
> controller.yaml O=out
> make[1]: Entering directory '/proj/mtk15399/upstream-cros/src/third_party/kernel/v5.10/out'
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.ya
> ml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-
> current-nanoamp
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-
> sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring,
> error parsing file
>   DTEX    Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts
>   DTC     Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
>   CHECK   Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
> Traceback (most recent call last):
>   File "/proj/mtk15399/.venv/py3.9/bin/dt-validate", line 173, in <module>
>     testtree = dtschema.load(filename, line_number=args.line_number)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 913, in load
>     return [ dtschema.dtb.fdt_unflatten(f.read()) ]
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/dtb.py", line 463, in
> fdt_unflatten
>     p = dtschema.get_prop_types()
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 892, in
> get_prop_types
>     props = dtschema.extract_types(schema_cache)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 883, in
> extract_types
>     _extract_subschema_types(props, sch, sch)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
> 
> [...snip...]
> 
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 803, in
> _extract_prop_type
>     _extract_prop_type(props, schema, propname, subschema)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 794, in
> _extract_prop_type
>     _extract_subschema_types(props, schema, subschema)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
>     _extract_prop_type(props, schema, p, v)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 790, in
> _extract_prop_type
>     if not isinstance(subschema, dict):
> RecursionError: maximum recursion depth exceeded while calling a Python object
> make[1]: Leaving directory '/proj/mtk15399/upstream-cros/src/third_party/kernel/v5.10/out'
> You now aren't checking more than 1 level because you have defined 
> 'additionalProperties' to be a DT property. Check the indentation.
> 
> You need this in $defs/power-domain-node to recurse:
> 
>     additionalProperties:
>       $ref: #/$defs/power-domain-node
Hi Rob,

I get the following error after adding the 'additionalProperties' to $defs/power-domain-node.
The same error occurs when I run dt_binding_check on power/renesas,sysc-rmobile.yaml, which has the
similar property.

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/mediatek,power-
controller.yaml O=out
make[1]: Entering directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-
nanoamp
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-
sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring,
error parsing file
  DTEX    Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts
  DTC     Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
  CHECK   Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
Traceback (most recent call last):
  File "/test/.venv/py3.9/bin/dt-validate", line 173, in <module>
    testtree = dtschema.load(filename, line_number=args.line_number)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 913, in load
    return [ dtschema.dtb.fdt_unflatten(f.read()) ]
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/dtb.py", line 463, in fdt_unflatten
    p = dtschema.get_prop_types()
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 892, in get_prop_types
    props = dtschema.extract_types(schema_cache)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 883, in extract_types
    _extract_subschema_types(props, sch, sch)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
_extract_subschema_types

[...snip...]

  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 803, in
_extract_prop_type
    _extract_prop_type(props, schema, propname, subschema)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 794, in
_extract_prop_type
    _extract_subschema_types(props, schema, subschema)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
_extract_subschema_types
    _extract_prop_type(props, schema, p, v)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 790, in
_extract_prop_type
    if not isinstance(subschema, dict):
RecursionError: maximum recursion depth exceeded while calling a Python object
make[1]: Leaving directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'


Best Regards,
TingHan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
