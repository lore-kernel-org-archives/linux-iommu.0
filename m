Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAD2F37;
	Sun, 12 Mar 2023 14:42:49 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pbMuL-0002dq-E1; Sun, 12 Mar 2023 15:42:45 +0100
Message-ID: <c44b3f40-4b8f-8614-65f5-e78ded89c641@leemhuis.info>
Date: Sun, 12 Mar 2023 15:42:44 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US, de-DE
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Fagnani <matt.fagnani@bell.net>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678632169;a99a0ee6;
X-HE-SMSGID: 1pbMuL-0002dq-E1

On 17.02.23 06:53, Vasant Hegde wrote:
> 
> [+ CCed few folks from other thread (Bug 216865 - Black screen when amdgpu ...).]
> 
> This patch helps to solve the 'black screen' issue we hit in upstream [1].
> 
> With this patch we are handling error path gracefully. System is booting without
> enabling PASID for AMD gpu. Matt has tested this patch and confirmed its working [2]
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216865
> [2]
> https://lore.kernel.org/linux-iommu/e17d1ee9-7383-6717-6f10-9465b273b1ed@amd.com/T/#m98390232691e3e55db7f1187073016436fd2176a
> 
> Can you consider this patch for 6.2?
> 
> I did miss Report-by, tested by tags. Can you append below tags or do you want
> me to respin patches?
> 
> --------
> 
> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
> Link:
> https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
> Tested-by: Matt Fagnani <matt.fagnani@bell.net>

Thx again for handling this. Matt now seems to run into a different
problem reported here:

https://bugzilla.kernel.org/show_bug.cgi?id=217170
https://gitlab.freedesktop.org/drm/amd/-/issues/2454

In short: amdgpu failed to resume when IOMMU is in use; when
"amd_iommu=off" is used, suspend works fine.

Is this something that might be related to these fixes?

Ciao, Thorsten

> On 2/15/2023 10:56 AM, Vasant Hegde wrote:
>> iommu_attach_group() attaches all devices in a group to domain and then
>> sets group domain (group->domain). Current code (__iommu_attach_group())
>> does not handle error path. This creates problem as devices to domain
>> attachment is in inconsistent state.
>>
>> Flow:
>>   - During boot iommu attach devices to default domain
>>   - Later some device driver (like amd/iommu_v2 or vfio) tries to attach
>>     device to new domain.
>>   - In iommu_attach_group() path we detach device from current domain.
>>     Then it tries to attach devices to new domain.
>>   - If it fails to attach device to new domain then device to domain link
>>     is broken.
>>   - iommu_attach_group() returns error.
>>   - At this stage iommu_attach_group() caller thinks, attaching device to
>>     new domain failed and devices are still attached to old domain.
>>   - But in reality device to old domain link is broken. It will result
>>     in all sort of failures (like IO page fault) later.
>>
>> To recover from this situation, we need to attach all devices back to the
>> old domain. Also log warning if it fails attach device back to old domain.
>>
>> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>> Robin, Joerg,
>>   As explained in previous version [1], I still kept the changes in
>>   iommu core layer. I hope this is fine with you.
>>
>> [1] https://lore.kernel.org/linux-iommu/f2151603-de54-7717-60f9-748e9205139e@amd.com/
>>
>> -Vasant
>>
>>  drivers/iommu/iommu.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index de91dd88705b..e3336a11b6b9 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2124,8 +2124,22 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>>  
>>  	ret = __iommu_group_for_each_dev(group, domain,
>>  					 iommu_group_do_attach_device);
>> -	if (ret == 0)
>> +	if (ret == 0) {
>>  		group->domain = domain;
>> +	} else {
>> +		/*
>> +		 * To recover from the case when certain device within the
>> +		 * group fails to attach to the new domain, we need force
>> +		 * attaching all devices back to the old domain. The old
>> +		 * domain is compatible for all devices in the group,
>> +		 * hence the iommu driver should always return success.
>> +		 */
>> +		struct iommu_domain *old_domain = group->domain;
>> +
>> +		group->domain = NULL;
>> +		WARN(__iommu_group_set_domain(group, old_domain),
>> +		     "iommu driver failed to attach a compatible domain");
>> +	}
>>  
>>  	return ret;
>>  }
> 
