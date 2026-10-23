Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764273;
	b=Lp2ygQaDS2YoSI9nMPioSUo0mEtTD99Jp3bQVs7j3K9VuJMwAtsu7emmghEH1fWcACp5
	 2VWR8r1UZY62KOLcSBIZ5qf4TGGuYtmp8BAqKSCN4tIaydC9T1aDHirIW6LLaFx2y20sM
	 QaH0lGqN971ji6jc1qi/oiKVpPjl4y/6Nq7XPTANGHOy3W/OebkbIgwq8OHcW1o8I7soZ
	 GEDWTZEYn3pUrpAswCXw/uJqb1BeFsPFgdzUxGzuFjeZjztzHr7kMutruXt+sn6oOjPvp
	 kWOxavhTzQjCCuV5DXf/MEwQ7vleA3wAdo0wUxFa8gRNPL74tT9e0emefZ9+crrXagg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=n36re4R3i8nXuM6/wGbiNDosDIqVkvFnDzUX2RMRlk0=;
	b=3hhZNxdFmcDEqeajtJUpeDEeguXTZ7ylU15SZAXKW1epbE1InJ1Cq/aULGcP9T6Q2sNY
	 OUWE6ZP2I1FNE4TCkfIgPLUd0Ncz3TULvlvxx3KGslr9Ol4E0h7XpF1RqQMfMpk9prQG6
	 27MbHOEfHgn6BvGKBDFbMvaT8KzSO5z1Oqwnl+8khU3EqiBUIs9GKlS1+MXYxCl9XedWx
	 j6vNArcoQ75/xHXUz0lDVEAKjahBpWXHSaHEikv4VpGbfqYeR/fKcrq5+XJsrbLKckpx0
	 f3jE3CalDPxC+Xfyfi2KkqSR8lfGLvk0uWhL4HTcct5O208rZVxDZ16Y/A2VZr/3Hfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MNdayn29;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB6606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MNdayn29
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BE731C00;
	Fri, 23 Oct 2026 07:04:28 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAEFB3F673;
	Fri, 23 Oct 2026 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792764271; bh=5LUMkx86sW2CCaNHvIGxIW+K+1BbJjEkbPwVzal5v8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNdayn29iT3ViLmPTZMzRluVsO7PfHn4zcOiCsLLTysTzD3Cs6MS/MP6pzsZOeyIa
	 i8F1Y57RsdzBNTeLzkb4acyVsYrD+fVBCmNLNS+yasI6jOzTLjW3d0QIGG2glwXWi0
	 PECjFLAvvaYmEV+lv2hDunZXOn2GftZHeKRfHFBc=
Message-ID: <d4570e2d-5b92-4f05-a8b3-34d5d5b299bd@arm.com>
Date: Fri, 23 Oct 2026 15:04:23 +0100
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
Subject: Re: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless
 replace of S1 domains
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Pranjal Shrivastava <praan@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-4-skhawaja@google.com>
 <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>
 <20261023134900.GB3977851@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261023134900.GB3977851@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 2:49 pm, Jason Gunthorpe wrote:
> On Fri, Oct 23, 2026 at 02:43:28PM +0100, Robin Murphy wrote:
>>> @@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>>>    		struct arm_smmu_cd target_cd;
>>>    		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>>> -		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
>>> -					&target_cd);
>>> +		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
>>> +					  &target_cd);
>>
>> No, we cannot blindly do this for arbitrary ->attach_dev calls - the
>> majority of S1->S1 transitions are going to be moving back and forth between
>> the default domain and user domains, where there is zero expectation, let
>> alone guarantee, that the translations would be equivalent and thus not
>> liable to lead to TLB conflict aborts or amalgamation hell.
> 
> Heh, yeah this probably only works properly with BBML2 or something so
> the temporary ASID doesn't explode.

This is fundamental VMSA behaviour - see R_FVQCK in the Arm ARM. BBML 
only applies to the one specific case of identical VA->PA translations 
with identical attributes _only_ differing in the leaf level at which 
they are described.

Thanks,
Robin.
