Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB852BE7DF
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658468; cv=none; b=tYpZho8y+1fpV0y4IFd1paH16zBXs8PS72edCWwXkTo68E8LNNnxI7ZiiqMensF21GEtj76QSdl1NPanEUvZLrv6yN6ZouCg69UW85irOI1uxqbhnYwYIY42crn1NVJQ7XJ2deuz7tMx3yzWd4PDhZTjzX0cawHMgMow79MgjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658468; c=relaxed/simple;
	bh=nYHZ0ZJewemOT8qDaTBfHHrFX8DaMBM2yLpg6PNR6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJE8+z3hmQzKJLlDBGYYNR2cA8qVfx4Z4hBZ1ebGOLLCjLZUoHu3xfGYFYrhU/pFNfcdMV8RKxuQdKNpqaKYmYBW5d/duiAHDjIwBLO+5bVmMNRUSYlfyZNLrkWzmP1i/s9fcTXLrsJpDd8Kam8y6/pYRUKHBKuv4pUARopUZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KSqWN6+K; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KSqWN6+K"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8823dfa84c5so11524176d6.3
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763658465; x=1764263265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuzsEMawQKHicA8bY4mlwm9qmzQtvglQsEjWLmxJJkE=;
        b=KSqWN6+Kiqujd2jURwko/pjbmgX5TXCJZFcQrThLfZY1iJOBY/vBWTpUgkIFfmYN1o
         CVTRDTyBowmAV+kxvXHZPJbb814ba1uI+lNYC4Z8XLAljg2GCIr/cYGeL8Cf71X0MtyX
         BC3pFlygT5LkDXCIFbthshdKXaCTAZRZAu7F9xNm+Oh+nDm+kv7NBZeiE1b519XMLofT
         4CYJis3mP7BgFdmWKi8vBT4D7N0hxX8hxav1ey4ckiBdVPpuAhidxhDjao12Cz3qmUc2
         CxIEcQVlCT7pePgHzl92yn7PuE3E1F7Xk6aGPXFtzbVFUT4XfzfbyJ5CHBNc5DZVVqLd
         5pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763658465; x=1764263265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuzsEMawQKHicA8bY4mlwm9qmzQtvglQsEjWLmxJJkE=;
        b=ZppTXMAY/ZZUAUAIF5fKMYC3rDceE5lbB64Ma3aVPy5e8mYZWkLrZ6W1TvHYYKLHFq
         +Ldyu+C7YOpH1ttChIRyvAT8JzWRcVY7+Du5jSdTPDLDUiT+D0/2sS5ksg+/m+kc2QIk
         2Qpwj3GLREIRG1rRoav58V4M+qETXaJcWMIuxB7yJAQ3Ja9E8As+eLc0HnehbqbIAsZf
         4uFAq7S/MMw3gS2EFCa3UZ8uWiEnRB7XhqFY7KuqHen0ovv2mpjtXOtslML6eyPw/6sb
         hWl0nyMoNZVasWPfcWU6zecGbfG2/fdEr5RpHvIhV3o1pbB0/YPDcK/cZGuG6R5ZXZeS
         N/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWs8wuLZIAVmuRYsD7ioaQAK1rPBnswQL5noBFIIddrWgrP1oaBIs6eHdVDuvU2YveFinQFEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/svs34TZ9x7nGyfQfYS8pIDa8nvbGn/06NSg0/vNgzpRfLrpx
	SJaT83xTL7oW+tjqUr5vpUl9oCVfgqlHqcU5WM7nt1Sn8MYaTDhF4AFFQMbI/3o3SZE=
X-Gm-Gg: ASbGncsydBvecuTIGXD+YtPs/Ej8EwLESHvJRjcFOI6gOBgWqhm3rCliazcZELSBH9u
	/+L5gew++zh5PnQHvMTn3ARtrrRAyOkW8p1r7NHMviTlnH3ptpS/kntbgqQiPGko9SEEFpGslh+
	iUNN6vmeePISANsPpbZocFYpNTqYkIC7Vvj7D2OtpwLtBvpEjnmRZryF3uY2UZPa1VRNnRrmcvx
	slyYg0TDZ/Cm6Ncz5sDxrZtz5S+hBAE7TiGoeeThMlAQkRkpfcSB1ruP8Uu5H7zUCxbS9zdzly2
	vbZAVOSqZ3YkgDVbkNoqD8ox1cfiPq56Cnt+Fg0ckUcy9zgjpdFiJHKW+hvLDdPB37vBwoxJIME
	rJx9EM22Onc9zxkSo+Go7RTNUX4LrmoM2ExntUdq1f2H5wVfVaoDSJEvcSip3V66CUBTLSypVqJ
	ynxO58v1PNITO91fYnimz6rNv4hlpzCSnB39AoR6CjaNy3vqaL3jrbFtnz
X-Google-Smtp-Source: AGHT+IEqjS4uS4xfyJNnG+y2iffk7Jh5hggdrDyF6w+tVPTXp3+LUWZ5E2fj48EBD86SRpKWdaJn2g==
X-Received: by 2002:a05:6214:2f01:b0:880:4961:3aef with SMTP id 6a1803df08f44-88471735cd4mr37815256d6.5.1763658465313;
        Thu, 20 Nov 2025 09:07:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e59ec1dsm20926156d6.50.2025.11.20.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:07:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM88G-000000012QY-0Ibm;
	Thu, 20 Nov 2025 13:07:44 -0400
Date: Thu, 20 Nov 2025 13:07:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <20251120170744.GA236839@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <20251120164933.GV17968@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120164933.GV17968@ziepe.ca>

On Thu, Nov 20, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > There is no point in asking the user about the Generic Radix Page
> > Table API:
> >   - All IOMMU drivers that use this API already select GENERIC_PT when
> >     needed,
> >   - Most users probably do not know what to answer anyway.
> > 
> > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/iommu/generic_pt/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Actually, it doesn't work :\

$ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
[13:01:26] Configuring KUnit Kernel ...
[13:01:26] Building KUnit Kernel ...
Populating config with:
$ make ARCH=x86_64 O=build_kunit_x86_64 olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=x86_64 O=build_kunit_x86_64 --jobs=20
ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_IOMMUFD_TEST=y, CONFIG_DEBUG_GENERIC_PT=y, CONFIG_IOMMU_PT_VTDSS=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y, CONFIG_IOMMU_PT_X86_64=y, CONFIG_GENERIC_PT=y, CONFIG_IOMMU_PT_KUNIT_TEST=y

Can you add this hunk and send a v2?

--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -1,4 +1,5 @@
 CONFIG_KUNIT=y
+CONFIG_COMPILE_TEST=y
 CONFIG_GENERIC_PT=y
 CONFIG_DEBUG_GENERIC_PT=y
 CONFIG_IOMMU_PT=y

Thanks,
Jason
