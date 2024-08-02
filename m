Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630A1DAC6C
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599585; cv=none; b=jJee8CHz9Lwlg72ya+kVMo5UgSgdr+MtghJoW7xP/FG2avW0/g04a40WYx4sW/BcvvqCNTrtzBA1TJODlA3Tj/faKTMG2HlraT0u78HB12kIoVUQxsI5NHNAZLtxn17wdMaC71jIRtXZ5qRYVXSfhG9yJZQEY8J4cA+riBdHgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599585; c=relaxed/simple;
	bh=VtrIb/aM40OrfdoFkua0eNuGrPU3kuqPoVMYQQrQhaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkzXvGPvL1q3UeRhGZ/WmjjncZHHO9QyE6Pq4HWOeHUukeY4+x9JUqdNhWdYwkdKqKwhsdiZ8qDuV6w7Q/gR4jcvbnUtVQyO/KW1tLPAH9zmZw86ra6KUGiYJdc3UF6PmCNDEyoNCIHfAHCMVmSrd7GF1FkqizHRWPTw1hh6vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13EE01007;
	Fri,  2 Aug 2024 04:53:29 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F6F3F64C;
	Fri,  2 Aug 2024 04:53:02 -0700 (PDT)
Message-ID: <a1a07edf-9ab2-4121-a230-0d06bda3bf3d@arm.com>
Date: Fri, 2 Aug 2024 12:53:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-mapping: don't return errors from
 dma_set_seg_boundary
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240723000604.241443-1-hch@lst.de>
 <CGME20240723000611eucas1p10986fd51e848a1ee948e71608c26192b@eucas1p1.samsung.com>
 <20240723000604.241443-3-hch@lst.de>
 <5895603b-945f-4b05-991c-76b590094354@samsung.com>
 <d54f486d-36ae-4668-b314-27137bc4d832@arm.com> <20240801133353.GA1846@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240801133353.GA1846@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 2:33 pm, Christoph Hellwig wrote:
> On Thu, Aug 01, 2024 at 01:36:01PM +0100, Robin Murphy wrote:
>> I guess I assumed that the old block layer bodges in this area had been
>> cleaned up already - perhaps it *is* high time for whatever's left to grow
>> a proper understanding of whether a block device actually does its own DMA
>> or not.
> 
> Can you point to a discussion on that?  The concepts here don't make
> quite sense to me.

No specific discussion, I just have a vague memory of hacks in the USB 
layer when I first started looking at this stuff 10 years ago... From a 
bit of digging to try to remind myself, I'm fairly sure that must have 
been the block bounce related stuff, which you cleaned up in 
6eb0233ec2d0 ("usb: don't inherity DMA properties for USB devices") a 
while back.

Cheers,
Robin.
