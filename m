Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCB3DE440
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289610; cv=none; b=Jg5wAha976D9bBtS6E7Cvzy8HUTzMTncAPZyRCpuREIEL0UfiEw0guS6Alu/rFukgfMeGk4bLx/FPTrWIsdEVef6BczM1q4gvSAQWITIOInE7ZqVnlqoryhLzgsXagmxN6p5Al6cLRHtrEcdHx9XhQ0MvVq4KnmzGR2x7PnJ0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289610; c=relaxed/simple;
	bh=k1XNn44v3qsaD0EI0G0pfPOXJSQRZQe0hXtKXACW6ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrpU+1HXPAFn5483vq1fqQpRr4BtMLEFmorfjN8Ekh5SZLkZ77gkwQv7o+475CGpKnNDXOr/4KzxAFoqTC4SPOajZFTlCWUbM7/uE6tApKcNqQsfsK2pflx7BJzEhj0/5Cb48lPQHCNppEn8cP5cMX1ZOqKr/VaHJUKeJgu6OPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXCwAYOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXCwAYOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784289606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
	b=TXCwAYOrTYiC6dMfv5eJlIEnLNjRE8ZTsXoGV0elMpg+dTEkb5AmYWQoptG9qBVL/dIKRO
	19qN+xUmrRTD2UYx6K9RhOF077VK3D9OA6wzpjc6X1/vgz+0/sMP7oJZaNxID+QTEH9L10
	BLVLYFpA+VremmXGhVlxCmooMpk/pJM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-M0pH4sFcOPyUzSTgWRI98g-1; Fri, 17 Jul 2026 08:00:04 -0400
X-MC-Unique: M0pH4sFcOPyUzSTgWRI98g-1
X-Mimecast-MFC-AGG-ID: M0pH4sFcOPyUzSTgWRI98g_1784289603
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49001defc4dso11047415b6e.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 05:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289603; x=1784894403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNMO1oYrbjElfFaSy7vQKoIRJB+LB6OR3rh+O+eE0CA=;
        b=sWRcZd77U7vXJhxlVWIfIuUwaAjhEqgohZLlZmCzHjX22qL5o86AK1UOMuixHQ10ZQ
         krasBzZxbLH/+0rpVem/+iAaNUrz3fKwGPrcMyui+VTiALxsX+RYrWrjlNIso11HFMJF
         72iS9X+V7YDJ9cmhT6trAbEtE7P4S2UPzcrz/0h2hvBpkH5/AlsvIoFbszTnWVB9efTJ
         Kv/ldsNzeEMqT19kfrHsDL9kWG2GpYZtIeyNAIv+Taf0ZLWu9sE5lxwzIU48VjxWoMgk
         SaN5ow2hSRZCoP06v/4k1ItGCIgwijuGY2RCs4bzxAF2Rgp7u5xl3qRlsODR86/l+MpP
         gylg==
X-Forwarded-Encrypted: i=1; AHgh+Rrha867ZXcI3alf330FzuKOAU1dngrKvSIknXqAEiJPw709PabAzV8blhZGiVq/WXegpecsYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmDZFb/A6HQ2GhlpSwp79Inq1oNMFlBLMMdx39AFWfgD/xQecV
	G6knzZSc2BdbMXE78LUqyaj9sld3coZpXFyO0wTmwoCRCvpoRRcdDbzDrp6XFTVBgB5FC40sGv2
	wO/UtX+IOfPkuLEebpswTik6/7gZRowFzbxGsyCO3QoB21fDpJim9fRxf7ejQ4+AMp6T3JyF6px
	zWf25667R38vQLj8gXfX1HmS+kG9Gzat8=
X-Gm-Gg: AfdE7cnEAEiYVFeJRmy1fmQOJzV6KeaOm70Qe1t9hBvXlNhgp4UuuZ2v83psgPH294O
	Iv3F27ht691+HxpZkKBptiv3j7IZ5Nlp5NuOf+ItF+0bVFrd4TwDPT9y7SVCsqLUAzemUxM9YoE
	kL/6Rus+upRPB+GBGpxBYF0k4AL0ieTvb2wdcXkdQFoN8ZeZ42znhZdeh02gKj5tIfQeE8863cA
	dEX4BfwMuSBLt0Q9Q==
X-Received: by 2002:a05:6808:6902:b0:496:1009:ec5a with SMTP id 5614622812f47-4a4d0160614mr1146337b6e.1.1784289603057;
        Fri, 17 Jul 2026 05:00:03 -0700 (PDT)
X-Received: by 2002:a05:6808:6902:b0:496:1009:ec5a with SMTP id
 5614622812f47-4a4d0160614mr1146300b6e.1.1784289602009; Fri, 17 Jul 2026
 05:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629144837.3244851-1-desnesn@redhat.com>
In-Reply-To: <20260629144837.3244851-1-desnesn@redhat.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 17 Jul 2026 08:59:49 -0300
X-Gm-Features: AUfX_mzpKeLRkWyX5IJziXQww7lPcrKAFEzEkmYK5hcKf6-cJXL-hIHQkRlAgFA
Message-ID: <CACaw+eyE+Rk3NeGaWmo=Psw+aDNp4=Ggzj3DnrkL-fp04NZc+g@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IN_QYLy3Mn5JdrfKh9atHbh7TO_MkKr3b3mqEFvmdDE_1784289603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Baolu,

Can I further assist with any more requests or answering any remaining
questions since the v1 review?

Best regards,

Desnes

On Mon, Jun 29, 2026 at 11:49=E2=80=AFAM Desnes Nunes <desnesn@redhat.com> =
wrote:
>
> When translation is already enabled at boot (e.g. kdump), the vt-d driver
> copies context tables from the previous kernel's root table. In scalable
> mode, buses that only populate the upper root half (UCTP, devfn >=3D 0x80=
)
> should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
> However, the current copy path always uses tbl[tbl_idx + 0] in this situa=
-
> tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
> LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co=
-
> pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after=
-
> wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
>
> In short, devices on bus 0x80 with devfn >=3D 0x80 fail DMA with fault 0x=
39,
> which will break drivers running in kernels with translation pre-enabled.
> This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>
> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000=
 [fault reason 0x39] SM: Present bit in Root Entry is clear
>
> For instance, this fault yielded to locking issues between systemd and
> xHCI, blocking a system's reboot after a vmcore was captured with kdump:
>
> [   72.987601] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=
=3D2193 is taking a long time
> [  132.237566] dracut-initqueue[277]: Timed out while waiting for udev qu=
eue to empty.
> [  202.988014] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=
=3D2193 killed
> [  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by signa=
l 9 (KILL).
> ...
> [  206.288378] kdump[569]: saving vmcore complete
> ...
> [  206.821258] systemd-shutdown[1]: Rebooting.
> [  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 second=
s.
> [  246.865319]       Not tainted 7.0.0-clean #1
> [  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11   =
 ppid:2      task_flags:0x4208160 flags:0x00080000
> [  246.888942] Workqueue: usb_hub_wq hub_event
> [  246.893202] Call Trace:
> [  246.895690]  <TASK>
> [  246.897828]  __schedule+0x299/0x5c0
> [  246.901378]  schedule+0x27/0x80
> [  246.904572]  schedule_timeout+0xbd/0x100
> [  246.908565]  __wait_for_common+0x97/0x1b0
> [  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
> [  246.917252]  xhci_alloc_dev+0x9e/0x2b0
> [  246.921068]  usb_alloc_dev+0x7a/0x3b0
> [  246.924795]  hub_port_connect+0x285/0x960
> [  246.928873]  hub_port_connect_change+0x94/0x290
> [  246.933482]  port_event+0x4bb/0x840
> [  246.937030]  hub_event+0x141/0x460
> [  246.940489]  process_one_work+0x196/0x390
> [  246.944569]  worker_thread+0x1af/0x320
> [  246.948383]  ? __pfx_worker_thread+0x10/0x10
> [  246.952724]  kthread+0xe3/0x120
> [  246.955921]  ? __pfx_kthread+0x10/0x10
> [  246.959736]  ret_from_fork+0x199/0x260
> [  246.963550]  ? __pfx_kthread+0x10/0x10
> [  246.967362]  ret_from_fork_asm+0x1a/0x30
> [  246.971355]  </TASK>
> [  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 sec=
onds.
> [  369.745593]       Not tainted 7.0.0-clean #1
> [  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1   pp=
id:0      task_flags:0x400100 flags:0x00080000
> [  369.769128] Call Trace:
> [  369.771616]  <TASK>
> [  369.773752]  __schedule+0x299/0x5c0
> [  369.777299]  schedule+0x27/0x80
> [  369.780493]  schedule_preempt_disabled+0x15/0x30
> [  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
> [  369.789974]  device_shutdown+0xac/0x1b0
> [  369.793877]  kernel_restart+0x3a/0x70
> [  369.797603]  __do_sys_reboot+0x147/0x240
> [  369.801595]  do_syscall_64+0x11b/0x6a0
> [  369.805407]  ? handle_mm_fault+0x110/0x350
> [  369.809574]  ? do_user_addr_fault+0x206/0x680
> [  369.814006]  ? irqentry_exit+0x7a/0x4d0
> [  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  369.823046] RIP: 0033:0x7fe2958da917
> [  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000a9
> [  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe29=
58da917
> [  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000f=
fffffff
> [  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 000000000=
0000000
> [  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 000000000=
0000000
> [  369.870659]  </TASK>
> [  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex likely =
owned by task kworker/0:1:11.
>
> Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel=
")
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
> V1 -> V2: Updated commit message and added xHCI stack trace as requested
>
> v1: https://lore.kernel.org/linux-iommu/ajnlKDglN6wEBBrS@google.com/T/#t
>
>  drivers/iommu/intel/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..737936f942a0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                               struct context_entry **tbl,
>                               int bus, bool ext)
>  {
> -       int tbl_idx, pos =3D 0, idx, devfn, ret =3D 0, did;
> +       int tbl_idx, tbl_slot =3D 0, idx, devfn, ret =3D 0, did;
>         struct context_entry *new_ce =3D NULL, ce;
>         struct context_entry *old_ce =3D NULL;
>         struct root_entry re;
> @@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *=
iommu,
>                 if (idx =3D=3D 0) {
>                         /* First save what we may have and clean up */
>                         if (new_ce) {
> -                               tbl[tbl_idx] =3D new_ce;
> +                               tbl[tbl_idx + tbl_slot] =3D new_ce;
>                                 __iommu_flush_cache(iommu, new_ce,
>                                                     VTD_PAGE_SIZE);
> -                               pos =3D 1;
>                         }
>
>                         if (old_ce)
> @@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                                 }
>                         }
>
> +                       /* Track if saving UCTP or LCTP entries in scalab=
le mode */
> +                       tbl_slot =3D ext && devfn >=3D 0x80 ? 1 : 0;
> +
>                         ret =3D -ENOMEM;
>                         old_ce =3D memremap(old_ce_phys, PAGE_SIZE,
>                                         MEMREMAP_WB);
> @@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *i=
ommu,
>                 new_ce[idx] =3D ce;
>         }
>
> -       tbl[tbl_idx + pos] =3D new_ce;
> +       tbl[tbl_idx + tbl_slot] =3D new_ce;
>
>         __iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>
> --
> 2.54.0
>

