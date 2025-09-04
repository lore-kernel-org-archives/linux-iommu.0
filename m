Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2083AC1C;
	Thu,  4 Sep 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014240; cv=none; b=G37fq7Muoed5RkS5VI5E5WtxK66UyK6QyDRiPbU8YVvyE/eKEJg3qiZdy1/R9erPqZR/iE20lVqQhn4ZPO6VHP0TceZHVepItgF1H3+yHg4cNlL996tAcrCxmGYhJeTb+qtGpLNoJMfqsfjw23b1hDR8dYWMygv3yKSW8KCvsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014240; c=relaxed/simple;
	bh=0RZ8CnMwf4NqKb6arTE1y1641ehql4WXMwOOTJDdIbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8x/IUExnLPPTcRp9eG0eZPCVfQJMu2xJrTDH16m4VgLzOLL7yCwgekusYKDfAjY4lQgb1Iploo8U1JJt/mEIWSMVpNR670Wd9HF19Et76CxGFOcJKPXnGTwx4Kjnut+2BHV3m774LjI5AOEwDJOYdWtNorsThmUHe79lL8mwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqU9NY0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqU9NY0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909FDC4CEF6;
	Thu,  4 Sep 2025 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014240;
	bh=0RZ8CnMwf4NqKb6arTE1y1641ehql4WXMwOOTJDdIbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqU9NY0f4OsloxJ8hrjbay3uVxPdDfrJdhw+yQhou50Mf8usGqoTPhJTDxoNZp+w6
	 eu6nxigNZ8yXtk74xrcMlP3GhpB2hvBpxU8ah4yk5t3JX8Lb1vFpRH7YwijLTSgbWz
	 qa9mBqjd3NaDpDjXFuhgVL3ZcMFKlqGV8sDgsAaqf5VbqGYVLBnMpIt1xy+iFdzoOR
	 gNmUrbAa7u2A5P+g9AScjho9KWkTUaNgRl2ZBG1zaws8KKSV6BH1t5vhbS0CK2T0zA
	 ywZqzYHxLFtRwnoZ7Dz4d747xiS8+AL/sRcm6VTWQeX0uaJ4oW2rz2DMJ+YwSutGZT
	 wOMJINbdy8Rbw==
Message-ID: <5b02ef9e-3017-400a-826c-59b5d5770a44@kernel.org>
Date: Thu, 4 Sep 2025 21:30:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
To: Janne Grunau <j@jannau.net>, Christoph Hellwig <hch@lst.de>
Cc: Nick Chan <towinchenmi@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
 <89251134-9685-439e-b220-92717663f038@kernel.org>
 <20250902052646.GA11139@lst.de> <20250903095325.GA89417@robin.jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250903095325.GA89417@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 11:53, Janne Grunau wrote:
> On Tue, Sep 02, 2025 at 07:26:46AM +0200, Christoph Hellwig wrote:
>> On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
>>>> Do you want to merge this through the apple SOC tree?  If so:
>>>>
>>>> Acked-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>>
>>>
>>> I don't think that's necessary since there are no build time dependencies
>>> but if you want to I can take it through there.
>>
>> Merging it through nvme sounds fine as well, I just through up
>> grabbing everything together would be easier.  I also noticed there's
>> another Apple hw enablement series that touches nvme, so I guess both
>> should go through the same tree?
> 
> yes, they should go through the same tree if they go in the same cycle.
> They conflict in dt-bindings and possibly the driver. We should avoid
> burden someone else with this conflict resolution.

Good points, I'll pick up the latest version of this series on the 
weekend then and handle any conflicts in case the other one is ready for 
this cycle (which it probably will be) as well then.


Thanks,


Sven

