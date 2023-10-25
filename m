Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7F27EEF
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kv/vEALj"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ce2bcb131fso3645750a34.1
        for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698237012; x=1698841812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DG403nD2V19bQC0UpYqMu9IRQQKhJgIcJ3freQIKoE=;
        b=kv/vEALjWQ9FmQUdF9X2H7HG6D3ZhZA3Sl/xfHdvuwjl5p7oxhgQImVL4zXfpiRqLa
         xmzh1op9WmArvAmsaSZ68CI7XRx9gNaNK1o+sk1oawH6gaOCzPA/x3B0L9o3dds5cVAH
         5XdrogfCl95ndFT/u2fjiZJ2bSyvq1STyobdSuCDzl6sI3OCJWfzB69321JA8buPMNoP
         VaZw0CaJONNLHfct08TxUCcJsPZXGwoE/TrwritEncWaIvmb9bCOWXqOjAl/9uBZbgI1
         R2mZhJzrvE/eZb23nObzb+LztFNDcWYLivKjO9iuAVFeTTmQQK6nXelFZBgQBlvwuqbe
         byIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237012; x=1698841812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DG403nD2V19bQC0UpYqMu9IRQQKhJgIcJ3freQIKoE=;
        b=Y55C1wsJ6X/gp/cwhbMnYKOvsnt5l3HJ1+f5zpRhet7WBKxqkYXPf5xfEfqTwohMHw
         pE9Nyh+/Z1oKZ5GqQihnI8DE3eALzibRgjG+pAqYm6a4p0hb6gTxORJoxBIYl384d/ho
         8tQaZyhTuD3HT7TcAWewmJFjjVRP6/KkaORJV7eM1WY8X02k1veDvvluYIMQWgz8UQd6
         uCT56L1p4YFjeiK1/I7Day0cvpgdOG8GBJYpMp7a4aCgKRwG+iSW9VfK2HB8I7u8k/7m
         lxlfC8VorVqdUJF9pJo6kuuVn1PM/ByRcdMPOs/ukFfQCCRWjes9t1Xg+5U+doVMdSsU
         TrkA==
X-Gm-Message-State: AOJu0YycFYu5/YsfAcR69IkjlkIXvQgfJrjNs8B/3F/beDczsDLgOanh
	Lfssy2vXxOy5/DC/kGFe7GXUlA==
X-Google-Smtp-Source: AGHT+IEJOcOZKL0zy8oglZlyZrvfqEvQLpCVmTAD59/utMgZ3IZcnStseBPSR1WbJdjae8MoeharIw==
X-Received: by 2002:a05:6870:9f8a:b0:1dc:33a:40d8 with SMTP id xm10-20020a0568709f8a00b001dc033a40d8mr19973908oab.4.1698237011790;
        Wed, 25 Oct 2023 05:30:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id du3-20020a0568703a0300b001e11ad88f7csm2569262oab.30.2023.10.25.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:30:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qvd1V-004frI-De;
	Wed, 25 Oct 2023 09:30:09 -0300
Date: Wed, 25 Oct 2023 09:30:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231025123009.GO691768@ziepe.ca>
References: <20231018050640.24936-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>

On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:

> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

I don't know where Joerg has gone, he hasn't been able to answer three
emails about this series in the last week. I'll take it through the
iommufd tree so we can have an orderly next cycle for the three driver
series already posted. If it reaches Joerg's tree before Sunday I'll
drop it.

We should have a discussion about process at LPC.

Regards,
Jason
