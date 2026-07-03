Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002122E542C
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097358; cv=none; b=HXCwd33/7HVLAeZ/yaTm9unZISDO+QgoIEbFf+xHj24ZSEoSPPJQxVs/uzxGvtx0XHiUEYPZYbemPmEj2ql/afNdsSeyjZpotRBW9EWV7JUBMhqdmO2b5ULQU42tf6ZYskMJKuZcidjuHrBkrh5fwCPPrFk6JiYuumtBEAAofmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097358; c=relaxed/simple;
	bh=NImIZmSEszOUZywtJZSxACAiRqZzU96rD6XMWaHuLMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMU87oL68tlPy0LC0oC7U9drB6kqi45To505X9ujEcHoAIlYXohpUNZF0G6DX4uv2K3wIJlhVC9HxgtMO6awGi1JYPAR8w2SgPCAJICXHZHAspeOQaq1KME9hxV0MogHWRsuDq4HQi//0wQs6wIXicIOM9ICkTLahjK+izlZeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OWSOeGqJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OWSOeGqJ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0c68aa31so4712501cf.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783097356; x=1783702156; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QyotU5l8k0oAbp2gmOwsLK/XfEKLkjm+dMk7XQ103yI=;
        b=OWSOeGqJutfaYszroSvSnyaEqmdoxnPc1l2tS74IOGeOnOZ9t+P2Rrnt08TtCG9dXM
         1nDp1Kxdw00V2GiRpHh2cjAqaWn0AAuO4zKVxp2XMOP2aapvlcHhAQo8c9gDOS6Eezov
         uifVHd/KvklAwFQ5uQ8u3gBSZ+CRU1yF07EnqLynU3jRAJIJxWIcG8rzyv7aUtevcaiO
         ua0C9Chs7FMQAUV1emBE1KPZne5T5g1x30IPhVwRl92tmkcTQ97nfaHYBKeeCjlJkP4I
         mXee/ZilQp5TmvWoMVysmoqvyiAoWZN825691HLPOF25pOrMLO5IzLXffLcvO2x0I2sB
         Pssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097356; x=1783702156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QyotU5l8k0oAbp2gmOwsLK/XfEKLkjm+dMk7XQ103yI=;
        b=K4Db0cTCyh9XHoQuonc/aIhH/FPYYMWnZF+mxy/BOtqIAwAbpyGVAmdaozHY5xukb7
         1pxL+PEYzxqp8cRriqJ47RqpZcaj9IXu+JUSJzBUGrEHhdN8EBL/OdnYrhjFrXdlB9YC
         s1hlhyU++srHT/dXl9/yjb5fqi9MUBRWDGTcHOmn26V4kLW/iR5IZP3WkyXdqrvwkrIv
         QdNePyIJs7EU7g0xXH1nKlsrpbbItrRgwWjvrqBN1/r3oLuJMgqDVYEgQDpgIUE0sN8S
         i3/I8Tg+jOqh602EUhHmNTyP7dl9ozCdx7lR+BxpSfEgxtYd8tVD0tr6FIySGL5M3KSA
         LO9w==
X-Forwarded-Encrypted: i=1; AFNElJ+WE2HwYCllan1tc/xlQHbFyNpHjpVi9hlWBfiZcdbDCjo0E74+60aj5/9SyYeoH/czxGz+Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG6kCRplSbFu8g3qMZ/ZIIXTbGvHVrTev6PYlCX5PNk+NfNNYc
	dM6WeLKecQnEHr4YV3EbF2uK9iQGIaNnqbnr9NbuH+3sOcowpSNtIFqHdvG9ukY5CZ4=
X-Gm-Gg: AfdE7ckmbBhrdHZkna1lb4lgmWwvnoq/7NypbtXETNmglRsvcKd+7AJBFOWWoHk5Bhe
	rJ99OKUquUbXdkAkHrdgSvrhh/wIcwxc3NfI2w2tMUzHYUZJ7WuDusxOCw9vH3GLYtg8eFnuCSU
	fhu0kvFtADwqEZEK2huT6piH0izidnFHSG/3+oYRc3bvYlm9JHcR66i+Zc9sr2KscPau6toIRPB
	tx+IH17NWSALVEqzFrloagU3aoRJh6vQbmnc4yV6Wdz9ppxX+XTBabBaxnuvAPMvaN/qivLJ6SG
	iHATcwzFj74m0G+vLC9me6Ezu4RmWfi9RXhEpCM0m/KEvZbh8RTjejZ5eCkiJ6cVFDZESwe8/a+
	GHFWgFeJrCYysG4LphAfAsXbpEAwq0V8PjW6jzshbZi50TsPXNDS6bP9UkzjfkPxoJk/Ng9nMIF
	atdUzPP4jTcMj7qTSo9vnkRqR79m4cDVJFcFLe9ec3v57jKttYMRoSchR5cmM60c8d2Dw=
X-Received: by 2002:ac8:594c:0:b0:51c:2cd3:ae7e with SMTP id d75a77b69052e-51c4c33eedamr5242041cf.45.1783097355828;
        Fri, 03 Jul 2026 09:49:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bab9esm57511866d6.42.2026.07.03.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:49:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfh4k-00000008F7B-0pi6;
	Fri, 03 Jul 2026 13:49:14 -0300
Date: Fri, 3 Jul 2026 13:49:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260703164914.GY7525@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>

On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:

> @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  	if (system_supports_bbml2_noabort())
>  		feat_mask |= ARM_SMMU_FEAT_BBML2;
>  
> +	if (system_supports_haft())
> +		feat_mask |= ARM_SMMU_FEAT_HAFT;

I fear this is going to make SVA stop working on systems it currently
does work on, so it might be a major regression. 

SMMU HTTU is not a commonly implemented feature.. I think of all the
NVIDIA ARM chips only one supports it. Given that a quick internal
check is raising concerns this will be breaking for us. We need to
check in more detail which cores have HAFT.

Breaking already deployed SVA would be a major functional regression.

I think this should start by just enabling SMMU HAFT when CPU HAFT is
on, when possible. Maybe print a warning on the mismatch instead of
failing.

Since we can't break already deployed SVA a full solution would either
have to somehow turn off CPU HAFT or we ignore the gap in the AF
updates..

Jason
