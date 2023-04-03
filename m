Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694917EA
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 07:53:03 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id l37so16502110wms.2
        for <iommu@lists.linux.dev>; Mon, 03 Apr 2023 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680508382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPgrU4Z8XYjk4fMfR22v6XbCcy+tUvCSuO/FiiIn/Bk=;
        b=RVLREcE/An3GlMLnTQ3YMjxmYckPepdGPCI3f83DzcmAV2+z5gMJcG8tGZNgx2/nUQ
         Gk+dB9SD9ecWkSwh7wqZ09COase6mQKVqfcyiI3uqYAoEPRia/qcd1NNaAInQd0+HH2t
         yVPl2pDzNVwiNQhLejuUeH4aDzf7z3dczrrSHtUDzTd9IOyViW1zb4p9HAB6A+cRkC4u
         TL4QUcXONgM/PjnGC0VxA+6oomVy5/da8D040Xr90K3M1D8wNhJR3TLkhio1pIaFddT/
         uyh5Ko934HkKRjC9LUN6MXp6MV+YvrEd3mY+bYFZ0T5ebSh18G5BZp6ilBTR//K3zY+3
         Zctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPgrU4Z8XYjk4fMfR22v6XbCcy+tUvCSuO/FiiIn/Bk=;
        b=3LRKw8CDzLYU1iPjwUYDyf7BwuqWygjHayYiljcTdLPbdWZ6M2gBuQTP9TnRus12h2
         pn/YPXQ4oGN0HfwMszkGRqfoc7p7SOgpGhrVtkYWoDlDhpGsQk51alhxSEqVVsuPjmja
         589X6LWL6VGW+co6hQAijbgPiOJehgdhbP7YwizJwvQtqW7Av0j6hr9Hq4wB/bnxadTK
         kal6NQWlHHn1nw6CqUgbOppUn1xlBVf/y3K26LKecgsO5n1pICiWoUhNvHZsPgxtcUJ9
         s9clBfaFH10XpRie4IClboIyBsIqOPpBJ/75B4vFASqUxDkOYIv45NsGJxEXpyZQwNqr
         zJ7w==
X-Gm-Message-State: AO0yUKVPreVpHLtogORYiJY7D87vgic0AQTuLNXobY/v+IbbOqY06skc
	tevlqPRJV+vuJ4qDJRX2/bYgtA==
X-Google-Smtp-Source: AK7set8TOMO8WIe4wP9znJDPEIKrZqcMiUfetV4fAY2sOaDxtIZqtI2PkZdZudkS0Omzp2n+Frg3fA==
X-Received: by 2002:a05:600c:220e:b0:3ee:a205:848f with SMTP id z14-20020a05600c220e00b003eea205848fmr24749444wml.20.1680508381954;
        Mon, 03 Apr 2023 00:53:01 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b003ef7795e5a3sm18727887wmo.20.2023.04.03.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:53:01 -0700 (PDT)
Date: Mon, 3 Apr 2023 08:53:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Michael Shavit <mshavit@google.com>
Cc: Will Deacon <willdeacon@google.com>, robin.murphy@arm.com,
	Daniel Mentz <danielmentz@google.com>,
	John Scheible <johnscheible@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [Design] iommu/arm-smmu-v3: Implementing set_dev_pasid for other
 domain types
Message-ID: <20230403075303.GA5002@myrica>
References: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
 <20230324123125.GA1061401@myrica>
 <CAKHBV25_hJU3xgSt3=xt7LgoF=15=jwo9A_8z9A5yi7-CZk2Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25_hJU3xgSt3=xt7LgoF=15=jwo9A_8z9A5yi7-CZk2Cw@mail.gmail.com>

On Sat, Mar 25, 2023 at 01:42:22PM +0800, Michael Shavit wrote:
> On Fri, Mar 24, 2023 at 8:31 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > > As a first order consequence, when multiple devices share a domain:
> > >     1. We’ll use more memory than we would have before.
> >
> > I wonder if we could save some memory by reducing the allocation size for
> > single-entry context tables: it looks like dma_direct_alloc() gives us a
> > full page at the moment even though we only need 64 bytes per CD
> > (and S1ContextPtr alignment is 64B).
> 
> Oh interesting, I can give that a try. I'm guessing you mean by
> allocating from a pool when a master with ssid=1 needs to allocate its
> cd table?

Yes, adding a dma_pool for this particular case could work

Thanks,
Jean
