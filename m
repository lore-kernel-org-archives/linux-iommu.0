Return-Path: <SRS0=ghm9=GH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42802C433E0
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 13:23:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CE4207AE
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 13:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CE4207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FC76870EA;
	Mon,  4 Jan 2021 13:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cNGE-TmD4Wm3; Mon,  4 Jan 2021 13:22:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E23F870DA;
	Mon,  4 Jan 2021 13:22:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 425D9C088B;
	Mon,  4 Jan 2021 13:22:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68435C013A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 13:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64068870DE
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 13:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIpCq6XsMsys for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 13:22:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B21B4870DA
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 13:22:55 +0000 (UTC)
Received: from zn.tnic (p200300ec2f086c006c90644a80fcf254.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:6c00:6c90:644a:80fc:f254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F77E1EC0266;
 Mon,  4 Jan 2021 14:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1609766572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5aMDYEhg0iQJyu7ZP/KCHJxaFG/SF630Fwsw9CP5ksc=;
 b=kyahIasVCRXi9v1kldpTmMxYlpKcYUFRL7j4Zn1tpPRQlhEmUYAe9ZFnZekn4cWowlmFDg
 LT05bi8r/lAAoLLucy87w5doI+3zXtLDXX7rTvtsyTfTHD926KvEKQJ5yfIuhZqR+Ebabd
 DfhDMjSh/YYPZb+Q/+Gc8OMFnTMcmD0=
Date: Mon, 4 Jan 2021 14:22:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: iommu@lists.linux-foundation.org
Subject: Interrupts enabled after amd_iommu_resume+0x0/0x40
Message-ID: <20210104132250.GE32151@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

Hi folks,

syscore_resume() doesn't like when the AMD iommu driver enables
interrupts in its ->resume hook when I resume the box from suspend to
RAM.

All kinds of warnings get triggered too:

[   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
[   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
[   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
[   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
[   17.386830] WARNING: CPU: 0 PID: 1576 at drivers/base/syscore.c:103 syscore_resume+0x12d/0x160

but when I comment out the

	amd_iommu_enable_interrupts()

call in the resume hook, all is fine and quiet and box resumes.

I'll try to bisect later to try to pinpoint it better because I don't
see what recent change would've caused this. But someone might have a
better idea so CC the usual suspects.

Thx.

[   17.386830] ------------[ cut here ]------------
[   17.386830] Interrupts enabled after amd_iommu_resume+0x0/0x40
[   17.386830] WARNING: CPU: 0 PID: 1576 at drivers/base/syscore.c:103 syscore_resume+0x12d/0x160
[   17.386830] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd mac80211 edac_core kvm_amd libarc4 kvm irqbypass
 crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek crc32c_intel iwlwifi ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_h
dmi snd_hda_intel snd_intel_dspcfg snd_hda_codec rtsx_pci_sdmmc aesni_intel snd_hwdep mmc_core glue_helper wmi_bmof snd_hda_core libaes cr
ypto_simd snd_pcm sp5100_tco cryptd nvram watchdog cfg80211 efi_pstore k10temp ledtrig_audio snd_timer ucsi_acpi rapl pcspkr rtsx_pci i2c_
piix4 ccp r8169 gpu_sched mfd_core typec_ucsi snd typec wmi soundcore battery ac video i2c_multi_instantiate acpi_cpufreq i2c_scmi button 
psmouse serio_raw nvme nvme_core
[   17.386830] CPU: 0 PID: 1576 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #2
[   17.386830] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   17.386830] RIP: 0010:syscore_resume+0x12d/0x160
[   17.386830] Code: ff ff ff 80 3d f7 73 fb 00 00 0f 1f 00 0f 85 3b ff ff ff 48 8b 73 18 48 c7 c7 05 4f 15 82 c6 05 dc 73 fb 00 01 e8 41 
2c 2e 00 <0f> 0b e9 1d ff ff ff 80 3d ca 73 fb 00 00 0f 85 d5 fe ff ff 48 c7
[   17.386830] RSP: 0018:ffffc9000171bdd0 EFLAGS: 00010286
[   17.386830] RAX: 0000000000000000 RBX: ffffffff82539960 RCX: 0000000000000000
[   17.386830] RDX: 0000000000000001 RSI: 00000000fff7ffff RDI: 00000000ffffffff
[   17.386830] RBP: 0000000000000003 R08: 0000000000000000 R09: ffffc9000171bc08
[   17.386830] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   17.386830] R13: 0000000000000000 R14: ffffc9000171bde8 R15: 0000000000000000
[   17.386830] FS:  00007fc7e51da740(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   17.386830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.386830] CR2: 000055bbb352a798 CR3: 0000000172639000 CR4: 0000000000350ef0
[   17.386830] Call Trace:
[   17.386830]  suspend_devices_and_enter+0x6d4/0x810
[   17.386830]  pm_suspend.cold+0x322/0x37b
[   17.386830]  state_store+0x8b/0x100
[   17.386830]  kernfs_fop_write+0xe5/0x1d0
[   17.386830]  vfs_write+0xf0/0x2c0
[   17.386830]  ksys_write+0x70/0x100
[   17.386830]  ? fpregs_assert_state_consistent+0x1e/0x50
[   17.386830]  do_syscall_64+0x33/0x80
[   17.386830]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   17.386830] RIP: 0033:0x7fc7e52cbed3
[   17.386830] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   17.386830] RSP: 002b:00007fffa7f50878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   17.386830] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc7e52cbed3
[   17.386830] RDX: 0000000000000004 RSI: 0000563349f39a40 RDI: 0000000000000001
[   17.386830] RBP: 0000563349f39a40 R08: 000000000000000a R09: 0000000000000003
[   17.386830] R10: 0000563349f4f7f0 R11: 0000000000000246 R12: 0000000000000004
[   17.386830] R13: 00007fc7e539c6a0 R14: 0000000000000004 R15: 00007fc7e539c8a0
[   17.386830] ---[ end trace b6887b5ff5d2a76e ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
