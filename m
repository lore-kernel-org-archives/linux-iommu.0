Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA2225A4F
	for <iommu@lists.linux.dev>; Sat, 31 May 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748667477; cv=none; b=Xg77ktPSEXri0BOQLEq2dr2guUOKPv5frtYUxjth6j3Obb2ecLT6Rmb1c6u9Hx+MPix3oyXNojyBNujV1nIgIjfJuJppt+/CXpRKUn37dJUudozvCFOlvbr7UsvQHSIuGgUsDBAP0DXBkcdUST6nCrTPOhbWXgfKo+RmrVSnjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748667477; c=relaxed/simple;
	bh=8K3tn6cFhZLTgoSBk3aO4SLumHWKsqeM5XcaTpuz+eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HY/zgisDoejcUxf0WZeu1jmyTezP3QSZnKKWJa5xR63WfZ9e38ExkfHy7x7NrHYc028dMR5F1TtZ6mV5Ziu8gfRghzjGEEsDzcBkQ34oJRS78h3Ip/0pc2D2Tuc7hhHIyCy0xXD1+/N3x29ODyiQbyUwp4DNAun3ev+gK2+EJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W5QiVq5Z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W5QiVq5Z"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso5399591a12.1
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748667473; x=1749272273; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSpiWOEvMO3N5M8jkH7wtrupzevXtJYKexVa9S/kUp0=;
        b=W5QiVq5Zd5lTAsIS3WwCt33T24X9LeVOCFjpiHvzyVVN+peFsibec3nAD0zzG3NYRK
         29B+Lweu+fjvE4sM4EZCR/p//c04LZHW4DESXbDjuKZuAUFfEeBxHnR3UnnMRbvVGntG
         oGYlj8guSDvfEHe98MAsso9PnbIXAP4zaE5O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748667473; x=1749272273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSpiWOEvMO3N5M8jkH7wtrupzevXtJYKexVa9S/kUp0=;
        b=PqlW08p6Xqx8OcMvNVmVrmoyzsV/qPPb2+V+x0t+V2TOwtiZ6mkFrpXM5NL+qPEKrp
         Ere23WMeeqx/MLJ3Z97uKfihmQa+ssZSMeVIBToGs3ciYmv60jIMYkLQYqa9OETutfiO
         1QAtYroUYySFykXE8AWXSoql7gPSa7ORyCXh6wT9oSitlFzSJlIKQY/eRajB07T+6IVQ
         t1ooCM7Ia9lL8IykXyt/ZTRSSmI2JFnc1qF4Zrp8enmC7SB9KilBel4HdV3W8N5OYlXC
         e+xr1nvlO3c8ZRpVyr2C6HVkPyCJYaEbmzxd1a39wbd2czHMxFbbmKcd0QL2uzQmWBs4
         NXpw==
X-Forwarded-Encrypted: i=1; AJvYcCXmyFXdl8XvweXn0x2o0JzMvCVttj1PXviz5fPJkjAgykbOf1qBQ0ldD6geKo6k8gR80/BwtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE725iF2AOTx/IIVw+CJTcrZ3FkHZBhCvIu3tYA6Fxboo64AJR
	2+XtKvlblHcS9H300yaf2FHoc7/31jPo96t+Rh565ohQ7ZZ2RtjgNBZkpTSB0fHjpE6/ke1cr8J
	YjlCMQuk=
X-Gm-Gg: ASbGncsCnG/YTMN3XNLUR1/h5+884wf8pIhDnL3HXyYowozW+piOInXTySitanmNa9Z
	Wk+A+wxNg7pZcD8yVKYrZ5gHNb7LQCP1gA0+v8jqMWzlsNPqGO/wtEqAakJ2Je2ZefHyIVw72XK
	xgMpXKUVWE52+xGiz6CeZ7tgdto30B3LnqyzymDwjXQaKHNk+6xFu2gd5V6SpDUl/VPgXZ4nAzO
	CKJ8yG4z2/kLXW8NVUVFshCet63FhJV6/RuR70RuDHVcO+AdJXvKm9fLMfA4eQeYLT9RRwOxx7p
	YniK9tuFVrDYjlvMmLac25eo3XCVnD+9Wk0UNEcIbsK2utuxlN/zt41ZThP0N7Gm3G/JoeIGLmc
	p0PFSssagMz2fKuvHLFzMy8yxxA==
X-Google-Smtp-Source: AGHT+IEbQZ9Q94S3sdYZAvQZj8BY3YAYlGP9vxZkDu8sXee+PlWMy8i/UtGR3DPB6isUxJ3yI8gltA==
X-Received: by 2002:a17:907:720c:b0:ad4:8ec1:8fcf with SMTP id a640c23a62f3a-adb32431b8dmr537254666b.46.1748667472749;
        Fri, 30 May 2025 21:57:52 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82eee2sm433108566b.73.2025.05.30.21.57.51
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 21:57:52 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso5399545a12.1
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 21:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0SlU/RJ0yr+iX+pVZgEAZs5a5c8Gwj3AY07YhqiMlg1wiAzkmEyBNpWIyiQuVxbmP0KlL9g==@lists.linux.dev
X-Received: by 2002:a05:6402:2747:b0:600:e549:3c19 with SMTP id
 4fb4d7f45d1cf-6056dd32172mr4701465a12.1.1748667470987; Fri, 30 May 2025
 21:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aDmght5YpHmJ6qZ2@8bytes.org>
In-Reply-To: <aDmght5YpHmJ6qZ2@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 May 2025 21:57:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
X-Gm-Features: AX0GCFtMpDskWfc2_AvCLjHC4dHVHudEo-Xx4HYHew7xlRDeRM-eGMEdr31NwII
Message-ID: <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 May 2025 at 05:11, Joerg Roedel <joro@8bytes.org> wrote:
>
>           - SMMUv3:

Bah. This seems very broken.

I haven't bisected it, but my arm64 build - which I sadly didn't end
up doing earlier today - breaks with modpost errors:

   ERROR: modpost: "arm_smmu_make_cdtable_ste"
[drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!

(and the same error then repeated for arm_smmu_make_s2_domain_ste /
arm_smmu_make_s1_cd / arm_smmu_make_bypass_ste /
arm_smmu_make_abort_ste / arm_smmu_make_sva_cd / arm_smmu_get_ste_used
/ arm_smmu_write_entry / arm_smmu_get_cd_used).

I assume it's some obvious D'oh moment to whoever changed things to
cause this, but the cause isn't immediately obvious to me.

             Linus
