Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA1E04AA
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400511; cv=none; b=cpaexjeOzXtjJCftpq0eHYx7PRY8T0hmCGkOHliGGmlUcf3zSFrMcYgaLfwOdTX3r4vMZnCXiCZx/8GePoFC0uvlfjND4cCTeBKFqMJ5hfj+pqPS2/Ga9iht5h5UXXMNnrW9dCCO0toIknYwJ8Dlft4BpW7QfCtoSpQppudnCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400511; c=relaxed/simple;
	bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksQfw5i/P/+fY34AirBjJ2p1qTXU2VFkvOAgGmvJNu3W9LyT/nGeQ5nCWuOfGeG4hsTqG5ZvbO3JiGm6Lo7Y8LU3TscB+j07YpjQzzErI2lfMxEfYb49IPjQw+tgA5ytXPdigW3r67Lrelw0h3EiszSxSxflKrRfUXTGU3pw4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=meM8IOMC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="meM8IOMC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9ae8fc076so620388785a.2
        for <iommu@lists.linux.dev>; Tue, 08 Oct 2024 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728400508; x=1729005308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
        b=meM8IOMCdvqjEtL5F7VuOKjpLg2mjYJvdK+qR3CxsoTLk65X4cw5Z65QxHDRRRg5/i
         Kv5QTnE+HY7zqWSBIBVL8gzd713HpMLEJSiEo5SCbtkS1vNoDV1jZntsUg3ZpfMVCnF1
         v5fMyPPUQYfPMIxl2fc8SwWi7CzLRBp0eHn4lRjhGvZptWFmpya2frZ62zikqK3OxIKb
         LKFCgUqf/Qg5iOquw24rnKtRQPwm8FYb9iFyzz1sb6BNa3ExVwJBFqwXaPDNI5+K8rCl
         7HuFHryQcrxrzwxRNI1rUlG9mUH03CWU//Tp4Y/3q7s6FMqHlhydBqzfZaEICHjlKWUb
         ECog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400508; x=1729005308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
        b=UJIZOD3vULAL5+VaCZxAlU+opm8ItMVDd/AOBoWudSEhKeQ4aAIlY5rD7WWHcOmMHe
         akSX3gN8QOUJO+q4WdPmQijXdyqJSOYui+zmhr/LeNbNyPB12ictmKEbss3IggMbDIhF
         bDDyvmKpy2GTwGdUWN/Ksi//6PoD6rKXY1Eta0z2zowm1VR6VFDZcyaiY0pnEEOA6Zuo
         I5YSUvHUR63cagZzNbrGXL5sJL26y4bYLuiGbwpn8BxSHd67c5QwX1BdK7Y4y8UELKJ6
         io+uRB3S7dD3Kse06l6G941KD+FTjS7SXp/tUK5A++JV8l/F3RDcwzkG1J+1LgTOPbAl
         Bc1g==
X-Forwarded-Encrypted: i=1; AJvYcCVAiQJkz5tLTiZO86vI7PhlFAe1psjg+XgMGUMNr4OgCPwXjaRduJgG8iWoxCbYt1UyIJYdQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjBAn5804DFFvrGT1Rp8GAgkwxyIgy/pmu1cdggaRZYPzkNGBN
	sbacR1xTia6FXJskmfcBdENSqmxu3Ad3P6UtZhz9ZqUNCXJHim1DrXw98+6C7Wo=
X-Google-Smtp-Source: AGHT+IH2uRC2UfcD0r1BF9aCv8jK6ZDJjGODQUbS2anKumzSrd3t/zuWy5T9g/mXSSYSymaMjGgK/Q==
X-Received: by 2002:a05:620a:192a:b0:7a9:b114:471d with SMTP id af79cd13be357-7ae6f4541a6mr2723208285a.33.1728400508653;
        Tue, 08 Oct 2024 08:15:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75764d2dsm361159185a.117.2024.10.08.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:15:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syBvW-00684j-QA;
	Tue, 08 Oct 2024 12:15:06 -0300
Date: Tue, 8 Oct 2024 12:15:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, nicolinc@nvidia.com,
	james.morse@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241008151506.GC762027@ziepe.ca>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <20241008133458.GA10474@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008133458.GA10474@willie-the-truck>

On Tue, Oct 08, 2024 at 02:34:58PM +0100, Will Deacon wrote:

> This all looks a bit messy to me. The architecture guarantees that
> 2-level stream tables are supported once we hit 7-bit SIDs and, although
> the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
> problems in the linear table code above.

My original point was about the confidential compute position (sigh)
that the untrusted hypverisor should not corrupt the driver.

So your statement is architecturally true, but we never check that
IDR0_ST_LVL_2LVL is set if IDR1_SIDSIZE > 2**7, and so we can get into
this situation where the hypervisor could trigger some kind of bad
behavior.

> So I'm inclined to take Daniel's one-liner [1] which just chucks the
> 'ULL' suffix into the 2-level case. Otherwise, we're in a weird

I think you should take it and let better be for the CC crowd.

Jason
