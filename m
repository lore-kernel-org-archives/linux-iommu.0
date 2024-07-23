Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1444C97
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739810; cv=none; b=JEW2igcBCqf+eBtBQIp1dJeVRJhJwUpLMIapbGc1DuMZhDPACqjPttTYG76+XxFU4qeEuGWopcn32MWtGrAjRJ14OZDMCyZV0ZyWvfXY5EGH+wNlD7lD0iL+KhZ+WoYCi2H0ZbRsdfKZfVnPick583pa/Uk3OqRhrjJPLbUnaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739810; c=relaxed/simple;
	bh=D8+jbkXwAtyO3GjYouh0mfosiTK2S3DmtFxKi72njpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAUlsNKqGvvQ607SdS+SACE8c6VUKn++E+nyY0RVz04tez5Qi3ArUqgFkMNUjuMuspqE0J6hWnVhqrEovNBWCnbbA93XbVrYJcOp7DMmf2nL4PCjaeKPkQpxTfXgjjyPf0peDQybcdkaM35nDeMNBrby89F3ADKCw08Kx3hbBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c7xCL/h5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c7xCL/h5"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44c2c4ccb7aso39103231cf.1
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721739807; x=1722344607; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44OX+Twfo4X5VVnBAv9LEB3DxW5Rn7PIWjxY2sHLWvY=;
        b=c7xCL/h5Ami2tVVWeF+TpUQNgvMXsUyD9V1g7zxGfDYVig/P9fvPnXUSPgJWpC3dma
         1dVuWkLqmSHVANjhHyi+mBwAfnHrovj2tMYmdpkKuLS6aSXUp0J8rFWpm4Rd9jx2omfR
         IKByvYTTiqdcOKkwHFkKfth6dUwL5aAifY8nVDK0XzElP1H16nutLU28dRrpg7rp1srl
         Lt5h/FU6Jn57hHOaEwxV2Ut2oqvZUCQPwTbRrUD1+GfNUfnyIpFNo1YvT7rdumx1M5E5
         W/z5NHSFepeoOkxRD/bOYyV+Jpef3GYTHjY1opETHNs7Qa0rMCJV1xfcol1Keht1U4+g
         0D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739807; x=1722344607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44OX+Twfo4X5VVnBAv9LEB3DxW5Rn7PIWjxY2sHLWvY=;
        b=m4zJUbB2X6tVKcHK10UHUV7H2EYQTQxUo/R+7ILKQ5QDwq6sqK9hizp96KD5z61JHZ
         UXESfv5+C0YtEgr61pIA4oxa5PWleRaZeGZM6viCMYJcabhEmPKGqUbnQMwup2J1pG6J
         dQevhuVEcl6gF7bvQ2RJ9AqTpbjImV/+Aia1IU4I2TUI+Yqg0p7jZbfeKum7dSY5vlrF
         vhgfOIHALmZ/aERxg+TpATjQJ2BnhuVA0aP7SzlZvlSs2C0Atsee3iyOSj9GY4XwCWez
         eKdm3Rtk5Nxg09lRoYlkQe+zC5E2hJ15Bj9LQ5d8/p4CmWSImQdeCk9trS9BT1gt15MG
         +WRg==
X-Gm-Message-State: AOJu0YzvIIJKnR7G2BskZIVFTef2upXTLMVjUZ/xct7lBqzJB7q9W2Zv
	oNM1stWSjnaGwM12WnLIMymA5HmSBAAErBtY2Gx+SybZQpCOfRlcGEJccLIsnGM=
X-Google-Smtp-Source: AGHT+IGPKNyerRKJhIoclkJPu1oz4Szc8bzFByjAZPJ5qm2TKETgeVKXdyVBkgt+9xaq6mysls4dlw==
X-Received: by 2002:a05:622a:11d6:b0:447:dd66:8004 with SMTP id d75a77b69052e-44fc814b03emr34089421cf.27.1721739806745;
        Tue, 23 Jul 2024 06:03:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fb68ff9cfsm21516471cf.72.2024.07.23.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWFAr-003fqR-4L;
	Tue, 23 Jul 2024 10:03:25 -0300
Date: Tue, 23 Jul 2024 10:03:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Add blocked domain support
Message-ID: <20240723130325.GJ14050@ziepe.ca>
References: <20240722115452.5976-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722115452.5976-1-vasant.hegde@amd.com>

On Mon, Jul 22, 2024 at 11:54:52AM +0000, Vasant Hegde wrote:
> Create global blocked domain with attach device ops. It will clear the
> DTE so that all DMA from device will be aborted.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
