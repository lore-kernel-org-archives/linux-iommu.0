From: "Hook, Gary" <ghook@amd.com>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Tue, 17 Apr 2018 13:38:04 -0400
Message-ID: <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523664612.2747.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523664612.2747.13.camel@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "gary.hook@amd.com" <gary.hook@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>   
>> +
>> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
>> +{
>> +	char name[MAX_NAME_LEN + 1];
>> +	struct dentry *d_top;
>> +
>> +	if (!debugfs_initialized())
> 
> Probably not needed.

Right.

> 
>> +		return;
>> +
>> +	mutex_lock(&amd_iommu_debugfs_lock);
>> +	if (!amd_iommu_debugfs) {
>> +		d_top = iommu_debugfs_setup();
>> +		if (d_top)
>> +			amd_iommu_debugfs =
>> debugfs_create_dir("amd", d_top);
>> +	}
>> +	mutex_unlock(&amd_iommu_debugfs_lock);
> 
> 
> You can do the above only once if you iterate over the IOMMUs here
>   instead of doing it in amd_iommu_init.

I'm not sure it matters, given the finite number of IOMMUs in a system, 
and the fact that this work is done exactly once. However, removal of a 
lock is fine thing, so I'll move this around.

> 
>> +	if (amd_iommu_debugfs) {
>> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu-
>>> index);
>> +		iommu->debugfs = debugfs_create_dir(name,
>> +						    amd_iommu_debugf
>> s);
>> +		if (!iommu->debugfs) {
>> +			debugfs_remove_recursive(amd_iommu_debugfs);
>> +			amd_iommu_debugfs = NULL;
>> +		}
>> +	}
>> +}
> 
> -Sohil
> 
