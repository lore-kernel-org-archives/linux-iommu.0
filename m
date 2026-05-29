Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C83DE423
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055619; cv=none; b=XsjXuzzlqaZYhucFxYzdE5rRoa+caXuiBFzKnNeWBJiQxxcKZRCoIJyX9mNCrV6NEYZzlloE8e30NzWsCLqAgQYygvgG1EOdpdJKZK7mpyTSpK+m1ymnlHM54cogNFd/Z2FGWlMp4kzspPDZyWJqx6dU5OlgVKH5+5FEVTZx+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055619; c=relaxed/simple;
	bh=G5xyrYCedBBiBjXLX9BpdfYmvPBNHuGbUEBN61ILOAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE7FwiEG4zqZp1cEXJ+81GrrUIYyHCAZN0B23DIzXZiaT9qN6Y8b4NIm0BWq4iqYNKOXVI6t8nSdb0VWMlFOc7oQv+MzO56MWiYdFUTODFyf8R30xFSUoMU9VQCdQzHOjhRqa4CHuL6S9yrMfb9oZe6aYIGy7x0FZcyrc0j85fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eItjbaSS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eItjbaSS"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so112863386d6.3
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780055618; x=1780660418; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdNhpYSdJLZFqMwO9tkYt495l1ZUqFPFFf63TsgVKd0=;
        b=eItjbaSSsIA0MnzmyPR00tpqUHWdzQK/74v9V0JBmoIdAYiUE6gbk7RKWmuTpchISr
         uMa604YGApCFYeVQkaQfEwbBDwdCr0BNMT/PqhZWs9L2om/mcBHzYw8+E19pK0F+M3rd
         k5RmktMGjE+vOOa7Oh5fxb0bjx3hute2Fr8hLEdF0+IaAdB++8KduWlRP57X2jYN76FI
         s9k4NiwdlJrzK1zu5r7o9gonEHyYMOhDGtsz5gAlDuiszEHQJ//Qf1euYZgoHQUxvDgE
         p4qrOFac/ZKBnOGroOr2TEN10c9nVijtvl0aMqe0hHnvBaufhG8tXMWsTK7k0eh9xWiu
         e8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780055618; x=1780660418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdNhpYSdJLZFqMwO9tkYt495l1ZUqFPFFf63TsgVKd0=;
        b=kpen7jhslzYwLkLq/FPHQKWa0X4sGyR4FiHTtSwxtlJ0sauxKS3Etvfb6jxNkbetq2
         jfYEHxigvI5vV6rxH2Jw0ifYayTnkTo5EVf0ZMfI+YZQPeRR09LJJVHDJHDV7vmapJ6u
         JTG8MeiyWQqz7pUOQk32sR5bS2cNGCRNIH0mdhnMlmO9E3AlyK+4bQyMgxWwt4G6wP3L
         N3LYzzwnMtnz7wDEe7EjOtX7OMeQUL4eZdfWXXlBOtC+Rdu/WiLXFKmLOkwc1EpKaxy7
         GOINN/McwhVto2495dqTAelrdY1roJKb1mqqYX8G6E1tWlw4kuPS1/H9AvFB9w/bP953
         utLQ==
X-Gm-Message-State: AOJu0YxEuaiEJSO2k+n/o9+KOtLeOgtg+v7anHHo0jj+4fF6PHIpL4D4
	3BkKUGkIQdYodVJLWCoD62D1pN5s3HmJ3/4DfB4xxISOejxWMjvwHNzmQQWyEjZaO2nJW1G729D
	DhbBD
X-Gm-Gg: Acq92OFsj0+MoO02gA8pdnWJTUuC2IP4q+1Ku2rgP15T/UsL7SVxkI0z5fRgQufLpaV
	nwttu9LMFSJJi2gOouxIkVxInFYxcb99JRi8gq1yvQbEPvwrTEbgvltR63WYPTP2h9HjZyOOzGv
	G4W6SPl1ZK+h+yDquY0Pcdj0YbPx5DBn97PAWFhTBV9H5tNS+PgRg7mZSctawgYdu61I83GJWgZ
	pqTttKy4wq8CJEa4TiDJpaMfPyTCexy7iqnjE2chnFeQ87w59DmWV4w24IoWMngKRSfAIFb/RJQ
	lqW1etrZXlohFjrxuDypr5hTovI0B7JoEHK7A1fk33KZgKD9oRYqQpoNM0Zwm0/4GZ5t2g0/ctg
	AWpuzYWgb1U7GkCOhoWB+1XUWkT9H5Nu5cJChVfi8zMPtCL7joBF2iW+M+iV9ujebq0kcZdqMbP
	wAZfx6bXgzEKqbtorm7OP2xggiWgMWVK6KDkcFEBIUO9dnVstU9pw6CERCqU0EKx4H+mCaqTbFP
	DJ9zCY5+vE1Vc7iB4RiMIsF9zI=
X-Received: by 2002:a05:6214:626:b0:8ba:ad10:97b with SMTP id 6a1803df08f44-8cce8035ea7mr28459056d6.41.1780055617749;
        Fri, 29 May 2026 04:53:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea245e56sm14706746d6.43.2026.05.29.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:53:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSvmR-00000000SVP-1Len;
	Fri, 29 May 2026 08:53:35 -0300
Date: Fri, 29 May 2026 08:53:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	nathanc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] iommu/tegra241-cmdqv: Skip CMD_SYNC flush during remove
Message-ID: <20260529115335.GS2487554@ziepe.ca>
References: <20260529091052.317102-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529091052.317102-1-skolothumtho@nvidia.com>

On Fri, May 29, 2026 at 10:10:52AM +0100, Shameer Kolothum wrote:

> @@ -789,6 +794,13 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
>  		container_of(smmu, struct tegra241_cmdqv, smmu);
>  	u16 idx;
>  
> +	/*
> +	 * tegra241_cmdqv_remove() is added to devres at the very beginning. So,
> +	 * at this point, devres has already freed the SMMU resources that this
> +	 * path must not access to avoid a UAF.
> +	 */
> +	cmdqv->removing = true;

Please don't add random bools to avoid devm bugs. Just don't use devm,
or maybe fix the devm ordering.. These ordering bugs are a well known
problem with using devm :(

Jason
