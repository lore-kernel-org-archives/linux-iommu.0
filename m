Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89A18625;
	Fri,  3 Nov 2023 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895152F4;
	Fri,  3 Nov 2023 09:44:45 -0700 (PDT)
Received: from [10.57.81.32] (unknown [10.57.81.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3623F64C;
	Fri,  3 Nov 2023 09:44:00 -0700 (PDT)
Message-ID: <ede31cc0-5662-4ce1-b718-82ad2d84c417@arm.com>
Date: Fri, 3 Nov 2023 16:43:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race between of_iommu_configure() and iommu_probe_device()
Content-Language: en-GB
To: Konrad Dybcio <konradybcio@kernel.org>, Hector Martin <marcan@marcan.st>,
 iommu@lists.linux.dev, Asahi Linux <asahi@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <a36ddb05-9e5f-dfae-81e2-0da5e4925743@marcan.st>
 <4f06d727-d424-44f8-bd80-53c452b289d3@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f06d727-d424-44f8-bd80-53c452b289d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-03 12:48 pm, Konrad Dybcio wrote:
> 
> 
> On 3.11.2023 12:55, Hector Martin wrote:
>> I just hit a crash in of_iommu_xlate() -> apple_dart_of_xlate() because
>> dev->iommu was NULL. of_iommu_xlate() first calls iommu_fwspec_init
>> which calls dev_iommu_get(), which allocates that member if NULL. That
>> means it got freed in between, but the only thing that can do that is
>> dev_iommu_free(), which is called from __iommu_probe_device() in the
>> error path. That is serialized via a static lock, but not against the
>> xlate stuff.
>>
>> I think the specific sequence of events was as follows:
>>
>> - IOMMU driver has not probed yet
>> - Device driver tries to probe, and gets deferred via of_iommu_xlate()
>> -> driver_deferred_probe_check_state() because there are no IOMMU ops yet
>> - IOMMU driver probes
>> - IOMMU driver registration triggers device probes
>> - IOMMU device probe fails, because there is no fwnode/OF data yet (e.g.
>> apple_dart_probe_device returns ENODEV if dev_iommu_priv_get() returns
>> NULL, and that is set in apple_dart_of_xlate())
>> - __iommu_probe_device is in the error exit path, and at this exact
>> point a parallel device probe is running of_iommu_xlate()
>> - of_iommu_xlate() calls iommu_fwspec_init(), which ensures dev->iommu
>> is non-NULL, which at this point it is
>> - immediately after that, __iommu_probe_device() calls dev_iommu_free()
>> since it is in the process of erroring out. This frees and sets
>> dev->iommu to NULL.
>> - of_iommu_xlate() calls ops->of_xlate()
>> - apple_dart_of_xlate() calls dev_iommu_priv_set(), which crashes
>> because dev->iommu is now NULL.
>>
>> As far as I can tell it's not just the specific driver xlate call
>> setting priv that's the problem here, but there is one big race between
>> the entire fwspec codepath (accessing dev->iommu->fwspec) and
>> __iommu_probe_device() (allocating and freeing dev->iommu).
>>
>> Thinking about this whole thing is making my brain hurt. Thoughts? How
>> do we fix this?
> FWIW I've been getting inexplicable boot-time crashes that sometimes
> spew out a fraction of a log line like:
> 
> [x.yyyyyyyy] addr.iommu
> 
> on some Qualcomm devices every now and then for quite some time..
> Not very common though. Might be this, might be something else..

Sounds likely to all be the same thing as here:

https://lore.kernel.org/linux-iommu/1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com/

The true solution is to pull the of_xlate step into iommu_probe_device() 
itself, which I'm working towards, and finally get rid of the horrible 
"replay" logic which causes no end of problems.

Thanks,
Robin.
