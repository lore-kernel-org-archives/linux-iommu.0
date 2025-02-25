Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F12698A8
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493704; cv=none; b=in9o1QRnpIFKnxNv+WdwiN7Y7yTbT20SI+LosvMLKBGOYHiTHFudyGeFYYobLaf99iJLzpWjp1cTQu0/qDsEVayXRs1XfMDlZSXYlNojphAellmX8rezm9W0wvfAKWVdTN3v1Fs4PnsiuJdtaycmNu0yQF09cJfgvIh6Ldwbz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493704; c=relaxed/simple;
	bh=DAMxjxR4lDwTzJ8bdStoqw7G2Z4W37EGQ/VGbx8mb48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/KaZ+J4k+DoaRXjDLlnfzLyTkY915zBib7C5DHmogH24D20ZyG+TQalAkSb85jHDkE0o3BiFNczQ8S6AlqlcCet6chYpCob8KgREKWsD3332AG7qzP2t7RnMBuqcjkdikQWVAw0akcQ4k3VbWE1gGehppaLhcmKnTE730n30Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j/6So0rh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j/6So0rh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471f4909650so52085411cf.2
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493702; x=1741098502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kOd2psR7BVzemYZrd0XIM48YnTgLxhjk+g6R6plfXA=;
        b=j/6So0rhZEnShKQXGFCx/N8dsclR02cyw0nTntnGowc2a0ruH57Z0hxjCeqBdj/tsV
         WfuzX5p9FzE8aF1GP+gNYpV/DQ7xXJCbSxwq52oZUKN156cT8yrRBCbCSIXZk4L6v3zz
         z2AcRWqaMlrb7/Fgto7ACV+ZalXe0xjNuCd7dotxNpuYf2TGBPBsslZsIRx90flrFEHY
         67aqIB5oYKOLZ37vj/A6GiUsHIiGA9NY9HMokPLUExFESNUrUZOlnFszpEAfymWbmCR4
         Q0GuQ+zO4EupFYzBdY4fswCgolqS+52/RpK+qpXv30CEMhqYm/y4ocOWDppxvNv9/jjw
         Nx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493702; x=1741098502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kOd2psR7BVzemYZrd0XIM48YnTgLxhjk+g6R6plfXA=;
        b=CtJ1OB6vqRe93ZApejhcgoWC3mVV8YvpcU1ic4U+q+GJDt2BGVwOEDLuH6Ckp3Xmxc
         RVz1nbmx4+ZAVIrNdAoCfCkEvX2zvyBDmWfFyB4jWN25bH3sjESompj/jtds5BpKDQZs
         TrCW+OMHpAjqbbYVK3ff/mMaAQU2mn6pX2tDUdJVKKUNRdh5JBHwy/wxxkuhba0bCbxb
         wjJyExujXXcBywD8nQO9wLOsZhMALpOxvx9SOtMqtElrZqlrGta0mDuXFrNVaRHTfAh2
         U3zNlbBWz3xhkCpBrXauhvhAHolJI2MHvOXoSreRapBkU3SWVuZvhm1fNx6qqUbwkzzS
         cMHA==
X-Gm-Message-State: AOJu0YwcO20cgFXaNUmNHdsB6Sv6B2b2ThuJhR1X9A0OJyG26AjGop4K
	ry+fZQL3PVZF4P9tii11v8+8oDIqjIkHyRMfzoCVZTKG9nWlBrLCbR/9ABO24mg=
X-Gm-Gg: ASbGnctpbA/ba6mVivjR4BpKJGyfnNGcJITg0eC8Qmhpr4S4UnfHhBzDarEDcLYX03s
	GGweypCAz+2ZN7TQMRqrKJcP9q71K74hIHFlvizYmfz28o4Ha3G+zfkjNRRXymmtMkjmvFiP0gf
	rDMHDU5tA6ASB1+74mJP6tEqnQWkS7f35CpWPgcv85scWRxlNw+9zlOx5hFTFiJZ03TbL2TJqLj
	nlOAkJEJiqOpO5Ol3w2PsfjvsNWGcnOFRTlnYM0uH/2MZ8oDHjtmPJzls3uH5OS0tXgEG3tMogZ
X-Google-Smtp-Source: AGHT+IG92TUa/ffu7lBHqe3LxdPf/rvMRP7IFFbE0vtpnqqqKpyqT/1LbPqjU2ZrEKaRClQRMHzMZw==
X-Received: by 2002:ac8:7c4d:0:b0:472:133f:93b9 with SMTP id d75a77b69052e-4737726e082mr52942341cf.43.1740493702168;
        Tue, 25 Feb 2025 06:28:22 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e15a7fsm10578071cf.29.2025.02.25.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:28:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvv3-00000002T5E-08Ml;
	Tue, 25 Feb 2025 10:28:21 -0400
Date: Tue, 25 Feb 2025 10:28:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 6/7] iommu/amd: Remove unused forward declaration
Message-ID: <20250225142821.GH545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-7-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:44AM +0000, Vasant Hegde wrote:
> Remove unused forward declaration.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
