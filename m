Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A413C9A1
	for <iommu@lists.linux.dev>; Sat,  7 Sep 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725711623; cv=none; b=DahZoTLqQ2EErBT4ngc5OsbHldRNT+ZkcHmskT97j9+eF8d6ectFXIBroXjxn9xwd8hlpbSVAXb4EN+o1osIsRKlocRFkZ2v3bKyzvJuomGK6SdeR1bzQ7VP2/FACed93krDaL7wlZUzR0QdN9poo1SvnbAqNAxC+73fKXsK06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725711623; c=relaxed/simple;
	bh=23b5QUF86rTmTLWdEmIRMcy4qYGQI4Dt8E6pceHHrFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz1yE1+UO6Da9sX/pLmDmb0goBKnr1Nq9Rp9IHQX+yLDzHTcl5HkGnse8a0PpZAROcYrErDRdWd4Lv641Sz1m4HQ0wiFVx0Ou20J1CsIboUOGzK3Mh5Hye+m5KE0R1kW5AY3CqUg7XFdBa6hbQa2lcm65ORB+++XrbjMjwU1b2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZpXVlwaL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZpXVlwaL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45693d58a19so19095861cf.1
        for <iommu@lists.linux.dev>; Sat, 07 Sep 2024 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725711621; x=1726316421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrfZKMwhUBII5rQ5V9cSiTUYqeiY+7c6ebw5rFPM7IM=;
        b=ZpXVlwaLkssYpD+VMuq/60dVi3pT4zAComEBCQfSq0xysoJ7XbZpzOgHDlia1PyFvc
         KHbNVhiM6qT9SQySc3uT9yIBc3lh1bhDCjEFS5t5UUaaGGCO3KXP+lI9fTbGfBgnqtD/
         U1UfCo/+7TptPvjZMpR3xRvwZU+03UAg3ijoPF7gMMxhW64EzJuo2mI5tAbY4s3FZNG+
         t1jL26zZFQ6+VGClLviTQlYFgGtUlHJ5cfqc1q+LiPGWvv3lsz4q1EHMB7mg3atPzlJi
         eTdVrMH2TU6RnDIk2uE1UtIt/zDfVfuO5rvS5Vmi+dCtdbc84atxnzrtNl3VeMVsUNTD
         pEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725711621; x=1726316421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrfZKMwhUBII5rQ5V9cSiTUYqeiY+7c6ebw5rFPM7IM=;
        b=DLIs7EOy/OelqXH+10DWnqGud/Z4feBymrDmOw/asKS6x3Tll0AXecN20PfPWgkAf3
         dHnDZVzk9z2ST9G6JO13KMyZW25JToi0iotBlb4JxITX0YeRAmQVzhPb89K3sZY28dQq
         uyomO4n5XxD5NC93/vzl4MG9V+muh5exGGByhQkb5z/caSd2HMJv7JiQby3k1vuXANG7
         PX2WQsT+1eBJeJa6xLBjOq61xh/DpbelC69LvnDKlvlrX0qDrZsncrx0E3nR1KpKqjhp
         qT9eGj6zHL1Gs/V2NYhjBtYVWhTWUVZLfnYMwphIb1bfq7BYr9gSy0wwUG2DHAF589iT
         8HcA==
X-Forwarded-Encrypted: i=1; AJvYcCUCeLyk+QV8tNiDzjKe0J5PcT40KIBbCrZQ25qJUomeclKzKjjyPMvoxy/8YvGhFQ/ZCuEQrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAgjzq4wZ1svfWnhPaIsEUrLRK7KUYkuFC5wb8IICQz45+rdow
	4eCzGkPYFQtL1Ou3sQNfd2HikNxRKRUtOOxAWSn8hW5s2OhUeQFklv1CnDFgMcg=
X-Google-Smtp-Source: AGHT+IFc8nlwMAWVD4j4Rq3jwoqFGBPOSR8Rb8xebsYZYNleUkXX/b/9NqqvEPl8AfWpvsxBtC57sg==
X-Received: by 2002:ac8:5f47:0:b0:458:fb8:9dc3 with SMTP id d75a77b69052e-4582012724cmr31153961cf.25.1725711620892;
        Sat, 07 Sep 2024 05:20:20 -0700 (PDT)
Received: from ziepe.ca ([24.114.87.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e633b6sm3919851cf.13.2024.09.07.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:20:20 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3. with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smuQO-0001OI-03;
	Sat, 07 Sep 2024 09:20:20 -0300
Date: Sat, 7 Sep 2024 09:20:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: j.granados@samsung.com
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <ZtxFAxM6QQBYVSJp@ziepe.ca>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
 <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>

On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
>  	depends on X86_64
>  	select MMU_NOTIFIER
>  	select IOMMU_SVA
> -	select IOMMU_IOPF

Does patch 1 still compile if INTEL_IOMMU_SVM=n?

Jason
