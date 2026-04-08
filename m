Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D33B0ADA
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672823; cv=pass; b=W1odXTfUDaiS03uE+nd4PgnQspwvS20Xwmzl4BSPHfLHP59IE/7RhIvCSY9e+58nqPRxGlHutZSPdxwqsohLnC2NoyO+fNKmgjAhXr4Q1ztaQpP0Rk915kLdjn3DNAMix+X/vcxpDyDMO/m+VdsYDIHoguLw9rvBzEGXGGNuqyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672823; c=relaxed/simple;
	bh=SKVrL5ccqZ1M15Bla0Mj4vxt8947C+VtIc9NoFBMcnY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B/8F2D0kKnEPXKvE8ErEO5MB411jel/JzxLs1u/BRCu3I6Bq7+xVTliG647PO5iXYHYI8E4N7JnpVAq+I5lxPDqqssBvkh1IWy74COJpyx8lfWQwt0YJhzpDzcVQKi/suKAnk086+ZQHwIMLbZKI8gl7LQeX6HNNSghTtH1fc54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=Ucn5R2tA; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="Ucn5R2tA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d965648a2so68599a91.0
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 11:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672821; cv=none;
        d=google.com; s=arc-20240605;
        b=hmgU5pfdutP89sskIoHUTfrV1aqzeBPJFj6/uJyzrJ95wXdfc+Jo5P/EeTPEK1Fm73
         DeP44rk+Gk4dgAU+UeaYxrvRyDPoQK9xuvJmCzejLES7vnIVz85AHhClwbdxSsZjCwax
         QYSccSYRK8o7aW5nvj1Ta0ydPAdVGIW0SdICIgTtmttXfU3mlglPFpoNpbnPdehH5H3z
         unxM07fhXuJ2I9MuJ1KbZy+KMb0sn4difZuL231tnogI7pUx0NlkloHzZIcY8pyaZele
         dRESh0fepbNPOqdRmvQUia4BCAbrKFm1MkIej2H0XVsme8g4MnjjwdXq4KoFK97WlHg4
         rFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DK8prnBL2T+8a4dK8WUWo2uyl9rlBlUaMoJyJHWk0Dk=;
        fh=e47DfwqcwqkazzHqM1mxtI5HNOP59m17nHe5UXGkI2U=;
        b=lsG1aGRgUKeEk8i6A2i2FJlv+9XaCqnAeKiUHNzKK1ox+JbZy+Qj4EHU2A5mD1sLG2
         REyZ5sTTiKPQ54Dxa6k/OKi+YOIDxikcJYjktFlt1hsC0NH/LT5BiWV4pfTsuOQTJIP2
         MH6O/INauUpqrziHswoRsCIasUiEqpKQcm8xmrs2xmiEinp55vd8M8plb9ecssf89z1a
         DdKr3X1hYx74asqGgSlulOpp/knIrl5eQJMZFkYSI5XRh0hD1fKiIZa047Yc34bB8HhR
         OFfFu1I/LME5ZaSZSXdpx70ad48+vPlb7mE+1mkXZiugrkY7PRBFKJMG3vd3RVxuEXS6
         ZWGQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775672821; x=1776277621; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DK8prnBL2T+8a4dK8WUWo2uyl9rlBlUaMoJyJHWk0Dk=;
        b=Ucn5R2tArNdqJIZPnSVwkaDRyMoswVmE92PEoP2z0V2xFH5K7deOZZDbM6LhWlskfP
         jLW8XYGB/jNLMWSXt5/gRHeZT7fNwY8XI5fxOmt9RQcNazEsIbZU1IWxSPe2DCZp6kux
         ySyDfFv85wHByR9c7QBanp3dChqGdgXJwekXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672821; x=1776277621;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK8prnBL2T+8a4dK8WUWo2uyl9rlBlUaMoJyJHWk0Dk=;
        b=W7kOpd/8lXJiishmh1U6D/K3FlgfoR9anaR+VGNzXw8eZAoFVE/gaWuzWexvxa7dZH
         jRHJ6Pky8lKOGrqnceN5qssc2H6k7MC4CcT5nuPm/LKBamLky+6kwigZpQxEQi5J/ghP
         tes58tqTAtFeq3OkrrruMn7kt4BsE1y0WJakFWiCptg0gyvFbGwS2jaKHnw88hV0EzX2
         UnqroNa3PC5tgVRZ5RsH6DnIT4qgvW20DoYq3/xMcCvfZPlwf9Lv4HsKaC2zo5wi/O1u
         zyY69unimXrUQg4x003m8xvU+d8ZvHIGwm83uo9fpkTJWzlSnw+QSkXQGd2tt2k283Mk
         oRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUEEvc3VxhhyCkmdyjmWaoelxOCEQJp3r4srTxqElORWectNUJeIgWA/VU1wrdXjnJ9ogw2ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO+1h0TunP+oqXP0P9luhwFVjigiMnbUgZNpE1G2BZcgctZ0Ub
	3t/PJxHP+sRf8O7TgT8ISUbEuewdxY+vJTk2w09JtrWzodBsf2vEnWgFeXuB1CHDLrMnte5sx0S
	+zK2pVnMKpdzlBgUh+fgANKVP5r6xdBayMpmgPpimiQ==
X-Gm-Gg: AeBDietJyvqreSzw398wZeVy3QoCLdIuMq6D2savPIvepBvDwQXdrd7rbbE3Js/TqKM
	3g/5yQtEqvbJrN2gHNpFVyvvKGjX4mSwc01sMAiMRXey6b+C2fCLnKTAHixpUmRGbZl4IB3Kmod
	/Bu0brxvbfsUKxU3T2y4ElE7F4NyLxyWy9YNE0MQgnkmOvqkD825+Qd3kr1OEtHh2Zg6lymtxbR
	rcfYuFT57klSGAkZAxpvenyFYohJaW8pKgG4W6WNkdYAOld3LxjFYNMGMvZlLfQraQ1p+Qcd0WL
	nCte1p73
X-Received: by 2002:a05:7301:1f04:b0:2c6:31f0:9fe9 with SMTP id
 5a478bee46e88-2cbfc6573d2mr13280380eec.28.1775672820751; Wed, 08 Apr 2026
 11:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 8 Apr 2026 11:26:43 -0700
X-Gm-Features: AQROBzA-xMj4kggYj74lrmJjIX9wKsEjXJikKiqJja9EVVHI6ydeW9zvBHQn7Yw
Message-ID: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
Subject: [FYI] iommu/iova: unbounded memory growth on 160-core ARM64 with 64K
 pages and DMA-FQ
To: linux-iommu@vger.kernel.org, iommu@lists.linux.dev
Cc: robin.murphy@arm.com, jroedel@suse.de, will@kernel.org, 
	Nagi Parimi <nparimi@uber.com>, Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>, 
	Vikrant Soman <vsoman@uber.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Sharing an observation of unbounded memory growth in the IOVA rcache
depot on ARM64 that may be relevant to others running DMA-FQ on
high-core-count machines.
A config misconfiguration during a kernel upgrade from 6.1 to 6.18
unintentionally switched our IOMMU default from passthrough to
DMA-FQ. Over several weeks, 93
ARM64 hosts (Ampere AmpereOne, 160 vCPUs, 1 TiB RAM, 64K pages,
arm-smmu-v3, heavy NVMe + network IOPS) accumulated up to hundreds
of GiB each of unreclaimable slab in iommu_iova objects, eventually
OOM-killing production workloads. Total waste across the fleet was
more than 25 TiB.
The issue is resolved on our end by correcting the config back to
passthrough. We're sharing it as a heads-up.

The slab growth appeared under dmaengine-unmap-2 due to SLUB cache
merging with iommu_iova (both 64 bytes on ARM64). One host after 25
days showed ~3 billion active objects at near-100% utilization,
suggesting genuinely retained objects rather than slab fragmentation.
Two things stood out as possible contributing factors:
1. Since commit 911aa1245da83 ("iommu/iova: Make the rcache depot
   scale better", v6.7-rc1), the depot is an unbounded linked list.
   The drain pops one magazine per 100ms tick and only when
   depot_size > num_online_cpus(), which on 160 cores may not keep
   pace with sustained high IOPS.
2. With CONFIG_ARM64_64K_PAGES=y, each slab page holds 1024 64-byte
   objects. Slab pages can only be reclaimed when all objects are
   freed, which makes it harder for partial drain to translate into
   actual memory reclaim.

Our kernel cmdline included iommu=pt, which we expected to force
passthrough. However, that parameter is only handled by x86-specific code
(arch/x86/kernel/pci-dma.c). On ARM64, only iommu.passthrough=1 is
recognized by the generic IOMMU core.

Sincerely,
Alireza Haghdoost
