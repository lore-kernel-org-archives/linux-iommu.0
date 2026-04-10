Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6393382D3
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859621; cv=pass; b=e+LNQIedbJqyxe3IxQy41iY5mcsjjJtv6qHXQjoJQdowuuhTMQkdQt7aFLUjobmEVlbLhRd1JNCqHgbDbP+7Szs6XsCn+45Z+KXH9G8MapO7wcIjboN9NpcbD7WAYWFbycM2p8pgzTdu+d9VVMA8lfxtRBqUyqZGyQMvzRWeQRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859621; c=relaxed/simple;
	bh=WpEExcbJhHbHvD4OVetfo0u/azX7GU+++JGeQSEmHRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnl2Z04lcIqxfeivuUMl/kz3z6gT/zz9AUVXML1bHQRQLFejcqwVtLuYCAEpGRMidwuLjC5aicXQfUXthS2vqknUvlrGSZ1rxglOtsB2LoCcsj0NOTxwIAs9LszDZJn2xt5DeS+M+Msivsy8B3h91V1nUX2BiC10GM0KWgR+pTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=7Qkq558w; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="7Qkq558w"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ab3e26cceso25904097b3.3
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 15:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775859619; cv=none;
        d=google.com; s=arc-20240605;
        b=HbADNVIcuUz1yjEapll0fKr5joiiSzAyN0sz9iUM3lQ1w3cdrsZbrTiuInG5WYakom
         c/pWkmCECOsRHJZkyFEkTARHEkaezdvvZQB0l/2FBZIqDoCGRi50gVwYweXEMBXNx0d7
         L+tSqVHOdwkENSKaA/e1nq9/tIABNltUmDsRijy4+AQJNighW0pSS+1ji996lPVBsdtt
         8zbrYe9s0Qsqd9sM/0xC19QxiG2f2Uy0+/rPgKodtSMsCgKB5QcT3LVrtbL2UXlwv2dF
         DLU/RIIAFAhK1VeYq/MF1ggMwBJeiSSuLbupCtYw6Pz/Frk71F/IrRa5IhHn1WeYH82j
         dWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIbOxa8axd32UeY7Jz70Yj0hoZbpGQL/4FWSZ9nxCHo=;
        fh=uGRzUREsCVyqYSnq+g34tIRmnyKCX4pCxhVduAzU9sM=;
        b=AZzNchYMyV0jGrJyAvr7cqm1Iltje/8A4bqCKB2O8MXs2Bb8So2uFTEWbh15KcJM0j
         Ud7U08j9Su99h8eaK9GZpLHWfdfCFPvm/ci/ALIXAvUC2wqtQraco5s1xxsgd6vrqnRU
         fMTqgWQSskyBocxGjh4Aphi678dFEN8BgMvvzs+IRK4NOGqHYmMYpeInTwB3r3nNMzWJ
         OaNVi+KlrOaDfxR1W2Zz+CQqt7IsQpJoRBIKmKhUysEdZ6N356Ri/ys+9w3OJPykjzlT
         7DT2p1zfG43HZ5LVPB/nlQUkT5h7myDhqRWlxbum6u990RMFh1df6vgw9TT+qR8NADcB
         NoOA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775859619; x=1776464419; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIbOxa8axd32UeY7Jz70Yj0hoZbpGQL/4FWSZ9nxCHo=;
        b=7Qkq558w14e9bTnUPMuqaSnJKYkLOYymiH4VwjztrN8VgurHOb6jPRNtBCtIn8TqwY
         Sh0BGcUkANV/ui0Te+nB/kJMZB3KK5MQem/kwj4v+pHA8GuPm4XgHaCS5Tph5+oNdaGo
         4WP2Mi7/ZPnWbc4f8FB4Czulaylu4pV6NZapo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859619; x=1776464419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIbOxa8axd32UeY7Jz70Yj0hoZbpGQL/4FWSZ9nxCHo=;
        b=j1yAR/qbF07QHfyovxaDRU7Y+zORBy/ZesXMTKVCfQabyDwTbbaAZSL6g5sVH4DtcC
         TbblgQds/1dcXgKFUwY+K1SNx+9PltEapvo6Fpy6hFIaZjwC2DaPk81XNN2AGp9QBYne
         DH1MUGpSVXIRohxSAu90DxCDBvxVFNpzoeAMNGMLwwv56kxuMLZxMN2nwRwxVfpsqtg2
         1yCYlyv7wMr2Sse/Fvx4xqoVUwnPmNdIM82N9JT2nuJb4RtcwHTvW0rzIidJbFggNWXk
         yszJCd3VvJgzoIArdP0Zfz3OxXgc6/9/xtQsIN0sCSHXXo1dqJ6ckNKaYTWM5tVtv08N
         IMFw==
X-Forwarded-Encrypted: i=1; AJvYcCXSFeGcMJkMul1ONGtjZ4GcHXPGU4Tt6i8zEJaf4mAebAsEjOiYeKpmht9ntRZzmfrkPRWO4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoL7smnqLb+geV3wGLzZ/PV/REUb1Ii5pFP5PlJ2M9eY1qbWvs
	w+ik3eb6IR2vJWSJwL7fVk5ZV9R2k3GhgU94F0CIZ0b8gS1fbJIYlKG2u/+QJ5SWGSCCnM0odYY
	HG0mnN9ViXA04dvfjVEEIJbgOsmqrBAEJy0IP3z6SCw==
X-Gm-Gg: AeBDievxqYjH92gwvCo4yZZGWhJ+sIW7V2THtgDEsqtDZKnqEQ7Dp3jYeBO6s9vcAh5
	XC6yWXsz/6/z7Ot0zbCi/DsuC/c60NSu1Vn9bjSuT+iI7e1jqmLdZ41ltaBVlZX7LsP9ACj+mSP
	Z/Fh4E/iM3Vfk1vN5tamokBbVytZ3/r4+bT4NChcAezmykw2MlDy7P0nlFFbnfQCMsWJCyPYAaQ
	Hk9pCyiK/7tCzDRI45wbytY8JrTGMBugPHS3dnXvJGDIXgPWVeapRFQXRw1rhHXHc+ZWtK03sJP
	vrmm9sVSTgHG2mFZy0Q=
X-Received: by 2002:a05:690c:a053:b0:7ac:ff2:4603 with SMTP id
 00721157ae682-7af6fde9d0amr46962257b3.20.1775859618560; Fri, 10 Apr 2026
 15:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
 <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com>
In-Reply-To: <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 10 Apr 2026 15:20:02 -0700
X-Gm-Features: AQROBzB93KvICbMCQkGh8RvaD2CP4WviPbQ_Gg_-miL0jcyIMKcC2Ol52NV55RM
Message-ID: <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
Subject: Re: [FYI] iommu/iova: unbounded memory growth on 160-core ARM64 with
 64K pages and DMA-FQ
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-iommu@vger.kernel.org, iommu@lists.linux.dev, jroedel@suse.de, 
	will@kernel.org, Nagi Parimi <nparimi@uber.com>, Kshitij Doshi <kshitijd@uber.com>, 
	Jeff Bean <bean@uber.com>, Vikrant Soman <vsoman@uber.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 3:48=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2026-04-08 7:26 pm, Alireza Haghdoost wrote:
> > Hi all,
> >
> > Sharing an observation of unbounded memory growth in the IOVA rcache
> > depot on ARM64 that may be relevant to others running DMA-FQ on
> > high-core-count machines.
> > A config misconfiguration during a kernel upgrade from 6.1 to 6.18
> > unintentionally switched our IOMMU default from passthrough to
> > DMA-FQ. Over several weeks, 93
> > ARM64 hosts (Ampere AmpereOne, 160 vCPUs, 1 TiB RAM, 64K pages,
> > arm-smmu-v3, heavy NVMe + network IOPS) accumulated up to hundreds
> > of GiB each of unreclaimable slab in iommu_iova objects, eventually
> > OOM-killing production workloads. Total waste across the fleet was
> > more than 25 TiB.
> > The issue is resolved on our end by correcting the config back to
> > passthrough. We're sharing it as a heads-up.
> >
> > The slab growth appeared under dmaengine-unmap-2 due to SLUB cache
> > merging with iommu_iova (both 64 bytes on ARM64). One host after 25
> > days showed ~3 billion active objects at near-100% utilization,
> > suggesting genuinely retained objects rather than slab fragmentation.
> > Two things stood out as possible contributing factors:
> > 1. Since commit 911aa1245da83 ("iommu/iova: Make the rcache depot
> >     scale better", v6.7-rc1), the depot is an unbounded linked list.
> >     The drain pops one magazine per 100ms tick and only when
> >     depot_size > num_online_cpus(), which on 160 cores may not keep
> >     pace with sustained high IOPS.
>
> Hmm, TBH that makes me suspicious of a driver bug - IOVA magazines are
> only pushed to the depot list when IOVAs are freed, but in order to be
> freed, they obviously first need to be allocated, and allocation will
> pop full magazines back off the depot list, so the total number of IOVA
> allocations still only grows to the actual peak working set size of the
> overall system workload. Thus at least the _maximum_ iommu_iova cache
> usage for non-passthrough is not affected by the depot changes, the only
> difference is the struct iovas will tend to live longer as they will
> stay around in between uses more often, rather than be freed and
> reallocated in the slab cache itself. There is of course some additional
> memory cost in the iommu_iova_magazine cache, as there can now be
> significantly more magazines in flight, but even on big systems I'd
> expect that to only be in the order of tens of megabytes, so still
> pretty negligible overall.
>
> Truly unbounded growth would stem from a driver passing the wrong size
> to dma_unmap, such that the magazines are pushed to the wrong depot
> list, and thus IOVAs are _not_ reused correctly. It's true that such a
> bug would have been heavily bounded by the fixed-size depot before, but
> hey, we don't optimise for bugs, and the whole point was that that was
> also severely bounding the performance of correct operation on large
> systems (i.e. >16 CPUs or thereabouts).
>
> If some workload really does oscillate back and forth between doing lots
> of DMA and then needing as much memory as possible for other purposes,
> and is happy to trade the setup cost of the DMA phases for more
> "in-between" memory the we could certainly consider adding some sysctl
> tuneables for how aggressively the depot reclaim runs - that's something
> I always had in mind, but which didn't seem worth doing unless and until
> it could be proven to be useful.
>
> > 2. With CONFIG_ARM64_64K_PAGES=3Dy, each slab page holds 1024 64-byte
> >     objects. Slab pages can only be reclaimed when all objects are
> >     freed, which makes it harder for partial drain to translate into
> >     actual memory reclaim.
>
> I guess that legitimately long-lived IOVAs fragmenting other slab caches
> could still be a potential issue either way though, so we could perhaps
> also consider making a performance argument for SLAB_NO_MERGE here.
>
> Thanks,
> Robin.
>
> > Our kernel cmdline included iommu=3Dpt, which we expected to force
> > passthrough. However, that parameter is only handled by x86-specific co=
de
> > (arch/x86/kernel/pci-dma.c). On ARM64, only iommu.passthrough=3D1 is
> > recognized by the generic IOMMU core.
> >
> > Sincerely,
> > Alireza Haghdoost
>

Robin,

Thanks for the analysis -- you were right that this is a driver bug,
not the depot. I instrumented the kernel and do see missing unmaps
from 10-second trace of all three probes simultaneously:

alloc_iova_fast:              404,732
__iommu_dma_unmap: 403,415 (1,317 fewer than alloc)
free_iova_fast:               403,234 (181 fewer than unmap)

The 181 gap between unmap and free is expected flush queue pipeline
delay. However, the 1,317 gap between alloc and unmap means 1,317 DMA
mappings in 10 seconds were allocated but never unmapped.

The problem is in nvme_unmap_data() where the two arguments to
nvme_free_sgls() are swapped. For multi-entry SGL requests, sge gets
the first DATA descriptor instead of the SEGMENT descriptor, so
nvme_free_sgls() unmaps only the first entry and returns, leaking all
subsequent DMA mappings.

This only manifests on ARM64 with 64K pages because
blk_can_dma_map_iova() returns false (4K NVMe page vs 64K IOMMU page
granularity mismatch), forcing per-segment DMA mapping through
blk_dma_map_direct(). On x86 and ARM64 with 4K pages, IOVA coalescing
handles the unmap via dma_iova_destroy() and the buggy path is never
reached.

I confirmed this on a production host by setting sgl_threshold=3D0 to
bypass the SGL path and noticed the slab growth stopped immediately.

I will submit a patch in the following email.

Sincerely,
Alireza Haghdoost
