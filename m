Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A27C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D596D20675
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogNWjhdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D596D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 77219257C;
	Mon, 29 Apr 2019 18:32:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A36281F3F
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:49:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 006FD711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:49:16 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id b10so292078wmj.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language;
	bh=KDA5e8LWemgJkCiCQCIy6KYMNWt5H+X2A/2FryOb1zU=;
	b=ogNWjhdmdgLzgX6TAnJ3ZYZQ4dJgLv/k5LnvIQKdT9J+HYCSNYPQutPkdFPuFyE4ry
	wF7ETFuuoFI1xVye7XMjM255VPUvACOZdbb4uSXIAXhEvJjBbf0sZm+IS/T8k36efcL6
	0oIlpPf2JqgyBb/7zbg+cC/jLYZuvzRREZQoC+RbTypT8PeY1SWbRtqeKm9MFIoth38B
	Xulm5n2RXu7ayZfh853MRiNTT2JGvbtGGChwGCh3jZwNBXboQOoiu14Rtv3oG6lkS/cW
	jDYCBetOdGj0yinRv564XYUscN4myrIb1Ndb6ycF32OxdUJEcaztUegf1PpMTYfiqCJJ
	CNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=KDA5e8LWemgJkCiCQCIy6KYMNWt5H+X2A/2FryOb1zU=;
	b=BBQ6KeInrhNrldCdenvDFMekmrzfNbDyOCE8yaIo4l0ZTPSekK4zycbvPC4Ckx7kCf
	Ey+WdLggolHaLUNPdVdx4Ry4FtW+Zx4ci/YsBR+lV3UXBIZwgIBHaCRcEllvfNM8nRCC
	UwuS+LfLlTwCPBZc3Nbxnop1Rh1+VUwLNltQEPUkrxnwhW6IqOxVlPDReqdUp3PpGESA
	klmab9wTorGBgTZEsSXi1UzxrCcqh1bnb6avtXxTjJVG9X0Vz9kLOwTQI7zUnzmA6/vA
	gUJPt+DxUEN6XE0p4zo6uwDThOIyZ+dVrQI6LlnKRliEl/BmZ9V2DFcwUhdRZa8IMhUh
	8PaQ==
X-Gm-Message-State: APjAAAXzv2o4IrDbdDGZUweRUD4XuVoOGn3LyheRbp2zEyGUXS1HJAUX
	wMl0CuZuffpTGFqrn7T51ifV+k9O
X-Google-Smtp-Source: APXvYqzHjjg/yNiJDsLDEgxB2KZCMJgEgE3PhZrorijf06fxtuL8aPNAmvb7pWZl19wLRWoD3+BRIg==
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr1988296wmd.98.1556538555098; 
	Mon, 29 Apr 2019 04:49:15 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	k67sm13106719wmb.34.2019.04.29.04.49.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 04:49:13 -0700 (PDT)
From: "StarostaCZ@gmail.com" <starostacz@gmail.com>
X-Google-Original-From: "StarostaCZ@gmail.com" <StarostaCZ@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
To: Johan Hovold <johan@kernel.org>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost>
	<26c4a175-dae2-3410-6924-92fe7c8ec6fe@gmail.com>
	<20190429112211.GK26546@localhost>
Message-ID: <d7a274a0-3247-b845-6faf-a345f538739c@gmail.com>
Date: Mon, 29 Apr 2019 13:48:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429112211.GK26546@localhost>
Content-Type: multipart/mixed; boundary="------------22C018EF992FBB461181A202"
Content-Language: cs
X-Mailman-Approved-At: Mon, 29 Apr 2019 18:32:46 +0000
Cc: linux-usb@vger.kernel.org, iommu@lists.linux-foundation.org,
	Mathias Nyman <mathias.nyman@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429114824.HHLDDEYZwtVKBNNJmCcYfWhulkJwZIUAphy-U_J5o9E@z>

This is a multi-part message in MIME format.
--------------22C018EF992FBB461181A202
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Ok,
I attach log from today test on Ubuntu 19.04 with5.0.9-050009-generickernel.
Full kern.log: https://paste.ee/p/yF3Qi#section0
Dmesg log: https://paste.ee/p/yF3Qi#section1

Summary:
- motherboard with AMD A320M chipset, CPU AMD Athlon 200GE
- Ubuntu 19.04 default instalation, kernel 5.0.9-050009-generic
- connected "FTDI FT232R" (USB to serial converter) to USB port, latest 
FTDI libftd2xx drivers version 1.4.8 installed, 
https://www.ftdichip.com/Drivers/D2XX.htm
- ftdi_sio driver is unloaded (rmmod ftdi_sio)
- problem is with reading EEPROM content from FTDI FT232R chip
- problem is on USB2.0 port only, on USB3 port it works fine

starosta

Dne 29.4.2019 v 13:22 Johan Hovold napsal(a):
> On Mon, Apr 29, 2019 at 12:51:20PM +0200, StarostaCZ@gmail.com wrote:
>> Hello,
>> sorry for other questions, but I am new in this list:
>> Is Ubuntu server 19.04 with "kernel 5.0.9-050009-generic" good for this
>> test?
> Yes, that might do depending on what else debian put in that kernel.
>
>> Can I add attachments to this lists?
> Sure, it's even preferred. Just try to trim non-relevant bits, and
> perhaps provide a link to the full log.
>
>> And who is xhci and iommu maintainers? Are they CC in this mail?
> Yes, that's Mathias and Joerg, respectively, that I added on CC.
>
>> Dne 29.4.2019 v 11:48 Johan Hovold napsal(a):
>>> So this is a debian 4.18 kernel seemingly crashing due to a xhci or
>>> iommu issue.
>>>
>>> Can you reproduce this on a mainline kernel?
>>>
>>> If so, please post the corresponding logs to the lists and CC the xhci
>>> and iommu maintainers (added to CC).
> Here's an excerpt from the 4.18 log meanwhile:
>
> [    0.000000] Linux version 4.18.0-0.bpo.1-amd64 (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #1 SMP Debian 4.18.6-1~bpo9+1 (2018-09-13)
>
> ...
>
> [  960.145603] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> [ 1790.293623] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fff50000 flags=0x0020]
> [ 1790.300905] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fde9e000 flags=0x0020]
>
> ...
>
> [ 4789.145364] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> [ 4789.310916] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000ff63c000 flags=0x0020]
> [ 4789.317023] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000ff5c6000 flags=0x0020]
> [ 4789.702446] xhci_hcd 0000:15:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
> [ 4789.766842] xhci_hcd 0000:15:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x00000000fdeaf000 flags=0x0020]
> [ 4789.781531] AMD-Vi: Event logged [IO_PAGE_FAULT device=15:00.0 domain=0x0000 address=0x00000000fdeaf040 flags=0x0020]
> [ 4790.093644] general protection fault: 0000 [#1] SMP NOPTI
> [ 4790.094186] CPU: 2 PID: 24561 Comm: readua Not tainted 4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
> [ 4790.094738] Hardware name: Micro-Star International Co., Ltd MS-7B38/A320M PRO-VD PLUS (MS-7B38), BIOS 1.C0 11/02/2018
> [ 4790.095333] RIP: 0010:prefetch_freepointer+0x10/0x20
> [ 4790.095936] Code: 58 48 c7 c7 30 09 a5 b0 e8 4b 64 eb ff eb 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 74 13 8b 47 20 48 01 c6 <48> 33 36 48 33 b7 38 01 00 00 0f 18 0e f3 c3 90 0f 1f 44 00 00 8b
> [ 4790.097314] RSP: 0018:ffffb6e303e67ce0 EFLAGS: 00010286
> [ 4790.098016] RAX: 0000000000000000 RBX: 93773f762ca13047 RCX: 00000000000077df
> [ 4790.098711] RDX: 00000000000077de RSI: 93773f762ca13047 RDI: ffff9a30de807c00
> [ 4790.099413] RBP: ffff9a30d20cc018 R08: ffff9a30deca4de0 R09: 0000000000000000
> [ 4790.100141] R10: ffff9a306f3c6638 R11: 0000000000000000 R12: 00000000006000c0
> [ 4790.100871] R13: 0000000000000008 R14: ffff9a30de807c00 R15: ffff9a30de807c00
> [ 4790.101619] FS:  0000000000000000(0000) GS:ffff9a30dec80000(0063) knlGS:00000000f7d6a700
> [ 4790.102387] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [ 4790.103157] CR2: 00000000ffc77e3c CR3: 00000000af0c0000 CR4: 00000000003406e0
> [ 4790.103954] Call Trace:
> [ 4790.104753]  kmem_cache_alloc_trace+0xb5/0x1c0
> [ 4790.105580]  ? proc_do_submiturb+0x35a/0xda0 [usbcore]
> [ 4790.106382]  proc_do_submiturb+0x35a/0xda0 [usbcore]
> [ 4790.107189]  ? futex_wake+0x94/0x170
> [ 4790.108009]  proc_submiturb_compat+0xb1/0xe0 [usbcore]
> [ 4790.108851]  usbdev_do_ioctl+0x894/0x1170 [usbcore]
> [ 4790.109704]  usbdev_compat_ioctl+0xc/0x10 [usbcore]
> [ 4790.110553]  __ia32_compat_sys_ioctl+0xc0/0x250
> [ 4790.111413]  do_fast_syscall_32+0x98/0x1e0
> [ 4790.112280]  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
> [ 4790.113167] Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c iptable_filter binfmt_misc nls_ascii nls_cp437 vfat fat efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_codec_realtek snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi snd_hda_intel ghash_clmulni_intel wmi_bmof snd_hda_codec efivars pcspkr snd_hda_core snd_hwdep snd_pcm k10temp snd_timer sg snd soundcore sp5100_tco evdev pcc_cpufreq acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper amdgpu chash gpu_sched
> [ 4790.120417]  i2c_algo_bit i2c_piix4 ttm drm_kms_helper ahci xhci_pci libahci xhci_hcd drm libata r8169 mii usbcore scsi_mod usb_common wmi video gpio_amdpt gpio_generic button
> [ 4790.122857] ---[ end trace bdd21237253335ac ]---
> [ 4791.452933] RIP: 0010:prefetch_freepointer+0x10/0x20
> [ 4791.461318] Code: 58 48 c7 c7 30 09 a5 b0 e8 4b 64 eb ff eb 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 f6 74 13 8b 47 20 48 01 c6 <48> 33 36 48 33 b7 38 01 00 00 0f 18 0e f3 c3 90 0f 1f 44 00 00 8b
> [ 4791.479889] RSP: 0018:ffffb6e303e67ce0 EFLAGS: 00010286
> [ 4791.490112] RAX: 0000000000000000 RBX: 93773f762ca13047 RCX: 00000000000077df
> [ 4791.500551] RDX: 00000000000077de RSI: 93773f762ca13047 RDI: ffff9a30de807c00
> [ 4791.509946] RBP: ffff9a30d20cc018 R08: ffff9a30deca4de0 R09: 0000000000000000
> [ 4791.519575] R10: ffff9a306f3c6638 R11: 0000000000000000 R12: 00000000006000c0
> [ 4791.530038] R13: 0000000000000008 R14: ffff9a30de807c00 R15: ffff9a30de807c00
> [ 4791.541665] FS:  0000000000000000(0000) GS:ffff9a30dec80000(0063) knlGS:00000000f7d6a700
> [ 4791.544526] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [ 4791.546019] CR2: 00000000ffc77e3c CR3: 00000000af0c0000 CR4: 00000000003406e0
>
> Johan


--------------22C018EF992FBB461181A202
Content-Type: text/plain; charset=UTF-8;
 name="excerpt-kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="excerpt-kern.log"

Apr 29 12:39:39 test-ubnt kernel: [    0.000000] Linux version 5.0.9-0500=
09-generic (kernel@kathleen) (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) =
#201904200830 SMP Sat Apr 20 08:32:44 UTC 2019
=2E..
Apr 29 12:42:30 test-ubnt kernel: [  184.230060] usbserial: USB Serial de=
registering driver FTDI USB Serial Device
Apr 29 12:42:30 test-ubnt kernel: [  184.230265] ftdi_sio ttyUSB0: FTDI U=
SB Serial Device converter now disconnected from ttyUSB0
Apr 29 12:42:30 test-ubnt kernel: [  184.230281] usbcore: deregistering i=
nterface driver ftdi_sio
Apr 29 12:42:30 test-ubnt kernel: [  184.230310] ftdi_sio 1-9:1.0: device=
 disconnected
Apr 29 12:42:32 test-ubnt kernel: [  186.736091] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:33 test-ubnt kernel: [  186.908142] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe80b000 flags=3D0=
x0020]
Apr 29 12:42:33 test-ubnt kernel: [  186.910476] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfff0a000 flags=3D0=
x0020]
Apr 29 12:42:33 test-ubnt kernel: [  187.295439] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:33 test-ubnt kernel: [  187.469145] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe995000 flags=3D0=
x0020]
Apr 29 12:42:33 test-ubnt kernel: [  187.469944] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffdae000 flags=3D0=
x0020]
Apr 29 12:42:34 test-ubnt kernel: [  187.854873] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:34 test-ubnt kernel: [  188.027196] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffdbe000 flags=3D0=
x0020]
Apr 29 12:42:34 test-ubnt kernel: [  188.029621] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfc77f000 flags=3D0=
x0020]
Apr 29 12:42:34 test-ubnt kernel: [  188.414536] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:34 test-ubnt kernel: [  188.587169] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffc20000 flags=3D0=
x0070]
Apr 29 12:42:34 test-ubnt kernel: [  188.589694] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe9af000 flags=3D0=
x0020]
Apr 29 12:42:35 test-ubnt kernel: [  188.974027] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:35 test-ubnt kernel: [  189.146304] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffb73000 flags=3D0=
x0020]
Apr 29 12:42:35 test-ubnt kernel: [  189.149188] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xf963e000 flags=3D0=
x0020]
Apr 29 12:42:35 test-ubnt kernel: [  189.533697] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:35 test-ubnt kernel: [  189.706380] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe68f000 flags=3D=
0x0020]
Apr 29 12:42:35 test-ubnt kernel: [  189.708841] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xffb0e000 flags=3D=
0x0020]
Apr 29 12:42:36 test-ubnt kernel: [  190.093821] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:36 test-ubnt kernel: [  190.266544] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xffbd3000 flags=3D=
0x0020]
Apr 29 12:42:36 test-ubnt kernel: [  190.268330] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe9a7000 flags=3D=
0x0020]
Apr 29 12:42:36 test-ubnt kernel: [  190.653335] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:37 test-ubnt kernel: [  190.825548] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe2d1000 flags=3D=
0x0020]
Apr 29 12:42:37 test-ubnt kernel: [  190.827980] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xf9584000 flags=3D=
0x0020]
Apr 29 12:42:37 test-ubnt kernel: [  191.212976] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:37 test-ubnt kernel: [  191.385639] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xf957b000 flags=3D=
0x0020]
Apr 29 12:42:37 test-ubnt kernel: [  191.388194] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xf957d000 flags=3D=
0x0020]
Apr 29 12:42:37 test-ubnt kernel: [  191.772941] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:42:38 test-ubnt kernel: [  191.945695] amd_iommu_report_page_fa=
ult: 8 callbacks suppressed
=2E..
Apr 29 12:51:41 test-ubnt kernel: [  735.067290] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe99b000 flags=3D0=
x0020]
Apr 29 12:51:41 test-ubnt kernel: [  735.069095] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffc4d000 flags=3D0=
x0020]
Apr 29 12:51:41 test-ubnt kernel: [  735.453621] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:41 test-ubnt kernel: [  735.626419] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffc24000 flags=3D0=
x0020]
Apr 29 12:51:41 test-ubnt kernel: [  735.628747] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe2d5000 flags=3D0=
x0020]
Apr 29 12:51:42 test-ubnt kernel: [  736.013655] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:42 test-ubnt kernel: [  736.186434] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xf961b000 flags=3D0=
x0020]
Apr 29 12:51:42 test-ubnt kernel: [  736.188821] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfa016000 flags=3D0=
x0020]
Apr 29 12:51:42 test-ubnt kernel: [  736.573822] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:42 test-ubnt kernel: [  736.746622] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe2d2000 flags=3D0=
x0020]
Apr 29 12:51:43 test-ubnt kernel: [  737.133262] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:43 test-ubnt kernel: [  737.305606] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfff22000 flags=3D0=
x0020]
Apr 29 12:51:43 test-ubnt kernel: [  737.307978] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfc77e000 flags=3D0=
x0020]
Apr 29 12:51:43 test-ubnt kernel: [  737.693013] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:44 test-ubnt kernel: [  737.865686] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xffc50000 flags=3D0=
x0020]
Apr 29 12:51:44 test-ubnt kernel: [  737.868055] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe3f7000 flags=3D=
0x0020]
Apr 29 12:51:44 test-ubnt kernel: [  738.252398] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:44 test-ubnt kernel: [  738.424709] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe9a3000 flags=3D=
0x0020]
Apr 29 12:51:44 test-ubnt kernel: [  738.427524] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xffda9000 flags=3D=
0x0020]
Apr 29 12:51:44 test-ubnt kernel: [  738.812021] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:45 test-ubnt kernel: [  738.984861] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xffb1c000 flags=3D=
0x0020]
Apr 29 12:51:45 test-ubnt kernel: [  738.987200] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe2bb000 flags=3D=
0x0020]
Apr 29 12:51:45 test-ubnt kernel: [  739.372120] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:45 test-ubnt kernel: [  739.544897] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xf93d5000 flags=3D=
0x0020]
Apr 29 12:51:45 test-ubnt kernel: [  739.547272] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfe9bb000 flags=3D=
0x0020]
Apr 29 12:51:46 test-ubnt kernel: [  739.931640] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:46 test-ubnt kernel: [  740.004937] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfff31000 flags=3D=
0x0020]
Apr 29 12:51:46 test-ubnt kernel: [  740.010755] AMD-Vi: Event logged [IO=
_PAGE_FAULT device=3D01:00.0 domain=3D0x0000 address=3D0xfa016000 flags=3D=
0x0020]
Apr 29 12:51:46 test-ubnt kernel: [  740.395707] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:46 test-ubnt kernel: [  740.569013] amd_iommu_report_page_fa=
ult: 9 callbacks suppressed
Apr 29 12:51:46 test-ubnt kernel: [  740.569018] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xf967d000 flags=3D0=
x0020]
Apr 29 12:51:46 test-ubnt kernel: [  740.570406] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe67e000 flags=3D0=
x0020]
Apr 29 12:51:47 test-ubnt kernel: [  740.955326] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:47 test-ubnt kernel: [  741.128009] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe9b3000 flags=3D0=
x0020]
Apr 29 12:51:47 test-ubnt kernel: [  741.130463] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xf93d5000 flags=3D0=
x0020]
Apr 29 12:51:47 test-ubnt kernel: [  741.515382] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:47 test-ubnt kernel: [  741.688177] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe2ab000 flags=3D0=
x0020]
Apr 29 12:51:47 test-ubnt kernel: [  741.689972] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe999000 flags=3D0=
x0020]
Apr 29 12:51:48 test-ubnt kernel: [  742.074489] xhci_hcd 0000:01:00.0: W=
ARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
Apr 29 12:51:48 test-ubnt kernel: [  742.249652] xhci_hcd 0000:01:00.0: E=
vent logged [IO_PAGE_FAULT domain=3D0x0000 address=3D0xfe2c5000 flags=3D0=
x0020]
Apr 29 12:51:48 test-ubnt kernel: [  742.592126] ------------[ cut here ]=
------------
Apr 29 12:51:48 test-ubnt kernel: [  742.592129] kernel BUG at mm/slub.c:=
3955!
Apr 29 12:51:48 test-ubnt kernel: [  742.593844] invalid opcode: 0000 [#1=
] SMP NOPTI
Apr 29 12:51:48 test-ubnt kernel: [  742.595550] CPU: 0 PID: 7254 Comm: r=
eadua Not tainted 5.0.9-050009-generic #201904200830
Apr 29 12:51:48 test-ubnt kernel: [  742.597220] Hardware name: System ma=
nufacturer System Product Name/PRIME A320M-K, BIOS 4602 03/07/2019
Apr 29 12:51:48 test-ubnt kernel: [  742.598923] RIP: 0010:kfree+0x16e/0x=
180
Apr 29 12:51:48 test-ubnt kernel: [  742.600587] Code: e8 f7 bf f8 ff eb =
8b 41 b8 01 00 00 00 48 89 d9 48 89 da 4c 89 d6 e8 11 f6 ff ff e9 72 ff f=
f ff 0f 0b 49 8b 42 08 a8 01 75 c2 <0f> 0b 48 8b 3d a9 a3 39 01 e9 c5 fe =
ff ff 0f 1f 40 00 0f 1f 44 00
Apr 29 12:51:48 test-ubnt kernel: [  742.604117] RSP: 0018:ffffb8824be07d=
f0 EFLAGS: 00010246
Apr 29 12:51:48 test-ubnt kernel: [  742.605879] RAX: dead000000000100 RB=
X: ffff9f0a18ab97b0 RCX: ffff9f0a10999080
Apr 29 12:51:48 test-ubnt kernel: [  742.607661] RDX: 0000000000000000 RS=
I: ffff9f0a18ab97b2 RDI: 000060f680000000
Apr 29 12:51:48 test-ubnt kernel: [  742.609410] RBP: ffffb8824be07e08 R0=
8: 0000000000000001 R09: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.611174] R10: ffffe24c4462ae40 R1=
1: 000000000000000d R12: ffff9f0a0bd2c900
Apr 29 12:51:48 test-ubnt kernel: [  742.612959] R13: ffffffffa438875c R1=
4: ffff9f0a0a445f90 R15: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.614708] FS:  0000000000000000(00=
00) GS:ffff9f0a1ae00000(0063) knlGS:00000000f7513b40
Apr 29 12:51:48 test-ubnt kernel: [  742.616446] CS:  0010 DS: 002b ES: 0=
02b CR0: 0000000080050033
Apr 29 12:51:48 test-ubnt kernel: [  742.618197] CR2: 00000000f6c00008 CR=
3: 000000010bfe2000 CR4: 00000000003406f0
Apr 29 12:51:48 test-ubnt kernel: [  742.619973] Call Trace:
Apr 29 12:51:48 test-ubnt kernel: [  742.621725]  free_async+0xec/0x100
Apr 29 12:51:48 test-ubnt kernel: [  742.623474]  usbdev_do_ioctl+0x117/0=
x1100
Apr 29 12:51:48 test-ubnt kernel: [  742.625193]  usbdev_compat_ioctl+0x1=
0/0x20
Apr 29 12:51:48 test-ubnt kernel: [  742.626918]  __ia32_compat_sys_ioctl=
+0x13d/0x230
Apr 29 12:51:48 test-ubnt kernel: [  742.628661]  ? __ia32_sys_poll+0xa3/=
0x140
Apr 29 12:51:48 test-ubnt kernel: [  742.630360]  do_fast_syscall_32+0x9b=
/0x210
Apr 29 12:51:48 test-ubnt kernel: [  742.632048]  entry_SYSCALL_compat_af=
ter_hwframe+0x45/0x4d
Apr 29 12:51:48 test-ubnt kernel: [  742.633711] RIP: 0023:0xf7f6a939
Apr 29 12:51:48 test-ubnt kernel: [  742.635379] Code: 85 d2 74 02 89 0a =
5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 34 24 c3 8b 3c 24 c3 90 90 90 90 90 9=
0 90 90 51 52 55 89 cd 0f 05 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 =
00 00 00 8d b4 26 00 00 00 00
Apr 29 12:51:48 test-ubnt kernel: [  742.638890] RSP: 002b:00000000f75131=
c8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
Apr 29 12:51:48 test-ubnt kernel: [  742.640668] RAX: ffffffffffffffda RB=
X: 0000000000000008 RCX: 000000004004550d
Apr 29 12:51:48 test-ubnt kernel: [  742.642425] RDX: 00000000f751320c RS=
I: 0000000000000001 RDI: 00000000f7f1e000
Apr 29 12:51:48 test-ubnt kernel: [  742.644201] RBP: 00000000f7513228 R0=
8: 0000000000000000 R09: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.645970] R10: 0000000000000000 R1=
1: 0000000000000000 R12: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.647697] R13: 0000000000000000 R1=
4: 0000000000000000 R15: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.649426] Modules linked in: nls_i=
so8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua edac_mce_amd =
ccp kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek snd=
_hda_codec_generic ghash_clmulni_intel ledtrig_audio snd_hda_codec_hdmi s=
nd_hda_intel snd_hda_codec snd_hda_core eeepc_wmi snd_hwdep asus_wmi snd_=
pcm sparse_keymap wmi_bmof joydev k10temp input_leds snd_timer snd soundc=
ore usbserial mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core is=
csi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables aut=
ofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy as=
ync_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath li=
near hid_generic usbhid hid amdgpu chash aesni_intel amd_iommu_v2 gpu_sch=
ed i2c_algo_bit ttm aes_x86_64 drm_kms_helper crypto_simd cryptd glue_hel=
per syscopyarea sysfillrect sysimgblt i2c_piix4 fb_sys_fops r8169 ahci dr=
m realtek libahci wmi video gpio_amdpt gpio_generic [last unloaded: ftdi_=
sio]
Apr 29 12:51:48 test-ubnt kernel: [  742.662927] ---[ end trace a4090e5de=
93b0c0a ]---
Apr 29 12:51:48 test-ubnt kernel: [  742.665363] RIP: 0010:kfree+0x16e/0x=
180
Apr 29 12:51:48 test-ubnt kernel: [  742.667359] Code: e8 f7 bf f8 ff eb =
8b 41 b8 01 00 00 00 48 89 d9 48 89 da 4c 89 d6 e8 11 f6 ff ff e9 72 ff f=
f ff 0f 0b 49 8b 42 08 a8 01 75 c2 <0f> 0b 48 8b 3d a9 a3 39 01 e9 c5 fe =
ff ff 0f 1f 40 00 0f 1f 44 00
Apr 29 12:51:48 test-ubnt kernel: [  742.671526] RSP: 0018:ffffb8824be07d=
f0 EFLAGS: 00010246
Apr 29 12:51:48 test-ubnt kernel: [  742.673718] RAX: dead000000000100 RB=
X: ffff9f0a18ab97b0 RCX: ffff9f0a10999080
Apr 29 12:51:48 test-ubnt kernel: [  742.675852] RDX: 0000000000000000 RS=
I: ffff9f0a18ab97b2 RDI: 000060f680000000
Apr 29 12:51:48 test-ubnt kernel: [  742.677942] RBP: ffffb8824be07e08 R0=
8: 0000000000000001 R09: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.680072] R10: ffffe24c4462ae40 R1=
1: 000000000000000d R12: ffff9f0a0bd2c900
Apr 29 12:51:48 test-ubnt kernel: [  742.682160] R13: ffffffffa438875c R1=
4: ffff9f0a0a445f90 R15: 0000000000000000
Apr 29 12:51:48 test-ubnt kernel: [  742.684297] FS:  0000000000000000(00=
00) GS:ffff9f0a1ae00000(0063) knlGS:00000000f7513b40
Apr 29 12:51:48 test-ubnt kernel: [  742.686432] CS:  0010 DS: 002b ES: 0=
02b CR0: 0000000080050033
Apr 29 12:51:48 test-ubnt kernel: [  742.688533] CR2: 00000000f6c00008 CR=
3: 000000010bfe2000 CR4: 00000000003406f0
Apr 29 12:52:57 test-ubnt kernel: [  810.994316] general protection fault=
: 0000 [#2] SMP NOPTI
Apr 29 12:52:57 test-ubnt kernel: [  810.996043] CPU: 1 PID: 7275 Comm: s=
nap Tainted: G      D           5.0.9-050009-generic #201904200830
Apr 29 12:52:57 test-ubnt kernel: [  810.997671] Hardware name: System ma=
nufacturer System Product Name/PRIME A320M-K, BIOS 4602 03/07/2019
Apr 29 12:52:57 test-ubnt kernel: [  810.999199] RIP: 0010:__kmalloc_node=
+0x18f/0x2b0
Apr 29 12:52:57 test-ubnt kernel: [  811.000687] Code: 46 0b 04 0f 84 07 =
ff ff ff 4c 89 f7 e8 aa e3 01 00 49 89 c1 e9 f7 fe ff ff 41 8b 59 20 49 8=
b 39 48 8d 4a 01 4c 89 f8 4c 01 fb <48> 33 1b 49 33 99 38 01 00 00 65 48 =
0f c7 0f 0f 94 c0 84 c0 0f 84
Apr 29 12:52:57 test-ubnt kernel: [  811.003780] RSP: 0018:ffffb8824be4fa=
b0 EFLAGS: 00010202
Apr 29 12:52:57 test-ubnt kernel: [  811.005329] RAX: 477a9f9cb590bccd RB=
X: 477a9f9cb590bccd RCX: 000000000001519c
Apr 29 12:52:57 test-ubnt kernel: [  811.006899] RDX: 000000000001519b RS=
I: 0000000000480020 RDI: 0000000000027040
Apr 29 12:52:57 test-ubnt kernel: [  811.008448] RBP: ffffb8824be4fae8 R0=
8: ffff9f0a1ae67040 R09: ffff9f0a1a807c00
Apr 29 12:52:57 test-ubnt kernel: [  811.009991] R10: ffff9f0a1a827fa0 R1=
1: 0000000000000000 R12: 0000000000480020
Apr 29 12:52:57 test-ubnt kernel: [  811.012240] R13: 0000000000000008 R1=
4: ffff9f0a1a807c00 R15: 477a9f9cb590bccd
Apr 29 12:52:57 test-ubnt kernel: [  811.014464] FS:  00007fd5cb7fe700(00=
00) GS:ffff9f0a1ae40000(0000) knlGS:0000000000000000
Apr 29 12:52:57 test-ubnt kernel: [  811.016698] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033
Apr 29 12:52:57 test-ubnt kernel: [  811.018911] CR2: 00007fd5bc000010 CR=
3: 000000007340e000 CR4: 00000000003406e0
Apr 29 12:52:57 test-ubnt kernel: [  811.021105] Call Trace:
Apr 29 12:52:57 test-ubnt kernel: [  811.023259]  ? alloc_cpumask_var_nod=
e+0x1f/0x30
Apr 29 12:52:57 test-ubnt kernel: [  811.025377]  ? flush_tlb_func_common=
=2Econstprop.9+0x230/0x230
Apr 29 12:52:57 test-ubnt kernel: [  811.027503]  alloc_cpumask_var_node+=
0x1f/0x30
Apr 29 12:52:57 test-ubnt kernel: [  811.029606]  alloc_cpumask_var+0xe/0=
x10
Apr 29 12:52:57 test-ubnt kernel: [  811.031705]  native_send_call_func_i=
pi+0x2e/0x120
Apr 29 12:52:57 test-ubnt kernel: [  811.033805]  smp_call_function_many+=
0x1b0/0x250
Apr 29 12:52:57 test-ubnt kernel: [  811.035898]  native_flush_tlb_others=
+0x48/0x130
Apr 29 12:52:57 test-ubnt kernel: [  811.037985]  flush_tlb_mm_range+0xec=
/0x120
Apr 29 12:52:57 test-ubnt kernel: [  811.040051]  tlb_flush_mmu+0x71/0x10=
0
Apr 29 12:52:57 test-ubnt kernel: [  811.042106]  arch_tlb_finish_mmu+0x1=
b/0xb0
Apr 29 12:52:57 test-ubnt kernel: [  811.044141]  tlb_finish_mmu+0x23/0x3=
0
Apr 29 12:52:57 test-ubnt kernel: [  811.046160]  exit_mmap+0xde/0x190
Apr 29 12:52:57 test-ubnt kernel: [  811.048177]  mmput+0x57/0x130
Apr 29 12:52:57 test-ubnt kernel: [  811.050199]  do_exit+0x288/0xb30
Apr 29 12:52:57 test-ubnt kernel: [  811.052211]  ? mem_cgroup_try_charge=
+0x8b/0x190
Apr 29 12:52:57 test-ubnt kernel: [  811.054235]  do_group_exit+0x43/0xb0=

Apr 29 12:52:57 test-ubnt kernel: [  811.056251]  get_signal+0x12e/0x6d0
Apr 29 12:52:57 test-ubnt kernel: [  811.058273]  do_signal+0x34/0x710
Apr 29 12:52:57 test-ubnt kernel: [  811.060275]  ? recalc_sigpending+0x1=
b/0x50
Apr 29 12:52:57 test-ubnt kernel: [  811.062277]  ? __x64_sys_futex+0x143=
/0x180
Apr 29 12:52:57 test-ubnt kernel: [  811.064235]  exit_to_usermode_loop+0=
x8e/0x100
Apr 29 12:52:57 test-ubnt kernel: [  811.066151]  do_syscall_64+0xda/0x11=
0
Apr 29 12:52:57 test-ubnt kernel: [  811.068044]  entry_SYSCALL_64_after_=
hwframe+0x44/0xa9
Apr 29 12:52:57 test-ubnt kernel: [  811.069940] RIP: 0033:0x55c38e2d4383=

Apr 29 12:52:57 test-ubnt kernel: [  811.071827] Code: Bad RIP value.
Apr 29 12:52:57 test-ubnt kernel: [  811.073712] RSP: 002b:00007fd5cb7fdd=
a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000ca
Apr 29 12:52:57 test-ubnt kernel: [  811.075646] RAX: fffffffffffffe00 RB=
X: 000000c420045000 RCX: 000055c38e2d4383
Apr 29 12:52:57 test-ubnt kernel: [  811.077628] RDX: 0000000000000000 RS=
I: 0000000000000000 RDI: 000055c38ecb8098
Apr 29 12:52:57 test-ubnt kernel: [  811.079545] RBP: 00007fd5cb7fddf0 R0=
8: 0000000000000000 R09: 0000000000000000
Apr 29 12:52:57 test-ubnt kernel: [  811.081400] R10: 0000000000000000 R1=
1: 0000000000000286 R12: 00007ffe68ebdb7e
Apr 29 12:52:57 test-ubnt kernel: [  811.083218] R13: 00007ffe68ebdb7f R1=
4: 00007ffe68ebdc80 R15: 00007fd5cb7fdfc0
Apr 29 12:52:57 test-ubnt kernel: [  811.084978] Modules linked in: nls_i=
so8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua edac_mce_amd =
ccp kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek snd=
_hda_codec_generic ghash_clmulni_intel ledtrig_audio snd_hda_codec_hdmi s=
nd_hda_intel snd_hda_codec snd_hda_core eeepc_wmi snd_hwdep asus_wmi snd_=
pcm sparse_keymap wmi_bmof joydev k10temp input_leds snd_timer snd soundc=
ore usbserial mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core is=
csi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables aut=
ofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy as=
ync_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath li=
near hid_generic usbhid hid amdgpu chash aesni_intel amd_iommu_v2 gpu_sch=
ed i2c_algo_bit ttm aes_x86_64 drm_kms_helper crypto_simd cryptd glue_hel=
per syscopyarea sysfillrect sysimgblt i2c_piix4 fb_sys_fops r8169 ahci dr=
m realtek libahci wmi video gpio_amdpt gpio_generic [last unloaded: ftdi_=
sio]
Apr 29 12:52:57 test-ubnt kernel: [  811.097944] ---[ end trace a4090e5de=
93b0c0b ]---
Apr 29 12:52:57 test-ubnt kernel: [  811.100472] RIP: 0010:kfree+0x16e/0x=
180
Apr 29 12:52:57 test-ubnt kernel: [  811.102334] Code: e8 f7 bf f8 ff eb =
8b 41 b8 01 00 00 00 48 89 d9 48 89 da 4c 89 d6 e8 11 f6 ff ff e9 72 ff f=
f ff 0f 0b 49 8b 42 08 a8 01 75 c2 <0f> 0b 48 8b 3d a9 a3 39 01 e9 c5 fe =
ff ff 0f 1f 40 00 0f 1f 44 00
Apr 29 12:52:57 test-ubnt kernel: [  811.106243] RSP: 0018:ffffb8824be07d=
f0 EFLAGS: 00010246
Apr 29 12:52:57 test-ubnt kernel: [  811.108200] RAX: dead000000000100 RB=
X: ffff9f0a18ab97b0 RCX: ffff9f0a10999080
Apr 29 12:52:57 test-ubnt kernel: [  811.110167] RDX: 0000000000000000 RS=
I: ffff9f0a18ab97b2 RDI: 000060f680000000
Apr 29 12:52:57 test-ubnt kernel: [  811.112132] RBP: ffffb8824be07e08 R0=
8: 0000000000000001 R09: 0000000000000000
Apr 29 12:52:57 test-ubnt kernel: [  811.114067] R10: ffffe24c4462ae40 R1=
1: 000000000000000d R12: ffff9f0a0bd2c900
Apr 29 12:52:57 test-ubnt kernel: [  811.116011] R13: ffffffffa438875c R1=
4: ffff9f0a0a445f90 R15: 0000000000000000
Apr 29 12:52:57 test-ubnt kernel: [  811.117931] FS:  00007fd5cb7fe700(00=
00) GS:ffff9f0a1ae40000(0000) knlGS:0000000000000000
Apr 29 12:52:57 test-ubnt kernel: [  811.119869] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033
Apr 29 12:52:57 test-ubnt kernel: [  811.121774] CR2: 000055c38e2d4359 CR=
3: 000000007340e000 CR4: 00000000003406e0
Apr 29 12:52:57 test-ubnt kernel: [  811.123701] Fixing recursive fault b=
ut reboot is needed!

--------------22C018EF992FBB461181A202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------22C018EF992FBB461181A202--
