Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108A11CBD
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206264; cv=none; b=s1vsA3DBBwdxPyAP8g7wFs4xfdkifTRL+CkoOPuWFRm84m6mOxRYJeM+QDwlJAsX96alzF/uzSWQymK6hxjVDiQ9tE2Tp8Jh29k1K6+2mI+vIx7CzV+ifQagvf9ejVlX2dhI0mUghChDFbUmCXOnQhzAq+Fj3q2n4bROrB11vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206264; c=relaxed/simple;
	bh=9kbMn6YpChM5AonBd7P0EdzUPS03Dkt/DezgXrUlmDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJkD3ZU/nuvvOtDNgLgrtQpsBAPI9kjdySMSQ5KFfHrDBod77K5L1AuifzSY0uaXaiUOWZbhTtwOgThHHN6WgwY/D+ShtqUH4xfE+D2OnE6J88zWWhHpptnfe/A9MayHE59eHZRKgNUBi6XF51k0TsE97aCvJaiDFvUR7ryPt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+sQFsOg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+sQFsOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727206261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gHwfJb9Jq74Zp+MSNc/zGBlnegLnGX+F7dKDa/eoiY=;
	b=M+sQFsOgy5V3y/Lty+BYk71j8/WzKtwRZcKjJf0dncL8WeCkgUktEx7ObXcbN9sIwCN1+u
	a330yd5lFALWaGV+rIhfRSAWI0xyRifX+OR4X4OK8FwBDcCudHNGZLuv59MsBpRPLp2WH/
	ikqhVeQCiRu7ldtWex9ETy/6iJgv/cs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-rhqGR1ftNga6VAVdBWx_oQ-1; Tue, 24 Sep 2024 15:31:00 -0400
X-MC-Unique: rhqGR1ftNga6VAVdBWx_oQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e20937a68bso26604527b3.3
        for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 12:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727206259; x=1727811059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gHwfJb9Jq74Zp+MSNc/zGBlnegLnGX+F7dKDa/eoiY=;
        b=eyWRboJN3e0D6ExWaDxMrZyHaqDef0KbSh++19IbEFj7gmWKecv6DvJhX3bacMjvgf
         4VFB56bELcwSwQKnxOI37ASGFipfiQrCRd08M46ZTRglFNwoGp2czWw8Que1oNnu7EHe
         qQkY8owPoe13MJlgmb6TbTSb8Z5NmgZoMsHw6ymS7Fhzu31FjAXlcvhx8jJF8lrNm4xM
         tCcP/5O7WN3x6/6U3p5+t9ZTP30rdmT3Nn4t6m8krxRtB9Fik1LD8Twe3VmYfNByaWRx
         oUMW8Hqiur3DOmItEGh4Lqi2r9BNMvQdDxJt6CFY9yqgz44+wE5xfZvZzPAL3IR8WTcv
         ogDg==
X-Forwarded-Encrypted: i=1; AJvYcCVE4F0NbUGpqgmdqrkw4MiIP2OhVe72wqsHljw9I9p3N5kYGFpAGD909UExVeaMBlDGQ44Tlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdSMMFSMhJtCVGvcfnx7lnz2D5cmYvu+wtgrlksfqdcwySgPOu
	c+KE2kTdoQJ5oPwFNsnGzzbSZ4bHbqCLHBCx6WIcxrtunalKs4ZjDyZLlcUHIdbOrqLtMvcWh7u
	ovQjhCdTAL5DeYMxnC1NF2wlePxk66JwaVg9L3wtahrrmt/ExvX8T8fJEdAFz1bY1dI7SbDx0va
	YkOuU4CWEFzURdLk9NSkCJexiRaqE=
X-Received: by 2002:a05:690c:fd5:b0:615:1a0:78ea with SMTP id 00721157ae682-6e21d9d61e9mr6452467b3.34.1727206259250;
        Tue, 24 Sep 2024 12:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaolj6P4i0qjFzMZyNndz98E0I2Qssv/UEM6HEyqJk7BxXfmWHZzgUB9rpcSAzqfB5atMyGtdKKy/FUu/ENOg=
X-Received: by 2002:a05:690c:fd5:b0:615:1a0:78ea with SMTP id
 00721157ae682-6e21d9d61e9mr6452127b3.34.1727206258873; Tue, 24 Sep 2024
 12:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240919165641.4632-1-user@am64> <20240924020824.6264-1-user@am64>
 <8eb45005-c6fb-4baa-a44a-243958a3a1ba@suse.de> <c960dc48-0a05-4cad-b86b-33ad59923bc3@suse.de>
 <CADnq5_OtdUvOUPpq1aUoxtgpt6a4h598019SNhe+9ZWUaANYqg@mail.gmail.com>
In-Reply-To: <CADnq5_OtdUvOUPpq1aUoxtgpt6a4h598019SNhe+9ZWUaANYqg@mail.gmail.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 24 Sep 2024 15:30:47 -0400
Message-ID: <CAGtn9rmUfHHOGX-_7ZNUpJMjBkCOMaAuGQsJnpSrfjMfmK1xSQ@mail.gmail.com>
Subject: Re: radeon ARUBA NULL pointer dereference
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Arthur Marsh <arthur.marsh@internode.on.net>, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wuhoipok@gmail.com, iommu@lists.linux.dev, 
	"the arch/x86 maintainers" <x86@kernel.org>, Nilesh Javali <njavali@marvell.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think we are seeing a similar problem w/qla2xxx panicing at boot:

commit 1868f9d0260e9afaf7c6436d14923ae12eaea465 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 056f8c437dc3 96319dacaf15
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Sep 20 19:34:00 2024 -0700

    Merge tag 'for-linux-6.12-ofs1' of
git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux

[    3.376687] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA
Driver: 10.02.09.300-k.
[    3.385285] qla2xxx [0000:c4:00.0]-011c: : MSI-X vector count: 16.
[    3.391502] qla2xxx [0000:c4:00.0]-001d: : Found an ISP2261 irq 121
iobase 0x000000003b0c542c.
[    3.400118] BUG: kernel NULL pointer dereference, address: 0000000000000=
0a0
[    3.407075] #PF: supervisor read access in kernel mode
[    3.412215] #PF: error_code(0x0000) - not-present page
[    3.417356] PGD 0 P4D 0
[    3.419896] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    3.424776] CPU: 0 UID: 0 PID: 413 Comm: kworker/0:2 Not tainted 6.11.0+=
 #1
[    3.431731] Hardware name: Dell Inc. PowerEdge R6515/04F3CJ, BIOS
2.13.3 09/12/2023
[    3.439386] Workqueue: events work_for_cpu_fn
[    3.443744] RIP: 0010:dma_get_required_mask+0x11/0x50
[    3.448796] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 87 38 02 00 00 48 85
c0 74 12 <48> 8b 80 a0 00 00 00 48 85 c0 74 20 e9 fe f1 b7 00 cc 48 8b
05 9e
[    3.467542] RSP: 0018:ffffb05741007d80 EFLAGS: 00010202
[    3.472769] RAX: 0000000000000000 RBX: 0000000000000055 RCX: ffff9f8601f=
92088
[    3.479901] RDX: ffffb05740e07000 RSI: ffffffffffffffff RDI: ffff9f8601f=
920c8
[    3.487032] RBP: ffff9f861b3ec000 R08: 0000000000000000 R09: ffffb057410=
07b10
[    3.494165] R10: ffffb05741007b08 R11: ffffffff831e15c8 R12: ffff9f8601f=
92000
[    3.501299] R13: ffff9f861b3ec4a8 R14: 0000000000001000 R15: 00000000000=
02000
[    3.508432] FS:  0000000000000000(0000) GS:ffff9f896f200000(0000)
knlGS:0000000000000000
[    3.516517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.522261] CR2: 00000000000000a0 CR3: 000000011d930000 CR4: 00000000003=
50ef0
[    3.529394] Call Trace:
[    3.531848]  <TASK>
[    3.533954]  ? __die+0x20/0x70
[    3.537012]  ? page_fault_oops+0x75/0x170
[    3.541028]  ? exc_page_fault+0x64/0x140
[    3.544951]  ? asm_exc_page_fault+0x22/0x30
[    3.549141]  ? dma_get_required_mask+0x11/0x50
[    3.553584]  qla2x00_probe_one+0x12a1/0x1cb0 [qla2xxx]
[    3.558758]  ? srso_return_thunk+0x5/0x5f
[    3.562770]  ? __update_idle_core+0x5b/0xb0
[    3.566958]  local_pci_probe+0x46/0xa0
[    3.570711]  work_for_cpu_fn+0x16/0x20
[    3.574459]  process_one_work+0x17c/0x390
[    3.578474]  worker_thread+0x239/0x340
[    3.582227]  ? __pfx_worker_thread+0x10/0x10
[    3.586497]  kthread+0xcf/0x100
[    3.589643]  ? __pfx_kthread+0x10/0x10
[    3.593398]  ret_from_fork+0x30/0x50
[    3.596975]  ? __pfx_kthread+0x10/0x10
[    3.600728]  ret_from_fork_asm+0x1a/0x30
[    3.604660]  </TASK>
[    3.606846] Modules linked in: qla2xxx(+) sd_mod sg nvme_fc
nvme_fabrics ahci(+) nvme_keyring libahci crct10dif_pclmul
crc32_pclmul ccp nvme_core crc32c_intel libata nvme_auth
ghash_clmulni_intel megaraid_sas tg3 scsi_transport_fc sp5100_tco wmi
dm_mirror dm_region_hash dm_log dm_mod
[    3.631945] CR2: 00000000000000a0
[    3.635265] ---[ end trace 0000000000000000 ]---
[    3.728765] RIP: 0010:dma_get_required_mask+0x11/0x50
[    3.733828] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 87 38 02 00 00 48 85
c0 74 12 <48> 8b 80 a0 00 00 00 48 85 c0 74 20 e9 fe f1 b7 00 cc 48 8b
05 9e
[    3.752572] RSP: 0018:ffffb05741007d80 EFLAGS: 00010202
[    3.757798] RAX: 0000000000000000 RBX: 0000000000000055 RCX: ffff9f8601f=
92088
[    3.764930] RDX: ffffb05740e07000 RSI: ffffffffffffffff RDI: ffff9f8601f=
920c8
[    3.772062] RBP: ffff9f861b3ec000 R08: 0000000000000000 R09: ffffb057410=
07b10
[    3.779197] R10: ffffb05741007b08 R11: ffffffff831e15c8 R12: ffff9f8601f=
92000
[    3.786328] R13: ffff9f861b3ec4a8 R14: 0000000000001000 R15: 00000000000=
02000
[    3.793460] FS:  0000000000000000(0000) GS:ffff9f896f200000(0000)
knlGS:0000000000000000
[    3.801548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.807292] CR2: 00000000000000a0 CR3: 000000011d930000 CR4: 00000000003=
50ef0
[    3.814425] Kernel panic - not syncing: Fatal exception
[    3.821267] Kernel Offset: 0x600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    3.890453] pstore: backend (erst) writing error (-28)
[    3.895598] ---[ end Kernel panic - not syncing: Fatal exception ]---

On Tue, Sep 24, 2024 at 10:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Sep 24, 2024 at 8:43=E2=80=AFAM Thomas Zimmermann <tzimmermann@su=
se.de> wrote:
> >
> >
> >
> > Am 24.09.24 um 14:20 schrieb Thomas Zimmermann:
> > > (cc: DMA and x86 folks)
> > >
> > > Hi
> > >
> > > Am 24.09.24 um 04:08 schrieb Arthur Marsh:
> > >> Using current Linus git head kernel, I was able to save the dmesg
> > >> output:
> > >>
> > >> [   17.218724] [drm] radeon kernel modesetting enabled.
> > >> [   17.218778] radeon 0000:00:01.0: vgaarb: deactivate vga console
> > >> [   17.219509] Console: switching to colour dummy device 80x25
> > >> [   17.219700] [drm] initializing kernel modesetting (ARUBA
> > >> 0x1002:0x990C 0x1002:0x0123 0x00).
> > >> [   17.219773] ATOM BIOS: 113
> > >> [   17.219838] radeon 0000:00:01.0: VRAM: 768M 0x0000000000000000 -
> > >> 0x000000002FFFFFFF (768M used)
> > >> [   17.219841] radeon 0000:00:01.0: GTT: 1024M 0x0000000030000000 -
> > >> 0x000000006FFFFFFF
> > >> [   17.219844] [drm] Detected VRAM RAM=3D768M, BAR=3D256M
> > >> [   17.219845] [drm] RAM width 64bits DDR
> > >> [   17.219851] BUG: kernel NULL pointer dereference, address:
> > >> 00000000000000a0
> > >
> > > This is 160 bytes behind NULL, which indicates a field within a struc=
t.
> > >
> > >> [   17.219852] #PF: supervisor read access in kernel mode
> > >> [   17.219853] #PF: error_code(0x0000) - not-present page
> > >> [   17.219854] PGD 0 P4D 0
> > >> [   17.219856] Oops: Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
> > >> [   17.219858] CPU: 0 UID: 0 PID: 451 Comm: udevd Not tainted 6.11.0=
+
> > >> #6121
> > >> [   17.219860] Hardware name: Gigabyte Technology Co., Ltd. To be
> > >> filled by O.E.M./F2A78M-HD2, BIOS F2 05/28/2014
> > >> [   17.219862] RIP: 0010:dma_get_required_mask+0x11/0x50
> > >> [   17.219868] Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> > >> 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 87 68 02 00 00 48 85
> > >> c0 74 11 <48> 8b 80 a0 00 00 00 48 85 c0 74 1f e9 ee ed 94 00 f6 87
> > >> 2c 03 00
> > >> [   17.219870] RSP: 0018:ffffa54bc13a7b00 EFLAGS: 00010202
> > >> [   17.219871] RAX: 0000000000000000 RBX: 000000ffffffffff RCX:
> > >> 0000000000000000
> > >> [   17.219872] RDX: 0000000000000000 RSI: 0000000000000027 RDI:
> > >> ffff976f44e720c8
> > >> [   17.219873] RBP: ffff976f44e720c8 R08: 00000000ffffefff R09:
> > >> ffffffffab2aab08
> > >> [   17.219874] R10: 00000000fffff000 R11: 0000000000000002 R12:
> > >> 0000000000000000
> > >> [   17.219875] R13: ffff976f48a4aa30 R14: 0000000000000000 R15:
> > >> 0000000000000028
> > >> [   17.219876] FS:  00007f59a070d840(0000) GS:ffff97726f800000(0000)
> > >> knlGS:0000000000000000
> > >> [   17.219878] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   17.219879] CR2: 00000000000000a0 CR3: 00000001053b4000 CR4:
> > >> 00000000000406f0
> > >> [   17.219880] Call Trace:
> > >> [   17.219881]  <TASK>
> > >> [   17.219882]  ? __die_body.cold+0x19/0x1e
> > >> [   17.219885]  ? page_fault_oops+0xa8/0x230
> > >> [   17.219889]  ? search_module_extables+0x4f/0x90
> > >> [   17.219891]  ? fixup_exception+0x36/0x2f0
> > >> [   17.219894]  ? exc_page_fault+0x88/0x1b0
> > >> [   17.219897]  ? asm_exc_page_fault+0x22/0x30
> > >> [   17.219900]  ? dma_get_required_mask+0x11/0x50
>
> Also reported here:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3648
>
> Alex
>
> > >
> > > This is not in the radeon driver but the DMA code. I'd say it's at
> > > [1], as get_required_mask is 160 bytes within struct drm_map_ops. The
> > > call to get_arch_dma_ops() probably returns NULL.
> >
> > And indeed, when I added
> >
> >      pr_warn("dev dma ops: 0x%p\n", pdev->dev.dma_ops);
> >      pr_warn("arch dma ops: 0x%p\n", get_arch_dma_ops());
> >
> > to radeon_pci_probe(), I got
> >
> > [   22.325657] dev dma ops: 0x0000000000000000
> > [   22.342921] arch dma ops: 0x0000000000000000
> >
> > as a result.
> >
> > Best regards
> > Thomas
> >
> > >
> > > Best regards
> > > Thomas
> > >
> > > [1]
> > > https://elixir.bootlin.com/linux/v6.11/source/kernel/dma/mapping.c#L5=
23
> > > [2]
> > > https://elixir.bootlin.com/linux/v6.11/source/include/linux/dma-map-o=
ps.h#L98
> > >
> > >> [   17.219902] dma_addressing_limited+0x6c/0xb0
> > >> [   17.219905]  radeon_ttm_init+0x3f/0x210 [radeon]
> > >> [   17.219977]  cayman_init+0x97/0x290 [radeon]
> > >> [   17.220057]  radeon_device_init+0x5e9/0xb40 [radeon]
> > >> [   17.220115]  radeon_driver_load_kms+0xb0/0x260 [radeon]
> > >> [   17.220174]  radeon_pci_probe+0xff/0x170 [radeon]
> > >> [   17.220231]  pci_device_probe+0xbe/0x1a0
> > >> [   17.220234]  really_probe+0xde/0x350
> > >> [   17.220237]  ? pm_runtime_barrier+0x61/0xb0
> > >> [   17.220240]  ? __pfx___driver_attach+0x10/0x10
> > >> [   17.220242]  __driver_probe_device+0x78/0x110
> > >> [   17.220245]  driver_probe_device+0x2d/0xc0
> > >> [   17.220247]  __driver_attach+0xc9/0x1c0
> > >> [   17.220249]  bus_for_each_dev+0x6a/0xb0
> > >> [   17.220251]  ? migrate_enable+0xbf/0xf0
> > >> [   17.220254]  bus_add_driver+0x139/0x220
> > >> [   17.220256]  driver_register+0x6e/0xc0
> > >> [   17.220258]  ? __pfx_radeon_module_init+0x10/0x10 [radeon]
> > >> [   17.220315]  do_one_initcall+0x42/0x210
> > >> [   17.220318]  ? __kmalloc_cache_noprof+0x89/0x230
> > >> [   17.220321]  do_init_module+0x60/0x210
> > >> [   17.220324]  init_module_from_file+0x89/0xc0
> > >> [   17.220326]  __x64_sys_finit_module+0x142/0x390
> > >> [   17.220329]  do_syscall_64+0x47/0x110
> > >> [   17.220331]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >> [   17.220334] RIP: 0033:0x7f59a0625279
> > >> [   17.220336] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> > >> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > >> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 6b 0d 00 f7 d8 64
> > >> 89 01 48
> > >> [   17.220337] RSP: 002b:00007ffd15ee7df8 EFLAGS: 00000246 ORIG_RAX:
> > >> 0000000000000139
> > >> [   17.220339] RAX: ffffffffffffffda RBX: 00005578ae660840 RCX:
> > >> 00007f59a0625279
> > >> [   17.220340] RDX: 0000000000000000 RSI: 00005578ae677fc0 RDI:
> > >> 0000000000000011
> > >> [   17.220341] RBP: 0000000000000000 R08: 00007f59a06fcb20 R09:
> > >> 00005578ae640550
> > >> [   17.220342] R10: 0000000000000040 R11: 0000000000000246 R12:
> > >> 00005578ae677fc0
> > >> [   17.220342] R13: 0000000000020000 R14: 00005578ae651750 R15:
> > >> 0000000000000000
> > >> [   17.220344]  </TASK>
> > >> [   17.220345] Modules linked in: radeon(+) snd_hda_codec_hdmi
> > >> snd_seq_midi snd_seq_midi_event snd_seq snd_hda_intel
> > >> snd_intel_dspcfg snd_emu10k1 snd_hda_codec drm_ttm_helper ttm
> > >> snd_util_mem drm_suballoc_helper snd_ac97_codec snd_hda_core
> > >> drm_display_helper ac97_bus snd_rawmidi snd_hwdep snd_seq_device
> > >> snd_pcm drm_kms_helper edac_mce_amd sha512_ssse3 sha512_generic
> > >> k10temp sha256_ssse3 sha1_ssse3 drm aesni_intel snd_timer gf128mul
> > >> crypto_simd cryptd acpi_cpufreq evdev pcspkr serio_raw emu10k1_gp
> > >> gameport at24 regmap_i2c i2c_algo_bit snd video soundcore wmi button
> > >> sp5100_tco ext4 crc32c_generic crc16 mbcache jbd2 uas usb_storage
> > >> hid_generic usbhid hid sg sr_mod sd_mod cdrom ata_generic
> > >> firewire_ohci crc32_pclmul crc32c_intel firewire_core crc_itu_t
> > >> pata_atiixp i2c_piix4 i2c_smbus ahci r8169 libahci xhci_pci ohci_pci
> > >> realtek libata mdio_devres ehci_pci ohci_hcd xhci_hcd scsi_mod
> > >> ehci_hcd scsi_common usbcore libphy usb_common
> > >> [   17.220388] CR2: 00000000000000a0
> > >> [   17.220390] ---[ end trace 0000000000000000 ]---
> > >>
> > >> Happy to provide additional information and run tests.
> > >>
> > >> Regards,
> > >>
> > >> Arthur Marsh.
> > >
> >
> > --
> > --
> > Thomas Zimmermann
> > Graphics Driver Developer
> > SUSE Software Solutions Germany GmbH
> > Frankenstrasse 146, 90461 Nuernberg, Germany
> > GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> > HRB 36809 (AG Nuernberg)
> >
>

