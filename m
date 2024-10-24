Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E111E8835
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779655; cv=none; b=EgFZzbunDlLZJ9rL7SBSQjSyBwiWyzsolQe7fZd9Z+AQAz1ljwtddt1+uoL7xIhiJ88DTd79xRizILqrgQaDq2lCVIeTAT29q8dh52lEUBL7QTIcU/+qzw5eywy316qY9mZ1vgXSJbFVc2L+PAQF7QSFaRQB9Ssig9N6YnTjfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779655; c=relaxed/simple;
	bh=VQc5gNeR95b8to8UOPWtKJkRJfPW8705gwN1Z4jeJv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNczGOhl0wwr1P+BqtjMJ0F9IX/5B5kleZ+T2Cs6P3LnYyGyZKByKA/rmWiY0DLf6cVeO8mW5D3Xy16qSEdge2Alye/1QbXkaMZ/1vQKLfANKR+zj5AftNvVf3IAsKA54qJRk52NlGp5ZhqK3um+1RUGkApBe7JG4CJFJ0zhSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGI+oE/H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGI+oE/H"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca03687fdso124345ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729779653; x=1730384453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpAP5qiPjWyz5Gc+Wil+D4sMWOO9mmQpTzwW1+P31sk=;
        b=cGI+oE/HJKhZZyKId/3UH2XoRZ3YddXb2h/oDW2e1MtInT8p9dWW/onRA9+wMiasbm
         muEuCLNxqlXaF2gyDp1lyK0nb6Gb5svrTvcA2ZTbI+yin/yLNsX+YspipIjh/K0/yEqm
         fA4HUioTqeQt1wpSffo/xt+11hWCP8gKZ3cmm6meQr/FRs0zBHuSBuB+LuiWaAvXFuJf
         6wEeGBy2/2WWki6v8MUygVS+h9OdqQRheuBVWP5pmCqMIsirZJ8+XnU1QyyID3OvKoxV
         ruH6UCQV84ddzJ1pR87lAV7aOJn/p/g3dyyWHkIHHM9tY+LrQQvb9hBuWIGzx3aimA1Y
         Rhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779653; x=1730384453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpAP5qiPjWyz5Gc+Wil+D4sMWOO9mmQpTzwW1+P31sk=;
        b=AjdY5614B6eiPprbRHpjV8q+WiuH3p5qxutV1CpBycx2n/fO8wZ2x2mDjWzz8B4Usa
         ZznOUKJT8dvIYaN0AKFKZjDAb9On68B+7/KfGK2Cjufx305e6ezEK1EwRaafoc3BOTmV
         QzjAYe89tMXMWhgZwX+r7cXHFbaoDAhRxx8etrmMIVv8I1kf5rsPwPPKXeqa2591O8Gn
         5BxycqvzGAYTsT+Kg2IRJQXYOucH3jqZxrrOLOzpgYUVEtnDWOloBNUoJTBSFi7L5sN6
         f3wtjEPN1CLr8pgIxO/QCTVjscWQnFd0MkFyaB3DG8q14cTe10qNfn4FyC0hsaoYVD7w
         OKCg==
X-Forwarded-Encrypted: i=1; AJvYcCVDLVgYTX41/eTQSR97srKXCWc3X4Vl1hYLFKEAstXjr5/vbuCjIsSxuRapoTo0v8URo9wDTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy94TJwG0ViOLFW21LIzsn1KlyHXd5SIV5SVYIzBu4UPmgVvoAL
	Em+fyZOwMHlnxpaTOmrBZhsLw6b3EFIundTmm36UqHAzZa8dkQhTbyG72QKNwQ==
X-Google-Smtp-Source: AGHT+IG9bQVuDshQJ4e8UjO37Jg7ZeJqhNlys9eA6ZQvuj/8wcPhCNr9uoFLeVFlBUc76sLjFX2PTA==
X-Received: by 2002:a17:903:1d2:b0:206:a87c:2873 with SMTP id d9443c01a7336-20fb76b796bmr2250305ad.5.1729779652572;
        Thu, 24 Oct 2024 07:20:52 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0e5asm73130105ad.167.2024.10.24.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:20:52 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:20:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZxpXvOZeY5aaFjHD@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024131147.GG30704@willie-the-truck>

On Thu, Oct 24, 2024 at 02:11:48PM +0100, Will Deacon wrote:
> On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> > +struct arm_smmu_event {
> > +	struct arm_smmu_device		*smmu;
> > +	u8				id;
> > +	u8				class;
> > +	u16				stag;
> > +	u32				sid;
> > +	u32				ssid;
> > +	u64				iova;
> > +	u64				ipa;
> > +	u64				raw[EVTQ_ENT_DWORDS];
> > +	bool				stall;
> > +	bool				ssid_valid;
> > +	bool				privileged;
> > +	bool				instruction;
> > +	bool				s2;
> > +	bool				read;
> > +};
> 
> minor nit, but it might be worth seeing what pahole says about the
> layout of this structure in case you've got a bunch of wasted padding
> thanks to the mixed-size fields.

Interesting! I didn't know what pahole was, let me see how to use it!

> 
> Will

Thanks,
Pranjal
