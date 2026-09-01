Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63761372ED0
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252702; cv=none; b=KRig0de8Hirc3SfnmDEGcDzII9u/QcUQgQ6gTIIJf9yAlGJ89RfOoSnC7fcvY+OKhEhaRekS8qfLmJMAMbiMD6EBLebZFcqSZ/12Sb1iZiHEIg5Xauon7fG88buR01Yb3Dooi/fkyWQEsIXYq+M9yVfDKKy2E+BRbNswFzQ+/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252702; c=relaxed/simple;
	bh=1dljEFWF149FOJ57AsRvt4hi6edE+9V4/CmIdnlyfUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgkHrKPjv2vN/O5/ouR/kYLVZC6DdE9oCSo1+gR+yMJSKs+oL6DyapPk30ft8Y0LBChNDXwrjEXALl2jjznj444fNTR393KpI2c45SC2qRpBWfv8ur1XbXLSsoK02/vDnSL8Uvevbz2QsvsqhFK4ISGTBRhLyjtObjMg7GB+UX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQh+ad2e; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQh+ad2e"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5f91ae397so6620a12.1
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788252699; x=1788857499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=538Bban5iOQuAF/2OvLsm8VbhbA6yCMNVAJAEEAo3ew=;
        b=cQh+ad2eO+P6tefDp/onxUUU52rYDtE7egWBNJnhM367vvTaeivUDCLCPSOajx2ih5
         rqprbnoXeSe5NcnWvDWHDCwE9/Mez4eoXdHvTFbT1vFpVowH4c323sh6Lo6mVUh4YRql
         a7zQoURPpUgGEp8wt0Tz5KUr5cgdbQc+dvtCrk9qzCZjEUe+KmsBsw6VIPF74Ffa+0wJ
         L9FOVVmFHXhsELyyoLnWa1sH2s5mAKruvTwQ781o5ezSeKXG+9mfUq5He+D1xf/28PNa
         Ae+8OZLzvXwAgEfCes8N2feu6yJqH+FL/SpcTQMEGv1vRorCbQqZsDYW75B+Xb049nLF
         lxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252699; x=1788857499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=538Bban5iOQuAF/2OvLsm8VbhbA6yCMNVAJAEEAo3ew=;
        b=eRJHGi/Ct4sNjVl2CdBbqrechhwheQSP6QDv7WgKOoEPjSe58jONCmfGiMkejjDt++
         YmGwkRIrltHEf/S1pp92WQDgF68ePnyHmpAra8U3UHOtHfcha/NVIhiA6GJCNEiIKR++
         eU8JPrEJevDlodjSuFn2pAkYmwzTg6h9F/4GGjq6QbyE8JnrX7cn1A97TzAyZov1bmAc
         AK5hCHuElJDnbS1recEF87YOJq+BK74OrABhA3Bg8TYJWOLu7TvFeN0MNkTuTWwtUJJQ
         0moeb2hfWZTBb6gs/XLQ2bp2rFYEwMH3UI+MoTdB/YDUWhClV9WcBttJ/9LSpiwCQZmw
         3fFA==
X-Forwarded-Encrypted: i=1; AKwUvByXK4vXX2ocwfL3oSCQmJfybI7UQU1hR5z3aWMz6To37giqmLOkh2/NMzB5hP6ZWzbR1mb0pQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lXOYRdiHmaybAxIzDBp2vrohGY0vJQqulQJnJbq97lKtc6KppI
	ZzIjnbtc3fYWQKadTpGk1/aJMGKZL+wbLqPGdK+IWUgPIG5xhnv+Nt2sqNPyG4ammQ==
X-Gm-Gg: AYBFou2fOnVumS0iuz3+clws5OAP3dBcE8KsDihs/Zfk7hIAxh6BZB5WrYiEiEdwxPw
	7l/5XMbscTxrnx1Xz2uiFQx9RbfOp2WDEKtLx2+MH/NJLT4K/jhMmlOrgHXbMY0Bemp1He1AITw
	8IEWRzm5LdGga40UCe8tiWmKOpC7J7qldQURtVN0nhGqHIfbMjZG5IC/M42LX3m4DpAe4QVLFXs
	oVbSgrEjrp19U9r6OkRS3wQ5wikO9tUTMLuroyyh1mbmQu9LAYTZcRYfLbImJPmcM6YjtJuGAqK
	e5kbDKCNfGG1tV+rCp6xPMRSMV74ApdLQIe+peJ27aTyRHx9U5NItzm9sTu2TlJP0F7TyuRJ0Ov
	6/ml7zAaFaP/AHJdFXNCZliSVczg7N5hNeFjMP58tK5PTUX9kfrEf36Dx5GXSqCuo5uXlp812bI
	0N3v9jCJSLpo8zOk++xDrqhUbmcII3uwuIyzJfMP3CPjUTKMjOzeIIM2FJOizqXQ8SGjQCy6iP0
	7PxxySZNRRqXb514jfA72RqwitFkUV9jpk5HF6U
X-Received: by 2002:aa7:dcca:0:b0:6a0:6677:37f9 with SMTP id 4fb4d7f45d1cf-6a66d5c18e0mr19763a12.1.1788252698938;
        Tue, 01 Sep 2026 01:51:38 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a66ccdc50bsm466634a12.11.2026.09.01.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:51:38 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:51:34 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, praan@google.com
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3-test: Add missing error checks for
 inv array
Message-ID: <apaSFtf2xe-qbKbg@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-6-smostafa@google.com>
 <178792724271.3808739.15472225478426952013.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178792724271.3808739.15472225478426952013.b4-review@b4>

On Fri, Aug 28, 2026 at 11:27:22AM -0300, Jason Gunthorpe wrote:
> > arm_smmu_invs_merge() and arm_smmu_invs_alloc() can return NULL or
> > errors which are checked by the driver but not the test.
> > 
> > Add KUNIT_ASSERT_NOT_ERR_OR_NULL() after calling them to fail the
> > test instead of accessing NULL or ERR pointers.
> 
> I've generally had the opinion that if kunit tests hit bugs I don't
> actually care what happens next so long as the bug is evident.. Many
> tests can't clean up when they get longjump'd out like this too.

I tend to agree as that's how I use kunit also, but I'd be extra
careful around crashing the kernel from kunit as it can be triggered
from userspace.

Thanks,
Mostafa

> 
> So, IDK, it is fine but I also think this is in a category that maybe
> sashiko prompts should address instead somehow.
> 
> -- 
> Jason
