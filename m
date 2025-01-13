Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F724025B
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808355; cv=none; b=JHOwXvSPIKZuVk1x0DIdJDzeHwn7wvnWSE9VtA8DMfl2EKL5gMehdBWMK7ajWJvh7bE1xC0kdP0hdmCeKQIubMB9d32yc4tzpNdUBHVyApm8RgKa1jr32MXOTzX7b6nKWTvFmtrdtTTghFd+ygnmad6skjfBisKfX8gnHAcThMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808355; c=relaxed/simple;
	bh=2i8typo8HD9wAt+YwM+N/Am7xizTXjzVHDvf9OC15Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jcxGJms7kZ5UHdvflTzFj25M9anHwBM/XxFx5SiL+2kXaKw+8HKGXqDsFWJTF4xg7WDtcaR5Osxh6isFq7pvuiwIr/HVe9VEmAQUyZ4GRI7UuJmXLgAk7cwZDFDo90P2rvLEFqMC+WHeed3yNZor+AaWtPR5m7v5YsZRF15MSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upl4TqKY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upl4TqKY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so1127455e9.2
        for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 14:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736808352; x=1737413152; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM0iEdN1RDP34FbwI/vf3msxOkmXdAiG7RIVz8RZ6s0=;
        b=Upl4TqKY5lA3MKJDR1O/GXd1CSAQ5UE/NhYX2WdSadRXiQcmFP3sJGFNdfsbLHRi1F
         sNG45gzUXYzXZd9fjMDqZahs231wIVSFZJjs0B5IeYK82Z3X+7A+eWfkmcdJ7GzcFhrt
         +Bpd06BN3rSCXu76ihRqJ45dnKguXtL70SHY4hC5UxY4KVAOCSi6HUP3xDkaCyHAQBJv
         FLCZ/4dTNXV9aK5GoFrspph/UtficXC9dBnrR89A1Qyns2Lwnn/38A6OJx2ySOKqq5h3
         a9Tf74Nb9m9nc6hbjBUJdZLKsAx3x+al/S9ErFsUQn52s6o33gBl9zTuqjXTwXE8aLej
         +4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736808352; x=1737413152;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM0iEdN1RDP34FbwI/vf3msxOkmXdAiG7RIVz8RZ6s0=;
        b=h5DmOe58aVojHi1gW4Hdh38ZfN17jym4qOUrzzV+iN+OnAj2ylI8ZNwF8+YFm61tqy
         2u+o9n6U+J8ZmBaLCycesX23CbYuQhiU//yVQthIv9HYNoItD/AG8HkxyEv+oFtNGtW1
         C7FBC1YpPHCcO/Ln3C8MU08Xt5klyksHwZ5Hh5nlOf3+f6xcIjIdq+jtugcyI+aPaMRp
         gAfLQcmuOmYLObfaYiTSV9fERL6Xum6aD2dwxoEub+YCSHkHs4JeVG77gmRF/y800tyr
         Tb56ISQj1FQLeI786mdlgWzf45bDJfQoF/1Wla1PUda83yeKvk65moQ3XqbOwPAw16Iv
         rU3w==
X-Forwarded-Encrypted: i=1; AJvYcCVIlAzcySzIKdInxIZx+p2n8KT3dc8A+rzxceuCaCOFCC20igvVDVjPkFJg/n+sAXnSg1p5Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygkct1P/np3ZS5d8Z5x+oLDLxm5jH4k+lQNOqDdZiefC8mu8/D
	JrM29I3HJPRj1KnZn64Z7dYrTJkTpknRFg81Fux5XGvWSgriHAv0
X-Gm-Gg: ASbGncs6sTPNBANIpV38dvTlu+DXeJ00BqSx/rcifOWjod9zvU0kB+MTXC9MR+Wd+6x
	qY7t6gzO/pDPek6XpeUOj3jlGZ8ZIwPea2vGDx33febuotIjVwBNGs7U9/Wqqavh56fS91c8t9+
	5EwZAKYfI/yNPX85Vo6ZIEux8OP2AusRR6XUYbaKelE8FN/2yEg6eBv/67fIQvXh07j0yCemqLZ
	xLm37krnD8Z7XTBWSCJqge/mwNnuWmfYE9HaWWEhGK+FII+7h+MSN0yb7fE
X-Google-Smtp-Source: AGHT+IFMBMp2BYedLlPToUVUltg+GUaxDTcmND5Gp7d4I/3kvby+tldtQDWjNbi/Kwska5uA0mAd4Q==
X-Received: by 2002:adf:a295:0:b0:38a:873f:e31f with SMTP id ffacd0b85a97d-38a873fe683mr15834202f8f.1.1736808352157;
        Mon, 13 Jan 2025 14:45:52 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:af9a:68cc:e070:12c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3838a3sm13321726f8f.33.2025.01.13.14.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:45:50 -0800 (PST)
Date: Mon, 13 Jan 2025 22:45:45 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Joao Martins <joao.m.martins@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
Message-ID: <Z4WXmeILAzTfb1xO@qasdev.system>
Reply-To: 142a177f-4e3b-473b-871a-2e929240efef@oracle.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 13, 2025 at 04:25:29PM +0000, Joao Martins wrote:
> On 13/01/2025 16:22, Jason Gunthorpe wrote:
> > On Mon, Jan 13, 2025 at 12:00:29PM +0000, Joao Martins wrote:
> >> On 12/01/2025 12:39, Qasim Ijaz wrote:
> >>> This patch resolves a UBSAN shift-out-of-bounds issue in 
> >>
> >> Avoid the 'this patch' e.g. Resolve a UBSAN shift-out-of-bonds (...)
> >>
> >> The Subject component part could also be a bit more specific e.g.
> >>
> >> iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()
> >>
> >>> iova_bitmap_offset_to_index() where shifting the constant "1" (of type int) 
> >>> by bitmap->mapped.pgshift (an unsigned long value) could result in undefined behavior. 
> >>>
> >>> The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
> >>> the shift operation overflows, as the result cannot be represented in a 32-bit type.
> >>>
> >>> To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
> >>> to match the operand's type.
> >>>
> >>> Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
> >>> Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
> >>> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> >>
> >> With those two nits:
> >>
> >> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> > 
> > It needs a fixes line too
> 
> It should be
> 
> Fixes: 495c06d82ba ("vfio: Add an IOVA bitmap support")
> 
>   Joao

Thank you for your feedback on the initial patch Jason and Joao. I’ve incorporated your suggestions and submitted a v2 patch for review.

Please let me know if further adjustments are needed.

Best regards,
Qasim
