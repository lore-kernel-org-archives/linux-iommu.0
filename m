Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BC168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:43:06 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77063481352so166491285a.1
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695386585; x=1695991385; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJYX5wUywumkDIjBBuCsh0129IAPGx0MBB+MpKbn2U4=;
        b=k/4b8popdwiJ4z7Ajng7u8C7t+wh2Srz+R2NtVXyZNhKBY3T2ioTrl/PHzfXTQTfW2
         qj3vdZdotaUoleltCWMG/b6uWZbOeYbFeXGftbbxjRbSMKbo2pzfhsrJQY2dZp9vud9s
         UGpwmTHbT2xi8R1AmWd9NE3G6O4R6K6jfaenxWINhgQ/ztkHlq2+op0Vbc0wkaM5LocG
         4aXi9W8pzNAjS41/m8VKCgBrYFBs0pVfZ4s9UsoGiZavEL5Q9SgrRhu6Ey6dYNCFlMk3
         Dt1NslbCI5BUIEQ4djX9ja4Ckpsp04ol9G+aL7UD4kC9zkNxYPj0na+RWjlF74rfw9fa
         ySfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386585; x=1695991385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJYX5wUywumkDIjBBuCsh0129IAPGx0MBB+MpKbn2U4=;
        b=uuIBsRAnaCaqmCrbyZ18iNEPhQbruje1y/jEirA+i0ymXSJu3/yxFwj01TSYDTXwKb
         pr3B3xaN5/IvcPB02EiTkoy9dNU0meamm/0MrxpAvoVLqwIT6OhztaW84Gep6dtPmgC1
         fX7kBPkv99sEeQxmEyN4KKRYAUORPQNfBKhyUYpK1fiqiPR0Hcu9WabsrB+Uy/rHtUwc
         ltTkN2zAwGxa2bT1mMpreu3Tx7Lr5eWEXqfu2koItegkk0TmtR7SqkYPDBH0M/yGq5Fo
         E9R8MnogZKCbfCdI4n6k66A21Uyll70OpSvjA4s+rIKj+oMPBPQvgKKMlHE7/u6qNh3c
         RvGQ==
X-Gm-Message-State: AOJu0YzRRhOdiPBZ/p5kqCeM/psvh/Wxauqn2O2LNYIJmG1ze7Ujrkt9
	hRox8t0+QuSMEYLkA18kKlmeyg==
X-Google-Smtp-Source: AGHT+IHm/qwy9v94zwoSSNba4IDdrqDeA5MFzZIlrmmRnzEbwpTUWaYrkAhTSt+q/0yib09m0ubygQ==
X-Received: by 2002:ad4:5de7:0:b0:656:519c:5a07 with SMTP id jn7-20020ad45de7000000b00656519c5a07mr3118747qvb.25.1695386585198;
        Fri, 22 Sep 2023 05:43:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t15-20020a0cde0f000000b006588f418323sm1396225qvk.64.2023.09.22.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:43:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjfUt-000Y5A-VB;
	Fri, 22 Sep 2023 09:43:03 -0300
Date: Fri, 22 Sep 2023 09:43:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20230922124303.GE13795@ziepe.ca>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
 <20230914085638.17307-10-baolu.lu@linux.intel.com>
 <f20b9e78-3a63-ca3e-6c04-1d80ec857898@intel.com>
 <20230921233402.GC13795@ziepe.ca>
 <e7c773f6-969c-0097-1bca-24d276e8a8f6@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7c773f6-969c-0097-1bca-24d276e8a8f6@linux.intel.com>

On Fri, Sep 22, 2023 at 10:44:45AM +0800, Baolu Lu wrote:

> > > > @@ -112,6 +110,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> > > >    {
> > > >    	int ret;
> > > >    	struct iopf_group *group;
> > > > +	struct iommu_domain *domain;
> > > >    	struct iopf_fault *iopf, *next;
> > > >    	struct iommu_fault_param *iopf_param;
> > > >    	struct dev_iommu *param = dev->iommu;
> > > > @@ -143,6 +142,19 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> > > >    		return 0;
> > > >    	}
> > > > +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> > > > +		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
> > > > +	else
> > > > +		domain = iommu_get_domain_for_dev(dev);
> > > > +
> > > > +	if (!domain || !domain->iopf_handler) {
> > > 
> > > Does it need to check if 'domain' is error ?  Like below:
> > > 
> > >           if (!domain || IS_ERR(domain) || !domain->iopf_handler)
> > 
> > Urk, yes, but not like that
> > 
> > The IF needs to be moved into the else block as each individual
> > function has its own return convention.
> 
> iommu_get_domain_for_dev_pasid() returns an ERR_PTR only if the matching
> domain type is specified (non-zero).
> 
> Adding IS_ERR(domain) in the else block will make the code more
> readable. Alternatively we can put a comment around above code to
> explain that ERR_PTR is not a case here.

You should check it because you'll probably get a static tool
complaint otherwise

Jason
