Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACD36F8EB
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419770; cv=none; b=mpk5o3R8uNMoG0M3XdNtrIk/OlrvCjK7qU+a88dmbROCxmmuaznXJUb/0NKw4yi9iXVbHWawXBTg7JdAu/VPIlhBTQbs9Oyi+Uj1kMwj55aK1Dn83J4dZiIcZRCZzPW5bvtaYJqleRCH6YE2SlzbX5DAgH5Q3W22mw/zlbXwESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419770; c=relaxed/simple;
	bh=+Nz9SwIVAxefhRScA3TiebWy1dtXtofh8ayiRLZdBXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlKCeH344MjwxneVC1UiWH6R3m1PivM1938nyjbQa67HFmK7CQn6QkGiFpoSGVPDiijq4dtET+lk+hVF19Tr9DBo/A7OfuVP44BitIeKI/U+AZyGP/ZuzFsBl/2FOtdddV0dBw1C+j+gCXcl5vtA+ApKZxOW9d1DI/st9M6AgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et0zZQUD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et0zZQUD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso20901285e9.3
        for <iommu@lists.linux.dev>; Thu, 03 Sep 2026 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788419761; x=1789024561; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PUem4kEIJhyKpMYsgry4Sm+2Sj01IOIz2KgU+h6K0Dg=;
        b=Et0zZQUDn/C7JDbbFs5x8sNTCFccmFpCqmgzYb4EtnIPN6WX3HJLhxKaChpcu5r8X5
         PqQ9EDRFvjo2/H0UZMEW3dUQ5UJ8naeuavelYoNn6tHdfPjUzIiMdoBLdc3ThgpCPrmd
         3465nfRQNJcheiIIWBBosEBd6tHfzoPrbiVUoyyCFBTFVHFdHq144YR+BsMEIetxNjIE
         LahutC482nkWlaLHkhtjXNrZsQxA8TlZCfz++LSBr9Wa8UAisNZozRl7A0m7Wq62KcgM
         6qg233q73LW67y1HMLngKOGHc4Uv2bSRZrupZXw92c+JfoCpGjI/Oxlo1MaCjQC0GyEM
         zg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788419761; x=1789024561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUem4kEIJhyKpMYsgry4Sm+2Sj01IOIz2KgU+h6K0Dg=;
        b=p3O5VuYXXdZe1H72chLn30Fap6TWqJbNEw8upOvm2zAcSkZvld4XWF8WPe5S67fvyg
         MSHS/O9TNbTLjgZcbVb9UIxpJi1QtkZ9xHsQvb/REOEKZFBqiAkK3WE4Qibm8LtV8yW+
         pKOGbRNPoO3FJWEPaz40TSWDSLiOfXVBmTaY4qE3GkGorZm9Pz/ONsLCYzU2ctxmVeZn
         AzI+k5K2OwaXZNRgqZbmxaTiKYL6YnIxXw89lF7M1cs8cv4CDO/EqqSE9B/V/3MSvgZQ
         3szH9Gt7RTNFAo7aVPDBvnLcXupkAql6mi+uRFh9/+/yAcZesiPMSiV0Otc68KmYufUP
         4AYg==
X-Forwarded-Encrypted: i=1; AKwUvBzuzLeV8G3bh5LVdFMGfice5KR1101VoFtIMA8w3bcZLfxnG0Q7g+4HvQDotL7B6GkmpUSOBg==@lists.linux.dev
X-Gm-Message-State: AFuF++k5xOWSqErdSK7PQOsf/Z8I+bTs9SL7UNZKtL/60it29vvMwzlU
	qRz1nxG3V1jGZ/FpDN+i9F1BCuqVtfrT401jWyYKSCEuGbeLkmd0b+MC
X-Gm-Gg: AYBFou1rGfyuSkOOe3cvCOi387yD6ANZZZjPIhLO8nzgRnNi2LHEz3q77/FZVscP0h2
	gvlTZcSlZj3cyXlXmAhEj6yaxyL8Mbojor/h1EYdO+6Kktnw2tEhXFYbJC7Zx4VmPnypg29f89/
	4gIDzOJnR4GBrBv6y4OZXbLsgk8b9yTkN25YSEmbYpTPEY3v6ynjxixPZx5SiHesCAAdeG7NZUl
	7wWAkklNNbIDOp47AS7GaZkuVUfJZgQ+i7TcIIMMUj/kq+0/cpWJp7jDNRJVDwKKwbfozKy9o47
	+lb+8FhjkDSFdVVRIhKr3Z2amgv4jorm0NYsHe3UBectycecyGpyynl9wl3CVdW7Oq/Z+K7P/6q
	qfKK0wU80ieuBUW4Pho4n9lAbYcWR/KF+CtYPowwSAzRmwqxMVxYMF3L/KGIPxYuDRdcWxpGYRA
	jwy0jjgMq3a02YylqhOHX2Z0sLPjgRv6mEBOBeky/JO4j4Z/ntO2jQn6zlNOeGwIW5FWRang==
X-Received: by 2002:a05:600c:3e0a:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49ce5810b5dmr220393395e9.3.1788419761018;
        Thu, 03 Sep 2026 00:16:01 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm52930715e9.14.2026.09.03.00.16.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Sep 2026 00:16:00 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:15:56 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev, Mathias Nyman
 <mathias.nyman@intel.com>, linux-usb@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [BUG v7.3-rc1] WARNING: mm/page_alloc.c:5340 at
 __alloc_frozen_pages_noprof
Message-ID: <20260903091556.751544ce.michal.pecio@gmail.com>
In-Reply-To: <20260902143351.7b6d5e0a@gandalf.local.home>
References: <20260902143351.7b6d5e0a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 14:33:51 -0400, Steven Rostedt wrote:
> I'm triggering this warning on boot:
> 
> [   32.862044] ------------[ cut here ]------------
> [   32.864573] WARNING: mm/page_alloc.c:5340 at __alloc_frozen_pages_noprof+0xd81/0x30d0, CPU#3: swapper/0/1

Apparently that's a nonsense allocation size.

> [   32.881048] Modules linked in:
> [   32.883735] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-test #510 PREEMPT(full)
> [   32.890178] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014

Hmm, I recall hearing about QEMU recently.

Could this be the "horrible splat" mentioned by 045b5bef916d ?

Find it in usb-linus branch at
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

> [   32.898333] RIP: 0010:__alloc_frozen_pages_noprof (mm/page_alloc.c:5340 (discriminator 12) mm/page_alloc.c:5397 (discriminator 12))
> [   32.902745] Code: 89 44 24 0c 45 89 ee e8 ad f0 ff ff 44 8b 44 24 0c e9 96 f6 ff ff 80 3d 95 5b 9b 04 00 0f 85 7c f7 ff ff c6 05 88 5b 9b 04 01 <0f> 0b e9 6e f7 ff ff f3 90 8b 05 e0 b4 29 04 a8 01 75 f4 89 84 24
> All code
> ========
>    0:	89 44 24 0c          	mov    %eax,0xc(%rsp)
>    4:	45 89 ee             	mov    %r13d,%r14d
>    7:	e8 ad f0 ff ff       	call   0xfffffffffffff0b9
>    c:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
>   11:	e9 96 f6 ff ff       	jmp    0xfffffffffffff6ac
>   16:	80 3d 95 5b 9b 04 00 	cmpb   $0x0,0x49b5b95(%rip)        # 0x49b5bb2
>   1d:	0f 85 7c f7 ff ff    	jne    0xfffffffffffff79f
>   23:	c6 05 88 5b 9b 04 01 	movb   $0x1,0x49b5b88(%rip)        # 0x49b5bb2
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	e9 6e f7 ff ff       	jmp    0xfffffffffffff79f
>   31:	f3 90                	pause
>   33:	8b 05 e0 b4 29 04    	mov    0x429b4e0(%rip),%eax        # 0x429b519
>   39:	a8 01                	test   $0x1,%al
>   3b:	75 f4                	jne    0x31
>   3d:	89                   	.byte 0x89
>   3e:	84                   	.byte 0x84
>   3f:	24                   	.byte 0x24
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	e9 6e f7 ff ff       	jmp    0xfffffffffffff775
>    7:	f3 90                	pause
>    9:	8b 05 e0 b4 29 04    	mov    0x429b4e0(%rip),%eax        # 0x429b4ef
>    f:	a8 01                	test   $0x1,%al
>   11:	75 f4                	jne    0x7
>   13:	89                   	.byte 0x89
>   14:	84                   	.byte 0x84
>   15:	24                   	.byte 0x24
> [   32.918421] RSP: 0000:ffff888100e66f90 EFLAGS: 00010246
> [   32.924467] RAX: 0000000000000000 RBX: 1ffff110201cce49 RCX: 1ffff110201cce0b
> [   32.937135] RDX: 0000000000000000 RSI: 0000000000000034 RDI: 0000000000000cc0
> [   32.948122] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000cc0
> [   32.960471] R10: 0000000000000034 R11: ffffffff85810cb8 R12: ffff8881044540d0
> [   32.971576] R13: 1ffffffff0b0004b R14: 0000000000000000 R15: ffffffffffffffff
> [   32.982619] FS:  0000000000000000(0000) GS:ffff8882b4542000(0000) knlGS:0000000000000000
> [   32.996996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.005932] CR2: 0000000000000000 CR3: 00000000060ec001 CR4: 0000000000172ef0
> [   33.016941] Call Trace:
> [   33.022138]  <TASK>
> [   33.024508]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
> [   33.028510]  ? kernel_init_freeable (init/main.c:1419 (discriminator 1) init/main.c:1435 (discriminator 1) init/main.c:1455 (discriminator 1) init/main.c:1670 (discriminator 1))
> [   33.032827] ata1: SATA link down (SStatus 0 SControl 300)
> [   33.033110]  ? __pfx_stack_trace_consume_entry (usercopy_64.c:?)
> [   33.041995]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
> [   33.047459]  ? rcu_is_watching (include/linux/context_tracking.h:128 (discriminator 1) kernel/rcu/tree.c:753 (discriminator 1))
> [   33.051447] ata3: SATA link down (SStatus 0 SControl 300)
> [   33.056403] ata4: SATA link down (SStatus 0 SControl 300)
> [   33.061341]  ? trace_preempt_on (include/trace/events/preemptirq.h:53 (discriminator 30) kernel/trace/trace_preemptirq.c:120 (discriminator 30))
> [   33.061735] ata5: SATA link down (SStatus 0 SControl 300)
> [   33.069156] ata2: SATA link down (SStatus 0 SControl 300)
> [   33.073741] ata6: SATA link down (SStatus 0 SControl 300)
> [   33.079200]  ? preempt_count_sub (kernel/sched/core.c:6012 (discriminator 2) kernel/sched/core.c:6009 (discriminator 2) kernel/sched/core.c:6034 (discriminator 2))
> [   33.085087]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:211 kernel/locking/spinlock.c:221)
> [   33.089973]  ? stack_depot_save_flags (lib/stackdepot.c:728)
> [   33.094674]  ? kasan_save_stack (mm/kasan/common.c:57)
> [   33.098664]  ? kasan_save_track (mm/kasan/common.c:78)
> [   33.102720]  ? __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
> [   33.106722]  ? __kmalloc_cache_node_noprof (include/linux/kasan.h:263 mm/slub.c:5582)
> [   33.113247]  ? xhci_ring_alloc (include/linux/slab.h:1196 drivers/usb/host/xhci-mem.c:379)
> [   33.117224]  ? xhci_alloc_interrupter (drivers/usb/host/xhci-mem.c:2311)

This trace does look like that, or something related.

Regards,
Michal
