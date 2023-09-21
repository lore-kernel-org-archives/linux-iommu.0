Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3C16429
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 23:34:04 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-65641c171cbso8035416d6.3
        for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695339243; x=1695944043; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GedEWxpKSzrGPRM6lMkTBIu3LFHKqvL1k9LSqu1VR6k=;
        b=CKOU0Dq9AskLlNS59zbs7JUNIiXXIAzS/kY1b4pSrTixPWUXAbA49HaV8ULNyFbmb8
         qch5bpoMoaNR/c/uhuaFA62x4RP/eh5h3xUCBJ8+H0mLy94akarnvjR7TBfD8298C/cR
         ZFuoH0YZbRFeS+z3FOr4lKE/XpSpw9YHRs3w0J4w+3sU8qlnJ4x+2HK1aSvy5DYrjysk
         ZNUhA1MxDBkd07IcQXX/CfGlNxL9YUDzvNlg7PA0Ga5zwXVAdAH2GP5wHKjVmUd26oTw
         IbeeY6K0C4i6+N8mKkcunoc8K4qYm7Bqu22ZQs1vtAQA4TRrHb1eaPIS1QgnZzuBURyJ
         T95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695339243; x=1695944043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GedEWxpKSzrGPRM6lMkTBIu3LFHKqvL1k9LSqu1VR6k=;
        b=QIVQ+19y4Xmm0eEesYscQAX8hn9Mb89g96BbmqvU9+Ci/LxcsyYqffjuvuK6ulaVv9
         QVJ2smqZdPzxykfofRGZb9Y9KVUoX3BkcaKAbQKyU4sy2TJOuMM6JU8YFmjUCWninAWI
         Pca85S71ylVI+P1wBaItmEKsQdul/Oho6VaCVg4uFc3AwcBXbUdBntDmRoZbcu0mFe8m
         jo2sKSOuDYOoh1l6oLgZXjCWVlMM+nFBxJoNz27mkk3mJO1ACdLx56/Ge5PAelqK44CG
         QPdLRFiuQP+A7O+VdMB07ns25Hbxt7DTOOUgMP2mYXSiU9oH2SsYsarGvfkwHcCMk8fl
         7tLA==
X-Gm-Message-State: AOJu0YyVDE/ZdBWsboqq9rwyib0SIwTVoXVGz9eVEfh7U2LH+tMp/xks
	4ZksgccBw89QgTCt0/D7Rb+AyA==
X-Google-Smtp-Source: AGHT+IGyPvvaH53YFg/+nfLkgh+wJ6GTD1U2RciFZyYgWxuFiG/EgPxEd0ck5941lJVaQIWktR+A+g==
X-Received: by 2002:a05:6214:4602:b0:658:310c:f6ca with SMTP id oq2-20020a056214460200b00658310cf6camr7598389qvb.42.1695339243709;
        Thu, 21 Sep 2023 16:34:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id o3-20020a0ce403000000b006263a9e7c63sm947595qvl.104.2023.09.21.16.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:34:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjTBK-000Uup-Kq;
	Thu, 21 Sep 2023 20:34:02 -0300
Date: Thu, 21 Sep 2023 20:34:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20230921233402.GC13795@ziepe.ca>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
 <20230914085638.17307-10-baolu.lu@linux.intel.com>
 <f20b9e78-3a63-ca3e-6c04-1d80ec857898@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f20b9e78-3a63-ca3e-6c04-1d80ec857898@intel.com>

On Thu, Sep 21, 2023 at 11:25:56PM +0800, Liu, Jingqi wrote:
> 
> On 9/14/2023 4:56 PM, Lu Baolu wrote:
> > Make iommu_queue_iopf() more generic by making the iopf_group a minimal
> > set of iopf's that an iopf handler of domain should handle and respond
> > to. Add domain parameter to struct iopf_group so that the handler can
> > retrieve and use it directly.
> > 
> > Change iommu_queue_iopf() to forward groups of iopf's to the domain's
> > iopf handler. This is also a necessary step to decouple the sva iopf
> > handling code from this interface.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >   include/linux/iommu.h      |  4 ++--
> >   drivers/iommu/iommu-sva.h  |  6 ++---
> >   drivers/iommu/io-pgfault.c | 49 ++++++++++++++++++++++++++++----------
> >   drivers/iommu/iommu-sva.c  |  3 +--
> >   4 files changed, 42 insertions(+), 20 deletions(-)
> > 
> ......
> 
> > @@ -112,6 +110,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> >   {
> >   	int ret;
> >   	struct iopf_group *group;
> > +	struct iommu_domain *domain;
> >   	struct iopf_fault *iopf, *next;
> >   	struct iommu_fault_param *iopf_param;
> >   	struct dev_iommu *param = dev->iommu;
> > @@ -143,6 +142,19 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> >   		return 0;
> >   	}
> > +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> > +		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
> > +	else
> > +		domain = iommu_get_domain_for_dev(dev);
> > +
> > +	if (!domain || !domain->iopf_handler) {
> 
> Does it need to check if 'domain' is error ?  Like below:
> 
>          if (!domain || IS_ERR(domain) || !domain->iopf_handler)

Urk, yes, but not like that

The IF needs to be moved into the else block as each individual
function has its own return convention.

Jason
