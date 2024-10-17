Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DF1DD548
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171224; cv=none; b=lUtqDz/Vcr2ki4nW00k3UDsxAFtZFHKtzPhX4snBG8isFbudngWI+PPAb7PM46SQwB4a2DbysgfiLqzn1GgLyERP87EwjZgx5qx8rjEYU/ejDLHjVYD9fAtcuoQVE/skUxcQJiX8Cx8NU3/jtw+BUdDVUyvVP6MtbJfJZ3i/v14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171224; c=relaxed/simple;
	bh=hp0vSAQBRpc+lxIHex6OzT/EzaZSHMes/DoqRlPnGfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkYfqTXKu9iO2A5nWern1nwCxa2cvvK0H1U62knMMz6RC8rIMj5k0ENCKFbvTSkmESxxYmpswkuJVo4bFWQX+Whr6T58HRSaGruyGVAwYWtrCv9ut2CYXc750pZSDWMt0S2a4yCewnZxqAzetthT7SAOpEoNvC3EeAq8v9AeFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QEfogx8E; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QEfogx8E"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbce16d151so4862666d6.2
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729171217; x=1729776017; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAnJMhZqNJbNK/RBqkf5Z0X7FQMRp1MNyH1Wf4TrHrA=;
        b=QEfogx8EOikRkX2NY+0MVQDx/nQ4TGnDYu4ChNkRP9dSQsZo34jub1/mgH5KG5DuDK
         ei1qcxHnvpult/7fl9gHQARdve2OAD/yYaNr8jyXvOLdaTzrD9u8UgN2fcrNRYjv3gLn
         m8RrHnOJUG1Mq+XXs34gGq7jt7VqLhKEUSV75p+pskYYmVPflMvtuokfj8r8RzDGOZkX
         byoYtMA/9/mc9w9V3mokptTqLizAMWBqozBiSFTAGoJmY1jd0yklj7b098hKDOgQqfOE
         sN8d80tniw7V5vM6ySoGfKO5w+cTk787y1qD+8oLPuH8gdCqM/vlUpxC4d74gxn1Hi3p
         DR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171217; x=1729776017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAnJMhZqNJbNK/RBqkf5Z0X7FQMRp1MNyH1Wf4TrHrA=;
        b=gid6dwMGRnfDJB625cE57KKBMTeoTYJwQlimAcynARdhbouzd+lV0wwLFCrTCUamGS
         jk0AargJ58YQlo7Ahb1VXCLX/eCCyMPIy3P8Il+eR9B7WShyxsJM4EV8gw6iRx+tOk2n
         8YcoOAfpVkLf0rfm3cSyBXsdUbLGhbmsKdBh/EIKeDkGklotNsY77QOGc+AosN2TYnu4
         KQlmxIs4JJZrpM/VBNwwwV8g10xsJ6t/4OYVzbrWQVsU5vVSIxVo72LYnO1AGSp9swvk
         UMIG5h6RmKuwRupn76vltQA3DMXDvQFmvsmvtgpYXJ84uFaWmmo5O4NhxDaitOiYLV0d
         5HGQ==
X-Gm-Message-State: AOJu0Yy8ETxMG9gObIg+AiUsyj33akieWEm1IqZmXVc4lC6aQyUg1TIL
	uGcJAD1eBElZUtSYjGvnkX2PtgrJZ+JwzgIEyg7Hik9AtFIPn1yChR7JYo7F9UQ=
X-Google-Smtp-Source: AGHT+IGhRM9cIaPunWGmFOvlbE7ch1lCSy5CWDAGST6o2jXJnWnvpg6s2ocY53UrSQHjpVBFjXAZuw==
X-Received: by 2002:a05:6214:3f82:b0:6c7:cd75:51fd with SMTP id 6a1803df08f44-6cc2b923aa5mr86626016d6.52.1729171217620;
        Thu, 17 Oct 2024 06:20:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f90dsm28348046d6.11.2024.10.17.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:20:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QQK-003vVj-MY;
	Thu, 17 Oct 2024 10:20:16 -0300
Date: Thu, 17 Oct 2024 10:20:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 04/10] iommu/amd: Remove unused amd_iommus variable
Message-ID: <20241017132016.GN4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-5-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:55AM +0000, Vasant Hegde wrote:
> protection_domain structure is updated to use xarray to track the IOMMUs
> attached to the domain. Now domain flush code is not using amd_iommus.
> Hence remove this unused variable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 ------
>  drivers/iommu/amd/init.c            | 6 ------
>  2 files changed, 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
