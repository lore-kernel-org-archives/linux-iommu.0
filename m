Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A051C31
	for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iRPoNH54"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-427c4bf6017so27674081cf.0
        for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703614172; x=1704218972; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7PfHDnomUiobG04nKM0XGBe44UinAFtZn/zdJlhx7E=;
        b=iRPoNH54kUwbmnAXs6551lZmcjJx+OIYDeu0sleoMhL6IXOpQzZsayzc26ei+hS2ak
         /9bNPmchufox470MYmupUeai5DQ/3xpdBEVsiJxwJYSj4vVdZc3vvhwLNiCLUbiab/7a
         KU7tZ4B+2Wgz3wflODAAPtnvUpxYZSJny0I3BNcBQbV0wxBOKqinjSF2y3N7wtLnBzaO
         whjcEFqg8oj0/fqqKeszPEedemg9yxfwFQSj2qgmmqZ3AeVV1SDUhxO9G4NYOg9/1zaJ
         Gtg5MtE6PSltC5k/Okv40LP394J5XbSgroCFL8604gAIXix1gj3y26pKo7AquEX4gyyb
         gWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703614172; x=1704218972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7PfHDnomUiobG04nKM0XGBe44UinAFtZn/zdJlhx7E=;
        b=Q0RZKQR8mJ2viUtsBS6q74yhGfvWEntZUukBZPxXFFMoKHp/IFLWCnqguohbQkMCbm
         5b2DoPeBIGx0gfdJZcufBxMAGA0WEjbVfLa0bzP6wWYxSbfoWWSEKOiFYDhXDAcqapqy
         RaNDxUTHGvj9QWesgcT5J1HwcSwen1PlzGP0jFcSB0jqjjDq+xmSSJowSYc2NKBCRJoQ
         Aa3lOP401t6y1e6799gdcG1DtXVkf2kU28ArKsOyexUBnyspbG2T/ZEDalHJb6qoZ6Ak
         DIjeOMMIMzFFegOE+OZl4Nprqp81PPiOrjB1WYthfCJ7VekJ9AdrBKtHLhuvNhIvfQY6
         X5BA==
X-Gm-Message-State: AOJu0YwIr64IubJTDAxTmXBFxCmYEEdJiYnUnfsj1YoY56m37O7l8UJD
	JF+7JUh+mk0FKxPapXxPTQnsFtisOatog2jhbxTvQZnXrVCeiw==
X-Google-Smtp-Source: AGHT+IEtGqiyCZMh5j3F5J6wchinmn9n9fLbR9QT0arAi9kviky2yh3yetb2CEZeXYs1U5tu4B71Z7W+qiWPVjn19sk=
X-Received: by 2002:ac8:5fcf:0:b0:427:8b8f:823a with SMTP id
 k15-20020ac85fcf000000b004278b8f823amr12805036qta.116.1703614172543; Tue, 26
 Dec 2023 10:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-5-pasha.tatashin@soleen.com> <0db8fdb5-26ee-5069-30d2-118595516926@google.com>
In-Reply-To: <0db8fdb5-26ee-5069-30d2-118595516926@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 13:08:56 -0500
Message-ID: <CA+CK2bBYXdbqTxmw4YxDudnb4+1PwtSbimpff98JFWi+GjnT+g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] iommu/io-pgtable-dart: use page allocation
 function provided by iommu-pages.h
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 4:36=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>
> > Convert iommu/io-pgtable-dart.c to use the new page allocation function=
s
> > provided in iommu-pages.h.
> >
>
> ... and remove unnecessary struct io_pgtable_cfg formal to
> __dart_alloc_pages() while there :)

Added to the commit log.

>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Janne Grunau <j@jannau.net>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you,
Pasha
