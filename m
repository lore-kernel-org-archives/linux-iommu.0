Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006A6994A
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529472; cv=none; b=oceVfGshRPl3UZbzPtgem/Kb/a0gesPz2hEOHntdQ3mVRBYl2i0R9ZU6gvImQoYmyeMYIFxE6oitUhZHdhcDVoXuXgSf6+ViHmHCUMBEujyKyXpkxcn3GfeKSTtqYMgbEvYfQJLScX1Br+ECuLJNrSxYv2+omLmBgy+ic9JIAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529472; c=relaxed/simple;
	bh=jfPSTOMFsVKRVNj7i8lkM+J2021KR6bAVax6Lo6yiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXWCykl5h8NyeE3L05Sr3B4fizrVk5qwX9BT32D96ep/CxfyLdL1gknRSDftxXylzG+TjV41RqsWmaRw7qS60O4OyhdRBSLdt6CddA4o0ECZnNAVeh4bqxfnrgId8BZ0YOCgyZkBMNCs45NjL+rgRrxUUELc7H9PAcCMc/gKCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mQ4We9DP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mQ4We9DP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7838af983c1so491808285a.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708529469; x=1709134269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8vitvLSu3BTqhP5sHDKjXQCZ2zP56e0qTlYZFKdquc=;
        b=mQ4We9DP5JoBT7JTD2X0doZqTzdcWNvIaGqaiJAJZvpx/zdmI8O8ZscnAowQZncI8K
         orBmRjAhxLfEASzREnba+ajkoCNiTEVIkZh2LgjU9BgFv/LBV644+fdLfE9M5C+zQCyU
         rYdIvUBgicS1d7XyrMYrETG24gs1sCniqTgOXFXlHhOEOB+VBeTSDAF4C+9HEUYITBMr
         yS1DWzw4G+mDiuIP+MgVzpqmyYCLepeEl/Hs3+vBdU1aAOhXDC3RWHCafXtmReEvbbDT
         q31OMLSybSTSfpgZZyB1lu8KNgfrd7S44cONCu+1dG+5B+mJm4JdOMVbyASMYcyOS/GZ
         hg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529469; x=1709134269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8vitvLSu3BTqhP5sHDKjXQCZ2zP56e0qTlYZFKdquc=;
        b=HrU21wXCihXQT5tQGTvZzDONJOgONHx5DMTDU0BthZ8HprNDxOxCntSAoccHKqyY5D
         taXTiXo8CmJTKYLyxHJcsZQ93Y8Mdo6yIplm27yII4CBTMhaDRE89lPbVWH1hUR2XRMT
         9gIWaob+tysIdcxoJbXRcYyuijaMIosolX1jeS1HYEo/yZO875sRdM1urUqFh6xxyYuZ
         qtk1CXcWtN0wzuc3AGDB8BKlNZXCQ31vSzqtdanREU//kwa8Ahg9MJFf6QcXAXA/Qgw9
         9dHt7ckoUvHwPnK1oQKqwCdn6xACLoCxekXOr16izGiLyQ9aFLZjXPi4Y3arD0kjrwW5
         SZiw==
X-Forwarded-Encrypted: i=1; AJvYcCXfaIn6GNM6cw8UX8gMuwFKsFEIhhrlViD0h4MQFYgZrBokEEp1qgsHNGPobMAB2WKIQLc07JW1/2XyB+RG3C+ut+6zZy8=
X-Gm-Message-State: AOJu0Yxx0O/krv5qNrvMAbV10kWju/wBjyf3oD+uEvaQqxHmjnwjhFOa
	QbrDHGK5S+YkrEOFX8Pjt05bNPhAcGxtlOnuL++AIrn7T7qNS5wIU69HNUXc0DA=
X-Google-Smtp-Source: AGHT+IEmPbtEB1n97pNqLMavAZrpmnUWZQCFJvhv79vGkSBI1itOYArJupCiyzSQO8AEzyfqYrdwxA==
X-Received: by 2002:ae9:f80f:0:b0:786:2d19:93cc with SMTP id x15-20020ae9f80f000000b007862d1993ccmr20111512qkh.73.1708529469737;
        Wed, 21 Feb 2024 07:31:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b00783f8693df1sm4420166qkn.37.2024.02.21.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:31:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcoYu-00BOuq-6n;
	Wed, 21 Feb 2024 11:31:08 -0400
Date: Wed, 21 Feb 2024 11:31:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Message-ID: <20240221153108.GA13491@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <20240215175534.GD1299735@ziepe.ca>
 <67391b2d-b441-4d43-aa46-2a30c95420a3@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67391b2d-b441-4d43-aa46-2a30c95420a3@linux.intel.com>

On Sun, Feb 18, 2024 at 03:02:00PM +0800, Baolu Lu wrote:
> A device hot removing goes through at least the following steps:
> 
> - Disable PRI.
> - Drain all outstanding I/O page faults.
> - Stop DMA.
> - Unload the device driver.
> - Call iommu_release_device() upon the BUS_NOTIFY_REMOVED_DEVICE event.
> 
> This sequence ensures that a device cannot generate an I/O page fault
> after PRI has been disabled. So in reality it's impossible for a device
> to generate an I/O page fault before disabling PRI and then go through
> the long journey to reach iommu_release_device() before
> iopf_get_dev_fault_param() is called in page fault interrupt handling
> thread.

Why is this impossible? Seems like a classic race..

Flush the HW page fault queue as part of the above to ensure there is
no concurrent iopf_get_dev_fault_param() on the now PRI disabled BDF.

> Considering this behavior, adding a comment to the code explaining the
> sequence and removing put_device() may be a simpler solution?

A comment is definitely needed

Jason
