Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E882899;
	Thu, 23 Apr 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951507; cv=none; b=SC5kkedjKV6um9WPGpMUSMt8731y0iI2sftHvLMMxDsDMsZf6efbDap8k+bwtBPN5SnwUmtW1sNkg/nUUXHLo1KzZokBSJaV+NuS5USVymvQUc+wghJJBa4WtIl0vqGzvjGzluyVhn1XhITGKNw5XycSPbwj0qA7giGIjJxt3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951507; c=relaxed/simple;
	bh=3wo7czwl0nEqa1PIdDnQUQEnxYPP/Z67DAucX0mtg6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj80YULso7Ap/oNMxpcknQiuL83IzAN+MiK35DzpzFGyMmH/Ea2b3kpjDSk2QVzXSiVEtLiO9fjdCe8AybZjAKONgyoVuLSqOhTIY/I6/mSF+eUpsMnyTzGazVj5j0q+FA0VgSQaJT0bmuP8jVyHC/TS9fGmjOTm11SpxTi+ZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siGgw8WK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siGgw8WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF50C2BCAF;
	Thu, 23 Apr 2026 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776951507;
	bh=3wo7czwl0nEqa1PIdDnQUQEnxYPP/Z67DAucX0mtg6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siGgw8WKeTOObuAD7awlSiObkHulMUGDGs5E5vA0f08Rh3YiBdU/wdoTbGEfYQmR3
	 mJR2vBy47fIfYpsaFgS4aEETnl9GLyrG7R0uLDdr1gBR82CPAg99vYx83dZstyRsfY
	 YOboDlN2s3BkfkUmHMCDGdxlBId2oxKOuetVDiy8=
Date: Thu, 23 Apr 2026 15:38:25 +0200
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
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 11/13] media: iris: Select DMA_CONTEXT_BUS to create
 firmware device
Message-ID: <2026042305-pungent-urban-c681@gregkh>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>

On Thu, Apr 23, 2026 at 06:59:40PM +0530, Vishnu Reddy wrote:
> Iris need a firmware device to enable secure PAS (peripheral
> authentication service) support in case of non-Gunyah.

As gunyah isn't ever going upstream, why is this an issue here for us at
all?

confused,

greg k-h
