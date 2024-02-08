Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F907D40D
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408576; cv=none; b=WA9pBU9KxeNLafeMT6mU43hgA/ImkqGuBDwd/1KteyBiGWA4RZiRhTq8j9SuxtcwftzQTTTzlb+h/CfathzFyv3Vl3dyXh1zd9RqJGskDAZljw26hkp2T7gYT8F4N1hsE/VNmO8DUVHLEqt982yf75zVnOzqOU4nzsyxa/nL0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408576; c=relaxed/simple;
	bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucXBfXhCxDkQ0w1Tc3wRT6bwmWEe3ADbEuK6n2eoP4GUNC/NGQLy9KkvKcNzlRwApmGsuDcNJjVTbSA/z3ZHr5CDOdISQJVZ/xwHG72L1K+1NcZRvs+IQkzVDDw7ki1KDn8TRXXgjcvGiJyPyi3fDhmHno1dX3Fdm6xNZI6lfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FUunC66R; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FUunC66R"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2191b085639so771746fac.0
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707408573; x=1708013373; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
        b=FUunC66RhYgArHO3oQ/cFniGfd51utTnjZ90QCmQGlj4usiBt34mPAJdvb1hrYBlDF
         pW9wHv/gxWwE6JqmXklc045W7N2D68JwqijQ4RkVa8lknMvJEqI7XqM8zVlAsai1n3IY
         1tZZOGrmn4AiVzFH3+tl/eyKCpeiovYOGD7LTYKSyqc8Q8kK1l+tEVuu1oztMpFsRA3/
         3hpeEL1Oj2PxeMbuU25C7umylQReeLhO1FTb4gLebhhRMmksRFBrMZmnP4vHS0grve9M
         R+SfKkA3d6h4wm4rXtYrVRm9Sz0VLQRB7gsOhu714XKxzuzuaA29h0bp72cORwQI2jKJ
         aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408573; x=1708013373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA68IYVKcNH83wAWFAiDF7WtWkrD2FpXaZIUMkfZUgc=;
        b=gTaYWVTsTh853ggotUVP8qNZDyWaHJeD3EtPUGGcwtbBCFH0b9A4UzdhUnqg/MeiLJ
         TEKaZdmBOwv4ag0iLpJm05Xioly9kBex6LeNG3unTpgr2rrNy3Pl8C4Z7pfKVq9NVP+b
         kE9YdK5xnt4RpQNqR4JIDOYH355Ea/GnLYFbT+0KY2aaAq2blRHgFIouy+YVdKeNzUQo
         PoskUSe1bC7XKroQp7IVdSeo3ihYVxXfKy1kzLMYm98H1hQXh9LIDqe0BbhRydkBk38D
         IE9AJqlI1pO6ZV7hCb6nAdQ1bBmPMZZnqYcFFItWmHaIsQSU4qmV2P7gU4SlfF84OFhD
         57/w==
X-Forwarded-Encrypted: i=1; AJvYcCWmh8sooGc8F0gjEtL3Vw2ptC0jjLm4TlPqzd/V+I/XH0kGl+lExpLMgINhK9SfWrSVKbXwqt1NVbuq76uZFdWGpZtYLFQ=
X-Gm-Message-State: AOJu0YxImbv4ykK8M1zNvu8OchcCoWZRsOPMrdLfe11KUpMZTcKO/wOc
	Ehp/MFQcVmCizPBfHD/5QByhRFoFXJXWlpvL6fOZZGUIKANBppaiaQL8Lv7z1Li7l85uMboItr6
	x
X-Google-Smtp-Source: AGHT+IErIu5NJVT0hLIHW0fj+It0NY8NAUd0q2LBBL3NnmeMbz2sfYWipPYkByL/AMAQc/lEsNvDeQ==
X-Received: by 2002:a05:6870:1696:b0:210:a32e:e7d5 with SMTP id j22-20020a056870169600b00210a32ee7d5mr10283269oae.36.1707408573724;
        Thu, 08 Feb 2024 08:09:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBsHol45yKoashMGQhkc/ZTmzPGkNoZ++2p0ShvaFoPWGrfOelckT9dqTmS4wjjoV/hOiM4t6sQarfrrhhe5BCELoSeiyNUaH+VdQhpIE5DK+KmZb2oYkGgB6Y5WpSyct9kOkpP/kiP2V8XTobJYBqawgaXmM1zL+BDYvKAkRA6MnquX3Sm+I8vC1Qzn7GWAQXAaB0vetnk7b00v3T9H9f
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mt15-20020a0568706b0f00b00219a1bf0e44sm792408oab.47.2024.02.08.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:09:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY6xw-00Ezhm-Gh;
	Thu, 08 Feb 2024 12:09:32 -0400
Date: Thu, 8 Feb 2024 12:09:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240208160932.GT31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
 <20240207145656.GJ31743@ziepe.ca>
 <37ab8689-5e0d-4166-bad6-84d3c51446ca@arm.com>
 <20240208011305.GM31743@ziepe.ca>
 <a93e93dd-5cb8-48ee-bf8d-b3bbb19507d6@arm.com>
 <1cb6a33f-57e8-f3d0-9098-755af70cda41@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb6a33f-57e8-f3d0-9098-755af70cda41@quicinc.com>

On Thu, Feb 08, 2024 at 08:47:42PM +0530, Nikhil V wrote:

> Also, as Jason pointed out, this fix would not allow changing the
> default domain for an iommu group. We didn't have any usecase for
> changing default domain, hence couldn't see any issues with the fix
> proposed. So, we would have to rework the patch for it to be
> upstream ready. Any suggestions for this would be really helpful and
> appreciated. Thanks!!!

I think you can lift and duplicate the check into the callers and that
way restrict it only to the probe paths.

Jason
