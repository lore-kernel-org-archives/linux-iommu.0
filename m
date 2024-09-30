Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6A19047D
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720593; cv=none; b=Rg8guh4g5WtD3gyX1ygWPbQdF4GsnHT3A+ygBMYtmwmEsIzY/ubwII7GgaukQKSRYdHrgqJTw5pHx0VcU/ycTB/MxBucEKkwboy+rsjrAw0W63PwK/Kc6oblXhno0boe8+v59JNmbhEfFTKSalFFXRrQPGdVUbD/0yTKrFGFJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720593; c=relaxed/simple;
	bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7y1gBP86aOJB6ah178ux3enONA/fHlQ8m2LeDTgQlVCX+yl8I/9gxKUIcLgw14Ol3PMumJH4mwkOK2bPMVsHCFimdSt6vYoc4QRYev8rZZ39OGY79bnIfvZzxyDW4VOyHpFVGnnZhJNBRxeWTkZ2qCdX2SDyrD4/q7fRMs6hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XcZ58D+C; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XcZ58D+C"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277dd761926so2798871fac.2
        for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727720591; x=1728325391; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=XcZ58D+C8IQXMimAbWbK4ChoxuwOgtKcEOywylb6CvAxHktU42MkCQQPTOM7VpibhU
         kxAz7xUWBnnqxbadSqBSi9Fbz//gAjDE7Juppb6hKQJ8oIeXyW1pOEfakuSekxklB87/
         URXpPqtSNzVU2Oh9ct2AIgjGmPkR2O1Aob6J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720591; x=1728325391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=kcYw2RFkkSIHBer+hlSdx0btdgLb/hMs3PsYJZajFjt8MQHKcReZ1CQ9bUXkuDXZ2U
         zeZurLs5YJZpsqCCnSKQeTlD3VrPsIv2g94zQYcWDyBIUvlmwUzG8IPYWXQf5nqYiBBt
         pwtDe16EKg1Ipb8Jx0qVqO5/wgeMhz+Yapfa5PF7bBEOEf87s0kxP3HdPZ92nl9KgG77
         BUdaPdS7xQDRdZUAjZlSaRnGTJIMvF9mCIrWWBCgNgzTHm6Jlbzpgs7050C90tkQmPkY
         Lxnf+ZcOLEoimDdkBQLSFfC09uAbCJRClNxW0jOFH1q81rVTG6i/fY9UIdCa0/lC1mKg
         FWyg==
X-Forwarded-Encrypted: i=1; AJvYcCXmf2cHqSgXpe8XsWXtCUe7eM1GG7ItSYJZW+7msaEnSL2zO8m2QW1+qCEZboywuSlwWuzJgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze7VE9i50hT+UKDrQ9rbSIMD601vTStSbptxntgRPPwCJkmBVT
	rtk+OszxNkG3qoTKPjBvKM85izSjO416ebt325RzLzOYB7WpPqMKHQUnN2t5cxjQ/EL5cgoH7+c
	+rOuLnBen51dNdqzfT6PD+wpG2izv0pElAxU9
X-Google-Smtp-Source: AGHT+IEa7PyDDTTEYOgSvCL8wcTYdFJzQ6xeqQh0FfcrTyWPVWg/k95QEjmZ5s68+65kdVi38bWTLm8OVVjNPcrmKeY=
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-28710bb0f11mr8656866fac.38.1727720591656; Mon, 30 Sep 2024
 11:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240824042635.GM1532424@black.fi.intel.com> <20240824162042.GA411509@bhelgaas>
 <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
In-Reply-To: <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 30 Sep 2024 14:23:00 -0400
Message-ID: <CA+Y6NJG7aJszmMG_N3HfnmeMFaAsz9g+XvuQyvzgquah3Jr4NQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

Just a friendly ping! I see that this may have gotten lost in the mix.

Have we addressed your main concerns? How would you want me to reword things?

This is the latest patch in this series:
https://lore.kernel.org/all/20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org/
Thank you!
Esther
