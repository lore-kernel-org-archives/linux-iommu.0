Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BA3921D5;
	Tue,  8 Sep 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852006; cv=none; b=Qxa7rUzSRMHHW/wViUPLW810vN5ypGx6R1yOTk4oCDHxqV00TBpe53DtODdjAR8gcvaNxxsfJY/uNfxYs7Nke/jFGijyUi/+lidDpdfyWcoDkQyqBaArvu5n5WXiZ5c0BT+ileKg0tAqFVkiHSK34V5CFQBAXIUV9qr6aRTlPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852006; c=relaxed/simple;
	bh=/RRZ6hsbvU6pevsalkZh88Ye4DxgDh5V1Ekk0sSBB/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na3ivCF4nqW6dctJVljdsxJefMidQumZU8GSTXWHoSzkyx2/YquUExnD8oCT5iEu0ltL5dNIbRWmCTI7ohNpZvrKcL1QpRmHNi3qabcGanYurBWCFsRRd8G8tbU+APmi/10VqA8xzLEShE0iyxWMb6iEU3Q9bbD2nRD+MnXwXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AljxjW7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AljxjW7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD91F00A3A;
	Tue,  8 Sep 2026 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852005;
	bh=Z8TMUzGdYNSK/Vy+LXW7FJczTUbzayrTgLFAcKaqXUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AljxjW7epwTO1iYIWAH2ZCTedj2G+V1vW7PgQNUErkagHEZOnqt/vS/U/4Koycd8M
	 pXrJ0xHesB8UZrl3uA1N+83YjZc/SfSxROF1cLnbVLecpo6SOeve36gXxpcOVNE4Ii
	 5jfqSL2JjviF1zjkSoDxRDbLrqzXTUYIEEWYO+ldoIOxhMTT49m/NBACighlNPMqW6
	 BNyG4IPoRmLz7OjKntIBiReertNXf/FzDnG5GWLHRwFL1680Td28JTgpxWIRsRtkdp
	 iLeFAHkptC6m+duZFR3W6G4YGaoG4zJqrgXK+t/1d5jJJXP33z0SAYhm0N24osKMVO
	 o/TAtKbCTTg8w==
Date: Tue, 8 Sep 2026 09:20:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord
 SoC
Message-ID: <20260908-whimsical-flawless-curassow-059bb0@quoll>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>

On Wed, Sep 02, 2026 at 09:38:58AM +0800, Shawn Guo wrote:
> Add specific compatible string to document the GPU SMMU present on
> Nord SoC, and constrain it to the single HLOS vote clock.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
> Changes for v2:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

