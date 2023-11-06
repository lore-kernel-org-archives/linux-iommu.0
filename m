Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2812168BC
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZsgY8d84"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2121257241.0
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699299149; x=1699903949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
        b=ZsgY8d84pNVm5XplQPwvOatLRben3RTbY0QnbpbHdYrKslcHNleASGTkLnSH3waXfP
         B83nyudMKSa9mZtZtT/NAFTJ42lVuvljdH5ezHr7O3rBLxEP17i+UKXq4ZAiTD7MmB8t
         7WHvpwg8BngA+mEmm+bM9gzrf3qs5rRLb7N/avkgNqo1loEQDNI+yJZb0OnBhAlDFvtq
         fEaLVHun94xLYSBXTf9p1jAVXg54/aG3hzkj3MmAYc6hau2LEjOVjesyPwpfgEqcnjGe
         0MlBEujyv/al5duwGqIlfCCXg1UOMVDT8eGBoAcOSUcLbvINCmf1fAsY6Pf77mInxS1D
         IPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299149; x=1699903949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAHtCI4uX5rSDG9hdPsxsTF21tKIZfBDAKE7xDsp3rU=;
        b=vr8XtD1JX8WCgGOwkNPohiM/aB2W18PdqsgzLNXRv+7yadKOXkAB7Jwai6KNVfmBGc
         XT7Li+gntgi4ODm4A+biOJoORXnVJ8mqqVyFolX8BAJuos+jX59WHqzakyziMzzWEAsF
         uWwp0fo6PjJN2vwIPIhViT/+V9vLDj8quGjBlh2xI38A82AZm7MtO5zGBZWo/RxB5wVD
         TzrMNMQL/JiVpVAjxcdB3xl/f13h5F4TWe6GWGufGrNP9TzHFT+r5bX0PbcXoaEydKvU
         n3ksIMGw6Zgz85Zl49VB0MPu9d+qaqNedGmtJ9DTHNJUVjh42yZOqot/JgGmIFGWfDCH
         s/+g==
X-Gm-Message-State: AOJu0Yw7l7xj/1gsq6yWYhPfrSiX3aNaRtTQK8U/w02wm2k6b2OJgbqk
	ewVNzdDEID/hme4Zndh2iq/cAg==
X-Google-Smtp-Source: AGHT+IHHrThxyHmJktLceZ794OYsaOv21wFux00FTZbUeam8b2XhNtl+ya1TeSFos/G045SdeP1ylg==
X-Received: by 2002:a1f:1c4a:0:b0:49b:289a:cc4a with SMTP id c71-20020a1f1c4a000000b0049b289acc4amr27005359vkc.3.1699299149465;
        Mon, 06 Nov 2023 11:32:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b3-20020a0ce883000000b0066cfd398ab5sm3663160qvo.146.2023.11.06.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:32:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r05Km-001Qut-BY;
	Mon, 06 Nov 2023 15:32:28 -0400
Date: Mon, 6 Nov 2023 15:32:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Message-ID: <20231106193228.GU4634@ziepe.ca>
References: <20231106071226.9656-1-tina.zhang@intel.com>
 <20231106071226.9656-3-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106071226.9656-3-tina.zhang@intel.com>

On Mon, Nov 06, 2023 at 02:12:23AM -0500, Tina Zhang wrote:
> Add basic hook up code to implement generic IO page table framework.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/intel/Kconfig |  1 +
>  drivers/iommu/intel/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.h |  7 +++
>  drivers/iommu/io-pgtable.c  |  3 ++
>  include/linux/io-pgtable.h  |  2 +
>  5 files changed, 107 insertions(+)

If this is going to happen can we also convert vt-d to actually use
the io page table stuff directly and shuffle the code around so it is
structured like the rest of the io page table implementations?

Jason
