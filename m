Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC142204F8B
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847665; cv=pass; b=miNxDwojJ4cFzvr4G8sdtQTcHT4wjjF7loos7iMy7jGVzQJ5CJLEQMjbO/HH+QPrsYnZVgpVl1xGK6PB3LpQLUNDP6ZFsa9IKrcmdeMNC7lTgYcnh5lx9n2UK2bk68208SckQEDNs38Z/eMUvd8q0jYCy0Kb3Ll96IJFEkp1yTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847665; c=relaxed/simple;
	bh=RYQZPJfFMxqkp+1nngNLsMaHBFm6+xCUj4KkP21+dYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAkqPNPnPn5Ya90J+AlgGvYOdB2OYYWJKhJcs2XzbfEuGELMDSj/3dcqbZs0qNMjmbwpnTVYsOPOQzIv/ox7qH2KfOfaJsAmOBEk4+tKuNnq61quE0CrVsXVkddHYli53Qdxcefk6nlgvsgu1ZGzWzkEwvKEuXo4wn4UCuvvrSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGUDJtK1; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGUDJtK1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed67a143c5so152421cf.0
        for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 17:14:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765847663; cv=none;
        d=google.com; s=arc-20240605;
        b=NTvvHWbXGDRFGubxw2T+fXOnbkfDkHYa7U9yyTbkAOcFks7Trs9MTVgNeanQRuM8QS
         XbUD8EU38V9O0EmBZU0N49caEITJ9ahkO7VIm4Nxy9RJ5BSH2mn37+/dtl7LPliYkI6C
         zMn6QhJOxlROIm8f9Bhsrm0FdsmBy4x28DAFsXrqKydl2Nd5EsCjfVREjSUbVFLZryHF
         tMbD4uHIP9Vey3w1mEcbBaG13xWQiZlQek/OlR0z1nk5XNXvVw2+Twsnlg91ZvQzRku1
         Ug5Mq89UrlPSZnV02cj72d27Wlhd11zFS2bmTI3hRc3BmjKbn6CtPAHkgYqvVr6A1E1F
         ccmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        fh=FawTotlhgE8NKNZwMDp2j5/wpx8qcp8Man2bXxtLyH0=;
        b=gT0CFSaZNX4efI5sgueadrizSW4c8irGFH6gf1Xu1jSzDyosSOKAdtqxFqXikoL4fE
         pnZr3/GfUUv+0DjhDnbUWNLxIAGda2Q7a/5vY13CCU/NOslKvoFlBopDujUklg5bTxZW
         GJaGyMXMDDbuEtAw1MtG5IgmdsgGwmFHRyDwl4iO7fiGd9L2g+fSlprGorxX4rQSEddP
         9EyHCkm5gpQpJDC+ZNPkDelhyBwh7231HU//hAWGi4TRnkOOjzFFRtNPEuTgrR/KkeKH
         O0xX258x+S71JeH119Hs/dZQyVUm8C9Sgn/PCIWNqFNPOFZxE2h6K0qqt7iW2w/AeAzR
         XlwQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765847663; x=1766452463; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=vGUDJtK1txL9KJyBns5NkuVGspY/0B/CNh5zdYrm2Kn88dcQxvi7x3xBWZboBRJbwz
         Cxa3fSZhB8JKowYuE3TJ4xLyrs3/ZHGwiMDurxRbgINqiFKvkC4QdZe0pxFQvbM5idoW
         j/JVzMLN8Sbq0qK2KZtxc/nA1Q9sgLTmywbilvBfUBIUqrKPWcfLGee/5kEXd/4KZLF/
         6CDyxeeQYYhyLgmU55mHI8J2PcyP0XkCybiFAa4rT7ixQKRPzMc4VGI+DI8QjyWfyYcN
         lbXLdjnA4BYZcUqEeRpyEez7xO3IQoCC97qeQuRXb01Wk4m+35t33V4zkSnjgee0s4R+
         HNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765847663; x=1766452463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=d6yxOEW9pHFcWCGTl+mz79lKiH06Mtz6locPbV+xIAdeZ5CfG6RMBfRe/gJ7jz2EdH
         ZbumksbtycIhmr24wkregXUQ7KmRqlugaa2eOAKqCi2lK4C5QczOrQC307CSD+6RcaUY
         cOS9Z2RBB+SE6ld0rSwv/GK6qPfo3vwC/sepEuQQ85DyReOBLr0eV9JcdnEc0StQk8db
         KpKO1zM/awtcX8L5JufhL290xLG8U457z646jL+JKwHyWKJmmNDPhNFpSSsC5FUxASPf
         qf1zrIP1SohhjqmCCs5vZWBOts6KOlsXK3XxljoI+Bl6yEstcI1r+rky7+3/VOz8wk/j
         w36Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBD2dky8pRr76CpFwKTJHZwqgzzYfUHY6FATdy7PQTzEimd550rprnXHhI3ZFbVJit9q6hGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE+QB7h7vfUdTGpBwwmvjzxA+GWyiv+PmQ0MRsRJst59oFCXLp
	N3Gw4RpGsKAHZYIuo4xyMJOPQu6diLnMv5F4/RRc6HnlgST8feECtvdSBzsyaLEjXgXX8SgxEuB
	6Q/VzBWDKaH6WdtMjbGgXRyL8D3V5dcrnsrgIaaSR
X-Gm-Gg: AY/fxX5E8m3uB4HogmpU2ZRlQ9d0opKKZZjI1wjSZKtXH/pP1OTvXB3ib9gXAZbtwsF
	znw9yuk8LnVDW8eaNwjZPFThNqcmv2z8E4A1Exdo0ooEdL74yLJVL+1HiNuAVpsztV/n8FMEzKB
	w0xsg1TrE9PRzEWLi/bTUOq4GDM78HTliZtJJnlqr3v2oCDSI9BbrsJ6nSV0Fp/5J4iTprLAqsX
	aXqf+PPU5lULewwkKHWWBD1m5rVBnPVPsvSvsYXzKwkn5vze3hfjdRMqJreulvr/3wnWlnP+2rV
	Iq9JCrvESnkZnvuzooBaeRC8dQ==
X-Google-Smtp-Source: AGHT+IHDK9Nx0ZJG9GA2+hWOGyWZ73qxIXF4H8RaWSuD2ofLYKrM3Tu07Foy0ZrKHXYTXOo9Ba7m6bZ0z05T+81FVJI=
X-Received: by 2002:a05:622a:8a:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4f347f93f08mr1579311cf.9.1765847662514; Mon, 15 Dec 2025
 17:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1765834788.git.nicolinc@nvidia.com> <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
In-Reply-To: <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 15 Dec 2025 17:14:10 -0800
X-Gm-Features: AQt7F2pGryc6oZ72KleXBeas9fEej802hxD59J2edZO4aLe2-OI0GRs2t7Q1jUY
Message-ID: <CAAywjhSzKM_bEm_VbPZFffY9sR3-p==gbVppSL+555D1kPg_3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] iommu: Lock group->mutex in iommu_deferred_attach()
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, afael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, 
	kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, patches@lists.linux.dev, 
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org, 
	etzhao1900@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:42=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> The iommu_deferred_attach() function invokes __iommu_attach_device(), but
> doesn't hold the group->mutex like other __iommu_attach_device() callers.
>
> Though there is no pratical bug being triggered so far, it would be bette=
r
> to apply the same locking to this __iommu_attach_device(), since the IOMM=
U
> drivers nowaday are more aware of the group->mutex -- some of them use th=
e
> iommu_group_mutex_assert() function that could be potentially in the path
> of an attach_dev callback function invoked by the __iommu_attach_device()=
.
>
> Worth mentioning that the iommu_deferred_attach() will soon need to check
> group->resetting_domain that must be locked also.
>
> Thus, grab the mutex to guard __iommu_attach_device() like other callers.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..170e522b5bda 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2185,10 +2185,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>
>  int iommu_deferred_attach(struct device *dev, struct iommu_domain *domai=
n)
>  {
> -       if (dev->iommu && dev->iommu->attach_deferred)
> -               return __iommu_attach_device(domain, dev, NULL);
> +       /*
> +        * This is called on the dma mapping fast path so avoid locking. =
This is
> +        * racy, but we have an expectation that the driver will setup it=
s DMAs
> +        * inside probe while being single threaded to avoid racing.
> +        */
> +       if (!dev->iommu || !dev->iommu->attach_deferred)
> +               return 0;
>
> -       return 0;
> +       guard(mutex)(&dev->iommu_group->mutex);
> +
> +       return __iommu_attach_device(domain, dev, NULL);
>  }
>
>  void iommu_detach_device(struct iommu_domain *domain, struct device *dev=
)
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
