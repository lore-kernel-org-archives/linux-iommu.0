Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B936C0BD;
	Wed,  6 May 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051909; cv=none; b=ax2WzVQdqaV4pk++Fpwh/agJz3yfyDT9NVv3b+CcfKZCCtd15/8GldJcOeklRu3Um4BPVU44aTNVEHwVgkPbbZaMvU4d9rmCwVeSqcdgfiziJTTNSVc5aHvgF+9VVI8cNI1quBplEJ23xYHwyQKBPQyw6X8rsGbB88OuygJI1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051909; c=relaxed/simple;
	bh=ONKe/eIzUUymE7iswii2KO1/a80BKGXzB3QWRpPSTAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7k7zHL4OZ7aXxWjJtUw+YhJ29IrwVqatDUv9X0rchpSB6sKwd92vQ7kc8jkydb+/pApHYlIcFASAo/Cgq/bFjMV6xn9Z/bg7dYB3tBXEh+sUW7RTHZwbxkc+osh0O2ZtnjM/IDyJSjj1mmnrN0Z6T5Qd0+J2Ylq1MyGRbCtXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3DFZTal; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3DFZTal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B739C2BCB8;
	Wed,  6 May 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778051908;
	bh=ONKe/eIzUUymE7iswii2KO1/a80BKGXzB3QWRpPSTAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3DFZTalp2r3toNOeZRw6LdPkJKEDEVKRy/LH4pn3Iouj/pN8c8ySr1lbM3M5weAY
	 Q5tZFm0hR1FLz8hmFsl59ieKupJ3vVJh8s7Bg74Z+1IgDBcPhUuuAPm5tpcSwXfRwC
	 G9Hd33e8Gb883QEjj4C17dW2tZuQIj+TRj2sijmWawMuJ7MXbmZIKFzwihQg9rWRQI
	 ARAxlANAPvdZOovSQCdk8TIxVaVgqZFyJB28egMXDnGypf8MzIYH/TJZ94jMxKkVoJ
	 Vw9HpnR+nDqwXXFrsfhsl1jBokzV3nLfTvaR9uCfTaSl7StNEA1PGyyFiWKgAJIR60
	 2DD8I3CxJeJTQ==
Date: Wed, 6 May 2026 09:18:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 03/13] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <20260506-neat-deer-from-tartarus-49a95d@quoll>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-3-17571dbd1caa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505-glymur-v4-3-17571dbd1caa@oss.qualcomm.com>

On Tue, May 05, 2026 at 12:29:24PM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,glymur-iris.yaml           | 205 +++++++++++++++++++++
>  include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
>  2 files changed, 216 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

