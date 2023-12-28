Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DDC8E2
	for <iommu@lists.linux.dev>; Thu, 28 Dec 2023 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="l0rpBrVQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-427a3887483so45285821cf.3
        for <iommu@lists.linux.dev>; Thu, 28 Dec 2023 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703774244; x=1704379044; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VU21beHWoGJM/Oi2NFAV2MrwGlZZbvr3br6yMg4QftQ=;
        b=l0rpBrVQbYkQnE/K5z8TciZ3OZIIYDD8Urqr3N4UgGngs2iEutLNnNLoyM2QCzwYTj
         wixG+Fk9CRBS9o+rT7jR/UXtOxL8pEAXGMUokybttlKUfMDq1Y7t5+dYk3ZmgndxhuJp
         KOW95t8U1bCZXUcrQ96W+/ZgGTVK1/GkVCgrdhYdO0uu0/IqdA0LQyW3pWbIl3uD8kKZ
         2hO5ll32avI4uYQT7csj7jYEFB0G0oj1PcNpx0ahIJvlCvCHbXXc9D6uWGFGovgmpBz7
         xIc9zpSA1f+OloSPap3miDKcxeH3ZdyCgXaygWRPuJPzymu6Qf5rNtnMTCk+gUaGYDtB
         FhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703774244; x=1704379044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VU21beHWoGJM/Oi2NFAV2MrwGlZZbvr3br6yMg4QftQ=;
        b=Hv+rzSDqX3u3FNMdkhRC24aEuvd4eXTInkMFHm1NI2EDlJt57G1ttjJpNEiLd+HRKY
         16dH29kp9JpNt9HKmlGSiNORsxqgBbbiIkAyfIWH0duAwBuk+8l7ocG0HEDMsw6Ui65E
         mOIlN8Uzq/yrBG/1+vxe6GUeXS9m8Dz1xU/hH2NMGaiYKl3jd3Smz6POUdZg+HlAYeKq
         DzEJgUh3aZnpwd8lmS7V0VkUsBysxqXnih5BbMrNR34oiYeKk5iqnvM0+hRDV0yR4AV+
         0UEB8/kGL2mU2LSK2crX0BzOK6PcTRv284sL3zfaHmXFxbsgIxUWJNs7W3I86ercl7aj
         k8Ww==
X-Gm-Message-State: AOJu0Yy2WiD7p7aOvw9N6exMylX0MVhQMe4PfYbp3NE1++DsdLv5F9p2
	o/52/AYooVDDl/lklymwgU/BMBvkC+sfgfZu0TZw0gUgWGQkKQ==
X-Google-Smtp-Source: AGHT+IG/UmSKlDQRlBa0+Is4JntOVZHhkiYS93o0FbAPPReWbU+HuVGCau4VX0GkprQKsQRXjMZhGZwl3l+vLHMY8rQ=
X-Received: by 2002:ac8:7f54:0:b0:41e:a62b:3d18 with SMTP id
 g20-20020ac87f54000000b0041ea62b3d18mr11492563qtk.59.1703774244502; Thu, 28
 Dec 2023 06:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <ZYv3BIeEgY8LnH7U@archie.me>
In-Reply-To: <ZYv3BIeEgY8LnH7U@archie.me>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Dec 2023 09:36:48 -0500
Message-ID: <CA+CK2bCSB46sZUrx+jsCCtGb-DFUuU9wvCaTamYtKnDAaG9eVA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
To: Bagas Sanjaya <bagasdotme@gmail.com>
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
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	Josh Don <joshdon@google.com>, YouHong Li <liyouhong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

> > This series encorporates suggestions that came from the discussion
> > at LPC [2].
> > ----------------------------------------------------------------------
> > [1] https://github.com/soleen/iova_stress
> > [2] https://lpc.events/event/17/contributions/1466
> > ----------------------------------------------------------------------
> > Previous versions
> > v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
> > v2: https://lore.kernel.org/linux-mm/20231130201504.2322355-1-pasha.tatashin@soleen.com
> > ----------------------------------------------------------------------
> >
>
> First of all, Merry Christmas and Happy New Year for all!
>
> And for this series, no observable regressions when booting the kernel with
> the series applied.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for testing.

Pasha
