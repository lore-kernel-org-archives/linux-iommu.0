Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960427FD49;
	Thu, 27 Nov 2025 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229750; cv=none; b=N6gCE/VhkgQgDnX6UVZgdENPmLFFxylHwJ/I+eTB/chIAZsPx4p5UAIEPfBVvgpB3q7SbDGj0f5i7bnX5ezomdJvbOx/IOMJ/Tx4C8PGQS6O14xKyb3kGfbLXx1u05TIXHlxmUj5qRhA6VohkbyiBJLMfKYzUUC9g9WwwnyeXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229750; c=relaxed/simple;
	bh=xCHxcpEIdv+cYmEpWP1sxWzNhSIiDpBmJZwuNZkMZtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsJzAQLSEOCJRjXVEDrmlye7tRmyHWOh4KNnHSTJKcs4QCTA57/OIJjp4YnFciSG2AWeW0jZdA2g9O4S864KqKX7xrBt+ohd30x2vS8Sj2GLjEq6ppy/7v7BVlGfds/pL+TRh3cz/iCMHFeuwi5cROz4W2ZEA5fZPmVpWanFAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQwfqP/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQwfqP/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF33C4CEF8;
	Thu, 27 Nov 2025 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764229749;
	bh=xCHxcpEIdv+cYmEpWP1sxWzNhSIiDpBmJZwuNZkMZtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQwfqP/QVZii9l8ecWYPqL+DhTc2gEZKdzPKZe3sPat/h7wPoswC6nqt25oEbfI6X
	 AJ9VlIQp7MkXckUpVg5sf4thLKbOR7D3ncXL+cVNTd+jA8GfsXMxp3q6k0kLGeGKBq
	 wZc50SuOI2+9aJI4j7aHrVGZWcKj1uAMfWyTlw8AL3zaR++iE5651KdiynSbupz92T
	 HrG6MpTWaGD8bmDZWJgP0HebESgwtDG8TVq9izwQYCdI8EEIKH1ECFhPfOZPFmPsNG
	 mnZcOker27snb9SaAQYHemgr/fRGAD9Eehoxe5gVmiSoZ33k9LM03qHOMYL2vYP4eH
	 Qw8fNHFSpnFmQ==
Date: Thu, 27 Nov 2025 08:49:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: rockchip: Add support for
 multiple interface clocks
Message-ID: <20251127-enigmatic-faithful-viper-baefa2@kuoka>
References: <20251126083345.88-1-kernel@airkyi.com>
 <20251126083345.88-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126083345.88-2-kernel@airkyi.com>

On Wed, Nov 26, 2025 at 04:33:44PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The iommu found on RK3576 NPU/RKVDEC may contains more than one
> interface clock.

So you need to restrict this per each variant. See writign schema doc in
DT dir.

Best regards,
Krzysztof

