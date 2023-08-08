Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D615480
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 18:43:30 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2693640dfa2so1975823a91.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691520209; x=1692125009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5Kq1LJc+7Xua2Kq4jL8Y3azeq9CaYf9ma2OpUQOoes=;
        b=be1D7x5HcJqbJr27O9QIV9joDE3vudd1QIP8F4Qgp4v2bIvgL98wvF67K8ptum1zM2
         rVcVlh0E9HVHGLUq0+J8M8cOP1JhiobRwtXpij1/CVCLwuDLT7bzIzY2/aOD4ne8lf9k
         7pCgsClRPSqKYWjp5s9RKFzKoygpeelVphLGe1NAcNrjZL98IrObDkQ9HoPqTSAqn/Nx
         R+a48BRECFN1JYwlMmbLUgBF7Ux/Z4kpdO3jWANdx5bINZyb6UQkvIzVR8lyDgalWF+Q
         rBZ6jyci9piCzF3KNNqc7ARsHaNSlDYNmR1odClyIV95XJDZ/zmL6NWmvkQMrzYdgbiK
         wOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520209; x=1692125009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5Kq1LJc+7Xua2Kq4jL8Y3azeq9CaYf9ma2OpUQOoes=;
        b=EcsLBiu4USBDCS2iGSqWgjLmnljmqhxkSbxWGfIkip/9yPgCcSjVbcE0mrdT4PnvLh
         1ounnHJ+1t+kziSRVciF7h+ba7O3/YsB4gKTNi32y3xPWapupSpH8zanKbPo4LlrQKJR
         FwkzCjbB/CzIyBEq70b51dtu1d1bnQyEQzj25+4khqrb0VLSL/xZ2yJ9eUDdEUFCRvhC
         +XQSdStRtAqVqPZX+lkZEzC6B/xJuKiOTueLqaoB8auxC+e1rY3BANq6GVFmeY7++Yg1
         RIeidV4f7Y0Nnh/A+wKhdKYOWFL7lOgub9Vbn1aEzBJmVXW2LwpBlfbyrnHfRRLngzYT
         Doxg==
X-Gm-Message-State: AOJu0Yy5lk6C1+La3p5JfQ3AQ/AQKYy96oaZK48HebOhPFlIq3H1DV/v
	LEyY968gN272J/x21zQk9U/9Qw==
X-Google-Smtp-Source: AGHT+IHMidDa+dRb7HS7nG66MhLisCldZm3VtChaKhwOxTTpgz5v3DNltRI6Cf7yDaiggZ/Zf9vhpw==
X-Received: by 2002:a17:90a:7e12:b0:25e:d303:b710 with SMTP id i18-20020a17090a7e1200b0025ed303b710mr329838pjl.35.1691520209601;
        Tue, 08 Aug 2023 11:43:29 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n7-20020a17090a394700b0025c1cfdb93esm8968536pjf.13.2023.08.08.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:43:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTRfz-004vcj-KZ;
	Tue, 08 Aug 2023 15:43:27 -0300
Date: Tue, 8 Aug 2023 15:43:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/12] iommu: Prepare for separating SVA and IOPF
Message-ID: <ZNKMz04uhzL9T7ya@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-9-baolu.lu@linux.intel.com>
 <BN9PR11MB52769D22490BB09BB25E0C2E8C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769D22490BB09BB25E0C2E8C08A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Aug 03, 2023 at 08:16:47AM +0000, Tian, Kevin wrote:

> Is there plan to introduce further error in the future? otherwise this should
> be void.
> 
> btw the work queue is only for sva. If there is no other caller this can be
> just kept in iommu-sva.c. No need to create a helper.

I think more than just SVA will need a work queue context to process
their faults.

Jason
