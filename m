Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A83DE42B
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843022; cv=none; b=g3FLCK7cOGZlyJ6O4jzPd0qnPQK/kY23ZZ+soSB7H81zOSaDnldqJe5frAU9AhsCDAvU3xGnkLzHK/dnsskGFsudjoL64b66Eedp00DMP28oEWcgleR8+Kqp1i+Z7TEc7XO6dKcU6XSG5ub1I2wSMyiWIiucODz1y214REQ4cqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843022; c=relaxed/simple;
	bh=yXMuCez+Y1TijpAtB8Z/VDNIXHswjBW8rCfBsl6YFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezHX4NZaaMC567k4levFIdmk+y1D9cc+9faF97Jh+Q8pwQGrO7hD+hzbuGpvrFtzXuZ0ThMLP/2jrfeSUqCKPL1tLP1lQbTrMJAEv+MMrCVQHfWoj+SjpMewci/qf4hm2gBT2hcZ42vaPGsOZrKg1o33XMD+agRiNZsyzIZ/V+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OYyrwNLw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OYyrwNLw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d424af6282so254103185a.0
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775843020; x=1776447820; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ihjmb9fqpNxu98y21D0TZBc6/21aqzIUurPov8MZIpU=;
        b=OYyrwNLwewe2qoxxl0Vr3AwogWKHHB8m/cXCVfeYOeuHiw1z4WtKIKN2dXmovMbqe+
         X1+Ph2mLFGuqdDXTBNWh5akJRq6WgyOK1BOWwB3ytWu+soSkDnjKJvQarmUW5CJsk4V2
         T+5WSd80HVXCpCz7Ot6TMlEKOheiZhxzWTD02xD8ly6URj8U/m3Sif/6b3QpSrmmQbzZ
         WUl7FUPbu9Zz7KBtfg3tJXULtztlcgynIhEjjUp4loPJ8GSWTEV/UOeSer2z8Tn0hvLA
         C8P1Dqcv5xxki0VLhZNaIEQCpbn/Mlv5C+2RjZJBdh739vTXKLVcI9/QJQ4ge+BH2ndz
         NDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843020; x=1776447820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihjmb9fqpNxu98y21D0TZBc6/21aqzIUurPov8MZIpU=;
        b=pC5we+l86NumbWJ6CyDJDcsp36uqQfaIoALEl2VkyiaP5K6Ie0TINHa7RokjayBtaZ
         lJXNhF0Bc2B22yvDXfd577+zdEUqRFjJ+uTRpNY0SpdMIylVH8lJ7KCgmirRWYRdOBbl
         4UlSuPncAYpnlyM3KuMBX+NOvmcPXl5EybE9mHmfOC36bpZLFcLrgOPzwsad7Obja4Kr
         x7mnRnwNJylr6fbpnB9NR7dQ13LAG+PKBNxDg8BncjyOXR8q0W8TdF4a8isZ0Xmk2nAX
         Nt/YwTZFYWB4OHWtdQU/50Z6hrU4/B+cd4X0EHH+xoC1dd8SRd+qVvl0yAj7lDVzLTJi
         uE5Q==
X-Gm-Message-State: AOJu0Yx0I8u6i6VOf2KmM9Co+s21dV27k8cX8yXxEc19IZPBlcR7UZ0w
	6D9TU2qGIW157vcHQOLISHD0f+ZBa8+8T2WsuCwxhX0Ge+dZpskWWB3hP7Lb6Wa+0RU=
X-Gm-Gg: AeBDieuAJhozyY4RNb00zSZipfWUcWpGZ65odwVoz2R5CkE2Yk/jLLz6zyxm15YamMW
	YZNRr0gbLfwFJznQWEjeEjIubclZyX+XG5ilHn7ScKVGC+NKyGvRJxAMKkfrRnPStgazMlqTxJ9
	KsR5X3JhiG4pYFWVuY+eUo9VK+MugF8ZdC3ABSwx0JRAlbTGu5IHTo/4k7vyec83MIRgxb3eH4L
	nEL6cy0/KJChuV7zCmq8FaxYIsYjcagz3bZrvd/RbyoQia/sFu4pI9gkN1o/2pwknYmAgreNN/p
	gTQO5o1OIhucCMGzeup78FNe4SZM0ll0zyXO8FTbYPTqkigVt1SPA1dje9MTBhNOtTujBD7rzK7
	SbHNUSt+v8gO9YT/0qbQ/BLUBTirHEboAWCLY0DanhwF3R8xagMRCC+E4bldyVPE/yFFNkFXRcS
	kfZZtzPZWcDx3qrzQ85nXULHgNXdVYGuQT3yDudhe36ivqpgTePFW/Ro49nr470GwtDMaarQ==
X-Received: by 2002:ad4:4eaa:0:b0:8ab:4ab9:bb50 with SMTP id 6a1803df08f44-8ac8849104cmr54272066d6.37.1775843020363;
        Fri, 10 Apr 2026 10:43:40 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84d0c6d5sm28018806d6.49.2026.04.10.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:43:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBFtK-0000000FIXi-47vO;
	Fri, 10 Apr 2026 14:43:38 -0300
Date: Fri, 10 Apr 2026 14:43:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 0/5] dma-mapping: Fixes for memory encryption
Message-ID: <20260410174338.GC2551565@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>

On Wed, Apr 08, 2026 at 07:47:37PM +0000, Mostafa Saleh wrote:
> Introduction
> ============
> This is the third version of the fixes for direct-dma dealing with
> memory encryption and restricted-dma.
> 
> Changes in v3:
> - Instead of extending the logic by using is_swiotlb_for_alloc(),
>   follow Jason’s suggestion and propagate the state of the memory
>   allocated.
> - Remove checks out of dma_set_*() based on Jason suggestion
> - Remove documentation for now until we are close to the final
>   proposal and add it later if needed.

There are a number of Sashiko remarks that look plausible that should
be investigated:
https://sashiko.dev/#/patchset/20260408194750.2280873-1-smostafa%40google.com

> Design
> ======
> This series focuses mainly on dma-direct interaction with memory
> encryption which is the complicated case.
> At the moment memory encryption and dma-direct interacts in 2 ways:
> 1) force_dma_direct(): if true, memory will be decrypted by default
>    on allocation.
> 2) Restricted DMA: where memory is pre-decrypted and managed by
>    SWIOTLB.
> 
> With a third possible usage on the way [1] where the DMA-API allows
> an attr for decrypted memory.

This [1] was merged now

Jason
