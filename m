Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1565604B5;
	Wed, 24 Jan 2024 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096828; cv=none; b=I/aCiyabPKKwn0lBVTtDlS+BEzk8zluymUf1rPqZXy8fUtD101vEJ7Nf0ruQipFoyvwclly1nsKePgxg8oDO+cahGygBdFq7fNeYrs+v38cG3c1ptOnXxKKIIyoUZVM8CFArCgUZfDdebM8yDNPPHdzIlrSe91mSzikJDSfOFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096828; c=relaxed/simple;
	bh=Z8G/x2PctAViaI4Q+4hzEXxuYAr1jPmScShAYAIhgas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIDsIKYcQov8Z5AJqBhdu08bnyGXyX5ZnbTeq8mU4Bzu4+aZE0u/2jQP+aJmVqwjZbklgUcG4CepABOHxu/HY9gjkn3BZb99tEPugHAED1mp4pu/cF87BUIy8P7iPcST/bJ3BKm1gQS6m+SnKHbJBAAr3gIyGUK/Aut9GjUgovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD9A1FB;
	Wed, 24 Jan 2024 03:47:50 -0800 (PST)
Received: from [10.1.31.24] (010265703453.arm.com [10.1.31.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880263F762;
	Wed, 24 Jan 2024 03:47:03 -0800 (PST)
Message-ID: <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>
Date: Wed, 24 Jan 2024 11:46:59 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Content-Language: en-GB
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, jonathanh@nvidia.com, baolu.lu@linux.intel.com,
 jsnitsel@redhat.com, jroedel@suse.de, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-24 9:13 am, Diogo Ivo wrote:
> On Tue, Jan 23, 2024 at 11:15:08AM -0400, Jason Gunthorpe wrote:
>> On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt wrote:
>>> Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
>>> at least on the Pixel C with the following error message reporting
>>> a failed buffer allocation:
>>>
>>> [    1.857660] drm drm: failed to allocate buffer of size 18432000
>>>
>>> This error message is printed from tegra_bo_alloc() which is called by
>>> tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
>>> allocations would fail as well, not just the framebuffer.
>>
>> Presumably this is because iommu_map_sgtable() under
>> tegra_bo_iommu_map() fails?
>>
>> Which I suspect is because of the logic in
>> host1x_client_iommu_attach().
>>
>> After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.
>>
>> So this:
>>
>> 	if (domain && domain != tegra->domain)
>> 		return 0;
>>
>> Will happen and the domain will be left at IDENTITY, while I suppose
>> the tegra_bo_iommu_map() assumes the domain was switched to tegra->domain.
>>
>> Does this solve your issue?
>>
>> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
>> index ff36171c8fb700..15c7910b2e1c76 100644
>> --- a/drivers/gpu/drm/tegra/drm.c
>> +++ b/drivers/gpu/drm/tegra/drm.c
>> @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
>>           * not the shared IOMMU domain, don't try to attach it to a different
>>           * domain. This allows using the IOMMU-backed DMA API.
>>           */
>> -       if (domain && domain != tegra->domain)
>> +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain != tegra->domain)
>>                  return 0;
>>   
>>          if (tegra->domain) {
>>
>>> This may be connected with an error in of_iommu_configure() that
>>> became visible after commit 6ff6e184f1f4d:
>>>
>>> [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT
>>
>> Hmmm
>>
>> This is a new logging, so it doesn't necessarily mean something has
>> changed in the code flow.
>>
>> It seems the issue is something in there is returning ENOENT when it
>> probably should be ENODEV, but I haven't been able to guess where it
>> comes from.
>>
>> Can you do some tracing and figure out where under
>> of_iommu_configure() this ENOENT return code is from?
>>
>> Jason
> 
> I did the tracing and found that the ENOENT is coming from
> sysfs_do_create_link_sd() in the following function call chain:
> 
> of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->

What's the call path leading up to that? If it's the one from 
host1x_device_add() then it's expected and benign - for fiddly reasons, 
iommu_probe_device() ends up being called too early, but will soon be 
run again in the correct circumstances once we proceed into 
host1x_subdev_register()->device_add(). That will have been happening 
for years, we just never reported errors in that spot before (and 
frankly I'm not convinced it's valuable to have added it now).

Thanks,
Robin.

> iommu_init_device() -> iommu_device_link() -> sysfs_add_link_to_group() ->
> sysfs_create_link_sd() -> sysfs_do_create_link_sd()
> 
> The particular block that emits the error is
> 
> static int sysfs_do_create_link_sd()
> {
> 	...
> 
> 	if (target_kobj->sd) {
> 		target = target_kobj->sd;
> 		kernfs_get(target);
> 	}
> 
> 	if (!target)
> 		return -ENOENT;
> 
> 	...
> }
> 
> Best regargs,
> Diogo
> 
