Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2A22A4D5;
	Fri, 29 Aug 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453460; cv=none; b=Nox2edtW1S1sM+RBLGdwPEyeOL+aFWmH42aiTtvauXEWn+vjHD+hkEyw10nT+1FlvTVJbuE+E/uvKo/bFElFRzJTkFCv0SqiT+3osxP1z4jD+W2bO6Umv1SDzjOwCaYpqq3Vphg8uz06l/KzX7tEgU26nIf8Ix3KEB3C0OA7QPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453460; c=relaxed/simple;
	bh=nMvebug/8aKBzyMnj8cDMWfLOrd+I+pKXhPg7EME4vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixe9r4gXh+vfqpcyrSEeI1ffILq3o57GYxzD7pNu6rRiHPG+KjsluG52YPxv1biY0O8azstvF+kdJJnHxaPmy2P2zQ33+hsyogNPVYBDpEdqDI0jBTFxtNbDTH/pKBlNDkdLcbv7DBCW8jNawBTMZvVZRFisFQHizH1blYI+M84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjx01uYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjx01uYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD31C4CEF4;
	Fri, 29 Aug 2025 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453459;
	bh=nMvebug/8aKBzyMnj8cDMWfLOrd+I+pKXhPg7EME4vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vjx01uYhuY7ysGvUDRQnccZcPl1S2rnoL2GRt9uHIO8R8kBXUw0FyO89wrumtXRc3
	 HKLiCsdUwk/ySu0HZmC5szGw0LM2IbgEJenbi6sZPYs849o6Uofxz08WaaX7HCFvjd
	 bcVyOUh7V3l+Q9aGKCgx5HmRT9STMjOQWWpuevJ+/4VwyUjhAemwLYexIbCnukSF53
	 6R0pDMb5Xa9r3jrqSNxbSDx0pAPeo1NFhpk8bJ4jLbGwW4hpjyArBL2rsKeI4NEzHd
	 cjDe6e9ZLyOqhbDhZ0I8emtbZM0pIOR5OipJLOzFB/mEYAObMWZB7dCXRiGkTNsUWg
	 qavyfN+q8lO3A==
Message-ID: <aeef4f20-03c6-42a7-aac0-e385419a05f3@kernel.org>
Date: Fri, 29 Aug 2025 09:44:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
 <20250820222044.GA1513864-robh@kernel.org>
 <3147ebf4-054c-4777-811f-86d0ad14caf6@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <3147ebf4-054c-4777-811f-86d0ad14caf6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 15:20, Krzysztof Kozlowski wrote:
> 
> What commit fails to explain (folks, please fix that) is that device is
> incompatible with existing ones. Right?

I've already applied this [1] but I can still rebase and change the 
commit message to "Add apple,t8015-sart for SARTv0 found on the Apple 
A11 SoC, which uses a different MMIO layout and is thus incompatible 
with the previously described versions".


Sven


[1] 
https://lore.kernel.org/all/175593408419.53541.12520438370584715457.b4-ty@kernel.org/

