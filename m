Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2826C39B
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260933; cv=none; b=iRmuuYkB9HaBMNs9z3AQ1iO8eXQ/pREe/BXLTaQugRwK3C5nXuWwoal9Yr59cqnjukjBD9sE3N8RBxsJOE3lTKsb4s2JE/Bm9Ki+R0pPKlPsjna0eAszDJIP5RVApNv4rYs63vKLAypFRkKvVTt0WESd/NZEcHler7FZLc+Fa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260933; c=relaxed/simple;
	bh=yGinWHDhWv3xQXAuhKOdI7aDvkam4iuHFZpxHNnvJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvzA296lugCAAiX63Mh2GHSRPkrc32GdagY0xKWRVGZoDbqiUqAS2suD8BgvXZW8o1Ql/D6U6Z3irQAPwuWMNDYtwWAth2Z2RygXSBD9kNIOLh+IdRYbKKsDEGanreUMlAvPMPc28kdT5d7Y27UlwNKe+CymQ2FYGDWOOKR8MxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A26E1424;
	Tue, 30 Sep 2025 12:35:22 -0700 (PDT)
Received: from [10.57.2.207] (unknown [10.57.2.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46C613F5A1;
	Tue, 30 Sep 2025 12:35:07 -0700 (PDT)
Message-ID: <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
Date: Tue, 30 Sep 2025 20:35:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] iommu: fix device leaks
To: Jason Gunthorpe <jgg@ziepe.ca>, Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250930182158.GS2695987@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-30 7:21 pm, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
>> This series fixes device leaks in the iommu drivers, which pretty
>> consistently failed to drop the reference taken by
>> of_find_device_by_node() when looking up iommu platform devices.
> 
> Yes, they are mis-designed in many ways :\

Historically they weren't really leaks either, just spare references on 
a device which at that point could definitely never go away. I suppose 
now that we finally have the .of_xlate calls in IOMMU registration, it 
would be possible for some error during probe to cause the IOMMU driver 
to fail to bind, at which point the references could rightly be 
considered leaked, however these are all embedded platforms with 
essentially zero chance of platform device hotplug, especially not of 
IOMMU devices, so realistically those references still don't matter to 
anything other than code checkers.

In summary; meh.
> IDK if it is worth fixing like this, or if more effort should be put
> to make the drivers use of_xlate properly - the arm smmu drivers show
> the only way to use it..

The SMMU drivers are really doing the same thing, they just defer that 
lookup operation to .probe_device time (largely for historical reasons, 
I think), and they use bus_find_device_by_node() rather than the 
specific of_ version since they support ACPI too. And they do happen to 
include the put_device(), since apparently I was paying full attention 
that day.

> But if staying like this then maybe add a little helper?
> 
> void *iommu_xlate_to_iommu_drvdata(const struct of_phandle_args *args);
> 
> Put the whole racy of_find_device_by_node / put_device /
> platform_get_drvdata sequence is in one tidy function.. With
> documentation it is not safe don't use it in new code?

It's not racy; if we're calling the .of_xlate op (or really any op for 
that matter), it's because an IOMMU driver has registered (or is 
registering) for the given fwnode, which means it is bound to the 
corresponding struct device. Thus as above, in that context said struct 
device, nor said IOMMU driver's drvdata, ain't goin' nowhere.

Thanks,
Robin.
