Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A82F31
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 13:12:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E271474;
	Fri, 15 Jul 2022 06:12:43 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629253F70D;
	Fri, 15 Jul 2022 06:12:41 -0700 (PDT)
Message-ID: <f0374374-1f3b-6beb-b7e9-f8071d48bf4d@arm.com>
Date: Fri, 15 Jul 2022 14:12:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, mjrosato@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-05 18:08, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1650890638.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v3, now with working x86! Having finally made sense of how I
> broke Intel, I've given AMD the same fix by inspection. I'm still not
> 100% sure about s390, but it looks like it should probably be OK since
> it seems to register an IOMMU instance for each PCI device (?!) before
> disappearing into PCI hotplug code, wherein I assume we should never see
> a PCI device appear without its IOMMU already registered.
> 
> Otherwise, the only other updates are hooking up the new host1x context
> bus (noting that it now takes all of 4 lines to support a whole new bus,
> yay!), and a slight tweak to make sure we keep rejecting registration of
> conflicting iommu_ops rather than needlessly change that just yet.

FWIW I've prepared v4, including Matt's s390 patch and some nice extra 
cleanups thanks to Kevin's suggestions, but have now decided to wait to 
rebase and send it after the upcoming merge window. If anyone's 
interested in the meantime, there's a preliminary branch here:

https://gitlab.arm.com/linux-arm/linux-rm/-/commits/bus-set-iommu-v4

(temporarily including the host1x patch from -next to avoid breakage on 
arm64 as well)

Thanks,
Robin.
