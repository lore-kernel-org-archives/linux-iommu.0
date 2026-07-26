Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101919E96D;
	Sun, 26 Jul 2026 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785071810; cv=none; b=TMs2IjMMXb84VG3WC5ySP+sK23Y+GjtJ9+Exf69GELa5NBLRUgUUaoekxw9bneVjy1F/ecwgqQ7A9A/WcpKI4Nv2gEjuGNea7F8QXjVNc74Nw/9NlQqmChnKw1OeAxSM6Pn5oOxNc153luoPaFA4cG+FlUE73ad8OPGJa1rU/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785071810; c=relaxed/simple;
	bh=TNparDVyDDn9haKhMEBsO+x8ytYl4NXqbNmntCdS740=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ona2hvQ8Uo7RHmzinFZ8hib0YkStBPKjXvXQpaDF2Kwvf2FQnbbyrCG1MHUyR2Eh6GLhlmuUihfKX36rQSgptZ5qC0EYaN2EIvPs+deV0f4m5MYgZyGyT6DNBokIWD/wwwZcyPoikrZDiUzA86/H8ST0gBVvNp0Z2dTMzYC27UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRHaw2Go; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRHaw2Go"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E79D1F000E9;
	Sun, 26 Jul 2026 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785071809;
	bh=4Siogxd1mnPfoRDu26OqqhqR/dDnozwHaf8cFoli+/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VRHaw2GoQpDSfvcJXRQtVy6ORniM+b1MVX1SJdwRzULm+ZbodjVa/zcRtdMV7xeyu
	 HkMG8PdX1T/I5kwRTDEGEBgaDz7uAdCkAfc715f72C4uCqNNmvHs7rL9uvEzC6mknK
	 MlQNpbGq3CueFIwdFF3Gr90NzOybVM/J+gLfknlT4YC8Ke6qcvqFx8ttAPGVnbnGBw
	 HvKXQOKGVPMUfWlvj0aYpp48n9/UGoc/vKud39t1ugVnThelroOUxJyv62FhJM1yyv
	 Kg3y9+ki8BGH1G4/Kr7exkZy8RQ3e5mT/giD01Pt8KuKwapQRYwuS+C8OC5RDHfbuj
	 sMEAatKtV9bPQ==
Date: Sun, 26 Jul 2026 14:16:42 +0100
From: Will Deacon <will@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	jyescas@google.com
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override
 feature
Message-ID: <amYIuhYenP4-qHyV@willie-the-truck>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>

On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> These two patches add support for a new "arm,instdata-override" DT property
> that enables the override of the instruction/data attribute of incoming
> traffic to Data by setting the INSTCFG override bits.
> 
> It is intended to be specified when the smmu can't guarantee that these
> attributes are provided correctly from the client device.

This is going to need an in-tree user and a much more detailed
description of what is being worked around before we consider this for
inclusion.

In particular, if a particular client is emitting data reads as
instructions, then a better work around would be to avoid mapping its
domains using IOMMU_NOEXEC. But I can't tell what's going on from the
limited description provided here.

Cheers,

Will
