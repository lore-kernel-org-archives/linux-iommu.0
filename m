Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06101390986;
	Thu, 24 Sep 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260913; cv=none; b=KqXz5li3sUO8sFNA38/M5+qxoDa9BE+UXLnqLNOQqpARMUeIT9hI3cnb6vqVDwW03SAXWOefJHFkXGvjsfhatfA8pgGjuHOxWbM+xPrhNFTgl0rJ1tBlR4IxYXYJrgqsMzRdrgnYhhQ8XymvBottmicqXq/BP5GLaixvIm63KR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260913; c=relaxed/simple;
	bh=olyggtUT4XkAWHwOtAXhMyGXgXLXLeCvpeud3+HAERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnMM9CnAiuBfpkdqcbyMdByOqJ6aKyZkPrb1EtsfofcGBLhZAAvWynmJkHpagYtRCOp7xgarGs2Kibf3958hY4WSanEn+Zyj0LUrsVs/SIM+kkE4+ABfIPLSc74TZkEB4gOs6rWCDt3xtXgxM3DCEnFf6MuVfGFFDl7Fn0Ei9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW6HS8oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW6HS8oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6565B1F000FF;
	Thu, 24 Sep 2026 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260911;
	bh=30DeOh+RnQi89KzPRmHL/URm5M418Bb8r3J5IBl0ccI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OW6HS8oq/AQEtS9bWj0ywrQlOIUwBmu9ekGyt/JPgBWsXHjad3uvtFWd7otpv8+xe
	 XjMDc9xNMMduBEWnEzvt0SHEPH+KYstaZc8wdHb0n5v4y7MEJw8aETEANnCr36gwT4
	 da82wBykF2k54yu0q7YmKOxz18QudTT8oSd68oA+37Z6wDdkNRSX6xs/5UC/ox31fq
	 AxZQybVBkEDFMP1XHBEbnFkqBUgCgt13LThBF3IL6nVnS1HlZpGl7xYz8cXb7rbguL
	 hjVIUm/eoMbla2Lk9CuLA0jNcQtPQFOzF1bXliHXATIHJvVJjf3sdyDr/FiYSHD9FZ
	 6HBMmHa+4n50g==
Date: Thu, 24 Sep 2026 09:41:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, linux-kernel@vger.kernel.org,
	willmcvicker@google.com, tudor.ambarus@linaro.org,
	Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev,
	kernel-team@android.com, andre.draszik@linaro.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will Deacon <will@kernel.org>, jyescas@google.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu-v3: Add
 arm,instdata-override property
Message-ID: <179026090862.4166237.2751536786551835786.robh@kernel.org>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
 <20260911-arm-smmu-v3-instcfg-override-v2-1-5804e4f400b5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-1-5804e4f400b5@linaro.org>


On Fri, 11 Sep 2026 21:21:05 +0000, Peter Griffin wrote:
> arm,instdata-override DT property is intended to be used for SMMUs that
> have a silicon integration issue with the AxPROT[2] signal always being 1
> making all transactions appear as instructions.
> 
> Google Tensor G5 (Laguna) is an example of an SoC with this silicon
> erratum. The DT property can be specified to enable a software
> workaround which overrides the incoming attribute to data.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

