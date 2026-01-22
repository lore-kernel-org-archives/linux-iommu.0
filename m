Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67543033FB;
	Thu, 22 Jan 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071069; cv=none; b=FkLNT/iffddzyiJYnNn+NS86BnglGi6pVOv+0rSfHo8FyP1I0tdCuWkQkNw/vwv+7FP6Bnno+8pMq5SXufjD0dKYvhXKfK+c0St7IOzSbgRDKo8zfbEJRznYvBB+WtIGa4XOxBlRPXQpJkjDApcdrKUb0LaKVRfHGIiuMKfCM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071069; c=relaxed/simple;
	bh=SfmvWqRZsDc45SxQJtfNXD/CqX0o2X+iPrylB7CAmNk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Y4IeQOH5roXCbPHTkyMQGBu9f4arjKAIGPx7px7OEsAs1N8Z4wQzovhzDv6KBmDVzxaf7xHKvfqVfKZfvwO3Bc0GtUlBucJRKrriugqysxR0Dl0QZYTrBr4+U73MPk66OZZ+4oSeyCKYNqO4cZpvkXSJTethl6rcrfYFH+vgSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip8L3Q6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip8L3Q6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE8FC19423;
	Thu, 22 Jan 2026 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769071068;
	bh=SfmvWqRZsDc45SxQJtfNXD/CqX0o2X+iPrylB7CAmNk=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Ip8L3Q6roPH4UT/uSKbKbAbbRltqOIGkmay/HPfUl4xOxKE9pV5oLwcT6fPS/he35
	 +k5/K+5iCTmB2ygSQfiKco4SQ+kQn7NtnU19Rd7kt2W/1BoMaJMrqmBFKhJlUEXvO2
	 dU+DiANH90rxClaSjP9Od6bF5Pi6Mb6pul5ny/wd4YsKkijB75nRcyBihea4Pgb6LH
	 EAMVLPrL9UzLTZEdYYYEalM6t9Ob8NzK5T2oxYnUkzUVkffiQHWPE+Gkz4est3G90q
	 h/ZU833scwAHuAZp7qfgLt9wGdShw5XCq/R+7UHnK8W9594lTUDo4K8f9GQL7o/4Gk
	 Ny9lzyTKrzlZQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 09:37:44 +0100
Message-Id: <DFUZCRCTYP67.358VJGW8MOFSH@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <broonie@kernel.org>,
 <will@kernel.org>, <robin.murphy@arm.com>, <robin.clark@oss.qualcomm.com>,
 <hanguidong02@gmail.com>, <quic_c_gdjako@quicinc.com>,
 <dmitry.baryshkov@oss.qualcomm.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>
To: =?utf-8?q?J=C3=B6rg_R=C3=B6del?= <joro@8bytes.org>
References: <20260121141215.29658-1-dakr@kernel.org>
 <mo5v74ryxfwik4ggr56c2xha34sfwq2kq6suxi65pbqxrdppnj@oqkirr2kgrey>
In-Reply-To: <mo5v74ryxfwik4ggr56c2xha34sfwq2kq6suxi65pbqxrdppnj@oqkirr2kgrey>

On Thu Jan 22, 2026 at 9:18 AM CET, J=C3=B6rg R=C3=B6del wrote:
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>
>
> This patch should go via the branch that contains
>
> 	dc23806a7c47 ("driver core: enforce device_lock for driver_match_device(=
)").

Yes, I will take it through the driver-core tree.

Thanks,
Danilo
