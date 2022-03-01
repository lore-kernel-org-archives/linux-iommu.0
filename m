Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2434DC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B352781A12;
	Tue,  1 Mar 2022 04:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnNpmsbtfJD0; Tue,  1 Mar 2022 04:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F49D81A0D;
	Tue,  1 Mar 2022 04:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12F88C0033;
	Tue,  1 Mar 2022 04:42:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D73C3C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 03:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCB1881404
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 03:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7iUBaKRB4IZA for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 03:00:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75933813E4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 03:00:55 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 ge19-20020a17090b0e1300b001bcca16e2e7so900537pjb.3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yGn3vdANW1r5F/Ia+3L2V3BcvELrYmTYHlCTQDMODUY=;
 b=ep9QUCPFrKQKKDYCeQZombvPSACDX5QAanOooXEIHsClagi7wvLSHLUpmEJEcOkSAp
 i4x+uBIRBF8TmYZhMV466UK9SW6J9IcxG4qg97PuHEs8Nj1BYAsILZ7ISr//Iq1RINTh
 K40dIR1Twn/KwTxXgneKoOpQO16AO+7fguGlE/GsT+xqRXKy681lN9yKVw6fL1fAN5Mg
 8egYde8mesDN4EdSYaKsOv4+iaHdjnXtd0cVZkMDaYCEl8RjkJkpojGim9lQ4FvCWcbA
 o08PP6uifdwrB0QgCHtLEmdEdrqH1rtpjuiONmzcS9rq8Kroc0P5JmsCF6OrQaJnnJOh
 8eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yGn3vdANW1r5F/Ia+3L2V3BcvELrYmTYHlCTQDMODUY=;
 b=WF2h1ZxBkzITHV0zLGmSVeVXD8liiNk7A31v22vx8hJKgARIPwfASEMwKXyUdDBnnb
 +LZKd9OIYRRUDn2izyp6gQEa3uwjGTFOdXXkuyMCvhlwOEYvmZ7DyRzPz0zzCOc+eXoc
 l6nJV94/EwXmgf3PIr32V2WE56A5aMCmKctNDQ1ax8PUh+r6Y79+i8k/RUPByzgXUAAR
 lnzjUTsap3E/jggA4S9H8aqVpVNy8RmdhBJ/oDJ4eXQ3eP2IhgalvIojX8FeJpt6luPj
 DAQfqk3+DLv8dg0hxr073REjaHDvwKVP+YcuLaDJuf5pzQDO8mmAu8j+3Xm8kyjZts8/
 ncJA==
X-Gm-Message-State: AOAM531B5w8JqrGp89sG1KjyEqlg3gSH6lTW7aYgSQ9LnxaXqa5lX3bt
 ctodNmQ8eTdkw+6waCtusiM=
X-Google-Smtp-Source: ABdhPJwrzwLsxcQUuidgmrPiWBuhODP8xX9zz34P7cXvnVYJLbgEO9+KzVp847C96T0rs95EBaonHA==
X-Received: by 2002:a17:90a:f02:b0:1bd:ab6:42ec with SMTP id
 2-20020a17090a0f0200b001bd0ab642ecmr16187772pjy.18.1646103654246; 
 Mon, 28 Feb 2022 19:00:54 -0800 (PST)
Received: from monstilationax (41.68.233.220.static.exetel.com.au.
 [220.233.68.41]) by smtp.gmail.com with ESMTPSA id
 be6-20020a656e46000000b0036c7c63e915sm11135691pgb.48.2022.02.28.19.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 19:00:53 -0800 (PST)
From: Matt Flax <flatmax@gmail.com>
X-Google-Original-From: Matt Flax <flatmax@flatmax.com>
Received: by monstilationax (Postfix, from userid 1000)
 id 8B6083848BC0; Tue,  1 Mar 2022 14:00:50 +1100 (AEDT)
To: nsaenzjulienne@suse.de
Subject: Re: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Date: Tue,  1 Mar 2022 14:00:31 +1100
Message-Id: <20220301030031.4025282-1-flatmax@flatmax.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20201119175400.9995-1-nsaenzjulienne@suse.de>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 01 Mar 2022 04:42:48 +0000
Cc: devicetree@vger.kernel.org, will@kernel.org, linux-mm@kvack.org,
 catalin.marinas@arm.com, Matt Flax <flatmax@flatmax.com>,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, robin.murphy@arm.com, hch@lst.de,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi All,

It seems that the ZONE_DMA changes have broken the operation of Rochip rk3399 chipsets from v5.10.22 onwards.

It isn't clear what needs to be changed to get any of these boards up and running again. Any pointers on how/what to change ?

An easy test for debugging is to run stress :

stress --cpu 4 --io 4 --vm 2 --vm-bytes 128M

stress: info: [255] dispatching hogs: 4 cpu, 4 io, 2 vm, 0 hdd
[    8.070280] SError Interrupt on CPU4, code 0xbf000000 -- SError
[    8.070286] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
[    8.070289] Hardware name: FriendlyElec NanoPi M4 (DT)
[    8.070293] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
[    8.070296] pc : clear_page+0x14/0x28
[    8.070298] lr : clear_subpage+0x50/0x90
[    8.070302] sp : ffff800012abbc40
[    8.070305] x29: ffff800012abbc40 x28: ffff000000f68000 
[    8.070313] x27: 0000000000000000 x26: ffff000001f38e40 
[    8.070320] x25: ffff8000114fd000 x24: 0000000000000000 
[    8.070326] x23: 0000000000000000 x22: 0000000000001000 
[    8.070334] x21: 0000ffffa7e00000 x20: fffffe0000010000 
[    8.070341] x19: ffff000000f68000 x18: 0000000000000000 
[    8.070348] x17: 0000000000000000 x16: 0000000000000000 
[    8.070354] x15: 0000000000000002 x14: 0000000000000001 
[    8.070361] x13: 0000000000075879 x12: 00000000000000c0 
[    8.070368] x11: ffff80006c46a000 x10: 0000000000000200 
[    8.070374] x9 : 0000000000000000 x8 : 0000000000000010 
[    8.070381] x7 : ffff00007db800a0 x6 : ffff800011b899c0 
[    8.070387] x5 : 0000000000000000 x4 : ffff00007db800f7 
[    8.070394] x3 : 0000020000200000 x2 : 0000000000000004 
[    8.070401] x1 : 0000000000000040 x0 : ffff0000085ff4c0 
[    8.070409] Kernel panic - not syncing: Asynchronous SError Interrupt
[    8.070412] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
[    8.070415] Hardware name: FriendlyElec NanoPi M4 (DT)
[    8.070418] Call trace:
[    8.070420]  dump_backtrace+0x0/0x1b0
[    8.070423]  show_stack+0x18/0x70
[    8.070425]  dump_stack+0xd0/0x12c
[    8.070428]  panic+0x16c/0x334
[    8.070430]  nmi_panic+0x8c/0x90
[    8.070433]  arm64_serror_panic+0x78/0x84
[    8.070435]  do_serror+0x64/0x70
[    8.070437]  el1_error+0x88/0x108
[    8.070440]  clear_page+0x14/0x28
[    8.070443]  clear_huge_page+0x74/0x210
[    8.070445]  do_huge_pmd_anonymous_page+0x1b0/0x7c0
[    8.070448]  handle_mm_fault+0xdac/0x1290
[    8.070451]  do_page_fault+0x130/0x3a0
[    8.070453]  do_translation_fault+0xb0/0xc0
[    8.070456]  do_mem_abort+0x44/0xb0
[    8.070458]  el0_da+0x28/0x40
[    8.070461]  el0_sync_handler+0x168/0x1b0
[    8.070464]  el0_sync+0x174/0x180
[    8.070508] SError Interrupt on CPU0, code 0xbf000000 -- SError
[    8.070511] CPU: 0 PID: 258 Comm: stress Not tainted 5.10.21 #1
[    8.070515] Hardware name: FriendlyElec NanoPi M4 (DT)
[    8.070518] pstate: 80000000 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    8.070520] pc : 0000aaaacec22e98
[    8.070523] lr : 0000aaaacec22d84
[    8.070525] sp : 0000ffffe67a8620
[    8.070528] x29: 0000ffffe67a8620 x28: 0000000000000003 
[    8.070534] x27: 0000aaaacec34000 x26: 0000ffffaeb42610 
[    8.070541] x25: 0000ffffa69af010 x24: 0000aaaacec23a98 
[    8.070547] x23: 0000aaaacec35010 x22: 0000aaaacec35000 
[    8.070554] x21: 0000000000001000 x20: ffffffffffffffff 
[    8.070560] x19: 0000000008000000 x18: 0000000000000000 
[    8.070567] x17: 0000000000000000 x16: 0000000000000000 
[    8.070573] x15: 0000000000000000 x14: 0000000000000000 
[    8.070580] x13: 0000000000008000 x12: 0000000000000000 
[    8.070587] x11: 0000000000000020 x10: 0000000000000030 
[    8.070593] x9 : 000000000000000a x8 : 00000000000000de 
[    8.070599] x7 : 0000000000200000 x6 : 000000000000021b 
[    8.070606] x5 : 0000000000000000 x4 : ffffffffffffffff 
[    8.070613] x3 : 0000000000000000 x2 : 0000ffffaeb47000 
[    8.070619] x1 : 000000000000005a x0 : 0000000000a58000 
[    8.070629] SMP: stopping secondary CPUs
[    8.070632] Kernel Offset: disabled
[    8.070634] CPU features: 0x0240022,6100600c
[    8.070637] Memory Limit: none


-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
