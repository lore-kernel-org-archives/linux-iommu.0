Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774402;
	b=Lz4M26GGA6qO9rMkVtbcBeP6cEMcBZ/+W1w58VoqbEgvIlI57ClKAyHgASqSwZKrV7Yl
	 5JoDw9UU266vK1iU/FBTDUC1bWy9V1EX1rFYh1P4Xak2klZD+4aV3gyTKNqKGtiKOPHwO
	 OcSiumV/b8YxZFrkIWdzKduD2aTNstYKUy3+h3i6pEhAkzRkGVYtK//DIUoepp4G0stEC
	 BX3uk9jaCs3a9AKLCGDscQQcFUbg5WQfpX0sisvYMN13/XDBg2m73dRhXwAO2Wkg4lKbA
	 aImuGjEWndsq2MUQVJVQVzjNrQrEtQHcIH34CC4Zl+5YxPT4wtxTtW/T8s8yivb3eOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rg3eS140aI/+OFL98v6V5INyaBk7whCAxPtAkMQ5r2M=;
	b=SIM5dgp0R30tPfRCw3izK39JlL02XfMbnBcAYHjdqBHsMjzTZklG0azWSPoRyhseEfhn
	 KpKYV174ItyaIuwCk4oDDkVmdokOHTnAFUMkBvVotRYyDwoo1/d/YxA/z2pmU84R7CMgW
	 Wj0SfybWrt1MofFvVD/27Z3ylcrJwdzrvJskDsnifklWdp4iN7YFobFgwwGw9CMBdKSkt
	 1/nEVp/Apx7cp+OU3xFZbjXaz2F+dCKywUoZaC3TRciHcCPP8mF939rAOkjNBuQaHRjwA
	 uqrAIuRsf3O2Wil750ZJqmlnZPrw/7WxTJrsw/yggMz0Z3dBHLHGBFSeAg9idcKns7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iEsAII2T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96B606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 10:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA96B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iEsAII2T
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385d8a00598so11792091eec.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 02:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774401; cv=none;
        d=google.com; s=arc-20260327;
        b=Lg9b3nPAc5vaRTvruSMfEmKBR0G5tJ1MELBgJD49GK3SEcnlcg+ZaEJR1g2fERSc8h
         4/cpsLMqzAzjLGHVXYfqSycXwo19ZL18KRighDXwSTUpeZCVP8usob/32dsNXx+2pjCw
         AmKJuuSevC2ye3uI6j9yilPlKhw2SlTENTJJG82MBqMJPeCMr/GNH3EMq3cEsuioDl37
         yOPTR0+C87Bku+ofHwJX7tL3FLz0hnnKrvdO1g9hNmPczoDxEA4rvfV3XzGko2OlPKTe
         Q79jr9u2GOsgm9jDP4ZRZQqFD/AL6rCS5UmPyyOMzNioZ6ew/mWA9UUaClmgJzuNazMT
         Eo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rg3eS140aI/+OFL98v6V5INyaBk7whCAxPtAkMQ5r2M=;
        fh=2wGMJQTFyRmL7Ra8nYfwRXvbPLKet60sWsqm+dwsfJI=;
        b=T/a3RHJQmUXwPoGP3KtPD7CMsYHUII/sO1RZeJEGt5ajhMOnTWzKNlJbbYhQAqbjk9
         wbqw11qt5dgz8SxFov/glCudFqnR/8qgjEICYJOtQ//cNaJeBar3DHArA2d4UCQTo/q9
         OUVYDQZi3xLbTMJCf8ZG1ce0qhqmwCAgqqQtGYffSxFpDAqq2Ycmuh6o7g6xob4Q2eNL
         VJzPEtN0+cvh4k/5lVWAJblsxBJJ7LsUSbrd+k1xFN2/AMKYqbxtgkDrFZsnCyh6wmo2
         lw1b82wedefc6rCF2rOEeq5WKw5bqLKAFBTnXfccsfgmFtDgQsyiHO4BhpZGJmyNU2ue
         o2vQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774401; x=1796379201; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rg3eS140aI/+OFL98v6V5INyaBk7whCAxPtAkMQ5r2M=;
        b=iEsAII2T7bb9k1RM7xizq3sd2iXQvn4uNQNS53V3XL9farfJIzMwm0kyPUGPLW1wF0
         YLX+DCKMwbkkqgjYDQ3Uw6pGXhC1XopMuuTGhw7w1cUo6UO0hyxkqLyxbe3EyvXVhPHk
         40tTHab7BNcsAJuysY8j/U/uUfkWmlOWn+HTxkKUdjMztN6QHF2/FQFPAbMk3lXlh/8O
         4wQpa0dWRAQKnLAqAW3uMdnJLpLwUT5cPzsVb3wCpgrymCnX81K0dWCkRPtlxSrRXWr7
         gsXwKfNOSIMOuZW4wR85PEchqI0nji2KkbJWJsqhfYTT6END7niJWKtQvm6cBhivCgk/
         CGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774401; x=1796379201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rg3eS140aI/+OFL98v6V5INyaBk7whCAxPtAkMQ5r2M=;
        b=vkfjPGUNAIbYO2/UJLfp0ARj/ibvfKwad+/NYLJqkaXANG56co48gbnEARQEy0KhzN
         gOZEG1nbY+bQbaPeuOoQ3jDxF0rb5Xo7g2j5tSPpZ0f4/fiEosXHzsSxovKgPrpAcZNF
         QtjBxxVushptBCXWetYdAFi1TCamzKxwmBoOgFbyPyFwIGUSah+V9jY7dOKtJ4GaBeew
         vkEM71TN5XWJ33Bjdm8/2Kbjgdma5XS5pv7WfLp2oyOML4PRX0HdpCFO5Z5d+So+J7/6
         lo7rWmtkKeTwt4wT6C2+J0C3fJZIPDhN2klP/h66jVpRZNkHXNtOhyYGnIrt9UpQ61jR
         i9rA==
X-Gm-Message-State: APuU4Z+oFnCJ5qMgJgBKVQyi7a65sX028KQwidQbFHjINs1GMwNNHv9o
	fsUKeLAVMLtHdL8+tS2bKGlvZpgkqrplQO39KRrzAJFv+hyDLl4VOf7edNj+B6ys7fnSiU0KwUn
	Z/xDoMsrkoV+Am/+E+EEHA5aIm2xtes0=
X-Gm-Gg: AZFdTZdeeI1mEa72yra65C5D7ETcO02GSiukvrFutLdITUDIdIaFIPtm5OMarCxJve+
	lKRj16CMHTDEVjwCww1xjDEExlfh+DE8Kp44c6rKSXdOfYQvB+XcJaLKH4M/phkOqJzzoDRurv/
	8PM5jE0jJ7tneNvnn5ZDb4InbjDHlyvdeUh+y4RgKfNHcP72KAtCB3WLURABO3j5LHT3rT3H10a
	OW8/2/ui7Nfa2AKNjxHWyhvqfGDw6tOMgr7N4WSu6juT+edj/okgvww+PL2bNq9incFZRjBSc1I
	0yDrw2NilAreDiWqk/dXePizzVjS0eOghO/xPl8YP0RKKvE47bCfGOy2MjXyLh2gNf3OVcjlUTq
	1YuYImcTlP/lxLcEODVdKYQcrOYBF012S5nGK
X-Received: by 2002:a05:7300:cf87:b0:386:565b:4f9b with SMTP id
 5a478bee46e88-386565b529dmr19005091eec.36.1795774400449; Fri, 27 Nov 2026
 02:13:20 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <3304e166-c2e6-4bda-bc75-46ca73f836e1@linux.intel.com>
In-Reply-To: <3304e166-c2e6-4bda-bc75-46ca73f836e1@linux.intel.com>
From: Pe3k <pe3cek@gmail.com>
Date: Fri, 27 Nov 2026 11:13:08 +0100
X-Gm-Features: Aa3M54o_aQ8iJ-kAp3ekkaD3-m2tHNuDZRMPmqEPRSpmjapyGgTgQ3YlK0bXNb0
Message-ID: <CAGvcwsDMECLevqiy5iY2LOpPAoFknYVp+bJ+HDX8YemdzeUJCA@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added regressions@lists.linux.dev
removed linux-ide@vger.kernel.org

Hi Baolu,

Thanks, that is the same bug, and Renato's analysis matches what I see.
In case you missed it in the other branch of this thread: I bisected it
to c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu
ops"). Its parent c062db039f40 is clean, and so is 5.10. Before that
commit, VT-d reserved the RMRRs in the IOVA space itself.

I tested the one-line change on the spare Gen8: v7.4-rc4 plus

- return 0;
+ return iova_reserve_iommu_regions(dev, domain);

in the already-initialised branch of iommu_dma_init_domain(). Same
setup as before: intel_iommu=3Don, translated default domain (group 10 is
DMA-FQ with 00:1f.0 and 00:1f.2), 6 parallel copies of a 10 GiB file,
and an iommu:map trace filtered to 0xf1f7e000-0xf1f94fff.

  v7.4-rc4 + patch, two boots: clean both times. 0 of 6 copies bad,
      no DMAR errors, no failed ATA commands, no WARN, and the trace
      shows no mapping inside the RMRR.
  v7.4-rc4 unpatched, same machine and load: 1 of 6 copies bad (8 MiB
      of zeros), 64 failed commands with "Emask 0x40 (internal error)"
      (40 READ, 24 WRITE FPDMA QUEUED), and the trace shows
      iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg <=3D ata_qc_issue.

So the change fixes this machine. I know Robin's concern from the 2024
thread (Jerry Snitselaar's patch, same change), that a device may join
after the domain is already in use, when reserve_iova() is no longer
safe. This test does not cover that case. On this machine both
functions are added to the group in bus_iommu_probe(), before any of
them has DMA ops or a driver.

I can test further patches on this machine.

Thanks,
Peter

On Fri, Nov 27, 2026 at 6:38=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 11/25/26 02:08, Pe3k wrote:
> > Hi,
> >
> > On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
> > 04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
> > firmware declares for it. With the default translated DMA domain this
> > corrupts disk data on every boot under write load. iommu=3Dpt avoids it=
.
> > Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.
> >
> > Topology
> > --------
> > 00:1f.0 ISA bridge [8086:1c54] and 00:1f.2 AHCI [8086:1c02] share IOMMU
> > group 10 (DMA-FQ), probed in that order. The group's reserved_regions
> > include "0xf1f7e000 0xf1f94fff direct". The DMAR RMRRs covering that
> > range list 00:1f.2 in their device scope, but not 00:1f.0.
> >
> > 6.12.118 (default cmdline)
> > --------------------------
> > Once per boot, ~20 min into sustained writes, 23 errors (21 + 2):
> >
> >    DMAR: ERROR: DMA PTE for vPFN 0xf1f80 already set (to f1f80003 not 1=
67119001)
> >
> > from AHCI writeback (ata_qc_issue -> iommu_dma_map_sg). Each one is a
> > 4 KiB page that reaches the disk with wrong content: mostly zeros, some
> > with firmware data from the RMRR. No I/O error is reported.
> >
> > 7.3.4 and 7.4-rc4 (default cmdline)
> > -----------------------------------
> > No DMAR errors. Instead 64-84 writes per boot fail before reaching the
> > device:
> >
> >    ata2.00: failed command: WRITE FPDMA QUEUED
> >    ... res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x40 (internal err=
or)
> >
> > followed by I/O errors and 4-8 MiB of zeros in written files. In one
> > 7.3.4 run the machine also took an NMI (iLO: "Unrecoverable System
> > Error (NMI)"). An iommu:map trace filtered to the RMRR shows the cause:
> >
> >    map: IOMMU: iova=3D0x00000000f1f7e000 - 0x00000000f1f7e000
> > paddr=3D0x00000001c94d6000 size=3D0
> >     =3D> iommu_map_nosync <=3D iommu_map_sg <=3D iommu_dma_map_sg
> >     <=3D dma_map_sg_attrs <=3D ata_qc_issue
> >
> > With iommu=3Dpt both 6.12 and 7.3.4 run clean.
> >
> > Suspected cause (not verified in the source)
> > --------------------------------------------
> > The domain's IOVA reservations seem to come from the device that
> > initialises it (00:1f.0, no RMRR). When 00:1f.2 joins the domain, its
> > RMRRs are identity-mapped but never reserved in the IOVA allocator.
> >
> > Reproducer
> > ----------
> > Fresh boot, ext4 on an AHCI disk, 6 parallel cp of a 10 GiB random
> > file, sync, drop_caches, compare hashes. Fails within ~25 minutes.
> >
> > I can test patches on a spare machine of this model. Full logs, the
> > DMAR table and traces are available on request.
> >
> > I used Claude Code to run the tests, analyse the
> > logs and draft this report. The results and logs are from my own
> > machines, and I have reviewed the report.
>
> This seems to have been root-caused in this thread:
>
> https://lore.kernel.org/linux-iommu/02b201dd5ea3$02b88430$08298c90$@mache=
lett.com/
>
> A fix patch has also been posted:
>
> https://lkml.iu.edu/2411.1/00575.html
>
> Perhaps you could give that patch a try?
>
> Thanks,
> baolu



--
