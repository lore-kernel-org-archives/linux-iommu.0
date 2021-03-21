Return-Path: <SRS0=mXGD=IT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88B2C433DB
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 17:31:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5913561946
	for <iommu@archiver.kernel.org>; Sun, 21 Mar 2021 17:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5913561946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 155B2605F0;
	Sun, 21 Mar 2021 17:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hk7hbXdzwNus; Sun, 21 Mar 2021 17:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CFEA605D1;
	Sun, 21 Mar 2021 17:31:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D049C000A;
	Sun, 21 Mar 2021 17:31:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97C3FC0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 17:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86F2183560
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 17:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="VokPC+Ab";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="QlE9cJva"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jg3gg2OWHTvY for <iommu@lists.linux-foundation.org>;
 Sun, 21 Mar 2021 17:31:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC8278354D
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 17:31:02 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 62B8058034F;
 Sun, 21 Mar 2021 13:22:37 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sun, 21 Mar 2021 13:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=Sh7yO4YyIwW3dq3G9kmAp+S/GX5l
 VHJLYLmDSBaxRpA=; b=VokPC+AbTb3wsAJKrhvDy0/kYnLFuusAVxfwIEuQytXc
 zjOAY49NZ2ayj+lW6Tth8P8JcA7a3mgdFxNel1e9dZI9Hr/VLFLfymtHKiKcgwK/
 aQIaN+S002w5ZAWEmU8YJ22NxM6ZleyzYouQtXlWdOxQcKgInQXWkB2xLYxxP6PG
 yeNlDf6UnJSOBlhU5WTf1SOLQG/rVYBK5DXCygun9+YcefnWtzmI3v5uUSNEthdF
 o4Aig3sgO2pLVHQukNiGA45VklyUWfxgMR8XQlwkHvOAACK4eM0e/PrctukQfw1f
 FW92R4GVlPWVzcGr749T9MYygKxZN92l88ebKSU+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Sh7yO4
 YyIwW3dq3G9kmAp+S/GX5lVHJLYLmDSBaxRpA=; b=QlE9cJvaenJVfCfiXVElRO
 vNcEORF42pyNZaQS9CTSc2KyDNZMaTR76/T5hSjn08G5nlNOKaUbBtA0HMJs3+Qo
 /NqVS6XPnyPPa8/IlrR/CZglPNCWMUIa7r/qaAPEgeVtoCXt90czNVFC9NBQkqjs
 D34/dnsMwMefgD52Vcx5hJI00/eWPrmKCl1MF2N9QRjmd2YRlyTWahsw8PbsxQTI
 ko+za7i8jbPUgF99qIqm9n/4VpdwQALmui5uBypAeIHGISAQ1Rbg2xegZaY41NHX
 Wpi08poMCZVgqOHFG4G+NZ9EG6EqO+oXydCNtmM05euALTd7tqo8wmddXrX4X8aw
 ==
X-ME-Sender: <xms:24BXYKaBXHCtMHHHNo-t3EbObLMETdmM0FCcLKe7TyitAxQt2vGilA>
 <xme:24BXYNZz3LRPSijoc0pE15CZ3YeWmbRUIJK3V_zz7C3FMwiRDC99fDRbvysvyF1QM
 xKvCv04yapoQEKCI0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegvddguddttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsegrtderreerredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepvdetgfejuddvheeigedtfefhvdffiefhiedvgedtudeijedvgffftedv
 lefgueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:24BXYE_ul2YR5X_H2YTirykdMLxZP5yDU1v0XVizwhxOFZ0cYJgIkg>
 <xmx:24BXYMrdgqYR5BoCg41iw8e0uZJ-9MT5Uilt639M0d1G_xQwEwOlKw>
 <xmx:24BXYFqvd1e6x0VxYBoNpq6QkKx4cMbC8OnkJ5xSLH16Y8Ea-TGCgA>
 <xmx:3YBXYGTlUAxOx25Unu-FiCOQ18koUiPQfSwBd8-8L6KH_ejkKKzV7KNAdnk>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DE3F451C005E; Sun, 21 Mar 2021 13:22:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
In-Reply-To: <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
Date: Sun, 21 Mar 2021 18:22:15 +0100
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: arnd@kernel.org, devicetree@vger.kernel.org, will@kernel.org,
 marcan@marcan.st, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, maz@kernel.org,
 mohamed.mediouni@caramail.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, stan@corellium.com
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: multipart/mixed; boundary="===============5813216942538423323=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============5813216942538423323==
Content-Type: multipart/alternative;
 boundary=a51a6ec388fd4cb2ab5292471f389a96

--a51a6ec388fd4cb2ab5292471f389a96
Content-Type: text/plain


Hi Mark,

> On 21. Mar 2021, at 17:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> I don't think the first option is going to work for PCIe.  PCIe
> devices will have to use "iommu-map" properties to map PCI devices to
> the right iommu, and the currently implementation seems to assume that
> #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
> that it relies on #iommu-cells = <1>, but it isn't clear how the
> rid-base to iommu-base mapping mechanism would work when that isn't
> the case.
> 
> Now the PCIe DARTs are simpler and seem to have only one "instance"
> per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
> fine using the first approach.

Good point, I guess that only leaves option two for now then.
Having some DARTs use cells = <1> and others <2> sounds confusing to me.


> 
> As I mentioned before, not all DARTs support the full 32-bit aperture.
> In particular the PCIe DARTs support a smaller address-space.  It is
> not clear whether this is a restriction of the PCIe host controller or
> the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> properties that encode the base address and size of the aperture.
> These single-cell properties which is probably why for the USB DARTs
> only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> wouldn't be able to encode the full aperture size.  We could make them
> 64-bit numbers in the Linux device tree though and always be explicit
> about the size.  Older Sun SPARC machines used a single "virtual-dma"
> property to encode the aperture.  We could do someting similar.  You
> would use this property to initialize domain->geometry.aperture_start
> and domain->geometry.aperture_end in diff 3/3 of this series.
> 
> I think it would make sense to include this in this series, as this
> would make adding support for PCIe very easy, and PCIe gives you
> aupport for network (both wired and wireless) and the type-A USB ports
> on the mini.



Agreed, I'd ideally like to converge on a device tree binding
that won't have to change in the near future.

I've tried to use an address space larger than 32bit and that seems to
work for parts of the dwc3 controller but breaks for the xhci parts because
the upper lines don't seem to be connected there (e.g. if xhci tries to
use <0x1 0xffff0000> I get a fault for <0 0xffff0000>).

Looking at other iommu drivers I have found the following two similar
bindings:

qcom uses a ranges property with a 64bit address and 32 bit size [1]

  apps_iommu: iommu@1e20000 {
      ...
      ranges = <0 0x1e20000 0x40000>;
      ...
  };

and tegra seems to support a dma-window property with 32bit address
and size [2]

  smmu {
          [...]
          dma-window = <0 0x40000000>;    /* IOVA start & length */
          [...]
  };

I believe there already is of_get_dma_window to handle parsing this
in the common iommu code [3] but I can't find any place using it.
It's a little bit more complex that we need since it allows to specify the
number of cells for both the address and the size but it should allow us to
express all possible configurations:

  usb_dart {
      [ ... ]
      #dma-address-cells = <1>;
      #dma-size-cells = <2>;
      dma-window = <0 0x1 0x0>;
      [ ... ]
  };
  pcie_dart {
      [ ... ]
      #dma-address-cells = <1>;
      #dma-size-cells = <1>;
      dma-window = <0x100000 0x3fe00000>;
      [ ... ]
  };

where #dma-address-cells and #dma-size-cells default to
#address-cells and #size-cells respectively if I understand
the code correctly. That way we could also just always use
a 64bit address and size in the DT, e.g.

  pcie_dart {
      [ ... ]
      dma-window = <0 0x100000 0 0x3fe00000>;
      [ ... ]
  };


Best,

Sven


[1] Documentation/devicetree/bindings/iommu/qcom,iommu.txt
[2] Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
[3] drivers/iommu/of_iommu.c

--a51a6ec388fd4cb2ab5292471f389a96
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title><style type=3D"text/css">p.Mso=
Normal,p.MsoNoSpacing{margin:0}</style></head><body><div><br></div><div>=
<span style=3D"font-style:normal;font-variant-caps:normal;font-weight:no=
rmal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;-webkit-text-stroke-width:0p=
x;text-decoration:none;color:rgb(0, 0, 0);float:none;display:inline !imp=
ortant;"><span class=3D"font" style=3D"font-family:Helvetica;"><span cla=
ss=3D"size" style=3D"font-size:12px;">Hi Mark,</span></span></span><br><=
/div><div style=3D"font-style:normal;font-variant-caps:normal;font-weigh=
t:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;-webkit-text-stroke-widt=
h:0px;text-decoration:none;color:rgb(0, 0, 0);font-family:Helvetica;font=
-size:12px;"><div><br></div><blockquote type=3D"cite"><div>On 21. Mar 20=
21, at 17:00, Mark Kettenis &lt;<a href=3D"mailto:mark.kettenis@xs4all.n=
l">mark.kettenis@xs4all.nl</a>&gt; wrote:<br></div><div><br></div><div>I=
 don't think the first option is going to work for PCIe. &nbsp;PCIe<br><=
/div><div>devices will have to use "iommu-map" properties to map PCI dev=
ices to<br></div><div>the right iommu, and the currently implementation =
seems to assume that<br></div><div>#iommu-cells =3D &lt;1&gt;. &nbsp;The=
 devictree binding[1] doesn't explicitly state<br></div><div>that it rel=
ies on #iommu-cells =3D &lt;1&gt;, but it isn't clear how the<br></div><=
div>rid-base to iommu-base mapping mechanism would work when that isn't<=
br></div><div>the case.<br></div><div><br></div><div>Now the PCIe DARTs =
are simpler and seem to have only one "instance"<br></div><div>per DART.=
 &nbsp;So if we keep #iommu-cells =3D &lt;1&gt; for those, you'd still b=
e<br></div><div>fine using the first approach.<br></div></blockquote><di=
v><br></div><div>Good point, I guess that only leaves option two for now=
 then.<br></div><div>Having some DARTs use cells =3D &lt;1&gt; and other=
s &lt;2&gt; sounds confusing to me.<br></div><div><br></div><div><br></d=
iv><blockquote type=3D"cite"><div><br></div><div>As I mentioned before, =
not all DARTs support the full 32-bit aperture.<br></div><div>In particu=
lar the PCIe DARTs support a smaller address-space. &nbsp;It is<br></div=
><div>not clear whether this is a restriction of the PCIe host controlle=
r or<br></div><div>the DART, but the Apple Device Tree has "vm-base" and=
 "vm-size"<br></div><div>properties that encode the base address and siz=
e of the aperture.<br></div><div>These single-cell properties which is p=
robably why for the USB DARTs<br></div><div>only "vm-base" is given; sin=
ce "vm-base" is 0, a 32-bit number<br></div><div>wouldn't be able to enc=
ode the full aperture size. &nbsp;We could make them<br></div><div>64-bi=
t numbers in the Linux device tree though and always be explicit<br></di=
v><div>about the size. &nbsp;Older Sun SPARC machines used a single "vir=
tual-dma"<br></div><div>property to encode the aperture. &nbsp;We could =
do someting similar. &nbsp;You<br></div><div>would use this property to =
initialize domain-&gt;geometry.aperture_start<br></div><div>and domain-&=
gt;geometry.aperture_end in diff 3/3 of this series.<br></div><div><br><=
/div><div>I think it would make sense to include this in this series, as=
 this<br></div><div>would make adding support for PCIe very easy, and PC=
Ie gives you<br></div><div>aupport for network (both wired and wireless)=
 and the type-A USB ports<br></div><div>on the mini.<br></div></blockquo=
te><div><br></div><div><br></div><div><div><br></div><div>Agreed, I'd id=
eally like to converge on a device tree binding<br></div><div>that won't=
 have to change in the near future.<br></div><div><br></div><div>I've tr=
ied to use an address space larger than 32bit and that seems to<br></div=
><div>work for parts of the dwc3 controller but breaks for the xhci part=
s because<br></div><div>the upper lines don't seem to be connected there=
 (e.g. if xhci tries to<br></div><div>use &lt;0x1 0xffff0000&gt; I get a=
 fault for &lt;0 0xffff0000&gt;).<br></div><div><br></div><div>Looking a=
t other iommu drivers I have found the following two similar<br></div><d=
iv>bindings:<br></div><div><br></div><div>qcom uses a ranges property wi=
th a 64bit address and 32 bit size [1]<br></div><div><br></div><div>&nbs=
p; apps_iommu: iommu@1e20000 {<br></div><div>&nbsp; &nbsp; &nbsp; ...<br=
></div><div>&nbsp; &nbsp; &nbsp; ranges =3D &lt;0 0x1e20000 0x40000&gt;;=
<br></div><div>&nbsp; &nbsp; &nbsp; ...<br></div><div>&nbsp; };<br></div=
><div><br></div><div>and tegra seems to support a dma-window property wi=
th 32bit address<br></div><div>and size [2]<br></div><div><br></div><div=
>&nbsp; smmu {<br></div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [...]<br=
></div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dma-window =3D &lt;0 0x40=
000000&gt;; &nbsp; &nbsp;/* IOVA start &amp; length */<br></div><div>&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; [...]<br></div><div>&nbsp; };<br></div><=
div><br></div><div>I believe there already is of_get_dma_window to handl=
e parsing this<br></div><div>in the common iommu code [3] but I can't fi=
nd any place using it.<br></div><div>It's a little bit more complex that=
 we need since it allows to specify the<br></div><div>number of cells fo=
r both the address and the size but it should allow us to<br></div><div>=
express all possible configurations:<br></div><div><br></div><div>&nbsp;=
 usb_dart {<br></div><div>&nbsp; &nbsp; &nbsp; [ ... ]<br></div><div>&nb=
sp; &nbsp; &nbsp; #dma-address-cells =3D &lt;1&gt;;<br></div><div>&nbsp;=
 &nbsp; &nbsp; #dma-size-cells =3D &lt;2&gt;;<br></div><div>&nbsp; &nbsp=
; &nbsp; dma-window =3D &lt;0 0x1 0x0&gt;;<br></div><div>&nbsp; &nbsp; &=
nbsp; [ ... ]<br></div><div>&nbsp; };<br></div><div>&nbsp; pcie_dart {<b=
r></div><div>&nbsp; &nbsp; &nbsp; [ ... ]<br></div><div>&nbsp; &nbsp; &n=
bsp; #dma-address-cells =3D &lt;1&gt;;<br></div><div>&nbsp; &nbsp; &nbsp=
; #dma-size-cells =3D &lt;1&gt;;<br></div><div>&nbsp; &nbsp; &nbsp; dma-=
window =3D &lt;0x100000 0x3fe00000&gt;;<br></div><div>&nbsp; &nbsp; &nbs=
p; [ ... ]<br></div><div>&nbsp; };<br></div><div><br></div><div>where #d=
ma-address-cells and #dma-size-cells default to<br></div><div>#address-c=
ells and #size-cells respectively if I understand<br></div><div>the code=
 correctly. That way we could also just always use<br></div><div>a 64bit=
 address and size in the DT, e.g.<br></div><div><br></div><div>&nbsp; pc=
ie_dart {<br></div><div>&nbsp; &nbsp; &nbsp; [ ... ]<br></div><div>&nbsp=
; &nbsp; &nbsp; dma-window =3D &lt;0 0x100000 0 0x3fe00000&gt;;<br></div=
><div>&nbsp; &nbsp; &nbsp; [ ... ]<br></div><div>&nbsp; };<br></div><div=
><br></div><div><br></div><div>Best,<br></div><div><br></div></div><div>=
Sven<br></div><div><br></div><div><div><br></div><div>[1] Documentation/=
devicetree/bindings/iommu/qcom,iommu.txt<br></div><div>[2] Documentation=
/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt<br></div><div>[3] dri=
vers/iommu/of_iommu.c<br></div></div></div><div><br></div></body></html>
--a51a6ec388fd4cb2ab5292471f389a96--

--===============5813216942538423323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5813216942538423323==--
