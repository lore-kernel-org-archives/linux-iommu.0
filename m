Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AF2101BE
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640941; cv=none; b=Nk9toypEEvPbHsJnWU4uzrXPsRW2BMNx4W9/7wLqhNch9fFdpZARVpAreAJLCVSVZ6QdBooR0lFLO4YRZyzAI6ciVmZPeeubsHdm+XnqAGGZR5dkqPVUr4+J1tVDnOs8t9x8hS2Tr6V2BwB8f49T86iZKiMhb/3Arv39oUYiNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640941; c=relaxed/simple;
	bh=dE88gxhC6bvegXa1UDrJO+CZhAyplQTaCMSznObQIEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKYjNQiIJdvwf/Z4DBFxgRycbcKJNj5QFJGkf/KQ0qPySpziuG/pzh+pgyovf+dOuLFhWPABqXzIj6BPe+jmX1Fh4/Ti8wc4CG9Fcfx0vEf+GB0jx2M/sk1zwa7Px5+4IkhUg6Hsi7kjtRWoz6RWFPKHnfht0YXQ7aBTUXxpyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrfLm0tq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrfLm0tq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca4877690so86985ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728640938; x=1729245738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hj7U9ZPr35bZnCvo43Yb2EON0cK+c8hSIwSqhGJ5z/s=;
        b=RrfLm0tq6U4kPx9FqKNRwyvJ4PaH+jgOYLKtP1VttMQKw/VLcGeFyKSdNjobIbHook
         yLaPZISw9M4bmjliZXLuczn1irAAB4mlTeKaEWI5uOwSmJN6rgQw9y0jam2a9NY14cU1
         /H2K3w3YVjDux/IZ8EuU3pXjv5VB9kWX58s2mZJE5o5PKCCrKbZqVUKr3ws97PaWd68m
         7A8bUrKlRrkXn5JTCI+3Krn4GU63DRA480MTzGoT58VgDveSH1xUokaItaCS7Lsj1A0y
         heM8duL61IyXj47YYLOEQQOaJFZEPyMDlt2QZW9FdMA+AXe9n3x4l+hMcxZmoJ1SGXZD
         e/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640938; x=1729245738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj7U9ZPr35bZnCvo43Yb2EON0cK+c8hSIwSqhGJ5z/s=;
        b=ugEegobvbeP/Y9RzrDHhiNORAs8E6x+zWBtWCptgA3WD7rFqadXFpjlhFM7axMjipv
         /B1XKSWhzFWBdNBkAFfA2NIPrLoDfhOvyGGyh3ZRGFreXAcbHGbUMFFeJj3+jkd7hdBK
         VF1U2NPYu6iJZJLNw2AUaBUTUFus+hEZZIzLhFK3spn+XRZmosgNaJPftijt6qErl8bh
         0Txw74ktQdYAEGVIYn+6mJpfLEw7vjeuiNi/pKYI499v+sXefkmfJBQFRNXiV/zA4QLg
         TouEa92n0l9vk1u6qIU1C1D6oBVdDnVkG38EGhZ3OovJYppNjQC3GQ4Z9X9stz3KxzBt
         m8tA==
X-Forwarded-Encrypted: i=1; AJvYcCWi9ODLfuLmq5RX3UYxMYWutT3XDkZ8Xsnk2178k/0k44DItl3seLi7M+9PO+Blo3j58UHyZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHzkopHVhrACCor+/Y2CilekVQqtAt60LYHjZ64Uq51oTgLuXp
	ZtVsvWyJozZ0p1dH/BqjE+RlrKOSnwbRTkZ9ryoHZbyqyOBJvy4N3O9iAGX0hg==
X-Google-Smtp-Source: AGHT+IElNBgVoMPwIjJAi7jmwfgDkttE8Vx96aGIBn/CvRkd85eJgoyqxC6dkLzVHLC5j9N83+z2wg==
X-Received: by 2002:a17:902:d4cf:b0:1ff:3b0f:d61d with SMTP id d9443c01a7336-20c9eefff3amr2304215ad.24.1728640937391;
        Fri, 11 Oct 2024 03:02:17 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e85f5a37sm1790863a91.6.2024.10.11.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:02:16 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:02:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zwj3oaVlJH26v7wN@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
 <20241002171052.GJ1369530@ziepe.ca>
 <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>
 <Zv8MDB4a_P3Jj6x1@google.com>
 <Zv8fob01iAGP85ov@Asurada-Nvidia>
 <ZwjZjumyCCQJqSVC@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjZjumyCCQJqSVC@google.com>

On Fri, Oct 11, 2024 at 07:53:50AM +0000, Pranjal Shrivastava wrote:
> On Thu, Oct 03, 2024 at 03:50:09PM -0700, Nicolin Chen wrote:
> > On Thu, Oct 03, 2024 at 09:26:36PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Oct 02, 2024 at 10:22:13AM -0700, Nicolin Chen wrote:
> > > > On Wed, Oct 02, 2024 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > > > > > > dev_name()'s result can't leave the lock either, at least not with out
> > > > > > > some refcounting on the struct device.
> > > 
> > > Agreed, I missed that! Maybe we can avoid reading the master name in the
> > > `arm_smmu_get_evt_info` and move it within the `arm_smmu_handle_evt`
> > > under proper locking? Since the event won't be dumped before it's
> > > handled, we can avoid locking at two places for doing the same thing?
> > 
> > Yea, just move the master_name closer to the locker, and put the
> > dump() inside the locker too, either of which happens in handle().
> > 
> 
> Ack, I'll read and dump the event within the lock acquired in
> `arm_smmu_handle_evt` in the next version, while keeping `master_name` a
> local variable.

On a second thought, it feels weird to pass a separate "master_name" arg
to the `arm_smmu_dump_event`. Let's keep the master_name within
`arm_smmu_event` and read it within the locks.

> 
> > Thanks
> > Nicolin
> 

Thanks,
Pranjal

