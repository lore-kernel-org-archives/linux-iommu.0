Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA52874F7
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141536; cv=none; b=QyhwrC+9+tcS6D2aG8k4KCyNMKrY8jbj6vUKwiLyW+YNDOR1LXLPdrOiIoHCRA1GWSDYOO766nRd1kkP01FAhZ1YJZte2Vk/QogW+tC2P35DEx+Ec1tTCsTTmCrtW30Gm3skC758vxQt2RO2ZPSFGBPBNKEPHM9+58wOhycB2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141536; c=relaxed/simple;
	bh=LRBN+7pVsfRX4HBnwza1vs2Vuv7PT4DxF6o0fSGauMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVs5fYAlsWGJ7VOEXwPIYfvkkR4CuSwE9sHP1Hkk/vw/HUhY2wzbe4KCF6QDHgF/BYSPzzZm68rFVGbjgQTjAXs3EALzF4Ryyw/ZXEmmMBBLAsnI9Mv4QtuVmuQwLxCJp1owshHJa0kAZW9I/9joixry9CHd74mGbIjGheMe60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dm30GrQq; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dm30GrQq"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70d9a65c353so41899736d6.2
        for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756141534; x=1756746334; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6KxvMDzVSOwTyVOOifum1zHj+Q1NMnnZSanrfOQhBQ=;
        b=dm30GrQqgrbU1Me6dQ32xwfbSggKsczOX0Jubuy7VnJcyNy0Yc2mBa4TWA3VeBCrB7
         deFudgX8Qdz4XbCUD9mxniTFYWaXWVcCmtxGEgfaJhcmecmhfksnnMp1lY2IvH/E46cW
         Y2tWinv75MbZ7iBFdxkX7dcsndTS/dCmxxV4EGn+K0sj8G/pKrNTY4WdeprFTPnLxtxI
         fnqyLIS6If9x/po3JLycfrelPx/xA7TeqDj1t29wpq5we2BEkl+5ZwkRTh5D3IDuZ4jC
         m+aDbiZOO0rBXZhLcdnks1HFf25dAI9XwjZfZ4YBJqCfpOjxhOKERMw3A7F1IqbOR3Hb
         RuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141534; x=1756746334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6KxvMDzVSOwTyVOOifum1zHj+Q1NMnnZSanrfOQhBQ=;
        b=i3RePdnJAub3w5+hjl4w+2fPtAAD4PUIMmaufVrVi7hpuvD9XQHMfM6jDHmmpVTq6v
         JpQl2LxICy1qadZ1J7s5uQsmP+4e3T3WzZ/S+8XITAaNc2oBVQTnrmDCkuQ9T+aaF1D9
         WArDImxcHTFG+Kr/FRyAKajzOIas9Pt5fb7FAGNZfS+9960Vs5Z0nPbfeOUQ2hMw3NmT
         bu/K9slGqXyf1iYxn+zp3GEAqmhEGOh1mw6Qc7uRAByTHIXFTKVuJzTOrD9b/SSQyA0K
         x8LPv63+2NU8ZqPNol3owyE/cNKL6/drU7YrvYE2ox75afAizCi2ALcj67Occ6020ybb
         pbMw==
X-Forwarded-Encrypted: i=1; AJvYcCVeJG7J8WHhv60+/lkzs4b17T4a08fY+d+QsPJ7W7j1xCCLdIzL4Y3tasUJo1ew1EEsJkshmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw95moLWsj4VmYlozDG0/Xv/mDZudBEbaEfV5EG+d278v+zZygS
	oDVpbPeG1uR0Mq40JptjNCcj2TYTtnr3VD7VFtpG9tOJTuSTaAd6OfrCFn4DMDZCsA0=
X-Gm-Gg: ASbGncufRXB1ypeZo/QMOAm63mLFxr/TxKADBylWFcW1OD0FCplRxhzALSZ0KIyF/kc
	WLUbiz//OBxRC4O7OT7TA1Uk8es64T0kWCAYpzY2kMYmhKL4Lp98gUimCVQy17AcI71e+NOkYQI
	Jbxr9liQzKKgZete8l2AOC1JN6cXMQFV2BqKbNvu25CSvEUijeOj04ihjSnIOuKNZSVx9aInyII
	FMbHR+xmo+m6n/lhkcTgo8wmW7yTgl+OghJOIjpQa1aBGIxaIfPElwQRVEeEe4q+9QShiFkbm/y
	zwIwmgt2shEeYJ7uoyORZc43K6nEPur0VEyy2KySCrHQE6Rd8tKC5glC8O6dmqrZeQ3HgxosB8T
	u6z9QqbsY1ZjrVfWUWaBivLA1Frh+cFjCOHtcHvKFl0qXUB/qEhxTGxv4ASPUpCXJOih1
X-Google-Smtp-Source: AGHT+IH8RaHjAylVQJBbbz2fVViy55MQyOlXslCXu2TNEUhwTy4uudrftYMxMziT/A2NjRI6tuUcow==
X-Received: by 2002:a05:6214:2a83:b0:70d:be38:8ee8 with SMTP id 6a1803df08f44-70dbe3890e3mr56021826d6.63.1756141533729;
        Mon, 25 Aug 2025 10:05:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm48193006d6.13.2025.08.25.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:05:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqadP-00000008iJN-3bFh;
	Mon, 25 Aug 2025 14:05:31 -0300
Date: Mon, 25 Aug 2025 14:05:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250825170531.GA1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825153450.150071-5-benjamin.gaignard@collabora.com>

On Mon, Aug 25, 2025 at 05:34:43PM +0200, Benjamin Gaignard wrote:
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 81328c63b796..a28a181013b9 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -12,6 +12,9 @@
>  #ifndef HANTRO_H_
>  #define HANTRO_H_
>  
> +#include <linux/dma-map-ops.h>
> +#include <linux/iommu.h>
> +#include <linux/iommu-dma.h>

This is an internal header it should not be included in drivers.

> +static void rockchip_vpu981_av1_restore_iommu(struct hantro_ctx *ctx)
> +{
> +	if (ctx->iommu_domain) {
> +		iommu_attach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> +		iommu_detach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> +	}
> +}

What is this supposed to do? Put it back to the default domain? Who
changed it away from the default domain?

Did some other driver change the attached domain (if so that's wild
and wrong)? The commit message hints at that but it should be
explained alot more.

This just seems wrong and goofy. Driver shouldn't be changing their
iommu domains if they are using the default domain at all. We now have
APIs to allow you to allocate wide chunks of IOVA space and manage
them directly. Maybe these 'multiple stream's should be doing that
instead of mucking with iommu domains?

Jason
