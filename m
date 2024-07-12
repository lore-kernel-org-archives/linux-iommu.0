Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3F7E76D
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767961; cv=none; b=Ve8NsO1vlIXViM/VjEGDYCWq3tZEdsIMeGv+E+fhvvlcpF6AkxjaDo07iOONT25UWFO4VbAKnVCmp+vsQlmd7ReuaIG5sqEd41218awFug33K4i6AzGhVoskvlPjZXihQXI+Q7J3E3vBLSmmr7Ipu6AXdfiqK9O7dgSjxxfKojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767961; c=relaxed/simple;
	bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBko1XieR5e4lZwXAIFPe1l8uP0jEkiINqtDTqdXwHEivBddDcvXY5tGsV6/wLaLt+TwzWxrDh9K8GZpJj0V80uL7eQX+l/rz++aI4XQIN0Ar9YQknYT2DFu+33k4Rs6W1sMzJxH1OC54NIbxlkW5q7PpeHoC/QVf9dfdIC5epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9J8TfTR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9J8TfTR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ca4649ad49so1295224a91.1
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720767960; x=1721372760; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
        b=U9J8TfTRTd2mFxZ86SWCLbUsQyHsWPq6fe+qo0vQTX4MwYdLx2zc+M74HoOsD3P8S2
         VQRSgajOXFZ+loFtXKAnXvk58jwi9/GABV8qyzd4p/Wh+rRav1Of5xEWXz9jsRG04yjR
         wLIcL94bEqQO4cE4395k3GbP6yZ2WOtS7xp9t840VoMQFWO99tgnXsMK1sd6CrgYBi0K
         TPpDnJG0jxEcanHXnOqgiARX4pPHeRy1/pCCftUCJl2lR2+Tu9pu4JswAbq5ejJHLIY0
         373tTqlHKA5HzkMqDfFte2n6NeJSN4NzdeyW8k++q/+1UdH4XZdQt4EbeChiDKWNop+S
         pPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767960; x=1721372760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+M+15Jtqb9r9vxu2BWFpc7n1m87DlN2aD2RS8uf2FU=;
        b=ra2clmM+3NTUpzkBKm5TBqxCMmfAzMZxR9DzR0bx2qLvNlDxVhMaIWqWLsPnBFZfYC
         xbtDuWjXuFalW4oCj0ZhJVeqJM3CHY1PFdhSYXAHfIHkNrmyvaeEcb6L21YNHG+faULl
         LTZl91nN5Eld1JGs5Czmq3y5LocPU/wJjm8BeHmuXOZASNsNFaTD+vJx0GZkLHVGp2MX
         zje2FUvN+VpByv5zG+CnwJ0/H1OEF/UBlOVL7M11SL1v47KUE0VMS5CqB8ByK5av+pcz
         t+KblAVIxUFyBfufpYahXYvHpxGDspHDaT/SH4Cr6IkYVZcerNvLElZ6PXCtL1wg/zK6
         ZYlA==
X-Forwarded-Encrypted: i=1; AJvYcCW69ulFBlUCcEoeiqmkhJFywoIjdkQ71MT4KWaW4XG06auW2mQUpPckS2R/9fq5hUXyjUaII/kkHqSWU+v8HGlzpzxVKrA=
X-Gm-Message-State: AOJu0YyX9WQ3PBvHBs4gEEDRm/ulMx5x9KOeYNFHFsf9Prt2mTXqUMmd
	y5nORs/K9HbIbzvWcvZ50mdI66OoE7wjFICIbs7nBTJuWNuyIqZ0kPa6A9809PYptqnSxACwfOq
	IcfJCuB95TwmT2Jszg9TDQ1pT8ID2SCmIppTP
X-Google-Smtp-Source: AGHT+IHA6cMwwcGt/hYxQqxC+XLWB1NWuPeNr+1qD7Xfm36w7VO6oEsb2keJWQBU+9mFLJ6Ez3xKy6D3cbgPnLqBHNA=
X-Received: by 2002:a17:90a:66c7:b0:2c9:815a:80cb with SMTP id
 98e67ed59e1d1-2ca35c69b06mr8978501a91.21.1720767959437; Fri, 12 Jul 2024
 00:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709234913.2749386-1-pandoh@google.com> <BN9PR11MB5276C05D3B3B8821420BBD6E8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276C05D3B3B8821420BBD6E8CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 12 Jul 2024 00:05:48 -0700
Message-ID: <CAMC_AXWbG_6DSOekjjoUnzPCR3UpS1P_p1AL7kLHO=AnVEhHtg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:49=E2=80=AFPM Tian, Kevin <kevin.tian@intel.com> w=
rote:
> s/aas/as/

Ack.

> > Fixes: 5dfe8660a3d7 ("bootmem: Replace work_with_active_regions() with
> > for_each_mem_pfn_range()")
>
> this doesn't appear to be the original commit introducing this bug.
>
> Even the old work_with_active_regions() way used exclusive end_pfn
> while it's not adjusted when calling iommu_domain_identity_map().

Oops. I did not look far enough back. I believe the correct tag is

Fixes: c5395d5c4a82 ("intel-iommu: Clean up iommu_domain_identity_map()")

I'll send out a v2 once Baolu's comments are addressed.

Thanks,
Jon
