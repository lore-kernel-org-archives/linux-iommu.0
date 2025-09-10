Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204A224AFA
	for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469503; cv=none; b=Ms2/zj8yC1ruxRnTqEUHdoSzHYMN/1tV0EC6/4TR6J+CIcjQ1VW8phn6k3yzoEtJemacZamNHgn2MSvRJW5/MIRNYHYWAdXb4TL4TnCeBubgMnMC/qxf1fAjZ3enPoR8cbb3DABiyHN03dSiutazk82p+9iwCHDSsFP6HV/84vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469503; c=relaxed/simple;
	bh=LRRR8BuMrgsRYuyMhegYDmAm90CuK5yaMJbhSnZhoU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKzGO27wQQYNqPTgJXRYksASVYCtUKw2/Qp3VSTgCZ1ye7YQh/6t9HUDgoq6cjZuWbYXSHOsoaTnwM1SjRILKFXLvm8eiDHhK+hMDm9F1HKkfeK7g+/bibcyvel+bpMbhe1OWi6zU05Z8bH/++lGI6fMNY++2Q4F/SaSOYNASWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ELkikix4; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ELkikix4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757469498; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MTNoidwT8Z4FYBk2bJLdhRry/2KTrqWkpMD54mBw+Xg=;
	b=ELkikix4hvCGwNNglWWv67CgWHkZJFMjK5FJaW6pEaZly21rNMqppNf8Tih6+z/OVUnZrOIilxmwuj+xYrfM3onmoUNR4X3aA/jWxNT0RVHiJrz4CiN+nbhs5am7RAWETUNkHQ7T5ZRab8e1DFKnWI02EcwVhYpRyxUGnEUilkc=
Received: from 30.178.82.131(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wng8r0a_1757469496 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 09:58:17 +0800
Message-ID: <ca8ca982-619c-44fa-af55-7a985b6b3cce@linux.alibaba.com>
Date: Wed, 10 Sep 2025 09:58:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] iommu: Fix iommu selftest running test mock domain fail
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev
References: <20250909125552.125969-1-kanie@linux.alibaba.com>
 <20250909140500.GC699673@ziepe.ca>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20250909140500.GC699673@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

在 2025/9/9 22:05, Jason Gunthorpe 写道:
>> +	mutex_lock(&iommu_probe_device_lock);
>> +	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
>> +	if (rc) {
>> +		mutex_unlock(&iommu_probe_device_lock);
>> +		dev_err(&mdev->dev, "init fwspec failed:%d\n", rc);
> No prints, we use fault injection to test these error paths, do not
> print.
Sure, removed in v2.
>> +		goto err_put;
>> +	}
>> +	mutex_unlock(&iommu_probe_device_lock);
> Is this lock necessary? The device isn't added yet so it should be
> impossible for the probe side to observe it, right?

In dev_iommu_get(), there is a 
"lockdep_assert_held(&iommu_probe_device_lock)",

if dont lock here, WARN_ON will be triggered many times in debug kernel 
during

testing.

> Exporting the lock is my biggest concern with this..
>
> Jason

Best Regards,

Guixin Liu

