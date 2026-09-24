Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF1409298
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291167; cv=none; b=nJZAGjMOJT1g8sj5rzkH72bM3opw8E9TYO7Irbc1tvjvU0144qSlRxkXdwcDkg/zBZp6h294vFQAbNCBj1ez0rYE8A39vJZysD4vD+oSeGwyxJHH+v41uGxkR+xcA52K5f3btPnijhBXu4Gtzx2TQtytR/7SYa9iB8vVV0SdECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291167; c=relaxed/simple;
	bh=xlKJNWi5b2E8rg/y/va8nUurduBnJnez2GdpmjlIV4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyaiVytVfRaqziwctW1UCDGfAM/iA4KdDZHoCdroH+BwzaCzmvn/xvgAei97SSbNittXkxOIze1uxBBLwuhrpHGoGUSWSawX20240PTglZhklj36lqmVyetWnMHGJLdpP5Z5XOc8CMwyyNTotV4zC3oQPt2vR9gNI0TpI78Uf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oocNQIHd; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oocNQIHd"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so192226eec.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790291165; x=1790895965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zQnsR23bVv3+/11lzu9TDysHJ//x+6ClkLoNDM2wVg=;
        b=oocNQIHdNvMIY2tqLS70CkvFP2bEAPpdF3pI44Ts+8pZm4a31dxwVygxE3lsHyWmV2
         1EA6BdBElEP7CTp5VZ9imTSUw0ZB8sAQWinKH0FxSkmTRdJ203GV5Nj8FpTCTceLGqkB
         HzvdweJC8ySjjMAICMB2sumSa8SajsB65Vy4YPTP77giAntaH733XCZpBHYaMJ9LscNm
         aNkKMCmgU5cedpm+vHo0hVR1lDEgBqBKmbRlyCQ0mDFEC4cfMOVyg3bqRJvXtOYopi1s
         XeinOZD+mueZrmQlMfleGxlqaIqvfdrcJIR/PJafk74Z1OOUmYcbjwbV9AFszAv8C37/
         HuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291165; x=1790895965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zQnsR23bVv3+/11lzu9TDysHJ//x+6ClkLoNDM2wVg=;
        b=ZS/1TOwUkuzNP8tOOI3WS90+wWO7yLpiLjaFHo43hScUbUuUDwg73Ct+l8RQEZxGsY
         +98VQyJyRSfdkvOky0PxK22YlzRnAAYMW/fqhReM3K5+HEPeQ8YBAV8IRrZV/jj134vU
         pTPXy6Q+XaACNFYSldhjA7uuhCWLNfR742i7G7VRb6Yi6UwKs+UJ6H5D/WrQ9xwqUmdB
         34k18j4xnRCau0LuQI19NPnUyedL4DSlW4TTHMTAF6RICj8aZhivRiUbBC16l/cxwyR6
         2IAkP8CrW/xZ3G/+K4tleudPBLnWlGeQBVGuogGE91SkmllXAndpqm97EFy/GpksixF8
         ie1A==
X-Forwarded-Encrypted: i=1; AKwUvBy3Q/AAEwmBlrGWHyhxRIrVv1yaJ4QFGlHru8QafUoorGHBOajfh7DaiQbdjlZGxy5jKLuMmg==@lists.linux.dev
X-Gm-Message-State: AFuF++l+PNn382aeogaQReRCQ4DEfr2LwR970opwVQ+nT2SYQdJOr/wz
	AUAbcfM/bY9iPf8ew6wQHCt7yA9SfQjnvYCwSGCWj/NJY4PiKzi3/fsS3DpDxRGuTGc=
X-Gm-Gg: AYBFou09jyyAAiucrLF0QX7H1mGImsWWOmTUIY5xEWO72VE7nyME6diEsylgWMlRmGl
	duXS/ETPeHkQuFox35vKJgFzhUAAbWvCaIKlMdaj316o/Sa8S3PbjrDzYsBSyEJdPVLii0bmKaR
	DB12uZuYqlVtv+8ug/fYFEIYWkOP9qU1dgFOfizwsv0bCOlbSlSUOJmZv+hAiAfpagk1AKto2sr
	ClG4R898DtxwSHJWXElhr0CeeS4CA0NcjVSblF4yz52CImhrozfys50Zl4CpzvLuws7QcFgoxz7
	5XyuSt8dH9mg1yvMC6/SS9W5Lam6Cpwn5YHnmXpVEp/EM87j27mctmf5i7IJ+32H6A5PeSEWrN8
	+ghZF75PtcD2Bxo4rLn7niJSlYnHW12l1dTMzx54WMkFQzWEjw2OZYhXey+oP54ZCWawrXoTLDP
	U0rNcyREcP54rdDzuNU901kCfwn55TXHjB5kH4BxZSm1TS
X-Received: by 2002:a05:7301:6406:b0:33e:42d5:1d3 with SMTP id 5a478bee46e88-34000c382e2mr2555669eec.30.1790291164415;
        Thu, 24 Sep 2026 16:06:04 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407d18fsm1480231eec.10.2026.09.24.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:06:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9sVu-00000000fXu-3DDy;
	Thu, 24 Sep 2026 20:06:02 -0300
Date: Thu, 24 Sep 2026 20:06:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add support for
 arm,instdata-override DT property
Message-ID: <20260924230602.GE16465@ziepe.ca>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
 <20260911-arm-smmu-v3-instcfg-override-v2-2-5804e4f400b5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-2-5804e4f400b5@linaro.org>

On Fri, Sep 11, 2026 at 09:21:06PM +0000, Peter Griffin wrote:
> The Google Tensor G5 SoC (Laguna) has a silicon errata with the SMMU
> integration where the AxPROT[2] signal is always 1, which makes all
> transactions appear as instructions.
> 
> To avoid F_PERMISSION faults (due to the VMSAv8-64 requirement that
> unprivilieged writable buffers are treated as Privileged Execute-Never
> (PXN)), as a software workaround we make use of the INSTCFG override
> feature to force all incoming traffic to data.
> 
> To enable this workaround, the "arm,instdata-override" DT property can be
> provided in the device tree entry for the SMMU, similar to how existing
> errata workarounds are handled by this driver.
> 
> Note this is added for "stage-1" and "stage-2" but we intentionally leave
> out "bypass" as nothing is downstream of the SMMU that makes use of the
> Instruction/Data attribute.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> [peter.griffin: ported to upstream, updated commit message, remove
> feature flag]
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> Changes in v2
>  - Fixup incorrect bracket (Sashiko / Nicolin)
>  - Add more verbose description of the issue (Will/Robin)
>  - Add note about why "bypass" is not required (Nicolin)
>  - Remove ARM_SMMU_FEAT_PERMS_OVR flag (Nicolin)
>  - Move check closer to IDR1_ATTR_TYPES_OVR read
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
