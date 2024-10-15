Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB81B394D
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004422; cv=none; b=o56AV8EUBUrbrxE1o/LVsIxFekkf7w89ZdZOUA1XRw9Ayr0GFP4lzabhQZjaTRKJbOYEc0anj4IzI8HxXPhkwqoM4SamUbqL1I/siFPaKUD7CHZLzl2Hb61eVjjSrR8FzIFU97lwia7f1BWe8GQPVk2lnKn0FSF4yqUSCaAnv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004422; c=relaxed/simple;
	bh=PnhrbquGrhgBwdZIayWClMTgqMfcJs9XO5QF7fKdce4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyj8gk2EUM/D10pELHipaDqr1NBVd3xHyM+BJQkNaCnnRCtVtZqXaIcCCTiM/hkSoT3s9rkN39snwupOPwX9rXTsJp8OTa0TAKHlsbysW3lzzy2nuhy2UezMayzmPVGrr+uZR3Zf4/VpGgQvcHW8UJF6H7vTYgFa2FBAm3FJh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZHusnkc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZHusnkc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c8ac50b79so504965ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729004421; x=1729609221; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9TrApoPekr73hkTm1MQpMBodsXouta6HBY56R3r8KIQ=;
        b=tZHusnkcjjMqIZH40DzOmACVWDRA+6WnRRsbOYUaNmigz3rZzzRkwQtH2oc8ifkfpA
         8cr3/1cbAcoSPJYret5yzATBuEGOexBJT/SDeFMLxUgTD4qG2VbgbJPICn0NAfmQ5MGU
         roAbFMCnzEGXBQGHIVoi73amxLa8LTN6M6Gv1aa/GYVf6sJNE6RZ7fTdQnFBTDAboI92
         dHL3DXtt5eO/u+fWqvO/Vco2jfExwn1SUWQdX53BcLdhjfuJVC3kHhyaTkFilTGk/04T
         zPXCenYSykyNgKeRSVnP4/Qgr67LEa4Ki4kB8FPS0oQ4GLhy/OmvH2/J/Yd0se7//5rz
         lDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004421; x=1729609221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TrApoPekr73hkTm1MQpMBodsXouta6HBY56R3r8KIQ=;
        b=qpmf8+7gSEaJDaKc60ETZ4nmtTrzNJLJ/I/b1lTR693WbkPArl72hvkOk83Fp5UoPj
         emnxPIcXnv+E0NTL9Syk+ETto1byjJwAe77OPQLfVzTLG2tTpqQOtrnOLWuLLUuE0ux6
         dSmYBZ5ac6gVuodwks+EKn5m7AE1eJBZ47iovYHdKG5FQ7Mzt6jB86sKmZXpNOaUIoCa
         l0puJHQjUdEo9vmZkR8prOlcJXvU8pC/Cs/4O0D4wq0Vego08hMRd/amf1OnAi5ZJuxC
         dyVI2ue3CGVWEL+KQvDfN1IHTTnovEziRLWgqwNCJ5VPUOX05yInjU3VvvnCiMIlBXv/
         HMjw==
X-Forwarded-Encrypted: i=1; AJvYcCUtW7g6gM6DI5pF3FX8VkU1VCxoEW1XMuufxH8g/o1q0nLbKhtUBJgSMrkGPMiZw4X4AY77Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsQocXS/TP5FEM61LMjp/uYta2nkH4bx5B3xDM4LuR6pnkQpbp
	uNAI0pBJ2zPsusjAqF2rbBk5pTk+CvltA5lDm6ursZf3V6GB6LpxQuzikXqkxg==
X-Google-Smtp-Source: AGHT+IEnO8qRPAnMZSsYcAU1umBH7w7hOtggGkej45WKFStRzR/jIUoEFsR5i+TfpWF2NyzCUeroWA==
X-Received: by 2002:a17:903:2442:b0:20c:769b:f04d with SMTP id d9443c01a7336-20cc02bd0c7mr6105425ad.7.1729004420408;
        Tue, 15 Oct 2024 08:00:20 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c6fesm12949855ad.299.2024.10.15.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:00:19 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:00:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6DekI9X7lL4f1G@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015124723.GI1825128@ziepe.ca>

On Tue, Oct 15, 2024 at 09:47:23AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> 
> > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > avoid meddling with the STEs directly for acheiving bypass. Playing
> > with the iommu domain type could be neater. Perhaps, modify the
> > ops->def_domain_type to return an appropriate domain?
> 
> Yeah, that is the expected way, to force the def_domain_type to
> IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> 
> If this is a common thing we could have the core code take on more of
> the job.

Yes! I've seen the IOMMU being bypassed at multiple places, primarily
for performance, people like bypassing the iommu for "trusted" devices.
A few examples that are publically accessible: Qcomm SoCs [1], [2].
Seems like Qualcomm have a DT property `qcomm-s1-bypass` to achieve
something similar.

In fact, *blast from the past*, I tried to do something similar sometime
ago with [3]. Although, perhaps that wasn't the best way (and I was a
kernel newbie :))

A little off-topic, but I think there has been some interest to bypass
the default substream as well while still maintaining PASID isolation.[4]

Although, as far as arm-smmu-v3 is concerned, IIRC, I think there was a
way to tell that the region is reserved and don't map it.

> 
> Jason

Thanks,
Pranjal

[1]
https://github.com/realme-kernel-opensource/realme5-kernel-source/blob/master/arch/arm64/boot/dts/qcom/sa8155-vm-qupv3.dtsi#L22

[2] 
https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/Documentation/devicetree/bindings/platform/msm/ipa.txt#28

[3]
https://lore.kernel.org/all/20230707104857.348353-1-praan@google.com/

[4]
https://lore.kernel.org/all/CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com/
