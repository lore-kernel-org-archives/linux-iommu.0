Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2953BE154;
	Thu, 16 Jul 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187607; cv=none; b=VeZG26MrPp1T5zsmJ6GNlwS7KRMZ0Ky0T/oCSQiEMSKRsjdyk/afT7GVH/ZaFVvqK7ynu2sSEXZigMQVWy5lf5n3WByyn7ER7OV5dvvh+7p5OYe1f/VJTfEnbe3ClFV/TnpRmfKSNkeHuRRy0Rtids/Uc6vJPqzzXVHce8aLa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187607; c=relaxed/simple;
	bh=KXlVTc3SRCvXiKLZmQ8/NCRXmu7FBjsJG2tFz0DMl/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qii1btmMNpwxH4HfR49bH2BH5TFItpE7XKIbF0QoYx+Y7szIv9+Bhs31eG3gtr+Rf5m3HHr9OzAegikczQ++uvxk+jPrMQa0UCfr0PGoeDhtSy6kYX92EjcHJ45mxrE+pD9qP4oSFFO/hQg118BXiPuSP4zm2fbflLqSt3rZHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3m6LlMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3m6LlMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F80E1F000E9;
	Thu, 16 Jul 2026 07:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187603;
	bh=dojcUCCxlLBrqpQJPv4c8YU3OBh/MSH4vqKe8+qyO8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U3m6LlMdue8PsJAdVgF57knst0IDMQwv96C041zLDkTI4/QWZxs0OOx/K84ByTf0/
	 VBb+gEPGRBwdeFHvNDv11E6tQyO8pbmqhy+DHfxQjKIC6jCBmS5ldwWlnimQUhpHE7
	 K2CBh0uknPZ8ush5uy97zeqfZkUGB2nQ6ESn9Uf1WFOxJcCeZ2yYTZeIs6/DjLTlo+
	 C+0AeJIGCCutlT7Fr8dxHY7TWX7SmBVQX42817Vj65gDYFZLxJQen4uk6CXCjEmNx8
	 Gf5+CogGuXzY1bOD/I8LSDUdEpSA6Et/qjQpQ5EzXneutfIQctevmKvKg/UVL+cQUq
	 8+3x1bHj1Vb8A==
Date: Thu, 16 Jul 2026 09:40:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v9 01/14] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <20260716-soft-dexterous-adder-badb49@quoll>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>

On Wed, Jul 15, 2026 at 07:39:55PM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> The current maxItems constraints for clocks and power-domains in the
> common venus schema were sized for platforms available at the time of
> authoring. The glymur platform introduces a dual core architecture
> that requires more clocks and power domains, exceeding these limits.
> Raise maxItems for clocks, clock-names, power-domains and
> power-domain-names to accommodate the glymur platform.
> The glymur platform-specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

You must drop the tag, you changed the binding significantly without any
doubts.

Best regards,
Krzysztof

