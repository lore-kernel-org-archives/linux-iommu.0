Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C081872
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888378; cv=none; b=dR48QyRheo9yV9Bpx6E1G3dNZJvbSA2t3PyONY56dQJWNQe2O3MJK70njav5MeiD3lsFeDCZhG6OpYuop4kKVa4UZbZ52Ex1h0VKFizfkjLLPkvYw/AdwRefpb8snODFMzIRiCT5LKczvLppuBpIUjwREVfS/xp4/CpOfsWhYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888378; c=relaxed/simple;
	bh=4ZWofalsuZmb/ntmgNIW+GtgsDeiz2TAm4x47GB9Y40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBv0O+2nMzpPmE+wKQujWwKASnvDf/OBI+Q+bug187MfCN0dZxm5zjRrlBvqZB6CqyDKXxzWEisRTEJP8KeavieHdwuWUCJLGsWLxLmugOtQ5oXL1SQDs/wXvWyAfA/q1plzFOMJ+pVtcsFjyKclVVPh17nLWgyo9rpUcmZndZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=auHbB8SS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="auHbB8SS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818a9fe3d4so11738266d6.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706888375; x=1707493175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU39QnoNXjcBC7nfuMXyZD80hgMpGm0/TrjMwiAD348=;
        b=auHbB8SS48tGemZWw5Zt3BtfzdqibAenfgfSUMMiPSOMVEpMLqhCsx2OBWe5SR1Zh3
         V4CF+Eqqrt+r5RuO/nU5FitiugOLyMSVfN4VXn+3lVYP5nqhJnKh8Gav3wnKjcEQeTsV
         OknLEZB7D8le2Ch4UXsYtEj59pV27KkR3nJkpt/XTu5/QQJD7VZlh3I/ODxnEroQnbto
         6nXU408PZThOW3jOGkzeDMm1AYNHL93Poly4EF3spJXJsq4soXRYcvIP5dw72aG5L89q
         80iT/c+8PglFHdvZylfVC63aKK4MziQmNQg6O7bnRnirZWbC6MzdPAQEde0K7IRMpbl/
         jtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888375; x=1707493175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU39QnoNXjcBC7nfuMXyZD80hgMpGm0/TrjMwiAD348=;
        b=i+4IF86z8Nz5GQOXW9xHyxa3NOYoi3y6lcty+ksNFx0lICNZ+1N4LHFHuul8HjJqlI
         XCMb1i8vFzDV6/PyL+kdlR0lS9bbjWTRRqy+7V9+hc79N3vaJjw0yu8j8lLRzlkQC0ta
         ewHD9k5zmZ07ZNi3Th0RxKdjJAlQDMVa5tu4lcZJzcViHZ8Mdfjqn7gti7yz87b7fwoy
         lwICCjYeWm6Sgm0qz1CEy9KHHTUMsWCCK1II5Wldg+9nEe7YdmQncF+YqITAp5a+G9/F
         qvJ0OUoauPOmiPhVfz5e7b9Dp5aNtjIsZ3rcFaVBJaZKLqtM/Mytf/MTKbUDp/DWLKFu
         F++Q==
X-Gm-Message-State: AOJu0Yzp4UUEEpi+P28LZTVv8GD5fhZAuVd5vNMUEV7VUTe1cHKB3R+h
	qdSv6xywRLQ6UDPTdk7Zlf5KJFju0+noyD9TTTXrEmgh3QBRzo37QAN+Vn3CZ54=
X-Google-Smtp-Source: AGHT+IHiw+AEztOJJqEv+FuIsKu3uPT1wuYZJmWuQWWrW1zNDN04EQCohZ3acbfSojrNbGI++36prA==
X-Received: by 2002:a0c:f38f:0:b0:68c:83f9:fa3c with SMTP id i15-20020a0cf38f000000b0068c83f9fa3cmr2468777qvk.65.1706888375070;
        Fri, 02 Feb 2024 07:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAceCf+KoqRHjUTfSYwJrnQ15qAFsD6FwrGJ2OFm83JtDL7BCcZ/JsXY/5AxhcVyY4PpqDhCNhmskIo4bnmfKFlnH1gdyuljk9N9A6RnVbD7VFgPyIBMiqoE7i3je93SXXFLHvDaNhqHmcMAJHesqukN2bjxRk80vE9JnS8KH13l3/qeMgcXk5+9R0/zQz9GPCOSwQuXjSJt5A57Jx00cSKDI7wE+ak37jQMuUKmDmKDWRbBaAwyoy/zwmAwHto2S4SNtSHUVKoA3T4Dx/Fk8HPdodxFAAcwWVoODL7tzBMw6nO4Hoe+jHcs3lTw158b5TQWmXQ9KoSlg3gamJsCzztQ3HoAMsji5xXx5ui9rJ7AmYnYSUazsT258mSUBa4rhB/BL5gpgyom1msg+dVxRl/otZiHF9Fy3QcRq1SV9hbIB6vHMa
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b007840a2586cbsm760828qkn.110.2024.02.02.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:39:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvde-00AwI7-14;
	Fri, 02 Feb 2024 11:39:34 -0400
Date: Fri, 2 Feb 2024 11:39:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 16/16] iommu: Make iommu_report_device_fault() reutrn
 void
Message-ID: <20240202153934.GB50608@ziepe.ca>
References: <20240122054308.23901-1-baolu.lu@linux.intel.com>
 <20240122054308.23901-17-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122054308.23901-17-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 01:43:08PM +0800, Lu Baolu wrote:
> As the iommu_report_device_fault() has been converted to auto-respond a
> page fault if it fails to enqueue it, there's no need to return a code
> in any case. Make it return void.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       |  5 ++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++--
>  drivers/iommu/intel/svm.c                   | 19 +++++++----------
>  drivers/iommu/io-pgfault.c                  | 23 +++++++--------------
>  4 files changed, 19 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Typo in subject 'reutrn' -> 'return'

Jason
