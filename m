Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047E33A710
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644851; cv=none; b=QfhqUH/fZNfqcgHXGVzXjsZRTT4WyCYpmHwGMrguwU5cNxJjfhuDKvxI5eD5zi9T/mGVGiP4ZZQhTsZ0Boz2FBzsiSPYQ52jnhIbEsJ6f0vXjNy/qbo5u3I9nZ4pA946pPWUicR/7xVtIi0Oz918t67SROLCI8qjbKQPFi8uaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644851; c=relaxed/simple;
	bh=FAIy2u4gJscDNGUshiInImCPqOKl3iOKQJH6e6Bc4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shi1vtpPivy5QZQkq644Ed6mUqHdJlw6Q1hnr/2RiTGZrP7RWACzA3hcwnUr/jWuY0Zl7NHXmiznGmTzkRG5CopuKpS5J7hLpLf7SPL10jjjGo3LWir6GTHay3WI6K8PlCYu+Yx3AfwXDDXTRvjFZnJ4FcMqFz4dHZFp7xf0zP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R3NzbRVf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R3NzbRVf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2627269d5so76733685a.2
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763644847; x=1764249647; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=R3NzbRVfvU+7OAblP8iBL4gWs88U93QgmJFDXZEEvkZUnVcEb1tHEAeOoIiLPJXPOd
         F/Sr7PwF60gQjtSbhuNgI8RRRa1xNFf9H1ZreBLelzJ5ivzrgg7mpODHl8WX2I1joW+D
         S6KnXSBBJSysBBrwQIEfcPmqDvtAJLgqbeqGppl832+lN3Y8O05SPw7k95HppfbIW7gW
         psD+1a9Ve9lw6yncHjtl61+Ovyr76ylWmEubXoAFSE12qOe2SXDG01WsNHY13rD3oFgL
         verEgYfsMwWBeRhtcflBT9l217J+4vCPaEu6b4U9DgfVd1N6A5cNFEUsUM8DiiL+s5W8
         fM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644847; x=1764249647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=Sm/BtwnbdPL2bWV2ogq7gyFteUCBry5/TKcdkrx6iGS/k6vxsa8FnkqJcAQVkEIeOM
         2ywPMn2EVBcxjlh8yoLvnEdy66FKgRiPzvZY3OSJw+ZmroVp+1T54wFOeDLwXeBCTVMV
         QDDrQco7fZifpgyRs4RI3ZabAeE2SdEU+Qrr1pJh/wAYi7Cr36X+z6KG64Baw6BcFTQm
         c5ZVmdp9puEMQuGDmsOI1fE4DlM8ahBRP0cBVUQa2PA5SeaSOi3b6Lzqm5YkiJg6xpi9
         R65/2Quhfr8NnhsZ91eznvfWXIeC+2q69ZdEnE0NL0BpvylAMIVIwlKAi7v7nI9tdxdt
         oMNw==
X-Forwarded-Encrypted: i=1; AJvYcCWtxsTSbplejEf+ENf6zYwHjYNmsycXnNTsMU4jZ8YYmoJQ6hLd9uvBeXh6gQlNm197HrjaAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsDeHOBpxU/yQplrgENofibLeO7NGpxbWBE0NFiCD4mrkANPM+
	hJrnbAkM0yDJAxr2gzScC4/vgGrfMpS5vuV7AkJTLa8g4Q3/ABa4k221rGLgpO+X0/U=
X-Gm-Gg: ASbGncsRnKbxvNUeFZy7r3lq2hsGACKTYcUI4++7jhnmGCskQMRTN8CpncgD3jpBdBT
	NEiqJit5wKOYtyte52Qax6j3xYaMnzWWU5OTeimNUe8zeN0hSjshfAo1DlZW5O+38wq4vMoAB7w
	y0ub4ORcI89O0PYnX8d7fOZ75H3fodqQX5oqkXewHIu9cy0hb+EHzALnTJpTORGl5FRxfM3n2j5
	Utsa9DbZ5r8Lnk9gSw+VKu73EXaTZcYFLUu4iu0+1Hu35JWrdH5DZ5vKo/s/YHE8OZNdZ0mnz0q
	n4tahqmILWAJ4UMPLWnsTxWjZWspVGAdLnSm6u+cWmIe5todProtM0qGsLIMq46QOnMEioZf7A4
	HG4BY83mGTLf5fjgVBd9AC/3m87cZ3Z6Oof8Bl5VKP+kKbXuJpW1EwfCPvVLeD8mXhWg1i6Tajr
	PFJ2ZIUR8djRNLviDf/3PZ7ZbIz6l+0bfaR/gEARLyCPPxdhbc5+jMww8l
X-Google-Smtp-Source: AGHT+IHQ4fmxCAI4/D2tK1B8sYqUFbudidu6PckWMercsX/iRS90WBjHNHkg95yPWC8b179KW1QKQA==
X-Received: by 2002:a05:620a:318a:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b32a193b85mr303322785a.54.1763644847316;
        Thu, 20 Nov 2025 05:20:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13ccsm148498285a.26.2025.11.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:20:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM4ac-00000000gLM-0tBz;
	Thu, 20 Nov 2025 09:20:46 -0400
Date: Thu, 20 Nov 2025 09:20:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251120132046.GU17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
 <20251119193114.GP17968@ziepe.ca>
 <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>

On Thu, Nov 20, 2025 at 08:08:27AM +0100, Christian König wrote:
> >> The exporter should be able to decide if it actually wants to use
> >> P2P when the transfer has to go through the host bridge (e.g. when
> >> IOMMU/bridge routing bits are enabled).
> > 
> > Sure, but this is a simplified helper for exporters that don't have
> > choices where the memory comes from.
> 
> That is extremely questionable as justification to put that in common DMA-buf code.

FWIW we already have patches for a RDMA exporter lined up to use it as
well. That's two users already...

Jason
