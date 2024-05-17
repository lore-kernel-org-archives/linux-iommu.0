Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E013DB96
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966392; cv=none; b=JeCg8qik5IF9WKxz9GFx3naNkgnDrQEOp9R08p54ly/FfljNKeMF7VhoEHvn5ZO+iu/ATPz+6WcesuHcCTw1ZUdmLMvv/Gt1OsvMRlKylNgnzmZVtr/HFDn3QIlh3QhBtQYia9lL0MmWnkqmX8qzlJjBnbaGlooI9/oJksKuLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966392; c=relaxed/simple;
	bh=9lqaZiLXVqQKz34hEpjrAlMK+jXub2IrwnL7zPj4nzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hg/oIlqaL8OYAcD99gKiF967XU3deTkfEQXC9SEm37VNQemUD/kr3Kdf1dLj6uXqoBuVVif/Tv384NOMI/FydKi7SYZtmROcRXYbFL8SU/4/kvdhzRQetJCQXqqIxuWjMQuPPnVix4rxsS2XbHRvD7DTtc8fTj3G/m3tzO7RmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJNHG40N; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJNHG40N"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a077a861e7so6926136d6.2
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715966389; x=1716571189; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvj+oLK1oxIlGb3spxeAPsEXiUc18MOxDzwp6iBcUmk=;
        b=WJNHG40NN9a0WAkBPPOi25DtIrA145q74Ie+aWGZxu/rwiEvWW1lK8NuKkf7e/wE7n
         A/sO7aBvPxiwbNJ76oshlQMq/ezGkuDkMZXJLI60Sg+hdQ1tGh1mFJ+rRvIPODjtTnyB
         90sObLAji4bM/2iiXpZhzyxY9b7PN0DHvyLn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966389; x=1716571189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvj+oLK1oxIlGb3spxeAPsEXiUc18MOxDzwp6iBcUmk=;
        b=WrejsycVFPQxqKJgTzimdzdX0HcBze3Tyk1Tx3lRbVfu9DnQbNgrd/nsm+DbMtFe7w
         CHmP+cS1zQ76xi5V+2vI5uCBCbn8EQTofpgKzWx0GzLHLEs6VQJZ1XoU+fqYFBeQ2vFU
         XoXT4reLV19KzXjZTwlm5yHLp1+8vCAW689Q1bte3I+8nlCc4TUtxaFchetd7umIOJM6
         hQihOc8q4dcCd2AckVFs4S7RbPXZwdtc64GbXkZF6wI4SBoz6LUBMPAbuFxy0bHxvePv
         8jgX/hYlzDkrVXcX2K2osc/dntn1Q6ta+gkwOna0MGJBSfTBhJnTT+5bSjKcXFVCgwb7
         ya7g==
X-Forwarded-Encrypted: i=1; AJvYcCUnK3HTQ4fHTzMe/9/ONxBs2x/Zku+3GXOP2eFfk1Iua+Bicf53uwLKH8SVvKeaZeoYlkVq7z96jvkqq6psoKPeSC3Is98=
X-Gm-Message-State: AOJu0Yz1pXdinbEF4pFJdU6XuWRG+X/gwiwl5dc/ZiXjVvRdeJ//i/aC
	TVdL4ZWxbQ4YHYFtvXKtF5AnVCWryqa3daBwzW0tl7UH86sAj7qvqlTeoWE3qzs9IJcmO2vOKBY
	=
X-Google-Smtp-Source: AGHT+IFrGSv7MpXErCS0nMraScbvqzZBXYt8jcuD1GU5lGcN1eArVI3tqZqx9d6xHeSrHouSeB47jA==
X-Received: by 2002:a05:6214:428d:b0:6a0:cba8:68c5 with SMTP id 6a1803df08f44-6a1682596c0mr276079456d6.60.1715966389012;
        Fri, 17 May 2024 10:19:49 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d912dsm87507946d6.123.2024.05.17.10.19.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:19:48 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43dfe020675so23391cf.0
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 10:19:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXv7f+dM4EpwZxmGU0b8jqpPOPcDEACPTj6m6UoFVq96yNTzlgkjVhmGEZwj/DFmDiJpzABMagfvejjzsGSvwCOTWTXFCI=
X-Received: by 2002:a05:622a:410e:b0:43c:554e:b81 with SMTP id
 d75a77b69052e-43e44c22ee8mr3422401cf.23.1715966387328; Fri, 17 May 2024
 10:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
 <20240517163742.GA525@willie-the-truck>
In-Reply-To: <20240517163742.GA525@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 May 2024 10:19:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Message-ID: <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 17, 2024 at 9:37=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
> > On sc7180 trogdor devices we get a scary warning at bootup:
> >   arm-smmu 15000000.iommu:
> >   Failed to disable prefetcher [errata #841119 and #826419], check ACR.=
CACHE_LOCK
> >
> > We spent some time trying to figure out how we were going to fix these
> > errata and whether we needed to do a firmware update. Upon closer
> > inspection, however, we realized that the errata don't apply to us.
> > Specifically, the errata document says that for these errata:
> > * Found in: r0p0
> > * Fixed in: r2p2
> >
> > ...and trogdor devices appear to be running r2p4. That means that they
> > are unaffected despite the scary warning.
> >
> > The issue is that the kernel unconditionally tries to disable the
> > prefetcher even on unaffected devices and then warns when it's unable
> > to.
> >
> > Let's change the kernel to only disable the prefetcher on affected
> > devices, which will get rid of the scary warning on devices that are
> > unaffected. As per the comment the prefetcher is
> > "not-particularly-beneficial" but it shouldn't hurt to leave it on for
> > devices where it doesn't cause problems.
> >
> > Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher err=
ata patch fails to apply")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
>
>
> Just curious, but did you see any performance impact (good or bad) as a
> result of this patch? The next-page prefetcher has always looked a little
> naive to me and, with a tendency for tiny TLBs in some implementations,
> there's a possibility it could do more harm than good.

This patch actually makes no difference on trogdor today other than
getting rid of the scary warning. Specifically on trogdor the
ACR.CACHE_LOCK bit seems to be set so the kernel is unable to change
the setting anyway and has never been able to. We are working on
figuring out how to fix the firmware and then we have to get a
firmware spin before we can really see any changes. I'll keep an eye
out to see if performance numbers change when the firmware uprevs.

BTW: any idea how big of a deal these errata are? We're _just_
finishing a firmware uprev process and there is always pushback
against kicking off a new one unless the issue is important. Given
that we've been living with this issue since devices shipped I'm going
to assume we don't need to rush a firmware update, but if this is
really scary and needs to be addressed sooner we can figure that out.

-Doug
