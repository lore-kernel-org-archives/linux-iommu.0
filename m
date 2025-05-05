Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39C25F7B1
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458179; cv=none; b=rGAEGuW8yVUGPSG1TkNjEFl/umnsdOv4KfHS7jKfLb41fY4dfqO53H1NriUboXY0qn5210tcReBTcBxLNsqhj2GZ0a/TTWSTpsZ+CGK3X5RUGc2HduQpxfeBs6ALYDoqPjo/zTnHRBYQ+Yugzkj6oReunI1LYny7pEnJ7yUkNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458179; c=relaxed/simple;
	bh=+5kKukBGqpf4X38xHUoQvfbz0A8mjmfzNZIHP9Y29F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUyx/cvcWT9FRKs4+OXwwhxp6Yl74iu5aXiU4dTgNg1G6RZ+3gOVUk6abB29sUi7fcYbXWW4490G5FtFwTnQJKBZHrNM9LPj5sHaKYRoWdzUW+DH2tDgCmHFYQRlaJi/QOA9pSJdrgFy82PyaMEWx61EkkF92WCFsaTZN3hn/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKMRC2MH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKMRC2MH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso222695ad.1
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746458176; x=1747062976; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBbovheYBlqHwmciu4NntN242/gbpCysIn7uegIhCyk=;
        b=xKMRC2MH3cIaNECcro6NhKvnALs3a42vWUc5a7WSfRG+b9eTEsheX697JdXg3ybPJQ
         tuLGCjBRAhSSyi63W8QNtw38hqsTX/n5hzthYPjoc40In+ib3TOXWh2WRWYEHriK4Yfr
         rY7H8m3TwrVgGECqvlx+/yNeIscNFJ9HnSHV64ZEw7Jw2SBqYt3QLibCsZoE5kJOg5Bu
         XDGGa5TXy2uvN9gSq9KnmUtB5RJF30j5osiIjbCeHYIxaDL3v+FYWPQWXF7nxW46TNvG
         qFVGMabcMrXSIYrXLTnn0TM3l9ubmbBadjyocx9afHk6qfmVJSFAcuu1RA2xnqeZKtu5
         5wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458176; x=1747062976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBbovheYBlqHwmciu4NntN242/gbpCysIn7uegIhCyk=;
        b=JSpB024RzXgZT3XzjVwOW8Nrhwwy5bEdQs8BtNfOieXI7MwI+t28jzM9vb4fmNA3Js
         1cAxxYiy1sBi1mwTAGJ8somCGDxec54YIH+G57UIoTPH4vMhnYSx3+B7FcftYdwShB42
         5tysFC8H9nwT9JiYYVUtB/Hxz4qHn58oY8F7V4ZV++o2BWtUCtZVrXpekZg+MPG0k3BD
         XH50xQ0l56H/iInRGojshiWUkqUsxTBsJDcemUmwmZyj0myg4RLFDe6/kTXtjHhpLjYO
         yR/Du7NTj2CsCFyw3MZc35lf9AIGKPRKt/cBMs6hsZSL9XFiti8OinZxxdiu4UAiNqGx
         v0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8D6GrVcJP6Cj/kPybp7KYVQiZiQriv2DklcinMI6yxUmmIwlksDIdFF5Rm/zThLKhVCqgXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynDP97049aPuuJwaN4Dboc5SOzS4lauPgTD37ZtCfKz3kEZZxa
	LcynwntBOgYq0EzToEevuysjB7jWIUHO9mAc0Y8I6APqz0hYGL6P5Xdw6DVtgA==
X-Gm-Gg: ASbGnctsyqO7/MPdrvRL6eBm8ile7C+O0QVqvLQGZNJWF3HpJ1GyLrmAxMBoXuXwlbU
	UJHZqRRnCMcLdse9Tuiq4WF9bOsB2BKL66jV/K63cuwWxJ5vwJxVHvsZmX5agkG6crja/sazHbU
	8hmtZjpIPP22TBI7b1I+X45lBSqjs0eFxX+HshM3Fq/9LCT5AF8c2xt8wdZOQIYFhimzyDANvgh
	Q1PWGI+sp/vRaPiIlYsRuJsksEJe4u9s+k3OG20sKjoM2CQ4a/cXNwg3VYm2EGE7AYEua4pfaaO
	61Y8j5zr9HJTjQ2S8vJvcqQewPyCNpi/75XIXvbf6xVRxks9s+GEfqhTem3sF+yC2Sx2EqAy
X-Google-Smtp-Source: AGHT+IGaqtb+G3jL+Zea8gpmUgwvAJFhlRGxM8eRwZWjVOmXQxaQGxm9d+tb5Gb4B7eYvQJsn/4ACQ==
X-Received: by 2002:a17:903:1108:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-22e3171e1a2mr130515ad.16.1746458175568;
        Mon, 05 May 2025 08:16:15 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902109dsm7141761b3a.106.2025.05.05.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:16:15 -0700 (PDT)
Date: Mon, 5 May 2025 15:16:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 04/10] iommu/arm-smmu-v3: Cache and restore MSI
 config
Message-ID: <aBjWN8GUzL_GmCle@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-5-praan@google.com>
 <aBUgRyT/nno2MNHk@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBUgRyT/nno2MNHk@Asurada-Nvidia>

On Fri, May 02, 2025 at 12:43:03PM -0700, Nicolin Chen wrote:
> On Fri, Apr 18, 2025 at 11:34:03PM +0000, Pranjal Shrivastava wrote:
> > +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> > +	if (desc) {
> > +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> > +		arm_smmu_write_msi_msg(desc, &msg);
> > +	} else {
> > +		dev_err(smmu->dev, "Failed to resume evtq msi");
> > +	}
> 
> Do we need to check if (smmu->evtq.q.irq) at the top?
> 
> And same question to the other irqs.
> 

Yes, that's right, we should check if the irqs are assigned. Thanks!

> Thanks
> Nicolin

Praan
