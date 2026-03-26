Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C339C011
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527208; cv=none; b=aK/jgHu5NnWu9lnXzG5E17D5WBp7TNreRgOLpbCE2Mp4j7doEkM35zpV+0JuJcfs8GZ84sqiM+pUiXHk2yklfae9KoeR+O98HdQGrxdpUpKm92EFRnQ4guSAziKxv90UNwVNsUY6b2HTuFNB/VjJN41gGOE6Ek5kSRHt6xAvFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527208; c=relaxed/simple;
	bh=FwSZ/7OJrnCav6mHeiPYjw7vKNEccgVJalfMDtXgtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szxjWR3NDYmSNSSvbouya1u05LezSK7rggN37lyk+ue6RA1TfLd6aTZbY1wJcUAVrk1a2oqFubW4ha/gcgFNRJxnmCG795JAOBCDCkgEKbVTwTGoMoaCmXdUKbLpL7iqraYnwIjAQqaysRa37Yfc5lAW6ECr/6wt9BKjCfjLjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXQkhuu9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXQkhuu9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5094e1d17d3so9099611cf.3
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774527206; x=1775132006; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6i0e8voY0W3VFEIjqKbZCWdQ8TQ9CEZiQ4kRraE3UfE=;
        b=iXQkhuu9Z/sLV2VDjPzmxb8G8FjvuGyKy9LBmBtBQMbbvwI/ftmlW5Bt0I2MmbOgid
         Nqyct4Xg02lAinkLYN71CoHsi0f5p3CXfulwVzeRpUyBOwqkv+TQ2WOk6F7mRVsCoXDe
         aIpn051GBGoMi0+aXz+/G2h0kC2rF6qONF1fcgbjWF3f8tFZWdVGVAeUJe0FzS37vB0t
         j8V0I6xrYE0jr4y6d36xlkTVB42TfJbvfQ6Helrk2jmbRcyfSUWW/1JQIDzFFvmNjh76
         gFKIlhAot7/wpYaGOrwl4bCUY9INrSTnISRI4FbpJli3/ALTe/ku+CcTCIBLeluPuRig
         JAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527206; x=1775132006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6i0e8voY0W3VFEIjqKbZCWdQ8TQ9CEZiQ4kRraE3UfE=;
        b=RKHDjtPkGf0pAV9QKuEgFjI2LM5PT6P1WdKodPMfCf6Pjyng9U7HgbfF1+nkzf/V5/
         Kz8tHEnQ7pBj3NHD/+dnFHOFtaH5nqTKc7NYfyx1bNOnrgwtoDUwqvii4WFkR1LyBCsO
         lL7st0xco1X9Vai+eWI5uz1VItAEzBbmLiGl81+dmJNmLxFUCK00wmFuZEpL3mOIT9QS
         gv0fJ0m8wEbXYM5MoS56Ieuhd/qu2V+KSOyTP86ddV3Us1Vym4VM+Vwy4/TUoV6vTBrx
         8ZcGTnyYNOEaGIpklG2LwvzAFrPp27vltOJzksXOkJhHDfFZ0C0PiX6weEC+lhSGasb3
         lBmQ==
X-Gm-Message-State: AOJu0YyngaHdDwPPQJ2kLoLHtXaINqWKrxE94wwYTEszbZs4aOMhfKq2
	J6fXqtvKCV+BaG3byrsETQMzDVk3EjcSDskk6L3CXzJjEnmndc3yqj/q3bUZpOd31DM=
X-Gm-Gg: ATEYQzwWs29Qzr92HtjrYW0qkgPIGdg7VoyYz/wxrYYbDR9WpBO56vR3cg41bLaPVtC
	yo9y2lHX/dqwsEVQv0dwefr5PzQail2RRPozBw6wH5EDAKbqvmbMlxqPQ12AUCCxk1x2ARlF7rd
	f4AteYaeE6tXJpt3UQMkk4Noz41hNAzQI6zNUBBvvzyB4z1wDKkqkXeHwQERCNuAoKS/ltEL6NC
	xTAJU8rgPr0Wo1Sei0kMe1Sg9sxCz7Wu8j2gYtfYM4skBm9aVj1BFNQHR7rCdrubslDcRcv9YDa
	YCM3z4CqHRchit8XcWHuU6A/ntxyXYZpFk0jsL9RdJ0VrXzCSoahHMV8EzKo9ePjUYspBNGqDlG
	vZlKB+CQJBQ2DTNOP3altI0IkQF1xqpBIraQ4kF7OPOtiHzaVYsEGyzrNhUdxcgdTxemx3ycB+C
	bN8aebA01+TwcfOI8ai/alM1QeSPWUarQDP98iqA+JuBHFBAWv/5+rq51ZBQbl8MEviTrEo0wSu
	F4Mr4PP
X-Received: by 2002:a05:622a:1988:b0:50b:22c2:d7ec with SMTP id d75a77b69052e-50b80e64fa3mr85474361cf.59.1774527206440;
        Thu, 26 Mar 2026 05:13:26 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9215a4e1sm23320911cf.10.2026.03.26.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:13:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5jaX-00000000moc-15LR;
	Thu, 26 Mar 2026 09:13:25 -0300
Date: Thu, 26 Mar 2026 09:13:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Ankit Soni <Ankit.Soni@amd.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd/selftest: Add missing driver_ops for AMDV1 mock
 domain
Message-ID: <20260326121325.GI8437@ziepe.ca>
References: <20260325094615.2420522-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325094615.2420522-1-praan@google.com>

On Wed, Mar 25, 2026 at 09:46:15AM +0000, Pranjal Shrivastava wrote:
> syzbot found that allocating a mock domain with AMDV1 format could
> cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
> providing the required driver_ops.
> 
> Initialize a spinlock (top_lock) and dummy callbacks in the mock
> driver to satisfy the generic PT requirements.

I'm inclined to delete the AMDv1 option entirely, I was thinking about
extending the sefltest to use it but I don't have time..

Syzkaller is hitting this because it found it can use a parameter that
the selftest never uses.

Jason
