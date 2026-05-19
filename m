Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC003ED3CD
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201717; cv=none; b=lC3TqDZVjiV+QVe2MMnUBnWNltZk2WPDuvL9bzrkBcwjJGK+EtedLquoLjHGDprGwZ/FvjuAh4U6BxBdaU6vBA2DlHISuigCwkn5jQgK3heYLLqCDRjpxVqAZI7C95WhbVYuMcCvdmDO1x+BDJ0rf5YwRKGAoIggPrrimXLAvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201717; c=relaxed/simple;
	bh=pp4L6xNEEJR55C1B8gZtr89JR1/fOu5Hhi4odc9u1ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbkA5PzMNKJ+U7S8cZP4OZCrglU7W4V5955G4THmBqwP1Ooa3Kd5dgZnbM5yPIPffTfKxamkiGQmpBZvAx529eJLetXpE+5drkpKdJE45YFmkmBaW/C2x4jqqlPWNziTM2TUpYW02pVdI96t5T1uqfY9zStQz093k7zNTMCtVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a5dNufMv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a5dNufMv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so54156816d6.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201715; x=1779806515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rTiPxjiJCNzJ9fOJ7k+wq/0Uj6CBWUn6o1yJioydV8=;
        b=a5dNufMvJ9QX0CcYNZeobWgQFgJ4C19ymNZdficcMte6DdENv4CZAUsDnsrxrN+El0
         dNJzkqAXmIHF7FzHfnF7OIALUfXlpuT4mz2dyiA2HMu6b3qFrSgCDfDxUqJPLgIILi06
         IVwuSxv1XHITVsL9V8aXPsC236vE8S+kWCR8FAKr1FJS/5FgmvGzuCWQAFWDfMeaGSQl
         mN42XcBDOtBESA38/SLt5nUtW7IchIUTQLDGkDkOkGIUZrlW5QBa48HwyTc+vACxFJQW
         GnsJKLsjhApGxfagOg5rZLmHkusMYgZIkqMW64ZBhfsRBmL81kUISE6bhXozTqwimtNu
         65mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201715; x=1779806515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rTiPxjiJCNzJ9fOJ7k+wq/0Uj6CBWUn6o1yJioydV8=;
        b=kR1pTkQGisvPiAnXIREe7pIPwbRolYdermF2SPZVwT3kb7hFBoeqSLMTumoSWHIlRN
         1bhnI17lezV0f/IRDCq7M9onzgoekrwVZLzZrtzB+p3VVOfc7cN/NIoNffZYZQEo6Ojc
         NJGT6HE7Y6Ax5TDe1EyBcasfK+cxAl02jGvzCBnw5EHJIV7IP2qOQKinaJ0JjC0dh4SS
         0nUueMPIhzQlKMuX68oax67WMGW5sxchOge94cwZ6+qGESjKc0mKmWae1OU3WDIDjJki
         Z3wKPdQ5Nmwt1fvJl3oRRTNUqXv3l+MITAFJyF/NgdEsWmJk7XgEp26K1osxO+nuQrcX
         vFQA==
X-Gm-Message-State: AOJu0YwbRGmKTN8LOsCLgKEFiC1k3MoHlXzqU6zRfNU0+2svAKVteP0f
	Ib4YTaAJ2nG8Uh6Dtl+HGAswdWSmZYbCMrUKVB0OAeLPqNLItjMesbV0RdDqH7edOFE=
X-Gm-Gg: Acq92OEmzEn+1lTpHrMIPJi5vfLsLHGuu/R6mDF09DleqmZPhxyXaW6ZspIgIWiU6u9
	CA0ZdA2WdWv+C+Igw9bWUxUh4/04ACNdaMtTJ6bUPU3zacuF6JQRWFUtIGKsiZTw9aF91TGBogM
	3oub/lFpIoj0OqEKjJ/lZlOlUMFU6LmX49fx291JgfxF3YUs4G3xIWKpWO+h6HzdyVlMW++WC4L
	mLFkGp8vk9zbUiwS64KztbqjbxlAMiPfl3DecqAndUGopSF91KStpIf6pWpPE+IGmdsRBNTO/DV
	gPOB3YxuBbrR0m+3z5aSmGfPheA+ab3NcmlRqbEuuc23O07Ve0Z/Jf5nMuWIrtRSAWdrvfAQ09i
	DRSZC48JIyz4KFE5kFtcYpkLLXPd2Nurw6BIyyRXaOFcRNmsYUwQ78FSDuAoR/3xb0dClGumJp4
	2VhtcRaxPJbn28XjD9pv0kEGPSRh3/M9PGAELVDDTUJWSxhYQO1ZI3Bo89eqqsA1jOdmIO6DlM0
	t2zsQ==
X-Received: by 2002:a0c:e08a:0:b0:89e:a170:6af2 with SMTP id 6a1803df08f44-8ca0f6b9fecmr309184076d6.41.1779201714945;
        Tue, 19 May 2026 07:41:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360b274bsm91988506d6.21.2026.05.19.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLdq-0000000F8Mf-01nK;
	Tue, 19 May 2026 11:41:54 -0300
Date: Tue, 19 May 2026 11:41:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <20260519144153.GG7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-2-praan@google.com>

On Tue, May 19, 2026 at 01:53:20PM +0000, Pranjal Shrivastava wrote:
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/pci/ats.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
