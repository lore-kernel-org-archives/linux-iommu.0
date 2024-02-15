Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC871386D1
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019233; cv=none; b=gwQK62Osc/pgahTWeVQrd/TBNRKJchhNJn0CYxoT4Vgw1AkBViQPAKakVuAVVzoifAm5nW4SkiEnJ7H8kvBCKAPN9VVGwAyIDO9Z7zMYtD1egd1O+Xdb41QNY4rUYmmaDbdsANoBX0tmArOoNZYwT3JVM4hLSetNvOyz+5HLm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019233; c=relaxed/simple;
	bh=+dXm83v4lzGGGWoMkrAhpsoKvqPYYTZkbg+SCOnXjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJyaFwHlOOsH2UWQKMHbeHfR0sa3xKMsk/UP5rsw+2kb0V6httePqc9iF8vCz0S86JKo3Hd45FBYn/U+BEE9vJaxvJ/og3zlGyKECb2DBKB1jKap9zGCaca6aS/DCoyJRKUU23uBmMFaXeJwrf1kxtYxBs3ra3o4VjhBBzezcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qo9bxomr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qo9bxomr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-785d5705681so111745185a.1
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708019230; x=1708624030; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwxKYOTTfsVxRUkOMJlptUV0ZFZUoBorwA6GkU+MTmM=;
        b=Qo9bxomr1W0+GHP1ApUr5sKNO/qqg2b8mLTh15ftGQ8VkiMxjTJ19k2fMJNJbbJTNu
         TffDfS5JmQfz4KCl4VuRIc3REf7p23qxkFCsSkmDaRT62WUIpl0N8TFe1OB8iT0GAAtf
         HGNXg+JUMHcVEQHd8Hsk8oCutkX5wGJ+GSgBtBa37SQSfAnTXbtiQqqiNs0FuqnTfphT
         6rur1xgI0bA7N0vVSJJM2im1lKsExYulq1StgtTLY3QgO8Y6fLtliJfJP241GAEOxNk6
         l+nbZMTA2Du9RWO+n1Cfg8eK5s7f5/YLDCXNnSjsvAvQpmlTlNDQcKWUWLGP/SAiBIQY
         oj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019230; x=1708624030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwxKYOTTfsVxRUkOMJlptUV0ZFZUoBorwA6GkU+MTmM=;
        b=vqUigka/jufMExLGoRYikmplCxD+pvOwL26cdlD6XnuHdz08qTUzQEwaOX6SeWRor5
         jjNInPWuoHIxfOAmqWHvf9UPHIko4sbA+kTO7wMHqmLOcofxqA5LQhwWEVy57BqAESjJ
         XwAdwc7V2Lvs4mj7pNhWiJnn5Yi1tX4HzLIM7K2+t3oqVGXyjqYVuWdEu4XT4PEKj3ZH
         MOjC3HZEIfa66RK1TBeEG/WCkKgtexSF+vwZsutv5r4LaOdJHeCh+hkN2lpaa/veVAbC
         1QD+7hYjx16utCaIht00wH+xNoxmKhtvEm4VYw7bswh90sAVzAywGDeKFQ05NlYHgNnf
         FZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0M97h2iX9UNRXLRAl/AYH4oKVmWdgifNHZWXyU86q1kvlkzKnNTWBZdGoOckTRDRms1F+gbsU3Ww6B+VpF01HCved/3g=
X-Gm-Message-State: AOJu0YxcEH7QFsUmOdrSaU/D/OMgEZkULvABlEBh57/GWgK4zGGIg7gT
	itZkkUF6gK1Epwwt58X8Mt7tFPiaGUTZtQ3HylcpmHJejWENVCXPPbyMb3tA5/o=
X-Google-Smtp-Source: AGHT+IEPzBiyamH8HajiIAanCfaYKrF4d6zvsj2pCYaxgpaQcWPNs2s/mky4ykJihrWfUqWYewBaKQ==
X-Received: by 2002:a05:620a:372a:b0:787:2d4a:e91 with SMTP id de42-20020a05620a372a00b007872d4a0e91mr9362184qkb.12.1708019229933;
        Thu, 15 Feb 2024 09:47:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bj27-20020a05620a191b00b007873df5a625sm182249qkb.97.2024.02.15.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:47:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rafpE-001DT3-Rz;
	Thu, 15 Feb 2024 13:47:08 -0400
Date: Thu, 15 Feb 2024 13:47:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
Message-ID: <20240215174708.GC1299735@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215072249.4465-2-baolu.lu@linux.intel.com>

On Thu, Feb 15, 2024 at 03:22:48PM +0800, Lu Baolu wrote:
> Use a red-black tree(rbtree) to track devices probed by the driver's
> probe_device callback. These devices need to be looked up quickly by
> a source ID when the hardware reports a fault, either recoverable or
> unrecoverable.
> 
> Fault reporting paths are critical. Searching a list in this scenario
> is inefficient, with an algorithm complexity of O(n). An rbtree is a
> self-balancing binary search tree, offering an average search time
> complexity of O(log(n)). This significant performance improvement
> makes rbtrees a better choice.
> 
> Furthermore, rbtrees are implemented on a per-iommu basis, eliminating
> the need for global searches and further enhancing efficiency in
> critical fault paths. The rbtree is protected by a spin lock with
> interrupts disabled to ensure thread-safe access even within interrupt
> contexts.
> 
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  7 +++++
>  drivers/iommu/intel/dmar.c  |  3 +-
>  drivers/iommu/intel/iommu.c | 62 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 69 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int device_rbtree_insert(struct intel_iommu *iommu,
> +				struct device_domain_info *info)
> +{
> +	struct rb_node *curr;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
> +	if (curr)
> +		dev_warn(info->dev, "device already in rbtree\n");

I would suggest

WARN_ON(curr);

Something has gone really wonky at this point, right?

Jason
