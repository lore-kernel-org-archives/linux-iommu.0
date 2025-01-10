Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A84400
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531245; cv=none; b=BOHteXvcfdovYyObyTIiUwxj5SAcXYys7MSCLxATz7XiwMIzy2ABfuOf1AQ+JJgmaDEIxK1hKAVyvPw59tZyJHuiK4tA9OxqfiacuqvXMmhhEipL7hgKKpf1IWOA7+JB13y8Z/KUeqzmECJgQFu4J0TVRt14e9K8c3K62Xp0Eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531245; c=relaxed/simple;
	bh=rGMMGjeWJbUzGv0EfdPeVp83XufEROKGRS0Xfs0yliA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2T2jAwOe7Y2dVt6FVST/f63kYj4pXByJzEZaYD6vzi2TI/wvYaPF623NPhbcldc0iZhyBf9x1fheVKzCvy3cx7axjPlz8QUeqQwQZ3moR2UPtVcF3oczn+NJrtiFcO8sLYJ0hlOhxRxEQZAQcAnRxI0DJVuBdJtNq5sdUDN2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvwrHDDz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvwrHDDz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163affd184so625ad.1
        for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736531243; x=1737136043; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vm2ZaO+Qrhb7+MpeP53Gs7seKtE/QtTH9a6EH76CK7E=;
        b=QvwrHDDzg81IGKu2HrIMF6NM0DjzWD9WE/O6J/KG+98+IBudeIu5KfBzz8FWTr3sIb
         6n9NZczK84HT4shXn60awlQRtF1xt+kCUnk5UIQGkZ6d+y+CQDzMdHqQguywFVKuODvz
         9n7HJWFbR6ajlyHblgrAKpnXiGbwbjJSsE2Xlxsl+/O9wHe7k8U2WXpfhxtEQvSJWIdA
         3eVZ1G3sTMIlZ+qXEPPdeofcoxZJ8qx+w2QQmofmKc8dBaTtqaTjW3TqP0g1xxeh9+vQ
         Ui+MPRTTjBsRe39tpB2cwWYygpD50oeJlS7AKuJ7TxQm2IsAXGTwCDjchgNkiCsGhLqO
         FE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531243; x=1737136043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm2ZaO+Qrhb7+MpeP53Gs7seKtE/QtTH9a6EH76CK7E=;
        b=MwE/GtuVzY84KlDlagozQbp3up5uCNero7+ZLKn3g1uCvrzR61yR367ORRSdNxsoLT
         nz6eziajUDQdYs9u+x8hnQj8f8w6U+ntBfxg4JA3eZ6WmcykcVzUYPzlu+W8od5uGA6d
         /Kgm3WQ8CyKHu0vU5HPdlYHyLoFRSpVpwLRUc+kVqT60+V81ZGE4PXrYG3QJtH38CDEp
         C5Z3ZtxUIc1YX2fad0cYUfRA3fu0bphrW3x2OutZWofShkDYtCUdBgxc7Hc8JaxGPFC7
         HN1aPKfjBbHC8gAur7DKPieSVSJm+yAkDX/9OXoV2Si7fcvNfwZhEEH3eBGvLON4ObIs
         vs1g==
X-Forwarded-Encrypted: i=1; AJvYcCU4aDMLgzLCjyT7KsZ5/CZA2UtLf/55j3mAzF1ACvqxlrs5cIAIFF3ZnME1J9DHo+jmjsveHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF6z+IW06Ao9KuiuHGGyw7LNsiNAyCfgdHZr3vYZoyHLW5IiFB
	DVNxgW//3xAJmHfGlLdK+7VIB5wzjvOJDUkH5ePoAry/oEivGaVJUJ39rJN6tg==
X-Gm-Gg: ASbGncsMDmDLAV8y8ZZGEW32aRJrMi8VoQzA2PvVs1Y+SSb17fNUpP19bU6rCuU84oS
	kT3au3Czz8+aN91yUmYWYIw7yiBUT5N8BDicgEEFQ6UVffvg9S8KjS2myzhfnzDyXVuu7HSmogc
	EolJScMexAKeraKeUIy3mlvDGQaaJfYTVDzgUUl8CUfAoKd4J0X5DxxJBuK0wogQPFZHoC98D58
	BVcw3i4pblVMmwPl8EwyVznI0EIiGroY0RePecDoJmp9sy1HnMptrRTDvsX3143PZPtOTEYrbpU
	JLhsDwEuKHWe
X-Google-Smtp-Source: AGHT+IG+mDTJqWPLLd9c07g3fP1V2113McZ21mcGzx1EDYcMrWYS3DyFgrSr3qUvNLJcKBBCFyeyOA==
X-Received: by 2002:a17:903:2596:b0:216:7aaa:4c5f with SMTP id d9443c01a7336-21aa3331273mr2229385ad.3.1736531242366;
        Fri, 10 Jan 2025 09:47:22 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31ddf6ee6esm3053801a12.75.2025.01.10.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:47:21 -0800 (PST)
Date: Fri, 10 Jan 2025 17:47:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Message-ID: <Z4FdIe2hlgayo19x@google.com>
References: <20250107165100.1093357-1-praan@google.com>
 <CGME20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe@eucas1p2.samsung.com>
 <d07e82a4-2880-4ae3-961b-471bfa7ac6c4@samsung.com>
 <20250110125342.GA11431@willie-the-truck>
 <20250110131725.GA11522@willie-the-truck>
 <20250110162553.GA11929@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110162553.GA11929@willie-the-truck>

> > > On Fri, Jan 10, 2025 at 12:18:02PM +0100, Marek Szyprowski wrote:
> > > > On 07.01.2025 17:51, Pranjal Shrivastava wrote:
> > > > > Adopt the `str_read_write` helper in event logging as highlighted [1].
> > > > >
> > > > > [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> > > > >
> > > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > 
> > > > This change landed in today's linux-next as commit f2c77f6e41e6 
> > > > ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs"). It fails to 
> > > > build here with arm64/defconfig on my setup. It looks that it misses to 
> > > > add the following include:
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
> > > > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 0e4cbb2c64d7..a0e395da8a88 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -26,6 +26,7 @@
> > > >   #include <linux/pci.h>
> > > >   #include <linux/pci-ats.h>
> > > >   #include <linux/platform_device.h>
> > > > +#include <linux/string_choices.h>
> > > >   #include <kunit/visibility.h>
> > > >   #include <uapi/linux/iommufd.h>
> > > 
> > > Hmm, I build and test my branches before I push them so this is a bit
> > > surprising. I just confirmed that it's building with arm64/defconfig
> > > for me, so lemme dig into this some more...
> > 
> > Aha, there seems to be a transitive include of string_choices.h via
> > linux/acpi.h. So while I still think the arm64 defconfig should build,
> > if I go in and disable CONFIG_ACPI then I see the failure.
> > 
> > So for my test builds:
> > allnoconfig:	Builds as there isn't an SMMU driver
> > defconfig:	Builds because CONFIG_ACPI=y
> > allmodconfig:	Same as above
> > 

Ahh, apologies for not building with CONFIG_ACPI=n, I'll be more
careful next time!

> > I'll add the missing #include.
> 
> I pushed the fix to arm/smmu/updates [1] which should appear in -next
> when Joerg next rebuilds the branch.

Thanks for fixing this!
Regards,
Praan
