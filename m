Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D07F
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598941; cv=none; b=H4LCkDrWLkV3+sZnNomm2qgz1SZ0GdToTg7BOe0B/rj9V8nR4T4qxfogndmeCvKljYqpsAAz7on/KqMT1UskPbRj++TBuz68tg+o5uy7p9IsekJZO+3UfcnVq5A1QGvDrViH7jeScPkj1ikIJ0cEWHwthVT3ajEyf2w8Hz9lARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598941; c=relaxed/simple;
	bh=zZMtkqW21w1CO6J3dM2WMM/75Z140feRSQpger9tjVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBNMiH7CzMaLCIqQ+Gjf02QHkgXVh87kVMXm5KFrEnRbVm5UNh98SIkQs8t8AzGDQFw8R6FvL3SxIpfNfnE9Oo9MIgZfjLfIRrIWBXuLUvwcGjE+q77SGgLuVRWzKc7fzfiWmpHii2gB+pQcveBip4XVpQdmOJpm3RgC75OzEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hsStd9Ff; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hsStd9Ff"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69032f12786so10110736d6.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709598939; x=1710203739; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xW+sWw6/BBn7RHUVIgf13UEYFG61N4RHRfETywDqNgw=;
        b=hsStd9FfTaHhOqKv1xaAUhrFQEJdTwLIQlOUDv46H0SuZifXFUOuxkt68uQCuKlPfx
         rUMNkeEiwThzitFdy/jRoClHzQrVBzzd+WavMVOxIfQHS3SCfSfAoyKY82+ARbyam2rF
         6oCKskFHZ5tyYRPd7Tx3efqwdgzinuUnrMnkSI4/jyr841+pPh+3y4Az7BsslqhJ8ye8
         alpo+YX4AlagcsmgUq7rJ5DPUSOmNB/7tiOSyWYqVrvUWrEhInCkuWQt1uApz4ZvNBFk
         cJ78eGd9cUrL3E9281FxY87KPkZQ3fNTkO7YcGDHGag7wPY2FrVUx0H8veGFFCbF3s/M
         U45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598939; x=1710203739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW+sWw6/BBn7RHUVIgf13UEYFG61N4RHRfETywDqNgw=;
        b=XbILZ3/iY31RPvwuH1d1hLQzBcUsFU2r167Uw3eRcK2AmnNDtyNkQV6rYW69d5iOYR
         Jmn/zzZn62GR62qWtOAL83GvF7uL95fs5PxGNsaUBf7sf0Y7ZMlinPV/+utP1+LfujBX
         O5H4Kp40/EyECVFaRl1kVB5pvlERB7frKm82jpxyKM4/UnHjwGz524boNWL2JcO6vFlH
         ssRcHkUqxNjHj90jb3jQSbivZAlJQJbmtM1o7zHb5V4utOG39QzJ+97Ze41rv56sYsnx
         j2gddw4X3w554eDFSr3p0tS275nMIETtTiH6UewhbRk/6+10paJ9KFxdObPp1qwCu2fM
         /+nQ==
X-Gm-Message-State: AOJu0YwcXKF2I41dQQTpTdNHzXOFoL5ATQpwlhDYTM4WpzwcHjjHdlmc
	O2qCAYHVpWk1apbgKKrM/aFcPA6mfXkZbkDW2HNm275in+WM2rEYEWQPf14wild6lWRy2Vx8xq3
	KbH4=
X-Google-Smtp-Source: AGHT+IHsTKfychHRx1U/Nub0ET59A9gHgT0BRIBVEDCDXEQDE/loIWUx2WdjoYaZeDaARnmlBm/W1w==
X-Received: by 2002:a0c:f889:0:b0:68f:6df2:3b60 with SMTP id u9-20020a0cf889000000b0068f6df23b60mr522416qvn.20.1709598939119;
        Mon, 04 Mar 2024 16:35:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mu18-20020a056214329200b0068fddcdc381sm5715500qvb.18.2024.03.04.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:35:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhImQ-00DYlU-7j;
	Mon, 04 Mar 2024 20:35:38 -0400
Date: Mon, 4 Mar 2024 20:35:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 10/15] iommu/amd: Add support for page response
Message-ID: <20240305003538.GE9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-11-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:25AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
> with the specified PRI Response Code.
> 
> Also update amd_iommu_complete_ppr() to accept 'struct device' instead
> of pdev as it just need device reference.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 5 +++--
>  drivers/iommu/amd/iommu.c     | 8 ++++----
>  drivers/iommu/amd/ppr.c       | 6 ++++++
>  3 files changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
