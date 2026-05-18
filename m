Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95876382293
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126879; cv=none; b=d3Li8CerNR+rHL7PMAhZmTxiwtEuvW69DrsoYbnfJRUW4M5IuEbr+6cyOxW5jaLR7H4G5yWdmYV3Pe2QNQ29UFYDKjtEV2TBukp3g+u5hdt/ifLKdloSJkkquHmwGiTihAEUDt+6WApDazaCa1+Cuf05H+UrV0hc+5sZLX5okGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126879; c=relaxed/simple;
	bh=tTAesT9aCvHqy1aw1UCt0dGkyXqlxaqbXlnX4/OKvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qul5J1H3SCnOW0MJf3yv/YaNGZx6wigXBSkgZcPS7WVKkxuUBxZu5mHRnvDYPx70zUIf9Lj+7x8sktti21f6YL6vxrw5pA9sn6pN97KdhMhbwBTzSmS9L87CZNp06LsR2VV3s8pD10G+h//W01Jlxns1niDsojD0LDFjC4kRYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BjrD9QME; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BjrD9QME"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso48719416d6.3
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779126878; x=1779731678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTAesT9aCvHqy1aw1UCt0dGkyXqlxaqbXlnX4/OKvGA=;
        b=BjrD9QME3SEJxtxOyoHvapNtdF7YVFszMEzs52lRWLQmmG7yU51QdfW9JHfa7Ya91F
         WTDIZ04KBgoXY5z/kfGQujqPpAerZZKVZmrctw32eH8XYR5M+7dHRoQ9e4YcwWY/uUdt
         RzqF8tzTAG68y7spU1XkH3jv/6RtF8rHYz8Z23Mwyap/ZQVPSCYc17D8K7qW+PnmU9AJ
         ECEIPoNIbQGptTA9mQO/d5EKasO/H5OGeOk/DpUtGawi8s3XXTYh0DR76xKCfume7QFI
         GigU8nBfMCgzkcIjsdP11gc38eGm00OFzxnrKd1xRO/AN9lEvKptJUPnVKmN5TYCH9HV
         yTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126878; x=1779731678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTAesT9aCvHqy1aw1UCt0dGkyXqlxaqbXlnX4/OKvGA=;
        b=AtpGpSPWtzQEzp6OsKPJIz/D1YUiU7rHZnz4mj0g29NBCrTjAQRUA75lYh66hGJ9KG
         CS+TpPuz3CrAQJyh8i4HVAJ9iG0hffcbjEPunJyryvW2giOqBtZvIT+223UpfNe25yOZ
         Cp/e4hvWUkhN02AWqLTJpODxn7HHJXoIt+Kzkuj3AMWbOADbmuQEPlV8F3m622mk/7nV
         6ij1IzeE69BZMtclqcHRMpLsTSXCk+nf5L1RKwFdKF4q6Em9s8YZu0ghJW9cS6jaqkSc
         hY7GjCLQcjnCcPDm9JcnntyjOYmuCRMDjTKOQjW11R7JFCkcuFAtVMC+67RiDWTnDin9
         fdRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GnldThGHxshow32LpxYQG+a6NtyRt5AoW+gMcIHveiyhugcO5PtxS+EcgipqV0nLz13si5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyahj+pkyCSmTX5s8dtArWnvgvxhrB18uVtGiOPNVu8pX0AVes
	IKWQa/1/o1WFr41La3W6KTvwT7CCOgy9wCn0TL1ziyJ83OmE5VFgg+iF2UEJJSrH6vw=
X-Gm-Gg: Acq92OFzKkYZsnSdj7N8aSLlhR3bJ9zEtVyTX3vxuzn8dwF8DrsXjt1VIJhSMOQ55je
	uw5lv/2StfjFOGwsaHOYMpk+Xvqy942LUM5CjkjWJo+9EjmHtE+/4MzbUkLKf+qnS9kw5gtQ4Tl
	IdczULV4gwRztwb4UptTAfwIdGP9Ew4EgRyDm3nU+NWNA4twWrDk6xV0jbbRrFNpIb3jPUDn0PQ
	vjfXpW0OYgfO9N/m1qnOaDr6fGoYzvW5vKrXKao++ym9EkHzjUO3PRAKBmrb7aaHyB2lk2WzzIW
	4SMtWnWSswIDTvC/nsOuE3XVgFF4OWvpk6Y3DStq3nt/RHESINoSfBxp8IrTpqxlzY6ZfomM/14
	ypfEVnCr48LAoZEP2ntzlyv4qTx7ZeHBNCrpZ7YY0WcEPbIX2YaIi/c/ncpGa6+u9peK3NWlI0v
	TnztKOa2YEBZjXDDT6yLAj9AUh2FIG5x5hBByWZDP3Cj2G7DkN8SohdrJ+x93fYOyXgszdqbNWU
	hcYeRnUQx2X5Ya1
X-Received: by 2002:a05:6214:2684:b0:8ca:1cee:7c58 with SMTP id 6a1803df08f44-8ca1cee93a8mr226863386d6.19.1779126877680;
        Mon, 18 May 2026 10:54:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361aabe0sm63112726d6.44.2026.05.18.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:54:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wP2Am-0000000DUxu-0CPW;
	Mon, 18 May 2026 14:54:36 -0300
Date: Mon, 18 May 2026 14:54:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Oguz, Yigit" <yigitogu@amazon.de>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iommu: Add PCI vendor:device ID to IOMMU fault logs
Message-ID: <20260518175436.GT7702@ziepe.ca>
References: <C1C278E8-E5F6-4701-9127-DCDBC64636E1@amazon.de>
 <4cbd2bd2-9acc-4c72-a4f5-6c6cf31f71e1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbd2bd2-9acc-4c72-a4f5-6c6cf31f71e1@arm.com>

On Mon, May 18, 2026 at 04:52:57PM +0100, Robin Murphy wrote:

> TBH I think the more appropriate solution would be to have vfio-pci register
> its own fault handler, wherein it can properly deal with rate-limiting
> and/or entirely suppressing fault reports from misbehaving userspace, and if
> and when it does want to log something it is then free to do that in
> whatever format it wants, independent of the underlying IOMMU driver.

+1

Jason
