Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF1374
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 15:09:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85BE3D75;
	Fri, 18 Aug 2023 08:09:43 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 857E03F64C;
	Fri, 18 Aug 2023 08:09:02 -0700 (PDT)
Message-ID: <9a4b0bf3-2eb1-9428-1905-2225ce0874ee@arm.com>
Date: Fri, 18 Aug 2023 16:08:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Software bounce buffers Vs allocating DMA buffers in page
 granularity
Content-Language: en-GB
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>,
 iommu@lists.linux.dev
References: <CAD7mqrygN8W59SmeS2nEVppNVeoW3FsiVtOG_PH7fcV4C16YEg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAD7mqrygN8W59SmeS2nEVppNVeoW3FsiVtOG_PH7fcV4C16YEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-17 21:17, Chathura Rajapaksha wrote:
> Hi All,
> 
> I have a question regarding the IOMMU software bounce buffer feature.
> I understand that this feature was introduced as a mitigation to
> sub-page vulnerabilities (which were shown to be exploitable by
> Thunderclap).
> 
> My question is:
> Can allocating DMA buffers in page granularity (multiples of 4KB pages)
> be a feasible alternative solution to software bounce buffers?
> 
> I am trying to understand the challenges and performance impact of
> such a solution (compared to SW bounce buffers) if someone were to
> proposed it.
> In other words, I am trying to find the reasons why SW bounce buffers
> were introduced rather than allocating DMA buffers in page granularity.

Dedicated DMA buffers (dma_alloc_*()) *are* allocated at page 
granularity. SWIOTLB is used by the streaming DMA API (dma_map_*()), 
where the data already exists somewhere in memory, outside our control. 
If a streaming mapping request does happen to be aligned to the IOMMU 
page size already, it isn't bounced.

Robin.
