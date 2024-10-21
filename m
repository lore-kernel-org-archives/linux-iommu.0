Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE491E5707
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514780; cv=none; b=ekAMulDCcZychDbhvzWivyHPEoUe9vp2ztp1KjywibOBULv13xPY/dEEZkLbXKJeaSAiTD0FrtfzZF6g3MlwznsJwZIC37ZuqYOc7VH6RR/NcjK/7yrhKLuXh26VVM8PRloXn/XqNnIWxbaKVNwm9QBBIvRlGl5K78iH4CEtrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514780; c=relaxed/simple;
	bh=hxvBJwRtNcqjde4Bcp10tSx/EP4OtbCrC1TrsZa7yoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjz3fPIYowZpYsTDbtOSGi7OZpwi4dbO4TD6h+9/TKOcbXFVyXYlNB962DypJXgH4+T5KG/fucH/HfQQdDIlI2/FTm9rkbZfD2KjTnwKxzD+jxthQwAniQAnVwcjUw5v2ksBmhclcOhYYqnSNOGuzKivAhWnGxWHXyRmwIp/8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aJHCDfO9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aJHCDfO9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a23ad00eso32161031cf.0
        for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729514777; x=1730119577; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KqBamHNwRSuVXvDqMa2+Op5Y2T6BUr3qtbGShSkry0=;
        b=aJHCDfO9ifAMqUr8QRvRl0ocuM1V0oulzjAWFJbVjPROZSkPZSyYKu45ypFcp8ws4T
         J9cIRiEcXWYaeX7QdwCXEDtHoQNCXGWefHkzXUzZD2uA6Vs+hDnjOBpxKCXXnrabaPrw
         ZXiYkjgou0mJfvZV3GZJ27DmSUKDl3ivXa1vyT1LyUWUg3MNgBXjhtdeCWhcWzjxYSzE
         jonL6zLvqh9+YdD2hy/ByzLE/oMX2sh3HmVMTIAUYsGCBT4jzAYCP5fEPtnRH1VHOj0C
         r6avQmigMW24wcxauRNET2aixND49BJTyiWdWDGpaCaM45bpcN0zMBjEMN5KnEZQwnsI
         Qt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514777; x=1730119577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KqBamHNwRSuVXvDqMa2+Op5Y2T6BUr3qtbGShSkry0=;
        b=KUaJnU1Pfyasb0V3WFRaOoyjcfHnpbrW+l0qR/B8UbSr/Dk1HKNcVfZhcFoLGz7yCQ
         oq6412UzpLgEBdDa6sd2rvFcMSFS9wRZomzhYFfCTOJAYmb9ZH3ZtlpAkrfIg8Nmu48I
         ggwzBuj8QGcUmv34RdGpcncPeFAWTu+EA8oR9VACtSrIzKVQL/JRJGndClFmSEexvbDq
         VyiOugEEfmGlWbk2Ifhw396lwisx5ZK82N3RUdPL7Cz3SPR+h4NU8P13auDcI2mirSiy
         hyMJlhATvBexFbg+xcBr0bkshS7JTiuk68iX8g/inouHhwk7lptSzM1hzjC3GiPgbD3s
         7WLw==
X-Gm-Message-State: AOJu0YwaCAhx8LQWByWSkNp/iqIuRC3ogmy7WNRVOVLMLYTNQB7nqaPB
	Mtp6I0VZuGNQlWblcAOln4JyfYZ1+/v5u16mNa3sgp00yBqt40G7kylZdMdWkms=
X-Google-Smtp-Source: AGHT+IEsct49HXAHsyxWnzioIo0Yw00GAMYfsud2aC0qPqa90PVNt1yTAnv4Mb9qPAFxVF2WWW1q2w==
X-Received: by 2002:a05:622a:10:b0:458:611b:ac34 with SMTP id d75a77b69052e-460aee9d875mr170497221cf.12.1729514777208;
        Mon, 21 Oct 2024 05:46:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c95aafsm17271251cf.40.2024.10.21.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:46:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2rnb-008HgB-Pw;
	Mon, 21 Oct 2024 09:46:15 -0300
Date: Mon, 21 Oct 2024 09:46:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Enhance compatibility check for
 paging domain attach
Message-ID: <20241021124615.GC3576661@ziepe.ca>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
 <20241021085125.192333-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021085125.192333-4-baolu.lu@linux.intel.com>

On Mon, Oct 21, 2024 at 04:51:20PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 433c58944401..96016bc40f94 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>  	 * The s2_domain will be used in nested translation, hence needs
>  	 * to ensure the s2_domain is compatible with this IOMMU.
>  	 */
> -	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> +	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
>  	if (ret) {
>  		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
>  		return ret;

This dev_err shouldn't be here, this path would be userspace
triggerable.

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
