Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502801E0B96
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516132; cv=none; b=b/CTZ0qV7huO+zI1GKkgsihw/k0dQS81JyrPBWU3UCWtwxaLxbmNAQmuIyo13Z7P0WaYYsYB9MMM23kSzPaINz4V+gGhjKQ8hpRHtjoPJA4vEfywpJfr6vEpvPqtOI9ZugGHW8saza688G368WeNhDjr1qLX3lFUOodxwHw/lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516132; c=relaxed/simple;
	bh=uMCpjxkkbpH4cJ9rg27SpjeMUkWX+azzoaNSrCRm8DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av5ILbwitk6mM9CooMmJbVvvTQKGungI6T9H/kZvGtb5/PwA7a/+N3ZtPkx5CP5tfV+DLhFly8JoPMNVl4j2H90rBenF0WQqooZ6142x4AXtO1LbUoTpdBCRQRQLpU9g1BCq0BZenucncE97IDhlhcwfUuljlEAC78K9+5ysYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V+xmk49J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V+xmk49J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460dce6fff9so8776991cf.1
        for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729516129; x=1730120929; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evJa18w61he0GiyzWsy/XhrOLrknrY4Tqt+JZDSyhOc=;
        b=V+xmk49JyrvbKUFpxYmTibrg+PvQX+6myq/PkQOmqjNEQRJGRVYcv7SYaSnPaut9Jb
         x5afO+HHhoC2yPsCavoVZ/RTX4/BGEZSzzvJA24+dk4NyttZWXoqdz+0QUKdg55ecggZ
         sm2b3ZrZ1EGn0YXBuMnyJyT8fQe6/Vewpl4NLd8y5Qkm+4pbk6V24/AZHhk7WKeITzNV
         mQhK4vFyK8W/scrYpd649iid48dGUjkwKzGjedDWdaM2r30v6cMPkumEher3aoqKf5hF
         PZSFk7A72d2qf4XQFDSUgoehbRFClsTu6TMg6c2JE+7qEqH6+IlJ4otku6e3EPDakgWW
         oEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516129; x=1730120929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evJa18w61he0GiyzWsy/XhrOLrknrY4Tqt+JZDSyhOc=;
        b=bL+SlNgDrUuplHan/x45QJBAqdsnh2m5j9pFqRpI86q/9f+FLdBBj9IeHQBnLctn4e
         pwl2RidRuCAaCjAWIhWaNpAOlduIv/FRSXXkX8+yYiyV4YbCOzA1U121t7yrm8dg3WrC
         CIxJztZPaQQcSElFIFGKg8JK6TW2REL/fAoGR5L5saTilPqhjkwN5tfNvLmeIKXmEsFr
         QxMZNTeqrgbiNlUedFEX3GjygpsJj9kSDY1Q98r9nne87BU3Ma8Hj9G4viS1l8kMySUd
         XWNBE6tBbs9IQ1VuttHQ0/cmWSelLZdCveoaMNuMOT4FRtfVCFy5RfeFKhAkzjLOfC75
         SoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgxBYSCeFC5p0d8K4DUyNMDSfulo1OunwSIiXThL40dej28kFqYBJ3AplmQAcqlPcG13aTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvGQEJYkUSK1R7/t0ltuXKpPhJB8eRkEmgThiNjdXHphc+Mn6H
	SOcTVpOx8cS+niGYxINT6dAL7O/5ZTer48Zqq9eZxDg+8/r2GkkxN4l6JUz/ERQ=
X-Google-Smtp-Source: AGHT+IHELvc9bJUkKetX+mL8TDIZmJ616V/74r+nkShR2wxBIrLxWT10RhDZSE2+v55iHiwoGSKOUQ==
X-Received: by 2002:a05:622a:28b:b0:460:a06c:4eae with SMTP id d75a77b69052e-460aed809bdmr174162711cf.31.1729516129164;
        Mon, 21 Oct 2024 06:08:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3a85esm17492791cf.9.2024.10.21.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:08:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2s9P-008Nw4-ST;
	Mon, 21 Oct 2024 10:08:47 -0300
Date: Mon, 21 Oct 2024 10:08:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iommu/sysfs: constify the class struct
Message-ID: <20241021130847.GD3576661@ziepe.ca>
References: <20241018121725.61128-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018121725.61128-1-brgl@bgdev.pl>

On Fri, Oct 18, 2024 at 02:17:25PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> All functions that take the class address as argument expect a const
> pointer so we can make the iommu class constant.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/iommu/iommu-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
