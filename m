Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D1F8F19
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338415; cv=none; b=R3SOKvv7VwO/A7aIifrpsQow14f5JKJR31Tz73tNfKoW1T10h/NF9CcY4fBwiMUIshOG+kZFTBT8n8+i2VJsFRt8tIFQhY3g5VI0b/MBCf+veuSk/2qaUQUHW4PZPH7LvzkuLgmU2oAiI0tZoZqsR3Wela+LKgDHsKAw/7IiTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338415; c=relaxed/simple;
	bh=aTUCe0dIJTabxq65+duMjvQ0xwrlksWU9hqQl/Sd1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCfy6KU/44xyvdtKJVWPDxd28PCFeBhkOsWYVA7G743KZguj141OTwLBqYcMf5T8Cb9i2M9wqpDCCLYbrPWi7Yp2jbrA3ePzbp6fLzqidJhaIWskTb1yic5W+EgKi1iUfIIaPLdtYfvLJzeLW3B7M3CaB+iSOGefNvqJ8eF4LtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCQNjU0U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCQNjU0U"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso36455e9.1
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736338412; x=1736943212; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrYofVOoKvKwnZPsYWd13Rqdme4LuIQHlAMqCcS50NY=;
        b=UCQNjU0UwqEF6qjY8a985jO+Xak8O6na8Cbd+ue+tmBc7avyxP5PriPPtBbMdE+EJl
         sZmm7F5vRrXryp14tU8m2bkgCymwqsyKPJdFAL/Hn27+kClgLxBF2Jf3RR9c9ZxiJW5h
         pXEyrsF4DwwZuhSZiacSf8xusfwv6q+ylMj0GGvTxkRCFBb6seOegvpC2KCpRwiA5aBX
         3AMhSK242NkCbMzYnJC9JIW0Aakv3GW70tMmjQEsm44bEi9UxFOK5PaRRV9Nio3b3kml
         2V4nrB6WYrM1clttfFh+HtVAOf5LkAJrYiXI32UjgHEzcbBY3ELb8d+nQMiiC0htnhJL
         6wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338412; x=1736943212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrYofVOoKvKwnZPsYWd13Rqdme4LuIQHlAMqCcS50NY=;
        b=p4f/J+Cjl09qOiKVyyYQp+mX9WYGofi2sWUzykqQXWfHolO35xNe7QzqX7jq/5nQSd
         xD2cvYacE/iuRFQUEhZ2oych949BhLLELO0xyDM1VlnR0MpFSVcvhKVNQEkqc8/LWqS9
         qRbGxRp9xnFNlk+K561EnpQwk/sSaoAuHbtsssmKSh4wbSNNW103HZE4mDBNKo4SQxGP
         M2BjJcFIlwk/a5yMgkahRRmPdg2+ntwt2HojiUfeQ1SODvZi9/oK0VBtVAmVrpL05QHl
         PyfMJtxND1LFn/2jIbFQilpxUXYaWfkPc0JQ2YjseSDiy56dpcKLdiHdufp8E5ewFb2i
         qFaA==
X-Forwarded-Encrypted: i=1; AJvYcCVbDAYyIhAnQPYNDmCEOVgFhJbL3Y7JdbkTIjUz4jivW9/Ixo5f/PzjBsnEYgCF4m83aOnmRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbt2y40aBEPJlTDjN10Ib44Fzjlqioyp+Bj9Xzzv0vDf9utoJ9
	G8jNyAlsR2yU+Y3AQk/3MdaF1ALel3wrSDlAvYk+NDs8FZUQ9cQDovI1OpawgQ==
X-Gm-Gg: ASbGncsrAxOr9S86sfq0xId6RjrRZBr2OfnnkbIQZTLaCA4fbwA4OkrfvuEaISvNpzS
	S+q21wS8BiJEySYtZCq1b7K0a6l4QB4hWZiJKfkuxUzYu2lgcUZ/rvtKRCDVd37Dp7ks8oZ8huD
	MkfrbJ6VlfMb7hWppeS6Z0x1BqTHDX+9/4AeyGKLs/XoX7sn5OFcqxLnDK09wvgiHM042zwE45z
	oY0xOxXkyBa3DNDgacSok6CzERkv3I6JrIrzbe5ihT3/aKZCQLCyRjx/xz9mE4+/WZUelJOA46t
	NWTXAcPp3rqWOLoOV9k=
X-Google-Smtp-Source: AGHT+IFSxU9Nih+nRcbTdqUehEVnjBOqg3Pc7JvHWVRd2oCHQ3onm9/9x+7dn/+oiTY0W8mf2rq1iQ==
X-Received: by 2002:a05:600c:4818:b0:42c:9e35:cde6 with SMTP id 5b1f17b1804b1-436e1f879cdmr1023645e9.2.1736338411667;
        Wed, 08 Jan 2025 04:13:31 -0800 (PST)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89ca5sm18817135e9.29.2025.01.08.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:13:31 -0800 (PST)
Date: Wed, 8 Jan 2025 12:13:27 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	robdclark@gmail.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com,
	tabba@google.com, danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 55/58] drivers/iommu: Add deferred map_sg
 operations
Message-ID: <Z35r54_zgpmO6FQ-@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-56-smostafa@google.com>
 <ce4c8db4-4895-426b-8d9d-97dc5d74fbc4@arm.com>
 <Z2Qshft8lQjI-x7c@google.com>
 <20250102201831.GB26854@ziepe.ca>
 <Z3gDuPe5C1Uj7y4m@google.com>
 <20250103154757.GG26854@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103154757.GG26854@ziepe.ca>

On Fri, Jan 03, 2025 at 11:47:57AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 03, 2025 at 03:35:20PM +0000, Mostafa Saleh wrote:
> 
> > An alternative approach as Robin suggested, is to treat all iommu_map as sg map,
> > and when the driver gets the iotlb_sync_map() call it can just issue the hypercall,
> > however this call only provides the IOVA range, which requires extra work or locking
> > as mentioned in the thread, and as Robin mentioned s390 doing something similar,
> > I was highlighting that in their driver, this call only notifies the hypervisor
> > about an IOVA and not an actual pv map as pKVM, so it much simpler in their case.
> 
> Oh, that is much clearer, maybe incorporate some of that into the
> commit message.

Sure.

> 
> We are going in a general direction of trying to make the fast dma
> mapping path not require sg, so adding sg specific optimizations to
> the low level driver is not good.
> 
> Batching the hypercalls in the gather and then flushing to execute the
> batch seems more reasonable.
> 
> You could probably work on advancing this infrastructure separately
> via virtio-iommu..

That was my impression also, I mentioned it in the commit message,
but for virtio-iommu we need a change in the standard to define this
operation, I can look into that.

Thanks,
Mostafa
> 
> Jason
