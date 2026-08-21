Received: from rs1.nue.1e30.net (rs1.nue.1e30.net [152.53.122.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA400493649;
	Fri, 21 Aug 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.122.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347028; cv=none; b=DYq+pUvsVmHkKE0e3nSUKgs+T0Ix/Gn+ecyzGF3h82YHTsk7GvsI0rMwJGWjUY+REBlZTUb81QecSauNIrjNbL98tm308hcciTNLxMuZqR9izvc7GFSOXb8+M52R5Tyjf9nIcJWLHFBRR4XvL2rOHVkvGYUcv6dsD2RS+XMkgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347028; c=relaxed/simple;
	bh=XWNkHM+bbLYU/g5fCfGmumuj8MJQwrnjw/ZgecO73dY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EZa0eP1xL2kJwn+A80I2V2Ywq7cCGgp4xXKNnBVP4lPlljD1DQry0PuA+YvrXycZuWN9IboJjEEZXDuA/Mh9/apdTbv2u2VWKO3i5RADUkijjkWSg3AoF5KU2PIgYcFROq6ZrVAJ6xEkW/tfZFeWNnub8kzk8SN5g739zDu4l3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=juch.cc; spf=pass smtp.mailfrom=juch.cc; dkim=pass (2048-bit key) header.d=juch.cc header.i=@juch.cc header.b=O3tkYrzf; arc=none smtp.client-ip=152.53.122.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=juch.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juch.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juch.cc header.i=@juch.cc header.b="O3tkYrzf"
Message-ID: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juch.cc; s=rsa-2026-06;
	t=1787346668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecCvYpXHLQiB/7Dq9VJa1pCKcLvQFPyds/0pjc/X0Tk=;
	b=O3tkYrzfpgvzE7GHG+1DnZrhmTjNrw87UqApzg8OcmWM6DQKlJHTi5dBU5302qbrcbobs5
	QyyD49cxIv/Yf2x1019b8kNxdsLpvViJLUBV/ssB92noKZoHj8TbMLJIj8NLq8ilhzbpOL
	+Hh9huDMwjryhDicsvhYX2QqUPLPLPczeYrJzk6QnLUrpepaoqoNplaqvcD6zolp5S5G0+
	p6YXXFY6KPZAw1g+vR9nctbKMtq2De+9WE2dKYLcveOdYg8azXgymwrMrW1OqoNNetVeJT
	J2xbWIBOtWan9df/Y5/w2jKVN2KB65Z/or5yzKcxBmfVxDtEcpyCA6p4LP9qvg==
Date: Fri, 21 Aug 2026 23:11:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: en-US
From: Andreas Juch <andreas@juch.cc>
Subject: [REGRESSION] iommu/amd: "Fix premature break in init_iommu_one()"
 causes early boot hang
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I noticed that one of my NixOS sytems failed to boot with kernel 
6.18.40. The
older 6.18.39 booted fine. A full git bisect of v6.18.39..v6.18.40 
identified
the following commit as the first bad commit:

   dc266f6c4e2628576ab33042b6b2a12480220026
   iommu/amd: Fix premature break in init_iommu_one()

The visible symptom is a black screen immediately after systemd-boot. The
machine also remains unreachable over SSH and leaves no persistent 
journal entry
for the failed boot. A reset or power cycle is required.

I reverted that single commit, built the kernel again and the machine 
booted, so
I'm quite sure that I found the right commit.

System information:

ASRockRack B550D4-4L
BIOS P1.10 (06/28/2021)

I'm no expert at all, but my research found that the following 
information might
be relevant:

   journalctl -W -b -k --no-pager | rg -i 'AMD-Vi|AMD IOMMU|IOMMU|IVRS|IVHD'
   Aug 21 22:24:17 kernel: ACPI: IVRS 0x00000000BB062000 0000D0 (v02 
AMD    AmdTable 00000001 AMD  00000001)
   Aug 21 22:24:17 kernel: ACPI: Reserving IVRS table memory at [mem 
0xbb062000-0xbb0620cf]
   Aug 21 22:24:17 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
   Aug 21 22:24:17 kernel: iommu: Default domain type: Translated
   Aug 21 22:24:17 kernel: iommu: DMA domain TLB invalidation policy: 
lazy mode
   Aug 21 22:24:17 kernel: pci 0000:00:01.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:00:01.2: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:00:02.0: Adding to iommu group 1
   Aug 21 22:24:17 kernel: pci 0000:00:03.0: Adding to iommu group 2
   Aug 21 22:24:17 kernel: pci 0000:00:04.0: Adding to iommu group 3
   Aug 21 22:24:17 kernel: pci 0000:00:05.0: Adding to iommu group 4
   Aug 21 22:24:17 kernel: pci 0000:00:07.0: Adding to iommu group 5
   Aug 21 22:24:17 kernel: pci 0000:00:07.1: Adding to iommu group 6
   Aug 21 22:24:17 kernel: pci 0000:00:08.0: Adding to iommu group 7
   Aug 21 22:24:17 kernel: pci 0000:00:08.1: Adding to iommu group 8
   Aug 21 22:24:17 kernel: pci 0000:00:14.0: Adding to iommu group 9
   Aug 21 22:24:17 kernel: pci 0000:00:14.3: Adding to iommu group 9
   Aug 21 22:24:17 kernel: pci 0000:00:18.0: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.1: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.2: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.3: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.4: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.5: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.6: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:00:18.7: Adding to iommu group 10
   Aug 21 22:24:17 kernel: pci 0000:02:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:02:00.1: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:02:00.2: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:01.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:02.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:03.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:04.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:08.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:20:09.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:21:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:22:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:23:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:24:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:25:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:29:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:2a:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:2b:00.0: Adding to iommu group 0
   Aug 21 22:24:17 kernel: pci 0000:2c:00.0: Adding to iommu group 11
   Aug 21 22:24:17 kernel: pci 0000:2d:00.0: Adding to iommu group 12
   Aug 21 22:24:17 kernel: pci 0000:2d:00.1: Adding to iommu group 13
   Aug 21 22:24:17 kernel: pci 0000:2d:00.3: Adding to iommu group 14
   Aug 21 22:24:17 kernel: pci 0000:2d:00.4: Adding to iommu group 15
   Aug 21 22:24:17 kernel: AMD-Vi: Extended features (0x58f77e022294881, 
0x0): PreF GA GA_vAPIC
   Aug 21 22:24:17 kernel: AMD-Vi: Interrupt remapping enabled

And the output of the decoded IVRS table, captured by `acpidump -n IVRS -b`:

   00000000  49 56 52 53 d0 00 00 00  02 e2 41 4d 44 20 20 00 
|IVRS......AMD  .|
   00000010  41 6d 64 54 61 62 6c 65  01 00 00 00 41 4d 44 20 
|AmdTable....AMD |
   00000020  01 00 00 00 41 30 20 00  00 00 00 00 00 00 00 00 |....A0 
.........|
   00000030  10 b0 48 00 02 00 40 00  00 00 50 fd 00 00 00 00 
|..H...@...P.....|
   00000040  00 00 00 00 2e 8f 04 80  03 08 00 00 04 fe ff 00 
|................|
   00000050  43 00 ff 00 00 a5 00 00  04 ff ff 00 00 00 00 00 
|C...............|
   00000060  48 00 00 00 00 a0 00 02  48 00 00 d7 0d a0 00 01 
|H.......H.......|
   00000070  48 00 00 00 0e 01 00 01  11 b0 58 00 02 00 40 00 
|H.........X...@.|
   00000080  00 00 50 fd 00 00 00 00  00 00 00 00 00 02 04 00 
|..P.............|
   00000090  5a 4a 29 22 ef 77 8f 05  00 00 00 00 00 00 00 00 
|ZJ)".w..........|
   000000a0  03 08 00 00 04 fe ff 00  43 00 ff 00 00 a5 00 00 
|........C.......|
   000000b0  04 ff ff 00 00 00 00 00  48 00 00 00 00 a0 00 02 
|........H.......|
   000000c0  48 00 00 d7 0d a0 00 01  48 00 00 00 0e 01 00 01 
|H.......H.......|
   000000d0

The relevant part (after decoding with `iasl -d ivrs.dat`):

   [090h 0144 008h]                   EFR Image : 058F77EF22294A5A

I'll provide any required details and test patches!

Thanks for your work, it's very appreciated!

Andreas

