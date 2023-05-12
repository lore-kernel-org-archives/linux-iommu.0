Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B923D43
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 19:02:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79CDAD75;
	Fri, 12 May 2023 12:03:17 -0700 (PDT)
Received: from [10.57.82.232] (unknown [10.57.82.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56C53F67D;
	Fri, 12 May 2023 12:02:31 -0700 (PDT)
Message-ID: <57cb07ff-dbaf-dda3-fc6f-75ca8e886672@arm.com>
Date: Fri, 12 May 2023 20:02:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Work around MMU-600 erratum
 1076982
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, jean-philippe@linaro.org
References: <cover.1683731256.git.robin.murphy@arm.com>
 <08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com>
 <ZFvXF3gKL4WHiBeZ@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZFvXF3gKL4WHiBeZ@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-05-10 18:40, Nicolin Chen wrote:
> On Wed, May 10, 2023 at 04:38:43PM +0100, Robin Murphy wrote:
> 
>> MMU-600 versions prior to r1p0 fail to correctly generate a WFE wakeup
>> event when the command queue transitions fom full to non-full. We can
>> easily work around this by simply hiding the SEV capability such that we
>> fall back to polling for space in the queue - since MMU-600 implements
>> MSIs we wouldn't expect to need SEV for sync completion either, so this
>> should have little to no impact.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!

>> +static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>> +{
>> +       u32 reg;
>> +       unsigned int implementer, productid, variant, revision;
> 
> Just for curiosity -- what's the fashion behind the coding style
> here? Usually I follow a longer-to-shorter style, yet perhaps I
> can follow this one for further SMMU patches, if it matters.

In the case of my code, it's usually some intuitive contextual order 
based on a hierarchy of the types and/or importance of variables within 
the logic of the function and relative to each other. I couldn't really 
explain it as a set of rules, it's just whatever feels most right :)

Cheers,
Robin.
