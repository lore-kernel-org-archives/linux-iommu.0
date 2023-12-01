Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29324E63D
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JeWG/kF5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c194b111d6so710166a12.0
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701459043; x=1702063843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKPTNfyUQ76RXlZglnCsaAsISjRqR/A1VMTCAWgJfNY=;
        b=JeWG/kF5VVWzsXMkPjpfp1paLAH/eLNb5UPAjdiiEg8QxEcuJDPKR3ilxQ824YO1gW
         ot3+BI6aHbwf9LVQCZXQUFRLeEio7S4Ui3rSnHSh7ep07Crz6MlmdzwI55KLhuTkM6Bx
         9igYlR4RGCooywi1ICTs2ohEIM8tmcNLw0ZtcDTpRldLkacFznCyxfLE5TzrFvPsnjK4
         gnSnY97EqJVfVzR4LhGWkVD8mVXX2h91yQZK/TB36wpqz3f3br9bNlhaA2J68G/ED/DB
         2IbDMF14kjUihF2Y18E8NNv/x2Vl2IfRYapvMScs2YxfpnXHmHXAN8peMQmwL+6HgIDW
         3TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701459043; x=1702063843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKPTNfyUQ76RXlZglnCsaAsISjRqR/A1VMTCAWgJfNY=;
        b=MgkdtAhegXwP4qt0nOqtSf8T/TOKyMEdtT/xujyQfLCzOmS7weQIxUkvztDjIgLkNz
         AsozXlDx/kJb5KJzQ0t6tu6YDcVFnDyWpWaUXkK4KH0PbrKmF27lcP1UMIxmToQfc/Xr
         Lm1lV9Ifsggx8AJoB/XMpeivGAf5sTFo0IfxbdxZ6VO9dfkzN9Vo2YS1akcsGYeyo0pF
         jBzD5PHn7HhAphP1Sg5cwSHAdh770kIyVqq9I8JKhjmse8wriARiZ1aIl5K6BCvTtWWX
         I1orqhxk3n2ywIs0IApCG8Bl/m/9Xns2gIZmioBpmzeQ9VJPI5/AjpxuBDi1ujCsVQrm
         5FrQ==
X-Gm-Message-State: AOJu0YxnIK/IwKhxo+RQsLWYeb/66xu72VZnhS+KSMwx8On6MsqJgyo8
	KHus+gPoPpz2xxQW8jHEeZG9dHWGgaYemhu8TGc=
X-Google-Smtp-Source: AGHT+IFicvE4UTpgf7EEaTDeLovKnKQDD9u8jMl5SDOOOkrmTUmnQHfGJZN3OtHg/u3QSEBLkoWKEw==
X-Received: by 2002:a6b:6111:0:b0:7b0:3:6ac7 with SMTP id v17-20020a6b6111000000b007b000036ac7mr68941iob.16.1701458082221;
        Fri, 01 Dec 2023 11:14:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id dc30-20020a05620a521e00b00775bb02893esm1741124qkb.96.2023.12.01.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:14:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r98yH-006HtX-8r;
	Fri, 01 Dec 2023 15:14:41 -0400
Date: Fri, 1 Dec 2023 15:14:41 -0400
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
Subject: Re: [PATCH v7 09/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20231201191441.GE1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-10-baolu.lu@linux.intel.com>

On Wed, Nov 15, 2023 at 11:02:23AM +0800, Lu Baolu wrote:
> Make iommu_queue_iopf() more generic by making the iopf_group a minimal
> set of iopf's that an iopf handler of domain should handle and respond
> to. Add domain parameter to struct iopf_group so that the handler can
> retrieve and use it directly.
> 
> Change iommu_queue_iopf() to forward groups of iopf's to the domain's
> iopf handler. This is also a necessary step to decouple the sva iopf
> handling code from this interface.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/linux/iommu.h      |  4 +--
>  drivers/iommu/iommu-sva.h  |  6 ++---
>  drivers/iommu/io-pgfault.c | 55 +++++++++++++++++++++++++++++---------
>  drivers/iommu/iommu-sva.c  |  3 +--
>  4 files changed, 48 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
