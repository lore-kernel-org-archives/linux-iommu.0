Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A349363C;
	Sat, 22 Aug 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787377753; cv=none; b=rrHuNxBzdlm9NVCAYUpmHCBP3WiPrZBKf0wWghG0bY0+nrOp0Ys/eFVB+htrxHTe0lVmLy3MwZDNuv2RtLf0IHzew4Xm7Y2jWInNibLv/1+8DvvWsPXskgQR2pyyuNwPo+4NpX7JrK3T5vvDonS6c/iKCVNrShEQu5x6ismpsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787377753; c=relaxed/simple;
	bh=hqOUR+uZ8Tincb7XgocomRRAWKuXWqkSAAmsERoWUpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5JtlmG7jLIC5VSnxau3LPf8/oymy0MNFkHXGkni0QOGu1wfuTr4AUIKRzDqbdf/cdqlP9HMeIpkIkjuoprMj7PM0PvQ77uhC3heOwcW0+nNqKIjmIwa/Iu5WWym7y57MF++zFu9S8N8jrBvf/Ph+uTA0tcTkw4o4q2LODQNdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5004f1d60e89a4b12a6.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:4f1d:60e8:9a4b:12a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 38ADA206425;
	Sat, 22 Aug 2026 07:49:04 +0200 (CEST)
Date: Sat, 22 Aug 2026 07:49:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andreas Juch <andreas@juch.cc>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] iommu/amd: "Fix premature break in
 init_iommu_one()" causes early boot hang
Message-ID: <aok4Ko0mpC4fdGPg@8bytes.org>
References: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>

Adding Vasant.

On Fri, Aug 21, 2026 at 11:11:07PM +0200, Andreas Juch wrote:
> Hello,
> 
> I noticed that one of my NixOS sytems failed to boot with kernel 6.18.40.
> The
> older 6.18.39 booted fine. A full git bisect of v6.18.39..v6.18.40
> identified
> the following commit as the first bad commit:
> 
>   dc266f6c4e2628576ab33042b6b2a12480220026
>   iommu/amd: Fix premature break in init_iommu_one()
> 
> The visible symptom is a black screen immediately after systemd-boot. The
> machine also remains unreachable over SSH and leaves no persistent journal
> entry
> for the failed boot. A reset or power cycle is required.
> 
> I reverted that single commit, built the kernel again and the machine
> booted, so
> I'm quite sure that I found the right commit.
> 
> System information:
> 
> ASRockRack B550D4-4L
> BIOS P1.10 (06/28/2021)
> 
> I'm no expert at all, but my research found that the following information
> might
> be relevant:
> 
>   journalctl -W -b -k --no-pager | rg -i 'AMD-Vi|AMD IOMMU|IOMMU|IVRS|IVHD'
>   Aug 21 22:24:17 kernel: ACPI: IVRS 0x00000000BB062000 0000D0 (v02 AMD   
> AmdTable 00000001 AMD  00000001)
>   Aug 21 22:24:17 kernel: ACPI: Reserving IVRS table memory at [mem
> 0xbb062000-0xbb0620cf]
>   Aug 21 22:24:17 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
>   Aug 21 22:24:17 kernel: iommu: Default domain type: Translated
>   Aug 21 22:24:17 kernel: iommu: DMA domain TLB invalidation policy: lazy
> mode
>   Aug 21 22:24:17 kernel: pci 0000:00:01.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:00:01.2: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:00:02.0: Adding to iommu group 1
>   Aug 21 22:24:17 kernel: pci 0000:00:03.0: Adding to iommu group 2
>   Aug 21 22:24:17 kernel: pci 0000:00:04.0: Adding to iommu group 3
>   Aug 21 22:24:17 kernel: pci 0000:00:05.0: Adding to iommu group 4
>   Aug 21 22:24:17 kernel: pci 0000:00:07.0: Adding to iommu group 5
>   Aug 21 22:24:17 kernel: pci 0000:00:07.1: Adding to iommu group 6
>   Aug 21 22:24:17 kernel: pci 0000:00:08.0: Adding to iommu group 7
>   Aug 21 22:24:17 kernel: pci 0000:00:08.1: Adding to iommu group 8
>   Aug 21 22:24:17 kernel: pci 0000:00:14.0: Adding to iommu group 9
>   Aug 21 22:24:17 kernel: pci 0000:00:14.3: Adding to iommu group 9
>   Aug 21 22:24:17 kernel: pci 0000:00:18.0: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.1: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.2: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.3: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.4: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.5: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.6: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:00:18.7: Adding to iommu group 10
>   Aug 21 22:24:17 kernel: pci 0000:02:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:02:00.1: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:02:00.2: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:01.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:02.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:03.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:04.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:08.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:20:09.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:21:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:22:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:23:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:24:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:25:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:29:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:2a:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:2b:00.0: Adding to iommu group 0
>   Aug 21 22:24:17 kernel: pci 0000:2c:00.0: Adding to iommu group 11
>   Aug 21 22:24:17 kernel: pci 0000:2d:00.0: Adding to iommu group 12
>   Aug 21 22:24:17 kernel: pci 0000:2d:00.1: Adding to iommu group 13
>   Aug 21 22:24:17 kernel: pci 0000:2d:00.3: Adding to iommu group 14
>   Aug 21 22:24:17 kernel: pci 0000:2d:00.4: Adding to iommu group 15
>   Aug 21 22:24:17 kernel: AMD-Vi: Extended features (0x58f77e022294881,
> 0x0): PreF GA GA_vAPIC
>   Aug 21 22:24:17 kernel: AMD-Vi: Interrupt remapping enabled
> 
> And the output of the decoded IVRS table, captured by `acpidump -n IVRS -b`:
> 
>   00000000  49 56 52 53 d0 00 00 00  02 e2 41 4d 44 20 20 00 |IVRS......AMD 
> .|
>   00000010  41 6d 64 54 61 62 6c 65  01 00 00 00 41 4d 44 20
> |AmdTable....AMD |
>   00000020  01 00 00 00 41 30 20 00  00 00 00 00 00 00 00 00 |....A0
> .........|
>   00000030  10 b0 48 00 02 00 40 00  00 00 50 fd 00 00 00 00
> |..H...@...P.....|
>   00000040  00 00 00 00 2e 8f 04 80  03 08 00 00 04 fe ff 00
> |................|
>   00000050  43 00 ff 00 00 a5 00 00  04 ff ff 00 00 00 00 00
> |C...............|
>   00000060  48 00 00 00 00 a0 00 02  48 00 00 d7 0d a0 00 01
> |H.......H.......|
>   00000070  48 00 00 00 0e 01 00 01  11 b0 58 00 02 00 40 00
> |H.........X...@.|
>   00000080  00 00 50 fd 00 00 00 00  00 00 00 00 00 02 04 00
> |..P.............|
>   00000090  5a 4a 29 22 ef 77 8f 05  00 00 00 00 00 00 00 00
> |ZJ)".w..........|
>   000000a0  03 08 00 00 04 fe ff 00  43 00 ff 00 00 a5 00 00
> |........C.......|
>   000000b0  04 ff ff 00 00 00 00 00  48 00 00 00 00 a0 00 02
> |........H.......|
>   000000c0  48 00 00 d7 0d a0 00 01  48 00 00 00 0e 01 00 01
> |H.......H.......|
>   000000d0
> 
> The relevant part (after decoding with `iasl -d ivrs.dat`):
> 
>   [090h 0144 008h]                   EFR Image : 058F77EF22294A5A
> 
> I'll provide any required details and test patches!
> 
> Thanks for your work, it's very appreciated!
> 
> Andreas
> 
