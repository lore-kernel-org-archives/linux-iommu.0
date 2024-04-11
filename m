Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD1149C7F
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845575; cv=none; b=m7N2rqkEbFj0297PcpASn/DXLhOfOtbTnlMZNT7WniZPHxHDQDFEdPE8JeQCZ65BXrpsOSuwPOYLtAojoG5+qIxNJLooTYni2GGOWh5darMCiC7BBWeQmJMdK6gKTKKYV7YEerh+rdqEiFYVdGz3o0C0lTOY5bNKSq7lAmqKlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845575; c=relaxed/simple;
	bh=CcTeL3OpMkKU2r/7LioeWWBMfEOPhkojhQtXZMB+8xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdo5GfC2J/t91Y9iiYB1JXRseXPG20asKvlLKH/YrDL7cuUBaEQ0nUOMYiqLNAPmdrmmJrpIMb/8tkFOkT7w7HobohcmDfMLLZ0n4MidxOulNqnzPuwisFi/+wbi381Zfbl357RVZYzIuScp9ZmJJnLQjta3j//wtFBd+htCTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G829KDSF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G829KDSF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d5e80bc42so409931685a.0
        for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712845572; x=1713450372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oHbllgoFpCrvjSC1lAfzgimxCBGclBnX2n/6HNhr/g=;
        b=G829KDSFdcpzxm/CZSjha6cIM1FOtIZPGtELJrOtTzfp7dExhyXLjc/H2wYNqniapl
         tCxYqxbuE3BxXOkmxk/WjGUbufFapcV1lu2tO3mo+TGTG1Fwhwhr6UNOAm3mvrXaYnnG
         cPJtRJiAv32YJPqOZMSNMqpw6zCiXi1wp0oaxIEYVOSBhRHzmgvtBBcOq+9XdM0+yg1G
         t4qLygMcitIalJmnzfaoZsSa544dFQvCWcZLOFlTeeMMj5Okm+TvWFSFBlRTB+MEityT
         Lg7gYcC7DUutCzZK+lTcltQw6b0v+Xh8o3pz36eKHXP3+JfToRpnhsCgogMpCwNu8ZpB
         QEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845572; x=1713450372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oHbllgoFpCrvjSC1lAfzgimxCBGclBnX2n/6HNhr/g=;
        b=szjX37AlHqUkFzohviI66dmEgtx6Syf4yl49QY1ARjbuz4OfWciSFPU9FPNHnpiDPP
         hK+EGgxrVFFBdMnpGAYntHNUGS6HLR736ZThrhpQgEQgCmJ877jirynxwqSDu+TwDVal
         LmXlTjK15M6mlT6aO4ANSiIitGPCa4wULmcBt0/mIgEZGbpEgqDzYmROY6+pHPjPBXD/
         6IosgsBoSUDw87bfnY37uyIxVh2GXu6s9ah9YrdhbM7ODBeIfw7TSADVfwfB4A/Xluvh
         UiAgoPXLVfG7GdFhLtSCO1nVwM5aWLFpT0U743ebcJoJMk3BU5VfiYdaaO0uU38nVuzY
         nkmg==
X-Forwarded-Encrypted: i=1; AJvYcCXr3Zyk1DMqJqtdQnmU7b+g1EHBPDfFGYWER9oSeaYrgT7OMNnCDxbPJiLdwVN9l2ZTx8ekCnKXpxRnwfS4hgvsQKGBq9I=
X-Gm-Message-State: AOJu0Yw3PLy/jn22JsD4+ilM9sAh9PSccTDHHhreIZMgyW7elCwUq3iH
	yMMX041ySVvUFwHgiB2jMVhCvwK6bOOd9+NHkVuhVkzvFC8xvC8AX7OAjUlZQNY=
X-Google-Smtp-Source: AGHT+IEJUflNdgHSve3aZKuaUf7mTk5cfYGyqQzPo1WhdaFIC3BZ6WGuh7N4g7NQKRJ8urZ3yw07xA==
X-Received: by 2002:a05:6214:18c5:b0:69b:4763:120e with SMTP id cy5-20020a05621418c500b0069b4763120emr1944998qvb.63.1712845572616;
        Thu, 11 Apr 2024 07:26:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d17-20020a05621416d100b0069b4b7c01f9sm836662qvz.146.2024.04.11.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:26:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruvNT-00Apf9-7u;
	Thu, 11 Apr 2024 11:26:11 -0300
Date: Thu, 11 Apr 2024 11:26:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Retire disable_bypass parameter
Message-ID: <20240411142611.GM223006@ziepe.ca>
References: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>

On Fri, Apr 05, 2024 at 05:52:07PM +0100, Robin Murphy wrote:
> The disable_bypass parameter has been mostly meaningless for a long time
> since the introduction of default domains. Its original intent is now
> fulfilled by the controls users have over the default domain type, and
> its remaining effect in the brief window between Stream Table
> initialisation and default domain creation hardly seems worth the
> complication. Furthermore, thanks to 2-level Stream Tables, disabling
> disable_bypass (there's another reason not to like it right there) has
> never guaranteed that any particular StreamID *will* bypass anyway - any
> device which might actually care about that wants RMRs - so there's not
> really much lost by taking away that option (which has already been
> non-default for nearing 6 years now).
> 
> As part of this, also remove the weird behaviour where we "successfully"
> probe and register a non-functional SMMU if the DT "#iommu-cells"
> property is wrong. I have no memory of what possessed me to think that
> was a good idea at the time, and by now I suspect it's likely to break
> things worse than simply failing probe would.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
>  1 file changed, 13 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
