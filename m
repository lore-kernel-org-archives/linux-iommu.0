Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEDC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 19:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83B2082611;
	Tue, 25 Jan 2022 19:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWT_I7ZMMPzU; Tue, 25 Jan 2022 19:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4E0488261C;
	Tue, 25 Jan 2022 19:26:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31E9AC0039;
	Tue, 25 Jan 2022 19:26:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8E2AC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2A0C6080A
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KLJfkH6272uC for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:26:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB134607F7
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643138792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4oqhYaOJzCMND/PHbdluqZlT5cXmCHSNgWuLWdmml8=;
 b=Zs/tM3JT1AFxhZXSD88kKVv8F2oHuOWmvb19x2jn9jeSXaPoLsz7fu2DFFZElGvBvuGn4i
 KE8yBee5hPehrvlFWt+0la72QyNwsmEqrioEL6u2IvmErJgsJ/gXvq4nCezaGqlbU+HPBB
 jjyds3IVLF40vmrAxfBVzSwgkyIUXjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-OCr_ibQWPMa7Po-5trzdPg-1; Tue, 25 Jan 2022 14:26:26 -0500
X-MC-Unique: OCr_ibQWPMa7Po-5trzdPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04512192D786;
 Tue, 25 Jan 2022 19:26:25 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F69419C59;
 Tue, 25 Jan 2022 19:26:22 +0000 (UTC)
Message-ID: <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 25 Jan 2022 21:26:21 +0200
In-Reply-To: <20220125150832.1570-1-mike@fireburn.co.uk>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
 <20220125150832.1570-1-mike@fireburn.co.uk>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On Tue, 2022-01-25 at 15:08 +0000, Mike Lothian wrote:
> Hi
> 
> I'm seeing a WARNING that I think might be related to these patches, unfortunately another issue is making bisecting difficult
> 
> [    0.359362] AMD-Vi: X2APIC enabled
> [    0.395140] ------------[ cut here ]------------
> [    0.395142] WARNING: CPU: 0 PID: 1 at amd_iommu_enable_interrupts+0x1da/0x440
> [    0.395146] Modules linked in:
> [    0.395148] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc1-tip+ #2995
> [    0.395150] Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> [    0.395152] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
> [    0.395154] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00 48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> [    0.395157] RSP: 0018:ffff88810022fc68 EFLAGS: 00010246
> [    0.395158] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
> [    0.395160] RDX: 0000000000000008 RSI: ffff88810022fc70 RDI: ffffc900000800f0
> [    0.395161] RBP: ffff88810022fc68 R08: ffff888100fce088 R09: 0000000000000000
> [    0.395162] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
> [    0.395163] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357c9e8
> [    0.395165] FS:  0000000000000000(0000) GS:ffff888fde400000(0000) knlGS:0000000000000000
> [    0.395166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.395167] CR2: ffff88901e1ff000 CR3: 00000000b440c000 CR4: 0000000000150ef0
> [    0.395169] Call Trace:
> [    0.395170]  <TASK>
> [    0.395171]  ? iommu_setup+0x29a/0x29a
> [    0.395174]  ? state_next+0x6e/0x1c9
> [    0.395177]  ? iommu_setup+0x29a/0x29a
> [    0.395178]  ? iommu_go_to_state+0x1f/0x33
> [    0.395180]  ? amd_iommu_init+0xa/0x23
> [    0.395182]  ? pci_iommu_init+0xf/0x45
> [    0.395183]  ? iommu_setup+0x29a/0x29a
> [    0.395184]  ? __initstub__kmod_pci_dma__250_136_pci_iommu_initrootfs+0x5/0x8
> [    0.395186]  ? do_one_initcall+0x100/0x290
> [    0.395190]  ? do_initcall_level+0x8b/0xe5
> [    0.395192]  ? do_initcalls+0x44/0x6d
> [    0.395194]  ? kernel_init_freeable+0xc7/0x10d
> [    0.395196]  ? rest_init+0xc0/0xc0
> [    0.395198]  ? kernel_init+0x11/0x150
> [    0.395200]  ? ret_from_fork+0x22/0x30
> [    0.395201]  </TASK>
> [    0.395202] ---[ end trace 0000000000000000 ]---
> [    0.395204] PCI-DMA: Using software bounce buffer
> 
> Let me know if you need any more info
> 
> Cheers
> 
> Mike


Could you just apply these patches on top of 5.15 kernel and see if you get the warning?

If something could case it is I think patch 1, it does move the GA log enabled
to be a bit later.
I also added few warnings there. I wonder why your dmesg quote doesn't contain the C line
where the warning happens.

In partucular I added:

if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))

That will fire if GA log is already running (maybe BIOS enabled it? - it really shouldn't do that)


And that:

if (WARN_ON(i >= LOOP_TIMEOUT))

also should not happen and worth to be logged IMHO.

Best regards,
	Maxim Levitsky



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
