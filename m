Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAA26FDBF
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212119; cv=none; b=W2PfWQ6M2vr/FbJYx7KTS+E16S+vu4x1jGQ+56Opd9MC62KeL3LQAuoXDg98aMo+Nnt8iR0lW/bkDgDSz0iUQlwvY2lNyWrIyFQvO83ro3S1BMdQ8fuT0fColMS5V8HetgbwuW0QuwpoCRiMAxTrCW7+/PqKianqo855tnD6Udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212119; c=relaxed/simple;
	bh=NvOeEpcXCwTZuKBEM0raiV4vYNrCoK5/TZbsoR30aEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uazw24ZrPddUmZauNLqKHvsS03RWIamWtRR2jkf/RMH+gLYU+dP4SonjUvpQqc8GZ2oqZUpnWkhg+rAt2Pgp6XghMQpjYywLl9KfSp/QRFazz1uj9wCF866Bnu58/LK9cWg6NLFJZYE3H8+EygdSM29ykjCnrfu/bWpn4ZGPIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mckU1pna; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mckU1pna"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24664469fd9so31777915ad.2
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756212117; x=1756816917; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T84fHSOjtH7H+COR+2RAmmEuuAs5zWdfFcbzGcITMW0=;
        b=mckU1pnacmHJT6gqRWtiPceoYGMOL5iQmvHTaYPoFpYyTA2cLJTcJD3sX84ZLgrrJD
         bZqnbOvJGOLfgFG6tATMFfNnFN4ExnDMXT8g+RSNl25sJ0WfkZt6P1lM74kf1NY9Xz35
         QVaS3OngDdjpB5poWY7DzcTI4XIlHg2A5pfw0QSCgZPJ3mMo0O9r3+2RYEufhlEzb1oO
         bV/2jzTbQsYguoThR+wk1dBQvZkM2Orv/iSKu1RVy49seXH3xXRwKNqLDf8FJvFopt3J
         B0FGdka2KciIER1lbzy/yLI/hHma7MhiX7kqw9HN2eBnPzssLhHOST0dSJYL4OIEX3cp
         1cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212117; x=1756816917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T84fHSOjtH7H+COR+2RAmmEuuAs5zWdfFcbzGcITMW0=;
        b=NqMJrond0FnTntJ+vz5HrFYZHBwvuP78QtBNRMvG1eo1pibQkjctKouoCsud5NAUY8
         1xYg+aa3U8mUHlgqhKAv8FdIT660xpmHCfWfosOf5NKyV8YS4QPRWpAFztlwEFz7kG3l
         HoBBu96faVR13zK3DmjgwF1v3+eivswbxaEmnYhPqawfNmVpgdFIzvABFHAdqn0MGFLA
         j6fJixsTyHYb3JoswvdNHNtc8BUrsi4qAuQmyMpz2SvLlquCx3StGHHUicUyQbnAHD//
         FG7lzp0rBQx0JWN8sg3FbMpRVQ2/ZvJ+p/FJeaxogdi4BX/d3tZopjh/emMuoACLTrxP
         dYbw==
X-Forwarded-Encrypted: i=1; AJvYcCUN2t6ju/Rnftbu3o2FIoGI9vCHs79B1hrUIEKpceteXVkPTy1l3bpX4GkVBVWDFXN7ddXXlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsslDZV4/LsLK4tQjNrL5PKiS4PPGo4w0oij/7vWKFtQXkNyuU
	EuJaUrbxjoFybVfmuQ5MbUSrBWr+x+Dw44w/vPL8auXikXiJl6ELukoosoyhK1YXPw4=
X-Gm-Gg: ASbGncsVJz/JVDjsfxRKZfn1NhW+bnxVh71aVfWjZ2l+dI50w5FZZf70LMJ/vuCT+kR
	iC1Lc2IZFgkbHOqkmYoKrgsHDVvXnoLWURjXaszACfiBtKeKfJByXidQiTcHaaI3G0IQuIa0eoJ
	OyKBqvcHYkxKV91xg2avEd+lvAq0IAR++cqc2Loi7JjEJne+o4uxBL+qxuqzVst4ETAqM1ryCiL
	2lCYvIH3TWllLAJwJvroiGjd8hFdXt+X9TLS1uFBETLmfSVCjufIjCJUMPd0WFtB7mVGw7YPIuk
	5oVqOQDs/3ferp/OkpXIFp09gLY3WVGNBb2+cTQtktXKQpbnwi0y3d6jnD+fBgDTCvnSrp7x
X-Google-Smtp-Source: AGHT+IEf2ObCWqklpLUBYBGCp1bYhdjq0lZf9FXkeM3wbZQ3D6NSnsFJXJkCjceBlS7IcS93bfZjTg==
X-Received: by 2002:a17:902:d54e:b0:246:a8d7:5bc1 with SMTP id d9443c01a7336-246a8d75c90mr130116235ad.39.1756212116823;
        Tue, 26 Aug 2025 05:41:56 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b4577sm95940715ad.61.2025.08.26.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:41:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqszr-00000008tSp-1M5u;
	Tue, 26 Aug 2025 09:41:55 -0300
Date: Tue, 26 Aug 2025 09:41:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	p.zabel@pengutronix.de, mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250826124155.GD1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
 <20250825170531.GA1899851@ziepe.ca>
 <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>
 <20250825183122.GB1899851@ziepe.ca>
 <441df5ff-8ed4-45ed-8a52-b542c6e7d38c@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441df5ff-8ed4-45ed-8a52-b542c6e7d38c@collabora.com>

On Tue, Aug 26, 2025 at 11:52:37AM +0200, Benjamin Gaignard wrote:
> 
> Le 25/08/2025 à 20:31, Jason Gunthorpe a écrit :
> > On Mon, Aug 25, 2025 at 01:50:16PM -0400, Nicolas Dufresne wrote:
> > 
> > > Jason, the point is that the iommu and the VPU are not separate devices, which
> > > comes with side effects. On RKVDec side, the iommu configuration get resets
> > > whenever a decoding error leads to a VPU "self reset". I can't remember who from
> > > the iommu subsystem suggested that, but the empty domain method was agreed to be
> > IDK, that seems really goofy too me an defiantly needs to be
> > extensively documented this is restoring the default with some lore
> > link of the original suggestion.
> > 
> > > the least invasive way to workaround that issue. I believe Detlev tried multiple
> > > time to add APIs for that before the discussion lead to this path.
> > You mean this:
> > 
> > https://lore.kernel.org/linux-iommu/20250318152049.14781-1-detlev.casanova@collabora.com/
> > 
> > Which came back with the same remark I would give:
> > 
> >   Please have some kind of proper reset notifier mechanism - in fact
> >   with runtime PM could you not already invoke a suspend/resume cycle
> >   via the device links?
> 
> when doing parallel decode suspend/resume are not invoked.

It was a proposal for an error recovery path.

> > Or another reasonable option:
> > 
> >    Or at worst just export a public interface for the other driver to
> >    invoke rk_iommu_resume() directly.
> > 
> > Sigh.
> 
> An other solution which is working is to call iommu_flush_iotlb_all()
> before decoding each frame.

That was already proposed and shot down, it makes no sense at all use
to use flushing to reset the registers because the HW weirdly lost
them, and flushing should never happen outside mapping contexts.

If the HW is really resetting the iommu registers after every frame
that is really just painfully broken, and makes me wonder if it really
should be an iommu subsystem driver at all if it is so tightly coupled
to the computing HW. :\

Like we wouldn't try to put a GPU MMU into the iommu subsystem though
they do fairly similar things.

Jason
