Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB33F8883
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857031; cv=none; b=gfnutTVV81228dDgHTddctcgaacJNQlkeb41cYlXhZk4Fo/FGdeAtI30/B0zepBg0xVQL61T0slNaVk068b0o9NJccfafwmYJ+pbA/npsJGGvdgRrP14HhHk9it9YLt7eHBbi7DGA3gIhwR5/MoYdzpbqWZogJGYh6W5/jMBsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857031; c=relaxed/simple;
	bh=L2JX0u8Lfazn5RuRn03mNfgqAEqgLPIOjbmGYwItSCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkPh621IWJdCr6octEuOwEnAk8mafFSQ4J8y+JjUb+e6FmaGGZgegpxYov5V13+LgWSMGUHa212ukP+dJKr6x/cGBkd7PFO1mwuWfRT+lVfS1LFoBey742Ne7A4e0OVlmqjvbvgwRW2KzmTg4pW2iwtoitAX6JHk7MMhstJFo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ccAb3BZc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ccAb3BZc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87651476;
	Tue,  4 Aug 2026 08:23:44 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964693F86F;
	Tue,  4 Aug 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785857029; bh=L2JX0u8Lfazn5RuRn03mNfgqAEqgLPIOjbmGYwItSCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ccAb3BZcuVgv6XZv+Wh+4/ektkFWGnknlGrl6C5/AvKTMAkCpcmZ/Se+jz8XyyY7c
	 MJ45VhKFzjjjKJ9CGatkCCdLCWaaXlVX0Mtt32vZSBinH1X8BORTfKxjvGqb0YQUtC
	 dsVwghScmdvtTJ2I6Lf+EZ6nDWcnc6NL5za5CmSQ=
Message-ID: <57013b4e-d024-4c37-8fb1-5d7c96a13978@arm.com>
Date: Tue, 4 Aug 2026 16:23:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
To: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
 Usama Arif <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck> <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck> <20260804141704.GB27883@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260804141704.GB27883@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2026 3:17 pm, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
>>> Would skipping their allocation when is_kdump_kernel() be acceptable on
>>> its own, or would you rather see it done differently?
>>
>> With Nicolin's patch, we can just avoid allocating the priq and the evtq
>> entirely in the kdump case. We can then add a cmdline option to control
>> the maximum size of the cmdq, which is useful regardless of kdump.
> 
> I would still prefer kdump do this re-sizing automatically, even if we
> do add a commandline. It makes it easire to deploy than having to know
> secret command lines :\

Right, but if we implement a general command-line option/module 
parameter/whatever with a variable that needs a default value for when 
it's not overridden, then it's even more trivial to initialise *that* 
default value based on further conditions as desired.

Plus implementing the more dynamic mechanism to begin with is arguably 
nicer than hard-coding a kdump special case in what is effectively the 
wrong place, since semantically what we really want to 
override/generalise are the max_n_shift initialisations in 
arm_smmu_device_hw_probe() itself.

Thanks,
Robin.

> So functionally I still think this patch is fine, though yes it points
> out more things in Nicolin's work too.
> 
> Jason

