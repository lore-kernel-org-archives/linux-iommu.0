Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18787126C18
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493039; cv=none; b=OLeoMaAPCpDtU2E1wd/fFJwf7zkiU8YTCnrgDZfUMreGu04Z5rkby+B/JmLTcYtdPK1hjNSCZL8fDGPVzIo/Fqzkk65/O92J7OHLUBF07lbOaRCCKG2Qeam77d2/s9FOdiWu4PXjs4s1otkeZnfdtEQ2Ic0m6Yv8BNIetijiUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493039; c=relaxed/simple;
	bh=OBXcVx5bNTD6D2IRnummVu9gH/H+dTrk0ExjvPTnOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M22+CpxlEHaHDgipGtXAHxd7uioIwVb/bepwu0RDM3lLgEjJjS4198LvE1cXIGRsDIiydyh1iMfiOL66YvofdQfoTIpuF/XsMBq5GCT40YSNLOtkUYOCnY7UR2ulrzCz1cqVyjpslAge9NtY/sz4WF2ClrttfmdzHHyMLlIzuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IxD7oXz6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IxD7oXz6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c2303a56d6so222818085a.3
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493036; x=1741097836; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ7PZq9etPp3tzaQLi/WkFQh7VYqZPINYGOK+qulRlA=;
        b=IxD7oXz6TQqyWwohA4gDLzYZlh1BnERaiJLepnx1B7fndmm4RYG1IAOxpkJgDF/FPq
         2tpi5Xfwr3c+oIZMdQpPT3ML8VwwofYN43GbVkc+9qjT1Q+7uoDE9Kb+yVm6CsDW9W1p
         kN+mslf15u33kA4MsUvOTopEa9jt0dcY088I9jsxt/ut7vdvHoFWgLat3tFGTH+fARFt
         FNuMoTvGG82h8Fw8Ur35BY0XPRXkuFEd1qHAO5uy39AQQ2YqiieWBf0Fls8iTg9DtiGR
         nywPEFvtvtv/A0y9euD5a7VgG7o5AfuZu1vY8KLlr/qUbWUqY7ZdksmGTYnnBTSkNfMc
         Cqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493036; x=1741097836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ7PZq9etPp3tzaQLi/WkFQh7VYqZPINYGOK+qulRlA=;
        b=DvF1ePgvN6KnWJfS+OTJy8JzOUmUMGtAw2//0DMdkarUm8EX2zbwyvZ5G8MUHf+X8e
         YizOLmS6YVGtZNf19x1o44NB9pK6uSvuDInRCDoaHQs2DCpqvf3hfVyHbvRaiPClxveJ
         lVtRnwkLXSDWcBDoPBzhOnov4qJBBLya4iBCOO7VGBQukNCyq+sCrJ61nD5xFt1CaMdj
         W5pzXn8K+J+t3EpzWXzetIy3iKclImq9oNcQnj2aqngkvUmuPymPT+FBU5h0AHih8xk8
         heKxkjkJSs6UEXfOeMsRNt9U6ouniNwiGAA6/iUy0pkVQEYm5ejygfYxIlCdgyMjsaaJ
         xDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrGHtqNMEOmNc/0JGXPjEzPoL4hRnH5a3W9IDOy0ebXG+WhanQahwwSs2teS1uRdQguulj4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoabuw7dGVi1exuB+pePPO/nSujU9Ot323+AbU4YExpr+2ZcF4
	wmiLkwBNwO3NM61Y1Znea7jJ1rg5aWq0C6zjSrryJx8M4jrg3Nos1hdXV2L5xgewWUnQkAOnvF2
	m
X-Gm-Gg: ASbGncs/gX1P+5vjtJmkPLEEnIKI2ovOvqwVDYteaaDjsklKm1yKtTCLQf0uPSYD6Q1
	5dQOQWBbhBaasJ46Xd+sxNNs4+Fxz8KD+3aSwEMpi80uXjmyBUmRbSFNawDMojyWStyxzZM64+l
	rlqHd46iXMM82HBVrpk1laPmOCQNn+psya7e2H21dC/UuZgD6Xl0okT+bgPGDEWtNS657H4eUbb
	890WHmAiZiNBn7JZdv5X/47PcysNg1HoDAONjn42HcUdh3YpiDLqMCPJ4aFOVuntAoZMNXZa0TI
X-Google-Smtp-Source: AGHT+IH0VQRMAlIy3yGeI1Ow4RW2x77HcwDm9aKWUZP87RBlSWNky3yZmlg6PMNUTdEURaKUdZk6eQ==
X-Received: by 2002:a05:620a:394f:b0:7c0:acf6:3726 with SMTP id af79cd13be357-7c0cf8afa39mr2124678185a.10.1740493035845;
        Tue, 25 Feb 2025 06:17:15 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cc1csm109415285a.95.2025.02.25.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:17:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvkD-00000002SwQ-2lHf;
	Tue, 25 Feb 2025 10:17:09 -0400
Date: Tue, 25 Feb 2025 10:17:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: update MAINTAINERS
Message-ID: <20250225141709.GA545008@ziepe.ca>
References: <20250224162724.349679-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224162724.349679-1-hch@lst.de>

On Mon, Feb 24, 2025 at 08:27:21AM -0800, Christoph Hellwig wrote:
> Marek has graciously offered to maintain the dma-mapping tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Thank you for all you've done. Your technical leadership on the DMA
API over all these years was sound and appreciated. I view it as one
of the cornerstone pieces of linux infrastructure that made a big
impact on the project.

To repeat Uladzislau's words: this is sad.

Regards,
Jason
