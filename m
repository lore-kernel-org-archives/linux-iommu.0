Return-Path: <SRS0=l7mN=MX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB99C4320A
	for <iommu@archiver.kernel.org>; Sat, 31 Jul 2021 18:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FF960EEA
	for <iommu@archiver.kernel.org>; Sat, 31 Jul 2021 18:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84FF960EEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45896605E8;
	Sat, 31 Jul 2021 18:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pIf8isbYrOVe; Sat, 31 Jul 2021 18:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1B71605F7;
	Sat, 31 Jul 2021 18:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B5EC0010;
	Sat, 31 Jul 2021 18:26:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE96DC000E
 for <iommu@lists.linux-foundation.org>; Sat, 31 Jul 2021 18:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAEF5605F7
 for <iommu@lists.linux-foundation.org>; Sat, 31 Jul 2021 18:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJCbPhuUIJFT for <iommu@lists.linux-foundation.org>;
 Sat, 31 Jul 2021 18:26:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9EAB605E8
 for <iommu@lists.linux-foundation.org>; Sat, 31 Jul 2021 18:26:13 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 c2-20020a0568303482b029048bcf4c6bd9so13228453otu.8
 for <iommu@lists.linux-foundation.org>; Sat, 31 Jul 2021 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hBtKNyxqROYkKFt3WBE7Y4EWrIo+/eGAI501eNvazo8=;
 b=sSg9WjBK53PQztypwJMPVaq3GObjOOuz+Sm55XkTFEVxs71ZxyZ1Rc8jRV3etzMhJS
 3IfURxgFW7FPEK0qhtnNc9669PsPS/SpGHvXQ2Fq8trqsIPIGyJ299QpmgxeBURHCnKk
 LHPL9BKqu5l+fhj3e/tkuyaMDSxrbEeJUCSTKiUtigMPf3g4uLDOARqKm83TlRgGM5Ce
 Xtd95dgulhIH1y3HB7W+cL6hSIZqoPkt+UAQy2doRi2cjTPSEy/z+MGcLwH/d1drSU2x
 plQeK4JIDkLBNArfKK1CSF1KSz5Z3U6EPSMa2NvUgfZMJDk3UeKB8ECyq2RO6x/TNRnh
 SEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=hBtKNyxqROYkKFt3WBE7Y4EWrIo+/eGAI501eNvazo8=;
 b=fkP2f2UiBybQqiiDNZEqsV99C392STV0LNCdzK8F5HrQWT8Z2xJ3boPxawP8Kr4XgI
 oc3++j3weZRohVXEWwEpdGkt/7/l0FyD/rhM8dLYRAQAF7GW3N4Av+DZFEePlaGmL1NF
 ScoRvlzeRfDdrjL34HOTg/pKNM26gt9K/bMsm0nPL6ymURibkH5XB/+GtHaEIZe5Iki+
 mc8CLEGp3lLfJ6HI5rF0skyCQTkDA4jN/WrUB3asjzmr6KcI7laGj5NIuMRkxtkPRoJS
 zJHhExE5dQN2s+v/OZ8UWELGsTQim8Xz/L3oNgKAGDiAammvAT5QrwHxkjGam8uwTebl
 2mLQ==
X-Gm-Message-State: AOAM530KyJUkk8dMklqG2+9ZRgMfU936gAAsVeQFSAB3ovki2dGma9Un
 ioum10VLVLnaF1KrZXk69gY=
X-Google-Smtp-Source: ABdhPJzAYOGKzOs20gmQvAnoUIZIaJXa+UkjMe9016BgtBmpjDIaHYvq4A/NDGvKBOKWtsbR7CZIJA==
X-Received: by 2002:a9d:550c:: with SMTP id l12mr6428564oth.169.1627755972617; 
 Sat, 31 Jul 2021 11:26:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 h2sm987204oti.24.2021.07.31.11.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jul 2021 11:26:12 -0700 (PDT)
Date: Sat, 31 Jul 2021 11:26:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/4] swiotlb: Free tbl memory in swiotlb_exit()
Message-ID: <20210731182611.GA3792424@roeck-us.net>
References: <20210720133826.9075-1-will@kernel.org>
 <20210720133826.9075-5-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720133826.9075-5-will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Tue, Jul 20, 2021 at 02:38:26PM +0100, Will Deacon wrote:
> Although swiotlb_exit() frees the 'slots' metadata array referenced by
> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
> despite no longer being usable.
> 
> Extend swiotlb_exit() to free the buffer pages as well as the slots
> array.
> 

This patch causes qemu pseries emulations to crash. Backtrace and bisect
log see below. Reverting it fixes the problem.

Guenter

---
Crash log:

...
[    0.937801][    T1] software IO TLB: tearing down default memory pool
[    0.938939][    T1] ------------[ cut here ]------------
[    0.940331][    T1] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
[    0.940787][    T1] Oops: Exception in kernel mode, sig: 5 [#1]
[    0.940883][    T1] BE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
[    0.940999][    T1] Modules linked in:
[    0.941240][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3-next-20210729 #1
[    0.941523][    T1] NIP:  c000000000031310 LR: c0000000000312f4 CTR: c00000000000c5f0
[    0.941608][    T1] REGS: c000000008687ac0 TRAP: 0700   Not tainted  (5.14.0-rc3-next-20210729)
[    0.941795][    T1] MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    0.942031][    T1] CFAR: c000000000300360 IRQMASK: 3
[    0.942031][    T1] GPR00: c0000000000312f4 c000000008687d60 c0000000022ee300 0000000000000003
[    0.942031][    T1] GPR04: 000000000000033f 0000000000000400 0000000000000000 000000003e5a0000
[    0.942031][    T1] GPR08: 000000003e5a0000 0000000000000001 0000000000000000 0000000000000003
[    0.942031][    T1] GPR12: ffffffffffffffff c000000002fb0000 c0000000000129c0 0000000000000000
[    0.942031][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.942031][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    0.942031][    T1] GPR24: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000400
[    0.942031][    T1] GPR28: 000000000000033f 000000000000f134 c00000000176c068 c000000008687e80
[    0.942884][    T1] NIP [c000000000031310] .system_call_exception+0x70/0x2d0
[    0.943399][    T1] LR [c0000000000312f4] .system_call_exception+0x54/0x2d0
[    0.943594][    T1] Call Trace:
[    0.943667][    T1] [c000000008687d60] [c0000000000312f4] .system_call_exception+0x54/0x2d0 (unreliable)
[    0.943919][    T1] [c000000008687e10] [c00000000000c6e4] system_call_common+0xf4/0x258
[    0.944066][    T1] --- interrupt: c00 at .ucall_norets+0x4/0x14
[    0.944172][    T1] NIP:  c000000000079ce0 LR: c0000000000fa274 CTR: 0000000000000000
[    0.944245][    T1] REGS: c000000008687e80 TRAP: 0c00   Not tainted  (5.14.0-rc3-next-20210729)
[    0.944323][    T1] MSR:  8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    0.944463][    T1] IRQMASK: 0
[    0.944463][    T1] GPR00: c00000000176c068 c000000008687a30 c0000000022ee300 000000000000f134
[    0.944463][    T1] GPR04: 000000000000033f 0000000000000400 ffffffffffffffff 0000000000000000
[    0.944463][    T1] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.944463][    T1] GPR12: 0000000000000000 c000000002fb0000 c0000000000129c0 0000000000000000
[    0.944463][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.944463][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    0.944463][    T1] GPR24: c0000000017c1088 0000000000000004 c00000000171c450 c000000002338e40
[    0.944463][    T1] GPR28: c0000000017c10b0 c0000000033f0000 0000000000000400 c0000000033f0000
[    0.945188][    T1] NIP [c000000000079ce0] .ucall_norets+0x4/0x14
[    0.945285][    T1] LR [c0000000000fa274] .set_memory_encrypted+0x44/0x80
[    0.945375][    T1] --- interrupt: c00
[    0.945419][    T1] [c000000008687a30] [c00000000176c068] .swiotlb_exit+0xbc/0x180 (unreliable)
[    0.945612][    T1] Instruction dump:
[    0.945745][    T1] 7cbb2b78 7cda3378 7cf93b78 7d184378 482cefd1 60000000 e93f0108 692a0002
[    0.945883][    T1] 794affe2 0b0a0000 69294000 792997e2 <0b090000> e93f0138 792907e0 0b090000
[    0.946751][    T1] ---[ end trace 600e218cfc83c24b ]---
[    0.955185][    T1]
[    1.955805][    T1] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
[    1.955918][    T1] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[    1.956024][    T1] INFO: lockdep is turned off.
[    1.956094][    T1] irq event stamp: 14792
[    1.956142][    T1] hardirqs last  enabled at (14791): [<c0000000001f8fe8>] .__up_console_sem+0xc8/0x110
[    1.956269][    T1] hardirqs last disabled at (14792): [<c0000000000312f4>] .system_call_exception+0x54/0x2d0
[    1.956384][    T1] softirqs last  enabled at (10586): [<c000000000efd6d4>] .release_sock+0xb4/0x100
[    1.956497][    T1] softirqs last disabled at (10584): [<c000000000efd654>] .release_sock+0x34/0x100
[    1.956726][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D           5.14.0-rc3-next-20210729 #1
[    1.956846][    T1] Call Trace:
[    1.956885][    T1] [c000000008687700] [c0000000009fe088] .dump_stack_lvl+0xa4/0x100 (unreliable)
[    1.957011][    T1] [c000000008687790] [c000000000193060] .___might_sleep+0x2b0/0x2f0
[    1.957130][    T1] [c000000008687820] [c00000000015fba0] .exit_signals+0x50/0x540
[    1.957238][    T1] [c0000000086878e0] [c000000000148dbc] .do_exit+0xec/0xe20
[    1.957335][    T1] [c0000000086879c0] [c000000000029bc4] .oops_end+0x144/0x210
[    1.957441][    T1] [c000000008687a50] [c0000000000095d4] program_check_common_virt+0x2d4/0x320
[    1.957561][    T1] --- interrupt: 700 at .system_call_exception+0x70/0x2d0
[    1.957645][    T1] NIP:  c000000000031310 LR: c0000000000312f4 CTR: c00000000000c5f0
[    1.957715][    T1] REGS: c000000008687ac0 TRAP: 0700   Tainted: G      D            (5.14.0-rc3-next-20210729)
[    1.957799][    T1] MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    1.957919][    T1] CFAR: c000000000300360 IRQMASK: 3
[    1.957919][    T1] GPR00: c0000000000312f4 c000000008687d60 c0000000022ee300 0000000000000003
[    1.957919][    T1] GPR04: 000000000000033f 0000000000000400 0000000000000000 000000003e5a0000
[    1.957919][    T1] GPR08: 000000003e5a0000 0000000000000001 0000000000000000 0000000000000003
[    1.957919][    T1] GPR12: ffffffffffffffff c000000002fb0000 c0000000000129c0 0000000000000000
[    1.957919][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.957919][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    1.957919][    T1] GPR24: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000400
[    1.957919][    T1] GPR28: 000000000000033f 000000000000f134 c00000000176c068 c000000008687e80
[    1.958633][    T1] NIP [c000000000031310] .system_call_exception+0x70/0x2d0
[    1.958720][    T1] LR [c0000000000312f4] .system_call_exception+0x54/0x2d0
[    1.958803][    T1] --- interrupt: 700
[    1.958842][    T1] [c000000008687e10] [c00000000000c6e4] system_call_common+0xf4/0x258
[    1.958961][    T1] --- interrupt: c00 at .ucall_norets+0x4/0x14
[    1.959055][    T1] NIP:  c000000000079ce0 LR: c0000000000fa274 CTR: 0000000000000000
[    1.959127][    T1] REGS: c000000008687e80 TRAP: 0c00   Tainted: G      D            (5.14.0-rc3-next-20210729)
[    1.959210][    T1] MSR:  8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 24002222  XER: 00000000
[    1.959337][    T1] IRQMASK: 0
[    1.959337][    T1] GPR00: c00000000176c068 c000000008687a30 c0000000022ee300 000000000000f134
[    1.959337][    T1] GPR04: 000000000000033f 0000000000000400 ffffffffffffffff 0000000000000000
[    1.959337][    T1] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.959337][    T1] GPR12: 0000000000000000 c000000002fb0000 c0000000000129c0 0000000000000000
[    1.959337][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    1.959337][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000021d8b00
[    1.959337][    T1] GPR24: c0000000017c1088 0000000000000004 c00000000171c450 c000000002338e40
[    1.959337][    T1] GPR28: c0000000017c10b0 c0000000033f0000 0000000000000400 c0000000033f0000
[    1.960042][    T1] NIP [c000000000079ce0] .ucall_norets+0x4/0x14
[    1.960137][    T1] LR [c0000000000fa274] .set_memory_encrypted+0x44/0x80
[    1.960219][    T1] --- interrupt: c00
[    1.960257][    T1] [c000000008687a30] [c00000000176c068] .swiotlb_exit+0xbc/0x180 (unreliable)
[    1.960845][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
qemu-system-ppc64: OS terminated: OS panic: Attempted to kill init! exitcode=0x00000005

---
Bisect log:

# bad: [8d4b477da1a807199ca60e0829357ce7aa6758d5] Add linux-next specific files for 20210730
# good: [ff1176468d368232b684f75e82563369208bc371] Linux 5.14-rc3
git bisect start 'HEAD' 'v5.14-rc3'
# bad: [8f3eb1f5c702ef868d89799b03c21d122f2fe197] Merge remote-tracking branch 'bpf-next/for-next'
git bisect bad 8f3eb1f5c702ef868d89799b03c21d122f2fe197
# good: [02afbb8f68dc8b37c07e457d2f69d440781af23a] Merge remote-tracking branch 'cifsd/cifsd-for-next'
git bisect good 02afbb8f68dc8b37c07e457d2f69d440781af23a
# good: [3e12361b6d23f793580a50a6008633501c56ea1d] bcm63xx_enet: delete a redundant assignment
git bisect good 3e12361b6d23f793580a50a6008633501c56ea1d
# good: [78d788681492abe4980d5cc9b93b70df9f028880] Merge remote-tracking branch 'jc_docs/docs-next'
git bisect good 78d788681492abe4980d5cc9b93b70df9f028880
# good: [266234e7659f731cf471a1bdc4fd1ead4caa8303] Merge remote-tracking branch 'v4l-dvb-next/master'
git bisect good 266234e7659f731cf471a1bdc4fd1ead4caa8303
# bad: [be1841fe3ca0010139fe4fb44dd42dea7c0e3401] Merge remote-tracking branch 'swiotlb/linux-next'
git bisect bad be1841fe3ca0010139fe4fb44dd42dea7c0e3401
# good: [7b8798617c7975d10678d99dcc59d103e237b4cd] Merge remote-tracking branch 'ieee1394/for-next'
git bisect good 7b8798617c7975d10678d99dcc59d103e237b4cd
# good: [463e862ac63ef27fca423782536f6465abc3f180] swiotlb: Convert io_default_tlb_mem to static allocation
git bisect good 463e862ac63ef27fca423782536f6465abc3f180
# good: [2dc6b1158c28c3a5e86d162628810312f98d5e97] fs: dlm: introduce generic listen
git bisect good 2dc6b1158c28c3a5e86d162628810312f98d5e97
# good: [62699b3f0a62435fceb8debf295e90a5ea259e04] fs: dlm: move receive loop into receive handler
git bisect good 62699b3f0a62435fceb8debf295e90a5ea259e04
# bad: [ad6c00283163cb7ad52cdf97d2850547446f7d98] swiotlb: Free tbl memory in swiotlb_exit()
git bisect bad ad6c00283163cb7ad52cdf97d2850547446f7d98
# good: [1efd3fc0ccf52e1aa5f0bf5b0d82847180d20951] swiotlb: Emit diagnostic in swiotlb_exit()
git bisect good 1efd3fc0ccf52e1aa5f0bf5b0d82847180d20951
# first bad commit: [ad6c00283163cb7ad52cdf97d2850547446f7d98] swiotlb: Free tbl memory in swiotlb_exit()
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
