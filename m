Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795166794;
	b=nmUbXkOt4b1Kdc8hsBbKNif8RLROsI/g9eTUwX1rhpsEfEphNHWbwA8TfJFzY+3IKxhr
	 er3WwsHZ/sQe9DPsyf8rhly6S5JU3gaaPc7efM1ejGYCZlAyy/fjH1p4Of+tMes9O676c
	 sWXBY6SAWim060g6fq9OaIO8eGzT307obfmrBR/y/4+OU9E09sOPx/YRUE8cbl/EcLX1c
	 EKuGr4TRr/4X+z2IOVI0jE2lmFVwLgVD+4wb2aVZBTpdQxgSFHloXoP1ZBCgr48Uf7yXd
	 Fi5YJ12GDmWEcqOc9KHQgB4r16PdGR+p2GwYgc6z5+sjIoivX/u1FrSpeWd6FJL67xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YLVHtNfEKOoQsgj7eBA+fP9IdBA3FfwhirmQVmJV3Ms=;
	b=d/dw7+hJyTjvXxFgwmmfWWHbYWxxnpVF+29qebNG3Df2fuEzdqdAxGlPmmBNzYA8jEvj
	 JnhykAmcnukyc3ZNeajHR/oq0RDrfgBsv2SCJtKnjqa6wa4nUOcL5H4HvIHVMuc3tRx3q
	 phQ6tfacKG3M2hJFctSAewb2BwMcL9dp7CK2l0CUkG/EoB3zpwx9bCWPtB5VcYKnhIUU1
	 If7V/toY50dOHoaRqf3XKeRwmTBbWmcRlcTuhCkR2NNJqkflxuJtUvNzd5llbTk6EgebU
	 qjlouicAd95KJuKhvmejdTOXeEahTLgnVFckBJipt69MlMJrti2ZwVzO5x207dujrmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZF8NnPN;
	arc=fail smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C650606A320
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 09:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C650606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZF8NnPN
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ee20b82356so398065ad.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 01:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795166794; cv=none;
        d=google.com; s=arc-20260327;
        b=ng/p13DLdhPoI1C1VFzFcUfHxWpqFcZm3+1cAYdQ7cleIgi4e9H4kwR+HaoVXn+iNJ
         0ydfAkSL1VG0xeTg17HGR+ZLPxdt4ATGBk1jHAifiGORi3rgX3F1+Th3qb6xUhkXSSfu
         pJlciaazV6Wzbg2zMcjH8eiNt5hHB4uqF0ekN2smFOX+fqhZxR3nqqKKlMLb+XkzlK5p
         dBMXe2niJs2gDouenjT53Noxr5fiowkRLISRmsMmbbnZ/wNDoh0J68LKPzgCqjP8C4fN
         Tgps39hPRNoHkztWgEB1J+lHuRMwLTVXHgTxWcDwVbrcQo4N6I8fkKAgdr0hThQiqQrg
         a9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLVHtNfEKOoQsgj7eBA+fP9IdBA3FfwhirmQVmJV3Ms=;
        fh=Td3Eil2a00Aj1FzixqSZyUV9+RQTCZa6yVMng412eeo=;
        b=O1l0dCLU6AkCj+7jd/2+9uXvF3X+SJqGyr8g0+dKzcyuAx8EhWnYwYeCwGJLLpIE1m
         MctoQy7+42DpzMU65yECOTfnyd7oHTym1vfM8MtPOfndpkRe+91472oFuMAbZBbcuiBg
         A1hS+hctNOfxWTknEwitAOoSggz1WXY92Y2jD2eadYEhJTLjLYjHvBzikmG7+iox6e0g
         CTZ9xJUx2fDyqCO6OCoznj6TMfKfcWB7QwdB2z+4dXRP+SFQ9ez6nCmp1iMZTDo2Ndv0
         PTyMl0nRFQ4r3K0OLJYfbHmuRvFu13ctnNPVYm1/XxfIkjhQRHE58W9COAZxXVbWyZ+W
         +7EA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795166794; x=1795771594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLVHtNfEKOoQsgj7eBA+fP9IdBA3FfwhirmQVmJV3Ms=;
        b=TZF8NnPN0rlaYoYs4QUF/8l7U0pePzdqHRLlxmzBlCvuXLr4HLs7qZUU/x6P1L17r+
         5LK4pLGpK0G5pjbfjWUAf6AO8whnsHHKa1WdCQ/z1Xhp9wQK/edUOHT54qYPXBpa5Ai2
         T4OtEfjg53lthNMxkASm5rXKt5FJNUKv4Y07eBtdfKkiZ95eDMiE4ZZIJWMJW3xXf2W6
         KfK02wjGQ7kwKoPW6Oko6klgfiPG/iU6zbmh55d7js5m6xVAdZ8XBwFYrRzx2N63Gg3M
         wHiWdQCNJAMsuVvep8lAiIgiPcP3ZCJmtl3iRYywOe5MIErCYyeRj7m+d2Y/p+m0bPHO
         ts2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166794; x=1795771594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLVHtNfEKOoQsgj7eBA+fP9IdBA3FfwhirmQVmJV3Ms=;
        b=c2ObuMBEQVU78vru+sTQatzRTUkE/sqk7waMt6LQYaNhSKBGVFHhhy0K0ho5JVTygx
         ximokp+B0eqkRzI0OD+ZGyUvZGEEH5PNIYL4YT1N4151CLHThPLscEiFXPmZqD2k4QOr
         XEgBkbj5XRVwMum0bnQs9EfFSD7etV3hp1AGbO7OXYYYN/ECwUCbkhxo4aNXSFZ/1cO/
         Da5CEQPy/dZ8aNKeenyq0WARhbBHxboMmb3Dhu2Pc/OOTYXcY9NBS6ypWUWjHZpp8PjQ
         avX6YJQqLx733gIfPzDcPCUriKxJ73RXvBxDfNtyj3jpGnfNfPVfAIQYxMwR1gE6jwsK
         Jtyg==
X-Forwarded-Encrypted: i=1; AL+hErFmU2GpfL2NE4Ufx4rH3WhKQ+KqKemBj1AT/5c5qzsCtYqFuGEwJFBXHRo+Yr5dTY9cTdAgcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/f05HeH7oqalWCaIJf4W1swhXlvtUKN48i1vXV+m60lveujkj8
	yW1VWqM+I4Ft7Ib4j8mQU9XRifDjrXWtGHj998bbYPWO3iMIp7xxfLPWP3vz7s+N9cI1y3WqEU8
	wSieLIWgoDdGmW8oM2MjJH64WoGwUrss=
X-Gm-Gg: AZFdTZe9a0LawelReg1a1vxZN/ymBjMmyjb9bovTFkRNvakoZ8DzgrfYZCeMuhOjTGO
	2+fqJY4aTwyf4OOoZnwrlB53j00JPIidtR1R+bMl7+RaxRMNt5w6numB53B4lMsVs4WwJG0wlFa
	ntuwdpJm3eS3WHG9qQiuYMJMKrnTY9iW9TjfWe4Us5nnKFu1Ujbtn8DyBkPehBTdfq7e8JkXm1V
	ShHzGC/Vq6ABQMR35UBnsgKfewUbenjGwXylqYUyj2t55mkfyE1R6PNVcg2djS4tSfZgFv7E5cZ
	V02ne1Yf5ddQHFOT2LcD6vefG69uAfcXD7g9z31+QEUVw5fzNgenzg4cVkiwg4JqnQTDzEiACXv
	lh9K5vcIVaVOszOd4+JVO7b3tWpiywql2v/J1UNe0BJ8kqz+iBCHAdVAiYa3So6WguyZUw1Y=
X-Received: by 2002:a17:902:d547:b0:2f0:33d8:f88d with SMTP id
 d9443c01a7336-2f03ee6fa4fmr43299475ad.0.1795166793696; Fri, 20 Nov 2026
 01:26:33 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com> <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
In-Reply-To: <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 20 Nov 2026 17:26:20 +0800
X-Gm-Features: AclHuK96MsvfmI4xhRwe-8BPGXSUlpaPU2PaBnGT6PTcIOYEbLNBvWMF0ZGTZE4
Message-ID: <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device removal
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolu,

Thanks. I agree that the driver must drain pending faults before
calling iopf_queue_remove_device(). My selftest removed the mock
driver's serialization, so it doesn't establish that fault reporting
can overlap removal in an unmodified driver. I'm withdrawing this
series and won't resend it.

I still have two questions about where the drivers establish that guarantee=
.

On VT-d, blocking_domain_attach_dev() calls
iopf_for_domain_remove(old, dev) before device_block_translation(dev).
When that drops the last IOPF reference, it calls
iopf_queue_remove_device(). On an SM-capable IOMMU, for a device that
isn't a real DMA subdevice, the only PRQ drain on this path is reached
through device_block_translation() =E2=86=92 intel_pasid_tear_down_entry() =
=E2=86=92
intel_iommu_drain_pasid_prq(). By then iopf_refcount is zero, so the
drain returns early.

In the same file, identity_domain_attach_dev() calls
device_block_translation(dev) first and releases the old domain's IOPF
reference afterwards. The comment there explains that putting the
device in the blocking state leaves the IOPF reference count
unchanged. Should blocking_domain_attach_dev() use the same order? If
the current order is intentional, what ensures that pending PRQ
reports for this device have drained before the last reference is
dropped?

On AMD, detach_device() calls iopf_queue_flush_dev() immediately
before amd_iommu_iopf_remove_device(). The flush helper waits for
queued work and documents that the caller must have flushed the
low-level queue first. The PPR interrupt thread calls
iommu_report_device_fault() directly, so waiting for queued work alone
doesn't establish that the thread has finished reporting faults for
this device. What in the detach path ensures that PPR reporting for
this device has quiesced before the device is removed from the IOPF
queue?

I may be missing a step in both cases. A pointer would be enough.

Thanks,
Qihang

On Fri, Nov 20, 2026 at 3:56=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 11/17/2026 9:54 AM, Qihang wrote:
> > iopf_queue_remove_device() kfree()s the entries on
> > fault_param->partial without unlinking them, leaving the list head
> > pointing into freed memory.  Since a74c077b9021 the fault parameter is
> > refcounted and can outlive the drain, a report that took its reference
> > earlier can still list_add() through those pointers.  Unlinking
> > instead turns that into a leak: the late node lands on a parameter
> > that is no longer on queue->devices, whose final put does not free
> > partial faults.
> >
> > This needs a device removed from its iopf queue while a non-last
> > (partial) request is in flight, with the caller not blocking new report=
s
> > for the duration.
> >
> > Patch 1 unlinks each partial before freeing it, matching
> > iopf_queue_discard_partial().
> >
> > Patch 2 adds fault_param->removing, set and tested under
> > fault_param->lock: a late partial is either drained, or rejected and
> > freed by report_partial_fault() (-ENODEV).  It covers partial-list
> > admission only; callers must still quiesce reports for the remaining
> > lifetimes.
> >
> > Both patches are scoped to fault_param->partial, not the group path,
> > the attach handle, or paths that never call iopf_queue_remove_device().
> >
> > Verified on v7.4-rc3 with KASAN + DEBUG_LIST and the iommufd mock
> > driver, its caller-side IOPF serialization deliberately removed and
> > test-only delays added; this shows the mechanism, not production
> > reachability.  The runs cover queue-before-removal,
> > removal-before-insertion, concurrent late reporters and re-enable.
> > Each round queues one partial before the removal and then races the
> > late reporters against the drain, so a clean run ends with every node
> > accounted for: 1800 =3D 900 + 900 and 3600 =3D 900 + 2700 (allocated =
=3D
> > drained + rejected), counted at a final removal with no reporter in
> > flight.  Nothing was left on fault_param->partial and KASAN stayed
> > quiet.
> >
> > With patch 1 reverted, the report is:
> >
> >    BUG: KASAN: slab-use-after-free in __list_add_valid_or_report
> >    Freed by task 1: kfree <- iopf_queue_remove_device
> >    56 bytes inside a freed 64-byte region (struct iopf_fault, list.prev=
)
> >
> > With patch 1 only, the same reproducer runs 1460 rounds without a KASAN
> > report and leaks one late node per round, which patch 2 addresses.
> >
> > Reachability on an unmodified production kernel, and any security
> > impact, remain unconfirmed: the test shows memory corruption and a
> > KASAN panic on the modified mock driver, not a user-triggerable bug on
> > a stock kernel.
> >
> > An AI coding assistant helped find this defect and build the
> > reproducer and instrumentation, which are available on request along
> > with the KASAN logs.
>
> +Jason
>
> The issues addressed by both patches are false positives. They rely on a
> fault being reported for a device after iopf_queue_remove_device() has
> been called for that device. The iommu driver must not allow that.
> Pending i/o page faults must be drained before the device is removed
> from its iommu's io page fault queue.
>
> Thanks,
> baolu
