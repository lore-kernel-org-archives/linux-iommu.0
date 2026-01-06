Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B234DB4B
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728890; cv=pass; b=RSLvhwVAG1zevybPoF4bTnAQK9LgDQ3Y4RCgj2hbjj5/U3b1EfyUhDG0gq+AC4wDDd5jauq7KojutT/NG3H5Ls0U3oQRPdc0QXkHRIjDJjqnb8Z6sDnFVs8dFhpevtVCr6cyJEF09vBtDDNglE4ZE62AWwdxFbzh6rDoVf7kugA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728890; c=relaxed/simple;
	bh=1YnjR/UJ25pEnbpL/aXyQKLrts/m65bSQntodSlPo/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJb2UJwC6Q/4lYOkp0a4kMlyQo37PK2zneq/t6eb0OCA5PaSf96accANNDNFIHNrzZBP18QUWy2+fQU7HSoGw/LNs7SEuVJL2Uu8JbRGxcFg4jf4/bkvobJJ3tQQ0Glp5FWr9lugGssMSrFdiIHEuFKW0Y9+k3AFWnPwCb1EKy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eI4J6/0W; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eI4J6/0W"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f34f257a1bso61581cf.0
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 11:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767728888; cv=none;
        d=google.com; s=arc-20240605;
        b=iw+9CKcf/+Yp49hRrzaRhuAtuwpuQO43dDZ1fSWhsGRyBgTwls2R+eYW7EPLoIr7pu
         ogLDfbiJr8+5J4fNMlNd+MXSBE4Z5E1ItzwJlmFLI7GhcN6D06D1aGg0H8VmZYDIeKU6
         oPNgY/nHebcVbeoMwT0V3QA6OCsQnZsVNg+QHVFq/S0hKWAJ6t33laaEgbdXzZmggO3J
         fy4aaVu5wxG0ofNwzXEKI4OBRMRX41mKJsD1AMjPRJ5RdiZAgSZlFVjpzLe0k7fZcBDd
         auWcSrDEWvBDylZk3m5mILkKsozk6zjTEFlCoIt0AxU7cd2rVQPX8knrQ/28r6LT+WHx
         souQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wS9AM92Mn02DFNJwpffp+t4vLG7gYdsW/Jw2tqGYH/I=;
        fh=UYoRL9P/OmhDSb1i5tj2KrdpwE7T56KONQS3xsC+l3M=;
        b=HpAQ5j+1p4TIcAyb5vSe4Ruux0V+9/XBiJiDLXfmCe+l3a1cN4rYGOrrYhvIjpTMOM
         7BvMMcG70hnN8NKk+Rm0VnNKXnvh+tqwg6KqctTg52sCKxBVVt0YEpWVBM9aIff6aOQ6
         +C3OdHwUiL5lYXktoEoLMv6DKjS4/yhIyixfUOybiU8ZXuWQIvy3oWQ/xtLfUOa/51tx
         EO/88He3hdfGQ3TZr1ksyXCNpIVsQMTNIBerzgGx9O+355/eVkkHXfmcorX+MEe0CSyf
         8IY4AkT+4A7ygHdnWKtWApbREx2QpQJZ1fCoDmgv6hOaNjDzyUAQn3KV2UfGSFdhSzr0
         uIIQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767728888; x=1768333688; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS9AM92Mn02DFNJwpffp+t4vLG7gYdsW/Jw2tqGYH/I=;
        b=eI4J6/0Wl1pJJr2A+pU8C/2g6fHtToi/2gsWRZTAJ8pRKu1KZnOFeAroSRrWFPDSsz
         SXS2YbdynVrKYKoevyqRMpoYA6Cd3HeYd51CASgjXCz1qJZvY/GKwKSubilK4T1fIIUz
         rAH39X/NHttSDeTSA5Q+goVYwpda2g85U9QYomc6NI8O2xTRPq4zJcg8lLur2qE36g3r
         5KpS56AArR171MQcL8XvRui1Xp5s85xr9lRDIUH5fNRsPehMw3SrJ/89++ztFut3av38
         6sTJ7RDSeyoyIrnbtw5CLAQ8UntopH1AX26wAN3ksIapMjRVUFaVTIbJ43srU74f5VNe
         y/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728888; x=1768333688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wS9AM92Mn02DFNJwpffp+t4vLG7gYdsW/Jw2tqGYH/I=;
        b=lkgGsV2PxrvSwydBe0slZXBO837Seqh7sAq5Zgx5ScbnwYTdMg6zw1zbUamOyyXKSg
         pz07DW2xaXQoDITwlKGjt7WRW0ypShOXGRJofTBebzVmD+LniMYxVi8eeyuZg0DRup+/
         In4Z3ZyqVO0uL4O2/yIs6EAvxxn4i9R04i8EYx0++lOXKiQy1rp6DB7NGSXTHHODBsY5
         D9ygBou9DQhnmXhJcgu+nukgeJ8ZDCcQZr292M2ka2fibcB1ILkW+8c7bgXbL7ii7FZP
         miXOygiu3+O2eymQMeSsa5H9LxNj7tSctcvPN9a73GfqMoTSlL41qDU7wz/Lx325sIVR
         AFBA==
X-Forwarded-Encrypted: i=1; AJvYcCV6MMG4lpe2afPPJE+yZOIB9S/4Dcd3VsPGPNao89yGMuFp7JoeoWhTY3PrIPhboNG8IPUgXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ0gB8UR23XOjqZ7GqsUjoHNUG9vlpnxsUP5UhNvDPadZc/v+G
	pyu/nKdskzjwSkywhjW2e8ngGtt1zC+ZWDK37vaVR7zdW1ejAaaA/iq86Jyl34Dr4+BZ6ofkWv2
	pu0Sdf+zA+mebYQsXxk1OarHZEsBb2zb+Y4aRYV35
X-Gm-Gg: AY/fxX4e0YqGgIEVe8mLWDfn15/hSPP4PxRe5PfiaStpCg98+0LGLdfhFQB3tIOZaBS
	cKC79FigrA+MnPXitnZfDkHvs1TTRIL82BSwW+5M2zeE5WeCyJfEILijYAP+DBDyMDOKJ+Y1nKT
	1xdhM2ziK4M3N2HsvHu6H7bhAY+sVygayHz8WE8bJUrhuH7udqOw/Cj9bxbpC2eeJnxDLlBIvbK
	G8/iKaSgjMlR5xUFDd67obxOswzoeVrbklQOfvrjpoiiwUKIa2QGbdm1/+neQz5iPummyIsmWvX
	GUsxaoiOroY1Xhjb75elyFpgsqI=
X-Google-Smtp-Source: AGHT+IF97VK6tDNOBZzvsiPagHn7GUyN7RhOp87+78douastKbgccj1G+jkn3mhW/jYBWjzTxn9oVW+lOpm9CmPfSSI=
X-Received: by 2002:a05:622a:34b:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4ffb3f2370emr1151991cf.9.1767728887404; Tue, 06 Jan 2026
 11:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251210181417.3677674-1-rananta@google.com> <20251210181417.3677674-7-rananta@google.com>
 <aUSNoBzvybi24SUD@google.com>
In-Reply-To: <aUSNoBzvybi24SUD@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 6 Jan 2026 11:47:56 -0800
X-Gm-Features: AQt7F2rAfTk-cbu6zx3OjEoh2OdQyifmOtjD8UmvvrzmBuM80EpWXTesyjQ404M
Message-ID: <CAJHc60zAB8pyc7=ca=eOf+SEEvnZ3JxVEnZoOtgj+mX1GQiALw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ cc: iommu@lists.linux.dev for the crash

Thank you.
Raghavendra


On Thu, Dec 18, 2025 at 3:26=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-12-10 06:14 PM, Raghavendra Rao Ananta wrote:
> > Add a selfttest, vfio_pci_sriov_uapi_test.c, to validate the
> > SR-IOV UAPI, including the following cases, iterating over
> > all the IOMMU modes currently supported:
> >  - Setting correct/incorrect/NULL tokens during device init.
> >  - Close the PF device immediately after setting the token.
> >  - Change/override the PF's token after device init.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>
> I hit the following kernel NULL pointer dereference after running the
> new test a few times (nice!).
>
> Repro:
>
>   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:16:00.1
>   $ tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test 0000:16:00.1
>   $ tools/testing/selftests/vfio/scripts/cleanup.sh
>   ... repeat ...
>
> The panic:
>
> [  553.245784][T27601] vfio-pci 0000:1a:00.0: probe with driver vfio-pci =
failed with error -22
> [  553.256622][T27601] vfio-pci 0000:1a:00.0: probe with driver vfio-pci =
failed with error -22
> [  574.857650][T27935] BUG: kernel NULL pointer dereference, address: 000=
0000000000008
> [  574.865322][T27935] #PF: supervisor read access in kernel mode
> [  574.871175][T27935] #PF: error_code(0x0000) - not-present page
> [  574.877021][T27935] PGD 4116e63067 P4D 40fb0a3067 PUD 409597f067 PMD 0
> [  574.883654][T27935] Oops: Oops: 0000 [#1] SMP NOPTI
> [  574.888551][T27935] CPU: 100 UID: 0 PID: 27935 Comm: vfio_pci_sriov_ T=
ainted: G S      W           6.18.0-smp-DEV #1 NONE
> [  574.899600][T27935] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
> [  574.905104][T27935] Hardware name: Google Izumi-EMR/izumi, BIOS 0.2025=
0801.2-0 08/25/2025
> [  574.913289][T27935] RIP: 0010:rb_insert_color+0x44/0x110
> [  574.918623][T27935] Code: cc cc 48 89 cf 48 83 cf 01 48 89 3a 48 89 38=
 48 8b 01 48 89 cf 48 83 e0 fc 48 89 01 74 d7 48 8b 08 f6 c1 01 0f 85 c1 00=
 00 00 <48> 8b 51 08 48 39 c2 74 0c 48 85 d2 74 4f f6 02 01 74 c5 eb 48 48
> [  574.938080][T27935] RSP: 0018:ff85113dcdd6bb08 EFLAGS: 00010046
> [  574.944013][T27935] RAX: ff3f257594a99e80 RBX: ff3f25758af490c0 RCX: 0=
000000000000000
> [  574.951857][T27935] RDX: 0000000000001a00 RSI: ff3f25360038eb70 RDI: f=
f3f2536658bbee0
> [  574.959702][T27935] RBP: ff3f25360038ea00 R08: 0000000000000002 R09: f=
f85113dcdd6badc
> [  574.967544][T27935] R10: ff3f257590ab8000 R11: ffffffffa78210a0 R12: f=
f3f2536658bbea0
> [  574.975387][T27935] R13: 0000000000000286 R14: ff3f25758af49000 R15: f=
f3f25360038eb78
> [  574.983230][T27935] FS:  00000000223403c0(0000) GS:ff3f25b4d4d83000(00=
00) knlGS:0000000000000000
> [  574.992032][T27935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  574.998488][T27935] CR2: 0000000000000008 CR3: 00000040fa254005 CR4: 0=
000000000f71ef0
> [  575.006332][T27935] PKRU: 55555554
> [  575.009753][T27935] Call Trace:
> [  575.012919][T27935]  <TASK>
> [  575.015730][T27935]  intel_iommu_probe_device+0x4c9/0x7b0
> [  575.021153][T27935]  __iommu_probe_device+0x101/0x4c0
> [  575.026231][T27935]  iommu_bus_notifier+0x37/0x100
> [  575.031046][T27935]  blocking_notifier_call_chain+0x53/0xd0
> [  575.036634][T27935]  bus_notify+0x99/0xc0
> [  575.040666][T27935]  device_add+0x252/0x470
> [  575.044872][T27935]  pci_device_add+0x414/0x5c0
> [  575.049429][T27935]  pci_iov_add_virtfn+0x2f2/0x3e0
> [  575.054326][T27935]  sriov_add_vfs+0x33/0x70
> [  575.058613][T27935]  sriov_enable+0x2fc/0x490
> [  575.062992][T27935]  vfio_pci_core_sriov_configure+0x16c/0x210
> [  575.068843][T27935]  sriov_numvfs_store+0xc4/0x190
> [  575.073652][T27935]  kernfs_fop_write_iter+0xfe/0x180
> [  575.078724][T27935]  vfs_write+0x2d0/0x430
> [  575.082846][T27935]  ksys_write+0x7f/0x100
> [  575.086965][T27935]  do_syscall_64+0x6f/0x940
> [  575.091339][T27935]  ? arch_exit_to_user_mode_prepare+0x9/0xb0
> [  575.097193][T27935]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  575.102952][T27935] RIP: 0033:0x46fcf7
> [  575.106721][T27935] Code: 48 89 fa 4c 89 df e8 88 16 00 00 8b 93 08 03=
 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10=
 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [  575.126178][T27935] RSP: 002b:00007ffe991aff40 EFLAGS: 00000202 ORIG_R=
AX: 0000000000000001
> [  575.134457][T27935] RAX: ffffffffffffffda RBX: 00000000223403c0 RCX: 0=
00000000046fcf7
> [  575.142301][T27935] RDX: 0000000000000001 RSI: 00007ffe991b1050 RDI: 0=
000000000000003
> [  575.150143][T27935] RBP: 00007ffe991b0ff0 R08: 0000000000000000 R09: 0=
000000000000000
> [  575.157985][T27935] R10: 0000000000000000 R11: 0000000000000202 R12: 0=
0007ffe991b1768
> [  575.165829][T27935] R13: 0000000000000016 R14: 00000000004dd480 R15: 0=
000000000000016
> [  575.173677][T27935]  </TASK>
> [  575.176573][T27935] Modules linked in: vfat fat dummy bridge stp llc i=
ntel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd eh=
ci_pci ehci_hcd
> [  575.190930][T27935] CR2: 0000000000000008
> [  575.194960][T27935] ---[ end trace 0000000000000000 ]---
> [  575.204004][T27935] RIP: 0010:rb_insert_color+0x44/0x110
> [  575.209336][T27935] Code: cc cc 48 89 cf 48 83 cf 01 48 89 3a 48 89 38=
 48 8b 01 48 89 cf 48 83 e0 fc 48 89 01 74 d7 48 8b 08 f6 c1 01 0f 85 c1 00=
 00 00 <48> 8b 51 08 48 39 c2 74 0c 48 85 d2 74 4f f6 02 01 74 c5 eb 48 48
> [  575.228796][T27935] RSP: 0018:ff85113dcdd6bb08 EFLAGS: 00010046
> [  575.234729][T27935] RAX: ff3f257594a99e80 RBX: ff3f25758af490c0 RCX: 0=
000000000000000
> [  575.242572][T27935] RDX: 0000000000001a00 RSI: ff3f25360038eb70 RDI: f=
f3f2536658bbee0
> [  575.250414][T27935] RBP: ff3f25360038ea00 R08: 0000000000000002 R09: f=
f85113dcdd6badc
> [  575.258263][T27935] R10: ff3f257590ab8000 R11: ffffffffa78210a0 R12: f=
f3f2536658bbea0
> [  575.266105][T27935] R13: 0000000000000286 R14: ff3f25758af49000 R15: f=
f3f25360038eb78
> [  575.273948][T27935] FS:  00000000223403c0(0000) GS:ff3f25b4d4d83000(00=
00) knlGS:0000000000000000
> [  575.282741][T27935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  575.289197][T27935] CR2: 0000000000000008 CR3: 00000040fa254005 CR4: 0=
000000000f71ef0
> [  575.297046][T27935] PKRU: 55555554
> [  575.300466][T27935] Kernel panic - not syncing: Fatal exception
> [  575.345557][T27935] Kernel Offset: 0x25800000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  575.362075][T27935] mtdoops: Cannot write from panic without panic_wri=
te
> [  575.368795][T27935] Rebooting in 10 seconds..
>
> I also have the following diff on top of your series to fix the other
> bug you found.
>
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/sel=
ftests/vfio/lib/sysfs.c
> index 5551e8b98107..d94616e8aff4 100644
> --- a/tools/testing/selftests/vfio/lib/sysfs.c
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -40,7 +40,7 @@ static void sysfs_set_val(const char *component, const =
char *name,
>
>  static int sysfs_get_device_val(const char *bdf, const char *file)
>  {
> -       sysfs_get_val("devices", bdf, file);
> +       return sysfs_get_val("devices", bdf, file);
>  }
>
>  static void sysfs_set_device_val(const char *bdf, const char *file, cons=
t char *val)
>
> I'm not sure which exact test case triggered the panic. This is the only
> test output that made it to my ssh window:
>
>   TAP version 13
>   1..45
>   # Starting 45 tests from 15 test cases.
>   #  RUN           vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.in=
it_token_match ...
