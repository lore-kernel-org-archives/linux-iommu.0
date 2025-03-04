Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334528150E
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104149; cv=none; b=ESkshSBNtcBZT0d50uGW8YKe4nKHGCeTWB7mWEkhjCTid9SL9phng6RLcCZS3uW5rK1kbDSGauzb6I35+o4f0ook3ozO4PcCmXkgWGCGmpFB9OVBq7oA9AllkNbIU2SWO4M448yoxBbqEDkgzcRusY7Ps/ybBA4CMUF7pD7W4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104149; c=relaxed/simple;
	bh=Ife1S2+6Gw0oW5C4+eCeVlOTVa8vt6NEV5srvuNBU6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOMq9hyQz2Hg8x0gYSWewVrNlZsAXndy71/lKSJkLx+ivsFvZU6T641yy1QgJ+PCOqikbzkDpWOIuCzM/8J5ydl/LxweYaiao74shJMdiwFxpweWn9nIuD6V3xujzLarP9lVV6ZiDirio6xgtmWpZRLfPp7rSSomdTHsD0DaULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619542F;
	Tue,  4 Mar 2025 08:02:40 -0800 (PST)
Received: from [10.57.83.152] (unknown [10.57.83.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C0B73F5A1;
	Tue,  4 Mar 2025 08:02:22 -0800 (PST)
Message-ID: <67fbe3f4-4fb6-4753-b34c-320b7897fd16@arm.com>
Date: Tue, 4 Mar 2025 16:02:20 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "maz@kernel.org"
 <maz@kernel.org>, "david@redhat.com" <david@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "mshavit@google.com" <mshavit@google.com>,
 "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com> <20250303165255.GS5011@ziepe.ca>
 <20250303190330.GA426248@e133081.arm.com> <20250304142634.GC5011@ziepe.ca>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250304142634.GC5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2025 14:26, Jason Gunthorpe wrote:
> On Mon, Mar 03, 2025 at 07:03:42PM +0000, Mikołaj Lenczewski wrote:
> 
>> For example, if we use BBML2 for kernel mappings, does that require us
>> to repaint all kernel mappings when disabling BBML2 on smmu attach? I
>> am not sure, but definitely something to be worked out.
> 
> No, it would be a per-mm_struct basis only if we did something like
> that
> 
> When the SMMU driver puts a SVA on top of the mm_struct it would
> disable BBML2 usage only for that mm_struct and it's contained VMAs.

I guess we would need to figure out some synchonization mechanism if disabling
BBML2 dynaically per-mm. If there was already a BBML2 operation in flight would
want to wait for it to end. But that's a problem to solve if/when it's shown to
be needed, I think.

> 
> Kernel mappings are never made into a SVA so are not effected.
> Userspace only.
> 
> Jason

