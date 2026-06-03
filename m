Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CB3112AD
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449427; cv=none; b=N4IZoJSWfg9A4uKNMm/t8yCB03uKkSQkAC0Uz4Bl4wiJq5zRwONHpZHblZmlltQH2v7wmauWjcm/C5ehi89Vf4JcS3LjwoYDYyaPJQBe87PI9GhU3wiixpBJySlgjrGJYH0MjY1fPYaROBMBGc2Zm+lsug+3sbGUM7qHM9rSJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449427; c=relaxed/simple;
	bh=AfeOHXoP4IMONW5uOULUF2nWpillreIFP9OwYK/o6Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6DlSj1D1ZXbn5XdarsShfuWMmwX18qQ4A5XTZHs839MSitjXs19uHaPl4yYFa0HCWgIJ7klds3a8lkiHt5zIKv4vzRo8kGMhVP/Df7DXO4hMHw2TItuWU47Q7OYM3JcRQD1oymLMOBdQS7ojLCQ7CjPcTKzyqTmuLDJ2WyzLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h4ReOcqe; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h4ReOcqe"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91550dda53cso456092885a.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449425; x=1781054225; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
        b=h4ReOcqewaCWRNxLzX78J+nDjuX8IbmfU1DIJns0iHHG30yXWyEY8iER61PhzkBw7h
         CaHWqnujeX9/7T+hGnwCt5tjMj50gZKyPIOacpgMqwVH4hXyLJ18Iy7w4GpraXLzQsAD
         QGtlx9fKOeEg86zdHT2GgV2qWcRoTjXnUSFmNh+3LCIN/8HQH8DCO9BGDfAr3/Whq0wD
         gGuJlk9Mn+6LmUvWAvyg0jcoc3IoSuOhWuhb3Kjcf0Pd2J46yNkXu0PTaMshvXAX8CGQ
         eA9+ECwWjLCL1XvG1f2T0nLUwN9pjsnG+FXRFmPrhygcmuKo/gL0ICw9mMPJFvZM5gtH
         vyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449425; x=1781054225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
        b=LDgXmVvewssYMZOgrJGuNTo3YqlBMTVTNRZcSbPVQVsrY0rqPACbZ5Vinoq5N0Fg6Z
         hdukLZPpmWmTnjdfojbNOBs0byKzzte1TlP/p5SONbfAoKQL4UVy4Qely3zoOrvdVwXZ
         aAoDjDijA6ekPl9DRotTI+uKOcK7B4ON+RL026Umv/i1uTxphnzu0ZsOkq2S4PCnv+we
         2TWtHepzdl5Rujg+IPV45YsqrJ0YlwU9mwPvXPBWQyt9U08mLzmiRCWPDZ+2y2Bp7A/E
         Bc15ARQEuKTxdLmI3/Ac7RVP3+2AmiAFsg6jcIJPydtl4WReNdJG4aaR8p0HFYuV60fF
         qQdw==
X-Forwarded-Encrypted: i=1; AFNElJ+bsqDcNUkAyLic2JsJg39G+vTWJRamsdag6nUEvU4CeHaL1wW0S00vYcGJ77fuswV4nORNPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOj9Azm+/uyapElyjiPkVLPwgCqb+6t9USTfwtHMvj95JsaUIy
	E3kEMa/qN87r6dt1PCxhJ+wy4PiGe6CcXLQxtfRJXsLOb43em6O4JIbh/+83QPx6TUo=
X-Gm-Gg: Acq92OEIDuhRwmiArrtmATY4WXvBJVFq+u+LwfzapdVolLXC9PrU2b/jL5N+xgOp45+
	p6HSVlHNE09P8R7LG7QEg6Gha30eoin2ydySU/tB/azICIO+tUN1hS3gApRIR7+S9vD4ijq4f06
	jeKpBOugCQBC+3tEoXLVSTIY70c2p2A0v7tcsUyHjJAP04l9wTtTHN+r4rQi/Y8UqvsuE3TB/qY
	DrTgSEZL7Rci0ZGHOkw1uRlPNMfpawcPXux7OCoYkMPyxVXTr92UiTtM4w4MWNBG5xueiQGVNAM
	5mW1Pm33PWPu0WsnNESmEKMMOLJ2cbiOADrgIDMd58w9EA3E+yCnK8njKJjhCiTMa/eejiSN4bU
	5pJqaLukHQlWW9Si+edZ1DzgN7kjK9fbx8w6XeusDHDdVqU1vBaGHV+Ux8DH6EIeZ5TvoyQKKrC
	ORzzVcOlbdYg8BP0d/FxZTchcnBaSdJ0szCvwvwZt4b04mzSf3a5KtGPQVAh7Z+/U3FrHcCqZWu
	m8e2lWFBYps3EKN
X-Received: by 2002:a05:620a:4455:b0:914:c788:761a with SMTP id af79cd13be357-9158a84f289mr254481885a.58.1780449425306;
        Tue, 02 Jun 2026 18:17:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fe7sm102378285a.8.2026.06.02.18.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:17:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUaEC-00000004yu4-0q6Q;
	Tue, 02 Jun 2026 22:17:04 -0300
Date: Tue, 2 Jun 2026 22:17:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 11/30] iommu/mtk_iommu: implement iova_to_phys_length
Message-ID: <20260603011704.GT2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:18PM +0800, Guanghui Feng wrote:
> -	pa = dom->iop->iova_to_phys(dom->iop, iova);
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
> +	if (pa == PHYS_ADDR_MAX)
> +		return PHYS_ADDR_MAX;

???

I guess lots of AI made this right? Please review the AI output for
the little slop things left over..

I saw enough unnecessary hunks, and goofy things like putting the
mapped_len zero in every driver instead of in the core caller.

That said it looks pretty close overall..

Jason
