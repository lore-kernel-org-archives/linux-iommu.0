Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04626E173;
	Thu, 23 Apr 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951629; cv=none; b=lQ7VSDRCKTNwbo/n6yfj81vmnwwXP3KKAcqhOe5czHSK34jmApT0marDEl9QWy3dFv3C2mpBbMWmzws26O9K8nyAyyFcypPSrZznqvcl/vMcQ/BIs/0nnYHNnd+JPI/XZ3GBMxzxcAJ8NGDS/F/qO947cN8m2eZskaf1Y/KXlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951629; c=relaxed/simple;
	bh=3KP4UVdXkAjUCLuoO/Zngx5JujLIt1ZAmsr3rv4yp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/JRcLrJqFTLi/8W2HALgjlTFJqix7lh5b0jNf10175wOJAE8DghWyQfS3SuM8L3ri0DfdB5tkvEp///uUGmgYCxNL2hC9SKps5HKOLRX41Hzbk0bg/ep8rHIhFnnV8ZfprXpxW07+iZAEFtDIFP6ifibAI0Z1A9ByTFldJ7tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d51b2ao5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d51b2ao5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DEBC2BCAF;
	Thu, 23 Apr 2026 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776951629;
	bh=3KP4UVdXkAjUCLuoO/Zngx5JujLIt1ZAmsr3rv4yp5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d51b2ao5sf7XgHmfz7iMq57cj2OZF6xGfimWjCfRuSY0cxJxIeeynX8T6+uuCsAwQ
	 QelMwuEkg4FlvKEstXscM6rkCKvWKSJS/rsmkYU1wU7PB/pRdg3xHq5U1ViGvA+c5o
	 2ESF5wtWpLmggMSwRMhFBfaffFSNbnd27dGEbD6o=
Date: Thu, 23 Apr 2026 15:40:26 +0200
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
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/13] gpu: host1x: Migrate to generic dma context bus
Message-ID: <2026042330-recopy-corner-07d9@gregkh>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-3-0296bccb9f4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-glymur-v2-3-0296bccb9f4e@oss.qualcomm.com>

On Thu, Apr 23, 2026 at 06:59:32PM +0530, Vishnu Reddy wrote:
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -462,7 +462,7 @@ struct host1x_memory_context {
>  	struct pid *owner;
>  
>  	struct device_dma_parameters dma_parms;
> -	struct device dev;
> +	struct device *dev;

Ah, nice try, but no.  You can't use a "generic" device for this type of
thing (i.e. your dma context bus device), as that's not what this device
really is.  Add the needed logic to the bus this real device lives on,
don't try to work around it.

thanks,

greg k-h
