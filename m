Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A71A3BCE
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937098; cv=none; b=J2XF/zTis/rv0ImBSJRqbOMqN82Mqm7pNlfCxVtU7mfDeRTJa9Nm5lHWc/fFnf/irl7pPUoYXOWrEOFY62vdS3x1Fq90TC2M7J89XQ4wf3AMQyeYd+xeVp35g8Z64rr5xX/wuPqqGvSH4e4y/Ph1EF7UVa1dsbmW7AqS6bCvTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937098; c=relaxed/simple;
	bh=l3a/nrwgJXcDrCqPZWFJQfP92351wbNDcCUTS0uGg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPrvc+tyUlfLsi66ob6Lglclj4U2n8dLBXggtlVdr6neCRGiQm1HQuMD9ZUhjpz/d00vMR+I5O9FUOT3BTk4OvvMIdwsRigbMW5S5QS/66g52p262wK/Dp95HIjiZpE2RRX09SC00fZLkeVwS6llfAj+flEzuciVBB0Y5Fkc0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EISQbzCT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EISQbzCT"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a8049d4a40so37486385a.1
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724937095; x=1725541895; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3a/nrwgJXcDrCqPZWFJQfP92351wbNDcCUTS0uGg3s=;
        b=EISQbzCTb5gnAG5udmSs64p0eNOo+rV4hPyWTFCsfhWtyq9eewpIN23JiIE7DDy/lR
         AjSDHiNL9Aca+7iF7myQJgpAlXae+OHSNYjIG371LdbPZSHnQ92FhsREceqYB59hPLBM
         KJSmDZgm633HnUD5eVVjPyFbnWG4Z353fsPPAOqPJNTVy781gzE2L5CbBm+iee12JsVZ
         nXpEV0EleRCWW2ai/qLP90eeiB40UeBvX6Yg79wUFPKDNx8uMmprmzizHVMBSA9lJmfH
         uwe5Xdr0woMBpqL6Gz8XPAfwWtdeOpE5UP/IXcYketyn/VF26l8mgEpekbC9/lpgech1
         3ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937095; x=1725541895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3a/nrwgJXcDrCqPZWFJQfP92351wbNDcCUTS0uGg3s=;
        b=Wbg+W/7IRBqZw/qZmHOTSdNfruVXToTbky+tPaqWrWeWzseBp+bNfnZz+esmH3B3pA
         UaKUSpCKIYGJ4pM58oH9mQOjDeiEbPedFs73dCbebu+sGKLiMt4KVVALqax4ASuefugp
         y2tn3xQG5qZdZkZ6ykaMuAse363QRFLL40OeFycHnMVHj7LGmHIhyJ7AVU31J5T77pP2
         SY9PqE+DT54ygtF3vYv+R43wkow3f3o0Rpjbehis0nAbCWUPNNJaz3qipKOD1M6/Iwne
         4BAGUAfeZwZuPPZ/+p+9f+1z9fPKXZREiBxQlgsTBENlszBgHv2/r78/p5+Sqcz6WILk
         yxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEEUL+ei5rKL83/BHPqdfDR40xzxIGGWnvhi0xkZSKaKFXEl31yC3nzzby3rUwLItKVrgSpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwANRIomj5LoWMqZK8DY570AeP35rhmVMga96Tr2Msnsf17w0B4
	OwhtI8C08H5IUee337V31lWtKR11CfUN99kt10ajT4tcBogqHL7xIQ7ToraVAH8=
X-Google-Smtp-Source: AGHT+IF0VCBzEl3MW3bSMcFaRbeIHrkfX7Oh6tHRY/6OhedZbsANu5IeivUu7XaeRfkem3I563stvQ==
X-Received: by 2002:a05:620a:d84:b0:7a3:78bd:bb78 with SMTP id af79cd13be357-7a8041b2f98mr284778685a.19.1724937089869;
        Thu, 29 Aug 2024 06:11:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bfc1a2sm50114285a.10.2024.08.29.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:11:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjevw-007cfx-75;
	Thu, 29 Aug 2024 10:11:28 -0300
Date: Thu, 29 Aug 2024 10:11:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240829131128.GW3468552@ziepe.ca>
References: <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
 <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
 <20240829121002.GV3468552@ziepe.ca>
 <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>

On Thu, Aug 29, 2024 at 06:17:38PM +0530, Vasant Hegde wrote:

> For HW-vIOMMU where we will have nested page table, Host will be in V1 and Guest
> will be in V2 page table. We need to add few checks to detect and use
> appropriate page table. It should be part of nested page table support.

You need to push those checks ASAP..

Guest enablement needs to be fast tracked to distros ahead of building
the hypervisor component.

Jason
