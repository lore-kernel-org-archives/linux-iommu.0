Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54C126C18
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493627; cv=none; b=bxKxmou+PXif62r437CXDGExRcStkRiD4pTZZto0BdReqCOBNTlPs+0LX2fcs01wgFdZt7GDzY9oRCHctwUIuj5hyj+N88Wox7kzX5HCywB4YQdUXmZUMpFGaEcDQBQMVbOMmFA3QWW8JPsMhvlk6c0bLic1/meAMfuItkvXdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493627; c=relaxed/simple;
	bh=825IBQXaPsW4auvVHz3V22jW7hDnJEolNxletaCLQx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMIRcaA3242mUP8r18Pa4WC/vgCTnEJVBBIP0C9ag0Z0+am+QSdv2lJoiRXu9ZJVROGuSsI31MgBS5zJxvAzMvnNQgg5Bov+KD/q8ggJ5RCmp2Vsuog9wTrKb51dVkSTUVFaU0qffdP16epEO6TaV9YZDGMsEBsAnKDFAOsJH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=arUy0CKJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="arUy0CKJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e670d29644so43514456d6.3
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493625; x=1741098425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bopp4D5UPsMhH66SspnmoKpv0er9o9jeCpKMs0YQZ+8=;
        b=arUy0CKJfgWXQ1KsbAgYgFNITpKs/unrJcr9sB6P7m2sQsrnTAv9MbkWsF4kmlDFpa
         ottE6G+FG7Mc891oe5sScFk0Zr947t78Ku+pFxvlnk0jA3KRaeq+HamNp2CmuHfDhwnn
         HEur981bKGD6TUkjNPHDTVO/ZegQg/ggRUAvbhHBayaCmNaDD7FnW0crJIPB4A7jQjLQ
         NsIf6pQ4HxHihF3GZgTpg68ZU8NQcjYGl22t9LVK2W0XnM61GNB9n6jSwZfqopUCv7Iw
         dftFEHLM069dGHPptH7SPsobnhuRnkd/HLHx1TDSqehaNl0Py64WfqKqOIIR0sOsac/T
         i9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493625; x=1741098425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bopp4D5UPsMhH66SspnmoKpv0er9o9jeCpKMs0YQZ+8=;
        b=K+osLVkkljrDT8Ulh4tFBNyJlFVu9+nAop1HHwimEzTZpwV5Qbj3fGCrUu3ORz7yvw
         CxpBeiYNIK81VC0K3JwWkG7jlIfaFeF476NFkos7F742J09MZ7jANJCImtPj6P6/Lga/
         28p7pcmmq2V+Dyrl9IYjO29/BtMHuJMIHBh4jBcHe8RiL6ZsVZ5xNpz4ksyvlCgIan7U
         gmtaTQxnjvd5fDOlR7xDTjfnwieEBnvOMZcgkT1ckQp8E8uql91aDCqYo4lcgrjuwh/5
         C5nT1f7SN2tdZJayKhynk4Z77Js+VleNHh7Iko09OK7nBsFmT6UPJK7+Xs0Ks/tDDXH6
         sOHw==
X-Gm-Message-State: AOJu0YxUDLOv6OEwFa4bayiPJyF+/QdqMp00Nvde5dpOE+r5/L53YmhP
	zvwXUEIZQCBV/fG+56Ergy51giyZrRBPmBY1R2/tBPCIdkLn/yliJSvqjUV7kr4=
X-Gm-Gg: ASbGncsygVKSSvBwUDtnhu11AMi0rdjhe6jvDkN3qG9u3JNG54EZlcC6l2/ht7X7feW
	f4PXR/9rLPwLMFZcDjLhso64GqQYN0cVXTCbwiv8znmv4MmmmFtVeS5alUmvHMIdDFsiC3Xtbf3
	pVDN6ok+TpB9nwXTIVZzdHLJCfSzq2589zFJduJdG26jJMbn8XsGLj4CwywYZA6rAtQLoQ+qVso
	0f7GWkoC5otVThc+iH+whBr5f8/M4Og/zXFTq22oj+rbxn2qSAVM1zmVgYkZ0VfpVibOBY5Oydo
X-Google-Smtp-Source: AGHT+IFChZnRI0Naqy1KrWuoiJMN0c8Nq80OAm3g9K9jTQn2U4j0Xym4T3KI6AMxyRq8UZ60EWZ+eQ==
X-Received: by 2002:a05:6214:e8b:b0:6e6:5e97:81f5 with SMTP id 6a1803df08f44-6e6b002fb04mr194441386d6.3.1740493624843;
        Tue, 25 Feb 2025 06:27:04 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b173b36sm9681776d6.96.2025.02.25.06.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:27:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvtn-00000002T3h-3Hhb;
	Tue, 25 Feb 2025 10:27:03 -0400
Date: Tue, 25 Feb 2025 10:27:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 3/7] iommu/amd/pgtbl_v2: Improve error handling
Message-ID: <20250225142703.GE545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-4-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:41AM +0000, Vasant Hegde wrote:
> Return -ENOMEM if v2_alloc_pte() fails to allocate memory.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
