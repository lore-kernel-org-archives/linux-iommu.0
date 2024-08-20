Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FA18E77B
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161954; cv=none; b=dTfO0sIulDhJ6sU0quF1MqLQKR93M+LTDb3iP0oV9Y+5/W+rVTqpQzfk5B0ocwZz3nN+jvQ8S2E+ltyi1/arepH7wxIrE+DoLADG5aBmutjUDyfNSG+00Q6VZhChg93RNTmVTRHnr8gFHlkcTYhhijgRieMtC3W1EKZ/+WdEJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161954; c=relaxed/simple;
	bh=f82abBbg9jguh/VDRR9fMf/RDo5qRnRxbSo6To1gBvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3KHiZX5vRSHL4qRqSFSnKqRePBCKAIBcomA0B8UvuHHSQjMMKyIbjuAO8hFThtrmbgJbJsOAgYSmmWBDRqLsXcsknCuhgMBsbmCSMK+NGxugBPhpReuCOjOWzWY43xz1AbDLeK+DRVI6EU18XoXGQsv/3WlPulpx+CXXY4Y0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HgWgcQf3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HgWgcQf3"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1e31bc1efso352882085a.3
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724161949; x=1724766749; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67FW9uiQtDU02nDB/lzmQFYFhmPDEgPJ7AO31offMAw=;
        b=HgWgcQf3dpM5N3PDATGZjSm0jrf/WetavGvwsRygugcph4hospEvdidJchQ5m1R2JL
         9n/7JbnbwXSqLVHIJ2qRasQ5Rmgm/Aqhi8diieyufhTPljnrs0gXOhZQKJjtm/PcejL+
         q4MNGTz1n/0EzGG77KA3ndJ1QceDjLOhYnAM34EC/P3c2vZDdH39t+FknvlvUT/1ECul
         YTUbaiqBpnnB79qfaUn+msLM5sQtDyClMroXxP7YyrVsZqXHHiy2Otd2Lk+QaMGIQEYU
         tF3PNPewZQoPSfmNcjBGSh8/6we9yBzNoK/oVI/vrL6wEanrAxS0sw4W12a+3PAhmM7s
         2itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161949; x=1724766749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67FW9uiQtDU02nDB/lzmQFYFhmPDEgPJ7AO31offMAw=;
        b=l9ottkTCCo/xGlWqfbki9fJxmlSk7EnSt9zUNb96cOjpkjNSmDKUcZEw9VDttft7Xp
         xxjl4mgHn3oMJb8BSrSCPBS7WW8NE9A04KUmfALUQnbRJ+j+EIbRDbcZjj0xI0cB0hS0
         Lad/QurnfhaeUpFOYo5lteZTSvp7kupeEnoPHgcwVm2P9ahAKtuuYZhyRq/iHgpBJyXf
         cxT5tnbShVLecCC1A7cbu+401aiVwM4UoW63mfb2WkmrpdcTzh/a4+6K+tQ4TbxlY8ja
         fz0OkQFUYEoQDAVNmHBB+hTtNtDBY10dgXZnYPYVX6/SPeBdPO4Ot/Fi/SA3W2wy583L
         7bGg==
X-Forwarded-Encrypted: i=1; AJvYcCUrgjz4EhZWMSVvy/uPdF6CxFA/C0+vTVSPzJQqt773Tkrpz3XDtKiR+lLBx+JKjeGTnti92Q8ewlIwrsV7RhCVNA/cP/A=
X-Gm-Message-State: AOJu0YwqPLXb3cc4O/9JBT4Og/E7237EFGvCueDj4GkzpWpO+TwkRvYY
	r3s+V/j59IndR2QA4mlaSsgWU1JLjPorrZgc7CanSiVtO4eJZaBDa3mSDH/5xLI=
X-Google-Smtp-Source: AGHT+IEhNIv0Ij2MIGvabq4gRCT+4B/5w3shoRSv5yF3X/yF+fiI0jyRZ5wjshZ3n7mQC+eePGdBkA==
X-Received: by 2002:a05:620a:1a94:b0:79d:8153:57aa with SMTP id af79cd13be357-7a5069d48b7mr1515182485a.48.1724161949724;
        Tue, 20 Aug 2024 06:52:29 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02f89bsm530357085a.23.2024.08.20.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:52:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgPHg-002W0g-35;
	Tue, 20 Aug 2024 10:52:28 -0300
Date: Tue, 20 Aug 2024 10:52:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240820135228.GX3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
 <95473081-db0b-4802-b875-24605ab2ef37@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95473081-db0b-4802-b875-24605ab2ef37@intel.com>

On Tue, Aug 20, 2024 at 04:55:26PM +0800, Yi Liu wrote:

> Are we sure that it is ok to enable PRI before enabling ATS?

I did not see language in the spec prohibiting this order.

Jason 
