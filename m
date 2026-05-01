Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AC22652D
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640412; cv=none; b=DMq8kSSCq/VaT/j/41nSzR0jmH1CdACNAv03iMb2uO3eCdqaDv2YqO+mYQNIX0Td6HKgZw1AhPLP8QXzmfwy/AsfwydMTHuerrZnYKgJSPp32F3BEnp9s8QtMA8i4317QVgoMRw0i4zmC2uHRYcYXArJ+l1/m/YiiJWq1UOqk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640412; c=relaxed/simple;
	bh=sLCEaWfAO7nUm59+syKMMoJB8EG0FMX2rc04JgPJ2aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxwTXcq0ARWeIjgzZg/G4WCoWYL5I2/o3ttbBtt8vnTjcGjbttWqij/1QxHhSNtiK2la762Pb0M32FFKsxmMe5X+vye2P7mBdGPYlRJf3z2a4mksdnVAFenRHkPrSGRe1tmI/YJBJVVbj1xTzhOlI/SPK+4MJN0qrSI/n11OzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJyb/ysi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJyb/ysi"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso19675016d6.2
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777640409; x=1778245209; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLCEaWfAO7nUm59+syKMMoJB8EG0FMX2rc04JgPJ2aM=;
        b=dJyb/ysiePzGLx64cGNzRL2gvON4jVxo2X0Xdw1piMeS4HC5oIDuqMMPGGigSEonND
         GjQ9YmHAIZZ8Z9EaHnjaF/TurpE5Z2W074yA2xtM69uB4QLX8Dh3cgK0TTu8HY1/OKgg
         yeI5U3t4uTj5lkPTL0GFXTIrw4qw9ches7V+dTtlo3RSHlh8cLXmB8WbevXNuUcDLyh8
         /XDPyBQr3B5L+BlYWMzxfY92h+OtH4yVcQwfQm2rle3yhrlNaDhTrj9F9g9mHY7O8KGP
         hIJwyArhyPpFBoXTpKr4CmbYhgB/MujTM5XJ9L1LXMBGuDvj/it0rTFM70fv0vS3niX7
         0QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640409; x=1778245209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLCEaWfAO7nUm59+syKMMoJB8EG0FMX2rc04JgPJ2aM=;
        b=QZyAPRO2X4BjA1IJxBbEGvFijS7bdhLMBzvXjiibpp3JFhAPxREnbGKSTKByxOD6Ir
         XzvTGyUlJZ/QdKwUZAkoRZmTernnFqb7nDXgSjiEkaZECAICSNGF5CC4aHzh4SUs05v2
         S5/CKbURzGIQ0nNzbS1w+TMn5nCUV961CKr+0BAubc3L9Xef3WT902YOEBwKdYFfCNe7
         DRx3mWULe+CuhOQd8QgRv61YdyKe2F/MB4b3sJgJR5cdhbGVyLlxNdRAdfN5fWuvbNe9
         F/AxpMMoFILBfwV2NiD9K4vRhh6tUyrosm6Ph+qy1CCSEruVzC5mPulE7Og9mFOrYL6L
         9xIA==
X-Forwarded-Encrypted: i=1; AFNElJ8UchCzI2rAloVfsJPwKviQ+VAl3uyJUTN7l1gG4QzN7XyCraJrgzum/IuKdJviaYmPF0WMKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5+4FSnYQ1w/5mTm6HEgQZ3WVcSmdQbJfxoe2k6GG0PB6d3INZ
	LJ+2Xegyu83dXwR/Q+SE+XFsh5gfUvFOZdhVqWB+RkOXDT3nw3ra+HHgy1svUdpOfAY=
X-Gm-Gg: AeBDieuEd8Bkb6hW5CyNNqhAhh3lLjvf2q4e/zGiZQw+UKl4wF08EoFT4HZS3V8zenV
	h3Unk5hwR+ThyzaRzYUEVZjNvJ95ojWnYjcnk2uOYJYfNMq8UFpU6AbDx0Hfq6HaS146bvBrGyH
	tiqLRztiFeG9D7oLokZ7zGxMkiIWERTMhlSe3FMz6+xbmaiNoIA/8yODXbHnXgUjT818qkxarjC
	yJTcnLyeS7jH8zynuD2/4JN0UceJFvR+0/wYNF7L6ynActTB/GmEFvboWSZdvasTawvdaZpE8yc
	DSZQZdGknSnxB7GnOfjUosoKTCUi+gugRY7EE3QFIgBR9ZHSo3whTFlYRZEZnHSJi3Irr3cM+UW
	4Ne1VE1KamI2iLZ+BzZJfabcWQNYfrW7gRFmrSH+aia/4zCV3XmoOJMi+PDYHcQ5KB7gk1medvF
	KKzpL/GuIBlN4kXP6D/VcXM+19/XDEhV7zWRaiO45O9XWEVwmNoiC9TC+UZiEMktiL46PbqhV2H
	JuUEpCzfjId2iIcB7FfjKx0jhc=
X-Received: by 2002:a05:6214:3d85:b0:8b5:e126:e77d with SMTP id 6a1803df08f44-8b5e126e7b5mr18314046d6.8.1777640407970;
        Fri, 01 May 2026 06:00:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c7accddsm23110796d6.36.2026.05.01.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:00:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wInTS-00000005DWr-2vHb;
	Fri, 01 May 2026 10:00:06 -0300
Date: Fri, 1 May 2026 10:00:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <20260501130006.GF6912@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111928.259252-9-smostafa@google.com>

On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> Create a page-table for the IOMMU that shadows the host CPU stage-2
> to establish DMA isolation.

Is there a reason you can't just use the CPU S2 for the iommu?

ie the CCA RMM is doing that, it is how ARM imagined this stuff would
work.

Once you start supporting DMA like this you have no choice but to keep
a fully populated at all times S2 around, why not use that for the CPU
too to avoid faults?

I guess there is a reason, but maybe explain in the commit message?

It sure would be simpler, you wouldn't have to mess with iopgtable at
all...

Jason
