Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F8A92A
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 18:46:56 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76ef653af2eso368061185a.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694544415; x=1695149215; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRPkaKw0fsk2DFLb9cphUy2aoYU7l0mwmJAEBxaUrd4=;
        b=HIjrFvT4nzceTinE/g2NAdUTSss6Zf7gUyMlktBL75YDh7gVKAO7n8WEkVa7PUpK5H
         GeKcbt6mxbyCMIfxxmQG1NM1tPjHxiK5ss0MCUcut8OhDzJ7B6or2t4BYX7v/CA20dGn
         ZRt58C6zyDIZaM6KyIdfMcBM7jdoDxD30jjvYit3paNWZ83VPP8dwhCY2FM95Y5mkqx6
         +1MvKaWNdSBZnh+1DzY4di16RjfTSoAXb633DQtlzZ1ffRfQFtORVbwJiP5ipPx48HmN
         dIZF70Byl5ZXYOgSilaNy44WfBX9d8gpqKFqi6X8Lkp6bjQua1ye4sE50DseZvcyhANV
         77yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544415; x=1695149215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRPkaKw0fsk2DFLb9cphUy2aoYU7l0mwmJAEBxaUrd4=;
        b=fXEDxsGF42P0Ck4RPm1tUDqJH/FgkCcPmoHVA7H7t9z8Y2HaMExk5TEFRmvmsmomGq
         KMlZvvnQhrajFS+xh6RS3uZ0g0SvyFQawUdwRowTZAoLAa4GReC/FR0WJPwceUya7dtZ
         qcxTEaHkC42x++tR/9LpxrDJL6cueFgzOJ7sV3QoMKUTKogHD3VCL3lI3EiJLMV1CjZP
         i7A4HAsc3XXQFjmAcyOzd5JU1Oo4+C0ZhYkz8FX7ocApkoxvtzfZR7Qjl/Ajx+a7MbSB
         Fw7gV6zu0wvfIRmWNUXRqiNK3utwHxuzdDFnqtSnz/W7VJb63eEw1s97tIgaLyYkgrGO
         0QsA==
X-Gm-Message-State: AOJu0Yyy63fuFgvAdgvZk5v7Xve0qEniTcJLivjUk8ItnjvE+fc9nNxt
	I96xGFgyoOabBSffK57muQ7+bg==
X-Google-Smtp-Source: AGHT+IHet4JEiu3UoiixVBa3dUZCN3fsblkD7Yn1W2FlJr5logjEu684jfjXseQOWVxKFJV4KA978Q==
X-Received: by 2002:a05:6214:1884:b0:653:5960:8959 with SMTP id cx4-20020a056214188400b0065359608959mr238177qvb.41.1694544415335;
        Tue, 12 Sep 2023 11:46:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id y2-20020a0cc542000000b0063d252a141dsm3851555qvi.116.2023.09.12.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:46:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg8PV-002GIw-SM;
	Tue, 12 Sep 2023 15:46:53 -0300
Date: Tue, 12 Sep 2023 15:46:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 10/11] iommu/amd: Add IO page fault notifier handler
Message-ID: <ZQCyHS9VFXZyAK4P@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-11-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:45PM +0000, Vasant Hegde wrote:

> @@ -285,7 +286,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
>  {
>  	struct iommu_dev_data *dev_data;
>  
> -	dev_data = search_dev_data(iommu, devid);
> +	dev_data = amd_iommu_search_dev_data(iommu, devid);

> +static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
> +{
> +	struct device *dev = iommu->iommu.dev;
> +	u16 devid = PPR_DEVID(raw[0]);
> +
> +	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
> +		dev_warn(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
> +			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
> +		return false;
> +	}
> +
> +	if (PPR_FLAGS(raw[0]) & PPR_FLAG_RVSD) {
> +		dev_warn(dev, "PPR logged [Invalid request format (device=%04x:%02x:%02x.%x "
> +			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
> +		return false;
> +	}

Please be careful that no guest can trigger these warnings..

> +
> +	return true;
> +}
> +
> +static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
> +{
> +	struct iopf_fault event;
> +	struct pci_dev *pdev;
> +	int ret = -EINVAL;
> +	u16 devid = PPR_DEVID(raw[0]);
> +
> +	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
> +		pr_err_ratelimited("Unknown PPR request received\n");
> +		return;
> +	}
> +
> +	if (!ppr_is_valid(iommu, raw))
> +		goto out;
> +
> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
> +					   devid & 0xff);
> +	if (!pdev)
> +		goto out;

Lu, here is another case where the core PRI code could make use of a
core helper for a getting from the RID to the iommu world.

> +
> +	memset(&event, 0, sizeof(struct iopf_fault));
> +
> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
> +	event.fault.prm.perm = ppr_flag_to_fault_perm(PPR_FLAGS(raw[0]));
> +	event.fault.prm.addr = (u64)(raw[1] & PAGE_MASK);
> +	event.fault.prm.pasid = PPR_PASID(raw[0]);
> +	event.fault.prm.grpid = PPR_TAG(raw[0]) & 0x1FF;
> +
> +	/*
> +	 * PASID zero is used for requests from the I/O device without
> +	 * a PASID
> +	 */
> +	if (event.fault.prm.pasid == 0 ||
> +	    event.fault.prm.pasid >= pdev->dev.iommu->max_pasids) {
> +		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
> +				    event.fault.prm.pasid, pdev->dev.id);
> +		goto out;
> +	}
> +
> +
> +	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> +	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +	if (PPR_TAG(raw[0]) & 0x200)
> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +
> +	/* Submit event */
> +	ret = iommu_report_device_fault(&pdev->dev, &event);
> +
> +out:
> +	if (ret) {
> +		/* Nobody cared, abort */
> +		struct iommu_page_response resp = {
> +			.pasid = PPR_PASID(raw[0]),
> +			.grpid = PPR_TAG(raw[0]) & 0x1FF,
> +			.code = IOMMU_PAGE_RESP_FAILURE,
> +		};
> +		amd_iommu_page_response(&pdev->dev, &event, &resp);

Just to call amd_iommu_complete_ppr(), this already has the pci_dev,
we don't need amd_iommu_page_response() to get it.

Jason
