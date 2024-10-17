Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B51DE2A6
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170873; cv=none; b=eaeEevkIjh15ZyEsMhf5Dn8dnbXzjmPaSviqvssAMMWYkYvsIPKE2ACLB06z8BbUGDyMPs++DxNdKus5hlEBq8BDUTPmqYEOwuf0VXLJK+K+e/zQ7xcjcPmfXC5li8dHyeM7hdx4WtWZndMbKWCuDlsIKkNPlEbuiEx5gUOVMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170873; c=relaxed/simple;
	bh=Wb6mSCDijxwZZWauFZGQf+BVgvzmCTUi82g975TaZ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzhHDMzX8vnWXcxTMwwK+5DaXhOc3boId3KnjH8pFYONy6IbU0VFScly5HCoK5QyQXJyM9SlrsP+JZmM2jZnvb+D147KYgRDUUudz20Lcdug/IYjgo+RwRtcDTMIVjZgjN9hbbJ97ViYnRe9KkByPmJOXMKbbPMU0GFwrNscRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UMxJhvCn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UMxJhvCn"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46098928354so7641531cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170869; x=1729775669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLDg8RvvLlEJQ66RvmtnlxLwzKS6+SGm4HKfXjEXnyE=;
        b=UMxJhvCn9DpvoiuKMRr4g2KE3dlqa9jve8nkf8MXQ1aQoQgj6MbPiyk79l5oWYZU+S
         /GKpaRDBw+S2u/GtTN9rpPdLTwx+4ROPAfO5dJ0Aiu8gwsR8y1kuOQkK9TdLh4UHTCFJ
         J8jyEfWIHs3/P096D4eILgWMINqDgI34Vd2B0+5m+nm6wIlX7GDZCedaHfAOonTwqX7G
         4Fr40uNGSjxpx8pE6rbVPbJucufxpuxNnTAA7kIryFzjJbkxpDmB02AWo3BTg4U+/RVh
         JHtPPC8JibO0MQg8iMwzRZOWfsObyM/RXAFkHGMmOIeeip0GYRCWt3A+MSGDXfX4f1hq
         QiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170869; x=1729775669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLDg8RvvLlEJQ66RvmtnlxLwzKS6+SGm4HKfXjEXnyE=;
        b=FN+gFiWish9zu/0uew5BE2P9UV90e2m6GFYgPqZsLk0X9l/6WRAQNBf4GsaiXsdwct
         IJTNwPY/I1XOGRi+ScOPBcmKiM126jwsxGOuMPE4VzAz5BheQlQrJcGnvJfXDpXIg4G3
         l2FbrrgZPIPT7RtRd3Y6TTq0iBe4h5GHVI++H3QMbFpZp9shmbluYRzpkiaDDa14IqGr
         SBvxaSh0c3O2HLeFlAS9SI+ydOjZ7tnrjlZ7VHDSJuJEV7orNXztH8kSMnlWIcW7JPox
         u1O9PYmAsPQRJ9stiUYaxjZ5Kru6RPOCLcNP6yRjvOiNNCbMI75KMbJGjsvIdheFyvxI
         MK8w==
X-Gm-Message-State: AOJu0Ywj80+sVeiO41a3tHGV5gKMUXSn54XURzzL8JjbOf4SfKD69hmW
	MO4+ERUltKjZIvmQ0kIRxnEFo4aW8Deb2NGY69VSlT3L7WXLX5jF/KfAvJ++ksKEiFnrzfUwVFI
	A
X-Google-Smtp-Source: AGHT+IH7GBJPueLtQf/uXwFuwTAWlRP7JuzET6PX2Dak97TDksm06gTxJg6y1gV+fnfQFcQRjUpMqg==
X-Received: by 2002:a05:622a:22a5:b0:460:4ef4:6377 with SMTP id d75a77b69052e-460583e875fmr313251541cf.6.1729170869210;
        Thu, 17 Oct 2024 06:14:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b390ddasm27243061cf.94.2024.10.17.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:14:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QKh-003uSw-EN;
	Thu, 17 Oct 2024 10:14:27 -0300
Date: Thu, 17 Oct 2024 10:14:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 02/10] iommu/amd: Remove protection_domain.dev_cnt
 variable
Message-ID: <20241017131427.GL4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-3-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:53AM +0000, Vasant Hegde wrote:
> protection_domain->dev_list tracks list of attached devices to
> domain. We can use list_* functions on dev_list to get device count.
> Hence remove 'dev_cnt' variable.
> 
> No functional change intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 1 -
>  drivers/iommu/amd/iommu.c           | 7 +------
>  2 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
