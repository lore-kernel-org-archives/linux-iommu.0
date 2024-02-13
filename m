Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A385F55E
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839133; cv=none; b=Y96cDiczfVqQzxneAcUh5c0bGa3p8hTXO72/sKS1cSwKPnefgky+HILZAZE29d9cAtwqIY/kYy02GL6jbLoeRGOwiE+nPrkay2CdAMCN0esBWxlCoDjpsluUdHHuPhf3JhCA/ualx/k2ZLJfwd/fW1TSH2Op41PtEB1ced8T3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839133; c=relaxed/simple;
	bh=Mb7cfkVoTPe9SpFqQPiRQCgZRgp43WdceLq+nhIl53M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUZZr80vE5iFWrsFtCsSwwlmeNDQI4G2t7x63PghucZfUOGRgnkgA3PBTea9tD+77mMteMInGmjYjPRHqp06M9fWoQi8csX138deMePiKA2OmSl1U510dLXOrOm3/GTozAWE4o+5OLuROlpm0eQrydQMEGt1ipOS+rNTrNYFsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=gEome/Zr reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="gEome/Zr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f553fdabso304619885a.0
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707839131; x=1708443931; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+5lFm1GOYo46btsIaJvA6S/B+CQsp17IG3lccG/v6g=;
        b=gEome/ZrILoDDeyRIow3vBrWXA26zD5/we8YLr8e4Z3DsHbX5J7rglI1wQqh6QPVl1
         32GV9i2a0TYB8+pxDBW/VIFzlqkRLIYkVlKEv51M0PQzQem9cQZgDigQ6iDMZuym9W4x
         f35asHd6GN3LElTsFzfl8Mr3C2X8yQD+GyuZWVhWPELzopahVnhuTYW6rG36E/JF/8IQ
         fhh/VY+fOkXc7VhqaE0eRg1zubPKbp6J2dhelc5NFmb5BHx1YU63CeemVPcfg8jiuQRo
         wjqT/gXTi1bxKtu8WwByZyk9CzfFXy7qSqy7QBnRNDlSH4sQuzrlw8KFkUUYQD3SIaXn
         w2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839131; x=1708443931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+5lFm1GOYo46btsIaJvA6S/B+CQsp17IG3lccG/v6g=;
        b=o8WUwM3RCpnA+Q6MQ9FOq85s2UmousIjgmhwy5GXSZ5r1/0QchiKsOzE8nvGTXgm/v
         /d7z++IF9PRN/5Z6Js/PjBLajCRniux4NER+WyMeU0f9Vn73l+lkcjFnYhGnf50vKlv6
         yXCfBT1f8MxMX4WXFe04eFBANKJCh8Bw1Sq48vUqTM7OilO5wffyyhkGau+P8hGd+ZJK
         oapbubI+No6YW7TF9pE7+EbQVfUWoKNGXEC05dr6HQ5TeDVlSYkkZ0eI1B7HVV/B4aeL
         NANF6mSaB2H7GyLeoMQ3s66nJrmQkHoIeXLHlUoilJmkvCVas0CLOKyUmPT1UYEH+y7o
         Xlmg==
X-Gm-Message-State: AOJu0YxUdvMOo4sDwdr1orqfY6H5+JH4AqyIjTLx7EzMmKQ4Gs6vkNXW
	9E4RxRdT/2+EqKKcNDtOJ5oDd4zFqTXBKP4bmxPQeNWHWY7VQyag5KsYEGYdfOIA1FmeRdnram6
	QOACw7vtV7QUZZLE2EkWDq1ELm8EdmA7vrT8ahw==
X-Google-Smtp-Source: AGHT+IFqChznTFjr/EeidSN571ZA0nQfVJvF+Fp0E+Y2flaP6eNCXc4z1s3ADkdtr1CrUfrPgpTF+9pex3Z052b1w5U=
X-Received: by 2002:a05:620a:618b:b0:787:1db5:f0de with SMTP id
 or11-20020a05620a618b00b007871db5f0demr2991955qkn.26.1707839131046; Tue, 13
 Feb 2024 07:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com> <20240213131210.GA28926@willie-the-truck>
In-Reply-To: <20240213131210.GA28926@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 13 Feb 2024 10:44:53 -0500
Message-ID: <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> >  SecPageTables
> > -              Memory consumed by secondary page tables, this currently
> > -              currently includes KVM mmu allocations on x86 and arm64.
> > +              Memory consumed by secondary page tables, this currently includes
> > +              KVM mmu and IOMMU allocations on x86 and arm64.

Hi Will,

> While I can see the value in this for IOMMU mappings managed by VFIO,
> doesn't this end up conflating that with the normal case of DMA domains?
> For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> wrong to subject that to accounting constraints.

The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
is passed to the iommu mapping functions. We do that from the vfio,
iommufd, and vhost. Without this flag, the memory useage is reported
in /proc/meminfo as part of  SecPageTables field, but not constrained
in cgroup.

Pasha
