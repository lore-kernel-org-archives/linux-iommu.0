Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C223F269;
	Wed, 15 Jan 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930419; cv=none; b=g9WMd0T+3egTD8Dj4PyP29UOW2mXQVIWyQnW8m1JY8bJBupmPTrIO1cCg9tN/kyxa6mo+NWACPGwu5x+odvfOxyWLr2jnzmnY5Id5J/5xfzOiF3pOB9dafo8FEnew5JUwqKwuYc65Bm/n+oug3vmywuUyD7lKH9eMYSyCAJUoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930419; c=relaxed/simple;
	bh=A5vDtaKwCUYk4D/fYrU86gKCpU7MX1HzZn2F2HXS338=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjV+aJjgBwVZB2AvjtYKH2AFCYGyiItnkrg9/Ek14M8HbqZSJGuv41NeZhNc5LmGop/AOkCxiW8880pzsJSW1twM5KGAgNpiC3gyYU1P7wIScTslciKMmWkeQwQEzQ+rvavrNThK/H2W2/vy9bjVelZj/WekSdGMbsgRuzF9cOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=t54iOFNm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="t54iOFNm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=q6hBrcRMQhF/pox7UFnnZR0yegceyTy2ATLnjvMiHHU=; t=1736930417;
	x=1737362417; b=t54iOFNmVPxvKLLwPjKsiSIPYw2Ifa42zzaPi4RMHNkXuMB7+5w1mTRHDEeTb
	IBfgSKPV23e1u9fqTg7PTOMDIn5IRHWXuu/O4MK7XyKuhoxNQHaS6ZtLSrA83w3Aa4lE4xPIlKh9W
	e8uVUIVaFqnFQSVAIP7Z+PNpzT+T1m23Bf9sWsS0p/R1Eg+trlqOLMfAscjI1/W2zioA6Qf/Y+Oo/
	imKfO/liqoBkEZuDyhp9ySY5Lpy7qKi5glVM0ln+oCrMWHei08eQNlivmmHYTECwxKQ+WGNSpHg/l
	bYDD/MIycePE1ZYIzryczRprAxGEehn6ZY4bFeYZAmdGIuhxwQ==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tXywX-002TwE-1b;
	Wed, 15 Jan 2025 09:40:05 +0100
Message-ID: <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
Date: Wed, 15 Jan 2025 09:40:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>
Cc: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1736930417;15830067;
X-HE-SMSGID: 1tXywX-002TwE-1b

On 15.01.25 07:37, Bruno Gravato wrote:
> I finally got the chance to run some more tests with some interesting
> and unexpected results...

FWIW, I briefly looked into the issue in between as well and can
reproduce it[1] locally with my Samsung SSD 990 EVO Plus 4TB in the main
M.2 slot of my DeskMini X600 using btrfs on a mainline kernel with a
config from Fedora rawhide.

So what can we that are affected by the problem do to narrow it down?

What does it mean that disabling the NVMe devices's write cache often
but apparently not always helps? It it just reducing the chance of the
problem occurring or accidentally working around it?

hch initially brought up that swiotlb seems to be used. Are there any
BIOS setup settings we should try? I tried a few changes yesterday, but
I still get the "PCI-DMA: Using software bounce buffering for IO
(SWIOTLB)" message in the log and not a single line mentioning DMAR.

Ciao, Thorsten

[1] see start of this thread and/or
https://bugzilla.kernel.org/show_bug.cgi?id=219609 for details

> I put another disk (WD Black SN750) in the main M.2 slot (the
> problematic one), but kept my main disk (Solidigm P44 Pro) in the
> secondary M.2 slot (where it doesn't have any issues).
> I rerun my test: step 1) copy a large number of files to the WD disk
> (main slot), step 2) run btrfs scrub on it and expect some checksum
> errors
> To my surprise there were no errors!
> I tried it twice with different kernels (6.2.6 and 6.11.5) and booting
> from either disk (I have linux installations on both).
> Still no errors.
> 
> I then removed the Solidigm disk from the secondary and kept the WD
> disk in the main M.2 slot.
> Rerun my tests (on kernel 6.11.5) and bang! btrfs scrub now detected
> quite a few checksum errors!
> 
> I then tried disabling volatile write cache with "nvme set-feature
> /dev/nvme0 -f 6 -v 0"
> "nvme get-feature /dev/nvme0 -f 6" confirmed it was disabled, but
> /sys/block/nvme0n1/queue/fua still showed 1... Was that supposed to
> turn into 0?
> 
> I re-run my test, but I still got checksum errors on btrfs scrub. So
> disabling volatile write cache (assuming I did it correctly) didn't
> make a difference in my case.
> 
> I put the Solidigm disk back into the secondary slot, booted and rerun
> the test on the WD disk (main slot) just to be triple sure and still
> no errors.
> 
> So it looks like the corruption only happens if only the main M.2 slot
> is occupied and the secondary M.2 slot is free.
> With two nvme disks (one on each M.2 slot), there were no errors at all.
> 
> Stefan, did you ever try running your tests with 2 nvme disks
> installed on both slots? Or did you use only one slot at a time?

$ journalctl -k | grep -i -e DMAR -e IOMMU -e AMD-Vi -e SWIOTLB
AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: lazy mode
pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
pci 0000:00:01.0: Adding to iommu group 0
pci 0000:00:01.3: Adding to iommu group 1
pci 0000:00:02.0: Adding to iommu group 2
pci 0000:00:02.3: Adding to iommu group 3
pci 0000:00:03.0: Adding to iommu group 4
pci 0000:00:04.0: Adding to iommu group 5
pci 0000:00:08.0: Adding to iommu group 6
pci 0000:00:08.1: Adding to iommu group 7
pci 0000:00:08.2: Adding to iommu group 8
pci 0000:00:08.3: Adding to iommu group 9
pci 0000:00:14.0: Adding to iommu group 10
pci 0000:00:14.3: Adding to iommu group 10
pci 0000:00:18.0: Adding to iommu group 11
pci 0000:00:18.1: Adding to iommu group 11
pci 0000:00:18.2: Adding to iommu group 11
pci 0000:00:18.3: Adding to iommu group 11
pci 0000:00:18.4: Adding to iommu group 11
pci 0000:00:18.5: Adding to iommu group 11
pci 0000:00:18.6: Adding to iommu group 11
pci 0000:00:18.7: Adding to iommu group 11
pci 0000:01:00.0: Adding to iommu group 12
pci 0000:02:00.0: Adding to iommu group 13
pci 0000:03:00.0: Adding to iommu group 14
pci 0000:03:00.1: Adding to iommu group 15
pci 0000:03:00.2: Adding to iommu group 16
pci 0000:03:00.3: Adding to iommu group 17
pci 0000:03:00.4: Adding to iommu group 18
pci 0000:03:00.6: Adding to iommu group 19
pci 0000:04:00.0: Adding to iommu group 20
pci 0000:04:00.1: Adding to iommu group 21
pci 0000:05:00.0: Adding to iommu group 22
AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA
PC GA_vAPIC
AMD-Vi: Interrupt remapping enabled
AMD-Vi: Virtual APIC enabled
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
