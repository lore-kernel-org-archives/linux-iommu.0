Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE4314B6A
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139670; cv=none; b=rtnNTQ3i0ylMgzSeQNcz8Xt7L2GTQprs0hgeI1OuzWLiiN3E8HPCSCRfkJ2Oz6LxsdruYzhTV4mwYEF5iL2htNvkl5xMk6Hlbr/BhPl7RIboVEu//9Q97CPfms9nYtmnKWptC6swz7DDc1ouHpBfmDCZSicBurxvdyJD3W+qeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139670; c=relaxed/simple;
	bh=vcmvVQNjYJimIYB0DxTGQAEothPkR0RBtUJioip9QfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+aEMWx3GnjUOXufHq6X5ciIlAVXkoe4MM5pMwwu26BECxESw/TsoUsAIuC6XiriakVbBT9pkG0ye7rQQoeyfH2cnmmqosJIliFIOvZqMj73iRCnu5Yn1mD/HgqZyIOmfWI+wunanGg28Isx+7+YJMHwKymRA4gKjZPvJuknf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IAyDBCkv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IAyDBCkv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46CE32C43;
	Thu,  2 Apr 2026 07:21:01 -0700 (PDT)
Received: from [10.57.75.194] (unknown [10.57.75.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62C53F915;
	Thu,  2 Apr 2026 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775139667; bh=vcmvVQNjYJimIYB0DxTGQAEothPkR0RBtUJioip9QfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IAyDBCkv28B1zf+0sx+87FBGG+7V0QTBmhlFdZueRYWSpxYszjqKu1Zjgove6er7Q
	 0d1cLyhOE69F3AlaHJvQtZCIu0OLzYYQ32eXu3WpkG1HlJ/aabsDgHq8YPxkpJq7CS
	 QF7oWcEcHF+dWWfpd3qvOtZ2pMMja0YkxB+L8yB8=
Message-ID: <39d07d46-fee3-48a3-a991-b293e9d498db@arm.com>
Date: Thu, 2 Apr 2026 15:20:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
 <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
 <20260402115958.GA2551565@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260402115958.GA2551565@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-02 12:59 pm, Jason Gunthorpe wrote:
> On Thu, Apr 02, 2026 at 02:25:54PM +0300, Tudor Ambarus wrote:
> 
>> I can probably track whether all instances are ready, and defer if any
>> is not ready, but then I'll force the iommu clients to use the sketchy
>> replay path, which seems like a bad idea, according to Robin's feedback.
> 
> I didn't think that was sketchy, it is part of the boot ordering
> system to ensure that the iommu driver(s) is probed before the client
> devices.
> 
> Half operating a device is definately going to get things into trouble
> with broken/incomplete domain attachments at least.

The Exynos driver itself is actually fine, and doing everything right. 
We'll never have a "half-configured" client device in IOMMU API terms 
currently - only once both instances are registered such that both 
of_xlate calls can succeed (one for each specifier in the client 
device's "iommus" property) will we proceed to calling probe_device, 
which will then work as normal.

The issue here is purely in the race-avoidance scheme within 
of_iommu_configure() itself, which hasn't accounted for the fact that 
when it's looping over multiple specifiers, they don't necessarily all 
target the same IOMMU node. And it's only during a window where the 
instance targeted by the first specifier happens to be registered 
already, and the second is currently in the middle of registering.

Thanks,
Robin.
