Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF33451BD
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778369688; cv=none; b=PoT8mX4jd7VHldSWnDGBkAsY49sL+iqGn77Y5Kf/JgiXUKq83bE0NS+a7oKysT/vdrUrVjeTH5z92Xl7o/dGR+HzOMsfFGJqmGCdWg7s7pmoIGgTloN+kQeWoQEKoVji+9E3kMWoMAWqB5IofBPsxEfYHUUHIGtUs7FgZ2hWUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778369688; c=relaxed/simple;
	bh=viE2tZT/M+fmeTU3fRuSrMwCvMP+jn8S3W++VN5Bl0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjRBj1RAthrRbmOjfON7UmzzTChT68IQRGmEv9FfEreMpyc43eaxN+qhhoa+TMOGphgo6ptgjxSp5uiF/ZahEEwmq/j5K3qa78HIjTU6cJ8gJMewG03QX1a54US968xX3CPqo0qkVsQKXeSxFCoyiR5KBWmjk8uoO4nOkARDgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R4XcU/RY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R4XcU/RY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-512f09ecc67so21297821cf.3
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778369686; x=1778974486; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6tLt4US09DyLso/mhdji9Hp8lkbi3csRWs2bmEy9sU=;
        b=R4XcU/RYKFBXFTaONdVKP4n+LPB81y9dWQ32Wr2E+uFGBfCEYZyQt+lRGAvpn8rRtf
         VkU3Pl9OzlgfJWx1FUHVTMUZLN52tJajiVPHmOBK2mTMIH0NLVZfAw3j43ITJfsgkqh+
         xFy9SPg3tyOcoK4UR7bruur+aMDwKnr59I8el9xDc9ykYpwYty0wDt3VCctsr6M9rVwP
         3H/wt/XshOqT6YQe5KLDQ7rYsfjAgHo5bI2Y2/6v7ZQHuwxaxdjij34x5iiFL2y/Ya9Y
         /2oNI8+ByzevTZbCnN19465pDbaKTgASdipYbq7o5jGHwp+M6toGbH9c7kn/LZRAzERO
         YElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778369686; x=1778974486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6tLt4US09DyLso/mhdji9Hp8lkbi3csRWs2bmEy9sU=;
        b=pfoF5Tbx/eR1skXFZnYjHmYWKTQWD9mRwA+4gBbbabt0THAqcC6LCIG4DVnIj3z4jk
         Au1DJP/VkkI3PfW6DwfIlyIRGXsIOhxIOYVFStMk5Sb9RIv4A0KiN7RDP0qttAnNebz1
         XlTCwQLpcxAy5X6m9dHka10dEVUPcVkM4LlL+7iuSd7dLTqQ4/CFxYaJwpl7axsv3TY9
         sRxzjaYR5GWo6QwXsc1g20b+Xi1kzedZEOPQD/NuVvYZHduQz6aJPfmP1scLdko0nmp6
         AKKt6AfoICHHSItsDAE5c2ooP30R1HZRsJQ19HQJ8cvZMp7jS+8vYH99iU1yl7K2k4Uv
         Bc+g==
X-Forwarded-Encrypted: i=1; AFNElJ+YJ6CFYocww9HrmmEczQn2zMxAoIeAhLntQfkFDnzksyVHD3wFXnJ+Mn73RdTtG3iEJqt1oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9b/wa9kq8yYwdsY0l7KYsdikH2eknsz3L3I0YY4Ua+umW/Stz
	IXaYtXefXEBaX4B1wdBph0mh0MM13RfWYOkafpxA0Z6EkoExe6a+4zJSk87RbUTc43o=
X-Gm-Gg: Acq92OGsx1KUZZ88YG1Jmk5N+mGfSdBNALppMKzqayVWYUXqx+DWj8buv5UUcq36mNm
	Ly7oSMB21Fg4JXQ1FfjJKNXuseOTREi8Vx/oOX4lNOZgX7s9IYVlaRIh7KJfnKqAbi+TMqtweJU
	rnczXIzsj2rYobKF81FqGwboK+VXafwYSYsaCnd3sVdjgYQSu0D7Z9yhrL6lIx7jE5rsoxZnh6D
	O518vslf8JtebnSn+TIc4pg2eIpBv8LvdD+wU2T06v7VnWPWE9RcfqKAmJJcj+pLmq6dkhGEVWm
	4wZKxA+OYeQJkYYDMulXcUUHaYhg/D8Di0lypAY9QJwIIWUDDPPh3ThKC6VVs1WmakEo/7F9jlq
	fRdOmGZvLC275eYemKn95hZMhmA4f8OiY84vOBf9AYz3Ph08GHBTBABGwebZ+vNhhF7cVZnlUTs
	H0n23x7pPjgaNJUyCueApOxjE/4sTpe0eXP7m66JE8eAzNUyhg0D4096EuQW1C0MDMOJmrP3QTa
	knASxbBK14Ly8Lc
X-Received: by 2002:a05:622a:5a9b:b0:50e:6139:492b with SMTP id d75a77b69052e-51461c3620dmr247096161cf.23.1778369685834;
        Sat, 09 May 2026 16:34:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3d90sm51028881cf.20.2026.05.09.16.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:34:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLrBz-00000002ONN-38VG;
	Sat, 09 May 2026 20:34:43 -0300
Date: Sat, 9 May 2026 20:34:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <20260509233443.GK9285@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca>
 <afiODW2sVMeOj3Ag@google.com>
 <afoagb/wVBJD1IX+@ziepe.ca>
 <afofSPQbepd_fpom@google.com>
 <afsQTwO3eW+Ks2fe@ziepe.ca>
 <afxlufh3t3hRe4-G@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afxlufh3t3hRe4-G@google.com>

On Thu, May 07, 2026 at 10:13:13AM +0000, Mostafa Saleh wrote:
> > I was thinking more like
> > 
> > #define arm_smmu arm_pkvm_smmu
> > 
> > Before the pkvm compile of the shared code. 
> 
> Oh, so we rely on arm_pkvm_smmu and arm_smmu having the same field
> names and types?

Just for the shared code, yes.

For instance this patch would require the features field be present in
both, and then all you do is directly copy all the smmu->features
logic into the shared file and that's it.

> I don’t think that’s better for maintainability, I can look into it
> if Robin and Will are OK with that.

I think maintainability here means pkvm minimizes how much it changes
the code of the main driver.

Copying a bunch of functions into a shared .c file exactly as it is,
then compiling the shared file with some #ifdef'ery at is going to be
long term better than trying to mangle the whole thing to avoid using
any of the core types and not directly share the code, IMHO.

Like my tlbi point for instance, it is not a good idea to rip out a
little bit of the invalidation logic then open code a pkvm
version. Use the exact driver code. But to do this you need to pass an
arm_smmu through to to the pkvm specific queue management functions.

> > How does pkvm compilation work anyhow? Is it all rolled into a unique
> > link, or do you have to worry about symbol conflicts with the main
> > kernel?
> 
> All pkvm symbols are prefixed with __kvm_nvhe_ in the main kernel.

So automatically with objcopy or something like that during the build?

Jason
