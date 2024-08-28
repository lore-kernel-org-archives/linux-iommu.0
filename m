Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2F19E83D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858687; cv=none; b=l9WJoRaxeiKzwetLe+hZxGkBYCVr8H1oJtDKTyWfyYpsF4zoVtdK18Ob/rlKNEh0odRWywt9U1t7fpEPWWB8bjSsUynwWPwV/38oCkvuYsWSEn9KDmJruyWJy8eLtwBPOLZn3yYJct602NBAi4JDB9xYfL5srUAxpswTwNd9J4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858687; c=relaxed/simple;
	bh=51xBBmdPEWsklZN52ULuaYNrZcsOdYPotwbhGXMEGzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV6TcLC40NiRMkv5GGZ2EMgfhVcTyh+4L6FyAQ+iAtZgijs6xEYFvZzbTWCsKuAveRiahDuMYbYZorsObWADZKwcV+MwkaKAyiAAYvzqL4E+yNjsMDwCSZKuUA/n0kwygtBj1PPnpR+POz1qCaWtQtUTIOEyIUxzS/X7gqtZvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920B6DA7;
	Wed, 28 Aug 2024 08:25:09 -0700 (PDT)
Received: from [10.57.15.188] (unknown [10.57.15.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969FE3F73B;
	Wed, 28 Aug 2024 08:24:42 -0700 (PDT)
Message-ID: <8d47c290-8146-4a3a-b163-e60b605557fe@arm.com>
Date: Wed, 28 Aug 2024 16:24:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iommu/omap: Use IS_ERR_OR_NULL() helper function
To: Hongbo Li <lihongbo22@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev
References: <20240828122152.3697094-1-lihongbo22@huawei.com>
 <ee9b096a-7d23-47ed-850f-f8ca2c9af97f@arm.com>
 <29458d89-132e-4069-81f4-a5b02598590c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <29458d89-132e-4069-81f4-a5b02598590c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-28 1:31 pm, Hongbo Li wrote:
> 
> 
> On 2024/8/28 20:24, Robin Murphy wrote:
>> On 2024-08-28 1:21 pm, Hongbo Li wrote:
>>> Use the IS_ERR_OR_NULL() helper instead of open-coding a
>>> NULL and an error pointer checks to simplify the code and
>>> improve readability.
>>
>> IS_ERR_OR_NULL() is usually a bad smell to begin with... Sure enough, 
>> if you really want to simplify and improve this code, it doesn't take 
>> much to look a little further and see that the suspicious checks are 
>> entirely pointless anyway. Both callsites have this pattern:
>>
>>          omap_iommu_detach(oiommu);
>>          ...
>>          oiommu->domain = NULL;
>>
>> so clearly the pointer must always be valid.
> 
> Yes, in IS_ERR_OR_NULL, the ptr is unlikely NULL, it match this 
> condition. But the original condition does not have this expectation.

My point is that the original condition here serves no purpose, so 
refactoring it is a waste of time, and the only cleanup worth making is 
to delete it.

Open-coded or not, the fact is that if we ever _could_ take that early 
return by virtue of either caller's "oiommu" pointer being NULL or an 
error value, then we'd still crash by unconditionally dereferencing it 
two lines later. And it's pretty clear from the rest of the flow of 
->iommu_dev pointers through omap_iommu_probe_device() and 
omap_iommu_attach_dev() that a NULL value cannot get here by 
construction. As far as I can see nothing anywhere *ever* assigns an 
ERR_PTR() value to one...

Churning pointless dead code into slightly different pointless dead code 
is not valuable to anyone. Churning ugly code into slightly different 
ugly code is still questionable at best. If you're finding places which 
look like they could use IS_ERR_OR_NULL(), then be aware that often at 
least one of the two conditions might be erroneous anyway. Otherwise, it 
usually represents some badly-designed interface which really wants to 
be fixed properly such that it *would* only need one or other condition.

Thanks,
Robin.
