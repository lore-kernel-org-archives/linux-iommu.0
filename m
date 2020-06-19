Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01900C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 20:56:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE2921531
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VuI4Xr4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE2921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DD9C86ADD;
	Fri, 19 Jun 2020 20:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EdEqOiCHl-ME; Fri, 19 Jun 2020 20:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB10C86A00;
	Fri, 19 Jun 2020 20:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97A8AC0865;
	Fri, 19 Jun 2020 20:56:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7623DC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 20:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6AD182107A
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 20:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ghuh6pBpmE50 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 20:56:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 8FDC420764
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 20:56:31 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id b7so4759369pju.0
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=6ZywDktM8pXlb5fMixw8rrzeWS4t9uFID6XIjv74YaI=;
 b=VuI4Xr4X0Pm3ZLkLxP9KgFz1iQK+tNUvZUmzaR1YcSNHYG5cg2Ths1TAPJAjczSlz9
 kGNClG4tj2wgp4rcnJaS83as67DEjWLSS9EX8W+2FYHPV+3NR0eIS326w2ttGJM+6xqW
 6z9iQpxVU6sxlaNXLxJZLTObHOgm72L9wQHEVdJ3ElibtoOS4Vt1ovwv6q3v9ToWreYJ
 Z+4+2AXg46fCGpaPuDxhQO+xTOsmOeIG/uLz4m51MZPXGQzzn9XpI3X/4tLmJhafcchN
 XfG9ZHJYhtiMymiRlFlIYwlw+qk8FP51l6J+9PJDgfc0ookZBiNwNf1YVdMUrBbGfEzn
 Ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=6ZywDktM8pXlb5fMixw8rrzeWS4t9uFID6XIjv74YaI=;
 b=sjTrsVfdKEEHKqJSUZ/hgHHrBSOo71NJ3SgYgW0sKCV4ol8lXZAuyvRaN3pS+GabiL
 rvsDbqzrR/i8E8LlPgBhAYIJrPRVmkPx9gMwEsYks1tytSS+kD4DZ1aBaMqi5uEghn78
 KBYNpgpHa9peMvN45dAZJwf8FgM5uwLLbBjtoa04Yfkt2cwX4vG8H/s7IwDS1LPzq+Or
 4rw1OB8lVKx0h2OqFJe4qFMC5w6bg72egkSoWls1BSfazvZQItct4vFtEw+8/nPITl1c
 qEnh3boFVh4mKqCJBdMInZcPi1J6JsPIB3847ZR9PMTmReDd6olgKuDZDJxVfs5FK5kc
 l49A==
X-Gm-Message-State: AOAM531vvd3SiLe28yACOisOw1KogJNyjq4JKdOpEKB6Joq35rN+myKZ
 1k2ucbxQIsIkcpFcgLy9sWUvQg==
X-Google-Smtp-Source: ABdhPJzhQVw6JDXXU9VTCJdrrtZbR9c4S55qPEclhLyoE6Jr2jZT95JIsmWaWnPBg6D2eplPm/7UZw==
X-Received: by 2002:a17:902:968b:: with SMTP id
 n11mr9392874plp.331.1592600190725; 
 Fri, 19 Jun 2020 13:56:30 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id b7sm6530221pfo.202.2020.06.19.13.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 13:56:28 -0700 (PDT)
Date: Fri, 19 Jun 2020 13:56:28 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Gushchin <guro@fb.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
In-Reply-To: <20200619185540.GB217189@carbon.lan>
Message-ID: <alpine.DEB.2.22.394.2006191354080.26224@chino.kir.corp.google.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
 <20200619185540.GB217189@carbon.lan>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 19 Jun 2020, Roman Gushchin wrote:

> [   40.287524] BUG: unable to handle page fault for address: ffffa77b833df000
> [   40.287529] #PF: supervisor write access in kernel mode
> [   40.287531] #PF: error_code(0x000b) - reserved bit violation
> [   40.287532] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3ec54d067
> PTE 80001688033d9163
> [   40.287538] Oops: 000b [#2] SMP NOPTI
> [   40.287542] CPU: 9 PID: 1986 Comm: pulseaudio Tainted: G      D
>       5.8.0-rc1+ #697
> [   40.287544] Hardware name: Gigabyte Technology Co., Ltd.
> AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> [   40.287550] RIP: 0010:__memset+0x24/0x30
> [   40.287553] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89
> d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48
> 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89
> d1 f3
> [   40.287556] RSP: 0018:ffffa77b827a7e08 EFLAGS: 00010216
> [   40.287558] RAX: 0000000000000000 RBX: ffff90f77dced800 RCX: 00000000000008a0
> [   40.287560] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa77b833df000
> [   40.287561] RBP: ffff90f7898c7000 R08: ffff90f78c507768 R09: ffffa77b833df000
> [   40.287563] R10: ffffa77b833df000 R11: ffff90f7839f2d40 R12: 0000000000000000
> [   40.287564] R13: ffff90f76a802e00 R14: ffffffffc0cb8880 R15: ffff90f770f4e700
> [   40.287567] FS:  00007f3d8e8df880(0000) GS:ffff90f78ee40000(0000)
> knlGS:0000000000000000
> [   40.287569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   40.287570] CR2: ffffa77b833df000 CR3: 00000003fa556000 CR4: 00000000003406e0
> [   40.287572] Call Trace:
> [   40.287584]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
> [   40.287593]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> [   40.287601]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> [   40.287608]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> [   40.287613]  ksys_ioctl+0x82/0xc0
> [   40.287617]  __x64_sys_ioctl+0x16/0x20
> [   40.287622]  do_syscall_64+0x4d/0x90
> [   40.287627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hi Roman,

If you have CONFIG_AMD_MEM_ENCRYPT set, this should be resolved by

commit dbed452a078d56bc7f1abecc3edd6a75e8e4484e
Author: David Rientjes <rientjes@google.com>
Date:   Thu Jun 11 00:25:57 2020 -0700

    dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL

Or you might want to wait for 5.8-rc2 instead which includes this fix.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
