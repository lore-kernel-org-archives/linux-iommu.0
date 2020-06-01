Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80468C433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 10:56:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A29420679
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 10:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khsk9V2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05A2F883A9;
	Mon,  1 Jun 2020 10:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9J8K5oQtse1; Mon,  1 Jun 2020 10:56:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E1BE883A7;
	Mon,  1 Jun 2020 10:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79BACC088C;
	Mon,  1 Jun 2020 10:56:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E8C7C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 10:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4AA4A883A9
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 10:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7scGUGHAQlyu for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 10:56:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 08041883A7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 10:56:25 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id z64so3326489pfb.1
 for <iommu@lists.linux-foundation.org>; Mon, 01 Jun 2020 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=wCiyJZBq0o0r4xZ6uRTrs2DmoNQhmxx4pO6/8YY8jEc=;
 b=khsk9V2ClzCmgjCfWLtn2ea6ccs9BWB54ilPHSlk3VawfYVP480kKhCTQtR8S4OYwC
 itgT2T4NRZKm0BCutlH2sBFdyKP7EcS5KgCAi4TdgrV0umu29IMGBiQxbKQgxvZyU4+r
 0/rdaT/eqiPPIB+a/YQtkAiKX6uMw25t8U/AbC9/1kj0j/6lKSZ1dTxdqsNB6BczmvKD
 lt+wNm5+DLSOEvN0fdahQ2NyFq534EOpYOkTXOZa8ySKEm4WM+JXhmMwlu9qQjm1XKsj
 IT6tjhwIUNbnJA4L7KvTt/5xhRyRZftujdZJzlVqZ3teyMj2SZenz8/grHDcI/e0jeLD
 CJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=wCiyJZBq0o0r4xZ6uRTrs2DmoNQhmxx4pO6/8YY8jEc=;
 b=bRGtNtx46Vz6dbm4XK8QolrAytq63UfPDpHO6ZmBYYpBX8ZnyO63qQu1U5Mz6pjT5L
 jLNwK08AY0r2etLZCpbmMrc3jdae0UZlX6bfQ1USpKxTbicAVb/leVvP64AF77Yp5dbz
 NkmFyoebxV9HDlL9eodQclDD6X/XSQuoUeV3JezqPkTc66ddGv45+wQFiSO1hYqQu+3a
 RbyItSNUM/EAvinBSEIxm8qWThULMT7X+HyVmIGU6qDlzzgzL/AI/kKXACXddyi+CJY1
 bHNDR4qoKtQm47U3YA0yqc58cAmzy6a7ZHUmrzx/0PBvU+EquNzM+Y1Y+IOQoY96ruQq
 nwfQ==
X-Gm-Message-State: AOAM531+/Ki3k2xyWDzanLzUGv8DzbOYmHSwvMbPyodRB7yxR7a+RJNt
 W8aBSmVC+Zv6DGPBvmusHqM=
X-Google-Smtp-Source: ABdhPJyVAxJqhgGLLD0bHF7Me9nHGGutGzWK1QxL7WPEMjwyFQTCjAaK98QUYN7f2Ty0WnF3ou2dmw==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr20137172pfp.265.1591008984346; 
 Mon, 01 Jun 2020 03:56:24 -0700 (PDT)
Received: from localhost.lan (p1585078-ipngn14401hodogaya.kanagawa.ocn.ne.jp.
 [153.203.249.78])
 by smtp.gmail.com with ESMTPSA id w190sm13708963pfw.35.2020.06.01.03.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 03:56:23 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
 by localhost.lan (Postfix) with ESMTPSA id C58C9900903;
 Mon,  1 Jun 2020 10:56:21 +0000 (GMT)
Date: Mon, 1 Jun 2020 10:56:19 +0000
From: Vincent Pelletier <plr.vincent@gmail.com>
To: USB list <linux-usb@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Mathias Nyman
 <mathias.nyman@intel.com>, Henrique de Moraes Holschuh
 <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org
Subject: [Try 2] DMAR errors on Wildcat Point-LP xHCI (Lenovo T450s)
Message-ID: <20200601105619.5367ed54@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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

Well, try 1 was a word salad, thanks gmail I guess. Now I will try to redeem myself...

Hello,

Trying to use a built-in USB device I rarely use (Sierra EM7345 LTE
modem), I ran into issues from the modem flapping (getting removed
from USB bus before LTE network registration is visible) up to all
devices on the bus being "disconnected" (xhci giving up, in my
understanding, with only the root hubs listed by lsusb).
Checking the syslog, I find this:

May 30 17:35:46 localhost kernel: [  278.999480] DMAR: DRHD: handling fault status reg 3
May 30 17:35:46 localhost kernel: [  278.999485] DMAR: [DMA Read] Request device [00:16.7] PASID ffffffff fault addr 9cdff000 [fault reason 02] Present bit in context entry is clear
May 30 17:35:46 localhost kernel: [  278.999488] DMAR: DRHD: handling fault status reg 3
May 30 17:35:46 localhost kernel: [  278.999490] DMAR: [DMA Read] Request device [00:16.7] PASID ffffffff fault addr 9cdff000 [fault reason 02] Present bit in context entry is clear
May 30 17:35:46 localhost kernel: [  279.001076] DMAR: DRHD: handling fault status reg 2
May 30 17:35:46 localhost kernel: [  279.001078] DMAR: [DMA Write] Request device [00:16.7] PASID ffffffff fault addr 9cdff000 [fault reason 02] Present bit in context entry is clear
May 30 17:35:46 localhost kernel: [  279.001120] DMAR: DRHD: handling fault status reg 2
May 30 17:35:47 localhost kernel: [  280.738192] usb 2-4: USB disconnect, device number 10
May 30 17:35:47 localhost kernel: [  280.738224] cdc_mbim 2-4:1.0: Tx URB error: -19
May 30 17:35:47 localhost kernel: [  280.738303] cdc_mbim 2-4:1.0 wwan0: unregister 'cdc_mbim' usb-0000:00:14.0-4, CDC MBIM
May 30 17:35:47 localhost ModemManager[736]: <info>  (net/wwan0): released by device '/sys/devices/pci0000:00/0000:00:14.0/usb2/2-4'
May 30 17:35:47 localhost ModemManager[736]: [/dev/cdc-wdm0] unexpected port hangup!
May 30 17:35:47 localhost ModemManager[736]: [/dev/cdc-wdm0] channel destroyed
May 30 17:35:47 localhost ModemManager[736]: <info>  Connection to mbim-proxy for /dev/cdc-wdm0 lost, reprobing
May 30 17:35:47 localhost ModemManager[736]: <info>  [device /sys/devices/pci0000:00/0000:00:14.0/usb2/2-4] creating modem with plugin 'Sierra' and '2' ports
May 30 17:35:47 localhost ModemManager[736]: <warn>  Could not recreate modem for device '/sys/devices/pci0000:00/0000:00:14.0/usb2/2-4': Failed to find a net port in the MBIM modem
May 30 17:35:47 localhost ModemManager[736]: <info> (usbmisc/cdc-wdm0): released by device '/sys/devices/pci0000:00/0000:00:14.0/usb2/2-4'
May 30 17:35:47 localhost ModemManager[736]: <info>  (tty/ttyACM0): released by device '/sys/devices/pci0000:00/0000:00:14.0/usb2/2-4'
May 30 17:35:48 localhost kernel: [  281.202173] usb 2-4: new high-speed USB device number 11 using xhci_hcd
May 30 17:35:48 localhost kernel: [  281.224037] usb 2-4: New USB device found, idVendor=8087, idProduct=0716, bcdDevice= 0.00
May 30 17:35:48 localhost kernel: [  281.224043] usb 2-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
May 30 17:35:48 localhost kernel: [  281.225646] usb_serial_simple 2-4:1.0: flashloader converter detected
May 30 17:35:48 localhost kernel: [  281.225891] usb 2-4: flashloader converter now attached to ttyUSB0

which makes me suspect a missing IOMMU mapping in ACPI for the xhci
controller. In this case, the xhci could recover and re-enumerated the
device fairly quickly.
Booting with "intel_iommu=off" makes the LTE modem work at least far
enough that it gets registered to network (can send/receive SMS). I
have not tried data communication (no data plan on current SIM).
I have noticed for a while that this machine had a tendency to lose
all USB devices more often than I enable the LTE modem, so it seems
the modem just make this issue more likely, and is not their direct
cause.

This is on a 5.6.7 (Debian Sid 5.6.0-1-amd64, version from which
pasted logs are extracted), and reproduced with 5.6.14 (Debian Sid
5.6.0-2-amd64).
The USB issues have been happening for a long time, and I use this
modem rarely enough that I would not notice a new issue before several
kernel versions.
The modem usually worked "well enough" but always has had a bit of
flapping, sometimes working after one or two suspend/resume cycles,
and until now I did not feel the need to investigate more (I assumed a
less-than-optimal modem/modem driver).
This time it never ended up working after several suspend/resume
cycles and reboots. So I do not believe it is a localised regression,
but a bad situation getting just nudged over the edge.

$ lspci
00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09)
00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller (rev 09)
00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI Controller (rev 03)
00:16.0 Communication controller: Intel Corporation Wildcat Point-LP MEI Controller #1 (rev 03)
00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (3) I218-V (rev 03)
00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Port #6 (rev e3)
00:1c.1 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Root Port #3 (rev e3)
00:1d.0 USB controller: Intel Corporation Wildcat Point-LP USB EHCI Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA Controller [AHCI Mode] (rev 03)
00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (rev 03)
00:1f.6 Signal processing controller: Intel Corporation Wildcat Point-LP Thermal Management Controller (rev 03)
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5227 PCI Express Card Reader (rev 01)
03:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
$ lsusb
Bus 001 Device 002: ID 8087:8001 Intel Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 006: ID 04f2:b449 Chicony Electronics Co., Ltd Integrated Camera
Bus 002 Device 017: ID 8087:0a2a Intel Corp.
Bus 002 Device 004: ID 138a:0017 Validity Sensors, Inc. VFS 5011 fingerprint sensor
Bus 002 Device 003: ID 058f:9540 Alcor Micro Corp. AU9540 Smartcard Reader
Bus 002 Device 016: ID 1199:a001 Sierra Wireless, Inc. Sierra Wireless EM7345 4G LTE
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Early boot messages are unhappy with firmware (1.37 is the latest
available version to date):
May 30 17:32:17 localhost kernel: [    0.168626] DMAR: Host address width 39
May 30 17:32:17 localhost kernel: [    0.168629] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
May 30 17:32:17 localhost kernel: [    0.168640] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e1ff0505e
May 30 17:32:17 localhost kernel: [    0.168643] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
May 30 17:32:17 localhost kernel: [    0.168651] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c20660462 ecap f010da
May 30 17:32:17 localhost kernel: [    0.168653] DMAR: RMRR base: 0x0000009c0f1000 end: 0x0000009c107fff
May 30 17:32:17 localhost kernel: [    0.168655] DMAR: RMRR base: 0x0000009d800000 end: 0x0000009fffffff
May 30 17:32:17 localhost kernel: [    0.168658] DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x000000009d800000-0x000000009fffffff], contact BIOS vendor for fixes
May 30 17:32:17 localhost kernel: [    0.168671] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x000000009d800000-0x000000009fffffff]
May 30 17:32:17 localhost kernel: [    0.168671] BIOS vendor: LENOVO; Ver: JBET73WW (1.37 ); Product Version: ThinkPad T450s
May 30 17:32:17 localhost kernel: [    0.168675] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
May 30 17:32:17 localhost kernel: [    0.168677] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
May 30 17:32:17 localhost kernel: [    0.168679] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
May 30 17:32:17 localhost kernel: [    0.168680] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
May 30 17:32:17 localhost kernel: [    0.169608] DMAR-IR: Enabled IRQ remapping in xapic mode
[...]
May 30 17:32:17 localhost kernel: [    0.890456] pci 0000:00:02.0: DMAR: Disabling IOMMU for graphics on this chipset
[...]
May 30 17:32:17 localhost kernel: [    2.574095] DMAR: No ATSR found
May 30 17:32:17 localhost kernel: [    2.574207] DMAR: dmar1: Using Queued invalidation
May 30 17:32:17 localhost kernel: [    2.574608] pci 0000:00:00.0: Adding to iommu group 0
May 30 17:32:17 localhost kernel: [    2.574760] pci 0000:00:03.0: Adding to iommu group 1
May 30 17:32:17 localhost kernel: [    2.575002] pci 0000:00:14.0: Adding to iommu group 2
May 30 17:32:17 localhost kernel: [    2.575170] pci 0000:00:16.0: Adding to iommu group 3
May 30 17:32:17 localhost kernel: [    2.575339] pci 0000:00:19.0: Adding to iommu group 4
May 30 17:32:17 localhost kernel: [    2.575489] pci 0000:00:1b.0: Adding to iommu group 5
May 30 17:32:17 localhost kernel: [    2.575652] pci 0000:00:1c.0: Adding to iommu group 6
May 30 17:32:17 localhost kernel: [    2.575818] pci 0000:00:1c.1: Adding to iommu group 7
May 30 17:32:17 localhost kernel: [    2.576035] pci 0000:00:1d.0: Adding to iommu group 8
May 30 17:32:17 localhost kernel: [    2.580374] pci 0000:00:1f.0: Adding to iommu group 9
May 30 17:32:17 localhost kernel: [    2.580411] pci 0000:00:1f.2: Adding to iommu group 9
May 30 17:32:17 localhost kernel: [    2.580436] pci 0000:00:1f.3: Adding to iommu group 9
May 30 17:32:17 localhost kernel: [    2.580461] pci 0000:00:1f.6: Adding to iommu group 9
May 30 17:32:17 localhost kernel: [    2.580628] pci 0000:02:00.0: Adding to iommu group 10
May 30 17:32:17 localhost kernel: [    2.581050] pci 0000:03:00.0: Adding to iommu group 11
May 30 17:32:17 localhost kernel: [    2.581056] DMAR: Intel(R) Virtualization Technology for Directed I/O

I am not sure what could fix this issue, hence the many recipients for
this email:
- An xhci module issue (should check/define extra IOMMU mappings, warn
about them missing, or maybe be able to more reliably recover) ?
- A new IOMMU quirk (workaround bad firmware) ?
- A new thinkpad_acpi quirk (workaround bad firmware) ?
Or somewhere else that I did not think of ? Hopefully it will not
require a Lenovo BIOS fix, as this is an aging model.

Regards,
-- 
Vincent Pelletier
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
