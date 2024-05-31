Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD31422D7;
	Fri, 31 May 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148748; cv=none; b=fQrQV9pxLwQuflVtWZX3FXjO+NFd3qkwaRGbfFXbZi2Njvzd5G68LamAxURiHk267buArx9Au3ifzEKjzz1cNEQBv+LZuetOxd3eMn71ug2NJmCg4zz9tV2L57rZxUq24TEeGSgRaHr2Pc83lXUxolSDdVTyRJHS5HKJp+Mvq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148748; c=relaxed/simple;
	bh=2o+jR85lZr2GiKnZ8cEbswaeoXH7Lg7Ye9H1XscrZWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkeBRjjdbJBYrm/qZbfSfHC8DSIaOmPyFGkQbZAJ8zjQTYhDh+myZiZHSnAmqCxT9/DJz/rL8pctWpUuVwhRB+wOxFI8EW4Rsdrnnhqcv2ppCDFXzRoaFJD1yAfXUp8+fQMy7d3CdPMw7eZd5rmkqBk1U+gJmSsd21ZqhyqCypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4B71424;
	Fri, 31 May 2024 02:46:09 -0700 (PDT)
Received: from [10.57.67.251] (unknown [10.57.67.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B9C93F641;
	Fri, 31 May 2024 02:45:43 -0700 (PDT)
Message-ID: <adb96c77-fc8b-4be1-b2f7-0a321b7ad593@arm.com>
Date: Fri, 31 May 2024 10:45:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: h616: add IOMMU node
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240530233800.27705-1-andre.przywara@arm.com>
 <20240530233800.27705-6-andre.przywara@arm.com>
 <bc550e12-7ad6-4592-994d-dca5a95e88ca@arm.com>
 <20240531103209.7db573c8@donnerap.manchester.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240531103209.7db573c8@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-31 10:32 am, Andre Przywara wrote:
> On Fri, 31 May 2024 09:42:36 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
> Hi Robin,
> 
>> On 2024-05-31 12:38 am, Andre Przywara wrote:
>>> The Allwinner H616 contains a scatter-gather IOMMU connected to some
>>> video related devices. It's almost compatible to the one used in the H6,
>>> though with minor incompatibilities.
>>>
>>> Add the DT node describing its resources, so that devices like the video
>>> or display engine can connect to it.
>>
>> Without also describing those connections, though, having this node
>> enabled in the DT means the driver will just bind, block DMA, and
>> prevent those devices from working. That's probably not what you want.
> 
> The IOMMU manages the Display Engine (DE), the Deinterlacer (DI), the
> video engine (VE) and the 2D acceleration engine (G2D).
> None of those devices are supported for the H616 in mainline yet, but there
> are patches out there for the DE and VE, at least. Especially the video
> codecs benefit from scatter-gather, so with this patch they can make use
> of it from day one.

Oh, I see - I assumed that stuff like display was more exciting and 
likely to be supported already, so read "can connect to it" in the 
present tense. If it's a future "can use it as soon as they are also 
supported", then there's no concern, and indeed this is arguably the 
ideal order of doing things.

Cheers,
Robin.
