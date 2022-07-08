Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E47E0
	for <iommu@lists.linux.dev>; Fri,  8 Jul 2022 14:44:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 999E51063;
	Fri,  8 Jul 2022 07:44:15 -0700 (PDT)
Received: from [10.57.86.102] (unknown [10.57.86.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5642D3F66F;
	Fri,  8 Jul 2022 07:44:14 -0700 (PDT)
Message-ID: <70cb6f20-7028-9cf8-6b3a-a074c0047687@arm.com>
Date: Fri, 8 Jul 2022 15:44:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] gpu: host1x: Register context bus unconditionally
Content-Language: en-GB
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mperttunen@nvidia.com, iommu@lists.linux.dev,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Joerg Roedel <joro@8bytes.org>
References: <503bffe670b24aac0dfb03c8fc16437b8f0cca58.1657215044.git.robin.murphy@arm.com>
 <Ysg/7u5gRiDbEm5F@orome>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Ysg/7u5gRiDbEm5F@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-08 15:32, Thierry Reding wrote:
> On Thu, Jul 07, 2022 at 06:30:44PM +0100, Robin Murphy wrote:
>> Conditional registration is a problem for other subsystems which may
>> unwittingly try to interact with host1x_context_device_bus_type in an
>> uninitialised state on non-Tegra platforms. A look under /sys/bus on a
>> typical system already reveals plenty of entries from enabled but
>> otherwise irrelevant configs, so lets keep things simple and register
>> our context bus unconditionally too.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/gpu/host1x/context_bus.c | 5 -----
>>   1 file changed, 5 deletions(-)
> 
> Applied, thanks.
> 
> Do we need this in v5.19 or is it enough if this gets into v5.20?

It's not strictly a critical fix, so I think 5.20 is fine. I plan to 
post v4 of my bus_set_iommu() series next week as the hopefully-final 
version, but at this point I think it might be safer to hold off 
actually merging that until early next cycle, to give it plenty of time 
in -next.

Thanks,
Robin.
