Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360693191B2
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121872; cv=none; b=R0pjCZCgK8xFqRpE98OSZHOSTJr2xK3uLvkLlNc6C47PVtktdBO8BqjAaqruLivDeySw/CS6L5YDc6eoMI17Hm4aXCxTmjeSMsELK+irGfYw909GzqWGTM0b4ivopF/AyanQG8WuiXd2BDOrhWpKy0kJ0IjowrOk6WRzs26iWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121872; c=relaxed/simple;
	bh=64hrnh+G03ii19qLsbC+gKG4i0vub0qBYZGHShiMxCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Q1dtqpvSvnAM4Ab/+ABw1LXnk7OpwYf5cuVgBIE7kss+gnbyMUeey1S6Q3pAdriPi5fdYAwdxsNfk8m8pHNXws8fw+f4KfTP16Ra9kW3UBQOngKQbrlUrgwdE8sQbSm2Leq+4hWePOHHDsAFmNXbCAKsZgDO1fcn34hcPiD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EHDLpfmz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EHDLpfmz"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523af71683so5466293a12.3
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758121869; x=1758726669; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=weVpY5S2PB5qtPhKTuvCTrn7esiEfFzwXr1/dTkYFP8=;
        b=EHDLpfmzA8MVpvGGqDLedyE/1rLkL99pSnsmqkkZoGuu7SVXkdes7zbIyD60HGV751
         F8CCLASGjUblb9WBettznjBsCAZZipH9apumUm71E9dNElzHJ6ZGsf9gqSInZtboF52U
         E6Zq8I1fO9zuGsfJNe2px6Q1pRCB0gIw6A+Ou+d4Npd4+yzyP41eGWK71ef3s8Gwk71B
         X4zj/g3S5RPG8FZj7KSfGpZg5aKcA4PO2QrH6zdNjoqyU0/4BITuQE1z0XlWlW0CqvuQ
         CE0RnGEBXQOPxcQb8lkZRrbeeMoJzdNFbFJY3mSfRA5fUfWFq719NT6/ezn9SVfe/ZCA
         ghkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121869; x=1758726669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weVpY5S2PB5qtPhKTuvCTrn7esiEfFzwXr1/dTkYFP8=;
        b=k9U9p/Z9CIas1Xqjn/SNchZyfXtvWs6SK5wryVRZwQENETXTefhFcGrEVnea6BoiPx
         IEeMnRcZpc30TiDkWJROYcd5E+ZrcF0Jm3PQWYe2s/yk09yT8n1iIaGvvEzBNGJxRByr
         ST/wkT+Pbo/8nbhYylVoHofCZwB0m85MrGH/ygEBcOMADXu5HZecivEVUyfwyRAWRx/d
         9B+4d2cVFH2KYkVWU2WZMuPULnYwQmJAHYnuTBDrar6tDCnQnemAOu3qQKwKLg3rXGBD
         nVR6gRAXex5gAxhZa+sdkhiuTqmz9EpyNl8ESwHoQTTOFbRma37AZ1RYBbKEWxFDPr7/
         11TA==
X-Gm-Message-State: AOJu0Yw6cXXOVywzbkUbqBCLtbqIXpYTFRT/dM5dFYof5vrxaCx4HLWa
	pFjxeoKPFIxNyc+XL7hwn/ULYJMmJZSx3CpOiA5R2SoQgiquBAgX6K/I3dajqfss6Hs=
X-Gm-Gg: ASbGncvWn+xRGLKzpO1S9xsalJulC4SGgsgQnz0nQf19rNcqL3GcZEbs+rZa105oId6
	PSouxpZWjDKMpc1LmZmnZw/8U0YXcBF0yLpuuC5yK7MHSkmLfP6wWNm7/pGNBNARx0LJWnRro3w
	u5nMMHpvmE4IsMHQ6Q7MTU2u5OLdO8g1YLrrWCvtBloA6oU622FcnhzRD6nVSo70thGEo9wJWwU
	gmLVlo/bjRhSymIAB8vp7AHD90yhWhNcNZIPwLkZmCk0XwPStAFnZ6HN2pbiMJNF/rEgE+jEujQ
	hkpUyx5mCTqpX+rhPWaSlDgFZaP/wRjo7TZMILllSXUPr0vxIERCepAdCI/mTH7xD8R0bcvj4Fl
	guALxkxo=
X-Google-Smtp-Source: AGHT+IFmYE7qlDUFZiho9mEwR2DSnCEfJp/r2TtZAeVeo8f4CW3I/2ig+DnSXAwTVwkjjffoimql8A==
X-Received: by 2002:a17:902:d582:b0:25c:9688:bdca with SMTP id d9443c01a7336-26813bf1f32mr31633255ad.50.1758121869329;
        Wed, 17 Sep 2025 08:11:09 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2623fd4d163sm127041555ad.80.2025.09.17.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:11:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uytoJ-00000008NeJ-3muR;
	Wed, 17 Sep 2025 12:11:07 -0300
Date: Wed, 17 Sep 2025 12:11:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917151107.GF1326709@ziepe.ca>
References: <20250917140216.2199055-1-smostafa@google.com>
 <20250917144435.GE1326709@ziepe.ca>
 <aMrNJw3obyu8IvBL@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMrNJw3obyu8IvBL@google.com>

On Wed, Sep 17, 2025 at 03:00:55PM +0000, Mostafa Saleh wrote:
> On Wed, Sep 17, 2025 at 11:44:35AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> > > Instead, we can remove the __init constraint, and be able to run the tests
> > > on-demand, and possibly compile it as a module.
> > 
> > I think you can just put the kunit in a module to avoid all this?
> 
> Yes, I don’t see the point of trying to run everything from __init,
> relaxing that allows us to use more of the kunit infrastructure.
> But, it’s more code to do so (it’s just longer to explain :)),
> I can add a patch in between, modularizing the selftest before kunit.

Sounds good, also it would be good to include the kunit.py
instructions in the commit message:

Eg this is one from my iommpt series:

    tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig

You can run that from x86, which is really how I'd recommend anyone
actually use this kunit rather than booting a live system and trying
to run the test before the system boots enough to explode on a buggy
implementation :)

Jason
