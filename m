Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9F23D4D
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 19:24:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E7CD75;
	Fri, 12 May 2023 12:24:46 -0700 (PDT)
Received: from [10.57.82.232] (unknown [10.57.82.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 778913F67D;
	Fri, 12 May 2023 12:24:00 -0700 (PDT)
Message-ID: <a45be5e3-c605-f93a-f523-1bb1f6150986@arm.com>
Date: Fri, 12 May 2023 20:23:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, jean-philippe@linaro.org
References: <cover.1683731256.git.robin.murphy@arm.com>
 <330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com>
 <ZFvec0JGfbaYHie2@Asurada-Nvidia> <ZFvi/WEksryM0cin@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZFvi/WEksryM0cin@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-10 19:31, Nicolin Chen wrote:
> On Wed, May 10, 2023 at 11:12:05AM -0700, Nicolin Chen wrote:
>> On Wed, May 10, 2023 at 04:38:44PM +0100, Robin Murphy wrote:
>>
>>> To work around MMU-700 erratum 2812531 we need to ensure that certain
>>> sequences of commands cannot be issued without an intervening sync. In
>>> practice this falls out of our current command-batching machinery
>>> anyway - each batch only contains a single type of invalidation command,
>>
>> Hmm. This doesn't apply to the user cache invalidation solution
>> in my v2. A user cmdq could possibly mix different commands in
>> a single batch if the driver isn't aware of such an errata. So,
>> I think I'd need some twist when the host has a FORCE_SYNC flag
>> in my v3.
> 
> Just found that you unset the NESTING feature flag in PATCH-4
> for this errata too. So, the solution in my v2 should be safe.

For the short term at least - we will still need to come up with a more 
practical active mitigation sooner rather than later, since I imagine 
people are likely to be a bit miffed if nesting support lands in distros 
but still refuses to play at all on the newest shiniest hardware. 
Unfortunately all current versions of MMU-700 are affected (hence the 
unconditional nature of this patch), and some of those are going to 
found in production SoCs.

Thanks,
Robin.
