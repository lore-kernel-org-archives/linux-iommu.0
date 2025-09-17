Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F2302CC3
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120279; cv=none; b=p1JaMZwnlpzZ1pNGnKBMzytHZ70q31xH7BrjfMBFOigS9hS7gTJOYkaJ6mPQHZQcu0aMS+nmJjIby6RJf9z82+zQXbxOC2tknwxpm7+W4WNNm1nPTDXDNa41yImf44QWJOIdVqYJSKIh4vY/XoUsv9LlglBQMDp8UMrKIags02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120279; c=relaxed/simple;
	bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5iQl/BoqXDKzd1iwhTjIQbytIbEMRKkKyde+8ElxjR8FHfnYC5+D1mwJ2Ij3UDO76amoWruzP9spNIdh4JfOdGtKi5TeVNm2NmZzV+0cjnqsmnvU7y7RaVS5qm9KrvdvFppXTUAYUMdtDZkzotAIKEcjoTWQOUCkMWwemepEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=COx3G3V9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="COx3G3V9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so5479746b3a.3
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758120277; x=1758725077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
        b=COx3G3V9GEjb/6+dMa1+YRo5wdQCfK8Qp/hcs2wYTHbeLwHkjcLFONPQC0hZwvDxHT
         ERjbr5upK79fjF703XQmAajVoNe0UZ6xTa9Fynrg5T2ah6C2f6RV6dIi+LXT2Ae/WBrG
         O8O08drqiZdOBPd4GSeIRk/DyJCHcOAVIfiHGagStZTau4RhQyPPK/fYz/qqAwA4bDI6
         5kDANdBd1GW13PsZTB+2qqeMFqjasFRf4Ta+cRDPDJ5r9G05BypqN3zwg/WP3hUSyTVI
         dxLkKV5PNjZqOgMXG3S+RRoWHfYmd0lzIQah4YmN6LFyy53GBp2KLp8ezUWzRNiT0mkc
         8T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120277; x=1758725077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnJnkot1+rn4s3cdxJNe0XcEndPrzF+uQQTDlNWewzk=;
        b=v3XdzlcxcV6O81jxXbC7EV9h6+nmY4hoEF9NpwzcGN8wgOAU6QmPjyGLNP3Qkgl7NG
         Tg3dI4i+cK0cC9mZyjM1aVhFdRmtqGJbTfVhDKTHDYh7mQJju+K6cwjWivsL+6GZ951n
         j7jHZGPO7feYKrIZrqWrNRlGSpx5uGphVqM0FRetMWlcel4DBvNb66423i4oVjrhNvru
         5HXz5kYez3WfG/u2i+w8eiw1Sv/jCMSP19aa37AH5oI1y2YALSztzRKt/vNKnTVTXjp9
         64HHScmC4AjzmOoOMhdQvv3p37UUjQTkS8mkjNs5H5z4CMkc4FVDWX8RlSQkvDwCvSzy
         GO4A==
X-Gm-Message-State: AOJu0YzmYNI/CQnBOtxJe86cP/lwT+b2h8WorLd+f/vbVBjfKlj2BUXr
	n7TbzS4dLuzT6WzW3zfr73JPR+Di/h3aApXHTWzEoaa3oD4RUrn9lYSoyCCGAMCx+OdENx79xHk
	HxAEg
X-Gm-Gg: ASbGncuU6klacZqCxbpbkTObzFrPzf1bijtF2KJC0jxwatdtZdmGVEE+ddh0fRKI8P0
	3t1a9BTQnrY6phy7CxJEB4c4XMMg8le/O6yS75szjgqQin6Ke7wTxIenKwOlaVCjH6ojM3NIcJV
	plOy8hDjjmU6QBDF2/J+KOBAlj7ZMpgXB1n3IjMKhPCqtRKmB5kzJe9/DoZse9yBlUyVARjb/Pa
	qmmF6X5v07VtYG7fUGOcv37Yl3ruU72qlJ66kfSeMAgHVvFcUqs0aoR9d04upSZtRpUipsNgRDk
	KvSpiFcZ9bDNK3N894L0D6QY/ZnkkU9s4UfZ/vwXEl6+N3ur/NPWBKbduVEiCrXa9uII/FsEj1Z
	H8xGsekg=
X-Google-Smtp-Source: AGHT+IGxxIJHN/EMwPyG7Tm3jmmOepTSVr4yhyZOluH1XV/4YRxZqqt3gswoEzoCKIkgz4edkbVgoQ==
X-Received: by 2002:a05:6a00:8d1:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-77bf6dce4eamr3307903b3a.6.1758120277565;
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47acasm19051666b3a.38.2025.09.17.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uytOd-00000008NTr-49fM;
	Wed, 17 Sep 2025 11:44:35 -0300
Date: Wed, 17 Sep 2025 11:44:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917144435.GE1326709@ziepe.ca>
References: <20250917140216.2199055-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917140216.2199055-1-smostafa@google.com>

On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> Instead, we can remove the __init constraint, and be able to run the tests
> on-demand, and possibly compile it as a module.

I think you can just put the kunit in a module to avoid all this?

alloc_io_pgtable_ops() is always exported, and I didn't notice any
symbols crossing from io-pgtable-arm-selftests.c to io-pgtable-arm??

Jason
