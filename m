Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D441F91C8
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236896; cv=none; b=QPD9DtQXakYmy+AKDhOFxrkhvxRWDkZeUzBXd+J/5lQXeslnWvye0iTSN3mN0WkrrXUhWkhspFUKA0MpR8Z9g68dTPpY3f7aNyCsrgzU1y+Ooqrg3ivk7RswJ49eSf6MU15JcBFQh05gbsOCRtAg7CfIotuycX8E80iYPOBDzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236896; c=relaxed/simple;
	bh=MKBeHyv3NY02Jpy+fPZVna1bcBZA3eyBmrzzBsDs3WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evh9uQqkkaFPBdsXhKAJEsuBpCa0jQSjqKZeNrD2fqt1sGAg9H4IflIEUUwTWb+EHPGohETp2Jxr3+fomQHkybYmkH2PJHnkS4KcurYQeDKvF7i7Obi0z9CiObu0jankPVgeu6y2aP/m2DA46iClKKenu0cRdJ6Uvg8iFW9ejYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RkLU30aA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RkLU30aA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-854585036e8so601062185a.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759236893; x=1759841693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn+6mTGWkxBQjLUsqN+kSoojzIgnAUXBIQNu61nSFyA=;
        b=RkLU30aAeoc4mOUeFTjivkOFnyN2rtAfhRXpKkUW/5icbv8XP4Pn1XL9xlind+Tm9f
         oESng8PqPjdUUKng4Qgj3hrsYPRuPOnqKcXpiynJF9iuad+dd26YxSbmV5fSi5zWw0vi
         /h71AAPddkloPJAydUrk+ye9IFOFS67fn9/iMCqnekKENcPX3MPqpMFGX0C+WL+6cXCA
         ao9+xVe3Y3GKognsQb1wvVaIvTCUoOHJHTddhS7XTNj90XZX6MK10r91yHBajIX9DMrj
         f7cH5G8G6cZvtkMK2NK0AS65Sbvlh5nyYduTbj/XJKhx9Ic9TyNfghI1OOIHhR/3zrH6
         B9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236893; x=1759841693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn+6mTGWkxBQjLUsqN+kSoojzIgnAUXBIQNu61nSFyA=;
        b=wxI0oOKKuXT4LQxjvRWBDYvkMIm37FW3y4/fN17y17O5o2xtDujXFAzIrlz7oyOX33
         WznoTdliMuTukwI/V50uGAcmQKcVM6cKFpo6y9QoanKey50v79MQbFW05yHaJkEvznkk
         ABRHq+h8PatCgdhamq/BjZopndj451bPYOqSvLuuZ/9BjDn3itE/PFvWd1bYam57frfg
         ZTaUozmz1WU4M2l91IYEMSDHg3qxQu2Xexoil+6H7sibUp0oPd8IcVBZVPfzHrnL72sy
         VWVNjjN4CgFDf4MQ+iAVBV7xw2d5aTIM1L1d2qlaDrIBQDeTrUdmwAKkqXtqLhNJtRYc
         U8qA==
X-Forwarded-Encrypted: i=1; AJvYcCW+wVtAs9i2mAeacialn1yrTD2tK03+cBRwWsFIijFEhFsngEXeEL9fAsSOfDTNdXgLoAmqnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTpAYMABggV8HzugY2hHR4rGplnYcD5Y8/wZG1WzaCrVHuNm6K
	UNAVoSjyhWRHXc01OdDbhp8O1lv3IGbKfO8MXqBHxb80glHOaZoA1Fd6AQ+ZkdW86O4=
X-Gm-Gg: ASbGncuJuqhV5ZXzcPKV8UPIuh52T0HmMMZNSCAaj53C28Hvv4xaxNO2p0ZHpTR+SfE
	QwCBtp/lePDBkhqSycS0+JghFpmzar2/QoA/HMmh5mwbyM8T5JxviBBGLtixKBL8CUxsvfcMEpG
	WgvgdndZd0rue1f8vikb2RW76l3ohCBzQ5Sm2F/hiUNKIVJjU/8If3jFjxm1lKmmvkPEBN55S4v
	bOavGDbPPxVagr2hk3STlZU6Fbg7ZC4lhHViv/b04c+qtz5wLt6YgiIcrMXEVlKKIiOt0wDaD8K
	sYOWxSTY2qzmMGAb4mi3XAnp5v5giJHzs95tXhaFTbRXKSYmGelOXsEVW85B1oACw9JjdrEuim+
	xpS0lO/K3VoWpuFS9cE8ZnGfcDKYh7qM=
X-Google-Smtp-Source: AGHT+IH8Xq1xzvsa5atQWy4L0N+927va19nw9h/INxGPOCjMGegHFYwwzd+J5W1A0Dfgpb/gIfdZBw==
X-Received: by 2002:a05:620a:6281:b0:842:6a7e:52ed with SMTP id af79cd13be357-85ae7bdfb4dmr1889933485a.45.1759236892962;
        Tue, 30 Sep 2025 05:54:52 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c33b73f99sm1035322385a.63.2025.09.30.05.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:54:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ZsZ-0000000CX6a-1f52;
	Tue, 30 Sep 2025 09:54:51 -0300
Date: Tue, 30 Sep 2025 09:54:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iommufd: Fix error code in
 iommu_device_register_bus()
Message-ID: <20250930125451.GM2695987@ziepe.ca>
References: <aNvMULgt6s7-3ceR@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvMULgt6s7-3ceR@stanley.mountain>

On Tue, Sep 30, 2025 at 03:25:52PM +0300, Dan Carpenter wrote:
>  	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
>  	if (IS_ERR(iommu->fwnode)) {
>  		bus_unregister_notifier(bus, nb);
> -		return err;
> +		return PTR_ERR(iommu->fwnode);
>  	}

Thanks Dan I fixed the commit

Jason
