Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DE4C5AC75
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 23:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CFB582A2E;
	Tue, 25 Jan 2022 23:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0rqPgUoMnCk; Tue, 25 Jan 2022 23:26:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B82A8278F;
	Tue, 25 Jan 2022 23:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 278C5C0039;
	Tue, 25 Jan 2022 23:26:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53EDBC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 23:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32BED415C5
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 23:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=fireburn-co-uk.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5opuUGYqP3u for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 23:26:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 383CE41587
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 23:26:02 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id c189so490691qkg.11
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OtjwrHzHKc3fn1SCrPZVpYq+Iid29e/g6FtA1ayaA7k=;
 b=b170mgh3N0fycSDKllLnagA7uZiFV1ByNqPRcx7HzHNwPLvt1x7pWMRwp6YRhIWQCx
 IbtEpge+Bjps4hk0XDHtFUU5WDThe/FibD3FCO9SCUXPYy+P1U/qFk7v731gLPsw2hP5
 PwsMwthyBC/OIsFQ7MlY0wbjRP7o2Ooy/vcO4sysKvSgrwgpBoYnVO6T3KZ6dqWX6fGl
 VLRWH7kF06z+70YporpdXJtlDU3UKZV+5bw+q/klbZj38G0taoZTp9K3miGwOPHV3/LH
 QaVWCrcWjX0AMgnh2hHR4fg974ZoGWKP/jmsCD31KyPOx+b15LxdJJ7bFcEAh4qtkFrm
 lJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OtjwrHzHKc3fn1SCrPZVpYq+Iid29e/g6FtA1ayaA7k=;
 b=mauJpH7yk2UGl4FP2yH4SG2CLlHBE1UDz6ykxEs4CZkaMieKlwvUaahVl2G/ZhYI9r
 /Ia207hdiFwCabzqujl99CkLrXsXHiK1YlrARZaqxEQm9ruM1tdNyG8oEbN3xYzNpEcA
 N9vvZTrPZOWUwca7f9v65dRiNUixjs/gK7jp7lHyw0f2OYk/bfCLIY0zwakOonYsu/dX
 cgd/2m6QjjShLgUXE2Dd01p1gEcN7iXHebl+FGiW19Sk0bEYOJ521wfz586uYnEkWcSq
 1NFxR2ygIT6WPve5VJMpu1G+jKGTVm+FnnCWxIMw4FZrqgeE1FCA4taEP9fhHEHrBl+M
 0vQQ==
X-Gm-Message-State: AOAM5311w8iXg/B6Fg14yUPPtQOywgSB1iJZL3XRqobN1WKfLMrTf7BM
 zxL96KxCTUYWvn1HdTGtzwh51tQbj0wD3hjSRHjm5Q==
X-Google-Smtp-Source: ABdhPJyBhSX1/M6deA0wEdudlzi7ThWo8x8JdXkbLDRYT/wBcaBFSP+fV9CMd5Jz/cdebAYvMSuH89CLcQ0VVgyAvtA=
X-Received: by 2002:a05:620a:1474:: with SMTP id
 j20mr8588947qkl.77.1643153161668; 
 Tue, 25 Jan 2022 15:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com>
 <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
In-Reply-To: <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 25 Jan 2022 23:25:50 +0000
Message-ID: <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To: Maxim Levitsky <mlevitsk@redhat.com>
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

On Tue, 25 Jan 2022 at 19:26, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Could you just apply these patches on top of 5.15 kernel and see if you get the warning?
>
> If something could case it is I think patch 1, it does move the GA log enabled
> to be a bit later.
> I also added few warnings there. I wonder why your dmesg quote doesn't contain the C line
> where the warning happens.
>
> In partucular I added:
>
> if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
>
> That will fire if GA log is already running (maybe BIOS enabled it? - it really shouldn't do that)
>
>
> And that:
>
> if (WARN_ON(i >= LOOP_TIMEOUT))
>
> also should not happen and worth to be logged IMHO.
>
> Best regards,
>         Maxim Levitsky
>

Hi

I applied on top of another kernel as you asked, I also enabled some debugging

[    0.398833] ------------[ cut here ]------------
[    0.398835] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:839
amd_iommu_enable_interrupts+0x1da/0x440
[    0.398840] Modules linked in:
[    0.398841] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc5-agd5f+ #1388
[    0.398843] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
[    0.398845] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
[    0.398847] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00
48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff
c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
0
0 00
[    0.398850] RSP: 0018:ffff888100927c68 EFLAGS: 00010246
[    0.398851] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
[    0.398853] RDX: 0000000000000008 RSI: ffff888100927c70 RDI: ffffc900000800f0
[    0.398854] RBP: ffff888100927c68 R08: ffff8881015b8f88 R09: 0000000000000000
[    0.398855] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
[    0.398856] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357a758
[    0.398858] FS:  0000000000000000(0000) GS:ffff888fde400000(0000)
knlGS:0000000000000000
[    0.398859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.398860] CR2: 0000000000000000 CR3: 00000000ac40c000 CR4: 0000000000150ef0
[    0.398862] Call Trace:
[    0.398864]  <TASK>
[    0.398864]  ? iommu_setup+0x29a/0x29a
[    0.398867]  ? state_next+0x6e/0x1c9
[    0.398870]  ? iommu_setup+0x29a/0x29a
[    0.398872]  ? iommu_go_to_state+0x1f/0x33
[    0.398873]  ? amd_iommu_init+0xa/0x23
[    0.398875]  ? pci_iommu_init+0xf/0x45
[    0.398876]  ? iommu_setup+0x29a/0x29a
[    0.398878]  ? __initstub__kmod_pci_dma__244_136_pci_iommu_initrootfs+0x5/0x8
[    0.398880]  ? do_one_initcall+0x100/0x290
[    0.398882]  ? do_initcall_level+0x8b/0xe5
[    0.398884]  ? do_initcalls+0x44/0x6d
[    0.398885]  ? kernel_init_freeable+0xc7/0x10d
[    0.398886]  ? rest_init+0xc0/0xc0
[    0.398888]  ? kernel_init+0x11/0x150
[    0.398889]  ? ret_from_fork+0x22/0x30
[    0.398891]  </TASK>
[    0.398892] ---[ end trace f048a4ec907dc976 ]---

Which points to patch one and "if (WARN_ON(i >= LOOP_TIMEOUT))"

Hope that helps

Mike
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
