Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A2FC41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 16:08:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEBA206D4
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 16:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEBA206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=traviangames.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E7FE820763;
	Tue,  6 Oct 2020 16:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QpqIxhUPrLmh; Tue,  6 Oct 2020 16:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47E2B20531;
	Tue,  6 Oct 2020 16:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26ECCC016F;
	Tue,  6 Oct 2020 16:08:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A09EC0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E1EB870BD
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id trOce8DrP065 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 15:47:20 +0000 (UTC)
X-Greylist: delayed 00:30:16 by SQLgrey-1.7.6
Received: from mailout07.rmx.de (mailout07.rmx.de [94.199.90.95])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9792C870BC
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 15:47:20 +0000 (UTC)
Received: from kdin04.retarus.com (kdin04.dmz1.retloc [172.19.16.59])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mailout07.rmx.de (Postfix) with ESMTPS id 4C5Lfg5X4WzBtvZ;
 Tue,  6 Oct 2020 17:16:59 +0200 (CEST)
Received: from SRV-EX03.muc.traviantest.lan (unknown [10.64.2.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by kdin04.retarus.com (Postfix) with ESMTPS id 4C5Ldf69dbzxNmc;
 Tue,  6 Oct 2020 17:16:06 +0200 (CEST)
Received: from SRV-EX03.muc.traviangames.lan (10.64.2.31) by
 SRV-EX03.muc.traviangames.lan (10.64.2.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 6 Oct 2020 17:16:05 +0200
Received: from SRV-EX03.muc.traviangames.lan ([fe80::24a4:13fd:f7e3:12a1]) by
 SRV-EX03.muc.traviangames.lan ([fe80::24a4:13fd:f7e3:12a1%3]) with
 mapi id 15.01.1913.010; Tue, 6 Oct 2020 17:16:05 +0200
From: Denis Odintsov <d.odintsov@traviangames.com>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Thread-Topic: [PATCH v4 0/4] Add system mmu support for Armada-806
Thread-Index: AQHWm/Oc4VLe7uS45EyxiIpxnstQ1g==
Date: Tue, 6 Oct 2020 15:16:05 +0000
Message-ID: <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
References: <20200715070649.18733-1-tn@semihalf.com>
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.10.4]
Content-ID: <638F69BBBAA28D40BA47FCC6BB720268@muc.traviangames.lan>
MIME-Version: 1.0
X-RMX-ID: 20201006-171606-4C5Ldf69dbzxNmc-0@kdin04
X-RMX-SOURCE: 10.64.2.31
X-Mailman-Approved-At: Tue, 06 Oct 2020 16:08:48 +0000
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "will@kernel.org" <will@kernel.org>, "hannah@marvell.com" <hannah@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mw@semihalf.com" <mw@semihalf.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

> Am 15.07.2020 um 09:06 schrieb Tomasz Nowicki <tn@semihalf.com>:
> 
> The series is meant to support SMMU for AP806 and a workaround
> for accessing ARM SMMU 64bit registers is the gist of it.
> 
> For the record, AP-806 can't access SMMU registers with 64bit width.
> This patches split the readq/writeq into two 32bit accesses instead
> and update DT bindings.
> 
> The series was successfully tested on a vanilla v5.8-rc3 kernel and
> Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.
> 
> For reference, previous versions are listed below:
> V1: https://lkml.org/lkml/2018/10/15/373
> V2: https://lkml.org/lkml/2019/7/11/426
> V3: https://lkml.org/lkml/2020/7/2/1114
> 

1) After enabling SMMU on Armada 8040, and ARM_SMMU_DISABLE_BYPASS_BY_DEFAUL=y by default in kernel since 954a03be033c7cef80ddc232e7cbdb17df735663,
internal eMMC is prevented from being initialised (as there is no iommus property for ap_sdhci0)
Disabling "Disable bypass by default" make it work, but the patch highly suggest doing it properly.
I wasn't able to find correct path for ap_sdhci for iommus in any publicly available documentation,
would be highly appreciated addressed properly, thank you!

2) Second issue I got (btw I have ClearFog GT 8k armada-8040 based board) is mpci ath10k card.
It is found, it is enumerated, it is visible in lspci, but it fails to be initialised. Here is the log:

[    1.743754] armada8k-pcie f2600000.pcie: host bridge /cp0/pcie@f2600000 ranges:
[    1.751116] armada8k-pcie f2600000.pcie:      MEM 0x00f6000000..0x00f6efffff -> 0x00f6000000
[    1.964690] armada8k-pcie f2600000.pcie: Link up
[    1.969379] armada8k-pcie f2600000.pcie: PCI host bridge to bus 0000:00
[    1.976026] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.981537] pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf6efffff]
[    1.988462] pci 0000:00:00.0: [11ab:0110] type 01 class 0x060400
[    1.994504] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    2.000843] pci 0000:00:00.0: supports D1 D2
[    2.005132] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    2.011853] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000
[    2.018001] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
[    2.025002] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    2.032111] pci 0000:01:00.0: supports D1 D2
[    2.049409] pci 0000:00:00.0: BAR 14: assigned [mem 0xf6000000-0xf61fffff]
[    2.056322] pci 0000:00:00.0: BAR 0: assigned [mem 0xf6200000-0xf62fffff]
[    2.063142] pci 0000:00:00.0: BAR 15: assigned [mem 0xf6300000-0xf63fffff pref]
[    2.070484] pci 0000:01:00.0: BAR 0: assigned [mem 0xf6000000-0xf61fffff 64bit]
[    2.077880] pci 0000:01:00.0: BAR 6: assigned [mem 0xf6300000-0xf630ffff pref]
[    2.085135] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.090384] pci 0000:00:00.0:   bridge window [mem 0xf6000000-0xf61fffff]
[    2.097202] pci 0000:00:00.0:   bridge window [mem 0xf6300000-0xf63fffff pref]
[    2.104539] pcieport 0000:00:00.0: Adding to iommu group 4
[    2.110232] pcieport 0000:00:00.0: PME: Signaling with IRQ 38
[    2.116141] pcieport 0000:00:00.0: AER: enabled with IRQ 38
[    8.131135] ath10k_pci 0000:01:00.0: Adding to iommu group 4
[    8.131874] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    8.132203] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0

up to that point the log is the same as without SMMU enabled, except "Adding to iommu group N" lines, and IRQ being 37

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

> v3 -> v4
> - call cfg_probe() impl hook a bit earlier which simplifies errata handling
> - use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accessors
> - keep SMMU status disabled by default and enable where possible (DTS changes)
> - commit logs improvements and other minor fixes
> 
> Hanna Hawa (1):
>  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
>    #582743
> 
> Marcin Wojtas (1):
>  arm64: dts: marvell: add SMMU support
> 
> Tomasz Nowicki (2):
>  iommu/arm-smmu: Call configuration impl hook before consuming features
>  dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
>    SMMU-500
> 
> Documentation/arm64/silicon-errata.rst        |  3 ++
> .../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
> arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 ++++++++++++
> arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++
> arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 ++++++++
> drivers/iommu/arm-smmu-impl.c                 | 45 +++++++++++++++++++
> drivers/iommu/arm-smmu.c                      | 11 +++--
> 7 files changed, 145 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
