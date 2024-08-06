Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB3481B7
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964360; cv=none; b=B5soZOaKykF1qfZ2PCX8hQ88ay/b2RZLtmP9xl1mNbgUdlUaGQFlukN4HsYa7CzlQrrHeSrZnwJcqFU0FG2WLiJOjqebMTGqmzUtSAqJF+Fc+orT78UivBklN/s3c9/aCyYLzaCm3dEUjx7kqSCpkxx644+O/YOo535RjPz1E1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964360; c=relaxed/simple;
	bh=Y4nXGQdMNF6rbUeYoiFqwWpEYmk4MMZ0QkxtYpu0YYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpx7HMmKcyCxUe9JBbFw3wd5sZj9CQ5eDSj+TD8XVaV7MB9cyxN//GeThImK/OOFUR2mwLB445coGZswVOFVHrSprpzibFTba+FO8O5rpD2XyeO3lK4xOHOEeOMVUviCJZ7nkVv/EVk8PWekOxIZywzJ9OH2y0Kg9HoSXap37bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S/cyT8K6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S/cyT8K6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d42da3f7so47254785a.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964357; x=1723569157; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Paa1t7vb4Zh9PUcYQZ9rYJjYjP4JtD2ssWrDQwkK7e0=;
        b=S/cyT8K6sXeavMcxO5dvFMYDFQXipczH9vnRAx++yf2CivyiG8MxZSR3k5sA9z9S3f
         BM9YA72iObnB1SIULJSYMCQQr0SJV4c1VM9vik8ke7/YfDyrN8IFM30woQOzKdD5UKz/
         RCzMQtEdzr2baKQRE6DdBal3vH3boFKUjYF21oGbaOmvZP2FmA1btEbMovKcOM0Ig99v
         kxZlL+S10otI+RV8yDIf59ZFLn61eV0w3fp+Phe9XaGcg8kOwouCs07Xv0M+G5l9VgBA
         /nLz6AtSS0KGl+biNgMmnww3bTpkXheRNCLtk0GtDG5IRR3zRaogg+4mJ+RpmFjEJaWJ
         AM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964357; x=1723569157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Paa1t7vb4Zh9PUcYQZ9rYJjYjP4JtD2ssWrDQwkK7e0=;
        b=I/ZJDx7a9lkaiqZg3t9xsYaqxmUSK7cn8vZjze6/k8J+4VxopAvMf2xAt/MDl3OJtb
         1XznbIGvfK3rdoHGgs5G5QJhVja9nO3Uiuva66eEivo6uuruYRVLAp0ABbvqF+PGk+X7
         55oydQ/Fl0Or1po7ZXQgwNEqzWrwhORYn56XmaWGsjYob7uBCZlNOH39LwKZm8WJoQFR
         hPmTlZ3N+Qh75mw1AA3xkWV11YWCf3q/NqUvXQnI1wtierLxHdzK9jKdWFclj/LfkW6r
         I9CI6jfHn9gsuCY+Eo0c9tfX5OZqT4JNvilvTs8GTfkVjSwkiwsWRCEKo8U0CGUoaJND
         /lGg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ca2X/zMYG05MbFD80WWnsyU30efsCsgZ2nP5ySU4QdkyGwKo630PcHU92C5e/UkJ4TqaijgRO1KTdjYtymthLroPVjI=
X-Gm-Message-State: AOJu0YwM5xh0XG4mzmSdK6E8s3yWCq63SNuS+f/Q+mu50ILAnqfe1qw7
	hSkjOtG9rnsgD4DUaxRVzZPbqVV5zfXXFa31pDE6/A/60dF2AG0F6Nci/sCrv58=
X-Google-Smtp-Source: AGHT+IE8W/7y4vs2RWEbhcbYMz+tVGwlO0vYOQAKxa5Dr1b8PGGexDfdO4ikD43yBmWeqI/PWBKLXg==
X-Received: by 2002:a05:620a:46a5:b0:79f:750:e5df with SMTP id af79cd13be357-7a34efeb529mr2013422685a.66.1722964357411;
        Tue, 06 Aug 2024 10:12:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f787aa6sm471273085a.103.2024.08.06.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:12:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNjg-00FVPA-EV;
	Tue, 06 Aug 2024 14:12:36 -0300
Date: Tue, 6 Aug 2024 14:12:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
Message-ID: <20240806171236.GM676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-5-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c019fb3b3e78..f37c8c3cba3c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
>  	bool has_iotlb_device = false;
>  	unsigned long flags;
>  
> +	if (!domain)
> +		return;
> +

This seems really strange, maybe wrong..

The only callers that could take advantage are
iommu_enable_pci_caps()/iommu_disable_pci_caps()

But if they are mucking with ATS then the ATC flushes should not be
done wrong!

So I looked at this and, uh, who even reads domain->has_iotlb_device ?

So I'd just delete  domain->has_iotlb_device and domain_update_iotlb()
as well.

Jason
