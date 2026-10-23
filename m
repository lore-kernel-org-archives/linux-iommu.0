Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764782;
	b=NNYfXjVR6x47rIl1rFxEgj6jEN29hoS3ksHPZD+vqQRpEPCsnrNP/fjxABnVp2TLg3E1
	 7yA5X2aGUbBCiIgkWSgTDzw6G4PJpgtmPq6959GKOLncc3b1LJFZRa+uGhROxhhHHUEfx
	 4GvcPd70nJhVhCfdf2Gfg2A9bNeCw3BHqUXdb4JOi0dQ2OwZ5WTqBHR/xAJNvjztjHxHE
	 wJsaHd4SML5QJy1ZsuggLcbr0Hb1kLYOIkZbdH7puDb5Whr5cft6DxsviyN3bOUYKlokE
	 JiV2uDxlr21h4fVvF1LNx+8epr51X9cWjIF/kYI1sxLnWWQIVMCmdLlkxr6bmwjYbQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764782;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9cFpvU8rjQOsVqgPNZEW5UiYjM8XcyLp4rMG1r738y4=;
	b=bXBmlC9w9M1jEAvJCq5kEcbuoT3q1rCRfIwxgo1/giOQGr4xcWx4qFM9dEgpnqB8DTso
	 bCtBKCi8EQuA9ts41LB3mk1Auqg/RaH5SMK9Qol1RRZ9dTC3nrnGFAzvA9cIT5f0jdyTX
	 p067p4hpz4Y4QvKde/iHoKAVsLOHQp3plEuS8N/if/6rHqGQITtswvD+ZykSebV2pKwI+
	 3WlPFmzv9p98dBwYEpmuAm5mNuGAFT8aAZ9pSYLSyko0nirdwdrI3c7//kWREmAnwjfYx
	 ZUSPL4SJKiazfDEd2Wgg5FtLla/MrRoFQTcSG42XZlkVzfwiYga2eUOVFHWJSoK5+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uO1JOGeJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D8606A32D
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 401D8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uO1JOGeJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332821C00;
	Fri, 23 Oct 2026 07:12:57 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805ED3F673;
	Fri, 23 Oct 2026 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792764780; bh=sROtlMFSXp8uwtrjh7+47j+s9WQZKDsosHFNWnr1FVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uO1JOGeJSJYNIbzJmFHsfepKZP6AX2zPVZE1kT3D//zfaqIfdvtvda8w2tRoZgWlQ
	 SErgyDg5O590mBUXaVfW3D6861ml7bejUJcTEeu9PjsF7XgMt7HmBFlaujXBv0nsay
	 5xPT8YX/1c9+tonQ8JOKmBHNuG2e9gaRtY+jWbhc=
Message-ID: <242e6922-2f40-4afc-ab8f-3405da5ad445@arm.com>
Date: Fri, 23 Oct 2026 15:12:56 +0100
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
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless
 replace of CD entries
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Pranjal Shrivastava <praan@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <40a2e1a2-138b-42bf-94ea-a42fda128c22@arm.com>
 <20261023134630.GA3977851@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261023134630.GA3977851@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 2:46 pm, Jason Gunthorpe wrote:
> On Fri, Oct 23, 2026 at 01:10:56PM +0100, Robin Murphy wrote:
>> On 25/09/2026 2:13 am, Samiullah Khawaja wrote:
>>> This patch series adds support for replacing IOMMU domains with S1 page
>>> tables hitlessly, that is without disrupting the ongoing DMAs. This is
>>> one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.
>>>
>>> S1 domains are programmed by CD entries in the CD table. During a new
>>> domain attach these are updated using arm_smmu_write_cd_entry(). Since
>>> ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
>>> considers it a non-hitless update and sets V=0. This means such an
>>> update is disruptive and would generate translation faults if there are
>>> ongoing DMAs.
>>>
>>> Replace the CD entries by using an unused temporary ASID in the
>>> following sequence to allow hitless replacement of CD entry,
>>>
>>> - Update the CD entry with temporary ASID.
>>> - Update the CD entry with the target TTB0.
>>> - Invalidate the temporary ASID.
>>> - Update the CD entry with target ASID.
>>> - Invalidate and release the temporary ASID.
>>
>> Why bother transitioning through a 3rd ASID? The old and new pagetables must
>> contain the same translations anyway, so why not just: switch ASID, switch
>> TTB, invalidate old ASID?
> 
> The target ASID may be in use by another CD someplace else. Doing it
> without the temporary could contaminate it with wrong translations
> from the original TTB0.
> 
>  From a driver perspective we don't know why the domain replace
> operation was triggered. iommufd can trigger it for domains that are
> not identical. Corrupting the target ASID when we don't know for sure
> what is happening is not safe.

If there can be "wrong translations" then the whole thing is 
fundamentally not safe to begin with.

> Obviously Samiullah's use case is hitless between the same translation
> so it doesn't need the extra ASID, but the driver can't know this.

Huh? If it doesn't need to be "hitless" then there is no need to do this 
at all; break-before-make via an invalid CD is fine. If it does, then 
the translations must be identical. Doesn't matter how many intermediate 
ASIDs you go through, any time *one* of them could have fetched from two 
different pagetables, you can't say for sure that an amalgamation of TLB 
entries won't create something which ends up looking like a global 
translation, that then "corrupts" *all* ASIDs.

Thanks,
Robin.
