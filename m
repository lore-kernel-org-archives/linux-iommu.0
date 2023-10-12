Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81530FA8
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcj5dpY5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c894e4573bso9168225ad.0
        for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697127013; x=1697731813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uywQQTLnXLWpXOPun4QKJKuWvTo48kWYaCdd1C3bRtY=;
        b=fcj5dpY5m2yflkswXdigMOF1d5vznj4iIiX6wBQWPo0Ad1CZwHbVvxnSJorrFrJfD3
         I3uYEriZYcF8GfzjPR1c7fLU5FppWtngAgiiVhwVFh/MaaVNmC97Gzueco7r1n4yrF82
         DVVK+/dNyvOM8ZCDN5eFttdgO+94KMpvvtSzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127013; x=1697731813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uywQQTLnXLWpXOPun4QKJKuWvTo48kWYaCdd1C3bRtY=;
        b=K2LAFc+eD/X2BljGfpKlwuEvqMUqXN8HCR0ad380yy1cSI94rROre9F/hA1xhRglEY
         5vz7MQKkFUopTYiNdzvIvAlNiYKNA0wU823bbRJHhXzTtRqJMakWpuT/I5h9Ec0gz+2K
         PdNMkW4zdiAwe9LNECuI1dvHgrqAP3r9B3vJmn5eYNnuITFeKsD9RjkkxnbElkLATGAS
         5nezMH2MpphuepHP9p/1kELucqxcsSYpcQTmY1dGfGt4BHNkDBINcGSJB7szW3fTKZZt
         V+ZhN+BFLE/Dyi5vr757AOQBNK4jJiBHbCrMxaIl0MnmMXstDCkg9NlMIfKLxJRMhZjQ
         b5bw==
X-Gm-Message-State: AOJu0YzQtivVym6JA6/DdrMizzRbxcWtyUr4MRCIlpKm9HlcrpwQav7H
	haAKDbWkKkQTEsyQIsQfUWFxcA==
X-Google-Smtp-Source: AGHT+IE70nC8DSZzov+QUlaT8psAeyZAo6cLbH9AArJEY5B9saYS5UPiiNtcut6ioYKyhJakE+UGSQ==
X-Received: by 2002:a17:903:120e:b0:1bb:c64f:9a5e with SMTP id l14-20020a170903120e00b001bbc64f9a5emr26657038plh.5.1697127012911;
        Thu, 12 Oct 2023 09:10:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001c72f51b84asm2177860plt.52.2023.10.12.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:10:12 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: x86: drop reference to removed config AMD_IOMMU_V2
Date: Thu, 12 Oct 2023 09:10:07 -0700
Message-Id: <169712700540.4491.11130004795723202092.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 06:50:40 +0200, Lukas Bulwahn wrote:
> Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> config AMD_IOMMU_V2.
> 
> Remove the reference to this config in the x86 architecture-specific
> hardening config fragment as well.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hardening: x86: drop reference to removed config AMD_IOMMU_V2
      https://git.kernel.org/kees/c/faed498d0db7

Take care,

-- 
Kees Cook

