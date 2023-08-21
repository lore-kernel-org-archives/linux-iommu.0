Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6326FC0
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 16:52:03 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-76da7f86d46so62373285a.2
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692636722; x=1693241522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkXwy1ISt6qrbrNZuCCq5IPH6kF6shpR2kgu96JJrek=;
        b=TUUsTkKH5URw0jANzhVv1T58xuhiQN8AoY56op+SMW6dJqqBZda8RDoywrFBQnuz3+
         iff2uk5g1UgRlXxQW+tuJj5yXCU9V7wWqr+lJGapFySbk7mC/eKW4FLVNyoSMxUXFRBR
         YvQUQ9o2y3GI5GGSue750glVwG2u7MFOxOCO5h2V29DOhKsRMpSKdlGvpr3jWwjWcFcH
         1VdQFHzo8a9pOqW+rhaOE2f7GTAfUNz3vidG+5vsqK97r4+gSZQlv/3IiBU9xx6Mrym9
         Klab9eqEoCmD6EKz3OXjW4iANZ5nY0A0aWKyinVKVgiV6PJ83olsWG1alZ2kOZyzlZiw
         qTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636722; x=1693241522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkXwy1ISt6qrbrNZuCCq5IPH6kF6shpR2kgu96JJrek=;
        b=ktmx417qGKyPIyWVlQMsM+4m1qPaDj4jcUHT/bstJCNix9BUebPF43yp+HThIiq/27
         n4Qeaqb/ULBnpzo3sFD2FIkGmXKNy8jhUUp8WGGHTisoJhAj+foZL/rOprHTQGb7Xrpw
         /YvpDb0QgJA5kqQDzNCCi2MGKWiZtRyRGIXJYU8EENPhWk4rX896ek5k6Mx3zrF1qRIf
         +wKvNFNWduSpv8ej/ZCuFux2MfEhvsIwHyE6AnW2LLOGuZe1j+kt+5O3TsoSZ6OIyRBX
         Zn78uO2rVZKNholdJx51N0HUVAwXDhMQVklEuWC0Zl0/RqihA0CHzjP3Ty56E1dZB/o7
         kWKQ==
X-Gm-Message-State: AOJu0YxU3E9cpowypjmD+GLVQL0TS20cBFa4dcRLbwMV2HBAVvXJLKi0
	xuZc0OinHKU7o77qAO198DBBtA==
X-Google-Smtp-Source: AGHT+IGIrArLMUjqUVsv2NQ4VGh6eVA/ApKYhx1ONwSB7QRBGzVgS5K5zRFadfQ4B9TvLMlxOhAyww==
X-Received: by 2002:a05:620a:bd5:b0:76c:9ea2:545e with SMTP id s21-20020a05620a0bd500b0076c9ea2545emr8795157qki.3.1692636722684;
        Mon, 21 Aug 2023 09:52:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a5-20020a05620a124500b0076d9e298928sm1589751qkl.66.2023.08.21.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:52:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY88H-00DuJL-7T;
	Mon, 21 Aug 2023 13:52:01 -0300
Date: Mon, 21 Aug 2023 13:52:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Huang Jiaqing <jiaqing.huang@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, yi.y.sun@intel.com
Subject: Re: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
Message-ID: <ZOOWMUmwG2jXOaXL@ziepe.ca>
References: <20230821071659.123981-1-jiaqing.huang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821071659.123981-1-jiaqing.huang@intel.com>

On Mon, Aug 21, 2023 at 12:16:59AM -0700, Huang Jiaqing wrote:
> The existing IO page fault handler locates the PCI device by calling
> pci_get_domain_bus_and_slot(), which searches the list of all PCI
> devices until the desired PCI device is found. This is inefficient
> because the algorithm efficiency of searching a list is O(n). In the
> critical path of handling an IO page fault, this can cause a significant
> performance bottleneck.
> 
> To improve the performance of the IO page fault handler, replace
> pci_get_domain_bus_and_slot() with a local red-black tree. A red-black
> tree is a self-balancing binary search tree, which means that the
> average time complexity of searching a red-black tree is O(log(n)). This
> is significantly faster than O(n), so it can significantly improve the
> performance of the IO page fault handler.
> 
> In addition, we can only insert the affected devices (those that have IO
> page fault enabled) into the red-black tree. This can further improve
> the performance of the IO page fault handler.
> 
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 68 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.h |  8 +++++
>  drivers/iommu/intel/svm.c   | 13 +++----
>  3 files changed, 81 insertions(+), 8 deletions(-)

I feel like this should be a helper library provided by the core
code, doesn't every PRI driver basically need the same thing?

Jason
