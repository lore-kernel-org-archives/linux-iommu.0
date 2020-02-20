Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE0EC11D00
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 08:24:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3556208C4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="0cL/kWKS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="16cWLyRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3556208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 883DE84F5A;
	Thu, 20 Feb 2020 08:24:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Hc1dv572dEa; Thu, 20 Feb 2020 08:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56DE2862C7;
	Thu, 20 Feb 2020 08:24:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4128AC1D81;
	Thu, 20 Feb 2020 08:24:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9A7C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A42D88674D
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZWQK1u4QK9QJ for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 02:05:55 +0000 (UTC)
X-Greylist: delayed 00:08:22 by SQLgrey-1.7.6
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5619C841D5
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:05:55 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id A776F6C7;
 Wed, 19 Feb 2020 20:57:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 19 Feb 2020 20:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=Ug60JBQBRNYbiA/ryIWOlfzVieF
 t9+a03PW6eV0kNWw=; b=0cL/kWKSBaOM6IiO18PrF7dvNe5EOcqkjq0ExKJUPAH
 EXNZXdozjEGfKN1F4af7O6a1+s1gY819DCfwUbtr6frLcxN3Zf4SeuuQwWncowmo
 I5LUQQsWoVxTfIk9wmL30EYJKHDCVBzgo40SwNSXOmaYxyY7zk8g0U+OS9Kw7fsM
 hP8xG8H3640z5aKfg7lP8ODQ+as24Y1EMaC/HxJnx7Lq4l+04zFQgd2HgtERCYbM
 /TvFdTb83SlEsYcYbFGsVHKvQFuQlvORvCzQYfCDe9VNOkaDSHoziIf3z+T0QiQF
 yKokepjJrkVAbW3K/JZoOqgS3d4Z5Kd8CNSERydlnEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ug60JB
 QBRNYbiA/ryIWOlfzVieFt9+a03PW6eV0kNWw=; b=16cWLyRIplwhbdvkcxUjM4
 6DGsZ03J1qOmEMSKyY/GE2o7jBC2rydNGtga76z4Op1iSEl1kO44nYIScxFP6s8J
 SJcFBhuA1ofz+SKRSXgP7UoRhHtrbKz5BXHEbCCUHIG8crca8pngwhBiOmhIzwSZ
 qlnhq4zJyHBqub8LEE1Mqd7ECskJ6+zkwQJIFOsK5r/u8Wb24ZfSDkTQgF7WmJO4
 btfi+7QckJOc7yYAGy/UKgH1mu5XCGrVd7xQOWxXfwVq33WRmyTQseRjKSG2Ta9s
 LiiFKI0U8UOjImolh/lwc5nDbNRYM5ReAGXWi8NI8RWgkLEOvM295n19atkKo/nw
 ==
X-ME-Sender: <xms:iudNXk10vbD55h0atRiOh7VxNYRFaDGDsrCjpGu4dG8loq_vHmyMYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhusghunhhtuhdrtghomhenucfk
 phepudegrdefrdejgedrudeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:iudNXq5S6iAx1BtmViThNg4Uzp1-xOu6h8UbEYgz9SzWiLi3V7D-6g>
 <xmx:iudNXjWs3MF5da5CBZLiv2CQTcZPDoAaR0cKmZtJyv8i0pFUCeCeSg>
 <xmx:iudNXqj1sxh_3TKdXmKK-d5w_zfikhxtxCx_xdwX5ag5PJsIDT04zQ>
 <xmx:i-dNXnKoVpdbqUVNSXOiL6XiSZcRUSu732vyjFY4OK-d-UkI8J_1Tw>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id C499B328005D;
 Wed, 19 Feb 2020 20:57:29 -0500 (EST)
Date: Thu, 20 Feb 2020 10:57:27 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Steve Morris <morris@buinea.com>
Subject: Re: sytem reboots when initializing Edirol FA-101 firewire audio
 interface
Message-ID: <20200220015726.GA3578@workstation>
Mail-Followup-To: Steve Morris <morris@buinea.com>,
 alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org,
 linux1394-devel@lists.sourceforge.net
References: <20200219141956.GA14216@buinea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219141956.GA14216@buinea.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 20 Feb 2020 08:24:04 +0000
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
 iommu@lists.linux-foundation.org
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

On Wed, Feb 19, 2020 at 06:19:56AM -0800, Steve Morris wrote:
> I'm running Arch Linux x86_64
> 
> My system consistently reboots when I power on my FA-101 when running
> kernels 5.5.1-4. Downgrading to 5.4.15 allows everything to work
> properly.
> 
> Here's the outpu of:
> journalctl  | grep -E 'Reboot|firewire|fw|bebob|alsa|jack'
> 
> This is a good init under 5.4.15:
> -- Reboot --
> powered on interface while running 5.4.15, initialized properly
> Feb 18 18:35:37 hostname kernel: firewire_ohci 0000:05:00.0: enabling device (0080 -> 0083)
> Feb 18 18:35:37 hostname kernel: firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
> Feb 18 18:35:37 hostname kernel: firewire_core 0000:05:00.0: created device fw0: GUID 0011223333666677, S400
> Feb 18 18:35:37 hostname systemd-udevd[541]: controlC0: Process '/usr/bin/alsactl restore 0' failed with exit code 99.
> Feb 18 18:35:37 hostname systemd-udevd[541]: controlC1: Process '/usr/bin/alsactl restore 1' failed with exit code 99.
> Feb 18 18:35:38 hostname kernel: amdgpu: [powerplay] smu driver if version = 0x00000033, smu fw if version = 0x00000035, smu fw version = 0x002a3200 (42.50.0)
> Feb 18 18:36:08 hostname kernel: firewire_ohci 0000:05:00.0: isochronous cycle inconsistent
> Feb 18 18:36:08 hostname kernel: firewire_core 0000:05:00.0: created device fw1: GUID 0040ab0000c20bc1, S400
> Feb 18 18:36:08 hostname kernel: firewire_core 0000:05:00.0: phy config: new root=ffc1, gap_count=5
> Feb 18 18:36:10 hostname kernel: firewire_core 0000:05:00.0: BM lock failed (timeout), making local node (ffc0) root
> Feb 18 18:36:10 hostname kernel: firewire_core 0000:05:00.0: phy config: new root=ffc0, gap_count=5
> Feb 18 18:36:12 hostname systemd-udevd[1532]: controlC2: Process '/usr/bin/alsactl restore 2' failed with exit code 99.
> Feb 18 18:36:15 hostname kernel: snd-bebob fw1.0: transaction failed: no ack
> Feb 18 18:36:15 hostname kernel: snd-bebob fw1.0: fail to get an input for MSU in plug 7: -5
> Feb 18 18:36:15 hostname kernel: snd-bebob fw1.0: transaction failed: no ack
> Feb 18 18:36:15 hostname kernel: snd-bebob fw1.0: fail to get an input for MSU in plug 7: -5
> 
> This is a bad init under 5.5.4:
> -- Reboot --
> Powered on interface when machine was running.
> Feb 18 18:13:37 hostname kernel: firewire_ohci 0000:05:00.0: enabling device (0080 -> 0083)
> Feb 18 18:13:37 hostname kernel: firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
> Feb 18 18:13:37 hostname kernel: firewire_core 0000:05:00.0: created device fw0: GUID 0011223333666677, S400
> Feb 18 18:13:37 hostname kernel: audit: type=1130 audit(1582078417.360:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ufw comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Feb 18 18:13:37 hostname audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ufw comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Feb 18 18:13:37 hostname systemd-udevd[539]: controlC0: Process '/usr/bin/alsactl restore 0' failed with exit code 99.
> Feb 18 18:13:37 hostname systemd-udevd[530]: controlC1: Process '/usr/bin/alsactl restore 1' failed with exit code 99.
> Feb 18 18:13:38 hostname kernel: amdgpu: [powerplay] smu driver if version = 0x00000033, smu fw if version = 0x00000035, smu fw version = 0x002a3200 (42.50.0)
> Feb 18 18:19:45 hostname kernel: firewire_core 0000:05:00.0: phy config: new root=ffc1, gap_count=5
> Feb 18 18:19:48 hostname kernel: firewire_core 0000:05:00.0: phy config: new root=ffc1, gap_count=5
> Feb 18 18:19:48 hostname kernel: firewire_core 0000:05:00.0: created device fw1: GUID 0040ab0000c20bc1, S400
> Feb 18 18:19:52 hostname systemd-udevd[1682]: controlC2: Process '/usr/bin/alsactl restore 2' failed with exit code 99.
> Feb 18 18:20:08 hostname kernel: snd-bebob fw1.0: transaction failed: no ack
> Feb 18 18:20:08 hostname kernel: snd-bebob fw1.0: fail to get an input for MSU in plug 7: -5
> Feb 18 18:20:08 hostname kernel: snd-bebob fw1.0: transaction failed: no ack
> Feb 18 18:20:08 hostname kernel: snd-bebob fw1.0: fail to get an input for MSU in plug 7: -5
> Feb 18 18:20:12 hostname kernel: firewire_core 0000:05:00.0: phy config: new root=ffc1, gap_count=5
> Feb 18 18:21:24 hostname kernel: firewire_ohci 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 address=0xd5080000 flags=0x0000]
> Followed by 125 more O_PAGE_FAULT and then the reboot,
> 
> I'll be happy to provide additional information if needed.

Hm. I think your system rushed into too complicated issue, At least, three
software stacks are related to your issue:
 - ALSA bebob driver(snd-bebob) and helper module(snd-firewire-lib)
 - Linux firewire core(firewire-core) and 1394 OHCI controller driver (firewire-ohci)
 - Driver stack for AMD IOMMU

From the log, ALSA bebob driver takes your unit to generate bus reset on
IEEE 1394 bus. We can see 1394 OHCI controller handles the bus reset and
the corresponding driver takes Linux firewire core to process the event.
Your unit's generation of bus reset is responsible for ALSA bebob driver,
and this situation is quite similar to what I reported in this patch[1].

However, the system reboot itself is not responsible for ALSA bebob
driver since it is just an application of kernel API of Linux firewire
application and sound subsystem (ALSA). I don't know exactly yet but
something happened between 1394 OHCI controller driver and AMD IOMMU.
It's probably that the cause is in more platform-specific domain.

I'm sorry not to help you. For developers information, I C.C.ed this
issue to iommu@lists.linux-foundation.org and
linux1394-devel@lists.sourceforge.net. If you can get some responses
from the others, please follow their instruction. But in advance it's
better for you to open information about your kernel configuration
and hardware, especially for the version of AMD AGESA for your CPU,
like:

 * AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
 * Gigabyte Technology Co., Ltd. AX370-Gaming 5/AX370-Gaming 5
 * BIOS F42b 08/01/2019 (=AGESA 1.0.0.3 ABB, perhaps)
 * kernel configuration can be retrieved from Ubuntu package repository[2]

The above is a sample from my development environment. I think it would
be possible to regenerate the issue if you give your kernel
configuration, however I'm on vacation till the beginning of March. So
I cannot practice it now, sorry.

[1] d3eabe939aee ("ALSA: bebob: expand sleep just after breaking connections for protocol version 1")
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/bebob?id=d3eabe939aee
[2] https://packages.ubuntu.com/eoan/kernel/linux-image-5.3.0-40-generic

Regards


Takashi Sakamoto
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
