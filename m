Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617237;
	b=SENxQgoWzSi0on21g557uSBinJ90V2nB2Kb63e81jE8wnrQGslGOBGqZdUve0JvgDNHv
	 yAJle3emd9IrO2whtsKvBmRN3hvwAfGzJ0yike+wCXus0dbzZPHuDkNAaUBOCxAVZZe9A
	 g5TtmLxaO3a/c5J3gV0ZEnv/3Rpan0ZCblqSzclSm+f99sNCY5NcKJtbSYK0z6bLXkqTd
	 zNciPUKSB5nXRms8Ol+rjg/RJ/fRLzaEbomeN6XFZx0yq2dFxe7Y7l+0uXeK/kL0biX1k
	 ryCxOJI9QnG6OnKfExc2TMrtcdRohHEgeWAkb4KElWsMbVyHOqR1qtZNGRERb513AvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
	b=1gxJPJQrq+nfVxuwvA684BJQKoKg63nQjDOBwsSrUjwivoMO9F6WewBG5T0k5tTxXRN5
	 8y367Srpkvh77LDt1Cf8D4MdFXRa+iMS3auxn8n87J28I63IJXm3vYVEDEPG7lEGzNkJU
	 mRGHaxvUx27KapWhexR42TSDVs9/sXge5SijLL9URLOP8xhzLJ5Masnv70Tl5CkPx2Bb2
	 lxNpq5tDsPdaBfE9srRyGpcqRg+zn2nCtCsqkQXsze3KaHeJqYOevAemsxYFo7tvxVAJh
	 O5VMjn2dKe5K9akEEKB4BUmT75bQ34NuX5UTnMwMq2k2IGWzTipaX/luVWa5/5pao+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ItKA60hk;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA7606A333
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 00:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04EA7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ItKA60hk
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-554c0d47d17so31464641cf.3
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 16:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794617236; x=1795222036; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
        b=ItKA60hkOGpgl/dQoG/1+S+NlqSnFvFYN0vI8wAJN2PpXt65Q7LZDuLbXS0K/YXz3l
         HuRGkxRV8yZfDL/zGTwh8CrqB+Romx9eDpOcaX+YRd0IrVyRhrJbNb+lXdsQl1n8WcO+
         uhyaOls8vII+qKzwo+ELqNiZakrQMGm+nRX+1dywtcrWr52YbWkY0D+GTu133oy4plvn
         oZ3l9QkmjFhexatY7gCFdH1+TIfpOeugo417zbj9omOKiVns5ymOixgk44q1NbTINiCb
         K8tCrwQYq4VUrkvfT3quRkqWyD4lXXaxcAjHTPLh+gALmcSow+1HOfFEeZF35APFPMXX
         FWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617236; x=1795222036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFWoksDl/YSxzzEgBxVNVr0WRDbY63H/etkwcboJjXc=;
        b=X07LmKebcArNKGmGN6P9Y8TSccnToo88ZoyJ8yu/NJm76fAffoNjeB6cANIITh25Km
         S0iUyZK70M2DDaRwbM5lEBZuSYvEQMAzJm1TCNwuMF7I5/goSXHMKSHIw6ePmhG4q9LK
         rNjVDGDRVFmYJwnNB2X4EYeTOkFOPOjA50scmbYcJzATs8yqa8Ok7XEeIclRNpOzO5w1
         jeMQMxd3OLqptNE/LYWJNh29ZeYXaStvP39D2QMTTxtO6us3xmJjxjV9tFusttv428Lk
         pk6Tz3v6MsX8WY4l5S0XbZRLGxkuk3UiDor4inPCe8/1P28LK1WCNddO7ocjH65+aOIC
         ox+Q==
X-Forwarded-Encrypted: i=1; AL+hErHT3+z2jqZKx5h4FR0sWcmINymlhWNaUxLuUL5aiqnYOhWuREcJwhy+W2fjLGGQsAlk/M+jxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/qrq6X0HQpHCPWSIZ/a/KVPNoSZh1U3D9wJ9gXcSZ+AdRsTMSV
	AqvPlpIw0rwUlwi3jvGMlyDZsly/S5mkPgWLZCCJMkmc0+4wludua+/2DZ/d2QOjX7w=
X-Gm-Gg: AYBFou2juW444T4Hqu86NT38EIgHgGG+vvltRrCYOBnT8TDILUdCiUb8sVMQLQTxzAD
	KkCbxCc00IapTJ3ZBsj1skVwJ+LSYY6KfR8zhDTs0rSdi3i2KWdANEoRGCgePi3lEWDxVc3ICQJ
	WpqRS/UanI5uyJ2FOAy7QixTiS6fiOwkNwjo7jP2fb4sDvPH7E4inC1rz06N41WuqFhtNQik2R2
	HsY63binfnNbJg1vxhZe5Z09Jvm7DtHmboFaH2D0R7ztEFn99X80yCH+OxYODTnAd3IJFVqDY+l
	8guwL6jjqEALl4zK8D34Sb1vkw14zQ9Cw8tvlXLu7rGHO5iKOZ1sKamPd5fkC1kQ32BGgGcB7dj
	UfXwxDv8x1tfZ8hBL9n6YPrZ6JuaTNoP6NauU64cBubZCeDfHltRltEzkmhp+DVOY/jFjS+z0+E
	6BngA0aDAQG1IGc8jPyHJoKeNE6xIGeVDz1xplU4pkcS872Hui5T/NIU9KqeRZm2c1CHPYBYSWD
	ESuyyQKUQswdUCnfmzzFH3SOSqA4lbWI0I6lo10TTpeBkQXyMnUB2cInr6YHU/jZuOR4hVndDCR
	29I5lw==
X-Received: by 2002:ac8:5c85:0:b0:535:a5f8:a5c1 with SMTP id d75a77b69052e-55aca875ecemr64665691cf.65.1794617236082;
        Fri, 13 Nov 2026 16:47:16 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm30002301cf.10.2026.11.13.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:47:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xS1vG-00000002SDe-0c1E;
	Fri, 13 Nov 2026 20:47:14 -0400
Date: Fri, 13 Nov 2026 20:47:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
Message-ID: <20261114004714.GF2532299@ziepe.ca>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-6-oss.patchbox@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112195710.1417744-6-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:57:00PM -0500, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). If
> the delete fails as well, the hypervisor still has the domain, which
> may already point at the page tables, and they are freed anyway.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
