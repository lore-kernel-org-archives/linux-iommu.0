Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170B75403
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N0wxXi5l"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67ab16c38caso37663406d6.1
        for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394290; x=1702999090; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fUIa9V7UktxZJFMOjKnGCbu4VLxyvHPNj4gCPjpKbw=;
        b=N0wxXi5lYE2zmshA62RrO49T1576EV6T/8beNRJrTYo+91Gv/X+RUJ2zRpOlWanMaK
         PZPokqDFyYuwFQYw/VMRrOXPbeUr6HXQ8nP3xWQY30TB9xcnr7hvJjNCPDeKuI4O0hzX
         uO8VXnO9rhlOll9DeDCnhi8uhVx8Quu1D8E8wWt6OwCiuKwrLlo2VvznJ7psPEZjaJXu
         9p0tbPHCSBlZrz9CpT14nitF9PfnwsLDLwpZ3Qsz2SPmiP/9FZPNXnAQAuosA8W1Gpup
         AEsG/iUIoG1e/QZdKfBmjP1FvN3zCXAWD9VjDWSqgd6k7Nl9ut9iwMo0IAUNqZBWRdGC
         t9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394290; x=1702999090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fUIa9V7UktxZJFMOjKnGCbu4VLxyvHPNj4gCPjpKbw=;
        b=tlQ3/8x7IlIVvqqgZjU0P51atIohAB76Y7fs8tXA9fbP9POVUPlned2IFC1XRwSilG
         lUmeUzpuRkrbMIqpeEMrrrZfZXrmlOg+/+SslNRfw8tEv4GrJk9W0hG4TUcZxLn6OWQL
         IlC62bjUUR0gTKTVEhQgjc3NRdtuWxRdjKC1+183wl33b5swExHDTug+ftlvzbxamFZy
         2kxeEGuFTOl4MWhkjfifs13TbYWs5SzmIDKUJyTst6tEdP/lOCXasDvWCLLe0edkM/HV
         wKOrHZyPXd2qX0NoKgkEjdmx2PIPOPTkPFp6vidDL0gMZw4j7EGP5ORH09D4OZJzeCuI
         8lkg==
X-Gm-Message-State: AOJu0YwlC558rI23whcIw+Ce1PaSwiG6sFOCuAt6ozWUbqtuXR/omyTx
	GNlCKivULuC1wKdAUcRaq8SPXQ==
X-Google-Smtp-Source: AGHT+IEO/Sp55UvFmU80+iPDIwa6VlDwgsHYJtE8bskomQaUuOkqvskk69ktoa1wViJw6YFWts4t4A==
X-Received: by 2002:a0c:d644:0:b0:67a:bc4f:341f with SMTP id e4-20020a0cd644000000b0067abc4f341fmr7016622qvj.83.1702394290678;
        Tue, 12 Dec 2023 07:18:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id c13-20020a056214004d00b0067a4f49a13csm4048421qvr.127.2023.12.12.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:18:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rD4WP-00Ck2Y-Mq;
	Tue, 12 Dec 2023 11:18:09 -0400
Date: Tue, 12 Dec 2023 11:18:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151809.GD3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>

On Tue, Dec 12, 2023 at 01:07:17PM +0800, Baolu Lu wrote:

> Yes, agreed. The iopf_fault_param should be passed in together with the
> iopf_group. The reference count should be released in the
> iopf_free_group(). These two helps could look like below:
> 
> int iommu_page_response(struct iopf_group *group,
> 			struct iommu_page_response *msg)
> {
> 	bool needs_pasid;
> 	int ret = -EINVAL;
> 	struct iopf_fault *evt;
> 	struct iommu_fault_page_request *prm;
> 	struct device *dev = group->fault_param->dev;
> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
> 	struct iommu_fault_param *fault_param = group->fault_param;
>
> 	if (!ops->page_response)
> 		return -ENODEV;

We should never get here if this is the case, prevent the device from
being added in the first place

> 	/* Only send response if there is a fault report pending */
> 	mutex_lock(&fault_param->lock);
> 	if (list_empty(&fault_param->faults)) {
> 		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
> 		goto done_unlock;
> 	}
> 	/*
> 	 * Check if we have a matching page request pending to respond,
> 	 * otherwise return -EINVAL
> 	 */
> 	list_for_each_entry(evt, &fault_param->faults, list) {
> 		prm = &evt->fault.prm;
> 		if (prm->grpid != msg->grpid)
> 			continue;
> 
> 		/*
> 		 * If the PASID is required, the corresponding request is
> 		 * matched using the group ID, the PASID valid bit and the PASID
> 		 * value. Otherwise only the group ID matches request and
> 		 * response.
> 		 */
> 		needs_pasid = prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> 		if (needs_pasid && (!has_pasid || msg->pasid != prm->pasid))
> 			continue;
> 
> 		if (!needs_pasid && has_pasid) {
> 			/* No big deal, just clear it. */
> 			msg->flags &= ~IOMMU_PAGE_RESP_PASID_VALID;
> 			msg->pasid = 0;
> 		}
> 
> 		ret = ops->page_response(dev, evt, msg);
> 		list_del(&evt->list);
> 		kfree(evt);
> 		break;
> 	}
> 
> done_unlock:
> 	mutex_unlock(&fault_param->lock);

I would have expected the group to free'd here? But regardless this
looks like a good direction

Jason
