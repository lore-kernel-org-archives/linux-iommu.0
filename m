Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA214A619
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294638; cv=none; b=Pz4sQbmL73TO3s9+8vcD4S+GNZpHaUuBLiNT7IVY7rpy4FECQCuydAVPYXySy8ruY10NJuC7ypx/KdpS6W//93rVDoO+/Q/2RcE8oRI6yQ07soOWDum9UhFvuOYjHunhuvHJrUsMn5xBojo7nGGHdykqBkqItwkaaaGtxfJI+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294638; c=relaxed/simple;
	bh=xiITypc98Vms++xdl1wlGNl0fj78/w8IS+p3wRC0q4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV3z/VqXf/I53IiLPM0Z0x0bd6lFBGm7CUmf4GuuBLfnogeTPWd6nhxeb5DlobbvdgaQBvoSdZdN057oo90NU0evnd0p6ZsMJ/eR3tmdPPdd+NcsImiXYOqX3yXZtieqyIlxksgpILgwbNkdd+IhP3TupzfPsn7IS6eMgpdTpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsD0KwM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsD0KwM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632DD1F00893;
	Fri, 25 Sep 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790294637;
	bh=IvuCKKesGJGL73AIQe+UGtgPPKsfK1qWpEmaJi2MOd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dsD0KwM8YVrziEOOqLDWjFJgwJI8FUvtKfnwmXVqSQTnkWyDDS0bvwk1CPnhOwGuK
	 4qzJClli4k6JplFx6KBiU1MnCrvqV8an2EWJERI7csS6ETJpeTjFfvIQ8d9vg4jCfp
	 sPoZX1fdPeYO8VoWWReXBGifan0kkh3nDENdrow4fPm8vEUCviF+ld1D9VjUbpjJ2x
	 HSQlbIKtrS1vpvNAW4SSwqRwUyxJ+KIvo2Jpbh8wSpCddNuEjg0sx9T9/bYfJkXdq+
	 UVnSs1oeWISy11eoNrpnW3rb3uTbzzPJPaZqAqY+X0EiYTFNp8pFEq+GsRZinHytOq
	 qtTbnlALlF+5A==
Message-ID: <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
Date: Thu, 24 Sep 2026 19:03:56 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260924225018.GB16465@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/26 5:50 PM, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
>> +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> 
> Last time we hardwired the GPU and IOMMU drivers together it was a
> huge mess to undo.
> 
> Why does the GPU driver have to request this? Why can't the iommu
> driver know that this is a special device that can use this magic fast
> path and then auto set it when identity is asked for?

The reason was to allow an "opt-out" path on the GPU driver.

> 
> How does the GPU driver even know it is magic special?

See patch 2/2.  GPU driver looks if it's an APU and it's in identity 
mode.  The special mode is only for the GPU in an APU.  It shouldn't be 
applied to anything else.
> 
>> +	/*
>> +	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
>> +	 * identity domain with the flag cleared, so a later bind without PerfOpt
>> +	 * sees a normally-capable device. See the locking note in
>> +	 * amd_iommu_enable_perfopt().
>> +	 */
> 
> And this is sort of a wrong thing in the driver, it shouldn't have ATS
> turned on for identitiy mappings, and it certainly shouldn't have PRI
> turned on until a PRI capable domain is attached.
> 
> Jason
> 

amd_iommu_disable_perfopt() only re-applies the policy that was 
previously set before PerfOpt.

If you would like I'll send a follow up patch to clarify this comment.
