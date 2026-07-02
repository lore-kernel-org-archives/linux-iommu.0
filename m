Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A444433E96
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004631; cv=none; b=rIXamH3UOQc77EN50qmIxhpsF5QtPKcN2VAqLe+stVJJRLoXX+IRpS/jrpC1V6NsemOxRLt+Eo2v0edXo268zJaa4bXG1odApieR93ozQfTg5qITe4le/vVQUvw9tq+3i0W31vQvrrczsnRG9WSTKvqc9GoPh6As5ytyr1QhKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004631; c=relaxed/simple;
	bh=W8BurQ3nRNlTzRaGRE3wTvVbqX5y4A5tPKLolg771wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/2NbvmYvITHcqlh33kIHMg3iRDTMOTINASfwH3CEp++yS+W8stO6waQusuiCDtRucqYSNUczJEITi78j2u5907qgxv6sfpdLvAdTr+Ev3bZbZlsGzHs2OPnkfSMnDHYO+tC74Xo2KWQiW5RW3WMd3wdsB1StiCNBXkJhu87fIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=VKPN3bWV; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="VKPN3bWV"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a18e363d52so644045eaf.0
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1783004629; x=1783609429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwG/MTWeS4xv8HKjPsiFYVmNZmAypY2FEaPTyYrUllo=;
        b=VKPN3bWVySAxTxlIX7L1H29uqL4tZ90/3FNjRJbN4o6y3FZ7n8Ihvmg5PGveYLAsvU
         /x2P84OLVbitaWtrBLbCnyjnbZw56J++VQWecO/O6NujFLWTItA0eP/YRpJzHDqy6F9p
         0J1mOauUhuN2LJkmRgyrWa6AW9FFLnYCU36XqDuca/PJhwko1VuZ6bhcrksogxdBWfDu
         rQeieTOrHFI0+7nn1eCgQqEjdeilg5s920aXZAhWHwzJVjxAl40Rux1EGHtUcstIi00S
         A/d78VqrmjyTXiSVOe4yYTfVPzj7jzpZ3I0R+yyKj4oq2ZAvgSsYQGoFHnYbODyTrnef
         byfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783004629; x=1783609429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwG/MTWeS4xv8HKjPsiFYVmNZmAypY2FEaPTyYrUllo=;
        b=Yw01WypwZGVbuwffUr921iHlzorsoDlap3C1lE9bXepg/6JOCZB7dMihlUO6nqN1do
         +yBmuzFpLc0/QSgoVLO9wIZiGkVl33CBbP/VTp1V1Pzv9peMU2gwZS/elayORj7/FHgJ
         wdFdy5ylnlzjx2jYTZk/DHWNwacW/8OSxfvjh6if4WIjBfOBvBTMNolLRTm3bM84gOyO
         Gg/9he4E/qLlAHUhD90sS8WpF9LcyFybSuCMsCAxLFR4EkhGZytZf0bYmdyZGC8PoOG4
         km6m6EZ+oBKA75XVuLdUGNQvnsSYxDIGsjU7UEDpJCnb2cbeeAgQZ1x/HKSAbM43ha4J
         pu+g==
X-Forwarded-Encrypted: i=1; AFNElJ9WBtn3D7n4qAGRRoDMOnIQcJzNmdksUYIvLQz266JtSEP1SyjbZIzeRI3tuVtWbHFoHxJn4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNx3clskUwDI/LZxZbAE6kucTZ5TKc36Z18F62nQUJPVzGcZBw
	eSF5HlEz4vn/X+NzSnRiNH4z71TB1PveeVP5Ih2weaz/uTAtbruoYM19/5DdCWOyljs=
X-Gm-Gg: AfdE7cmFRlMHipmzIXUGLpoxrS95C0NJIAaSR7tnmCMVtzVvncM4sqEVfNkO1xFTSdw
	tHwBDWH4noEK3I7E7hadJJ3Jr0etsD8ICuk4vOhpW+r7/SovrYrKRLiKG2hCpfA2a4cVhsTKx7/
	M0tIKzkBZHkiSinRpgRURV9u6/K2lcIax5m1VH8Z7mEs0vbpZVB2hBTkhqQpDOA8Vg8zY8FB2x7
	PRDtvXX6oQCmU/kV4JAO3HPvwKIkDBddQkwB7kJCkGG5Yah/d6bktQRYDJpfIEBzyNrBqpGbHXs
	JkwZ1attPW5jeSdHj6RMvCEp3nLrHwbfDZVC15jiyIPj33JvpldQW7j2PZhteoxMKbNiCyoRlqw
	8myCUVA12tcfwayuyPfl2uMLfswVEkbHL1r9OhTve9/+IyTU+yNPCC81+AhjSFwCxWAi2waccqL
	XUxjQiblyxhtxdppQT4zN/2qe+RtwXPCtkDmYFg8d/gP7IBmktPumn
X-Received: by 2002:a05:6820:2915:b0:69e:a233:6154 with SMTP id 006d021491bc7-6a31d15bd58mr146837eaf.8.1783004629042;
        Thu, 02 Jul 2026 08:03:49 -0700 (PDT)
Received: from vinp2.lan (c-71-235-107-29.hsd1.vt.comcast.net. [71.235.107.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80193fbfsm233245085a.33.2026.07.02.08.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:03:48 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: baolu.lu@linux.intel.com
Cc: dmaluka@chromium.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	will@kernel.org
Subject: Re: [PATCH v2 0/3] iommu/vt-d: Ensure atomicity in context and PASID entry updates
Date: Thu,  2 Jul 2026 11:03:46 -0400
Message-ID: <20260702150346.42807-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Baolu,

> This is a follow-up from recent discussions in the iommu community
> mailing list [1] [2] regarding potential race conditions in table
> entry updates.
>
> The Intel VT-d hardware fetches translation table entries (context
> entries and PASID entries) in 128-bit (16-byte) chunks. Currently, the
> Linux driver often updates these entries using multiple 64-bit writes.
> This creates a race condition where the IOMMU hardware may fetch a
> "torn" entry — a mixture of old and new data — during a CPU update. This
> can lead to unpredictable hardware behavior, spurious faults, or system
> instability.
> 
> This addresses these atomicity issues by following the translation table
> entry ownership handshake protocal recommended by the VT-d specification.
> 
> [1] https://lore.kernel.org/linux-iommu/20251227175728.4358-1-dmaluka@chromium.org/
> [2] https://lore.kernel.org/linux-iommu/20260107201800.2486137-1-skhawaja@google.com/
> 
> Change log:
> 
> v2:
>  - Considering that these fixes should be backported deep into old
>    versions, and the previous solution relies heavily on the x86_64
>    cmpxchg16b instruction, which is not friendly to backport as it might
>    cause regressions on early hardware or configurations, we use the
>    simple dma_wmb() approach in this version.
>  - Jason proposed the entry-sync framework
>    (https://lore.kernel.org/linux-iommu/20260113150542.GF812923@nvidia.com/)
>    which consolidates the details of how to update a translation table
>    entry in common code shared by the individual drivers, so that the
>    IOMMU driver could be designed without considering the hitless or
>    non-hitless replace.
>  - To make life easier, I decided to split all the work into multiple
>    series. The first, as it is, covers fixing the real problems in a
>    backport-friendly way, and the next series covers entry-sync for
>    PASID table entry updates.
> 
> v1: https://lore.kernel.org/linux-iommu/20260113030052.977366-1-baolu.lu@linux.intel.com/
> 
> Lu Baolu (3):
>   iommu/vt-d: Clear Present bit before tearing down PASID entry
>   iommu/vt-d: Clear Present bit before tearing down context entry
>   iommu/vt-d: Fix race condition during PASID entry replacement

This last patch(addressing CVE-2026-45945) did not seem to make it to
6.18 stable, while the first 2 patches went in with v6.18.14.

Could you please send a patch for 6.18?

Thanks,
Vineeth
