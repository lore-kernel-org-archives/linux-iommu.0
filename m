Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DB5C82
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 15:04:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF61D6E;
	Thu,  1 Sep 2022 08:04:57 -0700 (PDT)
Received: from [10.57.18.92] (unknown [10.57.18.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10EE73F766;
	Thu,  1 Sep 2022 08:04:08 -0700 (PDT)
Message-ID: <58d14cfc-f8ba-777b-a975-371ff2b29e5a@arm.com>
Date: Thu, 1 Sep 2022 16:03:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, iommu@lists.linux.dev, linux-s390@vger.kernel.org,
 borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
 joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
 <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
 <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
 <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com> <YxDDD2DF9KFDQ+Yk@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxDDD2DF9KFDQ+Yk@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-01 15:34, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2022 at 03:29:16PM +0100, Robin Murphy wrote:
> 
>> Right, the next step would be to bridge that gap to iommu-dma to dump the
>> flush queue when IOVA allocation failure implies we've reached the
>> "rollover" point, and perhaps not use the timer at all. By that point a
>> dedicated domain type, or at least some definite internal flag, for this
>> alternate behaviour seems like the logical way to go.
> 
> At least on this direction, I've been thinking it would be nice to
> replace the domain type _FQ with a flag inside the domain, maybe the
> ops, saying how the domain wants the common DMA API to operate. If it
> wants FQ mode or other tuning parameters

Compare the not-necessarily-obvious matrix of "strict" and "passthrough" 
command-line parameters with the nice understandable kconfig and sysfs 
controls for a reminder of why I moved things *from* that paradigm in 
the first place ;)

This idea still fits perfectly into the the "continuum of strictness" 
notion underlying that domain type rework, since it potentially leaves a 
lot more address space mapped for a much longer time than our current FQ 
implementation. I would agree that exposing FQ tuneables in their own 
right may well have some potential value, much like John's equivalent 
idea for the IOVA cache layer, but I for one have no desire to bring 
back DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, much less any further mess of 
disjoint properties at that level.

Thanks,
Robin.
