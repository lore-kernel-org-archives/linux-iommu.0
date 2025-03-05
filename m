Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9BB13C67E
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199395; cv=none; b=lNl5HIOictMZiHPZ6n/3q0KdJrkyijTJ1PnMDnnhZzXQMriWso6x8Mft7shw8n8SGObAMtCGZlMG/BGqGPbkbkdJDIxG8xQlgnSpqM+xc6rU9th0Idgz6YvLYFR21OY/INsg+lVr9VGW3Qbx1uPqu2RBQhgSXIwXwtCWvQAu7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199395; c=relaxed/simple;
	bh=nWeEq/W6PPKApSNaVNKQBVQUITFMQtYzmgMiTvJfNEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIC7JI8/K1lb/g58ifxS6XnoU3UtOkNZuVEF79Fmhyz87uzuxM1SQiM1hTw7fOR/Ox1AqPL84XiGx60oqfLm1dXiY86sXXUTTDCD2n9JTbC/heHkk4tuNZjF6JVxMtspCIQFaKhk0NdiAqhzABx/WUSXbjFJ4ZOyhPd+U01Oik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F/fk4isd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F/fk4isd"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-474d11c7f1cso18870951cf.2
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741199393; x=1741804193; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ow2RHMrMzwGJ2rXgPNnaGC6CmMDEd/EhLg2+AS/qQa0=;
        b=F/fk4isdRtE4fe2kSITEoZ+vdm16smsKYtUHAoTKyuGYKvOgwcKJLYG0uyZzFkNDNd
         xO91DJqZ9dfpAiw3BZwUY6nmnBymlp99J78yJu4Lcr97mrOEdVmF0ZcIgk5NFvsWCepW
         cZffdGRuKAbBtPX0qi1QQU0ZFjDHINTxg+//k/IUPsLqkglcBHAHrdpXQhybCvgJ62HJ
         Q7WkysjXT1fmdqF38RJah/0S3cDmOkttqQE35n3/1+3t6+bggiOiZYFZYXa/zw4GlAwB
         eftiLiUMa553xG8hzYvBCMRFQ95d/11bAPyl+KQno7lSAuTGP89NSef7LqputJ2DvnvT
         LJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199393; x=1741804193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2RHMrMzwGJ2rXgPNnaGC6CmMDEd/EhLg2+AS/qQa0=;
        b=PJbCcY5GIg8rYOPE1MaDs94LKU/aNUf5toT/QGF/SH8iu1f0VGxcGLknAkvXl0tV/g
         oWlbVP578SBkcKmSOnFZ2od94PanJRDwBIe2H3q+0aGaPsF7Py11CJf+VxUs81LEG2tz
         z0KU9pA4gjVKlSftKt5m/Gjf5Gaz+oRiAZNJzdOLIyPZ93Kcjedn573QdkMExUakB/0m
         1xD+jZnUy6DiSq9xTvbw1hqfN1U5xPHIFnPghbeF6RMGEzYVG3LcOLHrHu92ZZWHJFlq
         EoGCuWb87Q/39DRYVyVEoRk5aHkIeT2eiHv+8n6RFuK0iJx+grjzzELvb+FTKST7e8nh
         lelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTlZw/laCtgy07ayZJr4xHAW/6oDf/dowhxOpQ3CHdiWI9RUVSrkcz9OlBLqnAo7t1qgoDPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywif3mw9TgR3A70YNDVb7N+eF0L8PYq537D7xP+UEaOzkAPWq4E
	jnVuj3lwZMEWWs2XGKWXjUAxuSjr0kZH2ulroOCHl3cSy/owH/CToj9+BQn/ha8=
X-Gm-Gg: ASbGncsVwhJAgAeKKEf3PuTQZZKiNJV5Vp1vpYvTGYoCaz12IOTN3XvAXSwfNnP5Gn7
	oZ2LRPWuS0uJsm8cKhZvl/OtVnCMj+y4zjsvlshdTKGRKUiP2iU95CpKkQsesm14Dv4PMdYmgaC
	LLM42/Pd/MNfWMFtZ4o9RtNSvLTGJe8GJeUwJSi5fV6nD3p1qO20K+/o7nqchXzg9W7OwsDcpIS
	e/OdbdUXZ07GMpTD/sCp0yURcLEYXcXUgaJ5lFCKRpugkh+k85nzw0QsyZm/PfHOinE635ESAaP
	Y43G83jD/as9uc41VkM=
X-Google-Smtp-Source: AGHT+IFsnlL54iYEsLAYoSSta5icqiZzmyiU2KUod6Ytom4/BEVwRNDkxuBHJRsDyr8KcDtnyCu60w==
X-Received: by 2002:a05:6214:21ac:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e8e6c1cd7dmr50312666d6.0.1741199393252;
        Wed, 05 Mar 2025 10:29:53 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b2fb20f0sm505715585a.107.2025.03.05.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:29:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptV9-00000001UC7-35PY;
	Wed, 05 Mar 2025 14:29:51 -0400
Date: Wed, 5 Mar 2025 14:29:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com
Subject: Re: [PATCH] iommu: Unexport iommu_fwspec_free()
Message-ID: <20250305182951.GL5011@ziepe.ca>
References: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>

On Thu, Feb 27, 2025 at 02:47:47PM +0000, Robin Murphy wrote:
> The drivers doing their own fwspec parsing have no need to call
> iommu_fwspec_free() since fwspecs were moved into dev_iommu, as
> returning an error from .probe_device will tear down the whole lot
> anyway. Move it into the private interface now that it only serves
> for of_iommu to clean up in an error case.
> 
> I have no idea what mtk_v1 was doing in effectively guaranteeing
> a NULL fwspec would be dereferenced if no "iommus" DT property was
> found, so add a check for that to at least make the code look sane.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  1 -
>  drivers/iommu/iommu-priv.h            |  2 ++
>  drivers/iommu/iommu.c                 |  1 -
>  drivers/iommu/mtk_iommu_v1.c          | 14 ++++----------
>  drivers/iommu/tegra-smmu.c            |  1 -
>  include/linux/iommu.h                 |  5 -----
>  6 files changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
