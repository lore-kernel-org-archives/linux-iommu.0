Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D803D090E
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082536; cv=none; b=kXHkvjkqx3pdZgP2RYLBjfSJamCIAALN00Jo5KxZ6WVMyP2OXWbcuoBODGCEqqQ2YD1F6jMpc8qUIEvbaXNA/wc11sCCarY2d4L//mYmM+pkKNtJNmyXGwCk7tjUiEp5e/f903VMDkX+/uqvIIrLynp87oZM5Eo9e0LhXSPbNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082536; c=relaxed/simple;
	bh=6CYHJlxkNTZfdOatQqSstuMCIp+AJa4DKfe/htlVSzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrbyoED3D982JG7UjMt3JGzp+d4UGR3Qy1JotQmVR0rBF27qKQR7z3gpfXqgnN+GY/Js44vd/JAuXEOFT1DIxtN0L4waEqYeqUS7O8p4Yxi6n+GCR6EOpOBm59W3UqQcoIi135DBKe7FM99FAfNXOUmEFQ98X8kEei/XYLbjGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AXFSQS8d; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AXFSQS8d"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so24375285ad.1
        for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785082518; x=1785687318; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bagmeEHehug/GOrhos1Z3fTBlBFSZT78kPrPQp6rhbY=;
        b=AXFSQS8duKoOxPNaiI2OFPwvov9fkktZb20K+mOhejkg7HndcK0sjq3cLNtfd8ws5O
         84uZtnOgBjyzVa4raYOGch7DBeCqc6FsqtxSPPy5GJf6vExS4aszsATcRBev7vTMDIsu
         Jtqgf2slKxFsSa49Vh0ZHSmcBsHLufFXzu4+w4XyAJdD7geQGO0+obdkJXBeeV4vzEPH
         xAJjql2huF+9dn8VLEle8lTL2oLK40Z8aagQkpPJFpsq7wL3XzPXQ+26qlW8jEaK9kn7
         Q9qiZnJ7PUGYvdgX9Oap+U87A1u7kd9yprIjH52eNPfJSL7dVL8XO2zzMYeM+qt80If/
         +aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785082518; x=1785687318;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bagmeEHehug/GOrhos1Z3fTBlBFSZT78kPrPQp6rhbY=;
        b=KMLUxygbfJ/Pih91D07s6zhI1JeldoqhMWx9jtGTc/6mYtrc4fG2mdxRPZfHDcDd0R
         637fvQe1xE5B5hP3ixdKeGvt6gjmMbgy/aIHA7O5EdUx0LN+ZuzN1niQ7G6u8FwSrQrZ
         A+EAI7FHDsSxegS3XbbBTZBHOxfg5wp9c48ckhonRur60dzM+xsyHEaf+jM4o0vFiOQe
         M4CWmBHAdV+esNIx5lDRYvzLvtykGfOKdOkbVg9iRZXATpZsn8hCjGQdj0Hy3mDqN8X7
         s+xXa24qh4EoInBMywsQmeTx5sFYbZCFMozq4ea3lcpZZXBdRx8CyXvWWNnQl1n+UXos
         SnlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVYbAYINoqmUScwzx5UopXbNRgkwrhkFczprR0n98+q3pMqEHoUwESsxaJeUOljU9EVXcTUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4/anl5ujDPN4RkQV5qt1DGYzYFz8qelP9w2PJCLrVrrPwb+8H
	I4pAgZYn3ehBjC80cnSXXM2uc1f/I7K+Ni08CCdUzUm4hA5jq+r9Xzyg/O9tUAxP7Iw=
X-Gm-Gg: AR+sD112or2Od+3qPyjQLooHIvk+tGkHXJtfIInQ04xF6RfHaKy0C+Z92u5WnJpvh2n
	2acFv6KLkspATA77vCXyKfdaqJboocygOMZz3OlBZWAl/aGoNDuoiFULZILAvd7tQLzHATEb/bg
	zqDN0cLk5RHytPKtzcXp95IaSMJjKiVJdsMPHkhwzGgIprazARLkMwWqco4AQNI3MhEfZQaoeB1
	S4DD8YlwbaSG+PqRNBpvAd0HnKYSsDgtMoqsKwjsxtjrGjVYM29HzyE+Hx+fpgnvOaZVUCv6VCV
	qtZqh0uZH1Q0eig1z+17cSU3fgWA3TQr//Qr/fVmiJTImw2zKgxt7zKOp5SmFEioQ3tdaaeZHcU
	QiWrksxoDEkJRmWK5LqnqZaAK7H+9znRH1HDGhuHdWrHX+TMTPes=
X-Received: by 2002:a17:903:1110:b0:2cf:ba0c:aa5a with SMTP id d9443c01a7336-2cfde8af449mr45818245ad.47.1785082517786;
        Sun, 26 Jul 2026 09:15:17 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bc68sm21236295ad.2.2026.07.26.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:15:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wo1VU-0001KZ-M1;
	Sun, 26 Jul 2026 13:15:16 -0300
Date: Sun, 26 Jul 2026 13:15:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>, joro@8bytes.org,
	kevin.tian@intel.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 0/2] iommu/iommufd: Fix IOPF group ownership UAF
Message-ID: <amYylLjeAXTeqWVM@ziepe.ca>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <B0FDD4C32AC66FCD+20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
 <amYBCzc2dfH8A6Mo@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amYBCzc2dfH8A6Mo@willie-the-truck>

On Sun, Jul 26, 2026 at 01:43:55PM +0100, Will Deacon wrote:
> On Mon, Jul 20, 2026 at 04:50:15PM +0800, Peiyang He wrote:
> > This series fixes a UAF caused by an IOPF group being owned both by the
> > generic pending list and IOMMUFD's userspace fault queues:
> > 
> >   1/2 Minimum fix: dequeue accepted groups before IOMMUFD queues them
> >       for userspace response, then remove the check on list_empty()
> >       in iopf_group_response().
> > 
> >   2/2 Refactor: make iopf_group_response() free the group as well
> >       after responding.
> > 
> > Changes in v3:
> >   - split the v2 patch into a minimum UAF fix and a follow-up cleanup
> >     (suggested by Kevin)
> 
> Oops, I lost track of this as all the versions of the patches are in the
> same thread. Please try to avoid that, as it makes it hard to track in
> an email client and can also confuse tools such as b4.
> 
> Anyway, it looks like v3 is ready to go. Jason, is this something you
> are planning to pick up or shall we take it via the IOMMU tree? It looks
> like patch 1 should go in for -rc.

Yeah I have a bunch of iommufd thing for rc I'l pick it

Thanks,
Jason
