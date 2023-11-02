Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C197E
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUXWuGvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698884376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OzQ+mysgekhlmn5TVv8N1n5lIKYQ3IFVh9mWG/eO8g=;
	b=OUXWuGvIh+IZiKJfwx2jva5UscwW8tIW1puPug9UmVxjSg/SY/HCrOfEBxMM2ULsjCHHeD
	TsbxKDqHlQVHjqGps4t+bZ4NjsH0kG1nePVaLWC3iJ08D8bWE/RZ0iLfqbQ5VgzZUmO4zE
	pzPq9jZrOV5XMozWrc72dA5HzbE0V/k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-gynN6b5SMuKOb94Z8nGHQw-1; Wed, 01 Nov 2023 20:19:34 -0400
X-MC-Unique: gynN6b5SMuKOb94Z8nGHQw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e7a8fbbdso574624b6e.1
        for <iommu@lists.linux.dev>; Wed, 01 Nov 2023 17:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884374; x=1699489174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OzQ+mysgekhlmn5TVv8N1n5lIKYQ3IFVh9mWG/eO8g=;
        b=GVM5r/xKz2Yz1MSlA0pBTc8DYdoOyRWXatLofgcjKYps0mdEmrURkMKI0qQVvCLxtu
         Uz8vYYfGyj5C2w2KzUAetu9OV2IsbdUIR5PWKsqqT+7Qmvl51JKPgEnxpoKCX7I3jaVq
         m8yvyKTGMXVcWIOfAkHh4MLksv2RYbGpjF0/o100ppK1rqtFR5HB0x22pT+fmbmjKAzn
         ClMhsfO4UBcUMWDD+TlrV3/n/IkooPA7Wl3Yc4fNlhlXDFjWs8gnP8g6iwU0FGcda2dq
         pNnZkn4LFQQPCMLKEu513FA0ruL5Z61wwBQTABihKG5CHbIioP7gW3ppL0NlR3L8+8X1
         gCsw==
X-Gm-Message-State: AOJu0YwHKatb4QT/0tkY4Ao6jIL3ApRU6/3vst68IZvDaYYYlNJpc4j3
	JsNDGtw63xtQ7PW1lF7JPqdd+ZZFeedXQhOqiH+Bo5q6WF2Fd5RVCaMW5b2HKLg+fBwH4xzu0hE
	8ZegF0gp4Sx7WHe0=
X-Received: by 2002:a05:6808:1485:b0:3b2:e3d0:863f with SMTP id e5-20020a056808148500b003b2e3d0863fmr18280114oiw.13.1698884374338;
        Wed, 01 Nov 2023 17:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYDMhLo06x1zZMlVFpjQr32iADzJnM1xqmKd8p2XH7slw5BabLa5A1o+SCfYk7jxIcQwwO3g==
X-Received: by 2002:a05:6808:1485:b0:3b2:e3d0:863f with SMTP id e5-20020a056808148500b003b2e3d0863fmr18280096oiw.13.1698884374106;
        Wed, 01 Nov 2023 17:19:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cfb4e000000b0066d1b4ce863sm1919066qvq.31.2023.11.01.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:19:33 -0700 (PDT)
Date: Wed, 1 Nov 2023 17:19:31 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>, 
	Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v2] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Message-ID: <ajf4euztpubazdru5lr4pb5if5j43ztmekhlhxnfs6wextxrgb@njnuc4653dlw>
References: <0-v2-55ae413017b8+97-domain_alloc_err_ptr_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v2-55ae413017b8+97-domain_alloc_err_ptr_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

