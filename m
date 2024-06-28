Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03914267
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623515; cv=none; b=hJMzFwu6jNasd9wbreqGwN70CkP9UCFyNaiCgfiqLTBZBN3rActUpyDf5xEpFTP4K01RR9eMQ6Ic/azKO6iBZmZIUWABbKoNQY9jKj+bLW4rvxNj8impYvv2AaO4+7h3EO3sr+271PMUAvETj87c916XWFsd5pbwwkGinuRd5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623515; c=relaxed/simple;
	bh=6F/k6dwYH218Hyi1PGuaEb/Ijjso6ev6K6yn6UDiB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB2hUuzmugS90hP14ZPpV+ooG5UcYiBcHonU+d6gvwXSOOsRCAL/oC39MCv41azZ0HtMIHz86T5wp9rydQF+Ai3PmFGTfVC1BX0EazzRT6SPzCMLtzuDiKcQGXtbVtQRNkgVS5hbi05kZTTv42/da2wNBoglauftKtDvvvlfGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SAhOjoEF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SAhOjoEF"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-375f713a099so4803415ab.2
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623512; x=1720228312; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=SAhOjoEFfNHfrRl44u+EcYM7ZYwD4xZIsO3HFrfBjcZkVCtvjG287GsfsBv5yFMYSE
         dsLuRED9kvFZOdR78A9lnJVG1O309ln7Ot4Jf9FMb8ZAH2JnUMYZKf0+pbMiH4DzsARW
         ewC6CXvI2OqD/uv7jMIrUxyAUCRU3Djlc6sk2udEoXa9RwZ1a2R0OVkou/QRra3RI3Xv
         KTFjRghSDWmb515/HK7gecMHOjl7k1V9/voz7tnia5xXKKe4U7iY7MMJv9t/RfV1KWME
         TkAAD6JfqLeQRRyAStAsUWC2J79L5EnqJzX1E69aa2/wi74kyPujrKymYuJn9rqLZPtp
         EAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623512; x=1720228312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaMdKg0RidMIfRNkaCLQQUn8DgSGfF9Lh4khZx7QZA=;
        b=T2dAjakqvJJOS6ND9UoFuDL+94d539C/hxBlsdGZtF+VpEVE0X8KW/YnJOAjf/qrGs
         x4Pt4BuMQYf3zAOi51HKTrxnvHy+QrbbJz03MqvsQT4/UfrsvQGfq1IULBXQQWzzuhHs
         Ca6avbowcqobs6rWsE1B16DImjjY9OIikleSM8n/OLCbcPp6TuWa3U8Hr8IQFuEEwyzp
         ZVbBYoEcGX/Zt3u3+pk6FSXbaMkyCQMhdlTSTpazQb9mYg4LV8XufynvoMjzImq4EqOJ
         TyOOuQNExMabSWqKEYFVB4UuhUh2QvYF4WfFq/mBWuIVg2erG8bJq+njGS39Gr7AP+oO
         lx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz49/LDkWCMPDtzzvgiFyhWS9Sr3sFqThbmy1lcrOjd1Gvwx59xisxG3y7/7jx1E5935hmVsYiU5NBK9E5SoNUaxdnvfk=
X-Gm-Message-State: AOJu0YzgPTTT3wciXjoQq084EMuBOuDtnk2Kj9sqbWKdW9jaDX8RcGRz
	NeyzGrykCnylN66glgtvuMYR+mIc9zIUAVQY0yCqwG/DOtbCQLN9uuif7Nzobbk=
X-Google-Smtp-Source: AGHT+IEt4WuI6UUriXHM21a/iZG/YuB8wOThjfEiLBUbcEKDogKRn2+UhIh8HyJ2Q/QTwEKSXlIHrw==
X-Received: by 2002:a05:6e02:20e7:b0:376:492e:a13b with SMTP id e9e14a558f8ab-376492ea27amr214270955ab.28.1719623511924;
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIw0-0004UM-BR;
	Fri, 28 Jun 2024 18:15:08 -0300
Date: Fri, 28 Jun 2024 18:15:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] iommu: Remove sva handle list
Message-ID: <Zn8n3Cs7JDxzpRPf@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-3-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:47PM +0800, Lu Baolu wrote:
> The struct sva_iommu represents an association between an SVA domain and
> a PASID of a device. It's stored in the iommu group's pasid array and also
> tracked by a list in the per-mm data structure. Removes duplicate tracking
> of sva_iommu by eliminating the list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      |  2 --
>  drivers/iommu/iommu-priv.h |  3 +++
>  drivers/iommu/iommu-sva.c  | 30 ++++++++++++++++++++----------
>  drivers/iommu/iommu.c      | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
