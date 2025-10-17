Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7E32C930
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710396; cv=none; b=b77ChGzEFIfT34xKrQMUw6nizfXm9uwokX3fPMsSThsrsbBVaE+oIu4Jj5GfSV8lXkTQjdwCjbN4xCrQoNXnW30OAxr8k2wBY/StiNSol7OySR9wPpxPCMjkJV8EnI3LJUyImTKHoi6UiicQkDTAgtm6eiid7tZFy76G1W5ibQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710396; c=relaxed/simple;
	bh=gwvpwm1LLRYUen6mXbmoaSqbBuwMxLRMvKkgD974mLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLOfxyqphVTyxV+uuYOHzamMEkOLJoiDvHEPViCz9hjGgH6irAMAuMTR/B9gjzGL6WjYpS6yv+FfyVpAvmgwQcMLcWnawD4m5Kv6GWfepPdky5X7qlD6IpWvbV2CDFZvFPtuhepZWx8P/iAMlsmr8C48n8dWNyQ6892ZqX/FzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F7c1ZpEw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F7c1ZpEw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c28559bb45so224335a34.0
        for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760710394; x=1761315194; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCa1krvPa6thrRIUKnGByTp8gWYsBMbtC33XqRP3axo=;
        b=F7c1ZpEwjhXzeG3DXMOd0l82Lh+6A5XJBDHqNL34WiC+MJWdJNSmt7rXXt+duzBryP
         zEyJiggc2duBmlJQK1Rno6VPR9FxxE/z5ywu/GIQbFtG9B9y9KjjpwM2RmN5hF3tJ0R5
         eLPGTKXyICDRkreTp+Av0xMCT0LvH6ZUA+IT3MzBgDc5nIP8iHJ7kuUtJURsBI6y9IIY
         vdU2ix4DbYKRyRjP+w0PjrSks+2/rv+w/aWXnRSpyruf8x7mxUGUyOhbCSrTAZr42Ldt
         kizYQa0sfbAxRHWmh53FqHEXb9W2f7ARIFR6Egfh07cmQUh01HgW5UQtrQW2axARquA9
         tQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710394; x=1761315194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCa1krvPa6thrRIUKnGByTp8gWYsBMbtC33XqRP3axo=;
        b=fPPJrXuT4EJnkjhq8i+CW1ZVGvddxbcjoInXQrDKNVPfftlKnjvGa8GkjE9rqacm4P
         cLLxIV0IMSbKEv6QMHmIuOmlToKU9mLdyUG7lR3+VfbktszTXFAz7HFDgJ+8+pkZZh3L
         neRzVd8lCNH5O3BYxYZJ1C88KhtVbbkekWwli3RKYZEomeK94DV93NhQAiX9Y+NcL9zj
         OPnI1bJkECvadDVipPWwOBryoeOBRJM4yvIT3+TtKgH2drwBFbcZ4oQ+or29lPCDq3Si
         PjFGp+w9seyhpNeK9l++dcJI6R+mw8vgHh593K2AyBfsxbs6UiKUedxsm9nup70HEybR
         wTlg==
X-Forwarded-Encrypted: i=1; AJvYcCX1iQEfXryYm7lkRfQqtRBKOcBsF4nCFNVgRCCI3sxvCU2w3wbc0g49z3g5HrY46fTFp8dTiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfbG4GUXi7QhjvkUK4lHfhii7SoHjTRl4D1P2i7jGB8Swj130a
	Q7yOq3FpddlxUkpkYkalMvlWtGnLHCv9vj7EPTsy6249aDyi2S5sQ9t0XM2nK9p8Nig=
X-Gm-Gg: ASbGnctDx4MaFRdlwvej4WtzV/s5GilbXeOrsHtblSl6KjU6+psagXX0y6maPJZlJb4
	8CplsSC4ABcXmbMLIIIpqCngillBDto3CSgjTp04BWwMkNwJx7LwBQIC9jwHKDJ60bI/UkvBj0M
	ACuWw6M/XN+3PFL1dOyL4SS+CIiW9K9SGSmq2WUCABllMKF0xuZ893iOf8aC7pVo+vzPUPPgFuY
	eiZIDvpYyx1sunT5SZegdHeTvfTRlTGX6PuS7/KbsrENXTzcaPoCyfF/hoyTodZ5XSiNFQmboUR
	cC0rEM1MbCI0yFIh2T6+tnrSyQXZu6NByyWAEE9TTd5954goTUFXrpNN3Schuvke/gscJN97dJ7
	k+4ZwZSdzAMgiOLLaU6tYTr/7uQ0tt32iOruCWbRvwX1ZrV1L/kK1zwwsl6xw
X-Google-Smtp-Source: AGHT+IFpxOdk6Ni6feiUl7Z+NLPVA5NFJEIRLr3ye6HX+wgeHy3UR1Agbev9kB5TSYS6S/8PSXPR5Q==
X-Received: by 2002:a05:6830:610b:b0:79e:5341:392c with SMTP id 46e09a7af769-7c27ca2832amr1811887a34.7.1760710393815;
        Fri, 17 Oct 2025 07:13:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90687e8sm7323680a34.15.2025.10.17.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:13:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9lCi-00000001JNh-0d7r;
	Fri, 17 Oct 2025 11:13:12 -0300
Date: Fri, 17 Oct 2025 11:13:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251017141312.GP3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
 <aPI-8YfqC83QlltH@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPI-8YfqC83QlltH@google.com>

On Fri, Oct 17, 2025 at 01:04:49PM +0000, Mostafa Saleh wrote:

> Is simple enough and verbose and can distinguished from test failures,
> it will look like:
> [    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!
                   ^^^^^

The test "passed" though, and since we never expect this failure it
seems wrong to make it pass.

I think there is no point in distinguishing "infrastructure" from
anything else. Either the test runs to completion and does everything,
or it fails.

The use of skip is for things where we probe something and detect we
can't run the test. Like maybe you have a test that relies on
PAGE_SIZE=4096, or CONFIG_XX so skip other systems.

While, "I hit an OOM so I skip the test" seems wrong to me. Maybe the
OOM was caused by the "unit under test" leaking memory??

Jason
