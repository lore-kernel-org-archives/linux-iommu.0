Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53A405D4
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825498; cv=none; b=clnDlYEcy2fr6gJvbiB/bV9eKESRK/mssfJpTme4jl1Q7/io+7mGYEjOM/V1/9ogp5C4t16BW8VQgGK3b4i1IRE4ce7pUsP0l2NzExN/E+TqxammrQN3/zTqYWxrmiGtQQ6tygD/pFu1yLLeXpV86I5tiLxrff6Virpu1l6jT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825498; c=relaxed/simple;
	bh=86g+qEoenkm0oeTQiA6yz/w3YphkvvGPQnWrjxXicGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kt+FtaWYEaUaooeXEjd2S32kHXa78nsgL+lJoW84xEkh/1XEiZRZPQr/QOumow0vXsvtOPJ7zMq9K+/FCSEusqZHMd7cgpqA5gFLR/ZZr14zk2KiU5TYSveBi4zIedy3KmtnGioIBrA20xKHi6VjPA7VhU8QPN5Ngv3WRo+Y3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=avXHEFiD reason="key not found in DNS"; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="avXHEFiD"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bec19b893aso821770b6e.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 14:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706825496; x=1707430296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CCoiRTZe5/e8MNjxiyM/onfHMZyM22m6CAEHOZonNo=;
        b=avXHEFiD0wlFPI5LBRA5TlHcz+oXRx5OuQoth7QdpBA9sICRonxGZ25mJiK7+zxVJM
         aQqiwxjEvG2B7LRfIPO1WB/3ZXhySulrDp1jGgoynTnr+DH7bVoGKDr0GgxOxI3P4qF7
         bVVwu3EPq0K2z9pMmb8gEpSVOazIWgSqdySgpUYKSOp4Al8AO1WcTyvNyNYE/Snacf8E
         j4++Te+ydnXFhJZNAaN03TBcxOx3L732Zt2RISzXL7djD7yPWT4lg7mTmaBHVK4yKMrN
         bhTu1MiVj+MzjH1jJnDcYgqv/AnzaTeLcB5aSpUHSefLxyTrpp/yg/U4y+CXNstCDElA
         CqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825496; x=1707430296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CCoiRTZe5/e8MNjxiyM/onfHMZyM22m6CAEHOZonNo=;
        b=cvYvsT4l6SFi//o1OJAFuQU99mtbbINgLmfdQqiA6ieBiEwsGeND61YW8/jMII3evP
         VcJc1URPOlMY+XWvARVWOprO7pUtOyDLPVqryPc4OxLX1rTSm1v7k02pSFbXlbV4Rv2C
         osyAKAmKyOXSDg6nComfU97HrTjBlffunbs5TLTRA2UPEwKscoOdQ3vVAcQ/70SpjWaG
         iffhCcQ904Zebsxdf0nYhBshfwmOd59vkL6V59PcxtYuIwLpASK8rrECpMfz0PhJpS5o
         +gEtqb4seeIdaNxUF3+Bz5TkD4r9o+//lib4naFTIeN+V+dPc4WnWR/L2p1EBgWK5u0v
         j1gQ==
X-Gm-Message-State: AOJu0YyZLYHpwpLLLWhYBLeo7EJAxuEeGJePF87/ooioRpCqnkk4MZRU
	GXUYfEIiXOR3qCA5838PT1clx2k/MkYgHLUcTNklHnlDMA8rhcmP7t7AgdKOAjxeUv4lGEIVoS6
	5drDEByIcSo5tse69QwpKldr4SD73l9ljGeD8rg==
X-Google-Smtp-Source: AGHT+IHEBN97pDgrEcfxjhjtW1XJtpXigPPu4lYtbTbUci4Hva6kibJ+lbK2oPolooQmP44UMPBQalm+wnWgnFLvZqI=
X-Received: by 2002:a05:6808:13ce:b0:3bf:ba1b:e9c7 with SMTP id
 d14-20020a05680813ce00b003bfba1be9c7mr2080294oiw.55.1706825496199; Thu, 01
 Feb 2024 14:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com> <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
In-Reply-To: <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 1 Feb 2024 17:10:59 -0500
Message-ID: <CA+CK2bBRK=cDe5a-TuLMUs6DWRO06FzL6JDmoMmnwFfdt+Z-kg@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:23=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2024-02-01 9:06 pm, Pasha Tatashin wrote:
> > On Thu, Feb 1, 2024 at 3:56=E2=80=AFPM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >>
> >> On 2024-02-01 7:30 pm, Pasha Tatashin wrote:
> >>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >>>
> >>> The magazine buffers can take gigabytes of kmem memory, dominating al=
l
> >>> other allocations. For observability prurpose create named slab cache=
 so
> >>> the iova magazine memory overhead can be clearly observed.
> >>>
> >>> With this change:
> >>>
> >>>> slabtop -o | head
> >>>    Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
> >>>    Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
> >>>    Active / Total Caches (% used)     : 135 / 211 (64.0%)
> >>>    Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1=
%)
> >>>    Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> >>>
> >>> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> >>> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magaz=
ine
> >>>    91636  88343 96%    0.03K    739     124      2956K kmalloc-32
> >>>    75744  74844 98%    0.12K   2367      32      9468K kernfs_node_ca=
che
> >>>
> >>> On this machine it is now clear that magazine use 242M of kmem memory=
.
> >>
> >> Hmm, something smells there...
> >>
> >> In the "worst" case there should be a maximum of 6 * 2 *
> >> num_online_cpus() empty magazines in the iova_cpu_rcache structures,
> >> i.e., 12KB per CPU. Under normal use those will contain at least some
> >> PFNs, but mainly every additional magazine stored in a depot is full
> >> with 127 PFNs, and each one of those PFNs is backed by a 40-byte struc=
t
> >> iova, i.e. ~5KB per 1KB magazine. Unless that machine has many thousan=
ds
> >> of CPUs, if iova_magazine allocations are the top consumer of memory
> >> then something's gone wrong.
> >
> > This is an upstream kernel  + few drivers that is booted on AMD EPYC,
> > with 128 CPUs.
> >
> > It has allocations stacks like these:
> > init_iova_domain+0x1ed/0x230 iommu_setup_dma_ops+0xf8/0x4b0
> > amd_iommu_probe_finalize.
> > And also init_iova_domain() calls for Google's TPU drivers 242M is
> > actually not that much, compared to the size of the system.
>
> Hmm, I did misspeak slightly (it's late and I really should have left
> this for tomorrow...) - that's 12KB per CPU *per domain*, but still that
> would seem to imply well over 100 domains if you have 242MB of magazine
> allocations while the iommu_iova cache isn't even on the charts... what
> the heck is that driver doing?

I am not sure what the driver is doing. However, I can check the
actual allocation sizes for each init_iova_domain() and report on that
later.

>
> (I don't necessarily disagree with the spirit of the patch BTW, I just
> really want to understand the situation that prompted it, and make sure
> we don't actually have a subtle leak somewhere.)

Yes, the observability is needed here, because there were several
optimizations that reduced the size of these magazines, and they still
can be large. For example, for a while we had 1032-bytes per-magazine
instead of 1024, this caused wasting almost half of magazine memroy
with 2K slabs. This was fixed with: b4c9bf178ace iommu/iova: change
IOVA_MAG_SIZE to 127 to save memory

 Also, earlier there was another optimization "32e92d9f6f87
iommu/iova: Separate out rcache init" that reduced cases when
magazines need to be allocated. That  also reduced overhead on our
systems by a factor of 10.

Yet, the magazines are still large, and I think it is time to improve
observability for the future optimizations, and avoiding future
regressions.

Pasha
