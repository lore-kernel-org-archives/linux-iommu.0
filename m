Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03090125D7
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WImM6cab"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77bcbc14899so117753185a.1
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701445352; x=1702050152; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5OluPhgDT3nAw0/mpsAOoQF2zqQkql7YLDt75eO1Ow=;
        b=WImM6cabZvEYHGeBEc5SLM2yMvdu0ujxftBJkiSslnGYT1eKWYMjmqClbRwxLOErwA
         U+HB4dBbeoNpO1mOgmCCqL977XlwRfBYzxTzwp/SxKNKivvtMa0Rv+jFy25A7lhnPd3F
         +kKuXttD/GF/lV/aiWdapU74emXiEWW4L3YywSC3pPPJkiXto/PO5dacdxWxn+nQdfRS
         FdxGOXen9tpiB6XZc06PXRm6sPZUegqVyY26i0xXnydb3k4fkhhjVSzCJYTmaVO/Xivk
         ke1nd7ZBIotClUU1bhHnCHFtFnb/piFTncPW+gEpzOMcSks4q8EOAnmF+DWzpB1KoptB
         +PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445352; x=1702050152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5OluPhgDT3nAw0/mpsAOoQF2zqQkql7YLDt75eO1Ow=;
        b=AEDEmoSP2YlUNQTG83I03eRDVw2sYo6dlIz06/9tc4EUBg1BCESnft+FW9w7dJbZ/v
         y0F9GzpOs+QAr0ze52k0PMCn6h7WeJiWDse8zX5oTKLDl6e8S/sAIVhBSmVdbDOu9GJM
         atCqUpd/dbTMeuOcfVpAeINyoBYL0fBeA5eseqIEpgnoGnEIGDXxhM2mcgixDJMlOBAl
         qFXep0xk2t1TAisFUSAeQDwrMbFUSrY20iWt1QkFMKj8mZqHiVbJmSLbYuwJJhQOd4h1
         y5udoNw6EBvX7DL2zyoDUMXY9D+kQ24CKFIuIFBhpFeJ7QKcfNqzMvvD2k9GewU/LWSr
         iHZA==
X-Gm-Message-State: AOJu0YxdVsnguTrpxZ8dJOHAOZVOre+PogZwn9uzR/Hp17rJjq4xeVkH
	XnEbUhX2Mnq8NEOSsHsOBC3ahA==
X-Google-Smtp-Source: AGHT+IGJqqOzBXgm1gG3l4eq+iJtvvsWrjEeRODObVtVODE5xSIuIkhfCOaHdl0inwKoRnlUy4vC5Q==
X-Received: by 2002:a05:620a:4092:b0:77b:9bf1:6526 with SMTP id f18-20020a05620a409200b0077b9bf16526mr29808153qko.44.1701445351820;
        Fri, 01 Dec 2023 07:42:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a048b00b0076e1e2d6496sm1584171qkr.104.2023.12.01.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:42:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r95ew-006GSJ-Ja;
	Fri, 01 Dec 2023 11:42:30 -0400
Date: Fri, 1 Dec 2023 11:42:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] iommu/arm-smmu-v3: Remove unrecoverable faults
 reporting
Message-ID: <20231201154230.GC1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-3-baolu.lu@linux.intel.com>

On Wed, Nov 15, 2023 at 11:02:16AM +0800, Lu Baolu wrote:
> No device driver registers fault handler to handle the reported
> unrecoveraable faults. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
>  1 file changed, 13 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

If we do bring this back it will be in some form where the opaque
driver event information is delivered to userspace to forward to the
VM.

Jason
