Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D9487BF
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963935; cv=none; b=sT3YbzXCKJlqgOaIdfEBNf555aWfvMHscL5/XqC9fasittKJmYJVN0Bs0+LlXjzEs1ntdW0QWl+0NtkOBPuHQLI6GVSjvuq0QoY/OKzGabxU8lSqUSqcQNyehvzTJyPS+77Vkpj55fManVUI2qP1gTTeNJK7pVOn4nLssSs0TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963935; c=relaxed/simple;
	bh=yGvpZoh5vCSJK/qbn8LcdrNoO2Wx65yHXP8tJqegytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3m6fz92r9K7A7ExxJoE6VZ/tY7KjpTiExIaXRGa5CdsH7/oaV9QpVCTmcxkCtqgYdswQnYYZTLyqYGCi8cjxCJ1R4Ropxg/M5ZPjB52IrHEtLIDTZRizQ6WAvzsKcaQ2gxRnufboW0leuBtepuZph54gpCgbPkQEko71RVF3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kOnO5Eo8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kOnO5Eo8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7094468d392so509383a34.0
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722963930; x=1723568730; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FF/1bBloQvKewzJ9i4AR99oRC5uWACaYmjJ4UN+yhI=;
        b=kOnO5Eo8EvYfmK1x5o1j81K91sM3KqPvdtl1JwKirydXTJ1H7Kb8u2SMLJ6EmHqBoS
         hD+tu3h9KTk68Fuiw6GNp7PeUbZhyug9ZR3VzrBB/pTVAk8fZG+KKEyWnYiIRQPaaI29
         vEpnkVbU2q3ZhQkN8gURLN+AF3uFuVU97f5HtvvzymDQzth/yTTRBgAwYfSgOqtronj8
         eydDCIN/rmHzXjujmHNCAuHv+S6G4KnNVwSvDCTc4qYFBkeT/6vw5MyINhu+TXmQIzZI
         Se299FnNWbX4Gfg7dqoc5oSQctPjZ3tYEloj1ZSVgYuTJJjPexYX8MsIxErVgQnbmgDK
         N4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963930; x=1723568730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FF/1bBloQvKewzJ9i4AR99oRC5uWACaYmjJ4UN+yhI=;
        b=T5DxEkKjcgj8G7aWZEqwMwilzxnxzfEe2NaFCUvUzED6j7qzklo+EJwwlcPIK21PcE
         lKwrLkUT4DzpS8JhN+uJM15Nt/nQZ5FMuMlv96COshBTyFSIAM/N/l8jmv6J6pwXEljP
         lU17HMtFICp70tp6necgUsQYpA7a2GTOcTglnvLoqAQOpyS2WljeC2pgtOflPc4OlU8m
         X5FsF/T7rnwngaj/3k1DEgCb8QS9h791XAO/k0y82UIo8vE+nS+99hV228sQbrWKb4qw
         FjwCzjJf7HDy3h8mb2c/xOplR2UztzgNJghjd/3e6w+pCEc9ZP7M7b3qRvBFBgIGoUxT
         HHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsy5RuTQq8HfSnyrRwGshCFzMhYweuP57/WMdREPili1wXHrHzfNq2QG+G1ZNUJGYQgONbu6Kec5gWvqCv4OEPP4tntt4=
X-Gm-Message-State: AOJu0YzMXaDat8r432Jg3iaE51mVbbtu10XU6ZVHrVY7AbZ2K+QE2J84
	FJMqRflMrS4MQoKKF7TstB6TX45rWMVn5IUItni9WuUQy7ER+JowKohbTuW0eMM=
X-Google-Smtp-Source: AGHT+IEfBFlT4KzSQTpw4KAX++80DJzKla5Md85qMeUYrxRTC3yZCZpkl1YY0dnUlf481tT88r1k6g==
X-Received: by 2002:a05:6830:380d:b0:709:472d:f342 with SMTP id 46e09a7af769-709b3201792mr21629352a34.6.1722963930227;
        Tue, 06 Aug 2024 10:05:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79744esm48125606d6.40.2024.08.06.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:05:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNcn-00FTSc-AN;
	Tue, 06 Aug 2024 14:05:29 -0300
Date: Tue, 6 Aug 2024 14:05:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
Message-ID: <20240806170529.GK676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-3-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:36AM +0800, Lu Baolu wrote:
> As the driver has enforced DMA domains for devices managed by an IOMMU
> hardware that doesn't support passthrough translation mode, there is no
> need for static identity mappings in the si_domain. Remove the identity
> mapping code to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 122 ++----------------------------------
>  1 file changed, 4 insertions(+), 118 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I always wondered why this was so fine grained, I would have expected
it to work on blocks of 512 x 1G, once you allocate a memory for the
1G table level you may as well fill it with identity IOPTEs. The only
optimization point is how many blocks of 512x1G are needed..

Jason
