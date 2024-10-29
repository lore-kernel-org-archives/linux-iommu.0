Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F132076DA
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236972; cv=none; b=UzqVyF4goMb3C8zDUx4XnHAC1cx+lVHeKiHqRb7H+sSZiS67UPHkmh82R6rngagtREUF8iAna6cLRvhEY48tQK4eNHKY4VHxb7j/2Ob965Xs4UDEuValqMPSneTRQaBtCvCldYQTVmQNHp405tuoiPF5jCmXqW4IZVtNOT5CJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236972; c=relaxed/simple;
	bh=kqiqj5w/Vbl4ym0X5ZAgwX+gC6vFA/z8wsDzbYqbOBw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNf6tkozUQFJFLFkqttFZwv7ixmeb3jPqrs+cUe5cOM1vGeeE0AvDxtl3uWeD+WMAErhpPinNK4rRBUJkx5TK36w3f9FSz5WSQoOioMp19mcmUhp9LrUPqW/hy90jbTObDJ7AufJga83X1OllueP0AdkzIj2bQWkwNUvAETvYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDQMZaeh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDQMZaeh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15eadee87so432457185a.2
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730236970; x=1730841770; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXG3uAnR8xUGDWWZqqgTv3bWvp45oe+e7aGU+Lgvdes=;
        b=LDQMZaehjadsuJdKYI849X4MDudrlpkVrIXtBr/IyUyfejf80XX2bSeZ/s7nE2v0Zb
         V+z1QW0ZJZAhnayUJbl7DSgBekxPxypbjMf9V24Veitb3W19sMMvKLIkoOBjNEWQ2eaj
         ybf9yyMQ8d6TGKbB83XldNfLOgNsg9qEXDSzY+OgOK8mGgifyC5gVSnARDe54ypLSrvS
         YM5kBdldvnu4zKieImlKxBpkraB37ywmHsJVaMe1/c2YHbQBtqaT6hU9/8QmF0rzhr3S
         ARbSmuGgwDpj/gs/YkkqgDWz9zrkUOkqCca8vLahrfaYWXqbQoWgUPTTW1deOhgHYcja
         NffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236970; x=1730841770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXG3uAnR8xUGDWWZqqgTv3bWvp45oe+e7aGU+Lgvdes=;
        b=Ji8rbYg6Ik6OgEYw6W9j3RgIRviYI94rsWwde71w5bbJ+yv4xz6nUns4fFSWe+qPmF
         9ebrLcaNjmwLjm99IRndCWw/TIpza8umv7FrfGjz1kpx5uxw1KImnlcotAlc8UTCbsgI
         2lARtb3j6tF5WKN8lEc2xkjqrBzPyfmprAS12ZpgVZ5Wv+7J/RK2vvCM8oDhj/tiT0yn
         GxTKB5uuS4+6gBQk0lH3qj7F5Ib1Eoijj6N50GoDnXxmcerIT0SpreT9jauS0q3v7Wte
         QxojpD269C2mVwKuvqAM7IC+raoqQLifRIogD3JJ74x+C610AkwUSLjg4i6k7ik4bRdA
         X/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXCrZZQeOspkm5xKFlshhjTexrHih9048HjsKzzk0Be7GqvynIetO5RSlLcvWUzxQFTz1Jo4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzAjib9YVmMcytYlPqf26Z1LbB5+rm8EfJxfeMD6pkmNoOyuDs
	XMW1p2TkHn8ea2QriN61O6+v4YtRqmSE+lhlAJ/P8LE0CtdNe6PI
X-Google-Smtp-Source: AGHT+IGvPaY6eHkYtHcRujijpGZOkw5olQHZ+nTec+dmVsgZDErM8pZ7dmQgEqITB0HkJ64Bv404AQ==
X-Received: by 2002:a05:620a:4621:b0:7b1:49cb:5842 with SMTP id af79cd13be357-7b193eeb9d4mr2054633985a.15.1730236969778;
        Tue, 29 Oct 2024 14:22:49 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200::98bd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d32b9a2sm454857185a.82.2024.10.29.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:22:49 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:22:46 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/arm-smmu-qcom: Add SDM670 SMMU v2
Message-ID: <ZyFSJjO2fkqCwzWm@radian>
References: <20240730013820.41702-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730013820.41702-4-mailingradian@gmail.com>

On Mon, Jul 29, 2024 at 09:38:21PM -0400, Richard Acayan wrote:
> This adds the SMMU v2 for the Snapdragon 670, used for the Adreno GPU.
> 
> Richard Acayan (2):
>   dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
>   iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
>  2 files changed, 2 insertions(+)

Hi, I'm wondering if this is still being considered.

The NAK doesn't really make sense here, as there's a warning/BUG at the
bottom of the qcom SMMU driver that occurs when the compatible isn't
added:

	/*
	 * If you hit this WARN_ON() you are missing an entry in the
	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
	 * tables will be broken.
	 */
	WARN(of_device_is_compatible(np, "qcom,adreno-smmu"),
	     "Missing qcom_smmu_impl_of_match entry for: %s",
	     dev_name(smmu->dev));

DTS change for context (pending):
https://lore.kernel.org/linux-arm-msm/20240806214452.16406-10-mailingradian@gmail.com
