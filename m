Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1321A9FBC
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247030; cv=none; b=m5LUQA1tITvlh0C1dK2Thfm3Y2Ce5hPc2y4hKyXMeRphR+VXbAqIegTF/b5n7R6civb3X7Oqje4+05mIFkwvKTcIUpL5tbI9DlKx7ENECHi7/358D4tH44KF11LF6AgrwdnnYcQDopRZTfB2hupo+fmDyYzW5ZQe8xlaVXOGJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247030; c=relaxed/simple;
	bh=06YIPsvFCLfL0tR9DEMfp2l1wCcz5yUfmx7RaifG4Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmO6bX643skYAuMtv9Coy8Yfv3YKU1RuzUKRr7ggzd/Yyo2dyljgG/wsZVBTkhzjOiwqRX14bGdYHFKV3Fy//IXLsXF6YY1ROQBEue2heQTAD1xV6PdjbyPvMyCyKilBabUBFqIcuGAldz8lseTX+0K7FrG69PJPLwKFcau5qt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1K946g/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1K946g/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2911f93cso365ad.1
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780247028; x=1780851828; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybo4RkpcoWejnDM44U+Cay0s876q1Wdz5Zz0sx9dqJA=;
        b=F1K946g/0Um13jBppi9+l3TG50/vOGCji+tr72vVK54p/FWlk0ViviJCxIwE3NrrUf
         uXrcRGPwfgG0LGWs7wP5VMG24CyMl6fYegt2B50w/Kb6wz936cZMd6+lw44CzNYJWPIF
         NUYp66Vs8vIgyZ3LXzqPy62m41uSmj4p+NVIHcNlqB90ObfFL5QoKoTb0R/4KfXfY4rb
         e/tFkJjqg7IJsh8Q0IHJGWMapIDNplfx2Kh1TAtdF+hSiXQZdGIhJ7KVacvc3KxahjlT
         7Rt0K7xB4kfNGqq8oE05Q8NJY5PLcPKGtiiRdCrpN4kbzHhK9BSlg08lU75d3pxSYNKr
         6WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247028; x=1780851828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybo4RkpcoWejnDM44U+Cay0s876q1Wdz5Zz0sx9dqJA=;
        b=rF21X0R6M7VXqyUyHZid2PR5bW2X4wHr3j9fVgvkymRV9FyoGTetdTlLFjLbziJatF
         lxoY9P+Q98+Wai7mIK/Sq1LwiG1EMmy4/f6lutvWhMormVkWb5VLiOr0SJ0SreoA/6WO
         W5SBtGDjaZFIfighoKJVX2gA8g0AdFsiqkarTrjvL/4ByBsiMWGvvLPxjDme1BPlU61A
         DYAcANa3BVO1cvrhX1aT9NLLAFTFshpIbgRRUY0Ln2pxX7V9Yaak2af8xJSWIT0HYj2c
         ZZrBgcpzFGeX13XXdIX5ozwBLiydKzz2p0uf3z4ZIy/JZS3uEg0l/bM3Iprs0d2adYbc
         tNDg==
X-Gm-Message-State: AOJu0YxedzwEw8et9A1AZ245r/frLSNjR+r70n4zcwdebFCFOvE/ucmI
	BoHo6ow0kcs/Fw4+2nk/Csnqux341hQqlKjxXZ8lgfgiXQkkTvO9AhOF/X3xaGNBOg==
X-Gm-Gg: Acq92OEM2gLd20D6bzEI2N6lAlZA+0N33Wk/wNt5ICpFwax21c5iTOuUag8ZhvdXJMy
	1j8OvA5leKg+aRc867EagJvGsiTfGBArfCu+4ZM41Oi5nZnM0utzPcxlyqlbSNRhn9ExVQ+rUTu
	9hMZTAkkHMufFBGRgUQC0+xC/qmrGztraYKn4ttu/dV7Q4uynCD25FcXJ/QTn+nGNMflA/NlQhJ
	Qil2CDwpoAiBlPc+guefTjyZYs1FvFFVPdjIXmdSm1NI0DrYC7QuqABy7UItmTkP5lrsWxhd3st
	SzYeS+a2d41FPD7UbGJ7yMHa3qYL5gSbSB6b61myxv+UJc63x5r52XhLNB3v6Kk5tZeWdP8ugaD
	UvfMixj3CV3qjEUlkEKrPeDm6kfpVPasPyR4Hu+nN8dXuoanoLAZSKc59+jgP8tJXyWX0hrGwFi
	8chxoH3lTACSG2mneSblnOux0aK9JSEeocJYHB95Pb4aSJqWJs6HJ2bQK1eyaabyOS/r6G9/s=
X-Received: by 2002:a17:902:e5cd:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2bf97500a66mr4156065ad.6.1780247027806;
        Sun, 31 May 2026 10:03:47 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b018b6sm82818655ad.43.2026.05.31.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:03:47 -0700 (PDT)
Date: Sun, 31 May 2026 17:03:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix Use-After-Free in probe error path
Message-ID: <ahxp7CxM4kbTMgxy@google.com>
References: <20260529113410.491538-1-praan@google.com>
 <20260529113410.491538-3-praan@google.com>
 <fa33f355-a21d-4d6c-ad45-c2bd455a9eab@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa33f355-a21d-4d6c-ad45-c2bd455a9eab@linux.intel.com>

On Sat, May 30, 2026 at 09:33:12PM +0800, Baolu Lu wrote:
> On 5/29/2026 7:34 PM, Pranjal Shrivastava wrote:
> > When intel_iommu_probe_device() fails after the info structure has
> > been linked to the device via dev_iommu_priv_set(), the error path
> > calls kfree(info) but does not clear the pointer in the device
> > structure.
> > 
> > This results in a Use-After-Free regression if the pointer is accessed
> > by a subsequent IOMMU core call or a re-probe.
> > 
> > Fix this by ensuring dev_iommu_priv_set(dev, NULL) is called before
> > freeing the info structure in the error path.
> > 
> > Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")
> 
> Fixes: eda1a94caf6b ("iommu: Mark dev_iommu_priv_set() with a lockdep")

Ack. Sending a v2 with this.

Thanks,
Praan
