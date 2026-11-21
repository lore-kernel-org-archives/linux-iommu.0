Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795227241;
	b=x8w+1WCaZfpRtmpRHjhxeD5/y09hfsBM7FgN6GJkXrdOiOeMXzSAd3KiNTV8Bz4uTLxY
	 /jsb69aYUemmW7MYhWpbCCokoPqc+BA2PKI0qDcayfbPpk1HkOhLVQykANR7rMPc4LGAF
	 KhUQxcTQNjmL5p7DXAwWPIyWYbkDqs87Xxf0oW56G6dtgyKJq0B/EfRQ4vAHIzIE/Ni2I
	 VDqZFyqgm3++oygZb+CpuOVtJpQzkMcRB2UzmHmjhJdJWOxYZB3ltna34LtlPNZG8LwVK
	 Yy0z9QsH6eHClrR+Y1zf94v8PWIj63RQGoZ7x445Sn3v8LFCjHieYZMmLhZ7qWziF3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IG+ZJh/LD9XAogPPkpcUkOpfA1PilwYhMDov5mMLDkc=;
	b=nAuSj9/0OpCExzhevLDPFyV96vwzt98SIotHjw2yex1t1Xizf65IE6WiTU747eEEBeYL
	 rIG95znMNPRYNMNySknGl1kNcRxhmPulPU8BMQ8UXf4sar4EfqtnDI2Le4Ob0/kB2ArYm
	 kdTqr7Q/7bmLHsukVkApKX10yW4SQWLqVghYdD5MbsUI+qsIBc5QE/SyawiriIKokcqz0
	 tlB06OTSgocna/4Boc5wFu3Gq3x+PBb7eOUZ/g2/Ef6Vdo7pWsPWdFwzochvn8NwsDlpL
	 Xi0qn/EyNwy3hxRIrpJPoMoVZ8Mv06M5eO9DwfEETHCJIzXMZ6CmdPHc4/HQqAhFgxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwdVSGeT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B6606A6A8
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 02:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9B6606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwdVSGeT
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b4200f59e1so176502a91.2
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 18:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795227241; cv=none;
        d=google.com; s=arc-20260327;
        b=pG+1/Co3UA4gsSbWNm8uXADCD/83Emz0NYcH1Wc/rhjhlrxlfCKU+1uPnPJxlqw23g
         6V/xKpe1kALyuIl8TYiugi53l5UX772KxnZJFLQPvXSsaVhWDK2ucQFbG4kVTMGXQyr3
         qwIJjNn0G2FuLF0EqfVu+ayOMaoh62279zqajnzD/chmW9Jx/XHtle6hFk68T0Pkru4w
         rs/t4JmeButqrsZwihcFtKJGL2LD4J/O3WSr7yJjAyVsuk53O/nPe6WpwSZyuxMLoeYV
         pw8krXHjlaR/UdNFmRMLzgwxXA/s/h5F73G3V+JGYBWh/8YWWqp662cs4lDN4L1llyDM
         KA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IG+ZJh/LD9XAogPPkpcUkOpfA1PilwYhMDov5mMLDkc=;
        fh=xnUDJL6UB3i0EPdUTPCABw9TiTZ4v6od0XmxmmL0SWU=;
        b=CC1gd8Q2Q4Rvv7l9u19/pHVH91RkjKqkHw9NYXhIPfVK+ypnt/1A5zBM8YQDmOelle
         qMKYCoCrT2ODQz9OX+UUfyne1/MTO/DH67hcKgBH8KKPzFMks3W1KMYZvbJOq4jg2T2D
         BHfnSK7AShNtZZ6Pgk2GACqdBa/iGiuO2gHuQC4f0FSkLNdX1Tt/s+/TfvR4yFx6NaUv
         Zgc0WEP+TMta3ukoFZiyT3I4w9vFmk6APipUE2TTH4YX9hI0OZ643yLqhwjFHOvXF01S
         BZvE6VFggJQ7JKMQf2hl162Ve7A6omg6YeXD/04OTfTIvDlOG0+bGgD3uVc1DbxLJj3H
         tGjw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795227241; x=1795832041; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IG+ZJh/LD9XAogPPkpcUkOpfA1PilwYhMDov5mMLDkc=;
        b=SwdVSGeTeiMR8yQR1fZm7MK05UzPKk2GYYDKdw2PatREDfLapkhPX4+PX1GPATRz9p
         zgwKBW+m99YwDY5P/tkiAO09D8rbRYRPjj9g+Ku+SwE+GrX+ouPJm5PogGGTb4X50mt0
         SQzTrkO6TXPQR51a1e7OPdW2/WXhE0ZjUH4LoNc4FlPLWky6IN7++6sJFqkQ4AeLCVtL
         b1K5v5p/nIKN2+LJSLOapmyc8mdgv+7xQXPi9TFWIbUvj453LIq3aZN7Zw0Aq2ZsLZn+
         P0jow8mqPawXHpPsBnaq74KO97XKk4OFrezAGs8CZpnTREqV8AeTd0S+S0kBhhhzylwZ
         HBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795227241; x=1795832041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IG+ZJh/LD9XAogPPkpcUkOpfA1PilwYhMDov5mMLDkc=;
        b=thKh1cZdOPN/retK7kYYuRmhyTvzIWK1/V4trtddKP5SZcetkaSlTlL0pfUwD+4ZL5
         qCGqJYejjSofrcnO1T91cBwhoOSBd+xDBujFAuCPBWbI9m3s2kTxn09VorcbUCX66fpu
         MydywRbkMaLmHQNqC+ACBffvY5BQEQ2HT4WdUv3H6nxj2ci0uZ8rCRD8K9iS7WvNzyG6
         83Zs2jWkKwGSbiFwfUR5KMSSdAAg5sRlMW996uj0Fn7zhAYjKsTkvvSPCdIc+V10hGYL
         vDdUz/ko+QZEU8xcWrxTR6DR7cWfFaQ2JUc/pXqaZaGkDd0jOmUIAyzQXC9GLuxg+z5h
         Z3Pg==
X-Forwarded-Encrypted: i=1; AL+hErGbmHehLl2mxW5XWcyhX8vX0gnqnG+XYZF7LO8J1tsIZ1OeDngrrvxLPJUzXlbYlnkQ4FqlkA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Uikaz34GHYD4te6kIdvRj0nzgFVZm9G5GM7xC+u742kh+2VH+
	WkAm6zzp7BmNan70e+lWrlpq1R3cG5q5edZJV4BdBxVROYlQAUETYPq0vDeQnxd6m+4D0pUw3Wv
	tioPLZaylJZ2dMMgKNNPeaHqyoWvCItA=
X-Gm-Gg: AZFdTZdYN2Y2vTWYVLKsFrQ6naX6UzWW42pz8sG0pfdICTlVT+GcRfaTFURJyAVFISH
	0+Sm2kGSnBR2qUJ0sNrmiuYP4kXE+DbS5t+8OH2K8A888ONrA5PhBaUN1ncKcncZ4WPkGF1p8DF
	1uu17jW0jTUl+S5nPgS+h1y7wvUd41KJpPnwz/nWAV/h089kQfnVS2HRkF6DLJyJrSqs+76jl/W
	61efVmzlUGDvHAehWBjxmqOBdj5hy04lkDF3FwtmCLsB7MFg2LoLp32XB7dXDrPVG2tEwmqJBXu
	430nusQD6wLHru6/TjpUEg/I3SK7eSYtX9IjphROb9B0bM0BYgns5O2jcw1FFYTuiFrAvRTXo2K
	9kceaZaOHMiw1bAfksKx1L6oKlELXftKbhXVnyohLzNwLeE5GEvmGCN4SfTVKVSxqNps4Aw==
X-Received: by 2002:a17:90b:2ecb:b0:3b0:9a3e:bf8b with SMTP id
 98e67ed59e1d1-3b41c98a1f8mr7487744a91.6.1795227240277; Fri, 20 Nov 2026
 18:14:00 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com> <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
 <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
In-Reply-To: <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Sat, 21 Nov 2026 10:13:48 +0800
X-Gm-Features: Aa3M54opUKy3tR7eGnpShseaHOR8Dg3J-Z6Ik5gqSO8qnVYY4b0VBcftyM8PVfk
Message-ID: <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device removal
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolu,

Thanks for confirming the VT-d ordering bug. I'll keep this series
withdrawn and won't resend it.

I still have one question about AMD. detach_device() calls
iopf_queue_flush_dev() just before amd_iommu_iopf_remove_device().
That flush only waits on the iopf workqueue, while the PPR IRQ thread
runs amd_iommu_poll_ppr_log() and reports the fault through
iommu_report_device_fault() directly. What ensures that the thread has
finished reporting faults for this device, and cannot report another
one, before the device is removed from the IOPF queue?

Thanks,
Qihang

On Sat, Nov 21, 2026 at 9:25=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 11/20/2026 5:26 PM, Qihang wrote:
> > Hi Baolu,
> >
> > Thanks. I agree that the driver must drain pending faults before
> > calling iopf_queue_remove_device(). My selftest removed the mock
> > driver's serialization, so it doesn't establish that fault reporting
> > can overlap removal in an unmodified driver. I'm withdrawing this
> > series and won't resend it.
> >
> > I still have two questions about where the drivers establish that guara=
ntee.
> >
> > On VT-d, blocking_domain_attach_dev() calls
> > iopf_for_domain_remove(old, dev) before device_block_translation(dev).
> > When that drops the last IOPF reference, it calls
> > iopf_queue_remove_device(). On an SM-capable IOMMU, for a device that
> > isn't a real DMA subdevice, the only PRQ drain on this path is reached
> > through device_block_translation() =E2=86=92 intel_pasid_tear_down_entr=
y() =E2=86=92
> > intel_iommu_drain_pasid_prq(). By then iopf_refcount is zero, so the
> > drain returns early.
> >
> > In the same file, identity_domain_attach_dev() calls
> > device_block_translation(dev) first and releases the old domain's IOPF
> > reference afterwards. The comment there explains that putting the
> > device in the blocking state leaves the IOPF reference count
> > unchanged. Should blocking_domain_attach_dev() use the same order? If
> > the current order is intentional, what ensures that pending PRQ
> > reports for this device have drained before the last reference is
> > dropped?
>
> Good catch. This is a bug in the vt-d driver. I already have a patch
> that changes the order in blocking_domain_attach_dev(). I will submit it
> for discussion after the necessary assessment.
>
> > On AMD, detach_device() calls iopf_queue_flush_dev() immediately
> > before amd_iommu_iopf_remove_device(). The flush helper waits for
> > queued work and documents that the caller must have flushed the
> > low-level queue first. The PPR interrupt thread calls
> > iommu_report_device_fault() directly, so waiting for queued work alone
> > doesn't establish that the thread has finished reporting faults for
> > this device. What in the detach path ensures that PPR reporting for
> > this device has quiesced before the device is removed from the IOPF
> > queue?
> >
> > I may be missing a step in both cases. A pointer would be enough.
> >
> > Thanks,
> > Qihang
> >
> > On Fri, Nov 20, 2026 at 3:56=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.=
com> wrote:
> >>
> >> On 11/17/2026 9:54 AM, Qihang wrote:
> >>> iopf_queue_remove_device() kfree()s the entries on
> >>> fault_param->partial without unlinking them, leaving the list head
> >>> pointing into freed memory.  Since a74c077b9021 the fault parameter i=
s
> >>> refcounted and can outlive the drain, a report that took its referenc=
e
> >>> earlier can still list_add() through those pointers.  Unlinking
> >>> instead turns that into a leak: the late node lands on a parameter
> >>> that is no longer on queue->devices, whose final put does not free
> >>> partial faults.
> >>>
> >>> This needs a device removed from its iopf queue while a non-last
> >>> (partial) request is in flight, with the caller not blocking new repo=
rts
> >>> for the duration.
> >>>
> >>> Patch 1 unlinks each partial before freeing it, matching
> >>> iopf_queue_discard_partial().
> >>>
> >>> Patch 2 adds fault_param->removing, set and tested under
> >>> fault_param->lock: a late partial is either drained, or rejected and
> >>> freed by report_partial_fault() (-ENODEV).  It covers partial-list
> >>> admission only; callers must still quiesce reports for the remaining
> >>> lifetimes.
> >>>
> >>> Both patches are scoped to fault_param->partial, not the group path,
> >>> the attach handle, or paths that never call iopf_queue_remove_device(=
).
> >>>
> >>> Verified on v7.4-rc3 with KASAN + DEBUG_LIST and the iommufd mock
> >>> driver, its caller-side IOPF serialization deliberately removed and
> >>> test-only delays added; this shows the mechanism, not production
> >>> reachability.  The runs cover queue-before-removal,
> >>> removal-before-insertion, concurrent late reporters and re-enable.
> >>> Each round queues one partial before the removal and then races the
> >>> late reporters against the drain, so a clean run ends with every node
> >>> accounted for: 1800 =3D 900 + 900 and 3600 =3D 900 + 2700 (allocated =
=3D
> >>> drained + rejected), counted at a final removal with no reporter in
> >>> flight.  Nothing was left on fault_param->partial and KASAN stayed
> >>> quiet.
> >>>
> >>> With patch 1 reverted, the report is:
> >>>
> >>>     BUG: KASAN: slab-use-after-free in __list_add_valid_or_report
> >>>     Freed by task 1: kfree <- iopf_queue_remove_device
> >>>     56 bytes inside a freed 64-byte region (struct iopf_fault, list.p=
rev)
> >>>
> >>> With patch 1 only, the same reproducer runs 1460 rounds without a KAS=
AN
> >>> report and leaks one late node per round, which patch 2 addresses.
> >>>
> >>> Reachability on an unmodified production kernel, and any security
> >>> impact, remain unconfirmed: the test shows memory corruption and a
> >>> KASAN panic on the modified mock driver, not a user-triggerable bug o=
n
> >>> a stock kernel.
> >>>
> >>> An AI coding assistant helped find this defect and build the
> >>> reproducer and instrumentation, which are available on request along
> >>> with the KASAN logs.
> >>
> >> +Jason
> >>
> >> The issues addressed by both patches are false positives. They rely on=
 a
> >> fault being reported for a device after iopf_queue_remove_device() has
> >> been called for that device. The iommu driver must not allow that.
> >> Pending i/o page faults must be drained before the device is removed
> >> from its iommu's io page fault queue.
> >>
> >> Thanks,
> >> baolu
>
> Thanks,
> baolu
