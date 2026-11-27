Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757932;
	b=SXO8HVV0rUvNHBvNRI2DEf4lUX6HyfdjYyWW6VWvK4T0T/vj352Qq9EMxlvDq/wYvaMH
	 1atxsx3KVPNNfFrehE9MZSlmQ/DxtEsy7gnUvREg+cVjUOiVcGcEN7AbmWzq7uNYXM3vm
	 7aTCl+hXkK2e5FoR6saheFeFV+Kic4SxJpAvy6zHpajE9xdPThQThXYsXoGZtZoTB4iHM
	 DygfCxs1pGaY1U5pMhUMJpFlji1w+zSYOatCl/YeNuRti/yZho+mHBqli8kyhNSHH7H/X
	 d64Q3O04A/33NViaaUUOmnCj1mH+M8ULgJzjKJqCP2NPGL+/rkqSjARxLBlgOqEg1GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757932;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=R1mJ0VXm8OP3uneBElokiRm56AmoocKHIetW8ZYPqeo=;
	b=bJlvMeKuX5EIkNrOVfrYQGe2wPD1ht3dimhjSqivw05o3gf5hhqVC6NSFfwHNAKwSklo
	 L5acAN9BN7BNmXhkjMd6y7rWCpzpitiP60lfDsNV5umQXZ+QW/lgMl6UrZZXIqkeiE6yQ
	 JkaiuXjS6rN3LS8zfw3WaQEwhtFyRAUWwZnbtdvvKJnPFT5T+3Nf63p1reTmSaIgbJ8UJ
	 SlWqrCh5gQRgSnqT+C6VJ88hoqTB8r20uTb0oLWz/nkQXETYJo2nhHJA3LFnbu5G76n1/
	 +L5Y4FeVe+kr0ej4nvq8Cx/QynlDEtVx3P+FmIDoWf2PW1YpWl7PA+vGXf+xoOp/D3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TjbKkNO3;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F2606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 05:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009F2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TjbKkNO3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795757932; x=1827293932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oCF3Q92rkFJvvniOtXbtMvdk+LqUk1hQx/ISbb7syKY=;
  b=TjbKkNO3knC+d3sayXdmrqYcYK0JsxTFBVkcvScr7OxPheCRn8uvAw8Q
   KSRlnzt84KcPkjJ7X9dXYowmuNlVu2LUzPbew2hwyVAV3ZxMpNURO30i9
   HaCKTIHnO/dWKKUBepa7LI0/ZeZfSAZVwf+83zjSqUX/1+OHJC3Yutq5N
   1huPfv4LrilF2wJ2lhfv8K/7kJ8SI7gmaQeLapjArEZ2Vphg1iFTdd0+U
   c6Ikmo8ensbxXhAFzw4oex7GZHT/xvBNMp2ABfja/SCQCwk0B0I8UHLxN
   KK2T+m4XfY4jrIODDtNmLwPmk6SUfFALEtMah11d140BIPD31Ww/LxA89
   w==;
X-CSE-ConnectionGUID: iu3dRNJyS3yXssimtEPT3g==
X-CSE-MsgGUID: z+bkNJLrT0W+PcQvmwXccQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4574090"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4574090"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:38:51 -0800
X-CSE-ConnectionGUID: mgPNDTsvTpKOyu3y5W4bwg==
X-CSE-MsgGUID: 1EbhF+aoS4CJPPfwWsX/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12173211"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:38:50 -0800
Message-ID: <3304e166-c2e6-4bda-bc75-46ca73f836e1@linux.intel.com>
Date: Fri, 27 Nov 2026 13:38:47 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP
 Gen8)
To: Pe3k <pe3cek@gmail.com>, iommu@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/26 02:08, Pe3k wrote:
> Hi,
> 
> On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
> 04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
> firmware declares for it. With the default translated DMA domain this
> corrupts disk data on every boot under write load. iommu=pt avoids it.
> Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.
> 
> Topology
> --------
> 00:1f.0 ISA bridge [8086:1c54] and 00:1f.2 AHCI [8086:1c02] share IOMMU
> group 10 (DMA-FQ), probed in that order. The group's reserved_regions
> include "0xf1f7e000 0xf1f94fff direct". The DMAR RMRRs covering that
> range list 00:1f.2 in their device scope, but not 00:1f.0.
> 
> 6.12.118 (default cmdline)
> --------------------------
> Once per boot, ~20 min into sustained writes, 23 errors (21 + 2):
> 
>    DMAR: ERROR: DMA PTE for vPFN 0xf1f80 already set (to f1f80003 not 167119001)
> 
> from AHCI writeback (ata_qc_issue -> iommu_dma_map_sg). Each one is a
> 4 KiB page that reaches the disk with wrong content: mostly zeros, some
> with firmware data from the RMRR. No I/O error is reported.
> 
> 7.3.4 and 7.4-rc4 (default cmdline)
> -----------------------------------
> No DMAR errors. Instead 64-84 writes per boot fail before reaching the
> device:
> 
>    ata2.00: failed command: WRITE FPDMA QUEUED
>    ... res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x40 (internal error)
> 
> followed by I/O errors and 4-8 MiB of zeros in written files. In one
> 7.3.4 run the machine also took an NMI (iLO: "Unrecoverable System
> Error (NMI)"). An iommu:map trace filtered to the RMRR shows the cause:
> 
>    map: IOMMU: iova=0x00000000f1f7e000 - 0x00000000f1f7e000
> paddr=0x00000001c94d6000 size=0
>     => iommu_map_nosync <= iommu_map_sg <= iommu_dma_map_sg
>     <= dma_map_sg_attrs <= ata_qc_issue
> 
> With iommu=pt both 6.12 and 7.3.4 run clean.
> 
> Suspected cause (not verified in the source)
> --------------------------------------------
> The domain's IOVA reservations seem to come from the device that
> initialises it (00:1f.0, no RMRR). When 00:1f.2 joins the domain, its
> RMRRs are identity-mapped but never reserved in the IOVA allocator.
> 
> Reproducer
> ----------
> Fresh boot, ext4 on an AHCI disk, 6 parallel cp of a 10 GiB random
> file, sync, drop_caches, compare hashes. Fails within ~25 minutes.
> 
> I can test patches on a spare machine of this model. Full logs, the
> DMAR table and traces are available on request.
> 
> I used Claude Code to run the tests, analyse the
> logs and draft this report. The results and logs are from my own
> machines, and I have reviewed the report.

This seems to have been root-caused in this thread:

https://lore.kernel.org/linux-iommu/02b201dd5ea3$02b88430$08298c90$@machelett.com/

A fix patch has also been posted:

https://lkml.iu.edu/2411.1/00575.html

Perhaps you could give that patch a try?

Thanks,
baolu
