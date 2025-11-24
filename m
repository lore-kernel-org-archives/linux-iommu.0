Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609B339A8
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004588; cv=none; b=Kv2rSusOel6aYS/8XUVKuV0/kB5Cu+XhHTmZRGWiwaQREprfiUrUHAxzmFVZ9dIvWNRLYzJuy5GPnWSuANK53Fq54oQ6pKOUcOlXwoBawujICxlpqRIeocVXhRlWbdd5EnNRBQaBeIg1ubzkc/Q3O1yQ+op3T02NgMEmuIx+8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004588; c=relaxed/simple;
	bh=hiLCN2S2JkqrHyrDj98cjXaOOAih3/bUb62Dt4aMpN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr9Bf9XbKE4r6tfZ8xT3vCj+d/IkZ7BbKNy5HepwtL/Jxa/GTSFZ4fuRehex5NXSUfb/xE+l62V+zqei7+2mhjxtAe4eiluLxI57Lmfz3nh1MwiD0/rhT83DLrUEiRtaDEzX4vArGJjAMftsoI76ZlQfdlIividkman7hhSfGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217C01477;
	Mon, 24 Nov 2025 09:16:19 -0800 (PST)
Received: from [10.1.30.67] (unknown [10.1.30.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DB723F73B;
	Mon, 24 Nov 2025 09:16:25 -0800 (PST)
Message-ID: <78b9feb4-f756-4d44-9472-95ffad58647a@arm.com>
Date: Mon, 24 Nov 2025 17:16:23 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Remove redundant null check in
 iommu_iotlb_gather_queued
To: Will Deacon <will@kernel.org>, Aashish Sharma <aashish@aashishsharma.net>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>,
 Dmytro Maluka <dmaluka@google.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Aashish Sharma <shraash@google.com>
References: <20251111051952.1985154-1-aashish@aashishsharma.net>
 <aSSP7sG0OMFGElS9@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aSSP7sG0OMFGElS9@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-24 5:03 pm, Will Deacon wrote:
> On Mon, Nov 10, 2025 at 09:19:52PM -0800, Aashish Sharma wrote:
>> The callers of 'iommu_iotlb_gather_queued' always have a non-null
>> 'gather', so we don't need to check for the same in the function.
> 
> That's not obviously true to me, how did you check it?
> 
> For example, msm_iommu_pagetable_unmap() appears to call into
> io_pgtable_ops::unmap_pages() with a NULL gather pointer.

Indeed I think the only redundant check is the one which seems to have 
snuck into __arm_lpae_unmap() not so long ago (which the other callers 
never had and still don't.)

Thanks,
Robin.
