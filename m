Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477835E926
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788630553; cv=pass; b=mpk+mozifnD7Kthglee9POkwvOpZmDAkVq6Oyn9NGL5z4fdubJv5ALXig3tJCJkM3Gj72uJfEccYiwv5aosOFMa4UlqpLDCzVdpAJ436nzTTrkp5mqeHqSHenfx0RU4oHVRiEE/+hzSdqB8fXPINHubslDeX9WFIfaMGZcPgnVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788630553; c=relaxed/simple;
	bh=3LyyokutBxcAjfcGRumvVjoScViISOI7AqKTnE+qbTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZKa2C/ddYYZ6psIyUxJmOIkcuNfZyLatwvd+oxCBjbyl/1qThzY/i/xtUSGLE1x8mGeGpCma7bfSmlcll1r2U/4bDlyJV9n4Ni3PFQOa6vEEOApmzP3foaQjYzGOMHD0mT2Yb5If1Ned2tfgTNf25zH1CO9syjGBy2b9SOeS4Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaL3KhL5; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaL3KhL5"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a468f4c547so6194661fa.0
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 10:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788630550; cv=none;
        d=google.com; s=arc-20260327;
        b=cPHHzOq+o68p04ahdfe13mCRkdVVROuMWXML5faLeMZICkA0NkvwrPdoOLAgxRH9rs
         wM8ZJ2O+guFxurgWHn7oK5VtnK6nY6/ox5s4AvaejHWO0PACPwgBuBeyMNCHKWMMpFKh
         w/HRkfSQ72/P8c7CLbJ4ANvcPLcOHqTczDZUeyhB/nSJRRd8ChlwvVPnaxyHm+zosCzX
         8zBRa10khvoaeuo03ALJdVd+rWcJWpC/CTDnHZorB2PMrgwUQY8If/DwgT8taqWyFkkz
         zMOk53HIXDKPvDi9FzuMbzH9+gMkjJvcHHb8p99ZdHr7XblaIK6/WPfSAwTkCOlpJoz6
         G5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        fh=HPsMnQirzYaNx8kvOIwq2vNO4GYehi8gKE8Py3UbyBg=;
        b=Ba4ZOici4pnY3M9D1Tn8Elfj5dRafRiEpSob7NIybsASUwaYwBukEqGplv978nCeys
         h7cGUoc+he7MCtVdKAyeQI0/ypqK5DO7N20CDIIS1qQndz6p2CvMDbmLtk/vZdUWUkSX
         9cHQsIgLKZCpbkxfxekYMXjGrswo6GTDG5PK4QgPtIg4wRNHnZub1i85RXTlQVuZQgL2
         M5vgkKNxRKEvIl5uZPE7dIlggnOFvfH/RhiowQDrOX5rfi85pRrylyZfBGsg87HARRh+
         NUKpGR18ryVX8A5jf8WZnISoGtumR//F4AV+PF7l6IWQ3KANagpBkdp/EVU4Nyx/kQzR
         GAUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788630550; x=1789235350; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        b=FaL3KhL5cqMzALV9s6isP0J6nY+dPq9/p5EBcEeuzVSC8m2rjhb8wNJHz8vmRObB0F
         Qy7D/GFzZQzV8b8nEQDV35C7HQ9Bq+UWJqxWdMOwVeaIVbNmSnuLHh8CK0h8byCrC/+F
         y6QMCDAxEEu/N7KYQ23Mr4Lf34S3uau5A3Lr6v/k7mMAA616/cjKSQfebidZEqz9fEr/
         7PLdIdOu6MCHnGMJWv8yZs2/fM4vLCratSz80S7AtSNWk9UDqFP25RiKWWsAgCD6nQAb
         fdWzkOa+ZJV+qYVthRohmIearFYeHLk8Fd6kBtpYq/eO0E7CWIF7OFj0U2afr3XgpozR
         4A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788630550; x=1789235350;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        b=hfjt52CgM+xP2mgClOIM8V1CC80Mi/jwKsevtXxVHzTw1EVYe883VUTrlANlc/H8Bh
         Pn8oevhGRulINzGkXgyje2X9DofTJOy5VF4TiODFYf73R/HCB7VLYOBhyFtw0EGPjwrJ
         m7LKww59Y1lLDlpR/gMfYfbhK4MTM9Tqw0O/6oNmoEk7EkTLOWvmmraBITw26UTZ0MiJ
         levYnMQR5Bd5QaRV8itzzkO8oiHO3PFcveuMudPZdPkfXoIb/3QaD4uwZSqBS1KtxoI0
         HC+urivEOueTHBJ04d2K0P89s5O6u8DH2aALwT5Lad0n/FgCYQOWLmApKsLn3CZ6oSiG
         xQow==
X-Forwarded-Encrypted: i=1; AKwUvBwd6KDc5nwdFjdOVxV9Ap4L19g/sdGo42wyLbm72ID1yrl86URPJdncZeBj+VpphPxUNptSig==@lists.linux.dev
X-Gm-Message-State: AFuF++mMrHKG1tqrd0NbwmaZoijDRePXiFoQis5wh9VHyrmlUM60MhEx
	Oq8ymzYcSZwiCH+Axf4/eGXWKYZVPRSRwIjUfFVgWQoRn2R1BEnp6ppp1MUcO+lF8LYUykYiYHZ
	0h8zPHckWzKKAHptRzkhywgk2STPCoyI=
X-Gm-Gg: AYBFou2hy3pvggbP9JYYDN5/3REZTAEQrPt9+wTFvuxEUH0Sr+ujpCGEq8ta68nLWr2
	kU49NU9Ftx7v0IopgWXRti0L/XmMi2L+kRIVxT6WAxzDm/yjFkmXa+Z0k6Aqqrt8gHxQpg0Qkcj
	rdNU7wIIHBQLONdyUP4COHyH0KodT1ghDBsIMYsWNebvR95WsjnR02rN0dTlNg9cwqJZvBVg1gq
	ZILjfP9fQ5wOQ0ifP+vrElHONUfuS5nP65ojFu3wtySUArHwbg+oZgOXFMDyPidZZHQSTshwLcA
	0SnGroJT/sJMQmgMWwvoLpz6i41jhe5St7jMCwEFbFurOnUs1TK6jC6dLPhESoEcOnmXfWReY+J
	T+K6frw+M02xJMGXMYEr8iuyd
X-Received: by 2002:a05:651c:43cc:20b0:3a3:1391:fb19 with SMTP id
 38308e7fff4ca-3a371bb39e7mr11104281fa.9.1788630548430; Sat, 05 Sep 2026
 10:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: John Smith <imjohnsmith4000@gmail.com>
Date: Sat, 5 Sep 2026 20:48:56 +0300
X-Gm-Features: AcwNN1Xu-VurMgpls7HqOcG3u1WJMxdYGE5yaeczLyplTxIcSs8C8GkSUdfXWtc
Message-ID: <CAJ_jo9SD9UqRQe6UGcXAZjU8CbYzQwnwrz=muGd1HaAPGT-jYw@mail.gmail.com>
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
To: linux-ide@vger.kernel.org
Cc: mikael1022bzh@gmail.com, mario.limonciello@amd.com, cassel@kernel.org, 
	dlemoal@kernel.org, vasant.hegde@amd.com, alvinwylim@gmail.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

another data point for this thread, from a third platform: the same
"Using 64-bit DMA addresses" trigger, the same silent zero reads, and
the same cure (identity mapping). It adds one detail that may be useful:
the size boundary of the corruption matches the IOVA rcache limit
exactly.

Platform
--------
  Board:   AOOSTAR WTR MAX (DMI: TianBei "WTR MAX"), AMI BIOS 0.01,
           release date 2025-04-27, BIOS revision 5.29
  CPU:     AMD Ryzen 7 PRO 8845HS (family 25 model 117 stepping 2)
  RAM:     32 GB (30 GiB usable; highest System RAM at 0x83E2FFFFF)
  SATA:    ASMedia ASM1166 [1b21:1166] rev 02, subsystem [1b21:2116],
           PCIe 8GT/s x2; the only SATA controller on the board;
           two 4 TB HDDs attached
  Kernel:  7.0.14-11-pve (Proxmox VE, Ubuntu-derived 7.0)
  IOMMU:   "iommu: Default domain type: Translated",
           "DMA domain TLB invalidation policy: lazy mode",
           "AMD-Vi: Using global IVHD EFR:0x246577efa2054ada, EFR2:0x0"
           (v1 page tables in use; EFR bit 48 GIOSup is set)
  No VFIO / device assignment, no untrusted PCI devices.

What happened
-------------
Three incidents in 12 days on one uptime (booted 2026-08-24). Each was
preceded by exactly one kernel line for the SATA controller, with
nothing else logged in the surrounding minutes:

  2026-08-25T07:56:41+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses
  2026-08-31T23:23:59+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses
  2026-09-05T03:01:27+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses

First symptom afterwards (ext4 "iget: checksum invalid", files that look
corrupt, or the write/read canary failing): 2 h 05 min, 12 min and 3 min
later respectively. No AMD-Vi IO_PAGE_FAULT or any other AMD-Vi event at
any point, no ATA errors, SMART clean, AER counters zero.

The line appeared three times because the device was re-probed twice in
between (manual "echo 1 > remove; echo 1 > rescan" on 08-26 and again on
09-01), which re-arms pci_32bit_workaround. Each re-probe made the
problem disappear for 4 to 6 days.

Measurements while faulted (2026-09-05, ~11:00 +03)
---------------------------------------------------
  * 4 KiB O_DIRECT reads of the GPT header / ext4 superblock: correct.
  * 1 MiB and 8 MiB O_DIRECT reads at several offsets on BOTH drives:
    all bytes zero, identical and repeatable
    (md5 of an 8 MiB read == md5 of 8 MiB of zeros, 96995b58...).
  * 1 MiB from /dev/urandom -> cp onto the ext4 fs -> sync -> O_DIRECT
    read back: 0 of 1048576 bytes non-zero, 3 of 3 attempts.
  * After the fix all of the above return correct data, and everything
    that had been WRITTEN during the fault window (20,519 video
    segments, 47.8 GB, plus the ext4 metadata) verified intact. So on
    this platform only device-to-memory transfers went wrong;
    memory-to-device transfers landed correctly.
  * On 08-26, files that "went bad" had zero-filled holes starting at a
    uniform ~128-160 KB offset.

The 128 KiB boundary is IOVA_RANGE_CACHE_MAX_SIZE: allocations up to
32 pages keep getting recycled low IOVAs from the rcache, larger ones
hit the rbtree and, after the flip, get IOVAs at the top of the 64-bit
range. That is why a small-read health check stays green while every
large transfer is garbage.

Fix / current state
-------------------
  * Live: unbound ahci, "echo identity > /sys/kernel/iommu_groups/26/type"
    (the group holds only the ASM1166), rebound: correct data at once.
  * Persistent: iommu=pt on the kernel command line, rebooted
    2026-09-05 16:02 +03. Clean so far; a 1 MiB write/read canary runs
    every 5 minutes and the machine alerts on any new "Using 64-bit DMA"
    line. I will follow up if it recurs.
  * amd_iommu=pgtbl_v2 not tested here. Note that this 8845HS advertises
    GIOSup (EFR bit 48 = 1), so v2 page tables should be selectable on
    this platform, contrary to what was reported earlier for the 8845HS.
  * Not related to the ASM106x 43-bit limitation: the ASM1166 handled
    32-bit IOVAs for 12 days of heavy I/O, and handles physical
    addresses up to 2^36 under identity mapping without issue.

Happy to run the fio verify canary with iommu.forcedac=1, and/or
amd_iommu=pgtbl_v2 iommu.forcedac=1, or to provide lspci -vvv / SMN
register dumps, if that helps.

Thanks,
John Smith
