Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D01F8AC9
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493702; cv=none; b=uD4n9KCzpSzNLv7+zJY5WzuH7hbw1aOBXnQTpD1w6W9AUfLqOOKi3+Xaz5KbrekU/kwf+4cxpA323B2CbZvFddEaWeE8XLFeXZSAQc7LhJXmmv1F+RO23f2MaqQMgJsYF1mBkgVpe+sHPilqNF0vNSTtcvw4j6y+eLrS0urKLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493702; c=relaxed/simple;
	bh=uluMxOufkVTyf9lJfEzbWc5BVYqo/uuD+oDGx4hL5jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVqaFV7wnLCrpifkA4dziS9P5I48reFCeaxBll0k6YrlUDoeaLJlRRxhH64n5Hlt/u7qhhWy3qS9vlH2zFFM0xhh0gIgdNqP1K2G6+jqc7KEbzRWe9lTpyUU280KH6VM90G+XKaYujZWv3LpZUwmiUYcwhkAGi33/+nIDVqDehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rf+bgIgu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rf+bgIgu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678cd314b6so59037601cf.3
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737493700; x=1738098500; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uluMxOufkVTyf9lJfEzbWc5BVYqo/uuD+oDGx4hL5jk=;
        b=Rf+bgIguBa8oXrOceSJYbR6rmXz49/LFbNh6OlWIhg9nQyJJcZRxRhsfpD1vz5S5z1
         3IuRvpFuTjPmpHqhWbMt78L5RGb961wBfEhg6iZmZLIow4HnwnV3C5Ba+pevXb/FK2EE
         lHCbE2tS5iWDkMFXzhQy0UDj/1zPQjyBvsKresRGKYssemjKSOz3sjThLtc0ayJixrRC
         5Kis7H+TY8hi4Pj8R/gs+1osTEwp+dE6679qBiEkczccID0W3KU0qVp6Ao0WzJTHvJOW
         BjOPvPFWLbcqpJW/ntJ5EkZGngH4G4Us8zXR1c5Z2qLlEv5ZLxbFbqszt3A+DMh4F7WV
         vpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737493700; x=1738098500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uluMxOufkVTyf9lJfEzbWc5BVYqo/uuD+oDGx4hL5jk=;
        b=kZddmWD1AlUA5ZshovsAawpM4sYVOmNF/PsO8cVMou9EThea1MmV3bAF4gaSYAxaG8
         GEAanndldow8fbfFJ/4gBUeAI8zIIkorG9cPBakGsgjQaafXkWhmWitWPbv2QzlRE0JY
         tJqVel0YogqUswMPmVo1HEZwmTYcRMFaRizB8aVxGBU5I6IubwQzft2267kSjGfTlfW9
         xFEEqsMuxez0Ui3o/2KwPMBkIXxHGAFUuJb0HrAoxzWvyuWqn6FYQDeBq/nzFKIsfHmo
         u2Syk7cLmwuuqcLBqT+IhQnjIwcbyWwfE21Alz2bDcwFBbzKwY9vbptGGbl3ogtsvgyW
         UXkg==
X-Forwarded-Encrypted: i=1; AJvYcCVCoH7mFSGpbdO0ywbME6pTcHfNib3LGc8WnnZYKdVwhYKXvIAW4wY47iAPV5pPGevDjQOgng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMNubUOrFPo4g/3WG4aButspdlMpy5zROjjWbMAFJ+Hnr2viNw
	U/Eg6wGWR6B1CLspbDSegN+kl09S0DlqDyF1vkJhWuoTnUlQPd9ryKWJwRsgXZk=
X-Gm-Gg: ASbGnct0hQDH8y49LxdCMPSKbqeoskvx0S5l9hsc9sn5IaWRgK3WOoeK+cYmGP3sdqK
	Gn3GtVhrNolxvF/KCcUVgnCt9/ZzIhgGgZP81SODPcO+pZxV02Xlljfk0QUfBtHfibmhz/BE3kf
	xswFiopN28/dWTUCbDQLZP5PQLtwBSdnaGF02hrvsr7ExmtPL0e5l3jNxxh2dCbSD9cgEem2TCK
	coSb7cNjrS6N6SVrWXjKsZO8pRkmJEOZO59v276fJaG
X-Google-Smtp-Source: AGHT+IG5YP9eNd9K/tULkbOh+15rO6VP7dx9Kko33NgE7yfMs5pyEbUR5KFZXToPZd7tel5NdyHGag==
X-Received: by 2002:a05:622a:20d:b0:467:5910:255f with SMTP id d75a77b69052e-46e12b75c5cmr309673581cf.30.1737493699799;
        Tue, 21 Jan 2025 13:08:19 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1043468esm56871721cf.75.2025.01.21.13.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:08:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1taLTu-00000003kDx-1Y7y;
	Tue, 21 Jan 2025 17:08:18 -0400
Date: Tue, 21 Jan 2025 17:08:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/msm: Temporarily disable stall-on-fault after
 a page fault
Message-ID: <20250121210818.GS674319@ziepe.ca>
References: <20250120-msm-gpu-fault-fixes-next-v2-0-d636c4027042@gmail.com>
 <20250120-msm-gpu-fault-fixes-next-v2-3-d636c4027042@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120-msm-gpu-fault-fixes-next-v2-3-d636c4027042@gmail.com>

On Mon, Jan 20, 2025 at 10:46:47AM -0500, Connor Abbott wrote:

> To work around these problem, disable stall-on-fault as soon as we get a
> page fault until a cooldown period after pagefaults stop. This allows
> the GMU some guaranteed time to continue working. We also keep it
> disabled so long as the current devcoredump hasn't been deleted, because
> in that case we likely won't capture another one if there's a fault.

I don't have any particular interest here, but I'm surprised to read
this paragraph, maybe you could explain this some more in the commit
message?

I would think terminating transactions and returning a failure to the
GPU would be fatal to the GPU operating model when the entire point of
stall and fault handling is to make OS paging transparent to the GPU??

What happens on the GPU side when it gets this spurious failure?

Jason
