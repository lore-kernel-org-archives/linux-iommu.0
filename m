Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEA2848A8
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954721; cv=none; b=GjyMG00ka2uhbOvgr8cOoNENtf7tJ+Z8Z7NP/eYNykTHqXxQNPGlAncXymDGHqfVFHjOLu431U1/6BZ2oSGQMSnbD7phdiCiRTRpGA5TmYzq56lovqPpemfoQDdskhAPBCJfVEEohv+hR3hAQjUEdfDHfcGsZmQg+61D2SsfYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954721; c=relaxed/simple;
	bh=vkx6SM9gqmpLvlgtVI8pwEBIHZtD0Q9irwN6qy/aYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSyYOIDgOu5wdS7NAjAwl6QjbjkMcPqQpEN5FRpuH3z701I2FacvtmSjnVmfk2THM0RvHzBnsb5WpmlJXRtiGaD7AtxBElR1HZV+8+mh14zjBNn6bc9+nAbrdY6rFHlO9ODzKuGwgs0DPhtMVZvyNAPy1ZeAw52lt2xGuo/iYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VxoQA76n; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VxoQA76n"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b301d621so2620614a12.0
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757954719; x=1758559519; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQDjqbiT9oGuFNrzjLvyS3Lnpn5E/CxPnw6kf2pPIuk=;
        b=VxoQA76nsIo/f91Aklk+FZzSoWss2B/LtZzctMqFuC0nvFQk1vQ7wzgdyQQog98Ou9
         rBaXqECR7D6JrGI8ZBqBg/PGAL9UXaI7l2+lSHgzLQGHJacOdUyBXbBasT6WXbGsPjki
         /8hIRGq+FduCB98M3Xm8kDmsOkY0X4HaVYnMQWmPyB36/9wiZK4fUtvqyQf4NgT5k+Vd
         XnFxtwUWYXlhMfWBO0BXeRpWKPc15Si2ek3uGBEJ56J6GCk/jeRxh8nMswgaJ0feSYBE
         dPJGR+T3LF22xqkgQADDSCsxheGp5VomyU8TqdfKBqY4jQmRqhCFDiIIoAEs7lTcUT2e
         1m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954719; x=1758559519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQDjqbiT9oGuFNrzjLvyS3Lnpn5E/CxPnw6kf2pPIuk=;
        b=wUeza42/XlPXUrwVK9r3VkrYEcXJtsvx60pK86G02t7+lTRJCzXz9izlCGdpn1iudY
         lXJqDTZrZcA559GpaEWKGL4Jbs7F6AXhSNcGvqYZgN25isv8eXnsWTJ7RnWT6IwdXvO9
         F7Omd957JX1bgGDwpp9txk/hkUU61cBA1SinPN/IC9/CA3q/NHE6fJFJ1LqXzAEXink4
         gFf5bryy1gFJ02GtTEf+1TLfeFi843Jvhzg+BLbDR4FSDTRHXBj40VRrvWslSbEjnMgQ
         U/rOjrUQMH1iML6eJaLOiJyTF1ayUzqD8VJYVrr6MKlir9l4Qm7zjQDtJM7Jp7Od5nZx
         Mwdg==
X-Forwarded-Encrypted: i=1; AJvYcCUnFWe+RoNfUZViJPDYAELwdghV/R51Up4maEQ4z1h4NDBVfnXrxEDZchcMfOiAwt+RmxxpgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwodzKlZ6ImeJHZw6j44sVD2QGmq5z4pResQz41vyJMyM+BDlew
	b6rWgmY7Wg5DZvIwMpN33+Tbvr1vhSN1pQrhCM0sTEB+8OeGYv3eQH80PPqcy4vQTN2OK3LjhnG
	2yLwr
X-Gm-Gg: ASbGnctpLRde8ph3y3DxWKFoTVoxmwzHE2ctN5FbyUN9WaheE+kTBWxaAwcdoljgMfL
	eIkpObDZBauip0+vnsfT/wbVb92W4v08IxEJxxKgC0Jxxlacmm7r/BHSdX5qsbgYggVoK33uniP
	MtYatcxg34KORsS/6L/z0HphpSR8j+dljuwMHBaTZg6cwj9kkb4HRHngdhmC1JruJy7g/sFCozY
	8HJVWZt+OKWiAl8YoLj8pb3wM+69gjMcmIrwY/gceegadevtCQu0DouMVjlBd2/oGsxyquPwaK2
	547GwIhgupQouwiq74nb7/SD8UHH2H2KTrIAwr8e2gpLUkvEjw9o1ssBJmOZ3/H5AS2i3vLQ
X-Google-Smtp-Source: AGHT+IEueZRPYz6Ovwnbpjg7oIfp7yjCHZ9L0M0q/iZt1RonHcNLG+PurDsqJLquezOzfjlKgS1iDA==
X-Received: by 2002:a17:90b:3d0e:b0:32b:ab1f:5113 with SMTP id 98e67ed59e1d1-32de4f7ee8fmr16124999a91.28.1757954719094;
        Mon, 15 Sep 2025 09:45:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1a22sm12075579a12.52.2025.09.15.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:45:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyCKL-00000004TKd-1naj;
	Mon, 15 Sep 2025 13:45:17 -0300
Date: Mon, 15 Sep 2025 13:45:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 04/28] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250915164517.GL882933@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819215156.2494305-5-smostafa@google.com>

On Tue, Aug 19, 2025 at 09:51:32PM +0000, Mostafa Saleh wrote:
> Soon, io-pgtable-arm.c will be compiled as part of the KVM/arm64
> in the hypervisor object, which doesn't have many of the kernel APIs,
> as faux devices, printk...
> 
> We would need to factor this things outside of this file, this patch
> moves the selftests outside, which remove many of the kernel
> dependencies, which also is not needed by the hypervisor.
> Create io-pgtable-arm-kernel.c for that, and in the next patch
> the rest of the code is factored out.

Please send this as a stand alone patch, it looks like a good idea.

Also please add the boiler plate to wrap the selftest into a kunit and
use the usual kunit machinery. We alredy have an kunit for
smmuv3, it can just add another file to that.

Jason
