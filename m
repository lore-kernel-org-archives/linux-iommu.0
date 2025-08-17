Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C211AF4D5;
	Sun, 17 Aug 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427855; cv=none; b=W+Q8+gimPexX0LldqGavruhRpAVljE+Y0X4ebbVYFm83ebGDIXKGRrtsZw/DSdd03mWR6nKh+9zsC5pPqVxIoGjsny9q64tJ5cBGdJj9qc78yhQNfyfSVEHl1V+dOIs19jmepid5//b2lpCjwSU1ef1aaRrL5Xssvl/VIQiwYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427855; c=relaxed/simple;
	bh=jYq7d/KI9Fl7n0FN3697SqbIefUMAmBfpP+PbR+dS6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdPm6KFL2AdtfgZY7EVobC3wnH0f+dlC0/Ir1XmCRhrXELPPRLlFYDJWbdtremPKapbJkq4bNK/T+omAg0zrA9G5/zpkFKGUXILx0kJ8kWRCNY0hD0qpFqV5pOJ3GUa1Xl8VTwGeGQPJPLcH4bW8H5Me6T+Lol44Zu11ZlecTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOpxmImS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOpxmImS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1CAC4CEEB;
	Sun, 17 Aug 2025 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755427854;
	bh=jYq7d/KI9Fl7n0FN3697SqbIefUMAmBfpP+PbR+dS6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oOpxmImSwwHJZh3R1upYjow3eW8PAtsOA7LQdCIqDJTVHVgedpn9RuwIKhtL/48o3
	 QFTz4aMH1BRvbIt5iWZ7/eOYz2uUCFbR/ZOqRw79eMLPXXhwJ0uYzkBR1tmu6r06vF
	 7s8wK844/6Z9N2lrFISXUSiyXjeu9oKBe2nVud/8Ov6O/e0ojUkYH1Lm+XkxEe03ai
	 PkUYJRjFLKfrA5V9znZP7/bSpYnKpfz5wggXiTt2PRV0AKAgB/6e6jc/bgWApQjJP7
	 PLLuKXg9OgRc4DfcKTxVGY94iyBRq4rmBPRe3Yjs2KymcarqV0fswaiLJntCpYXqBd
	 XiFgAvFn7zk4Q==
Message-ID: <170403b9-f98b-435c-8403-d1b8c2db1244@kernel.org>
Date: Sun, 17 Aug 2025 12:50:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Will Deacon <will@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Neal Gompa <neal@gompa.dev>,
 Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-3-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-3-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 15:50, Nick Chan wrote:
> Add bindings for SARTv0 as found on Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>

