Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653047CA76
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630669; cv=none; b=gyPio9KEcXblrE05qK0AHYUNQBMvvf7cb7MS8vMP5CRRUXgAjei0yKNZQwiSN72hm15miaeIf3AysoNGnF5jAGKku7T1tEWDj+AuWVujaigw8Nv2g5hkRD50UTdAX2aLNwt5akOcdPaKwNCOs36wFhSwEBlL2FVRLZi4ep0Lp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630669; c=relaxed/simple;
	bh=TP7XKuLsZqTgON/vymz0EVZI57PEH0WyHIQ6IZED1II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5a1z+hgCg8UzoGqCwJ2N8xGkSZysKN2aPg05A8KlUmZGOXuMGIK01crRVri/chWglZtgBZ8+k0/eMJ589HHKN28/q68Pj+xLz/01SAg7AvHOL0G2xOWSYaSZMFxGjIpSKLHDs8nJgKdX9ssVbBtZRRdW52E+be2EU/FRXq/7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9kESoSo; arc=none smtp.client-ip=91.218.175.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9kESoSo"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=TP7XKuLsZqTgON/vymz0EVZI57PEH0WyHIQ6IZED1II=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786630665; v=1; x=1787235465;
 b=t9kESoSob7lBvubRrdLnZBExjIJ5n9WjOmAfi+6AkSNiVTMLHuvHDfE0ibXaMk8cXYEST1pp
 FVSRIl0BtHJRLCLsIzSIZBctBLxh7cjEqvNKftmLgniFiabDprWXxXtAj56F2PwQx/CnH/y0No2
 Pja5NE8uJmPGt3SuXm0Kbmeo=
X-Envelope-To: iommu@lists.linux.dev
Received: from [IPV6:2a03:83e0:1126:4:9d:a05e:5bd8:c200] (2620:10d:c092:500::6:def8)
	by smtp.migadu.com with ESMTPS id 5f16e761327ec0e3;
	Thu, 13 Aug 2026 14:17:45 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <129a38d6-3b00-4f53-9190-a0e615b3798d@linux.dev>
Date: Thu, 13 Aug 2026 15:17:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com
References: <20260420084204.12263-1-vasant.hegde@amd.com>
 <20260813131833.2808948-1-usama.arif@linux.dev>
 <20260813133503.GL662699@ziepe.ca>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260813133503.GL662699@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2026 14:35, Jason Gunthorpe wrote:
> On Thu, Aug 13, 2026 at 06:18:30AM -0700, Usama Arif wrote:
>> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>>> on affected CPU families when SNP is enabled.
>>>
>>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>>
>>
>> Hi,
>>
>> This series seems to break kexec in our production on Milan hosts with SEV enabled.
>> This is on the 6.18.43 stable kernel backport.
>>
>> If on top of 6.18.43 release, we revert the 2 commits, i.e.
>> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
>> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
>>
>> kexec starts working again.
> 
> This sounds like the same issue Nicolin is facing on SMMUv3, these
> larger allocations OOM the kexec kernel
> 
> Jason

Thanks Jason!

Was there any solution for this issue. Could you point to a lore link for this?
