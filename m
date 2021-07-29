Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A24C4320A
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 04:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0696103B
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 04:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD0696103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78EF783ABD;
	Thu, 29 Jul 2021 04:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y_yRrIjru7m5; Thu, 29 Jul 2021 04:09:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BF8583AB2;
	Thu, 29 Jul 2021 04:09:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1717C001A;
	Thu, 29 Jul 2021 04:09:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81FFBC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E58A6063E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgBp5A06-yiM for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:08:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33054605DA
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:08:58 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id t3so3264870plg.9
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=G1a4z6t0YH/1+lopR4XgZUjwrxuMtoSPgiMGhqemeMw=;
 b=tnkbUP5Ud2dYb+GWlpuqjNiphBSTejuF1omZYayoFYB7lteJVXkzOVRd0oZG97q+0h
 noxryBFC9UaX/iDbNjmc4gjckh3BM1D+YAR+a2NMaF77iJ0gjStoImhLwSNtZ6GajDGu
 v/yJqgeUfxD0QRfdsifx5KLL/5bBWBy3OshaDe6rgQC27T9TGtE5aGUhWuZZJQ3mAAXn
 ldTyDh+Ipf6aAN2E4Lx1wy+bYbxWKNf91awCfs5mRJDYXUacS8eXEJcwJW70e1EycN73
 y71gQF3BBhZzUx6VVKnHLuRwwBGUKZGf1SDuoM7ADz/TodEeIOixEzC9Ryv944exUCUz
 +sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=G1a4z6t0YH/1+lopR4XgZUjwrxuMtoSPgiMGhqemeMw=;
 b=jnbhCJM/cieES+R3NJ/F+j/0L7CJcG+NqcG/O8W96CofnvuIhPKkFFUooDHDCxOdpd
 Hv2Eb2iF965fN5BoVSg1exae3jfiFbL71uvgdHAQPduu1LPw6hiXF4Rm6TlA9nm/n78o
 UenFXo+ViDYsJybxzFtU+aV3mkVOHN8emFDdi6BbA53NsqSsF/j5tKAa9UZ/dO9jSABT
 GnYeLVmn9K/kdYe9KumyYd1QW041LsdgCW5uBut1yj4IvElOVUQrKMb38mHM1r7a3eOU
 BXTFciK6sUH+YtEqA0eUNOLyD5he85Bu9f4Xb4yxEpXME5r63ZXtBQObh7WfgF6K1LKg
 pxCQ==
X-Gm-Message-State: AOAM533PsxMZzGcXtG9wkNNrzHa225OCpyjNpdnKTb4vha3yFjrC40C5
 Jhr2xSJXdXcrRSCEeDaL7so=
X-Google-Smtp-Source: ABdhPJw4KzLL5+SwyRMRry6vDFuKnWhRIHabIsYLolMkrCj75FCTCCaJFX9D7Aq5Qka1rBTdo5X1DQ==
X-Received: by 2002:a62:3045:0:b029:32b:880f:c03a with SMTP id
 w66-20020a6230450000b029032b880fc03amr2939932pfw.22.1627531737556; 
 Wed, 28 Jul 2021 21:08:57 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
 by smtp.gmail.com with ESMTPSA id
 x65sm7715402pjj.57.2021.07.28.21.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 21:08:57 -0700 (PDT)
Date: Thu, 29 Jul 2021 14:08:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [powerpc][next-20210727] Boot failure - kernel BUG at
 arch/powerpc/kernel/interrupt.c:98!
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Nathan Chancellor
 <nathan@kernel.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, Will Deacon
 <will@kernel.org>
References: <1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com>
 <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
In-Reply-To: <YQGVZnMe9hFieF8D@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Message-Id: <1627531480.yy7fe9l470.astroid@bobo.none>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-next@vger.kernel.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

Excerpts from Nathan Chancellor's message of July 29, 2021 3:35 am:
> On Wed, Jul 28, 2021 at 01:31:06PM +0530, Sachin Sant wrote:
>> linux-next fails to boot on Power server (POWER8/POWER9). Following traces
>> are seen during boot
>> 
>> [    0.010799] software IO TLB: tearing down default memory pool
>> [    0.010805] ------------[ cut here ]------------
>> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
>> [    0.010812] Oops: Exception in kernel mode, sig: 5 [#1]
>> [    0.010816] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>> [    0.010820] Modules linked in:
>> [    0.010824] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3-next-20210727 #1
>> [    0.010830] NIP:  c000000000032cfc LR: c00000000000c764 CTR: c00000000000c670
>> [    0.010834] REGS: c000000003603b10 TRAP: 0700   Not tainted  (5.14.0-rc3-next-20210727)
>> [    0.010838] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 00000002
>> [    0.010848] CFAR: c00000000000c760 IRQMASK: 3 
>> [    0.010848] GPR00: c00000000000c764 c000000003603db0 c0000000029bd000 0000000000000001 
>> [    0.010848] GPR04: 0000000000000a68 0000000000000400 c000000003603868 ffffffffffffffff 
>> [    0.010848] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000003 
>> [    0.010848] GPR12: ffffffffffffffff c00000001ec9ee80 c000000000012a28 0000000000000000 
>> [    0.010848] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [    0.010848] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [    0.010848] GPR24: 000000000000f134 0000000000000000 ffffffffffffffff c000000003603868 
>> [    0.010848] GPR28: 0000000000000400 0000000000000a68 c00000000202e9c0 c000000003603e80 
>> [    0.010896] NIP [c000000000032cfc] system_call_exception+0x8c/0x2e0
>> [    0.010901] LR [c00000000000c764] system_call_common+0xf4/0x258
>> [    0.010907] Call Trace:
>> [    0.010909] [c000000003603db0] [c00000000016a6dc] calculate_sigpending+0x4c/0xe0 (unreliable)
>> [    0.010915] [c000000003603e10] [c00000000000c764] system_call_common+0xf4/0x258
>> [    0.010921] --- interrupt: c00 at kvm_template_end+0x4/0x8
>> [    0.010926] NIP:  c000000000092dec LR: c000000000114fc8 CTR: 0000000000000000
>> [    0.010930] REGS: c000000003603e80 TRAP: 0c00   Not tainted  (5.14.0-rc3-next-20210727)
>> [    0.010934] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 00000000
>> [    0.010943] IRQMASK: 0 
>> [    0.010943] GPR00: c00000000202e9c0 c000000003603b00 c0000000029bd000 000000000000f134 
>> [    0.010943] GPR04: 0000000000000a68 0000000000000400 c000000003603868 ffffffffffffffff 
>> [    0.010943] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [    0.010943] GPR12: 0000000000000000 c00000001ec9ee80 c000000000012a28 0000000000000000 
>> [    0.010943] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [    0.010943] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> [    0.010943] GPR24: c0000000020033c4 c00000000110afc0 c000000002081950 c000000003277d40 
>> [    0.010943] GPR28: 0000000000000000 c00000000a680000 0000000004000000 00000000000d0000 
>> [    0.010989] NIP [c000000000092dec] kvm_template_end+0x4/0x8
>> [    0.010993] LR [c000000000114fc8] set_memory_encrypted+0x38/0x60
>> [    0.010999] --- interrupt: c00
>> [    0.011001] [c000000003603b00] [c00000000000c764] system_call_common+0xf4/0x258 (unreliable)
>> [    0.011008] Instruction dump:
>> [    0.011011] 694a0003 312affff 7d495110 0b0a0000 60000000 60000000 e87f0108 68690002 
>> [    0.011019] 7929ffe2 0b090000 68634000 786397e2 <0b030000> e93f0138 792907e0 0b090000 
>> [    0.011029] ---[ end trace a20ad55589efcb10 ]---
>> [    0.012297] 
>> [    1.012304] Kernel panic - not syncing: Fatal exception
>> 
>> next-20210723 was good. The boot failure seems to have been introduced with next-20210726.
>> 
>> I have attached the boot log.
> 
> I noticed this with OpenSUSE's ppc64le config [1] and my bisect landed on
> commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()"). That
> series just keeps on giving... Adding some people from that thread to
> this one. Original thread:
> https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/

This is because powerpc's set_memory_encrypted makes an ultracall but it 
does not exist on that processor.

x86's set_memory_encrypted/decrypted have

       /* Nothing to do if memory encryption is not active */
        if (!mem_encrypt_active())
                return 0;

Probably powerpc should just do that too.

Thanks,
Nick
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
