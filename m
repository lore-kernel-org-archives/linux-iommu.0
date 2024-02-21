Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750943F8D1
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513835; cv=none; b=Ji9FYsIRmc18O04RLiFIuV8p/wR4tqiGjWEvTmj51f2p5q+VDMcPrmKE2Y5WIqsiXq+Abb1qW8L3DCV/nYPUNAAkKvqvQwrcMmJzAIFgzK6EALZn+Z508XJ/f4UYtC6ztiutyTpDpyzZ1Y3vIqkhvGHEFz+ICxVmO5ZG491EK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513835; c=relaxed/simple;
	bh=yYwOfjmiT5pxQ2sOc334eJUjQ4d60tVUqL5jOyR3Ajk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODKZQTV68eYND3Uz68s0kBnlLfog8zqOhUytL+jeB64znSV+WBLQMZA3wKd9o4NUZxs/UPjJajKH2v213/NT85ErcGis8ICTEA7vSZqrJzXE48n6rkUFPxpM4XE+iIhAiEr48E3S2iexSur5GumSTAWX/pv477ZZg+vSqyghqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4cNlnLl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4cNlnLl"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30f7c9574eso820389966b.0
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513832; x=1709118632; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5L9NoyuwvA4Gf7LYh90rqEBr7lWC8KBnH4p5IN+MFQ=;
        b=z4cNlnLlr6fhZ3zeVMlC95Stw9lcU/AurQ8gSeYnDVseq49qRB7CuIizmkMCV8SMSk
         VEQ0SesAHUyl6ap2plfJGJvaomSjUR4IkQpqeMLLRD9jGtzA2XkJ3o+YTRx6p5kLJeIL
         v7gBuWhX2ePRYXac3w8HBwgmbdezqDQlK1SE+tHtL2wlHBEhtFF7V4LMuhqoPAWAlEgQ
         rES3pJvKXM8jZnFi/otKJTiZOHU+xy/xV5wUjDtNW7fXkp0DENTPCnxxgC/5UW2++bQg
         BA+bMogi4v/w/q0AXhjXEhwxC0442RKYHaQc8OwbRiq9WlU+xx4ijRZg8IPf45MRQhMA
         u7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513832; x=1709118632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5L9NoyuwvA4Gf7LYh90rqEBr7lWC8KBnH4p5IN+MFQ=;
        b=T6W8NOXT2wCiuEm7gmKWWG3NYSH8m2txf/jnVJnuZTF4vbwzGUh/ljgOxeieHKG2AM
         FmUhv/xDMw18+Brm9I9t6UjCp7OXZ/ubLs8dPLFmdphkMrEvEXeC2PBf/qbggMte4r7+
         ilM7hJsUsTVNsmG3CktXLSrCiDrdq/4wS4/6s3kc/B94yRix71m6fdx/o5eE1sy3I9N1
         4u3/KnsEu/RMljMN4xrBetcUN0n8vUaNlRhQ1E9c6UF+t23q5vO+1Lcw5MI0DWh9KbvD
         qjJaA9O/F+m6uZ7ldz2xUXUZ6DQQN4/q/KZBX/Xnn3LQfkOm47pR+A60eyYkYHqBzWel
         n3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14m2XQBMYwUxUTDE2YlWSK9LZcdMEFWqIystkuugPgOK9pCapZZ/UsJL/UPeqhg7V8ea7l8NuV1FEIlz50fG2It4NJPI=
X-Gm-Message-State: AOJu0YyFa5Is9MjswqEF1UTa1i7WMyPVgrau7JNAtmfh/VBiov71e1zu
	ouAFEDjsZiXb9AKHgt8dr8LzsSfLfwfSPOVkvI20h9TV2WYMuDdafWgW59/zoUs=
X-Google-Smtp-Source: AGHT+IEHmqJXiGEszWIcBJwOe1/dTMQWWMygFC3Y1juPap31hfiRJ/+P0zYCmXOXO8UIXslmCNRgjw==
X-Received: by 2002:a17:906:3bd0:b0:a3f:45b7:3af0 with SMTP id v16-20020a1709063bd000b00a3f45b73af0mr605988ejf.71.1708513831729;
        Wed, 21 Feb 2024 03:10:31 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a3e0119b4a3sm4958240ejc.140.2024.02.21.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:10:31 -0800 (PST)
Date: Wed, 21 Feb 2024 13:10:29 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible
Message-ID: <ZdXaJQ5AfOiki1l5@linaro.org>
References: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
 <20240213131952.GB28926@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213131952.GB28926@willie-the-truck>

On 24-02-13 13:19:52, Will Deacon wrote:
> On Wed, Jan 31, 2024 at 02:35:16PM +0200, Abel Vesa wrote:
> > Add the X1E80100 MDSS compatible to clients compatible list, as it also
> > needs the workarounds.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 8b04ece00420..5c7cfc51b57c 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -260,6 +260,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >  	{ .compatible = "qcom,sm6375-mdss" },
> >  	{ .compatible = "qcom,sm8150-mdss" },
> >  	{ .compatible = "qcom,sm8250-mdss" },
> > +	{ .compatible = "qcom,x1e80100-mdss" },
> 
> I think this needs adding to the bindings Documentation first.

It is documented here (once it gets merged):
https://lore.kernel.org/all/20240220-x1e80100-display-v4-2-971afd9de861@linaro.org/

> 
> Will
