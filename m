Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF693570B4
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523619; cv=none; b=gpY69ZnqQ0fJPKBV4aBGjh7dg48zDfpysiz6yOYfHq4/AzWGA9AOi9BvPqYDIRfFZTWkWZ4q63wUjJ7PsYO1NrfERVyVbV+n0bf7lxWb+9TFmoFZpG9acqq57HLfnWdwvAFzSut7LoPojgMwrWQ9B7q6vC9vJ3IESqowih1nuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523619; c=relaxed/simple;
	bh=3dbkaF5OVhRQfnw/0d9n1Gzk+2qa9elwJ9BhiZVnO/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vy47uylEoJqMDTD/+QfIbwzUJtCjxozNVyxGLkC5K+gczOswtoc4pLJDTjSKhc07AxuADGSLMvYh6av1NQV3aDAvSVxqEw7Dz+69jApbCIlYCGZfVNo81zCGTqgbY54F7dB0T3b1g4EownHYFzC7qrNEoxSNwjxGs7GJsIGVXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C522F1595;
	Tue, 27 Jan 2026 06:20:10 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1BF3F73F;
	Tue, 27 Jan 2026 06:20:13 -0800 (PST)
Message-ID: <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
Date: Tue, 27 Jan 2026 14:20:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] of/iommu: add multi-map support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
 Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
 <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-27 11:45 am, Dmitry Baryshkov wrote:
> On Mon, Jan 26, 2026 at 05:55:46PM +0530, Vikash Garodia wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> When multiple mappings are present for an input id, linux matches just
>> the first one. There is a usecase[1] where all the mappings are to be
>> maintained in parallel for an iommu-map entry of a same input id.
> 
> This contradicts the IOMMU idealogy (at least as far as I understood it
> fom the maintainers): the device (driver) doesn't control which IOMMUs
> are getting used. Instead _all_ defined entries should get used. For
> iommu-map it means that if the map defines several entries for a single
> function, then all entries should always get mapped.

Indeed there is no concept of "multi-map" - if a single input ID 
represents more than one thing then that notion of "input ID" is 
fundamentally wrong. A single *device* may have multiple IDs, as in the 
case of PCI bridge aliasing, but in that case there are multiple things 
to map.

Thanks,
Robin.
