Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72F267F5C
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945889; cv=none; b=XqGApQ55YzeITWf9F13pdUE6gxOFmjmkWjh0k45n10ez202u8TKuZsU4NUOOvTBNHUScUAqtG8hAz1ow6UuBhbDf9e7O93/5kktag93QzL6YysguRSDXSTcIADF7omaJOBXp4nE8pcoD5SIhwK/dAMQxqeMzbww7UAsU1yZnKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945889; c=relaxed/simple;
	bh=2Gi98+Gx3q2+a5abm9nQzow/IATwvJxJ6qoPMe2C2Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxbzukI6wiYHH2cMK751w8kieYkSZrMGnhveEpYR+PZr9Bdngu0cZxu2GlbJ6LHhJWG8LHO94V9ZvIv6SqOsKIUbERbGkc8YXov7leEkJNiI50+qrftTqHh30/9tBHaE7qt8iYSS5D1uZ2LdxgLiUZfR2aP+Aa3Qf8paCtl5hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwVifRXE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwVifRXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744945888; x=1776481888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Gi98+Gx3q2+a5abm9nQzow/IATwvJxJ6qoPMe2C2Ao=;
  b=HwVifRXEl4ZStzKR/jk7gKFU/VbQnDO1oOZm0+OwPRsfhhGvG2EhRYae
   ZXuA92JGzJNnE69d3VTYFk1hDpLLiWk0K1e6/Fl9UMh0HAdZ0551jg5zo
   PcDj9kO9RrO3PDXZHcNhx60B6CWshGDjV8LEG8cx/4WmRJBQKZVgZVqik
   GHm0h7wVXPm39m4MHepVde3rvYjwmhcFRqUMvLXdbjrQZymVNtB6a6xU9
   H9fzHfuvHeOSRtmHcBKGWGrywNzJpxtvsaS7/6mls9wnesbrLoWhSZwKH
   e2PBgFxxlRy4NbejgzSB3LEtOeNFnP4oBysJl2m/R9EvYD9L6LKet2RjD
   A==;
X-CSE-ConnectionGUID: YtelbZthTsyvUT4rN0j1iw==
X-CSE-MsgGUID: BcvOKlZSTk+Iob1/6TAIZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50374187"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="50374187"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 20:11:27 -0700
X-CSE-ConnectionGUID: q3K0h6HTReu4AhjaznOcbg==
X-CSE-MsgGUID: 9ThdzKhWSYi5yCKJ4vhfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="131312815"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 20:11:23 -0700
Message-ID: <9fce601e-b557-4454-8698-6c63303999a1@linux.intel.com>
Date: Fri, 18 Apr 2025 11:07:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND] iommu: intel: apply quirk_iommu_igfx for
 8086:0044 (QM57/QS57)
To: Mingcong Bai <jeffbai@aosc.io>
Cc: intel-gfx@lists.freedesktop.org, kexybiscuit@aosc.io,
 Wenhao Sun <weiguangtwk@outlook.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250120093540.512825-1-jeffbai@aosc.io>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250120093540.512825-1-jeffbai@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/25 17:35, Mingcong Bai wrote:
> (I'm not very confident about the approach of this patch but I failed to
> find a better way to address the issue I have on hand, so please consider
> this patch as an RFC...)
> 
> On the Lenovo ThinkPad X201, when Intel VT-d is enabled in the BIOS, the
> kernel boots with errors related to DMAR, the graphical interface appeared
> quite choppy, and the system resets erratically within a minute after it
> booted:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Write NO_PASID] Request device [00:02.0] fault addr 0xb97ff000
> [fault reason 0x05] PTE Write access is not set
> 
> Upon comparing boot logs with VT-d on/off, I found that the Intel Calpella
> quirk (`quirk_calpella_no_shadow_gtt()') correctly applied the igfx IOMMU
> disable/quirk correctly:
> 
> pci 0000:00:00.0: DMAR: BIOS has allocated no shadow GTT; disabling IOMMU
> for graphics
> 
> Whereas with VT-d on, it went into the "else" branch, which then
> triggered the DMAR handling fault above:
> 
> ... else if (!disable_igfx_iommu) {
> 	/* we have to ensure the gfx device is idle before we flush */
> 	pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> 	iommu_set_dma_strict();
> }
> 
> Now, this is not exactly scientific, but moving 0x0044 to quirk_iommu_igfx
> seems to have fixed the aforementioned issue. Running a few `git blame'
> runs on the function, I have found that the quirk was originally
> introduced as a fix specific to ThinkPad X201:
> 
> commit 9eecabcb9a92 ("intel-iommu: Abort IOMMU setup for igfx if BIOS gave
> no shadow GTT space")
> 
> Which was later revised twice to the "else" branch we saw above:
> 
> - 2011: commit 6fbcfb3e467a ("intel-iommu: Workaround IOTLB hang on
>    Ironlake GPU")
> - 2024: commit ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic
>    identity mapping")
> 
> I'm uncertain whether further testings on this particular laptops were
> done in 2011 and (honestly I'm not sure) 2024, but I would be happy to do
> some distro-specific testing if that's what would be required to verify
> this patch.
> 
> P.S., I also see IDs 0x0040, 0x0062, and 0x006a listed under the same
> `quirk_calpella_no_shadow_gtt()' quirk, but I'm not sure how similar these
> chipsets are (if they share the same issue with VT-d or even, indeed, if
> this issue is specific to a bug in the Lenovo BIOS). With regards to
> 0x0062, it seems to be a Centrino wireless card, but not a chipset?
> 
> I have also listed a couple (distro and kernel) bug reports below as
> references (some of them are from 7-8 years ago!), as they seem to be
> similar issue found on different Westmere/Ironlake, Haswell, and Broadwell
> hardware setups.
> 
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=197029
> Link:https://groups.google.com/g/qubes-users/c/4NP4goUds2c?pli=1
> Link:https://bugs.archlinux.org/task/65362
> Link:https://bbs.archlinux.org/viewtopic.php?id=230323
> Reported-by: Wenhao Sun<weiguangtwk@outlook.com>
> Signed-off-by: Mingcong Bai<jeffbai@aosc.io>
> ---
>   drivers/iommu/intel/iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Queued for v6.15-rc. Thank you!
