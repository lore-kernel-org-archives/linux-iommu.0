Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB7285404
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290011; cv=none; b=Bco4XXjVsbnVj7/sm+wcjh7WKGGbtW+CXkNB4HrYjtaYatK2WhN7KPAmO+UvsdwGJvOLg/+JnTruutIIwBND5IIqcaLOr1TK5qU8uZFWk0MXpscSSU3NC2wXujxatKODT1GbYKuXZrUgfXwwbTJqwq4SrhrLwrmAqPZUYgaJRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290011; c=relaxed/simple;
	bh=m7Z0yYpRm79fgEb6YmXFOLVv+GzsYP9fjX6jcKkZ6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br4/tY/wg6VDGW3HftRCd67797GatRUJiaK55ejnTOSR4unw9iGnLpoy+8OlMdD/W6BiGf7HLh8HtMoDF1hmCWgB1xsWRy6nCoP9gE1/Rszr2GQ99LD0M6ZWMw+C0zV+RalwccMzoEyqmY8dhp5I1cbcTbg0XN6vD1yoWwzAERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OLd5bHfb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OLd5bHfb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fce04655so5755806d6.3
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744290008; x=1744894808; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw0sPz7v8LS0CAWMOhVgeU0Cp08HZ75p6fVMZNaNdbQ=;
        b=OLd5bHfb2nK3EVwhVQvavrZpsFOxAu8lB9mbSDQMSrmUc3QfEQ7WVbBnHfwq08ap+V
         PXKjSIWzX3RNWr4GIBHWBsKJGZmqyZO0KAOC70kTc7wNsZMZcx3XMFRv5sHEa+Zf/ugc
         hf/kSLZA/3suCdprs9qu0Q6D47mBpgaeKWGeUgOhrnB+0LGj8JuGLYTiYJvf4vqXGc6Y
         BZEuUiRNNzayxKxBLCBL0FaGX9iyGMAWNO11gxV2EaUbTLBwpPQkAu/a9rTuqGmmQf4W
         i9KIGo/SJZmLXgfbAQGStcIVmngyH+G2ofs8xGmn7W+pD7wfScjc3nP/HmG6J+XCnXF/
         VvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290008; x=1744894808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw0sPz7v8LS0CAWMOhVgeU0Cp08HZ75p6fVMZNaNdbQ=;
        b=FlgmRF8805BXhun/HRrp1e+v6og8JxQ9iUJVcGZp3b9fIo9lctWIRdf42EQU5ZlFhA
         qZa/3b88p1ZguxjGTT+NWT1mcJZ/xK3TY3TTzxSnFlHYdFC+bFN1yn4QeMXOEI2HsodT
         Bg5ZVRJD21zdxipmRsTeJN6I/VZqFz4Xchf7Bbcw6+ppLEqe3Vm6cHcs9GYZLG5xRJAn
         7vRgOO8EnEEqgsMfDJtoCVCxspbF3W71kwavsYxpVwXYJ5bJGtc1w5A8QR8f2xoreVn1
         08Gp7FHYolh5J44srPjBnLEtnZ2Qi5W2aHrlW4WinVaf162xGTsZT6V5TfCRSaknfhx+
         HfqA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9ADDBBFR86fqUQ6O9JLfuCPj//b6qJPHU0sIjMFuHGNgkqRaEGK7F3OWMWFCozcQTlSxjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQuL+3B3GytVZp3ozRRGUtmUX3naRg2/gxAskOtRrtmxMSaX/b
	dilWOFTUdSIC4MoVftIEBgDbo6wCGyqnhjFTf8PFg7uNgLcMXYO4/rSl28aSiQs=
X-Gm-Gg: ASbGncvg7sDFF4cLWLyNpvR8g1s7acmavzRBmLC8dc2NNYo4xczVow24JDrwwfLIizf
	rAzyeQlJO4cZ7tlkUxkHzolnbVIl8yodg6hlMGqjgsq/JpsU+f+2DzckobsUD1MCftFxtglJrqn
	1kN8F/RDk9sv7VXXhY5zdsc6Kaf9HmlLSh+YvotNRWGRcaBTEUwvIkHmUxB/5RmVlaqiTiODIJE
	icX8Bnzpx3BtwouSt64zkaVsjelBEOL4zUnnDpuj64YFtCGbFpp/+4uq2MiOeTKl1t9JeIxGgfP
	aSxS1kXXvkTzMUMCDqUU2uEONIMIMOSAng14VnrHHRHkPv82ctgOEQAZHtXeGdfe0Y2qcVIT+zf
	SfwUdOOD/W0OzHoHVF7XbvOEgLKcrIw==
X-Google-Smtp-Source: AGHT+IHV+4h17MmPjJdRiEYMcX/HrkQ8ur+6FJoazqwSyALLqiGaa9IaitQwXYP2okcYEgv65MC6QQ==
X-Received: by 2002:ad4:5dc8:0:b0:6ea:d49f:ddeb with SMTP id 6a1803df08f44-6f0e5c927dcmr45949516d6.31.1744290007618;
        Thu, 10 Apr 2025 06:00:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8951764sm81874985a.40.2025.04.10.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:00:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u2rVm-00000009a9u-1Cgs;
	Thu, 10 Apr 2025 10:00:06 -0300
Date: Thu, 10 Apr 2025 10:00:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] iommu: fix crash in report_iommu_fault()
Message-ID: <20250410130006.GD1727154@ziepe.ca>
References: <20250408213342.285955-1-pchelkin@ispras.ru>
 <20250408213828.GC1727154@ziepe.ca>
 <74c07104-d072-4d2f-9b79-d9a1c3f2bc54@arm.com>
 <BN9PR11MB527618FFDCF2D7287C3ACA028CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527618FFDCF2D7287C3ACA028CB72@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 10, 2025 at 05:29:51AM +0000, Tian, Kevin wrote:

> It sounds a general requirement to all IOMMU drivers, but in reality
> only a subset of iommu drivers call it (e.g. intel/smmuv3 don't). So
> there seems to be an implicit assumption from drivers on whether
> the underlying IOMMU provides such facility...

Yeah, it's a bit wonky. And a different intersection calls the new
fault handling API instead :\

There are only 3 things using iommu_set_fault_handler():
 - drivers/gpu/drm/msm
   Seems to actually do restartable page faulting?? Maybe it needs to
   move to the PRI API..

 - drivers/infiniband/hw/usnic
   This just prints a log, we should remove it

 - drivers/remoteproc
   This prints a log and does some crash_handler

I just quickly typed in a small series to improve on this..

Jason
