Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD5C433FE
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 10:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89D4960ABD;
	Tue,  1 Mar 2022 10:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiysU3mwqzZG; Tue,  1 Mar 2022 10:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4358160ACD;
	Tue,  1 Mar 2022 10:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE3DC0033;
	Tue,  1 Mar 2022 10:56:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1646C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 10:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C13FA410D7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 10:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Bp5LhMpUkit for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 10:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA95F410D5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 10:56:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F7FBED1;
 Tue,  1 Mar 2022 02:56:13 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701873F73D;
 Tue,  1 Mar 2022 02:56:10 -0800 (PST)
Message-ID: <4e4bb61a-377e-1ec9-5998-214055ef0a78@arm.com>
Date: Tue, 1 Mar 2022 10:56:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Content-Language: en-GB
To: Matt Flax <flatmax@gmail.com>, nsaenzjulienne@suse.de
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
 <20220301030031.4025282-1-flatmax@flatmax.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220301030031.4025282-1-flatmax@flatmax.com>
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, catalin.marinas@arm.com,
 Matt Flax <flatmax@flatmax.com>, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, ardb@kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, will@kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Matt,

On 2022-03-01 03:00, Matt Flax wrote:
> Hi All,
> 
> It seems that the ZONE_DMA changes have broken the operation of Rochip rk3399 chipsets from v5.10.22 onwards.
> 
> It isn't clear what needs to be changed to get any of these boards up and running again. Any pointers on how/what to change ?

Your firmware/bootloader setup is mismatched. If you're using the 
downstream Rockchip blob for BL31, you need to reserve or remove the 
memory range 0x8400000-0x9600000 to match the behaviour of the original 
Android BSP U-Boot. The downstream firmware firewalls this memory off 
for the Secure world such that any attempt to touch it from Linux 
results in a fatal SError fault as below. Any apparent correlation with 
the ZONE_DMA changes will simply be because they've affected the 
behaviour of the page allocator, such that it's more likely to reach 
into the affected range of memory.

Cheers,
Robin.

> An easy test for debugging is to run stress :
> 
> stress --cpu 4 --io 4 --vm 2 --vm-bytes 128M
> 
> stress: info: [255] dispatching hogs: 4 cpu, 4 io, 2 vm, 0 hdd
> [    8.070280] SError Interrupt on CPU4, code 0xbf000000 -- SError
> [    8.070286] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
> [    8.070289] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070293] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    8.070296] pc : clear_page+0x14/0x28
> [    8.070298] lr : clear_subpage+0x50/0x90
> [    8.070302] sp : ffff800012abbc40
> [    8.070305] x29: ffff800012abbc40 x28: ffff000000f68000
> [    8.070313] x27: 0000000000000000 x26: ffff000001f38e40
> [    8.070320] x25: ffff8000114fd000 x24: 0000000000000000
> [    8.070326] x23: 0000000000000000 x22: 0000000000001000
> [    8.070334] x21: 0000ffffa7e00000 x20: fffffe0000010000
> [    8.070341] x19: ffff000000f68000 x18: 0000000000000000
> [    8.070348] x17: 0000000000000000 x16: 0000000000000000
> [    8.070354] x15: 0000000000000002 x14: 0000000000000001
> [    8.070361] x13: 0000000000075879 x12: 00000000000000c0
> [    8.070368] x11: ffff80006c46a000 x10: 0000000000000200
> [    8.070374] x9 : 0000000000000000 x8 : 0000000000000010
> [    8.070381] x7 : ffff00007db800a0 x6 : ffff800011b899c0
> [    8.070387] x5 : 0000000000000000 x4 : ffff00007db800f7
> [    8.070394] x3 : 0000020000200000 x2 : 0000000000000004
> [    8.070401] x1 : 0000000000000040 x0 : ffff0000085ff4c0
> [    8.070409] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    8.070412] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
> [    8.070415] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070418] Call trace:
> [    8.070420]  dump_backtrace+0x0/0x1b0
> [    8.070423]  show_stack+0x18/0x70
> [    8.070425]  dump_stack+0xd0/0x12c
> [    8.070428]  panic+0x16c/0x334
> [    8.070430]  nmi_panic+0x8c/0x90
> [    8.070433]  arm64_serror_panic+0x78/0x84
> [    8.070435]  do_serror+0x64/0x70
> [    8.070437]  el1_error+0x88/0x108
> [    8.070440]  clear_page+0x14/0x28
> [    8.070443]  clear_huge_page+0x74/0x210
> [    8.070445]  do_huge_pmd_anonymous_page+0x1b0/0x7c0
> [    8.070448]  handle_mm_fault+0xdac/0x1290
> [    8.070451]  do_page_fault+0x130/0x3a0
> [    8.070453]  do_translation_fault+0xb0/0xc0
> [    8.070456]  do_mem_abort+0x44/0xb0
> [    8.070458]  el0_da+0x28/0x40
> [    8.070461]  el0_sync_handler+0x168/0x1b0
> [    8.070464]  el0_sync+0x174/0x180
> [    8.070508] SError Interrupt on CPU0, code 0xbf000000 -- SError
> [    8.070511] CPU: 0 PID: 258 Comm: stress Not tainted 5.10.21 #1
> [    8.070515] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070518] pstate: 80000000 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    8.070520] pc : 0000aaaacec22e98
> [    8.070523] lr : 0000aaaacec22d84
> [    8.070525] sp : 0000ffffe67a8620
> [    8.070528] x29: 0000ffffe67a8620 x28: 0000000000000003
> [    8.070534] x27: 0000aaaacec34000 x26: 0000ffffaeb42610
> [    8.070541] x25: 0000ffffa69af010 x24: 0000aaaacec23a98
> [    8.070547] x23: 0000aaaacec35010 x22: 0000aaaacec35000
> [    8.070554] x21: 0000000000001000 x20: ffffffffffffffff
> [    8.070560] x19: 0000000008000000 x18: 0000000000000000
> [    8.070567] x17: 0000000000000000 x16: 0000000000000000
> [    8.070573] x15: 0000000000000000 x14: 0000000000000000
> [    8.070580] x13: 0000000000008000 x12: 0000000000000000
> [    8.070587] x11: 0000000000000020 x10: 0000000000000030
> [    8.070593] x9 : 000000000000000a x8 : 00000000000000de
> [    8.070599] x7 : 0000000000200000 x6 : 000000000000021b
> [    8.070606] x5 : 0000000000000000 x4 : ffffffffffffffff
> [    8.070613] x3 : 0000000000000000 x2 : 0000ffffaeb47000
> [    8.070619] x1 : 000000000000005a x0 : 0000000000a58000
> [    8.070629] SMP: stopping secondary CPUs
> [    8.070632] Kernel Offset: disabled
> [    8.070634] CPU features: 0x0240022,6100600c
> [    8.070637] Memory Limit: none
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
