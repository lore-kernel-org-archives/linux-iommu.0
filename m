Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1618048
	for <iommu@lists.linux.dev>; Mon, 15 Jan 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d3Xy418x"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67fa018c116so48404716d6.3
        for <iommu@lists.linux.dev>; Mon, 15 Jan 2024 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705341540; x=1705946340; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=d3Xy418xe2wAFTIlHMqP28uPFvfjMD6i+bR98rgUvPY6ljHyGccZ+GnjoPL1qh54BU
         QkQUN3C16npToH7xs8+wdafojFZuIFWISExIMnn1byNpM40A/k8lj3wFkDin+izCaiM7
         /nawWUmrh+6P3J24MIGaKzwFPPZvR0f7TJPTAAqO+7i9+QENBAqGnliq/yirlxio+rHa
         ffKcVMd9fgHZhroefA/w2ZtvRf9a5Orj9QTysz4z6m+sL0G1SW+tQTYpfyhKqroC+95g
         4uqqAHi3npK6JKSn2yzIgT+7Flnw6KhTiAhPQG/Ozwv1pXG9imuWfJpNu0uvCeG3LHQ/
         bziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705341540; x=1705946340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=mXEaOWKNRrYua5GeU6IGbeqBP9yf6kCUXCCEsfzmlbVjcmnUtjNo7r2CCtSzEvud2q
         51r29ogsRgUe58uIsjAytMUS3Y3og4LBGROdfYL0ku1cDnF7PP7+NIz6yq6SFThvgs2F
         hEtoEFeWfZR4LxDQVEncw61hcSi5wAlOQ6BDBtcNCVi4AiA2YyROkzuoNVdNNvdKO7hL
         CfvkWCvSLrMSwhlDkV2z/mheZmfW6GpsxOQX2mbB6y7x6nKKM7K0gO8H23+C8lNxqrj7
         udNb6DHIznJ4AvB778qc5BSJfukZsfY8clinKkEsSSlkFOzWhkGl66DWc/fRBZ5eWzxH
         EunA==
X-Gm-Message-State: AOJu0YxfWmzLw2vQcwATy+f7HJw0SXRWwVuT3fSFpawQNT9r7hm63lOl
	+inFQkvtcgvlrjXOboOYicEC3qgPdmk+9g==
X-Google-Smtp-Source: AGHT+IH3qvjmHpS/20mUo+xR0imhTBslJ6twopYzo9p1d1flQYlhOLrwJcWYbmGWgldNtbhvIF7Uzw==
X-Received: by 2002:a05:6214:518c:b0:67f:d236:5c0f with SMTP id kl12-20020a056214518c00b0067fd2365c0fmr7596556qvb.90.1705341540583;
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cfe8a000000b0067f454b5307sm3452291qvs.108.2024.01.15.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPREh-003u0V-Kj;
	Mon, 15 Jan 2024 13:58:59 -0400
Date: Mon, 15 Jan 2024 13:58:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20240115175859.GC50608@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
 <20240115164723.GB50608@ziepe.ca>
 <b1663110e1ca4301834f403270357bea@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1663110e1ca4301834f403270357bea@huawei.com>

On Mon, Jan 15, 2024 at 05:44:13PM +0000, Shameerali Kolothum Thodi wrote:

> > If it is valid when userspace does read() then it should be valid when
> > userspace does write() too.
> > 
> > It is the only way the kernel can actually match request and response
> > here.
> 
> The kernel currently checks the pasid only if IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID
> is set.
> 
> https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@linaro.org/
> 
> > So, I think you have a userspace issue to not provide the right
> > pasid??
> 
> This is not just ARM stall resume case, but for some PCI devices as well as per
> the above commit log. So do we really need to track this in userspace ?

Yes, these weird HW details should not leak into userspace.

The PASID is required on the read() side, userspace should provide it
on the write() side. It is trivial for it to do, there is no reason to
accommodate anything else.

Alternatively I'm wondering if we should supply a serial number to
userspace so it can match the request/response instead of relying on
guessing based on pasid/grpid?

Jason
