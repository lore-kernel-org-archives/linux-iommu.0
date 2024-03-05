Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD67F
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599205; cv=none; b=D7J0yrI23bISOyGoM7qbGTRfqGs7Bu2QPHTO0ltKRhIDVnq/mJX4Iuhbjzj//pF9B6w5/xJGCYr4W8pTFP1mDG5LrKUn92LggKH4EW+IqumMZVdqaXfdg6lah71T6NddMgKgFMJko/1PZDQu3zn7dfaAHjje/OQyhXTA18o0Usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599205; c=relaxed/simple;
	bh=OJVxlvUHWy2uOkUJ9qzLlrd+YUDXz+sTwBcLeuZtP5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqI44z/op07P9quNFcc5tonE/RhfdKhqMZJ4wClvg2VjZNe29ViUQgRceIwQTZ/hs0AShhQlSOQ+8TKVmmvW9tlbKqKS03sk9E7+h3Hm8bzDmwEHcyEioOqpzVz3UWvdPJY7QJQHz7WYjiEdmtyc+hbN8spTZjbCanY733BcJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=obg1zYd0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="obg1zYd0"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a12060fb59so1442845eaf.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709599202; x=1710204002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVtsAUdyiMgNvT7uMIw5qQhwfMqE3HQO6gWH1Lry9MU=;
        b=obg1zYd0aNWzsO01onilddQK+UC7wtvLQxOhN/MxmOxxqRzhS0fblCO5An/4CnbbOw
         AATXBwZOdsraVWVnsMzQwJk7TNsYOocA2yFGRwZpqHF8+FVd0KdkxwXhHsKnT8dHYEes
         D4iM1OXrn3sDIWTffSrzy/huTf/ywrVJSRagMapcqzjIk8sMU0y+jaMEH7+kZO+5OtKY
         f02UkulFaMN/E3mKh8sLaoXkV3Dcpd3L2XrZrl4mRrWlLSwPGCvBmqt5WiiRWfS4JF4C
         /BgdVW7x7BYWawzoog9lebM9NM8wHwGZUufOePlR0V+EEOBxy8z+QPkoz8vSW/gzeW8n
         i+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599202; x=1710204002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVtsAUdyiMgNvT7uMIw5qQhwfMqE3HQO6gWH1Lry9MU=;
        b=WJG1VWubqs29eeo4qZpPcQO/fnMhASuh9zzJ/u5QtFv1aStgbdsoJkp325Gnl7xwql
         pFGV0z8M9wdwNu7WoouHp9dusOC3e+/afd4n/K8uRdHebfO891O3J3TqswTqZeniEF+P
         S0w9KEpM/D9qfcGCvQV+5QDZ6c0keSB5dWr9rW1ZoinjlszZdEt4SuqZdtueqQfCgXjo
         Y6nh1DPOQ6SyHsJ31/FfSkT1x+U7gSqYMReHSL7EmGnN4bznmrb3SMcLAbfv0XUvPA2x
         dPLFesZUFwL2QIr5lIvdi8Z6q6Fy4YEOfy8KNORRrPWLpcWsjeZxWLjwNZj5ed4X9VhE
         fNJw==
X-Gm-Message-State: AOJu0YzPgl6t7MLCBuvzH6i/3MrV2XUXTvLZesDRrnTQN6hpC/VtZ9FV
	pCj4Mas3bAn2hFV1NoTuAlx29oWmeXrd49qjqufricOodJE0IETZ1yzrBScA+Rg=
X-Google-Smtp-Source: AGHT+IEt9tiA/2ReNRUFrQzgscif4B8CsCi+sw7D79HBoMEJYz36PQ1ssNo6IUHIfnKdfF7TshF8Ag==
X-Received: by 2002:a05:6358:5924:b0:179:f2:daa4 with SMTP id g36-20020a056358592400b0017900f2daa4mr293076rwf.24.1709599201973;
        Mon, 04 Mar 2024 16:40:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b0078830d4ef5bsm687585qkm.107.2024.03.04.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:40:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhIqf-00DZkP-2N;
	Mon, 04 Mar 2024 20:40:01 -0400
Date: Mon, 4 Mar 2024 20:40:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 11/15] iommu/amd: Add IO page fault notifier handler
Message-ID: <20240305004001.GF9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-12-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:26AM +0000, Vasant Hegde wrote:

> +static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
> +{
> +	struct device *dev = iommu->iommu.dev;
> +	u16 devid = PPR_DEVID(raw[0]);
> +
> +	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
> +		dev_dbg(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
> +			"pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
> +			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> +			PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
> +		return false;

Someday this will not be an error..

> +static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
> +{
> +	struct iommu_dev_data *dev_data;
> +	struct iopf_fault event;
> +	struct pci_dev *pdev;
> +	u16 devid = PPR_DEVID(raw[0]);
> +
> +	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
> +		pr_info_ratelimited("Unknown PPR request received\n");
> +		return;
> +	}
> +
> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
> +					   PCI_BUS_NUM(devid), devid & 0xff);
> +	if (!pdev)
> +		return;
> +
> +	if (!ppr_is_valid(iommu, raw))
> +		goto out;
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
> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> +	if (event.fault.prm.pasid == 0 ||
> +	    event.fault.prm.pasid >= dev_data->max_pasids) {
> +		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
> +				    event.fault.prm.pasid, pdev->dev.id);
> +		goto out;
> +	}

Why even do this check? The core code is perfectly fine to take in a
big pasid value, it will not match anything in the xarray and just be
completed with error anyhow.

Looks fine otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
