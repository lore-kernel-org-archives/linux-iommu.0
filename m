Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03C2773E4
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723994; cv=none; b=H880qFsHkGKfCnEI/97zoiLY+NOEUP/p5aW32MjbkWYBVLL0Gn5HYd+3SszDL+F1xORM+qP4eNVmuvNxxzbHu2KOU4khOy8sihDmEzG34RikzcBxsjU9XGQ9I48ui3cnocdPqYi2eccZ3aGnzw9ptSG1kvk8ca+hN0q2+71FMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723994; c=relaxed/simple;
	bh=ZzH+32i9zF1DJuIb4vfgQHzdhY7TJS9MME3F6gVefh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgrZMMmam8wbV0oMlEFzG995YngP1am/uGXuz+Bsz+FDLf9FIR8TfXeyqTtrSH5YrY50u0jj3Yi45jeNAB604Iq0Ki2th6JfFGpb2Ao4KBRRkGDcNZes9Rnx5c3+YHg9sytMGfH1i91jt5w2bpWLrHC9cb4ANYXDBPX3B0zl/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJjd98Sg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJjd98Sg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47101c27c9cso6625e9.0
        for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760723991; x=1761328791; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cm/Xe7cjynibkOQ6Px4QnhuGS+eC9ZhGU5GEHOrppAM=;
        b=BJjd98SgAc5qhSlZF70P4iGs8gX6VJFEwazZyDGrJsuzGB5WWM/+VLRaHdP9BpfYiP
         5INC9rMSgBJDBGbAthn4YsnaoNxO336pUNBG/PfUdXdyHHhNtA32jfUc2EfuV6P+3ZU8
         9UZKNxhvRPVsJGlJqm9fDIv6tZ5fnb2TRah8c5IzQR45Okq4HBxS4vdJK+8q2WUl1+4u
         kQ4cEcQqQFzMNE57zNzUZDj0df8ZGF6U0Ifwwu3P1eGhsH/CMtXqOeTpdOQ4Tq0Jw6XE
         m3niFxiz5c57E+TE0T+D4HkTCBySadQebdBukauWONeP7bltS11ZS/ipJrdqyT6H2uvp
         2QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723991; x=1761328791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm/Xe7cjynibkOQ6Px4QnhuGS+eC9ZhGU5GEHOrppAM=;
        b=Mie1D5C73JMRetZ2m/8P4sCVkyC44fJi2hLMrbPqq8OWD3vMMgciz5Ku3ARfnZ38Bj
         0G3INoj7e5KQ2hC8bQr4AasNFu2bnR6cmZKD16rvc/Wj9jpKkaGT51tN8IU+rffhHDGe
         yrMQ1m0BPElyA8/zOAqTcTxQS3o4hx9PbkxfurJ5qibYwh4U7wII+JNDJhiwuGBp+Wav
         K4cAuw364zAydY1bGbK98+7rZM+oW9wd5z+UQwvKNjGThU0JbdEn2g1AFq+n3nNn/k7z
         sZA6Lywn1/u7q6ig54MDnm4oCMmmzXlShd+smzM/1N0Aut4waauzPddoxDM1SChCeogR
         nihA==
X-Forwarded-Encrypted: i=1; AJvYcCUiY0WJrUbrKfUr/SzQfyKnAa2q2ik9Tseo440shEpfzE9D3GVJgMdRV7V8V9MarhCkaWAsVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygxx8o2eniOE5ogQjlXJ/2Bc6wKe4nTWsL0r0/570WSJtnPgnn
	cq1FbtsIL3kPHFeV+667e8s+1nlG1jfNG6Y1pYLVMxAtQATjHdyq2ywWxBbpWnGIo7V0on/Ie9G
	p0qddGw==
X-Gm-Gg: ASbGncvx0d8y5f1bWlsgU6kNEfU332BSAGikAPUf2z8pHl6CV1nqUOuQvHCFgYdaAY9
	d9SlfRJrxSwpyuPJcVtH8qPPnaSWehlRPyCbD4vP5eh7lVPNdBbRB4xxuphLhnvLlWoNIlRRcls
	+pGwQvxx/SBjtD7uEq5kZMIE3Z11tk93fEYuVtymrpiuKR0E+eGJm85VDtlqPN9tlEG9KwdwVEm
	Zr+TgUBMlF1JSW7VR6HIvSxdG4JW35UYbPCH0OtlRalPJYUb2tUj9z6/ftJkTAy5vmFb54sqO91
	h+VNlObyVpmdPg8FGpoFlCkQtpKAJ8+IMGMc1hOkBp0kMxoaeAezoZOaKRd/XEbzZTQ/E4oxpYh
	s7Ef/YYDiik8ufRE8zeNno8acdUtuqog9S8PXLA3Zh/t/jiL7tMrye4cBXAqo1ZU/r8ETvip23f
	AMNRDRTk1xNiRg8ITZ54s90+nO9mITsJIpXL3NSA==
X-Google-Smtp-Source: AGHT+IE8/FXhVVJrozgI0Wh8A6TqTcaQumti7JajkJKRLGU4JC0DDWkhAHhYmkS9bQHIRIjtvr95Fw==
X-Received: by 2002:a05:600c:4797:b0:46e:1b09:1cda with SMTP id 5b1f17b1804b1-470ff2e9434mr4517485e9.5.1760723990610;
        Fri, 17 Oct 2025 10:59:50 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm420433f8f.35.2025.10.17.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:59:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:59:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aPKEEuCYbbJbN9Cr@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
 <aPI-8YfqC83QlltH@google.com>
 <20251017141312.GP3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141312.GP3938986@ziepe.ca>

On Fri, Oct 17, 2025 at 11:13:12AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 01:04:49PM +0000, Mostafa Saleh wrote:
> 
> > Is simple enough and verbose and can distinguished from test failures,
> > it will look like:
> > [    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!
>                    ^^^^^
> 
> The test "passed" though, and since we never expect this failure it
> seems wrong to make it pass.
> 
> I think there is no point in distinguishing "infrastructure" from
> anything else. Either the test runs to completion and does everything,
> or it fails.
> 
> The use of skip is for things where we probe something and detect we
> can't run the test. Like maybe you have a test that relies on
> PAGE_SIZE=4096, or CONFIG_XX so skip other systems.
> 
> While, "I hit an OOM so I skip the test" seems wrong to me. Maybe the
> OOM was caused by the "unit under test" leaking memory??

I see, both are fine with me, it seems the kunit maintainer is more
inclined twords the failure approach [1].

So, I can keep the test failing, is it OK Robin?

[1] https://lore.kernel.org/all/CABVgOS=NfRcXYzJVMMKqeXP8SyTewffwb7vdGN1D8esO2f0KOA@mail.gmail.com/

Thanks,
Mostafa

> 
> Jason
