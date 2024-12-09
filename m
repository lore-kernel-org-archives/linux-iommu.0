Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D2217F45
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741395; cv=none; b=AwQreg9uBzyqVXw0RxXe2rzW16Iyid7x1dV/XgKL3C+17ZTT/FydeDj83Kg3kvcCrfwQdGtYBVToYrZbSyXGh6DAK8Q2jFn8jsguQ9bGj4KcsqbytkRxURGJQZN2/wAgjE59r+yjrkQnc6nfoUi2dNNdKsB1eshElmmTTk+3aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741395; c=relaxed/simple;
	bh=qDYE6sm06wT5iAye49l+JIErayXfaHy2n7nmUt4z920=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3S7pb+Y0tLr5zEK11wcG4ezabzldy078Vns/x5lloNqKG+ZDWOsELjGdlECWuuqGPMlcX5dsf9v0lh5MXkfQIpNODL4pJ2lujNAiryC64e4I18xI8pW3TzoBBhlXKRBozLeplgjzwH2usq/aUJjvCskzyu835Uhb30Q5upwaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23CE0113E;
	Mon,  9 Dec 2024 02:50:20 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C9D3F5A1;
	Mon,  9 Dec 2024 02:49:51 -0800 (PST)
Message-ID: <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
Date: Mon, 9 Dec 2024 10:49:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Christoph Hellwig <hch@lst.de>, Tim Harvey <tharvey@gateworks.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com>
 <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com>
 <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241209081714.GA25363@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2024 8:17 am, Christoph Hellwig wrote:
> I scrolled three pages before giving up as it was just quotes over
> quotas.  Can you please write an email that contains whatever you're
> trying to tell instead of just quotes?  Same for the person replying.

TBH I'm hesitant to look too closely since everything those Atheros WiFi 
drivers do with DMA tends to be sketchy, but from what I could make out 
from skimming until I also gave up, I think it might be an attempt to 
reinvent dma_alloc_pages(), or possibly dma_alloc_noncoherent().

Cheers,
Robin.
