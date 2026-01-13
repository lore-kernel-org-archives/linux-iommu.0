Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC161318ECD
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334791; cv=none; b=mqJ7shPUTMjacZK7WPk38dDqB5cDMDCQoELW6fUKZO5IWpiqgA1iIElGyB995RFtH5YXX3bOD4xBG7a4tfbYV4thsCcz/xEwAw5IMfeRF1/r+Bh6enElMGRlWMrRz/ZwSLkHkGc/JY5UXEEtuiuXuVTYkotzkrf4BJlklvWLBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334791; c=relaxed/simple;
	bh=SXeVqrAxRNSkbAqiUR95aiCk1pP0/f44tJZoVaiTKdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkZJTDHGQxKEPKww2YtnZuWzI61HHVjLpcFDpxx/6RRLjfxJ4r29sfNEkVbSfNjVJky2BmSxmTw0K0ujCkp5xxfam8mFD/T1zCc8Wb49krLh6MWC/7e9hMlwaPXIRuusiEmBQJIm9nJK6TY4oLXXMadue5Q7TU9Pdkr9b66YdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iea6tzw1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iea6tzw1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8707005183so462039166b.0
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768334788; x=1768939588; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poJusVDfcWw/0sEwE+/iopbM/pyMLBED41iUqzSMc7A=;
        b=Iea6tzw1IvasQW058GVSvXqHZutlIcj1zcYodQla4sdirGtfHMXm040ZRaOnidoKqb
         e32BZ7RJkl+Z3ie5umMEZhBCtEG0pa3nmZT3hxW/zP7nuO2QS55kgLR0/JILrLYK/xqO
         JcWo6Sz0MDRBI+NDL/3G4J+UQIlvSdC0tEQ4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768334788; x=1768939588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poJusVDfcWw/0sEwE+/iopbM/pyMLBED41iUqzSMc7A=;
        b=SGB961v+2PD9dE/Om/jJsHhGh4PWmm3GsC32iis+wsNulHPVwqEQFdZYYc5pfb372D
         pCmuJhoeYj686tVOpWERF6m0mIiHAS4QPl6M3kU3yLWkC0aQeximVh+Rvhimz4NXSIGw
         3r3sVUEui25MURdBNXmjUFpleXg01BMXJgi3ZxTkyl3EY7bPYUS9htTdggAb1E6eWX74
         Zqic7RXCzZjFSSWRW8mmc0TebZByag4hXbEvfFc2S3FwQEdkq4X34M3tcpzMr72qOFLq
         0+FXa4QutfhHSN2RBemhfiFp/AUvq3A9b2x8u46civ2CyjUUTDQuQb23sMO4nyUU1WmI
         USbA==
X-Forwarded-Encrypted: i=1; AJvYcCWyDol0C1YmsvXZI3mou6BpdTkDmRniaz8AwtSuK5Ag43P2MCKHpv8FLyjEUJJIvUOtMnaieg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOr8RT03S1YuH8pIyz/hZUTe8RK9yaMCGV6TdGC9AlqGywypbm
	Tsqf/MZuAgBMTJecLjme4qaXMuvJNoSOKsx2sn2XmZ3yZEnaYxtCirajLDYHBz2D2Q==
X-Gm-Gg: AY/fxX7vd3LH7Sx/g3G6YsJZNJ1c6C2ExhPdaJsUeCgrkNFewtDQk+pcSNqigFeHeOQ
	CtkjIs5pxuXsbCgXs9btwpFgmva5mG5wuRSrXnBzU7wtGmdD5h/LE/uLJiSaz4h+NvtSUCUdJpg
	/iO6an/m3/LmPDYn4TjGRbYg+DjqnMA4p2qObkQIsesGj7PiBq3etA2Zzbm9tYiIJ8XCvdsiHot
	tZpMGk8b4Ce/0KCdEE1XrmUzKmmMeOwnB7YEtZtkbgpP75tWMkKcXRjPrivbwFVQxjJNl94pusU
	6859L3wrJWfA8b3rtHHmCw8CPAPDskQUMbY94yybDqEy9+XeLNPsqaka+h69JZBZmkTRazuPzZR
	CcaIni9cITJxc+PPxLSRds0zumwQkEgQnEK5N00eyklLxq1pxnqZAcrjr5XtZgo9eV1quYw==
X-Received: by 2002:a17:907:26c8:b0:b87:124c:5f54 with SMTP id a640c23a62f3a-b87613e097cmr22645166b.59.1768334788215;
        Tue, 13 Jan 2026 12:06:28 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:e42d:53cb:2a0f:636a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4479sm21104781a12.1.2026.01.13.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:06:27 -0800 (PST)
Date: Tue, 13 Jan 2026 21:06:23 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <aWalv0gG_DqxZxz6@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <aWafiUwBI8togJvP@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWafiUwBI8togJvP@google.com>

On Tue, Jan 13, 2026 at 08:40:00PM +0100, Dmytro Maluka wrote:
> On Tue, Jan 13, 2026 at 11:00:48AM +0800, Lu Baolu wrote:
...
> > +	default:
> > +		WARN_ON(true);
> 
> nit: WARN_ON(false) seems a bit more suitable?

Ah sorry, ignore this. Somehow I thought this was returning true...
