Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667A3112A3
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605805; cv=none; b=EO4lDOd6SLwzV4r2cMdkGURqFlH17gEVohPP1bhfW6PvATZC08F7vj5YDZe82e/TaVWp+zSC406PIoPLv2nDXC+GxEz02kYfSJ/plHDNTF62cXVw4D2Z8aLSwObdK+5jPk1cBRf75miAtWQLqSlL3hHyU3+l7jrI+zx9z0FYSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605805; c=relaxed/simple;
	bh=DlEwdt/1oVvgj+xrSw5FV5rN/OT/QnCBBXeLUsuO/CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBE+13yIaxXqp4/0Xm2GpNllFnU50/5UBourAN2Fd6mwMKI4g7hA/VN4X6fJZdrBJzelSiuS2mYsKGRVgSTrDC5x0WYN8Hyx27OkmT/fovS+JdAUxFGsUMvZJY7VeBNtw9dipEmN2TZIKKPq4eS0t3fLvpgN64kj5fmAkTjSQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoIkVoz4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoIkVoz4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so334293f8f.0
        for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605802; x=1761210602; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=eoIkVoz4QWBjT/xMXT2wq6eqiVa5e8CoBV3zNRia4EOmKsGyV/F9UNN59wCNpG+D1g
         r6Nlhryk2ZwgLQ/vEsTAq5YHFuOqlRh6RFdI1k33n0Y0VSTbYmm7zUKIxI06sO1UkEDv
         Od/hT31GfJMS4MOnNIl+Bg8ROigkCo1WSpfDKoPCCQ8zc/wt/r++pBF/WYlLQBFSP6KO
         FH18Feo/onLWa9rzo9tk/XPmz76PbH0UTwFaM/1r+EruFclm/1WZSEXmRCmK39vtMF1O
         BVve+WJpYhA0qm2zvPnikuqRRfPEuvGoKrBVydb0k9WqenEiOJurc0tWFXGqvxUanEv1
         nJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605802; x=1761210602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=BeVErUp91m53kWXgrr/lGW/I5Tp44tThVkL6eho4eq2Cq/K18UvF57XGsvxpLQPCD3
         rplSSc4WhMw/pGliqn2yChza0l/eOUcUYPAzWfb8WQRnV9DHfaz7hn5LB4ACi/rbtI0v
         2WdPYXZrheWMoK6SbVD5EeSIEKr3DX87lZ32cFEemR7AJ2u9nbmy3aaKx0i7ubZhjkfO
         fh5OKBfxProZUopwDBR0Ri4bWyKO1+AE0LPSLQhP2gWlBuV52fBd7wo9+Hpo7cGA3uF0
         8V+T5ybQFt7ogrmbKUdhJADFG9Y43MyWUzEWAUU7v6s0tTMBknflCsLaC/7Qh/dB2YZX
         Pq8g==
X-Forwarded-Encrypted: i=1; AJvYcCWyd5hEk4HcHjJUVZIfrzaVr8pWFCDZ+0wpH3OCy4vyucPEd7l5c1SbhI6hQE+yOlYgU3QTrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVxrmC00Mdr7qL5DGCoOTWnr9e/1kB1ef+LcYxNTOs5TgL+Caw
	KWdjaIkFJFBRI5+afjB63WaUfC6h9lMmi+jNW1H17OZR19J56f+Y6EH4
X-Gm-Gg: ASbGncvU38NbQLx+fxxesEEHbYNH/0B3c4/MM2ldukbiWQlpQ+UC+E8GLWrAyLI7a0Z
	wJrBjNb/Noyn3pxUh6RL+eic+RsX6ADKZPHcFEXqf1bRkOKH9UmMo6iv7c6VqimOKeODVKk2QyZ
	dBRfdgh1A4ZMkOqq4d1Vk3K457CAtO9b/7PpTDBRSjoO4/0EqbiVSF/YM0AXyz0AsGCxYLTk9yD
	Dt5G+F44/InQugyoAUT2h/ipg2cCJfjup49pyWjH9wkSPbslMRWyrL5aA+r/1+2mgXoDwZXhaLZ
	JyaLxwg+f7n4gtxNLn8+uMxA4zn/gV/E1yy3rbHe6/G4H6rrJ+ajKj/KCZ/KM1Y6XpGQCpall/A
	214VgY+X5P6wiiJKf7YJVQ2YmW2skTLjF5LhWKvf6w8+a01rEmdk9Xm5yABcsY9naLy9tgkNC38
	7ikdIO0Lhd41zskdMf/gq7VeFTmdE1s6wAqBQ9i826VFARqwjVhg==
X-Google-Smtp-Source: AGHT+IHu9qsVuasRZJiri7bGvjUh1qF8593kOXqmfugC2rLOQS9cOi8nsqbJlHpNN4XuyqQi9YJqbQ==
X-Received: by 2002:a05:6000:2c06:b0:40f:5eb7:f23e with SMTP id ffacd0b85a97d-42666ab2b15mr17600109f8f.1.1760605801871;
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm147894f8f.4.2025.10.16.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:09:59 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "alessandro.zanni87@gmail.com" <alessandro.zanni87@gmail.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Message-ID: <gn4l62kroj74d765uojx2vmu4tugxbmwnhodckfbath2pafeuz@nw2kudzcucv2>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
 <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Oct 16, 2025 at 07:47:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, October 15, 2025 5:49 AM
> > 
> > The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
> > 
> > Drop the '!' to fix it.
> > 
> > Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

With this fix a positive value returned by the ioctl() ends the loop and returns -1
to the assert.
Maybe better to put ioctl()<0 in the if condition?
