Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBC2C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 15:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8421141299;
	Tue, 25 Jan 2022 15:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNEAegRQKjD8; Tue, 25 Jan 2022 15:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 498B0410C8;
	Tue, 25 Jan 2022 15:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 019D1C0039;
	Tue, 25 Jan 2022 15:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E17CC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 15:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B23281284
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 15:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=fireburn-co-uk.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nrvRhpX2aM3S for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 15:08:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B426481255
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 15:08:36 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id c2so25597876wml.1
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c0h+YN3WZ8oQh9kE3wDALdghjswXTmmA4zejnT27K50=;
 b=BxF2jD/gwk5n+uxdwkibC69S3bbAdsUYjb60OvC0MGZcwMR0slys4RJ3ITONTZE0l7
 G9QVEKMqefxo+drC29/13e7+CTE/hHnizaLW2Mg7UVAq04ND+p7LfHcS5Ku/x666oHPT
 LGd7IhyOrHX4supz9d8B7lufphNH7CItAEH0ttPMx78+FwOjbh5Iamo/5RTq9xTpiHVB
 epOCjA/OSBtkMWzq89PV+dH4JXMuzn72v/iFxquM2HXgj/m6SFMqNfWMQgxLv148N6k+
 OQ7CPh3Th+FZ8SXNZCs5yUEpgvWyKWICGUmsZYwCwrysbLg6O34IVQWU63M5oxKFewwO
 7UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c0h+YN3WZ8oQh9kE3wDALdghjswXTmmA4zejnT27K50=;
 b=UhU38QhvwKFUaP+WmZfDuaCYwyK/ycl0Lwf1kz2B8PJmJn1TNWV9guiAfIX+ziEHzs
 zYiMaDwmaGGtURQx2ua/X9QYHfWOAepOyL3wi5DjgkX8tFVhbBAXalYUr9qg/AcjL7eh
 zaK/JrrnKXiBu0wmhw9e+UmS7yc24iWckw3/bdoHaXdzL1W7TSlJqfD9tlcXW4qJC0zj
 Tv3jvxsSs18VCRBQrMGlwlFAEEaKnqvD8/Oxolcf6pFLrY7yIoHK1WkthEov1zdG1svU
 oeIvrqvccQdh6KRZTKA9hNHyUJJa6U2BWcx64zhgaRLN3NKD6F1dfchaiS7zLyW+uE4Y
 6vsw==
X-Gm-Message-State: AOAM531+PblMBwBgBUYO0KF621Rfj2e2PhuaV3NCKOmR00DOF6V4x57G
 5FLBovD9A9/7T3z6FAsVK5u7Ew==
X-Google-Smtp-Source: ABdhPJzQ0CBgzIskgvTyEcBm/E90Y3KutqvpAUmc5uI1NwV1BBCRTek9m7YPaA7cG+qCyIhTn9Spmw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr3407619wmc.33.1643123314267;
 Tue, 25 Jan 2022 07:08:34 -0800 (PST)
Received: from axion.fireburn.co.uk.lan ([2a01:4b00:f40e:900::64c])
 by smtp.gmail.com with ESMTPSA id r8sm17334224wrx.2.2022.01.25.07.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 07:08:33 -0800 (PST)
From: Mike Lothian <mike@fireburn.co.uk>
To: mlevitsk@redhat.com
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Date: Tue, 25 Jan 2022 15:08:32 +0000
Message-Id: <20220125150832.1570-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 25 Jan 2022 15:24:51 +0000
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, will@kernel.org, dwmw@amazon.co.uk
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

Hi

I'm seeing a WARNING that I think might be related to these patches, unfortunately another issue is making bisecting difficult

[    0.359362] AMD-Vi: X2APIC enabled
[    0.395140] ------------[ cut here ]------------
[    0.395142] WARNING: CPU: 0 PID: 1 at amd_iommu_enable_interrupts+0x1da/0x440
[    0.395146] Modules linked in:
[    0.395148] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc1-tip+ #2995
[    0.395150] Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
[    0.395152] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
[    0.395154] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00 48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[    0.395157] RSP: 0018:ffff88810022fc68 EFLAGS: 00010246
[    0.395158] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
[    0.395160] RDX: 0000000000000008 RSI: ffff88810022fc70 RDI: ffffc900000800f0
[    0.395161] RBP: ffff88810022fc68 R08: ffff888100fce088 R09: 0000000000000000
[    0.395162] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
[    0.395163] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357c9e8
[    0.395165] FS:  0000000000000000(0000) GS:ffff888fde400000(0000) knlGS:0000000000000000
[    0.395166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.395167] CR2: ffff88901e1ff000 CR3: 00000000b440c000 CR4: 0000000000150ef0
[    0.395169] Call Trace:
[    0.395170]  <TASK>
[    0.395171]  ? iommu_setup+0x29a/0x29a
[    0.395174]  ? state_next+0x6e/0x1c9
[    0.395177]  ? iommu_setup+0x29a/0x29a
[    0.395178]  ? iommu_go_to_state+0x1f/0x33
[    0.395180]  ? amd_iommu_init+0xa/0x23
[    0.395182]  ? pci_iommu_init+0xf/0x45
[    0.395183]  ? iommu_setup+0x29a/0x29a
[    0.395184]  ? __initstub__kmod_pci_dma__250_136_pci_iommu_initrootfs+0x5/0x8
[    0.395186]  ? do_one_initcall+0x100/0x290
[    0.395190]  ? do_initcall_level+0x8b/0xe5
[    0.395192]  ? do_initcalls+0x44/0x6d
[    0.395194]  ? kernel_init_freeable+0xc7/0x10d
[    0.395196]  ? rest_init+0xc0/0xc0
[    0.395198]  ? kernel_init+0x11/0x150
[    0.395200]  ? ret_from_fork+0x22/0x30
[    0.395201]  </TASK>
[    0.395202] ---[ end trace 0000000000000000 ]---
[    0.395204] PCI-DMA: Using software bounce buffer

Let me know if you need any more info

Cheers

Mike
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
