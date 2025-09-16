Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987523BD1F
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027765; cv=none; b=TtV7joAXGDSs2Q8zp18dVWQ/dvdoXDrKJeY3eZUa2kFWI2LHT6ze7sUkSUXNDFNZa8PTmit+E3wKV9SY6MwPTR6ULKb2iMRZX3nuNbDRj6/Fm9nwQrqp2GfbkJ9S0YZVgCt6yOoAAtfkbg29PwwPFSnzPDgo/BFxsXFTWpkA604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027765; c=relaxed/simple;
	bh=IHIAB69PsK7W4sFK9/F4t7y6OBjeQP7F71nwjhXw+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEPk94s70+H3Ma492dXwbOkWUgW+zKhJ8xFa68hFQsuAiYBxGpqHML4iXtr09x3vmdwITCgZ+AVo2rua4cf1aMBmX92Yoz1Mi6QrDK6cGHjThwWbw0LNWwOj8dj2SmsCxemjnpJMtAEWDlTx7ztyscWB42BC0B+1nd9LdOKkURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mWTIemTG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mWTIemTG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-812bc4ff723so502982185a.0
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758027763; x=1758632563; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XVbefYP1T9aC1YC53q5bs8AZBmUU9WkTWwN/oYv1o=;
        b=mWTIemTGJRsVzjPP9pRg6NgDNxYRpoHYCIczVxgnIqSDJsvOxhLSWGntD2mMgKyIvq
         b2vTPBpS8snJVVBNqtxIAIKtPgUbCs8JBaC4brJBJBSkIz2Mtid/RO7gm6pUJWCSxVPk
         iRVOFWExYqsMS1bx8YwC9dznhKumEOD2nwXGu4kChlUf5aed/ikwJ31fwZuaZcGGIqOv
         nm9XKv1qlw9ysQp91xz3riQcWobVSITvMkDq9CI8sqURiYHLR7kZ+CPbP6RpVVxwecBo
         ZdUphZMxGbGV3kYspQllaH2DLXrTcodj9o3fXZ7ZyqKXK9YoKl9QkEQhzlIiS/nNSCyq
         7M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027763; x=1758632563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7XVbefYP1T9aC1YC53q5bs8AZBmUU9WkTWwN/oYv1o=;
        b=tnd0PaFRGp8cgy9WUfjtBvkUQrBouCYcfEPs1dg/9E02TrV9l52AbNmn3WCyC4CqGl
         ynQn79gVexVqpeB1Dc3kR2irk9NoJpCbM2qqIyNu2KfRE3SHADV+HPGoa/4deUb4Ahdb
         Uk2nILHTsLtb5f71N+mjqJBIzuKlMrGIrzD/b2NhpmRvcBlEfMiEzDb3YcesCt0R8j3W
         CO1PKx3pFU2R0RK1yNWUO/6F1S53qhRqz8pxXD7ma9Vu1Wls6451UlgS/3obVImdJoNE
         VuUmwingjFwj4orVnmP3PRFHeZArUtb0m4vDpAv/5hI7k0nqNLmmyVAjd/7zQ1mFD+Hy
         P8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVbfbiMsWSb1JHpnPXBciX5kS6omrXVIo0PTjOYCGc/Jq3KGOTZCaqrrTKWG7CrFk2WndAVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYXmH7ERB43qa5/cs3GrnBGVeI3WNrV9hU6AfhleJRgPVACrGw
	Z7mcwsT+obprCR2k3VlC/4HnERmtIT79vcBenOIwwgcYPS4eNrEPfoZMPIl6hEoByGk=
X-Gm-Gg: ASbGncsqZyiWQM69GpbJJsL3ApdupZyFQ0kmTIJ/ibZ0f3UiwisQOU+6NPVQAFAUwBz
	CSdFmeCVI+qxzC4irtufqRKgRmlmD10VAciWOCtORBg+nDS2jr8Uki7jvls1bY52rNinoOJECnX
	w/doCfWpohlddxJ2agZINOJ3j/zYnJGqpDayoy1ALme6AvsR2bgHetsOxG/ARg7fDvMlsZ6LiyN
	NIzz4joVuCx9WRI5oJXj+mAqHZcE4FgkRD/eHALrogv6Q2v/LpZHChgTvN1aiT5V3VdVKLOr1II
	kQS/gQ6dgreV7dvaGKCmTeuadRK+ANK1cKuqbujSk+6u0nosu2AeySQ7UNhaOTP+LzvO7qqX
X-Google-Smtp-Source: AGHT+IGgSNjoagg9mR50jyVvqVknWt7pO/h98DmCtfm4l0bnsXbM49f7ZWlU8/4EiRAMYAi5HACKDw==
X-Received: by 2002:a05:620a:a483:b0:813:4da8:8653 with SMTP id af79cd13be357-823fc1d4cb3mr1861079585a.25.1758027762539;
        Tue, 16 Sep 2025 06:02:42 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19d151sm932484485a.50.2025.09.16.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:02:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyVKS-00000004ePY-3X0g;
	Tue, 16 Sep 2025 10:02:40 -0300
Date: Tue, 16 Sep 2025 10:02:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <20250916130240.GO882933@ziepe.ca>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
 <20250911155720.180465-4-benjamin.gaignard@collabora.com>
 <vrngq76nnms3jyl5hnxqnkimjc6kil66o6fdyqn5vm3fpovmja@cfynipjw7ktp>
 <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>
 <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>
 <20250915225806.GM882933@ziepe.ca>
 <aMkkYU-p2ouknnAc@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMkkYU-p2ouknnAc@willie-the-truck>

On Tue, Sep 16, 2025 at 09:48:33AM +0100, Will Deacon wrote:
> > I would strongly object to trying to share map_pages, unmap_pages,
> > iova_to_phys, free and other iommu pt related functions in some
> > limited way instead of helping on the much more complete iommu pt
> > work. Which is what I said to Will, but for some reason he suggested
> > it anyhow.
> 
> If the answer is to convert this to iommu pt, then so be it. My
> understanding was that was still premature at this stage but you know
> better than me.

We are waiting for reviews, hopefull when people return from
vacation. You know how hard it is to wrangle people to review it. But
the code is all done, it has all been tested by multiple vendors now,
many people have projects blocked on it.

If this duplication is really important to you then you are welcome to
help review it and merge it. As is Benjamin

> When I bothered to look at this driver side-by-side with the rockchip
> driver which, despite apparently being totally different IP (honest!),
> is *remarkably* similar, I summarised the similarity in the default
> domain ops:

Presumably there are more HW control bits in the PTE than just valid
that we don't know about..

> I don't think it needs to be one or the other. afaict, these drivers
> should share the default domain ops and if the page-table code is using
> iommu-pt then that's even better.

Refactoring rockchip into an iopgtbl, and making it work with this
driver is quite alot of throw away work in my view. I would not ask
Benjamin to do this.

This is why I offered the compromise that if he writes and tests the
iommu pt version I will carry it and he can merge the driver
as-is. Hopefully in a few months it can all be sorted.

We can then attempt to convert rockchip as part of the followup
activity to try to move drivers to iommupt.

Jason
