Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0919DF78
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345204; cv=none; b=UFEI3xq5IlePRI/Ty3TezVlY8jOEgNSsSd2cdvO0+/36slrfb0Rmcb7Pw/VpE8DfgeLVeAhwDi26QtrITz8kLgfRztZ2ig1XwWKy0tDb0KgFfTdZulyHal3bgmNYtvQiSikw6JzGMiKQHp5su7pOc/OYEuK9TMJzeEsttDnGFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345204; c=relaxed/simple;
	bh=VISTxJp2mQkG0SJltq7xzPM+sRU0rmhMu+cq1srTJyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj98W1jFF1rKXd7+qFSLP5Ffhg2VuMl0AbA5HhLK3W4Me7oFr/cUBixIJyZqKeuA/i/4ct9kdXrwAkzNpGo/PtrOhVu3KDRm2clSH161CDtJ3vylHLiM5qadBTqp+0rSvk0WmdRLZxzMWcAuSIaXoHNmrmZtdFxTwUef7lNfRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D45E1007;
	Tue, 30 Jul 2024 06:13:46 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEBD23F5A1;
	Tue, 30 Jul 2024 06:13:19 -0700 (PDT)
Message-ID: <a86ca03d-13ab-4304-879d-ac4cbacabfa5@arm.com>
Date: Tue, 30 Jul 2024 14:13:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask}
 return value
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240723000604.241443-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240723000604.241443-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2024 1:05 am, Christoph Hellwig wrote:
> Hi all,
> 
> the above three functions can only return errors if the bus code failed
> to allocate the dma_parms structure, which is a grave error that won't
> get us far.  Thus remove the pointless return values, that so far have
> fortunately been mostly ignored, but which the cleanup brigade now wants
> to check for for no good reason.
> 
> I'd love to get this in after -rc1 so that we can catch any of those
> cleanups that might be queued up for this merge window.

Indeed, I think this is long overdue ever since the responsibility for 
dma_parms was moved from these callers into bus code. For the series,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
