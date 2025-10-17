Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A8324B1F
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698680; cv=none; b=gbmlo+fKCWWnNCnKOL6X/6PE3VWUXdJFX9rFZeI8KIiynWQcfC+aC4eTml8Ik+jEsL7szkkJo0CQj0Mun0k6BS+tKU82M4HUurIjKX/vVMlcSVvT1NM7vZcpOBbScdroqIPdJ3U+v2IlYSOmRoUooJyubJfDE3DrHTIM7CQkxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698680; c=relaxed/simple;
	bh=eR16PUkc6dUUYhHIVoedj8Hgpyf6tQRjyt0eGaFiPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6gbWqvzGz5UZti2rTDk+WZ/I7021GIoHU7U5GXFjuapsyZb1tXv4otdQFqkBtC0sqhcy8rkmIKP96Uagh9NldfR6d6lKFY+h2yCbnbV3hb1vHxstA5zI9EeliWYRAHf353SLPS2QjcUvHFHGAQX5DhwY6tKZzLQMrAW6/1aZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HILixhFN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HILixhFN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so46355e9.1
        for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760698677; x=1761303477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo4lGh1qylkyfZNtOOXID57CwW0befm2pIFirkm/dXY=;
        b=HILixhFNZq3M0iIy7GHCL27XoA9QZ0SBgwhFzbOgHzbUMo4RwYq1J/EB6HbdZg6Yt8
         O7IQqLQRo7+UQDPSMneFZ6zc78UCcdBS/pkthK666EU7BHMiq/QTNHLrxIUqIlGOqREO
         ZXWU9plbLkHQNCqxtgtSfWo3PY0oY1R73aZhcLAhTg+L0amPUj7OpC+yEr4LyuZNOP4w
         x+Xj7FJRQq5T41UR3rAjB9NFQQ38aEwBthyrPHA9pKFRiRFvlAXXF441LUEYydaUi+Db
         nDpSiP8a2AEFoxvcgyMsLG65qFLOGD3VdElCeOl45PgCEPdyaBI9S6YYQHc4nGtXtrtN
         wNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698677; x=1761303477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo4lGh1qylkyfZNtOOXID57CwW0befm2pIFirkm/dXY=;
        b=GH524e3cs5nYLNfp2TuB0U4wyruOt0ke5a0w0C4LVpG13ntZPaLTBa1O+SjWvBbXWv
         pC396T+gQpYVYe2Yj7lRDYsDVSMbp7qucdhI3VJIAD16pPgGBqKAi+5Xx6wch6FNhrlW
         EYhEXctU0hpykgoED4W+F8s+VzY/+d8Fl3QP0vk/FFxPsiuqM2DwBS7DIQ5lP+WnpOWr
         B+32ywXTIUsnw3Dkh6niA7nJEtj9KM/Zn+TiLHZpXihc3GeOar4k0yTcEN+zmYSF3e4t
         VEFWTj7+csZ4RtS77mAx2v9/oXqBlbIMeADr5i1raNWgdxbZXS+lOjKfmJfmcVPlmRnS
         7+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/ZPrRc+0AeJzBJNMn9PJSMkLQJtOOe4BE2p7LbpDwJ4qPckcb5zD9e1r/N1r+l0cRWmk1oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNhPffFMzz9+NY7X7dvyQa3IzCvx9BBpyQBZBA7wemEahupGgR
	qQX/tOJaXy5aozIJ3oem9RMV/iAlG2TcKQ+B/jdkDcLVV/Wswr26tODQ8P1QLm0IBg==
X-Gm-Gg: ASbGncvqWo8STVIcdCKYVj6UWFgZYwQHeMAVIl1QgmGQ2Gtj6/Ri+BcXLVhh2izCiBu
	vcbNiwV81aj6Y6G7ZX52KoBPlPUbLDQQSf/eLwWXwMtlq3NYLIpOk2YDUd+aidplcHWdGM50a88
	+TWBty7V35xbR95gmNdwPULROPUFblpl6HHq1Wrkn+NsKhSmxDTGO8tp15rDQqwy2n+EEG6akmu
	tEj2xYBrYulr4TYggPHtmSRWs41zInwC7GjYh1ork7rJoldjtImAsweOCrmly3pA51LYC2HRtLi
	kU5wEzC68DX2uO8heqfu5JQdEyp6LMRM/ZIW5OzBmvehFivdOrPVIiBevEA7X9s4u7zQwNmNtiu
	N0T2gHcV/+LndpAHtklPLROhy3/uQ+0/MKYrjIRZoAjuDYNMLOd6H8FSZIUSFvfCwUKKIP9ziZG
	2+cjHlgXUDE1t3jsh3RmQPN9zFxg+3qEBS9yt2x68QbxOLMN5D
X-Google-Smtp-Source: AGHT+IHdsLkKcL/Bxy+rEkb9qWShVazjyHsRGsdQUHxxbtS9bFNnyuCxT3yLhLwXkstTJOH4J83LHQ==
X-Received: by 2002:a05:600c:1790:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-470ff2e9387mr4052525e9.5.1760698676935;
        Fri, 17 Oct 2025 03:57:56 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm40279039f8f.22.2025.10.17.03.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:57:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:57:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <aPIhMGnzHiBkIEam@google.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>

On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:
> Hi Will et al,
> 
> These two patches are derived from testing SMMU driver with smaller CMDQ
> sizes where we see soft lockups.
> 
> This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
> with artificially reduced queue size and microbenchmark to stress test
> concurrency.

Is it possible to share what are the artificial sizes and does the HW/emulation
support range invalidation (IRD3.RIL)?

I'd expect it would be really hard to overwhelm the command queue, unless the
HW doesn't support range invalidation and/or the queue entries are close to
the number of CPUs.

Thanks,
Mostafa


> 
> Thanks,
> 
> Jacob 
> 
> 
> Alexander Grest (1):
>   iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
> 
> Jacob Pan (1):
>   iommu/arm-smmu-v3: Fix CMDQ timeout warning
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85 +++++++++------------
>  1 file changed, 35 insertions(+), 50 deletions(-)
> 
> -- 
> 2.43.0
> 
