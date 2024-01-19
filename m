Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4021E520
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690806; cv=none; b=Fw43dhJjCPy5MSD9Szc69I4VVJETC0UO8+OaiI25y+kyd1IgFf8ZBM6SRBPigoloRnz7E5XXnD1kcNl0pdpokhqk+SP9D308giJ9DeLNnehIPNaoe6ni2ywmpy+q7JFOJ9Jh7m97zkcJngdPJv0zxcoMZPeA+SCudQhflownrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690806; c=relaxed/simple;
	bh=LDZaHWUxu9wGlkO0R+r41UFE1VsCqtyczIBGdbDKt2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQB113k3nSWhlLxPkSE/KQ24mLtZeYr3DA3QewQ1+h37TMUJETDiXB+1ZJaYZAzesmzBP64Obwwqs31W/3bMxBpOHrdLbyRkpuQAOAsm8QtLrsxLODhpnWo5L/ZudMFCsY8Be1/ml5eaKC1QVglNR+UHCzJHgvcI7dqK1AyWt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KK1HPnVN; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KK1HPnVN"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-595b3644acbso1019215eaf.1
        for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705690803; x=1706295603; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RlRcJVF4lP5Gv+WOK2n3oVk3a83J/9exE6JhdOdjvk=;
        b=KK1HPnVNZu6TJcIw1BX5A4Zfde4NVHPaqw+2edkrHZ3hDoGsIMq95AWP3moYFymjUi
         eOJe4ZeHypJ/5lCrb9nWzbyT+3B8mYtRqVK9CvHlaxkAizkdsyac1BQLVEkqm64kAMr/
         BbIR6874+cE11yo5zsn/+oZRtwy5dilRg81LFSnshPc9yCYDG9RZ6zqLIx9+GeyLQVHM
         C57sSmxTFPg6k3wFhGmC4Ba2tA3KT+mDHTVSp2nwaF+RnOvJprfccwnko4bP42Nh8h1K
         mpsWib7q7RRHvtSFKjxlyZXZ7ss4QA4P6tvcMb5sLJUYnuRVgsFlI4Bjjdk0ZnD4qKKq
         imdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705690803; x=1706295603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RlRcJVF4lP5Gv+WOK2n3oVk3a83J/9exE6JhdOdjvk=;
        b=WNalgskzrIqswVjmRs+XRIyo9nH9X1jsWnWOUDDZ6WxSjDoJ5owfNwzcE0BSSzvVqz
         yDqjiONoXblQyilSrcQ5IfHfucx5vUYEnUQPn1gBCf6q58uOEBG737K1gJle7dKf/j6m
         kJwRawTSpPIWmy2C3eDXY8KNMenhZXNmCrwXmHeSQFV10kh99iJawcsHHGjMcovsjxq1
         DSUYqswHJMPkzxyrNbqAvoJQyqBPJR2s+Fwv68IEpigAt46ZfWnoFe/QUsT3qGuhL/1C
         4EZBTFOjX3BV98Hu++vkkNXLAdRX5EVI2vv3x6QKDe3IAiKN60/lFTdP2iFhMBoOgu4i
         9wYw==
X-Gm-Message-State: AOJu0YzthlhfMc+8N7TU8LkiluZ/73VMIuM4YEAwZeZYD8GuqsR3ityw
	EpNU5QXeyLVyJGI0c89GdymgPDcLpby2mhzIA/yPhMU2Zl6RS2OWuQ0U+pXxCj0=
X-Google-Smtp-Source: AGHT+IGKx2SGv7+xtGld34OApYQgcXtT+La+l6oPlUYLk0BfuMemAuodVzarVtuE+NfkNyriaY2sRg==
X-Received: by 2002:a05:6870:218f:b0:203:cf95:f1dd with SMTP id l15-20020a056870218f00b00203cf95f1ddmr639963oae.32.1705690803184;
        Fri, 19 Jan 2024 11:00:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gh19-20020a0568703b1300b00210eea02ca4sm173061oab.30.2024.01.19.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:00:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQu5x-005lW5-3G;
	Fri, 19 Jan 2024 15:00:01 -0400
Date: Fri, 19 Jan 2024 15:00:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 03/17] iommu/amd: Introduce get_amd_iommu_from_dev()
Message-ID: <20240119190001.GK50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116165335.6043-4-vasant.hegde@amd.com>

On Tue, Jan 16, 2024 at 04:53:21PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Introduce get_amd_iommu_from_dev() and get_amd_iommu_from_dev_data().
> And replace rlookup_amd_iommu() with the new helper function where
> applicable to avoid unnecessary loop to look up struct amd_iommu from
> struct device.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 15 ++++++++++
>  drivers/iommu/amd/iommu.c     | 54 +++++++++--------------------------
>  include/linux/iommu.h         | 16 +++++++++++
>  3 files changed, 44 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
