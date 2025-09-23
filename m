Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF2273D92
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605991; cv=none; b=P43e84vem+0eI8P3SW5BQHzwCOcEnlNaK1sQfp5BHYynsIr/6fZ+6prKJtdTF7zNMDfNaLehiwpcT1Z/coDxR8BSzYn5FuvK7f9L25/M5gQ+WiV+Npp1cLhceJ7bw1T79BqM1YCMg0OMmo8ebc5yPQbkHUOrNgj36ZMmc5ovW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605991; c=relaxed/simple;
	bh=vYZ8bzD0dvB7SeZuGO07X/0YsC6pUYWdaL3B9nbMzjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A1JH3VYPpsLb8aFzSKp8LA7BHVJIRnhaC4uqtqw3op4S72hMNpse7QWoXEt4B58FilN3hlKJ6gBmo/R6txUVKqe2t656p/LawgXMDMyJApl6PFrRf2ZspoTqRAwM0H3IJbUnXAFOoJhuRE0F3fOWKESRvJ0S/xntGi0yIlMf42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBo6qGB3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBo6qGB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758605990; x=1790141990;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vYZ8bzD0dvB7SeZuGO07X/0YsC6pUYWdaL3B9nbMzjo=;
  b=IBo6qGB3N0L9CC3jxQ8efm0VITitdo2i8DqLakqVTbOYHtHtcJ8TS54Y
   PQVScqRvpCNsA8dY2fD18oyrKDjVZdmtxwdDB/DANB5mstoXatg+COMUY
   VvkrBDNOC9UOmuRLQhgfNWc8c+IuC1Sdpwj0wN507HofkANqGfIg+36Am
   SBvB0DB9b5/O6OzFZwoKmLaCBRLfPY9D0uqj5tSfbPhIQoGEaVq73tZsp
   5SynQDZhw4ihUOOFUmWK+bBi08sJEz3Uepqg7ktqaoK9EqfvDPizM/f+Y
   DgXHXvV7TaaIZaVGhqdODBF0o/kvWO8IBgaMaLyPSioWA2VHgTliArdls
   Q==;
X-CSE-ConnectionGUID: fzAUW+TOQ7mGptk9ECNDVg==
X-CSE-MsgGUID: qoLs9dJhTL2vh68PiV2S+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60765170"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="60765170"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:39:50 -0700
X-CSE-ConnectionGUID: MYRuTO00TayWdz5JnjJ1ww==
X-CSE-MsgGUID: BxD3dGraTI+tbg3ANz5fjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="177118756"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 22:39:47 -0700
Message-ID: <02510e4e-0edc-4932-b198-2d44f83180e3@linux.intel.com>
Date: Tue, 23 Sep 2025 13:36:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] WARNING in intel_iommu_map_pages
To: syzbot <syzbot+6e970ad52c1b9e57e6b1@syzkaller.appspotmail.com>,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <68d17f7d.050a0220.13cd81.05b8.GAE@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <68d17f7d.050a0220.13cd81.05b8.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 00:55, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' ofgit://gi..
> git tree:       upstream
> console output:https://syzkaller.appspot.com/x/log.txt?x=142d3c7c580000
> kernel config:https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link:https://syzkaller.appspot.com/bug?extid=6e970ad52c1b9e57e6b1
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:https://syzkaller.appspot.com/x/repro.syz?x=1740fe42580000
> C reproducer:https://syzkaller.appspot.com/x/repro.c?x=1037a712580000
> 
> Downloadable assets:
> disk image (non-bootable):https://storage.googleapis.com/syzbot-assets/d900f083ada3/ 
> non_bootable_disk-3b08f56f.raw.xz
> vmlinux:https://storage.googleapis.com/syzbot-assets/6f981dad47cf/ 
> vmlinux-3b08f56f.xz
> kernel image:https://storage.googleapis.com/syzbot-assets/031397abeebd/ 
> bzImage-3b08f56f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by:syzbot+6e970ad52c1b9e57e6b1@syzkaller.appspotmail.com
> 
> DMAR: ERROR: DMA PTE for vPFN 0xbe300 already set (to 55400003 not 51800003)

The driver is complaining that the PTE entry for IOVA 0xbe300 was mapped
to 0x55400000, but not unmapped before remapping it to 0x51800003.

Thanks,
baolu
