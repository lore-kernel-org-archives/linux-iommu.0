Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FC1ADC83
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102927; cv=none; b=RSKV4NuhcDuYqhWQjff4eCgEdxn6XJ4nzxzJKwBiPaSjTW74laHrbpX6jyaeK1g5mQDVsj36yhUZ9T63lypwRRFO1nk6nVbzh9dMhLWuOCH5aX5g/WB0Z5foXMm6OnDw9jTsTYuVtMBECGDG91yeizH/OThqJ8xXQmC4H+eFc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102927; c=relaxed/simple;
	bh=009AGo0MZHlPasEPyaYAPNU6AvgkTeVS0lu0Z4SrMtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRa96/Cf2JzKE/I4x0oIMOLLndXYXbxl3Nc6LZ9BSjJpbob9VuNxWryR3pa9o/Rc6ASp0MUK2NcMyyP6fWeB6Hw5EJT3C+a1DUMqIlOAoWH0QXN7HXxmP7YunU6DZmy9rjDld3WnybnVNeYzU9mnSfEOFIAaNVVrP84ch/VbSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=echHA+ba; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="echHA+ba"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899f8c33c11so83565536d6.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773102924; x=1773707724; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzWH6RbRKTBzRTMn26sPYCEGxdubi4Ld04JsptWsl0o=;
        b=echHA+baQQBNksUSE1wqK8WljjDyBij4GGQKQ5/tMA3ODc+6cYHQlWmGxtP9Q4vUdU
         1t1Xs41TqyLZLRrb7mdR/TyHXU1ANHGTy0jea5Pj2dwEaKn1tl/OVgTGu0C5hYTn+wsb
         UtIdFlsSNSaSy+hH3RDfHKnHZuRgZyt7gY7UlICc29ADMO9/MLaQggPNaWMHsmH6NGMc
         P/At4vazVvSeteR/3n69NRlhiNutf8khXtSiR11WO3DQxgBKJZbv51aFXIJXQXA5fCbN
         fkzb34CrSh8EPL3Fcf9aoE+rJt6d6egU0pZ968Cf7trjBgixx8qvGfGRY/VIiq7iZY8r
         mshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102924; x=1773707724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzWH6RbRKTBzRTMn26sPYCEGxdubi4Ld04JsptWsl0o=;
        b=knuGDVd6RFJg2KccqVTpMq8yqpi84t6GAlNuVbD0OAt6M9f0jg18LU2L5Hw5dJ/1zE
         s41pxoajIUIsrf3pFmEVPcuJLzUCoB9+hKrALoA5bG4S8bZ/XbRza9vsFy0+CZy0eguN
         lxMuw42JM7pYxtQDAys+kS6nbBYQb7Jb/w7FQP9gfELaVmwT7TpbHeIPGFPoIVaQ3RY5
         0uzcePL4J6yo1vCmVZTkdh+VHlOBj3qb2KQB7Y5u4VByvVBSHTWuwEq3VlmycHQKhKOH
         uuGXuHHDvFp8polWI/+pxxRFF9R7+Wmo65OQHaSaD8zzzfNs73Zlu1UB71aQHzvHwrNG
         uOSQ==
X-Gm-Message-State: AOJu0YyyHKnn41jEXzRPDT5yuMyHgG4UbBRHdvlwzqDxn78GYKcKG7Ko
	XMOEBXE/RNcotSpM7K0DggsM7kU2JcaUu+5VGGaytAG6/IevBu/lLWIo5Jt57rhhq+g=
X-Gm-Gg: ATEYQzwlUXnQR2eRG7GZqvGLbv7RswpORCMsBTACY8wD1bcu1+UCekg4Fh3Y+2sYK/8
	kOw0lXJTq8CPtQ/8sataiVZnYGjTCJddqEykyIW2yb0mGKnN/93+oYA/RAxkjS4ARlKAwd6sLPh
	D5S62jZBmiPRxHpaeNAqIbLvwPcIkJrQ7aOlOmzFBFFyPx0+FiKwlS02kSQMU3q/saa4/YO0Nhd
	lBauFaUnTOahBXw+16Kmu/Ra/Jmz+GN4EYFdSsiAq4uLuiwigrgx0yPZHlt+2DzxNCbjTi8S0FO
	nLON6JotOWjAyPT+9A5X8BglZLPoR99tnGc8nRb18lI7JfEGKHU9n0nqOSt0kfkkEKwEuH7Drmr
	Mq9XIoNtCOibtxBEwBsDMWm8zS8PLla8KFDL4DDAbVFjgaR/A+S7bs2qarM1DSOQNBdVNPA8fnK
	K2vm2yN5B1B+GQo6JBa4RNQLiqAeOARXfJnYjCi2+zeGrBvxZXirNFftqqQ5hJTsxeQ+ZIZQTBh
	TAw7zKh
X-Received: by 2002:a05:6214:2524:b0:89a:107a:5b8 with SMTP id 6a1803df08f44-89a30ad1c8emr181406496d6.36.1773102924555;
        Mon, 09 Mar 2026 17:35:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c298e4sm8412466d6.40.2026.03.09.17.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:35:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzl4F-00000001ttk-0iou;
	Mon, 09 Mar 2026 21:35:23 -0300
Date: Mon, 9 Mar 2026 21:35:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joe Damato <joe@dama.to>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Block identity domain when SNP enabled
Message-ID: <20260310003523.GQ1687929@ziepe.ca>
References: <20260309235234.3367768-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309235234.3367768-1-joe@dama.to>

On Mon, Mar 09, 2026 at 04:52:33PM -0700, Joe Damato wrote:
> With this commit applied:
> 
>   # echo "identity" > /sys/kernel/iommu_groups/62/type
>   -bash: echo: write error: Invalid argument
> 
> Fixes: 4402f2627d30 ("iommu/amd: Implement global identity domain")
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  drivers/iommu/amd/iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
