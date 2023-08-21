Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190C2F2B
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 17:01:02 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-649a653479bso18392956d6.0
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692637261; x=1693242061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp0mp4oKv9QJH2WNBMG+dMHV2S+Emhcg8pj4eiwry6I=;
        b=owUGxInYWGETc4Byt9qhOufCBlVpnQr39WF5+gGKIgsoShD+J8oyY6c8cXx6JLmJQh
         o3k7KiU6gAg+P3ufYR+t+aLNXl2l2o9ATj/s+OML35OLWn22moFaCxPzfEnwkOHU6etn
         D4DEYVIOIvJ3j/T+beSJPKauBBj1mX6moMVdZcZsKyOkx0DGBe96RFqaE+NPvm88AI98
         sZDPwbfPaqBwneSsIRDK1BL/tmEMlbYBcnGmY8eRNfsXAAoqd8VQSm/RC1iNUtTbwL7y
         4ws+ht1grGxMjzZuY44/MMkxrVJdd8h5VHNqGPapA/kAclCDwXEorlkLi1IbjvtXgQkT
         bbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637261; x=1693242061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp0mp4oKv9QJH2WNBMG+dMHV2S+Emhcg8pj4eiwry6I=;
        b=cmOQAlnM4JBOgs1cnoPuncEjnCkxKXl4QZNhdHCHKHexOWofEV8HTDfiZd71PXz4/6
         0bSfL+IPN/KGszlmahGaESTlWN3mqOQ3JSTbIMzIqgUDZwgmnQaUW5g5bR1fZ8Z+TAM3
         uJQOb0ty7yu83PYMsDAPttxbOnr238GSBGwnKwx2NoWiZjWVSG1OFxoqXCZuP5+8uC6z
         Xte0fDL9FlOQyQ1a3kMWYi68JN1+Ix34wSD+O8r0nSnfTdELoAWl6bzXId3nW88newY8
         CW9yJiovv48QYnJymdHA4uJ50mfSZAFScpRFHHgO41o8MZJe/efK+bPGuKXCJiB3HxEs
         MUAw==
X-Gm-Message-State: AOJu0YyAqKOgOVY5tqUK4FEd/rdClF7fqiEoTksR59b5jWstaypnQgW1
	1u56U6djFhvZdt94GBBgzGlzlg==
X-Google-Smtp-Source: AGHT+IHlN4tly8d2T2RVI8aDQ+SFzup3PPM5KO0yIMtl0SMNI2iXsSHA0d9eUjaH5xpnlr6zrfUOPA==
X-Received: by 2002:a0c:b455:0:b0:649:c4f:8d81 with SMTP id e21-20020a0cb455000000b006490c4f8d81mr5856142qvf.5.1692637261620;
        Mon, 21 Aug 2023 10:01:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b0063f88855ef2sm2987702qvl.101.2023.08.21.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:01:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY8Gy-00DumB-IP;
	Mon, 21 Aug 2023 14:01:00 -0300
Date: Mon, 21 Aug 2023 14:01:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] iommu: Cleanup iopf data structure definitions
Message-ID: <ZOOYTLmgJuV3zxYm@ziepe.ca>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
 <20230817234047.195194-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817234047.195194-5-baolu.lu@linux.intel.com>

On Fri, Aug 18, 2023 at 07:40:40AM +0800, Lu Baolu wrote:
> struct iommu_fault_page_request and struct iommu_page_response are not
> part of uAPI anymore. Convert them to data structures for kAPI.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      | 27 +++++++++++----------------
>  drivers/iommu/io-pgfault.c |  1 -
>  drivers/iommu/iommu.c      |  4 ----
>  3 files changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
