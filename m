Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709673C5529
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083762; cv=none; b=ZV8M1RDEBFLEiF0pxtWgYWIXdwVScp0z8HbcoTsO5tQcqHsn+EHHxLprPmQ7RQH1pjOiAef5wDiYkk9k6+cHu5HT4wKFPG8CvOmhgHGSixN0zGJDzyL+CIbB2EkWBq51u+tgVtSlFVfpH+JWbM7X9/FCUmbSZ7EhkYtu9aPywww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083762; c=relaxed/simple;
	bh=fp+7EXcZwqQp/8IuIliOE61yrp537yagktKvVrhPsfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4zGtAdesQB9VdK2SVhPZLfe7s3PNQeIHQ5AwYESg5iGReDufSQFgpxyl5wXTp473bs/7CVu44qn9DvdqSPYTCJgbVK4AtSvs5nvVtHVvP8n3PshOz4BUzKbBuG155GtENxNb9FbqBICwrbIPAz55C7PSBIbPagGJ+OK7aHU9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T4N6qbbS; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T4N6qbbS"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8aca0469204so15112426d6.2
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776083760; x=1776688560; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FEeCHDd/CcKmcXa27s5lHb+0eRsgAlvaV16ik8ah84U=;
        b=T4N6qbbST9vFJaEv/jeoA37xm5iK9eQWsL9NwdvNBvg+pPmCJO8fmquP5P9/gidbru
         scrBNGwQ7l+DSdGwarh1d4ODSDf4cg90VkrmgBdaKxH3dDyc+qcicImEtE0fdtzJ8/36
         9OvdeVuh98oOeDKZ6BXQeFNBBeTLSkPhphBT0AcVOJWBDCl/9STwI1e0GQQPmkso/wq8
         lqTubteu1T9YT85xR8NsTPfq3X7BSOlpSub+LyMfpsYFLN3+lsLiutTHFwSqTahLoTKC
         kcRfaa9CMmYY4dSlpxOqrLUNDDDs8A8qNij9uKwaCWq8PIPACSXszVpNx98r44K+mgBJ
         UU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083760; x=1776688560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEeCHDd/CcKmcXa27s5lHb+0eRsgAlvaV16ik8ah84U=;
        b=Qzn9gDhurCNsRnkavt2we/a8CoOJlatGON8+QUKuBoCNyJFh5IFI1WFz8xQU1l5NIZ
         t4xiqY50skqkjICvq6ZdgBkhu0C+QooQYCW9QJ58Bk6KDRuQDrbG/ZbmMDJIyn64kqDg
         hfaUK7y5Bc3tnbt/QLvnhlFDmESCUnw3LD9UMbrjM5fSKjnTFXLTz+Vw0uKY6ta/ChSD
         OLn8wTqXjzXjKUR+gkrKgbppb6T1Em5icflQVNFXGL0sXr32t+kff8l2t+Mj6jBvgMnD
         QAyMCv9sqh5lTPN/XsbRcDMOtGMy37p+9Aj4Alr27Xy0kkMqs4zabI0JtQ/WHsKGPtVo
         QeHA==
X-Forwarded-Encrypted: i=1; AFNElJ+nNhFU/9G+586nvKQijuDKkOvrGPi6hiLDGbgyz35t11XN5mb/dRg7InZxn/HC4Z5PUko2yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9R0pkVnkh0XA8v1soGbW/pYYqI7xFpY11iWDpPuQ0/I+UGawu
	I+ODoLtDteB18yXtx6jWRKDeN3Bg6iulZI+O0Wla3xU7F3dFa76hIlAN34AE/piBIjs=
X-Gm-Gg: AeBDiesUYXsLJ4jecI9EBifkCySjlCz8pMhnnDIqztbjaIyGqaAIdQpwUTcbEkSTzpQ
	gXYGZODTe2I/Z8wAqo72FaVInyXfNRCbhnaXadSlx3fhvAjTp6/DV5y1gmjKFPkNUU68QQq1Dig
	2/vVyj5QorZUojsXt1cOi3OcvuUDR6sARpc4A17so7f+UhGtmM7tgDEe9tTXJyB1U2MPLu4bEJZ
	jbznQMH5Z0zMFeVocxjh7BP8U6OfqltAbzWkGb0vSksWi9xTy7eG4KujN7OfBNntmvSUZpUG4sQ
	erclhSk30eFRiDvmC3SJcUShHTIh3lhe6B4/C+IKYT5IzyRy9O2Q+zg7kEbGVkirmTNSCNupfPs
	yGDIxGzftPEoHj43eyZVlfIp2l9SWyHEx6/+6BIhqam1Cd02EFV5kkzFpf9oUbhiu+A2wqJMDoV
	0SStFS7Kb/T+nqhTpp0/+4G/9IB/WkYSbSI0d/G0JvqoJPn/xO4VI/Wq6HOV+z66tuV9An/FGJf
	LcS5Q==
X-Received: by 2002:a05:6214:8092:b0:89c:eabb:f58d with SMTP id 6a1803df08f44-8ac862b6426mr205059646d6.47.1776083760376;
        Mon, 13 Apr 2026 05:36:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c9c37csm92724086d6.36.2026.04.13.05.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:35:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCGWF-00000005Aek-0j6d;
	Mon, 13 Apr 2026 09:35:59 -0300
Date: Mon, 13 Apr 2026 09:35:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <20260413123559.GI3694781@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca>
 <acrgYotBExJhEJkK@google.com>
 <yq5aeckjbdrt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aeckjbdrt.fsf@kernel.org>

On Mon, Apr 13, 2026 at 11:30:38AM +0530, Aneesh Kumar K.V wrote:

> I know there is a v3, but I’m commenting here to check whether we really
> need to do this now. In my opinion, we can keep this much simpler by
> treating all swiotlb allocations as decrypted allocations. 

That's not going to work when we get to supporting T=1 devices that
may still want SWIOTLB for encrypted memory.

Jason
