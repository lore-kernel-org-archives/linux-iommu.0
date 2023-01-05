Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060B7FD;
	Thu,  5 Jan 2023 05:19:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id D62C9425D6;
	Thu,  5 Jan 2023 05:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672895977; bh=DBNkKPLiFmCsOai0eLz6rBhEs0qbT7bO/x7ibCYBYPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=zHn7iLgCqBMr20WdN/Kx6nNWPZv43tDvT8UFeTKrXHxNbbwuBdPcs8Q0kGi+lYfQX
	 6y5W6359/O4ox/TS0pG++cSHZH7aynh6x/apobgwKVVqZU7/fIhOlG4j0iMa0hGD1r
	 KB9e2NttfGMjNr0Kh/dWk2LUtXXDyZvdi7ZuqTgFnUC5H3lp5S9m5L1KxyKjvnmDW8
	 LOaBMLZen50hgUwTfYgxs+moZKwflHdSYpJbpWOFt93L3JUXAmiRVidBsmJAGSHRuW
	 Vbzo0d+IM+TiJju0npZIWZbYYDDR33aHI0q8rUa1q3jiDfHppJwjBwrmXXIdVaJgZk
	 mWqi2pWEmY2tg==
Message-ID: <fd66fa48-8810-5b8b-c330-8456bdb9de9e@marcan.st>
Date: Thu, 5 Jan 2023 14:19:32 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] iommu: dart: Add t8110 DART support
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-8-marcan@marcan.st>
 <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/01/04 22:50, Sven Peter wrote:
> Do you have any more details on this registers? For the 8103 DART
> we called it _CONFIG but I assume for the t8110 DART it can
> actually lock different parts of the HW instead of just a global lock?

This is based on R's reverse engineering here:

https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/m1n1/hw/dart8110.py#L87

I don't think they ever fully nailed down exactly what the lock bit
behavior is, though.

- Hector
