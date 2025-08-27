Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54227218ADD;
	Wed, 27 Aug 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310200; cv=none; b=TsNWnVpDp0TvU51NMZch9L+lkEQrGi5HLBOedWpK6yA97lgKEe0bl9IlUVUhbS94ZlLydT6dRaurp/iut/Cy7xEghqjwlLZ05VrGjMByLJTFzk7RutjvSkapMNPFT43tS9TRTVYQCan8Rh0sAIT7hanpWr/fCsSk102jYvRNo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310200; c=relaxed/simple;
	bh=ziop8ByzeP3o/TkE8zYyoxz54jgtYl6UGalrslsR+Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1k6TzJiDXNPfStGlFDQJ5nmQUEXhLRTDJW37Q/bQekz4cCpRuWiUyoMEEEOSyWrcGXUBkBHVJxBmkjPikWke/Mm2KyolN/Io85OYLfdi4oDGySt8tfLZkwOSfvN+SkHHCTO2pD4pwdGmi9h+OtrxTYKwU/8UFVscp9/rWliLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7B4H2l1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7B4H2l1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D2C4CEEB;
	Wed, 27 Aug 2025 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310199;
	bh=ziop8ByzeP3o/TkE8zYyoxz54jgtYl6UGalrslsR+Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u7B4H2l1ccA+a6oBnVc0pqC9CMtUhz8m3wz7OB4PtcTdzBGzdGjBE/InkWWODNl7B
	 D6Q7dn8aiVnb7zNZbDh70IJObDZp9ggWwybDjVDB6AvKqQm+zkd5foCjrhUkKSG3IA
	 Ahf42c7zABg+lhaW1+TFpk+wJmGlUNpEPOUDtfdGkgzyUHbLoREUzxzlLOkIHwOZ7D
	 Rlys2izNtCTsyI9sAJPvRQAogj2N7t/WEJH6yXPFjx3Amqsm93rvRKLA1hJVj6/Ox8
	 qRDAzEQNquR1KXFAl3NsqVkvy4uMokYpIGYTnfe6lAiYK4qq6w7y8Bmc0kk8FKk2Ak
	 oHvO+Ha3Yabnw==
Message-ID: <89251134-9685-439e-b220-92717663f038@kernel.org>
Date: Wed, 27 Aug 2025 17:56:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
To: Christoph Hellwig <hch@lst.de>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
 <20250825080710.GA23193@lst.de>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250825080710.GA23193@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 10:07, Christoph Hellwig wrote:
> On Thu, Aug 21, 2025 at 11:56:44PM +0800, Nick Chan wrote:
>> +		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),
> 
> One long line left here.
> 
> Otherwise this looks fine to me.
> 
> Do you want to merge this through the apple SOC tree?  If so:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> 

I don't think that's necessary since there are no build time 
dependencies but if you want to I can take it through there.



Sven

