Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7D2512C0
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198479; cv=none; b=r7bhDq5HhY/NYlk3hnw4/c1MLoTmnorVTs3P+EIzchc+Q18sRvQvdXb41p4Cx0R4bIvsd7RN9YDDxC0op1IpCYKENAg0vc8Ija6fGh5Qg5+KvZ28XBHcvHuCAlkIQrQmO3j9nluPO9uJqqrAA6VSUkCw+E2awbWGhOkYeoIARI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198479; c=relaxed/simple;
	bh=lDGktsrrvusw3EwyIKgqSW+1nB/A4uH5GaWgGqTDi+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPnxtFqFhVIXUq07gExGBZyDLhaLNB1vPkkMWbTJ/Ll4HOWefdBeLzZ3e+YQ99aa3AiqN19YE+48IQjXzYXIX/00KN/FXCCWu/KdbWX4ekS32/3lUA3B1z4F37/tNuSOP/pYCqiyrR5/5HP1XSqg7lc3pRBoOt8Ux6Oi0rn0WWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lkHt3tpm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lkHt3tpm"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3cf3afc2bso213348485a.0
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741198476; x=1741803276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=lkHt3tpmD+TAdBEfmIBfaC5WR0OvJDfub6RJY5MCvFlpuK6i6morjD0hY0CbhiZ0A+
         15Hc8suv9pDQdr0MoN8zeZuQY7jXSM+I+L/aRXaQPIPKkbRczYbs8zH1r507f6L7EpIK
         xlioC+EU1vzZqAo+G4HvSGdlt7SNNUTKH2txzfgygwSWJrOEi3HKZD+tCMVANEc6X/1C
         PBEBI9E8/VJge2MUMTmYd/YyQn5Y0e8ENwXiOOyUFRIUNS21Pll72usZvsciy+KOqddj
         lM+f6y7v8/q3fenCS6uS4SIS8I8tJOhQvZj1k6QlxIhJnWsHYtcajRB/yGnWGqfsLyYS
         BngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198476; x=1741803276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=kAVdEYI7eQyGhun9slg3aCr1/DfcIsZTrJlCJNJ1psAtCsMAwd3V4K2AsLv5RxUWoS
         xBpo4ZpPtkoIKG2J5qTakkiNTlrtcqltWDyK/+c5l80n+egWeMAhp+fCUj/pySrg1l1/
         Ntja5YToHW1/1xYDQ/6fVhV2RchbAz6BSsCo8uSBojGzl1IXZKk3oOCxywGvSXW7GZM4
         FsKODhHaSUK96zvtgTW0jzATneEJmS6Z+dQhHirsLEU1yTpg75HJWUp80q3sfNSJIEBV
         XCWxs6muR7JsSyzHpdZ7es0sywFEM6aBNhgYs7gCxk7CYgwmxUVaOLKpMQv415Ymr/FU
         wFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXudYzjbqbRPI18UrJKXswvykU4tCiIPtpfa0C5j3b607zdoQ7Jt+VbzrVSfYmdcUDKn/ZVSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYJpTjD8kDb8RWgd81bNkHORLZ6pZPFJDNKqbz/Jz3v/LW0Dcl
	W5VZx2Vu9v0WVPmPFqB2iUJENNMOtb1bQRVGg45tvR1Ahe1e5F9aIAWX12vpHP8=
X-Gm-Gg: ASbGncvDxtSWrpWWciR274PNH1H43GTg01YZq42NOtKcw6ff/GWVs3Pw8UiItOdKPq1
	ksHpJM3Eer+bkAOqT09jwt0HjyVFuXofSAnYENqRmRn1mpOLRewMsn1Ct4155iAN9kEaIzFnEbY
	bt+3yEenjiy/BE9bO5H4IjMV04Ge9kgKzpMgo2AkOtMxmJrFkg0zGvZj3psEbH3SPmH7XeDLjtP
	8kJLYhUB85DTQz88Gd8w0s49k9BzdMzUCFTfnR4OGv6banD/wawqVEmRpODLuae/1h/gMkTqXYw
	ATj90yD72zG16tennZI=
X-Google-Smtp-Source: AGHT+IGBXOlCQEjAXivcZONN7HD211rRxB+Amwcgf4SScDXv9d/J0SEM3NN6sEdvhUlnOiPXZLnHzQ==
X-Received: by 2002:a05:620a:2b44:b0:7c3:c077:fbf2 with SMTP id af79cd13be357-7c3d8ee8505mr677678685a.45.1741198476550;
        Wed, 05 Mar 2025 10:14:36 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da283sm81577696d6.111.2025.03.05.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:14:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptGN-00000001U2f-0a3P;
	Wed, 05 Mar 2025 14:14:35 -0400
Date: Wed, 5 Mar 2025 14:14:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 3/4] iommu: Keep dev->iommu state consistent
Message-ID: <20250305181435.GJ5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:32PM +0000, Robin Murphy wrote:
> @@ -127,6 +128,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		mutex_unlock(&iommu_probe_device_lock);
>  		return 0;
>  	}
> +	dev_iommu_present = dev->iommu;

I feel like this deserves a comment..

Maybe it is:

/*
 * If of_iommu_configure is called outside the iommu probe path
 * dev->iommu should be NULL and it needs to remain as NULL
 * If it is called within the probe path then the dev->iommu
 * was setup by iommu_init_device() and must not be changed.
 */

And I think the commit message should explain what consistent
means.. AFAICT you are going for !dev->iommu means no probe has
succeed / dev->iommu means a probe is ongoing in this call chain or
it has succeeded?

Otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
