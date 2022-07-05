Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9716001
	for <iommu@lists.linux.dev>; Tue,  5 Jul 2022 17:43:30 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so8235152wmr.0
        for <iommu@lists.linux.dev>; Tue, 05 Jul 2022 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKDOb4xlZp4MaUsVZxk18FvC9MTm4XhyouNs2L3jRNQ=;
        b=G0X8ImN2RMYiGMiFNphfKdlxW6zMCVZIp5lWBwjZ+bL31Vn++3Cur6/ybppQF8izva
         3kR8eoD+QGt6WAxugtpTapdxkEU/XzIo9w0PbBok+y0wZLGG9rrW1gwKxJEUSsqJLuwa
         L3gV0+NajJmYaOKamQ+CudIBUDvwGZj2xZFXq4CnWcVkZr6KVLkmc4F+VliXfTUgnCl0
         0Aps/GnkGGn0jTKmcOwvxfI1pyL34OwidbDnp+5mTkTpjNdgCxWJeJSGZMjnmw0CIFWb
         XM6XnMbettTLuqgIrE/qaetQ47FOFXqYUbB3/lkkv7l/HLNy0zGYopVysXl5C/8PTspB
         u41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKDOb4xlZp4MaUsVZxk18FvC9MTm4XhyouNs2L3jRNQ=;
        b=BlkcvhQ6nAKVhCgwuIklx2C+tXkAf1dCyuG+2gJAxRcYEOREY81UnxOuRNpqniqAis
         i+hEf5Ah7ju0RKRdfTHB/lc8O6xvPfqC1uHqR0CqJM6quVC9WvpS3h58q3flrDfByGLw
         QPD8PtNgf+6kc/d4v5Tdf1GqSdQsFWjmeoit1mu55Pzr8l95N7KAp5+ROU8wKDFAQdAV
         ok+xhKrd7nWNxZOC8F7A54Sf5In4hv9X+w3iHkE4lR6nyVJofSmGr0vUQ8WU1339i+4c
         ZFxLvrysNq46+wQH5YyCLMmvFZL3aOBW2ctMkT7QKjC7LoY/jkyJX/fzwn4nrB5xYagW
         GKpg==
X-Gm-Message-State: AJIora+ij7lBzftK2vHw11HHZTJO2bYfA29hD6Kn2si2edg578Kvkl2y
	xz19KaUvuK8GUIHkuTCrimfFRQ==
X-Google-Smtp-Source: AGRyM1shDXUmV/7o3y063+Nyrzm5QDMjcyksWy5xl5QFnim77i91N380LMA7XTtoDBeD8UufCtcF4Q==
X-Received: by 2002:a05:600c:3491:b0:3a1:8609:ba7e with SMTP id a17-20020a05600c349100b003a18609ba7emr30360640wmq.79.1657043008462;
        Tue, 05 Jul 2022 10:43:28 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b00219e77e489fsm32675353wrt.17.2022.07.05.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:43:28 -0700 (PDT)
Date: Tue, 5 Jul 2022 18:43:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YsR4JzFgvm20fs7E@myrica>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>

On Tue, Jul 05, 2022 at 01:07:06PM +0800, Lu Baolu wrote:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

