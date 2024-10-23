Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8A12C475;
	Wed, 23 Oct 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671931; cv=none; b=f7Z7GcAfH1Wm4+NxI0Uy42M+bC0XQMsCzbICG5XtP6Ua71xMqWHtKPYrUtu8O7/p3EZa6D5iyQes4s9zKA8wnTtx/Lv7S3wsW6rWZg5PLIWCCa4S+YP1zEqEb60Uowk4ZWdgjp/k0M2J4T4YKu2P9JjZ2vL1aVMnaeJXryRi138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671931; c=relaxed/simple;
	bh=XzVfo+yGb5qyhp8c3EGJOmQk0WqCkhFLW1iQ50gHA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNZDsP7NdvD1PZJZnmrXNJ0BWvAHpTEMHgzUwlIYsXwA9wf0DZL/Q1GpeHYIKeqGLsEMxS+wo810qLsEt6CRTC0Md/u38OMhSw+87Ho/rQsz0RItPGy6gqF5oGWwaBpkrDwP9B0AdSV6bcTsJw6UqL36sZPxznONVAekQjQ3Xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdn7tXZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdn7tXZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A4DC4CEC6;
	Wed, 23 Oct 2024 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671931;
	bh=XzVfo+yGb5qyhp8c3EGJOmQk0WqCkhFLW1iQ50gHA3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hdn7tXZTllRMvFASo/RBclPnxYNsKqqCv6abJXKt9fwPsVkEq5BFEkR3qJSllxQVu
	 UG6zTeQ+18TCx++vN0Dw1zlMEItXB7jppaCugJ+y0bTkXtlyWepbqcpcOYojURi4ED
	 U5R7O9PBjtRlsgDM/4StfUwnR+Iq7lpDYPrCKdfl46D/27GdA2J8MPzEALctNBH/kw
	 OZPklSYlSRzioCPVdfNl096yRBUWd0q42Uvz60RfvroPICMATEx1IHdhFdzQIUwtow
	 0eHRyVyYwt7/HaReaT/9l59WMW9dmIxzfgB5q73O95M+7AVEbPTi8HFLNWk1nb0Ba5
	 dvwZN602tjgfQ==
Date: Wed, 23 Oct 2024 10:25:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document sm8750 SMMU
Message-ID: <tf7zt3ytxdzgeop2n5ard2kivbjtcqun5jahgqvejynj2ttyon@eg2yd4ulouw4>
References: <20241021230449.2632493-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230449.2632493-1-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:04:49PM -0700, Melody Olvera wrote:
> Document the sm8750 SMMU block.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

This is incomplete, what about clocks?

Best regards,
Krzysztof

