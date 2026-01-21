Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14A22D4DD;
	Wed, 21 Jan 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000586; cv=none; b=GFhHujbbZnaed4VGjyq7DTBGv46egt+06g0trNwMSbl/azbDkmZk11PrA/03l548IJ43bhj6+0YEfyZ5C1PclglqWbFXuWR1tc2s/+4ayjeokVemWvfxL97ccVL5ZfZ/xLiUu/qDtKexmpbEeGMz1T8pPhaWoxoCHYgoFUrG3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000586; c=relaxed/simple;
	bh=BOd5zkjfHP132J3aOakYOWbzIMqm43y3rol1qpZtb5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1pv3uPrAp2kaKo8eGoLiop5UBxe+gRSbKbJgla4gRXtnIh5oqd6RO2gQ9pfYSUCSwYQGy82PdY/2p23HyUZ6oRQBMBCb5cM+YIHuiJmQwWoDRSGU4YW0rIBkiWK+6MEamLvTseMkfr/26MMoq53RvjNkAyTD2KxxLp/zh98wB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ7z8eGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ7z8eGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17485C116D0;
	Wed, 21 Jan 2026 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769000586;
	bh=BOd5zkjfHP132J3aOakYOWbzIMqm43y3rol1qpZtb5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ7z8eGd34tS2wxDungBy76VNLBqfVJ6ksE3dpA2/FKel/jk8pbGQDwh2IzXhEKaN
	 je8DXkc24f43ksA5GV3BZ3hLh6qSKYfo3yt9vSDu4WOWdo+1bLb1c09EuD8jjU8P78
	 rLgAQfLE/A5sMzeTxWeVUR6NOZvMiR/Td3DOtyrfrMKoZ2EeKP9Hwfb7HEBSI/p5Ny
	 NkLqUl2vEbj1xl2GQjRISslXXJu2VC1uRupgalrQIyAZazWLD9L3c4BMwxEP+OdnAg
	 Ezghkd3KYBOCInYGbSL8Du+elpnESSeWbf4ENabQdil0/5cF2TWZmjtlMvz+iOy7HF
	 PxB1Kl+yLdN3g==
Date: Wed, 21 Jan 2026 13:02:59 +0000
From: Will Deacon <will@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Wang Jiayue <akaieurus@gmail.com>,
	hanguidong02@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, Aishwarya.TCV@arm.com, chenqiuji666@gmail.com,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	robin.clark@oss.qualcomm.com, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Message-ID: <aXDOg9YXqWyV3JTR@willie-the-truck>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com>
 <20260121085549.165428-1-akaieurus@gmail.com>
 <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
 <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
 <789030ba-c5bd-4c1d-a10a-2bed4fd76dce@sirena.org.uk>
 <DFUA41G0WJ04.3TZX9914SM60E@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFUA41G0WJ04.3TZX9914SM60E@kernel.org>

On Wed, Jan 21, 2026 at 01:50:52PM +0100, Danilo Krummrich wrote:
> On Wed Jan 21, 2026 at 1:49 PM CET, Mark Brown wrote:
> > On Wed, Jan 21, 2026 at 12:02:15PM +0100, Danilo Krummrich wrote:
> >
> >> I assume that this should resolve the problem (unless there are more drivers
> >> that register drivers in probe()):
> >
> > This makes sense to me, I guess we can just fix any other instances as
> > they arise.  Will you send the patch?
> 
> Yes, I will send it soon.

Please make sure you cc Dmitry and Georgi when you do that. I'm worried
that you proposal means we run the probe code once per TBU, which looks
like it will break.

Will
