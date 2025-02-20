Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE50135A53
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013410; cv=none; b=j4Ip5BFIFjdor/aFkBg8eLJAWfr9bOp8GJe5dkTYYnB1HDCyZvAytF7ekwpgtTSKUROaezU0BqBnWIPZt8TM6OSkwTDvBd/hRH0G8xOrMHMPzUDy148cbju2eQYsUNdjNv1kWM1CWGTlmphISGn7a4keGAyWAXwSdUxx0HdRqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013410; c=relaxed/simple;
	bh=uoKT8mn2kqsuF35fq8S96ubypduruFZKYY1NqO9aO4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCKyC+ubqXEIjYpQa5v9/R3fFSIIW6tfEYiWwqoAFqiovTDIIPXT1kZndvQkzp1cvaBaMr1n+L01UGkaZiK+iBK6b+wRXusef7E9mv+Cjn4vbnDx9iGjDsa9UYeoYPYXtdegWM/O6MvYgy/oIU1P9Rrn2FVQQsodpYCdrOhv1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mdnQdsbJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mdnQdsbJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471f257f763so3897231cf.0
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013407; x=1740618207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJnHTfhhh5oO/5QVFdYosizxDAfM8S4m8Bge+zqnfMQ=;
        b=mdnQdsbJvqPwOWtgD9HEuibynHjkGPaJU6pN2VA0OCWIRV6+UZQ8ObZ46mMDMfk5u6
         AbHPNq4AfC+Xx53pockhgEI+XknsEEHM1XcgS1A9DP8MHN2qzpVXD4XHcgAad9W1eGbx
         f/mjl9NX4sTrRrdMr7D55fU2G9k5erbBrbQRH4ziABYUX1b8OPhn9WLTEaHaZWCyXPGz
         hHYemOHwRbg25iwExBS4rPRp4MtlaYnK3iCgYfly9eogWhGbX6UHxkxhN5Xab9V3QcKq
         2cELcebeY5BDMK0hPJy8uwDtUqbSUtUeDSoT7MTCUuy6z6KmSVajah6Dnjn7SCg+s9gI
         YKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013407; x=1740618207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJnHTfhhh5oO/5QVFdYosizxDAfM8S4m8Bge+zqnfMQ=;
        b=TxWSXgYanW7+JVbmt1JhZWWMmGSr/ufN+3A+lyTkbLqgp/m4v/5xzGZmuWqSQriitF
         hnjg3gU0TfkhLKHHu17bZfLrTXCN9XI9RFPB8ci7d19QcdM/+TkF5on21x3FJr0c3mrs
         eVjUwKPTYQXnSDj5K8vKrOySX/L9ib38ntsK0vtbeYqECT0EJKazgvaoX3MLTEP0QI0o
         qIRRXRRQk6DWcDlszKMsqhuaXcCPtbut9mcOWZm5lI2KpFlEbb1D1JXKCxH4NlgK/0c6
         LjJ0L2ooC72mvLHwmc9km4E/aGy3AgUoh+m066RVx73kIIr5um+QtZbqTdkZXEkzAyWN
         Zbng==
X-Forwarded-Encrypted: i=1; AJvYcCVeZbDfTrtNQSMV6B79buaPlaKOTUp1WN/jK2rHMlnJ09jRQsgSYVKTgGLn/QlqEyuUayu+8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCaaUWr4p4XQUX27H9vwBpNmIS8oLKTctSIx3RA47q/5K7ralN
	/6s4KPzP4GOue2vRYmxEVejbRZpjqOQDmMGaFPqM257tJ0LgBj8CLF4sPWsBLPw=
X-Gm-Gg: ASbGncsgnrH5VOuj/JIikF58xcce59sm0oWKfEH6Rugx0SzeFrZtkYXnIhge8C+8SMe
	GYRm+4Y1T0wjL6IB3B6SVVLlhuXOvdp0lrHGELr9aQNyPazbVjFe0O2rZ1RNicHAXeIh+UHHfoD
	vx8Ssz1kjjz4feH1GcNdh94uLxnD4WlUSvyBMg5Rdn/fN3QqB64xCn8ZgdT8BocpunfuYGSK5Bt
	tJrRTXd4yf0SoTN81j4eZuI6IUVJtZ+r7LxhCH1NNalGHD+gJQVtGRCP7j8/vkmcrGa8u3q706y
	zEMHYqCuBPe2O9Ffoai6EtyVwuITwRzsdItH6R7t5QwVVFmAW35w9nJJvA2ies+f
X-Google-Smtp-Source: AGHT+IEP0SznMWngJV+XmUdphWVKwsCLb8oL7y9FuJxNV2MD0qkEQHKc4YBhbpTr5rtelyk7i+YEMg==
X-Received: by 2002:a05:622a:302:b0:472:5ac:48bb with SMTP id d75a77b69052e-47217372cf5mr6048941cf.29.1740013407667;
        Wed, 19 Feb 2025 17:03:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472069c3482sm18629721cf.20.2025.02.19.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:03:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuyL-00000000D7S-2awh;
	Wed, 19 Feb 2025 21:03:25 -0400
Date: Wed, 19 Feb 2025 21:03:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010325.GR3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-10-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:01PM +0800, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/dma/idxd/init.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
