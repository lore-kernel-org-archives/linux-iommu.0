Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D1195B1A
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664240; cv=none; b=ZfliVFnkqwiKctX5r5xVl0Ah+jK7emItRlaIxG5Nph4Yt5YLDN32naL6bcCPxDjYzyMug12JbiEuLHuxoLv8Mz1irTLSOyH1urT1mf7ttAPpGqg1AJFjFozWUfJwTezufC+lh0D1RXW/mjRLwIUSeo7yEUNHOCrwVkUIvlekoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664240; c=relaxed/simple;
	bh=2Dt28Fwtz8IPz128aCTHRBpWzuAHFuoCTDFAVrA+BTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM+gqHCCYHvrzeb/PzwJDUHkGmdw5yn5OTORI1sZpSgtkTmEGBlaNnuqPowOklFrKrR/1erIBimLDFb/uiyjgldHWqnZrbjkXkXCvHzhs0iWxOteewHMJUxX9c2ZRsuNMWUAsk5d5qNGysv4GwSnDTgHrrVM875NFu3Ry5bBTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mlnPCbXU; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mlnPCbXU"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e7ff3c8bbcso1043780eaf.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664238; x=1729269038; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMYBZOfFBzfB3xbbGKRT2aXeTeXYa+qmBIc5mdM83Y=;
        b=mlnPCbXUftL7CqcLzCCXqJkb+uShqEVcDLvYjz/PWDevkksALDWQD+Cq40D80wEHT6
         76BHliTpHdiCw6CboMVkhBcM2UebLFTahGXl7P5eymt+hvpyqQ9CgiMbPMFGr5S2DDm6
         NPnh6yYRx4PfTHwc+kGvG+lkAvnIQdnY33Yr9GN4Z1b01XcPYFsmW5GFSggBRKenJUat
         OzInqXkvjpOfxn7qyDylxPf8lpeCawiZzswFYLIzIhEBcu93NcZCACtADx9W0Fq2z2OQ
         mOoK1M3RIWzkGRz/CV3k/PtguCemJcTDlkLT274X7nH/Ee1J/evrKd7fUFvEhqk/pYh1
         QXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664238; x=1729269038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HMYBZOfFBzfB3xbbGKRT2aXeTeXYa+qmBIc5mdM83Y=;
        b=vJusv3Z9Q6zN2cRJtMYKi1BiC2CaCNd2qpGif3YW7AR0Bmmp2gPsceF07ppMUL+AJB
         Pv9U6sBvv1J27I2RcVx9Nx24tr8zwSskoIngQ5Kt25v9zD91foWaMJs819RCnuNXuDK3
         hoklL43uBd0sPI5t65bBRP5QDPjlr0n+RBAovQwBbbahz+3XNSyojxUqSP0jE8yQXTCp
         1d1pLLvDYjDR8uP4c+IIScIPFexVwM94DoKSazmYqWWnm7Oa9W5d8eL9yO8RK69dxtlE
         ClOmtRt8y3hKmI6yns6zIH1u4CnsQp83w55GAu9ds/I9vELOJvrMPdOm1opdzfVWWGs5
         ZKfg==
X-Gm-Message-State: AOJu0YxBwzOsYtzA3lGSG99RuCOcjuc0LSqR6b+M5id1FNVRedLLrHuw
	BKivzLP1GKo+ggRLd9IMl346aC2KP2jy9BapACcgktmjP7dX4+JvZmY5eXsP3bU=
X-Google-Smtp-Source: AGHT+IHGT0DmoxFiFdtcfOeyfYi6NN5cYcuiaTlJxj6mXSXrbGwgzolCWN9AgIpKpOcs/zOIQVHqGg==
X-Received: by 2002:a05:6870:1706:b0:25e:1cdf:c604 with SMTP id 586e51a60fabf-288874761e1mr129847fac.31.1728664238001;
        Fri, 11 Oct 2024 09:30:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497acb3sm145223785a.120.2024.10.11.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:30:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIXE-007e6u-St;
	Fri, 11 Oct 2024 13:30:36 -0300
Date: Fri, 11 Oct 2024 13:30:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu/vt-d: Remove domain_update_iommu_superpage()
Message-ID: <20241011163036.GN762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-6-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:20PM +0800, Lu Baolu wrote:
> The requirement for consistent super page support across all the IOMMU
> hardware in the system has been removed. In the past, if a new IOMMU
> was hot-added and lacked consistent super page capability, the hot-add
> process would be aborted. However, with the updated attachment semantics,
> it is now permissible for the super page capability to vary among
> different IOMMU hardware units.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 39 +------------------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
