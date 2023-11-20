Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8481C281
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IXNPG8EI"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce2c5b2154so2684013a34.3
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700489067; x=1701093867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rG0WCHMqWdGOoOpA8oz353io0iId12Ij+cwigESy5ls=;
        b=IXNPG8EILObTP5t7ODNoClC7Zr4RiG9+IoLDU6af6jENg7VXRJfNiwcjGbQMXphcMz
         h43wVdrYAt+nBj9duNJa7B0UCxOFnnCcC+ZAxthQQU+4BXRKzkOzP6fEjhJtpryDCFwU
         JX4Wg90yJUCn+OmaPe2f6sn/CdtpAk//wvH30pNQ1knqLYLF5Gimcwqn3zpJfpzubiqD
         HU09YE7EMfLBAmidoY2EhD2G3fn1HK1vMjJ4tl20bXx0OWhf0GYcxp3wQa7F+ll2q5UR
         sxl+cpbLDGVxxIGPel/jF992BAxt5Zj8at5WoZpd+MqzHbBfbxxkSBnRxeg9DU05N018
         NOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489067; x=1701093867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG0WCHMqWdGOoOpA8oz353io0iId12Ij+cwigESy5ls=;
        b=j4mRtM2MdQvdPhBQu7sWbPTNVLphr/3lMe9EDraqJra4HeXyrJhHfwshiCRYm9zcq1
         hdSx7XGkp2Cy1uK5lTiecKe1wxPVF2RH9MvmEvtfx8lLZ/ryprab4ULGJrWNc5f5rmeh
         2ZqC5SJvQNgSpsd8Dp+l/q0uIzKgMM2mQGg5Y72zcjEY6yj0rXVZejxAVJronlziMsOl
         ybhONwp+Di7PWpshS77jaxNPZEskccAJ5l9MgYU0LN9QTutgmF06e3BJ6z+XHmr5pOMg
         syk511VaySJbQ7tWO0OEWsmjvRxDVWSXToOq7eQ1NHlQdX6t4AAZb//LoFMwh17NjBb5
         AQEQ==
X-Gm-Message-State: AOJu0Yw1WhY56WBrPSRSYet1khT3rzKYLd4hGeYJtwHZJuFfCeSGqkGJ
	7MaVvFa5Mt8IvcEdfAFNvyDQEA==
X-Google-Smtp-Source: AGHT+IHHYsEhV7J+GzlVmc8OzgOHpcxM+6MzRUXt5ncp8iyh4bWAf3tzoGkaPba/CTOoUAru+Cl/hw==
X-Received: by 2002:a05:6830:200f:b0:6b9:50a8:1e76 with SMTP id e15-20020a056830200f00b006b950a81e76mr7463127otp.17.1700489067691;
        Mon, 20 Nov 2023 06:04:27 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y8-20020a9d5188000000b006c7c1868b05sm1168833otg.50.2023.11.20.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:04:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r54sz-000Hvu-MZ;
	Mon, 20 Nov 2023 10:04:25 -0400
Date: Mon, 20 Nov 2023 10:04:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231120140425.GA10140@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110151428.GJ4634@ziepe.ca>
 <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com>
 <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com>
 <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVOgBBEetWf1PFxX@nvidia.com>

On Tue, Nov 14, 2023 at 12:27:48PM -0400, Jason Gunthorpe wrote:

> > Anyway, given you already thought it through, can I ask you to provide
> > a preliminary implementation for this IOVA range mechanism so I can
> > play with it and adjust panthor accordingly. And if you don't have the
> > time, can you at least give me extra details about the implementation
> > you had in mind, so I don't have to guess and come back with something
> > that's not matching what you had in mind.
> 
> Oh, I don't know if I can manage patches in any reasonable time frame,
> though I think it is pretty straightforward really:
> 
>  - Patch to introduce some 'struct iopte_page' (see struct slab)
>  - Adjust io pagetable implementations to consume it
>  - Do RCU freeing of iopte_page
>  - Add a reserve/unreserve io page table ops
>  - Implement reserve/unresereve in arm by manipulating a new refcount
>    in iopte_page. Rely on RCU to protect the derefs
>  - Modify iommufd to call reserve/unreserve around areas attachment
>    to have an intree user.
> 
> Some of this is a bit interesting, like reserving probably will
> ideally want to invoke the batch allocator for efficiency which means
> computing the number of radix levels required to fully populate the
> current empty level - that should be general code somehow

At LPC there was quite a lot if interest in improving the io page
table stuff to work better. Based on that I'm even more against adding
an external allocator at this time. :\

I may try to write a sketch of something but I'm not sure when..

Jason
