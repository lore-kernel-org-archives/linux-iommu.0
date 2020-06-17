Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24985C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 05:53:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE45B2073E
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 05:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sFW5yvIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE45B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D310879E9;
	Wed, 17 Jun 2020 05:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tIHosGv0PEXU; Wed, 17 Jun 2020 05:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1F7687776;
	Wed, 17 Jun 2020 05:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 944D9C07FF;
	Wed, 17 Jun 2020 05:53:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7617C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 05:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D29A788798
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 05:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6P+PRfq86E4 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 05:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id CCCF488704
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 05:53:22 +0000 (UTC)
X-UUID: b2146c6af2314d6dacbebe5b0acc7bc5-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=oVpXGg2U7AQKunA+hsmMzQqdqyO7uOh2s2YhRzJO1cY=; 
 b=sFW5yvIkSXSY97G+GJw+Eb8VYAGekJI2KHKMX9mzrNuMzBUiAMAD7VIt+lIF2Bd7ihAx4WTeL9rdR6ZSmy96p6RFZw0GBbkJ5iHR1+ajhYpVT5jxOlSGBfSGLKmUfV6zQIHTqRVCY0TXcyM2z9FlktiJB/3PZTViso72zcgrGuQ=;
X-UUID: b2146c6af2314d6dacbebe5b0acc7bc5-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <tiffany.lin@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 2120803201; Wed, 17 Jun 2020 13:53:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 13:53:17 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 13:53:16 +0800
Message-ID: <1592373196.24313.1.camel@mtksdaap41>
Subject: Re: [PATCH v4 01/17] media: dt-binding: mtk-vcodec: Separating
 mtk-vcodec encode node.
From: Tiffany Lin <tiffany.lin@mediatek.com>
To: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 17 Jun 2020 13:53:16 +0800
In-Reply-To: <1591774707.21260.14.camel@mtksdaap41>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-2-git-send-email-yong.wu@mediatek.com>
 <20200609212102.GA1416099@bogus>
 <CAPBb6MXdbEgWtOx_b5ab3hOTdyPPaGDQ2kA21pLjoLE-2sjuTg@mail.gmail.com>
 <1591774707.21260.14.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: Maoguang Meng <maoguang.meng@mediatek.com>,
 Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Rob Herring <robh@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Evan
 Green <evgreen@chromium.org>, eizan@chromium.org, Matthias
 Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Tomasz
 Figa <tfiga@google.com>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, 2020-06-10 at 15:38 +0800, Tiffany Lin wrote:
> On Wed, 2020-06-10 at 15:46 +0900, Alexandre Courbot wrote:
> > On Wed, Jun 10, 2020 at 6:21 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sat, May 30, 2020 at 04:10:02PM +0800, Yong Wu wrote:
> > > > From: Maoguang Meng <maoguang.meng@mediatek.com>
> > > >
> > > > Update binding document since the avc and vp8 hardware encoder in
> > > > mt8173 are now separated. Separate "mediatek,mt8173-vcodec-enc" to
> > > > "mediatek,mt8173-vcodec-vp8-enc" and "mediatek,mt8173-vcodec-avc-enc".
> > >
> > > The h/w suddenly split in 2? You are breaking compatibility. Up to the
> > > Mediatek maintainers to decide if that's okay, but you need to state you
> > > are breaking compatibility (here and in the driver) and why that is
> > > okay.
> > 
> > In my understanding there is no real hardware using the old bindings
> > at the moment, and the split is indeed a reflection of the actual
> > hardware layout. Tiffany, can you give your acked-by if this change is
> > ok with you?
> > 
> 
> In my opinion, there is no need to change mt8173 dts for driver to
> support mt8183.
> I saw another patch that already make change to have encoder driver
> support both mt8173 and mt8183.
> But they done a lot to prove h264 and vp8 encoder could work
> independently and parallel.
> In this case, I am ok with it because dts should be a reflection of the
> actual hardware.
> 
> 
> 
> > >
> > > >
> > > > This is a preparing patch for smi cleaning up "mediatek,larb".
> > > >
Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>


> > > > Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/media/mediatek-vcodec.txt  | 58 ++++++++++++----------
> > > >  1 file changed, 31 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > > > index 8093335..1023740 100644
> > > > --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > > > +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > > > @@ -4,7 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
> > > >  supports high resolution encoding and decoding functionalities.
> > > >
> > > >  Required properties:
> > > > -- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
> > > > +- compatible : must be one of the following string:
> > > > +  "mediatek,mt8173-vcodec-vp8-enc" for mt8173 vp8 encoder.
> > > > +  "mediatek,mt8173-vcodec-avc-enc" for mt8173 avc encoder.
> > > >    "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
> > > >    "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
> > > >  - reg : Physical base address of the video codec registers and length of
> > > > @@ -13,10 +15,11 @@ Required properties:
> > > >  - mediatek,larb : must contain the local arbiters in the current Socs.
> > > >  - clocks : list of clock specifiers, corresponding to entries in
> > > >    the clock-names property.
> > > > -- clock-names: encoder must contain "venc_sel_src", "venc_sel",,
> > > > -  "venc_lt_sel_src", "venc_lt_sel", decoder must contain "vcodecpll",
> > > > -  "univpll_d2", "clk_cci400_sel", "vdec_sel", "vdecpll", "vencpll",
> > > > -  "venc_lt_sel", "vdec_bus_clk_src".
> > > > +- clock-names:
> > > > +   avc venc must contain "venc_sel";
> > > > +   vp8 venc must contain "venc_lt_sel";
> > > > +   decoder  must contain "vcodecpll", "univpll_d2", "clk_cci400_sel",
> > > > +   "vdec_sel", "vdecpll", "vencpll", "venc_lt_sel", "vdec_bus_clk_src".
> > > >  - iommus : should point to the respective IOMMU block with master port as
> > > >    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > > >    for details.
> > > > @@ -80,14 +83,10 @@ vcodec_dec: vcodec@16000000 {
> > > >      assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
> > > >    };
> > > >
> > > > -  vcodec_enc: vcodec@18002000 {
> > > > -    compatible = "mediatek,mt8173-vcodec-enc";
> > > > -    reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
> > > > -          <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
> > > > -    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
> > > > -              <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> > > > -    mediatek,larb = <&larb3>,
> > > > -                 <&larb5>;
> > > > +vcodec_enc: vcodec@18002000 {
> > > > +    compatible = "mediatek,mt8173-vcodec-avc-enc";
> > > > +    reg = <0 0x18002000 0 0x1000>;
> > > > +    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
> > > >      iommus = <&iommu M4U_PORT_VENC_RCPU>,
> > > >               <&iommu M4U_PORT_VENC_REC>,
> > > >               <&iommu M4U_PORT_VENC_BSDMA>,
> > > > @@ -98,8 +97,20 @@ vcodec_dec: vcodec@16000000 {
> > > >               <&iommu M4U_PORT_VENC_REF_LUMA>,
> > > >               <&iommu M4U_PORT_VENC_REF_CHROMA>,
> > > >               <&iommu M4U_PORT_VENC_NBM_RDMA>,
> > > > -             <&iommu M4U_PORT_VENC_NBM_WDMA>,
> > > > -             <&iommu M4U_PORT_VENC_RCPU_SET2>,
> > > > +             <&iommu M4U_PORT_VENC_NBM_WDMA>;
> > > > +    mediatek,larb = <&larb3>;
> > > > +    mediatek,vpu = <&vpu>;
> > > > +    clocks = <&topckgen CLK_TOP_VENC_SEL>;
> > > > +    clock-names = "venc_sel";
> > > > +    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> > > > +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> > > > +  };
> > > > +
> > > > +vcodec_enc_lt: vcodec@19002000 {
> > > > +    compatible = "mediatek,mt8173-vcodec-vp8-enc";
> > > > +    reg =  <0 0x19002000 0 0x1000>;  /* VENC_LT_SYS */
> > > > +    interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> > > > +    iommus = <&iommu M4U_PORT_VENC_RCPU_SET2>,
> > > >               <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
> > > >               <&iommu M4U_PORT_VENC_BSDMA_SET2>,
> > > >               <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
> > > > @@ -108,17 +119,10 @@ vcodec_dec: vcodec@16000000 {
> > > >               <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
> > > >               <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
> > > >               <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
> > > > +    mediatek,larb = <&larb5>;
> > > >      mediatek,vpu = <&vpu>;
> > > > -    clocks = <&topckgen CLK_TOP_VENCPLL_D2>,
> > > > -             <&topckgen CLK_TOP_VENC_SEL>,
> > > > -             <&topckgen CLK_TOP_UNIVPLL1_D2>,
> > > > -             <&topckgen CLK_TOP_VENC_LT_SEL>;
> > > > -    clock-names = "venc_sel_src",
> > > > -                  "venc_sel",
> > > > -                  "venc_lt_sel_src",
> > > > -                  "venc_lt_sel";
> > > > -    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
> > > > -                      <&topckgen CLK_TOP_VENC_LT_SEL>;
> > > > -    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
> > > > -                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
> > > > +    clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> > > > +    clock-names = "venc_lt_sel";
> > > > +    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> > > > +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
> > > >    };
> > > > --
> > > > 1.9.1
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
