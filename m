Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7A322A2E;
	Fri,  2 Oct 2026 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790913441; cv=none; b=DVuFMUGOqkCR+RLks64mmTvtJLqIF5p3/p8gx5h0whJ1rF+7jHc/ejFSY7JSyrBcOTYLsX8nauMujRp0NKO9vs23D2LtzmpYrecSgpCp9JWbYyyVT7hWm1eU8zQDwHdh+wkS3dS2PlBFXlzyERhkTetp7gF+UfbdSf5k6yiZu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790913441; c=relaxed/simple;
	bh=ud0njTb+UTcmC7RfcGMaJx5fA1+AoT2gA/SldV45wKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSJC6dE2Nha+9GbX4P0lO5z7mLB5E4HxDcSAQoJ7osNkFu+m/Geg3dtwU6F62rB/Uh5kBigyWhxNPx3fkbUdb689d3bbGMrpq5OtTVUO0GhXHfUJqmADRGC2LGEmPOXW3a53ETpC7p6hrWEBIf18a4atylBbpN0wkdBp1qEgX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiJkGWu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiJkGWu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DED1F000FF;
	Fri,  2 Oct 2026 03:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790913439;
	bh=JGbxfjALTUQwxq1qJv01o3GgQpTAqeK9iKQm41v7RH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fiJkGWu5LJxFkR3v6K0UnkZ3TKNnXEv4qWypJMDSvW9pkeN4RItLn2SBF7Ubej4VB
	 xmU0yzbWQ12Xf4YDF4O15g4sX6iZyJFRFLedUWJREiGGU+Wj1V3Mz8n2f01OLYhyzf
	 /KjbfSVPIWDd2SgNG2VrgelKFaIK+EPZ/hYD1HsKE1/iWsb4qj3bMQpZ/PepUuDqPC
	 WmjdW0Dh2jfdQ2uCNRgr8cMfYE/5yyMqNYGPE4XiDZmI6Xm4UOlSA8xazXs8nvRQ7N
	 eP4Tr3nd6sSTPpNViD1JuXoey7tLZx7cQj561YBho3gXAPvNle2TU5o0RMf7zuPGzJ
	 ISREDXIhmnXwQ==
Message-ID: <f790bd53-8610-4e8a-aa4c-1f346c0cbbe6@kernel.org>
Date: Thu, 1 Oct 2026 22:57:17 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20261001182410.1525285-1-superm1@kernel.org>
 <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 10:44 PM, Vasant Hegde wrote:
> 
> 
> On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
>> PerfOpt is only a feature usable by integrated GPUs and only in identity
>> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
>> an integrated GPU is in identity.
>>
>> PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
>> it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
>> table in the fast path).
>>
>> This drops quite a bit of compatibility glue.  There was a refcounting
>> system, exported symbols, and device attach/detach logic.  By just setting
>> it immediately it's a lot more straightforward.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v4:
>>   * Disable PASID for PerfOpt devices
>>   * Don't allow attaching a blocked domain
> 
> This will block attaching device to guest via vfio-pci. Is that fine?
> 
> -Vasant
> 

Right - The thing is from that experiment on v3, putting it in blocked 
domain does nothing while PerfOpt is enabled.

I figured the user should be aware; so I was between blocking attaching 
a blocked domain or showing a warning.


