Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9A477E23
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628981; cv=none; b=VYFJjOiVtSWJdnAuorYuzVDp+U362aMd6QseCO/luKLZBkL+GmKq4xR7wNnmIGOa4+tCvoiqh4ibFWBqwSrwTOFaVrkssbpQGH2/fxWy3tLzWxAXv+3c6uBCAlFjiaHHa2yizp85xwUDMJWhpsOn5m7ByXjFUNIMVrO+emQtQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628981; c=relaxed/simple;
	bh=0/BIRfMphfS1OGwGGVzoT/+z7v+H5hzNBd1OvKLo6R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHNnhlUkJO4BKUSCr7TwQ1Z7kinTQKgqxywC55ylkdy2A8J4dwKTYGFm9L3rOaj0PW2GGbfXqeovm4d6oIKlKC8X3jx4YXQKQvZEkZJZnywF5NfhSkgQpG42edkkHvotOrQZZ3sfMJ3MRoCT0xnZYJ65FEyTv4XQ98bsWh2rfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MKg3w3LE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MKg3w3LE"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92f03daaa97so40717785a.2
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628978; x=1787233778; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=MKg3w3LE/xrVKXAifxupau329+Qnk1ZObm/IrHTddZDTFrgC2pd32eGrU4/ivj0JT7
         VSNzaOMcPgqoszkP0SJyVdDYn7PSgYqh5MZnT2bf5rZ+cH37GAMwK7aKqQTlNA7roZas
         GQPtdIz3+2CdxSpr0YLAlgYoC4ndRCIbX6f9Og9b/mtLw0NT/LS6HneLZbmATH95JD3W
         iDn1zQcpOjyHWJ/k1+5MIvaE3gneaqGKVKv9J/gjxsY+1zRRBNwNVrcekUmfZwM288RY
         ZVobtzXtO+gjuenTNWem+3YBgHAItdK8DjAr4AqQIt3GSL+ObY916mq1i2/E0M3UbYpw
         a5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628978; x=1787233778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=MOIUhJ1abJmfx7JThBxgtgfBayQFiAhb7e0Jbb/4AkEoJHyIIS5u15/4c72ZsV8HKG
         CVkIcqUeU/MbbL7AEh3UFhqyTDDzEQr3LJrSUsuBfG+qKtC187p1KKy4DnIngRAHrPBU
         DuIzX8v2qjnLQ3mnJehaikhIPPk8ehlKEHJJ9zlRHRVAnmuCt1211kCDUBVTRdaJ7HQt
         SxlKPDiEvcHfLRVIgFiL2eUtDq+X10FqZhguvqYDv0zG8jXkTGf4COB3hklz0FqAsIb/
         Qp3jeU1NrUIIa5LALwVLavKJsfupLi+zhUGv9TEIcTebEQsRmCEibeX286np9U6gUyAG
         +3OA==
X-Forwarded-Encrypted: i=1; AHgh+RpoiGY8Z4U2osmCVsQCoUdi1Hr2u8xnaHmANnRF9KfxAo5uLjPngp6CBzEP1H6vppy4RaBNLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDfK4g+YchEle4ojpl+sDOtg0/jdRuClFIK+l5pmS88Lb8BbQf
	/ep7lX46W+TXId3PLtqeLMvweDGzmLQmTonTiXwKzP8ocGfOI+W7TbQHhQaluFVP9U4=
X-Gm-Gg: AR+sD13BdaTnbeFQbmqb5VS2CtS0jy2XEPS/7GlMPAn5JMTu/Mjl62nBq5q4XUOgCvK
	8DUWimmCGY1nuxHkk2MnzhJMZzn/+7C4DzlYLnziF6aUBaC/aCTFkaCa5c47b8RR+/bHDuceNzu
	pAZuGmz8W9VEL3XwvpxQS3vXQ/cz+0V01rhrmhOQMniYPdd4ze6J1E9zPmUFP6/iifK4djaNIIQ
	HyN+3fkteYMeP7pPw3JTsVlcgTeNDpC34CBLSVaj5bZ/cjI+Y18Hj59Javw5FHdkepeD18+CrgA
	LF5aKHkl/ofxGxBm6jVcHMPIBhh6t7Xanmi1jBbJWdAQYfdR2g2iIzn1F/eif+3gMiCg/R0sAM/
	5wzueJTGK1whB0NYeDCK7anLx9/C08bbDJbPqcvUZns01ozAo9U/kGhcOI+5O3QbYlkreBZtTtH
	nDbvGXtVMGMn8k12obp7wNPiRIxsmCpioQUMUvSA==
X-Received: by 2002:a05:620a:1995:b0:936:bc78:791b with SMTP id af79cd13be357-936bf90b78cmr572103285a.15.1786628978075;
        Thu, 13 Aug 2026 06:49:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b12344sm150528085a.29.2026.08.13.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:49:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVoO-00000003nYa-1b6m;
	Thu, 13 Aug 2026 10:49:36 -0300
Date: Thu, 13 Aug 2026 10:49:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813134936.GM662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-5-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:20PM +0800, Yu Zhang wrote:

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);

Since attaching blocking does this and you set blocking as your
release domain, this is redundant.

The new flow looks alot better, removing the detach operation entirely
makes sense if the HV can support attach on attach

Jason
