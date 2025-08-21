Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B22E1EE8;
	Thu, 21 Aug 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791235; cv=none; b=Z4N39hKcOEVYoTow5tmhhllmPlrsGDSjc+UqrAGt2NwS/p5Sz6TyZ8CLazACPrZm6yzl+WOkmwBTqNHzxM0mhEQrs6FUD1fLnQYkJBEvjwstyxU8QByo9/PwcuAWhhHXF6ga3IeMytRlHshzZjWcjGfjXeMeUJk8eqWsHC8mKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791235; c=relaxed/simple;
	bh=uNxeyEwJIeMK7I5aTTxuR+vdsb3qwZbdDF0YXJk1RIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+cyA+x7zxX0dUAoIUz9BdOk0PKePoBvc7U11wu/9X5ZVFeoT0n8yVgzVwGeHi+xKlipMdU8M0tML32iPdEqI7mQPWS9Qje3y4PSZ39h0Zwl8zm4itPCg1raldf3L0jGgTiupQU3qzUBmMruI6LDtFvEUa/9uZE20FHyDz6In3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN8zKzgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN8zKzgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE6C4CEEB;
	Thu, 21 Aug 2025 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791234;
	bh=uNxeyEwJIeMK7I5aTTxuR+vdsb3qwZbdDF0YXJk1RIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rN8zKzgp4yY1voOqoROdgerZ9G1i2qnm8LvSCvoQbREV5fiFUUrdfSQkijzzZGK9K
	 eMx1VUkbCT6icHNGU1CVRx5uGfJ+Iwnfpu5LnF1xjCME9tKu/3wfPRqQ4Ur/0TQOsG
	 dJS/PEnPlooiO14dYeLvg+q7qWkKgQP0ONkxHEXXGQqoNH7dZ2ZIzpp8x78sJAWOaL
	 KhotH3qDPY6GfKflqOx8R3E2exeA3E9MYrPN+gptA1NitmvK2YfhXPeFhbl9BofOGM
	 q0xVbTLowkKIgvdm7Vq4UojAJm7TKObMCqsVvnDKRKn/8RDcOkJeh/36HcKAv+hQOs
	 H0DH/GKS46kOQ==
Message-ID: <54aacd00-8c18-4dfb-a1fa-d600eb9733a4@kernel.org>
Date: Thu, 21 Aug 2025 17:47:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
 <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
 <8279536d-c4f4-477a-9823-3e7b452c3c33@kernel.org>
 <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.08.25 15:09, Krzysztof Kozlowski wrote:
> On 21/08/2025 12:25, Sven Peter wrote:
>> 2) We keep using the ones that are already upstream and just accept that
>> the situation is a mess and add comment above all the bindings that we
>> messed up and that this should not be used as pattern.
>> In this case that means it'll just be "apple,t8015-nvme-ans2" for A11
>> without any fallback and we keep everything else the way it is.
>>
>> I prefer option (2) but if you really want to get rid of all this mess
> 
> 
> I also prefer option (2). That's the least disruptive option for users
> and inconsistency in bindings naming is just inconsistency, no big deal.
> You just need to remember not to grow the old items/pattern with generic
> compatible.

Okay, thanks. I'll make sure we keep those old items/patterns frozen and 
essentially start over for any new hardware.


Best,


Sven


