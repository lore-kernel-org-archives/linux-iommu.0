Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D02DC355
	for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710003; cv=none; b=oRoT8+2dcltCEW6HqERb8vLfVOO7iT9YAYEE9lNGFyOUBWmzgjVTJreasKf/Wx6mN7uWFWphXhp0FAB8TTma5D28uLeO2cJEgDLGZUxbOQnm0aDgNDObptKeiC2GFrUHyKQWYk2kJ6lrDL018+RKHoegg9b8a8MVGSaFh86omOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710003; c=relaxed/simple;
	bh=jbPVSAPrjwCZ1QgFLEq2EkAZjF01jNgD4rg/XY2hQcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L33aFtHt/m460SR3q5A/1K/lJ3vD/Ji1XC1/o7m61SKbIcHu5ihfoJ2mVWcKodWvbHpiBNLU+GMPixG/4KXnftNhHuxiSE6oj8XwyC6COUfKdecGaGyXFsoZDIgvWEkwHRRN/kHJhsCSu5epfNZ2ZgHbBeX0BNoDvXW8RNoziEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bWRltI+K; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bWRltI+K"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a288811a4so12445166d6.3
        for <iommu@lists.linux.dev>; Thu, 29 Jan 2026 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769710001; x=1770314801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvou5EnfC6erSqFqmm4M1vH3YCXBRlE30VyZs921xdw=;
        b=bWRltI+KIi2Yq03H7tl6tvzkLAPo1Jtiq/v5f7afxOCHXx7+ANiFXD2XIgtlu/RxZ2
         M1AL+sSYLIrD4S3ZiZvSRd0EvykTqvQ3dJD1rc8WrrkmzlaZqLdb+v5eeAyKYkJeOD39
         hgB7pwWiJackCTmhXyFreQd0IdnO2SxeJpWtMGnL48nY90vUXyxRISMscp9i7JbUfi1G
         Z99qt+m5W0wWlxBUbiJ3WtUu7uVMIr+te9rHokKJz0u3zMxLSB4E+CTBSoXnzBX23fl1
         89QkNYJzp5NmR8o8hu8kEm/Kt4Sh0zzFcXr5kF/peOQRiXdyvgjuGeu0iosvcidnV2fU
         S8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710001; x=1770314801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fvou5EnfC6erSqFqmm4M1vH3YCXBRlE30VyZs921xdw=;
        b=kbhJFKdueIgjsrr41NCbHJi9r6+fAXMv6RhhTLdDW8ysZYH6WPZTyglWnSFv8FPF70
         haVIf9is0zSR+Uf3EKL1ppwD2LipOZkk0s0220vU+xlgKfRHOSSbD1m8w0eVdjKXIoXY
         gfCxSww7lBza38ElMt5cEg3pg32MMZxGUrd2rzP13EJx+ByHNJP+Tbvnx435bpacEfa9
         yc5UKRm+wHfVIF8+lX7ZzvBPkeJF/6/LayQqeU7+7VaSqnAg99mq0XvE49ipKOhAT9vA
         Qg+2rwOf7A6KNP6uisaXORTH8HOGitF/4MbcSTrNDv9oJAzWwd13RtwSEj+fYraMuR60
         I3gw==
X-Forwarded-Encrypted: i=1; AJvYcCXWefDLboW6lhtTgxeWovbTuGUbgzoNusLTjuC9IWfrfcsKIiSK0aTKfULhwDjuIKJVlKHJYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBNOtk/u7ZCIfdN/y61nakcj7p60lzlvEzmgEcnaV5AEnlJT32
	DBvWzZuN1PAetDRInkW5mxV0L5uNlcxoujYpwo5jZuCeU6nzemZY5/5k4lviMIG/3u4=
X-Gm-Gg: AZuq6aJy2Zgo8xKwD8QoG+PlQ1tDSJ0TIjArBVadvU6Iy702v97WNk48vr5LkQmbsCi
	2tZatBYAsP42xceAZ+0RA53A2ExUWmtY40bUZ5i07mcgAAd5FkpFGIyEjZ6ZQ7943Dfl9SZVL/5
	njRkGpr7hlkEKRAdxKoe5IQGim8WWezBAfD1LkNRUFqhRJDYOHBPsvI/IHy3tR9scSQgaciPM3R
	m0x1jC50gIlocN2mpDkS4O5Eq3pmivOo6WOjkfU6KNBJDtkTFOOUS3FzuYIyVFYNFQixZkgHdey
	CjkZHoKeO9QUgtbPsftCWRToVS9zWTTKlXHbp8wbcAb+4/LF+cQoNW1M3mxNH2Bb6IiNtUdHZz0
	Lup90fJAQOOLpmYyAo1eYarZ1IHcuKDpp9FwLxkQs4PQOro7m9jhATAUNahuiHLcBl6mHi0dM+B
	7E7Zd+H9wTAAYEO3wQA1WF77a/Fkk622OcCJkVaPa51gGq04Gh7+pgyhtqMSFu3ghsGN8=
X-Received: by 2002:a05:6214:f0e:b0:894:2d0c:5de4 with SMTP id 6a1803df08f44-894ea058de0mr3910776d6.34.1769710000756;
        Thu, 29 Jan 2026 10:06:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm41852446d6.55.2026.01.29.10.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:06:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlWPf-00000009mLl-22aB;
	Thu, 29 Jan 2026 14:06:39 -0400
Date: Thu, 29 Jan 2026 14:06:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Message-ID: <20260129180639.GA2328995@ziepe.ca>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
 <2hua2e6admppbj5ttscqmclngfkvqpccix4n35vc4xc44o2bnr@yzw6hyvmar2c>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hua2e6admppbj5ttscqmclngfkvqpccix4n35vc4xc44o2bnr@yzw6hyvmar2c>

On Thu, Jan 29, 2026 at 11:12:07PM +0530, Manivannan Sadhasivam wrote:
> > Manivannan Sadhasivam (4):
> >       PCI: Cache ACS capabilities
> >       PCI: Disable ACS SV capability for the broken IDT switches
> >       PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch

I'm OK with these patches

Jason
