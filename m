Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C522F2B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 17:06:55 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a7781225b4so2439113b6e.3
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692637614; x=1693242414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcpesrdOKBjIBH3tlZ3q44ls+ILnPyIbnyYqKr2W+dE=;
        b=i6Kb4H1cvgEso7109Gj9Y553yi7GSJelnA0xjnD/VxAY2DUlnrNnvON3JHvIfxm0tM
         Khe2hq6wX6BQKnboV5ic2Ud2ZF/0lJjL/6ybD+FZbFoyBmonG2o8OrcUvSPMJ/E0DU7Q
         Sm9u9VdsJcaR6XJk+XU5WXOCjz+L0eyorS9BupLzbzhhqGPNPdABoJl5zSI+K2C5t8S4
         u/QKDmkT+DtZrqFJ90SuPsJ+b/skNq3EtbseQZWSRoAjpFiXnxmpeykw/PtavxcZvoOH
         uFHR/4KkKRLb8Rh6ptTotGQknfASXOc9KV+D42hlAvVcxAPaSFKn4WI9BrKMAac1JOUh
         mM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637614; x=1693242414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcpesrdOKBjIBH3tlZ3q44ls+ILnPyIbnyYqKr2W+dE=;
        b=deqtAsx0HQtbVCDq9+nSibnfplnFVJBwSTKvr9vqaDjDInZqSvhUW8gWYs/ANcaM+T
         CtVrqyavcb2XV+4DLHcR3Aahi2UYX5MlmjOWt3+Za8UUqbKD4dTA3i1N6n0EHDcQ7QDN
         nSx9pz2tZJSHMhJjK+zOPGQwN0kK0pu155UcYCgn0iySssIukMiYvIB2yBj0dubxo5zK
         yXIFW9PRdzn0pylPZBqXTpqe6DnfTqC2y2M5FjoYF+SBDFCJlOaMYYSt1JCJSriTKosr
         qOyMKDlziCp5I+Y4rIfUQDjls8Gs7/P/HvQGHpO1guVqw9tIMd7ZRsXcWsm9LvdDqb2G
         q5jg==
X-Gm-Message-State: AOJu0Yw8w6IEXFgVn135hFrPFnM8sS8eYRQjgmHn+hP6ZMjwldX2+tHq
	PWihUS98Nk6sZbaQvgYG45TeRDnJM3PgXRjZ3U8=
X-Google-Smtp-Source: AGHT+IG8X+l5Motw2UgXh3Pll87HnD6q0vanSSPX/5vtlKoHrD+t0K/F+xFSEdJ9OFLGAZ+9gB3oFw==
X-Received: by 2002:a05:6358:41a3:b0:134:dc90:b7d1 with SMTP id w35-20020a05635841a300b00134dc90b7d1mr5913387rwc.25.1692637614702;
        Mon, 21 Aug 2023 10:06:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s8-20020a05622a1a8800b004035b79860dsm2455049qtc.81.2023.08.21.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:06:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY8Mf-00Dv3E-Ob;
	Mon, 21 Aug 2023 14:06:53 -0300
Date: Mon, 21 Aug 2023 14:06:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] iommu: Prepare for separating SVA and IOPF
Message-ID: <ZOOZrbb13QjGEJ9c@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
 <20230817234047.195194-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817234047.195194-8-baolu.lu@linux.intel.com>

On Fri, Aug 18, 2023 at 07:40:43AM +0800, Lu Baolu wrote:
> Move iopf_group data structure to iommu.h. This is being done to make it
> a minimal set of faults that a domain's page fault handler should handle.
> 
> Add two new helpers for the domain's page fault handler:
> - iopf_free_group: free a fault group after all faults in the group are
>   handled.
> - iopf_queue_work: queue a given work item for a fault group.
> 
> This will simplify the sequential patches.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      | 12 ++++++++++
>  drivers/iommu/io-pgfault.c | 49 ++++++++++++++++++++++----------------
>  2 files changed, 41 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
