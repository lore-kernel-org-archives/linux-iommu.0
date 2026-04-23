Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974718BBAE;
	Thu, 23 Apr 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951427; cv=none; b=ae1qqdWJoSDBRnUNzT7hV71KKczsNG5yWRD8rpFqmQep8+eH7K+mkvR1UzVd2TymEZCf+kezLOo62vQNQmx/brzcTqgR/fm6fVRI55kvPBOjx4EVV+40hu5mweon3NFq6Xc+OxJHjGGuxJLuLesp0Kh2SqPSoO/+WgjfoZd3RLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951427; c=relaxed/simple;
	bh=SCMeXc6iNHZVhRhU78udGlaYW9NkW14onQYu/AiF6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7LdzhQcL3vN43mHa1BoCZis0uXlR8COTZmcAtYZDemq7IDHjdf8EjI7VSMfPXZh56mFhS/nJxIKFA6J2z+Y6VCYKusJ07gy9lWC1WmGPFUCuUyBhrM5J7pYto1AvtQqSe/FMWKojNoTSpcFqXHx7Wpa1oDk7NIwgXic+rLEWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=au64Nxy3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="au64Nxy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA45C2BCAF;
	Thu, 23 Apr 2026 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776951427;
	bh=SCMeXc6iNHZVhRhU78udGlaYW9NkW14onQYu/AiF6M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=au64Nxy3WFohQJGnz3FSUq8C7RO3sPhLi5iwbU952kiR0Ope5w7kJ7cYGLG4z5SMC
	 e/VFjhoABO6Y7Anyln2loRbXXujZZXjWCvV/JbnsUf8poq5HkVfBCsog9kgnuwaH8M
	 BBlgRx59Y7oEpJWqqpEH2KOrwWDxjL8NrCi1uVSs=
Date: Thu, 23 Apr 2026 15:37:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
Message-ID: <2026042346-trustable-register-095a@gregkh>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>

On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> When a driver needs to create virtual device at runtime and map it to
> an IOMMU context for memory isolation, there is no common bus available
> for this purpose. Each driver ends up implementing its own bus type,
> leading to duplicated logic across multiple drivers.
> 
> host1x driver implemented its own bus type to attach an IOMMU context to
> a dynamically created device. The Iris VPU driver now has the same
> requirement. Rather than duplicating the same bus logic again, a shared
> bus type is introduced under drivers/base that multiple drivers can use
> directly.
> 
> The bus takes care of creating a device and attaching the IOMMU context
> to it based on the client inputs.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/base/Kconfig            |  3 ++
>  drivers/base/Makefile           |  1 +
>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>  4 files changed, 107 insertions(+)

as you can not have a device on multiple busses at the same time, this
makes no sense to me at all.  "dma context" is a bus-specific thing, so
please add it to the bus that you are wanting it for.  It can't be a
generic bus as that just doesn't work.

Or what am I missing here?

And why is DMA somehow "special" here from any other hardware attribute?

thanks,

greg k-h
