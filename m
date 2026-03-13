Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1B3947A2
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419389; cv=none; b=EgXk1+RikQ0tBZ60HIsJgnKx6TG7OVYgcrYzbvNrLMfZJve1USTDXNSMz6w5Hh8/TyfkxCkFKiTR9cenx7KxSpforVZOBKMmSVv8RHUDP0bCMC9Tt0arHfO9QBI76e/MNshBJ4IgDnxbUg3c2szT/RwrdvPpN9u5a5NiZ+hYJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419389; c=relaxed/simple;
	bh=EZoFcnTv15ywdGMgzpXfHMHTakhgmPvW43ji/xyzqhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgoRW5cO5FpRmvj7o6Lng0KPGdG822EIzZafRpwFVpJqEajN3nR9QcjCtCWpZ+fBU+XXjXKLPzkrEweI+VoXqfnfS2lWBNGixWN8gYnoDJhPw5UfEFW+PAvKocMIg++csFt+sjf6iwFY5KQ3BkwqcnwVO15+dJGrPjcNkKqUS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BP8+40TD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BP8+40TD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd7a75c680so333043785a.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773419386; x=1774024186; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucU+6O9NcrurkuJo/0aLMyRlc+sLJzYFKhCbCreSM2Q=;
        b=BP8+40TDesD3hM8Ok3VLj2Pd9pIou9DYMS1AtUrkZZ9N4x3LptdDLQF37EX89N+G3+
         w66zjtqq+Htg1O9tATCKBRlmJAEPPzOGysLWCnNbmEywFGH0HXOhW4P+z3YMstyODCbO
         R3t1Mv5XW69WiK7QVHRh7ebueKhUQl1cXvZRIvg5hk4Uisg3U1JkAwqHAjgjmk+L1Mad
         yk3uf2QGWBbX3F0CKqug/ZH10yapDHta1lhyVTYglEzwga29/viqH3MaAXjM5N6Ovcxp
         Z5pih1V6xMps1rRmHwbGNIc0HsN1nQMZFRLPxAJHKAVnRGu0/yXlLqOzlR3iL/xF5tt6
         MHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419386; x=1774024186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucU+6O9NcrurkuJo/0aLMyRlc+sLJzYFKhCbCreSM2Q=;
        b=JgC8b93nI2sWiv/4QOAjPBjldIJ3kcLZuKxzItsGf+OD6/Q4W7Ft9IBDdpuV9eSzHb
         6GqIv4qPA1fxcBmM1yk0NSfD6NBcS6fgkYiD//dcs2lCZlJA7THfVxGGEh+cObcdzzGM
         PASUmRcB8P1NNzrOcKW7Yuo/8YePrm64fvvX5geSyL3LBNJNVMpJa9u8oF2ozGhX+FIe
         1Y3YbCKggkvNINS/eau7EaXFjf9f5IMuliXigSuCyoxEUen2pb/R06TN6IRxk+WgHV35
         cJp1QlQ6sw9KhjkYgXXUL4cvAuGGUnAO/OMcuMA2ojmgPxPXyNRA10LlfkRs6AjmAcP5
         qaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyhdHSZEsVy4VaQUF6jYLBfJLAYmhVXkN8vNXZXAhOE7inoXa+KkfnxZnkfE3vL5QuUnfaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwguDj/t9rQsew4/oLfYMHNpCB2ruxrD+lcYE3Za9cX7D9PPTap
	lL2YB24LayqdNM9wWU1UdaE+JPFYez9CxV1tA01eq6UAkp9oK+uGnwBibUm6DACGuBk=
X-Gm-Gg: ATEYQzxoPcyoycDatymUyOVYWaM+c1kc0cXih6cP/562u7QRPWe/P5ZbegbauR2B9fW
	rOifG7Sc8g+UxjpU5oitD6tkGGr5bOcLI10/dXImawEY7FWCZ22UTw9LlfujfDQc0bFFSCaGUYV
	7PxypMyjCulvmsHPpd+UTXFFfGXbU54kvu/l/ejShrF9S1PmfG/CYoIY4MNBluUCXgzL+YholFK
	MbBOMGSxg31MLcrEQgKpf6m2HGfEFM1iQRki2+EZgTzteprDBmztZQtvYesNCuUxSNEZqLfMfIy
	H7tCo7x75X4x5KMpyW/hKyjhSEBO/DG9Io/oFXS+2aewcwRbSFqpRNO34aBbSKuq5fP0/MEJuig
	EAOLKOxp5gENlYnTsFSJf+mSKE+r+N0dLLY283tIVXL0tvp6fPn2Y9BGD97NWBxd/zT+8X9GHA0
	zE6ANj7YZU/SmKNPkB+8qpAzABuUrcW1LAE/pbhWmXkCV3/oSzPWMI63t/JPu5zGL6x0/R5xpwe
	P/jN+Yc
X-Received: by 2002:a05:620a:7114:b0:8cd:9405:9662 with SMTP id af79cd13be357-8cdaa88ceb9mr1132608485a.36.1773419385726;
        Fri, 13 Mar 2026 09:29:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100adsm633364985a.31.2026.03.13.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:29:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15OS-00000007JE0-1OZL;
	Fri, 13 Mar 2026 13:29:44 -0300
Date: Fri, 13 Mar 2026 13:29:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Fix page leaks in
 mock_viommu_{init,destroy}
Message-ID: <20260313162944.GD1704121@ziepe.ca>
References: <20260312164040.457293-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312164040.457293-3-thorsten.blum@linux.dev>

On Thu, Mar 12, 2026 at 05:40:42PM +0100, Thorsten Blum wrote:
> mock_viommu_init() allocates two pages using __get_free_pages(..., 1),
> but its error path and mock_viommu_destroy() only release the first page
> using free_page(), leaking the second page. Use free_pages() with the
> matching order instead to avoid any page leaks.
> 
> Fixes: 80478a2b450e ("iommufd/selftest: Add coverage for the new mmap interface")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/iommu/iommufd/selftest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

Jason
