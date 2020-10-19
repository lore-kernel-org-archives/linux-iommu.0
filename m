Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1BC43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 11:42:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C20208B8
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 11:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C20208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=traviangames.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CB9E8700B;
	Mon, 19 Oct 2020 11:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0edevqdcFBty; Mon, 19 Oct 2020 11:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD3248700A;
	Mon, 19 Oct 2020 11:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD60AC0052;
	Mon, 19 Oct 2020 11:42:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F93C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 140E020457
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MjuzILc88Im for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:42:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout06.rmx.de (mailout06.rmx.de [94.199.90.92])
 by silver.osuosl.org (Postfix) with ESMTPS id 1608E2288F
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:42:19 +0000 (UTC)
Received: from kdin04.retarus.com (kdin04.dmz1.retloc [172.19.16.59])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mailout06.rmx.de (Postfix) with ESMTPS id 4CFFGn53Wgz9yGp;
 Mon, 19 Oct 2020 13:42:09 +0200 (CEST)
Received: from SRV-EX03.muc.traviantest.lan (unknown [10.64.2.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by kdin04.retarus.com (Postfix) with ESMTPS id 4CFFFf5jHTzxP28;
 Mon, 19 Oct 2020 13:41:10 +0200 (CEST)
Received: from SRV-EX03.muc.traviangames.lan (10.64.2.31) by
 SRV-EX03.muc.traviangames.lan (10.64.2.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 19 Oct 2020 13:41:09 +0200
Received: from SRV-EX03.muc.traviangames.lan ([fe80::24a4:13fd:f7e3:12a1]) by
 SRV-EX03.muc.traviangames.lan ([fe80::24a4:13fd:f7e3:12a1%3]) with
 mapi id 15.01.1913.010; Mon, 19 Oct 2020 13:41:09 +0200
From: Denis Odintsov <d.odintsov@traviangames.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Thread-Topic: [PATCH v4 0/4] Add system mmu support for Armada-806
Thread-Index: AQHWm/Oc4VLe7uS45EyxiIpxnstQ1qmVan8AgAlVjQA=
Date: Mon, 19 Oct 2020 11:41:09 +0000
Message-ID: <98F41358-3877-4096-A0A4-1BB6C0AD5460@traviangames.com>
References: <20200715070649.18733-1-tn@semihalf.com>
 <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
 <08ed4dd7-9c2f-813d-9aea-ff8da07e5641@arm.com>
In-Reply-To: <08ed4dd7-9c2f-813d-9aea-ff8da07e5641@arm.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.10.4]
MIME-Version: 1.0
X-RMX-ID: 20201019-134110-4CFFFf5jHTzxP28-0@kdin04
X-RMX-SOURCE: 10.64.2.31
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "hannah@marvell.com" <hannah@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mw@semihalf.com" <mw@semihalf.com>, "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============2711543867836387662=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2711543867836387662==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_98F4135838774096A0A41BB6C0AD5460traviangamescom_"

--_000_98F4135838774096A0A41BB6C0AD5460traviangamescom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

2) Second issue I got (btw I have ClearFog GT 8k armada-8040 based board) i=
s mpci ath10k card.
It is found, it is enumerated, it is visible in lspci, but it fails to be i=
nitialised. Here is the log:
[    1.743754] armada8k-pcie f2600000.pcie: host bridge /cp0/pcie@f2600000 =
ranges:
[    1.751116] armada8k-pcie f2600000.pcie:      MEM 0x00f6000000..0x00f6ef=
ffff -> 0x00f6000000
[    1.964690] armada8k-pcie f2600000.pcie: Link up
[    1.969379] armada8k-pcie f2600000.pcie: PCI host bridge to bus 0000:00
[    1.976026] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.981537] pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf6effff=
f]
[    1.988462] pci 0000:00:00.0: [11ab:0110] type 01 class 0x060400
[    1.994504] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    2.000843] pci 0000:00:00.0: supports D1 D2
[    2.005132] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.011853] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000
[    2.018001] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit=
]
[    2.025002] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    2.032111] pci 0000:01:00.0: supports D1 D2
[    2.049409] pci 0000:00:00.0: BAR 14: assigned [mem 0xf6000000-0xf61ffff=
f]
[    2.056322] pci 0000:00:00.0: BAR 0: assigned [mem 0xf6200000-0xf62fffff=
]
[    2.063142] pci 0000:00:00.0: BAR 15: assigned [mem 0xf6300000-0xf63ffff=
f pref]
[    2.070484] pci 0000:01:00.0: BAR 0: assigned [mem 0xf6000000-0xf61fffff=
 64bit]
[    2.077880] pci 0000:01:00.0: BAR 6: assigned [mem 0xf6300000-0xf630ffff=
 pref]
[    2.085135] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.090384] pci 0000:00:00.0:   bridge window [mem 0xf6000000-0xf61fffff=
]
[    2.097202] pci 0000:00:00.0:   bridge window [mem 0xf6300000-0xf63fffff=
 pref]
[    2.104539] pcieport 0000:00:00.0: Adding to iommu group 4
[    2.110232] pcieport 0000:00:00.0: PME: Signaling with IRQ 38
[    2.116141] pcieport 0000:00:00.0: AER: enabled with IRQ 38
[    8.131135] ath10k_pci 0000:01:00.0: Adding to iommu group 4
[    8.131874] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    8.132203] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
up to that point the log is the same as without SMMU enabled, except "Addin=
g to iommu group N" lines, and IRQ being 37

Does forcing ath10k to use legacy interrupts rather than MSIs make a differ=
ence?

Judging by the DT it looks like MSIs ought to be targeting the GICv2M widge=
t, but if things somehow end up trying to use the PCIe controller's interna=
l MSI doorbell (upstream of SMMU translation) instead, then that might acco=
unt for general interrupt-related weirdness.

Robin.


Frankly speaking you quickly overcome here my knowledge depth, this is alre=
ady way far from what I understand about PCI devices. But I tried my best t=
o try it out what you suggested.
putting 0 to /sys/bus/pci/devices/0000\:01\:00.0/msi_bus (bus of ath10k) an=
d reloading the driver didn't make a difference with those almost same mess=
ages:

[  103.245287] ath10k_pci 0000:01:00.0: MSI/MSI-X disallowed for future dri=
vers
[  145.938562] ath10k_pci 0000:01:00.0: pci irq legacy oper_irq_mode 1 irq_=
mode 0 reset_mode 0
[  146.053590] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.161637] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.269515] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.453633] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.561589] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.669550] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[  146.753456] ath10k_pci 0000:01:00.0: Failed to get pcie state addr: -16
[  146.760129] ath10k_pci 0000:01:00.0: failed to setup init config: -16
[  146.766695] ath10k_pci 0000:01:00.0: could not power on hif bus (-16)
[  146.773196] ath10k_pci 0000:01:00.0: could not probe fw (-16)

lspci -v says
Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable+ 64bit-

So it seems it does what you suggested, disabled the MSI. With not much dif=
ferences unfortunately. =3D(

I also compared lscpi output also with non-SMMU-dts (with which ath10k work=
s) and SMMU-dts, and there is a difference I guess, I'm not sure how affect=
ing it is.
On non-SMMU dts host controller (served by pcieport driver) IRQ is 37 and a=
th10k IRQ is 82:

00:00.0 PCI bridge: Marvell Technology Group Ltd. Device 0110 (prog-if 00 [=
Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 37
...
01:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless=
 Network Adapter
Flags: bus master, fast devsel, latency 0, IRQ 82

On SMMU dt's though both IRQ's are same and are 38:

00:00.0 PCI bridge: Marvell Technology Group Ltd. Device 0110 (prog-if 00 [=
Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 38
...
01:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless=
 Network Adapter
Flags: bus master, fast devsel, latency 0, IRQ 38

[    8.221328] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.313362] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.409373] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.553433] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.641370] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.737979] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
[    8.807356] ath10k_pci 0000:01:00.0: Failed to get pcie state addr: -16
[    8.814032] ath10k_pci 0000:01:00.0: failed to setup init config: -16
[    8.820605] ath10k_pci 0000:01:00.0: could not power on hif bus (-16)
[    8.827111] ath10k_pci 0000:01:00.0: could not probe fw (-16)
Thank you!
v3 -> v4
- call cfg_probe() impl hook a bit earlier which simplifies errata handling
- use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accesso=
rs
- keep SMMU status disabled by default and enable where possible (DTS chang=
es)
- commit logs improvements and other minor fixes

Hanna Hawa (1):
 iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
   #582743

Marcin Wojtas (1):
 arm64: dts: marvell: add SMMU support

Tomasz Nowicki (2):
 iommu/arm-smmu: Call configuration impl hook before consuming features
 dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
   SMMU-500

Documentation/arm64/silicon-errata.rst        |  3 ++
.../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 ++++++++++++
arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++
arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 ++++++++
drivers/iommu/arm-smmu-impl.c                 | 45 +++++++++++++++++++
drivers/iommu/arm-smmu.c                      | 11 +++--
7 files changed, 145 insertions(+), 4 deletions(-)

--
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org<mailto:iommu@lists.linux-foundation.org>
https://lists.linuxfoundation.org/mailman/listinfo/iommu


--_000_98F4135838774096A0A41BB6C0AD5460traviangamescom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <7C53DC6C8512144688A7CD1F63DC7597@muc.traviangames.lan>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break:=
 after-white-space;" class=3D"">
<br class=3D"">
<div>Hi,</div>
<div><br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
2) Second issue I got (btw I have ClearFog GT 8k armada-8040 based board) i=
s mpci ath10k card.<br class=3D"">
It is found, it is enumerated, it is visible in lspci, but it fails to be i=
nitialised. Here is the log:<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.743754] armada8k-pcie f2600000.pcie: host bridge /cp0=
/pcie@f2600000 ranges:<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.751116] armada8k-pcie f2600000.pcie: &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;MEM 0x00f6000000..0x00f6efffff -&gt; 0x00f6000000<br class=3D=
"">
[ &nbsp;&nbsp;&nbsp;1.964690] armada8k-pcie f2600000.pcie: Link up<br class=
=3D"">
[ &nbsp;&nbsp;&nbsp;1.969379] armada8k-pcie f2600000.pcie: PCI host bridge =
to bus 0000:00<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.976026] pci_bus 0000:00: root bus resource [bus 00-ff=
]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.981537] pci_bus 0000:00: root bus resource [mem 0xf60=
00000-0xf6efffff]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.988462] pci 0000:00:00.0: [11ab:0110] type 01 class 0=
x060400<br class=3D"">
[ &nbsp;&nbsp;&nbsp;1.994504] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0=
x000fffff]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.000843] pci 0000:00:00.0: supports D1 D2<br class=3D"=
">
[ &nbsp;&nbsp;&nbsp;2.005132] pci 0000:00:00.0: PME# supported from D0 D1 D=
3hot<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.011853] pci 0000:01:00.0: [168c:003c] type 00 class 0=
x028000<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.018001] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0=
x001fffff 64bit]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.025002] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0=
x0000ffff pref]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.032111] pci 0000:01:00.0: supports D1 D2<br class=3D"=
">
[ &nbsp;&nbsp;&nbsp;2.049409] pci 0000:00:00.0: BAR 14: assigned [mem 0xf60=
00000-0xf61fffff]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.056322] pci 0000:00:00.0: BAR 0: assigned [mem 0xf620=
0000-0xf62fffff]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.063142] pci 0000:00:00.0: BAR 15: assigned [mem 0xf63=
00000-0xf63fffff pref]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.070484] pci 0000:01:00.0: BAR 0: assigned [mem 0xf600=
0000-0xf61fffff 64bit]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.077880] pci 0000:01:00.0: BAR 6: assigned [mem 0xf630=
0000-0xf630ffff pref]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.085135] pci 0000:00:00.0: PCI bridge to [bus 01-ff]<b=
r class=3D"">
[ &nbsp;&nbsp;&nbsp;2.090384] pci 0000:00:00.0: &nbsp;&nbsp;bridge window [=
mem 0xf6000000-0xf61fffff]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.097202] pci 0000:00:00.0: &nbsp;&nbsp;bridge window [=
mem 0xf6300000-0xf63fffff pref]<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.104539] pcieport 0000:00:00.0: Adding to iommu group =
4<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.110232] pcieport 0000:00:00.0: PME: Signaling with IR=
Q 38<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.116141] pcieport 0000:00:00.0: AER: enabled with IRQ =
38<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.131135] ath10k_pci 0000:01:00.0: Adding to iommu grou=
p 4<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.131874] ath10k_pci 0000:01:00.0: enabling device (000=
0 -&gt; 0002)<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.132203] ath10k_pci 0000:01:00.0: pci irq msi oper_irq=
_mode 2 irq_mode 0 reset_mode 0<br class=3D"">
up to that point the log is the same as without SMMU enabled, except &quot;=
Adding to iommu group N&quot; lines, and IRQ being 37<br class=3D"">
</blockquote>
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Does
 forcing ath10k to use legacy interrupts rather than MSIs make a difference=
?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Judging
 by the DT it looks like MSIs ought to be targeting the GICv2M widget, but =
if things somehow end up trying to use the PCIe controller's internal MSI d=
oorbell (upstream of SMMU translation) instead, then that might account for=
 general interrupt-related weirdness.</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Robin.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; text-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
</div>
</blockquote>
<div><br class=3D"">
</div>
<div>Frankly speaking you quickly overcome here my knowledge depth, this is=
 already way far from what I understand about PCI devices. But I tried my b=
est to try it out what you suggested.</div>
<div>putting 0 to&nbsp;/sys/bus/pci/devices/0000\:01\:00.0/msi_bus (bus of =
ath10k) and reloading the driver didn't make a difference with those almost=
 same messages:</div>
<div><br class=3D"">
</div>
<div>
<div>[ &nbsp;103.245287] ath10k_pci 0000:01:00.0: MSI/MSI-X disallowed for =
future drivers</div>
<div>[ &nbsp;145.938562] ath10k_pci 0000:01:00.0: pci irq legacy oper_irq_m=
ode 1 irq_mode 0 reset_mode 0</div>
<div>[ &nbsp;146.053590] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.161637] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.269515] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.453633] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.561589] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.669550] ath10k_pci 0000:01:00.0: failed to poke copy engin=
e: -16</div>
<div>[ &nbsp;146.753456] ath10k_pci 0000:01:00.0: Failed to get pcie state =
addr: -16</div>
<div>[ &nbsp;146.760129] ath10k_pci 0000:01:00.0: failed to setup init conf=
ig: -16</div>
<div>[ &nbsp;146.766695] ath10k_pci 0000:01:00.0: could not power on hif bu=
s (-16)</div>
<div>[ &nbsp;146.773196] ath10k_pci 0000:01:00.0: could not probe fw (-16)<=
/div>
<div><br class=3D"">
</div>
<div>lspci -v says</div>
<div>Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable&#43; 64bit-</div>
<div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D""><br class=3D"">
</span></div>
<div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D"">So it seems it does what you suggested, disabled the MSI. With not mu=
ch differences unfortunately. =3D(</span></div>
<div>
<div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br class=3D=
"">
</div>
</div>
<div>I also compared lscpi output also with non-SMMU-dts (with which ath10k=
 works) and SMMU-dts, and there is a difference I guess, I'm not sure how a=
ffecting it is.</div>
<div>On non-SMMU dts host controller (served by pcieport driver) IRQ is 37 =
and ath10k IRQ is 82:</div>
<div><br class=3D"">
</div>
<div>
<div>00:00.0 PCI bridge: Marvell Technology Group Ltd. Device 0110 (prog-if=
 00 [Normal decode])</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>Flags:=
 bus master, fast devsel, latency 0, IRQ 37</div>
<div class=3D"">
<div class=3D"">...</div>
<div class=3D"">01:00.0 Network controller: Qualcomm Atheros QCA986x/988x 8=
02.11ac Wireless Network Adapter</div>
<div class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre"></=
span>Flags: bus master, fast devsel, latency 0, IRQ 82</div>
</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">On SMMU dt's though both IRQ's are same and are 38:</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">
<div class=3D"">00:00.0 PCI bridge: Marvell Technology Group Ltd. Device 01=
10 (prog-if 00 [Normal decode])</div>
<div class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre"></=
span>Flags: bus master, fast devsel, latency 0, IRQ 38</div>
</div>
<div class=3D"">...</div>
<div class=3D"">
<div class=3D"">01:00.0 Network controller: Qualcomm Atheros QCA986x/988x 8=
02.11ac Wireless Network Adapter</div>
<div class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre"></=
span>Flags: bus master, fast devsel, latency 0, IRQ 38</div>
</div>
</div>
<div><br class=3D"">
</div>
</div>
<blockquote type=3D"cite" class=3D"">
<div class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
[ &nbsp;&nbsp;&nbsp;8.221328] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.313362] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.409373] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.553433] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.641370] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.737979] ath10k_pci 0000:01:00.0: failed to poke copy =
engine: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.807356] ath10k_pci 0000:01:00.0: Failed to get pcie s=
tate addr: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.814032] ath10k_pci 0000:01:00.0: failed to setup init=
 config: -16<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.820605] ath10k_pci 0000:01:00.0: could not power on h=
if bus (-16)<br class=3D"">
[ &nbsp;&nbsp;&nbsp;8.827111] ath10k_pci 0000:01:00.0: could not probe fw (=
-16)<br class=3D"">
Thank you!<br class=3D"">
<blockquote type=3D"cite" class=3D"">v3 -&gt; v4<br class=3D"">
- call cfg_probe() impl hook a bit earlier which simplifies errata handling=
<br class=3D"">
- use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accesso=
rs<br class=3D"">
- keep SMMU status disabled by default and enable where possible (DTS chang=
es)<br class=3D"">
- commit logs improvements and other minor fixes<br class=3D"">
<br class=3D"">
Hanna Hawa (1):<br class=3D"">
&nbsp;iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum<br cl=
ass=3D"">
&nbsp;&nbsp;&nbsp;#582743<br class=3D"">
<br class=3D"">
Marcin Wojtas (1):<br class=3D"">
&nbsp;arm64: dts: marvell: add SMMU support<br class=3D"">
<br class=3D"">
Tomasz Nowicki (2):<br class=3D"">
&nbsp;iommu/arm-smmu: Call configuration impl hook before consuming feature=
s<br class=3D"">
&nbsp;dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806=
<br class=3D"">
&nbsp;&nbsp;&nbsp;SMMU-500<br class=3D"">
<br class=3D"">
Documentation/arm64/silicon-errata.rst &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;| &nbsp;3 &#43;&#43;<br class=3D"">
.../devicetree/bindings/iommu/arm,smmu.yaml &nbsp;&nbsp;| &nbsp;4 &#43;&#43=
;<br class=3D"">
arch/arm64/boot/dts/marvell/armada-7040.dtsi &nbsp;| 28 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br class=3D"">
arch/arm64/boot/dts/marvell/armada-8040.dtsi &nbsp;| 40 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br class=
=3D"">
arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;<br class=3D"">
drivers/iommu/arm-smmu-impl.c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 45 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;<br class=3D"">
drivers/iommu/arm-smmu.c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;| 11 &#43;&#43;&#43;--<br class=3D"">
7 files changed, 145 insertions(&#43;), 4 deletions(-)<br class=3D"">
<br class=3D"">
--<span class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">
2.17.1<br class=3D"">
<br class=3D"">
_______________________________________________<br class=3D"">
iommu mailing list<br class=3D"">
<a href=3D"mailto:iommu@lists.linux-foundation.org" class=3D"">iommu@lists.=
linux-foundation.org</a><br class=3D"">
https://lists.linuxfoundation.org/mailman/listinfo/iommu</blockquote>
</blockquote>
</div>
</blockquote>
</div>
<br class=3D"">
</body>
</html>

--_000_98F4135838774096A0A41BB6C0AD5460traviangamescom_--

--===============2711543867836387662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2711543867836387662==--
