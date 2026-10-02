Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127204F93D9;
	Fri,  2 Oct 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959626; cv=none; b=jaWPBG7ONTQj43BpfaW4r0CiVyGAqDIO2JYjOLN/0uX6BbPf3vBIC0NTEh/c9bPkRK3Go4lzI0MfbxM4cNxi3MV8nen8SVwUJOcNCFZF9F/m7I58OgE7pEaQ2Je76Rfn3njaSn4ujtrmonBjrEPFdKJQEHJmj5SvhZz6+wqVwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959626; c=relaxed/simple;
	bh=2UjzcEdVWTRTCn9Xa5TWBJkmLNxYtjNOh5IkxKRPo9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7lvnzkZjslU5YA/s+baOHhNNS/1EEYD80wH6LZJfkDEhNPOOQ2z5UEVxRoU3OglLiiGUmV9ZuOFCaygWqxvVJdtTZPA5MI6YVzd5dLAiODFlQOmjqcvdhkhISKpFfYt8Hhnwi4O3Fvj8jSDrEZ/3DeXSUdjQwxYI9fXUr+YZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us4l3jQn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us4l3jQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912811F00898;
	Fri,  2 Oct 2026 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959624;
	bh=XvI5rA2BsHrApBR9QCfo5HYzpkgGUKmP3+iH/QCnwts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Us4l3jQnfMXzXUgE0mzhupmPL1OWdNmOIsauX73UiJG05fZUnIs/uldB+LCv9BpE+
	 3k8r6TjA5cJSWl4NJNP7i/XN9qhp4iMbVjgWBFSPVr34fDxzZAGkugx0hJVIyn60Wp
	 u9gIF3125QSFvCczjMsq6vV9dz8I0KwFum5ga2B8/VpQ3K/aIMBtjLiuFtcPQeFkWy
	 t/ooZBVLQ7seWXpKdmUUpgAQjrEXP01+pv6r97/3tTfQpDil+IE6Lfsq99FrXKwZg0
	 yuP4AVY1R6vyEyVJBm0DBbsXfqkti7g0TNF9rb2tCqMkCey7YTkVdoVRqvhIgP4ObN
	 CQVN8VFJm/LZw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	jyescas@google.com
Subject: Re: [PATCH v2 0/2] Add arm-smmu-v3 support for Laguna SMMU silicon erratum workaround
Date: Fri,  2 Oct 2026 17:46:39 +0100
Message-ID: <179095473404.2069316.15351395567657253108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 21:21:04 +0000, Peter Griffin wrote:
> The Google Tensor G5 SoC (Laguna) has a silicon erratum with the SMMU
> integration where the AxPROT[2] signal is always 1, which makes all
> transactions appear as instructions.
> 
> As a software workaround we make use of the INSTCFG override feature to
> force all incoming traffic to data.
> 
> [...]

Applied second patch to iommu (arm/smmu/updates), thanks!

[2/2] iommu/arm-smmu-v3: Add support for arm,instdata-override DT property
      https://git.kernel.org/iommu/c/937bbba25930

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
