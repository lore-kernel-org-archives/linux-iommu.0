Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795032027;
	b=xW/duQI7mVfIh1M365Hkq8lxWZB+Xb5gW/+/SIw3FoVaq1VF37TYfZguj3Qx+206VTW6
	 EZEhga0Gb1yCxXgfNJUdKRkCGgp4HoYi0iXcfwfR392BzKW4FDH0CZLYjSn/GpzrGhn9N
	 leYux2bIfZda4y1ckT9NMHsdpPGHV600RHHVD9uoFfBHXU64jjoW96EkI4ICYVe6d5y86
	 2y6fGATKayBqPYrCK94b9LWbwg6Pfun+K+xMsP2W1gZv1yf9hDGF00hhyhhLJ77tQiPt5
	 oRr571ezNI6hbcz4lEvYwjDiO7MBvntNjAHaZdvFfXe4J9NEv5Mx2E0egtiDvMJ/mgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=3zq6H5oxvqbo0sfevsruq5mckCi17ste1PpPlmxAzn8=;
	b=PQcdPZOiiBtXQrEvc/BAQsJxPowsCI2738DLWMWvhVBWjxvyT6Zk9IQUSyn5ZcTcSkNI
	 X6rZx30M0zgvyefQf9RnuiIs4bZ5i8vvpwBXWEso8IK2Yr88Fsju6k414X/BZSTnFA+A+
	 pT1syWF8SRXOIpg9SlkKjXt5+7Wrjq/iOKj3yyeSnzj46jSQJaOCu7Zyj/z40o1LWokfU
	 qBpQsZEaSkFNmCXELJTzXzePukkfjuVOv7G6TMbkaIqhFEeTdcSF+sV5RU25M964VtXWV
	 pB+pbSjzijHK7rJNgcj+Q17CHMuIhFKMi5WVpycQ6XrzkiTo3G0Z9NwA/bNhAoxYbnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdhhBzf9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3D606A325
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 20:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED3D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdhhBzf9
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so2018036a12.0
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795032026; cv=none;
        d=google.com; s=arc-20260327;
        b=oKWwtLlrPb6f3erMAyflHLUI7Ryvqxe5HO3IQ1Phc4Nk7u7C9fjqoQhsf0VmLEzggr
         Aq9TlcDwmTUpJZ0CYi/IcEJQvLrljUgu2JmKSQmO2T9o5hOlEysi6JPUlDKFqhWsfZKZ
         evyIQYfRRZfrQItlHkDtTEMo6mfa+oehAfxe/7oW2bkFbMRd/O7niuIK8WJRnAvQRKu/
         TbAfgdYNh4nx62yCujedfW3TBeuv1w4M3YbuoF+1IuVA/48v9h2SdNi1oes/1qKXLqYC
         z9Bp8U1alKVUtc3ftgdWZYHJeCvmdQVJDU1noFajWHMXfO/zhZOhXsmJRHg1Q4lGQepo
         Lyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3zq6H5oxvqbo0sfevsruq5mckCi17ste1PpPlmxAzn8=;
        fh=cEC4s9UrC8HJiYnNKdY0ryk9kl24IQpcpf3VY3oirJs=;
        b=F1CsZPXofYDck80q5pJzuoUkfdE5hGBfmLT8sRakq7RpXKvVTVs76mOqYbky/KkKwz
         lcsb5xw7bPKJBpuOC5i9uzd4WxHCIlJ5q7hwm6j8slCORHqtPgvQ1Ox7rWSz2NMKIbsw
         IrfwqPgNklF4tVELEwO/ocy2QC+wdhZc3n+toHUHiTGBvzQpqMhluHwcjzi+Pku5h94L
         EEze25qrnoZmXG1Kn4xxS/Fnp/sqL5sH8rrEY9mvaSIxKuhvGK8jaDOerKWYchjMhdZ+
         mJa+vrpNkcIhSsIXlUYF1A70A3AfKLS1ztdPf5w4aBSu9TXzNvjcS9eykMcDjqlFsUG7
         uwyw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032026; x=1795636826; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zq6H5oxvqbo0sfevsruq5mckCi17ste1PpPlmxAzn8=;
        b=ZdhhBzf9JwoZiVmF86ZHGIsAs6Xnxo+j0u6fElVYqqDI5qZjBh2hlwN5howMQUH4Sc
         XM/pM+mYNmgxrk3raBd5N2khQXXMMKAQwN362zXHSF5ah78ExINUqOOU1G6AagONari4
         6yKohfsKWr9pqTrxuy4J6VvlJkUbPPgvBRgmVtaOb1jxzQhj7plZLkKuF3PVNZVz5k7I
         AGElviGz07uym9o+7kTw9NW8n21mrrYzfcnTjxpwIv+jF7yMKdJczzv3IHdMxpwMIBY0
         lfcG8d0GXhiu47DkVOkVbKEmkCkhIAxunFjDj5Q6kgMdwMo2+rsH9mXXjfpkKFIU4H0Q
         b+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032026; x=1795636826;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3zq6H5oxvqbo0sfevsruq5mckCi17ste1PpPlmxAzn8=;
        b=nN6TADJlYKjKOzyIcIqckK96wBEU3FXnDryPRwon7PGBq+7iT6aJt1+/dF2xJkoRzF
         LLmHmT0i+7rOU9FwlpGuEU1/GW/D11LzEW4T7zxLGV9eSg3a+QLATZ14t5huSyruRRvr
         oxd8odbO9scnNAX/oC9+OUSYNbatiMUBok8VrFD9pX88rSy/oyEn4XOKPG1JMJPLMmFc
         DiS2pVjuhg+VPRFZR9odmCgmwVwfjdPv1EPge5fP8hY/WbKnAvjDd/ouGJMY6150G6EL
         +wkBspDfSC2biTUsoe+LOglfALYJE4rlLkFfA2xv4KsCZWVguYFLasbQRUbxSjw2Mnqg
         7TpQ==
X-Gm-Message-State: APuU4Z8eHc9nuRWqQDlLx3gy2+hDyxRtE1AOupRZPveDaNW9H5Y+SimA
	iU/AV9/I1tvuUfSKYveVqI/p/5L3O6e3XZNeHoKWfJExVK1tSE5Cf6yC2hZemVbq3JcTM843Uux
	5M9wRmGdcG2hvtILaugc04gPUuFoWvqAVNQ==
X-Gm-Gg: AYBFou0bjiLd3LTYrH4lkzgNApb0ldwVYfS7j8K2t9dwMujxIbduGyMWXEAmmAnUPjD
	1z78lzKMBZoduf00/3d/jlarNIRlWrZql7Z+nA0La/ZKeApbCgXN1eTosNoLZb1IxbGGjp2ewPt
	CKZMw1KzFQBjoM87mvJeFEodK8BQLH7m0cImZfjL/6AW4dmUgFKKCi7FnwUfyR272izj7jD3mlF
	La/ZxXNoTsaLYU8ozObqXbUc0/4lF9oIfYMV5RrKEC+uTJKqtvCF7Vw2HzzpyXcDXLlYzhouPIe
	84ryXPm0tThDiqGRYAmLNC98K3JplCJYCcRNmq+OlMoXjEeFhcJzNVEswq6eyEM9RnLAKR2Pt9J
	+Zr0EA0Ac4qtNXzMXXyYDUP7LrjgLVPTQ0jvGAFX0Ah5lsgY0yQUkdaUoVVhfZsB/iALcEYzN2i
	HoRnCwwtCoKl0YrQ==
X-Received: by 2002:aa7:c843:0:b0:6b5:96e9:ae97 with SMTP id
 4fb4d7f45d1cf-6b887ec8837mr2487426a12.34.1795032025417; Wed, 18 Nov 2026
 12:00:25 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 18 Nov 2026 14:00:24 -0600
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: dankoc1989@gmail.com
Date: Wed, 18 Nov 2026 14:00:24 -0600
X-Gm-Features: AclHuK8HzntpXxzSHVEkA5Q3B-bj665YDMjML8ApUS7u0FbwBWK2CtQgK9zau5Y
Message-ID: <CAM5xBNUVDHhn-ucSWT5LFn7m_GdFV+UKdqVgAiY42sxes4Vc1w@mail.gmail.com>
Subject: [BUG] iommu/amd: unchecked dump_command() address causes #GP after
 ILLEGAL_COMMAND_ERROR on Renoir
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hello AMD IOMMU maintainers,

An ILLEGAL_COMMAND_ERROR event containing an implausible command address
was followed by a general protection fault in the AMD IOMMU event IRQ
thread on my HP ProDesk. The immediate fault appears to be the diagnostic
read in dump_command(). I am reporting this secondary failure separately
from the still-unexplained origin of the invalid event address.

Observed system and workload
----------------------------
Date: 2026-11-18; approximately 19:32:13 UTC / 20:32:13 CET.
Kernel: 6.12.117+deb13-amd64 #1, Debian 6.12.117-1.
The Oops reports Not tainted, PREEMPT SMP NOPTI.
Hardware: HP ProDesk 405 G6 Small Form Factor PC, board 872D.
BIOS: S15 Ver. 02.18.00, date printed by kernel: 03/04/2025.
GPU: AMD Renoir, PCI 0000:05:00.0, device 1002:1636.
Renderer: AMD Radeon Graphics (radeonsi, renoir, ACO, DRM 3.61).
Relevant boot arguments:
  amdgpu.sg_display=0 processor.max_cstate=5
  amd_iommu=force_isolation iommu.strict=1
Other non-identifying arguments: ro quiet splash.
Boot-device path and root filesystem UUID omitted.
The GPU IOMMU group was checked as DMA before the run.

The failure occurred during the first stage of a bounded Blender 4.3.2
EEVEE GPU workload (1280-pixel width, 32 samples, intended duration 30 s).
The render log contains one completed frame, with a render duration of
11.1512 seconds. Its completion record is about 79 ms after the first
IOMMU fault timestamp, so the log does not establish the exact ordering
of GPU completion versus fault generation.
The wrapper recorded an aborted run due to the kernel Oops. The desktop
froze and I had to reset the machine manually. No new reproduction was
attempted for this report. There is no minimal reproducer or bisected
regression range.

Evidence and immediate failure
------------------------------
At monotonic time 1310.594100 through 1310.594204, ten GPU IO_PAGE_FAULT
messages were retained. They report domain 0x0003 and addresses ranging
from 0xffb907a0 to 0xffb91180.
At 1310.594251:
  ILLEGAL_COMMAND_ERROR address=0xd78459178334137e
At 1310.594263:
  #GP for non-canonical address 0xd783e5ebc334137e
The faulting thread is irq/27-AMD-Vi0-, PID 129, CPU 2.
RIP is iommu_poll_events.cold+0x345/0x4d8.
R09 retains 0xd78459178334137e; RBX is 0xd783e5ebc334137e; R15 is zero.
The faulting bytes 42 8b 14 bb decode as:
  mov (%rbx,%r15,4),%edx
This is consistent with the first 32-bit command-word read in the
inlined dump_command() loop. This attribution is based on the printed
instruction bytes, registers and upstream source; it has not been
confirmed with debug symbols for the exact Debian binary. No CMD[0]
output appears in the retained excerpt before the Oops.

Source inspection
-----------------
In upstream v6.12.117 drivers/iommu/amd/iommu.c:
- iommu_print_event() constructs address from event[3] and event[2].
- EVENT_TYPE_ILL_CMD logs that address and calls dump_command(address).
- dump_command() converts it with iommu_phys_to_virt(), then directly
  reads cmd->data[0..3] for printing.
There is no check that the supplied address identifies a complete,
properly aligned command within this IOMMU's allocated command buffer,
and no fault-tolerant read at this call site.

The event address ends in 0x7e, which is not 16-byte aligned. It also
has implausible upper physical-address bits for this machine. The bad
value is already present in the event log message before conversion.
The difference RBX minus the logged address, modulo 2^64, is
0xffff8cd440000000, consistent with a direct-map offset. The actual
direct-map base and SME mask of the crashed boot were not independently
recovered; this arithmetic is a consistency check, not evidence of a
memory-encryption fault.

The same unchecked helper and call site were present in the mainline
master and linux-6.12.y source files retrieved on 2026-11-18. These are
source observations, not reproduction results on those kernels; the
branch URLs below are moving references.

Limits and potentially related work
----------------------------------
This machine has a history of freezes/resets. In earlier 6.12.116 crash
logs, printed instruction bytes differed substantially from the local
kernel-image reference, suggesting corruption of runtime state or the
recorded output. That comparison did not establish its cause and is not
included as proof of a driver bug here. Hardware, firmware, cache/memory
coherency and software causes remain unresolved. This report does not establish
that the IOMMU driver produced the malformed event or that this Oops
alone accounts for the entire system freeze.

There is no vmcore or snapshot of the complete raw event ring, its
head/tail registers, or the command buffer at the time of failure.
Under the inspected decoder, the logged value corresponds to address
words event[2]=0x8334137e and event[3]=0xd7845917. This is an inference
from the decoded output, not an independent capture of ring memory;
the full event[0..3] cannot be reconstructed from this message. Corrupt
contents, a stale/partially visible entry, and reading the wrong slot
have not been distinguished. No new instruction-byte corruption is
claimed for this Oops.

The 2026-11-05 AMD patch series "Various fixes to interrupt handler code
path" includes clearing IO_PAGE_FAULT slots, protecting the domain
pointer during fault reporting, RCU protection for the GA notifier, and
raw event logging. These patches have not been applied or tested here.
The missing clearing is relevant context, not a demonstrated cause of
this ILLEGAL_COMMAND_ERROR. The retained instruction and register
state instead point to command
dumping; the stack does not show report_iommu_fault() or the GA notifier.

Questions
---------
Is this secondary fault already known? Is there an existing fix or
hardening change that validates the event-supplied command address
against the originating IOMMU command buffer before dereferencing it?
What additional retained state would distinguish a malformed event from
an event-ring read/coherency problem? No patch or fix validation is
included with this report.

References
----------
Affected upstream source:
https://github.com/gregkh/linux/blob/v6.12.117/drivers/iommu/amd/iommu.c
Address conversion helper:
https://github.com/gregkh/linux/blob/v6.12.117/drivers/iommu/amd/amd_iommu.h
Compared branch sources:
https://github.com/torvalds/linux/blob/master/drivers/iommu/amd/iommu.c
https://github.com/gregkh/linux/blob/linux-6.12.y/drivers/iommu/amd/iommu.c
Related AMD patch-series archive:
https://lore.kernel.org/linux-iommu/20261105041603.399016-1-vasant.hegde@amd.com/
https://lore-kernel.gnuweeb.org/linux-iommu/20261105041603.399016-1-vasant.hegde%40amd.com/T/

Pstore excerpt
--------------
The following is an unchanged contiguous excerpt from the collected
pstore text, beginning at the first GPU fault and ending at end trace.
Earlier unrelated firewall entries containing network identifiers are
omitted. Pstore part markers and the complete retained Oops/module list
are preserved. The original dump remains unchanged on the reporting host.

<3>[ 1310.594100] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb907a0 flags=0x00b0]
<3>[ 1310.594119] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb90d00 flags=0x00b0]
<3>[ 1310.594130] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb90e40 flags=0x0020]
<3>[ 1310.594141] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb90ee0 flags=0x0020]
<3>[ 1310.594151] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb90f40 flags=0x00b0]
<3>[ 1310.594162] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb90fa0 flags=0x00b0]
<3>[ 1310.594172] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb91000 flags=0x00b0]
<3>[ 1310.594183] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb91060 flags=0x0020]
<3>[ 1310.594194] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb91100 flags=0x0020]
Oops#1 Part3
<3>[ 1310.594204] amdgpu 0000:05:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=0x0003 address=0xffb91180 flags=0x0020]
<3>[ 1310.594251] iommu ivhd0: AMD-Vi: Event logged
[ILLEGAL_COMMAND_ERROR address=0xd78459178334137e]
<4>[ 1310.594263] Oops: general protection fault, probably for
non-canonical address 0xd783e5ebc334137e: 0000 [#1] PREEMPT SMP NOPTI
<4>[ 1310.594269] CPU: 2 UID: 0 PID: 129 Comm: irq/27-AMD-Vi0- Not
tainted 6.12.117+deb13-amd64 #1  Debian 6.12.117-1
<4>[ 1310.594274] Hardware name: HP HP ProDesk 405 G6 Small Form
Factor PC/872D, BIOS S15 Ver. 02.18.00 03/04/2025
<4>[ 1310.594277] RIP: 0010:iommu_poll_events.cold+0x345/0x4d8
<4>[ 1310.594284] Code: 89 4d 90 45 31 ff 48 c7 c6 e0 ce 3b b1 e8 eb
3b 00 00 48 8b 1d dc e9 f4 00 4c 8b 4d 90 48 f7 d3 4c 21 cb 48 03 1d
5b 4d 8f 00 <42> 8b 14 bb 44 89 fe 48 c7 c7 3a b0 32 b1 49 83 c7 01 e8
0c dc fc
<4>[ 1310.594288] RSP: 0018:ffffceb4405a7d90 EFLAGS: 00010287
<4>[ 1310.594293] RAX: 0000000000000000 RBX: d783e5ebc334137e RCX:
0000000000000027
<4>[ 1310.594296] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff8cd86e721780
<4>[ 1310.594299] RBP: ffffceb4405a7e20 R08: 0000000000000000 R09:
d78459178334137e
<4>[ 1310.594302] R10: ffffffffb1ab43a8 R11: 0000000000000003 R12:
0000000000000100
<4>[ 1310.594305] R13: ffff8cd540062000 R14: ffff8cd616986100 R15:
0000000000000000
<4>[ 1310.594308] FS:  0000000000000000(0000)
GS:ffff8cd86e700000(0000) knlGS:0000000000000000
<4>[ 1310.594312] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1310.594315] CR2: 00007f26b2c19000 CR3: 00000001d5822000 CR4:
0000000000350ef0
<4>[ 1310.594319] Call Trace:
<4>[ 1310.594322]  <TASK>
Oops#1 Part2
<4>[ 1310.594325]  ? srso_return_thunk+0x5/0x5f
<4>[ 1310.594330]  ? psi_task_switch+0x113/0x290
<4>[ 1310.594339]  ? amd_iommu_int_thread_evtlog+0x48/0x80
<4>[ 1310.594345]  amd_iommu_int_thread_evtlog+0x48/0x80
<4>[ 1310.594351]  irq_thread_fn+0x23/0x60
<4>[ 1310.594356]  irq_thread+0x1a8/0x300
<4>[ 1310.594360]  ? __pfx_irq_thread_fn+0x10/0x10
<4>[ 1310.594366]  ? __pfx_irq_thread+0x10/0x10
<4>[ 1310.594370]  kthread+0xd2/0x100
<4>[ 1310.594375]  ? __pfx_kthread+0x10/0x10
<4>[ 1310.594379]  ret_from_fork+0x34/0x50
<4>[ 1310.594384]  ? __pfx_kthread+0x10/0x10
<4>[ 1310.594389]  ret_from_fork_asm+0x1a/0x30
<4>[ 1310.594399]  </TASK>
<4>[ 1310.594401] Modules linked in: sd_mod snd_seq_dummy snd_hrtimer
snd_seq snd_seq_device qrtr ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt
ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_multiport nft_limit
xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables binfmt_misc
nls_ascii nls_cp437 squashfs vfat fat loop intel_rapl_msr
intel_rapl_common edac_mce_amd snd_hda_codec_realtek kvm_amd
snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi
snd_hda_intel kvm snd_intel_dspcfg hp_bioscfg snd_intel_sdw_acpi
snd_hda_codec firmware_attributes_class snd_hda_core irqbypass
snd_hwdep hp_wmi snd_pcm sparse_keymap rapl platform_profile snd_timer
rfkill wmi_bmof ti_usb_3410_5052 snd pcspkr ccp usbserial soundcore
k10temp ipmi_devintf ipmi_msghandler joydev evdev msr i2c_dev ecryptfs
parport_pc ppdev dm_mod lp parport nvme_fabrics nvme_keyring
efi_pstore configfs nfnetlink ip_tables x_tables autofs4 ext4 mbcache
jbd2 btrfs raid10 raid456 async_raid6_recov async_memcpy
Oops#1 Part1
<4>[ 1310.594540]  async_pq async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 md_mod hid_logitech_hidpp amdgpu
hid_logitech_dj hid_generic drm_buddy amdxcp drm_exec gpu_sched
i2c_algo_bit drm_suballoc_helper drm_display_helper usbhid hid cec
crct10dif_pclmul rc_core crc32_pclmul drm_ttm_helper crc32c_intel
ghash_clmulni_intel ttm ahci sha512_ssse3 drm_kms_helper r8169 libahci
xhci_pci sha256_ssse3 ehci_pci libata xhci_hcd realtek ehci_hcd nvme
sha1_ssse3 mdio_devres drm aesni_intel usbcore nvme_core sp5100_tco
scsi_mod psmouse gf128mul crypto_simd libphy watchdog cryptd nvme_auth
serio_raw i2c_piix4 video usb_common crc16 scsi_common i2c_smbus wmi
gpio_amdpt gpio_generic button efivarfs
<4>[ 1310.594647] ---[ end trace 0000000000000000 ]---
