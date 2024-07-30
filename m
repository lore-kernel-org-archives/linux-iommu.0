Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BB18EFD5
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331326; cv=none; b=a3bzZLMVlRtHfAO8KcnioZqqvLEaIG2WZYFdD1FmQtrQ++HuSOApqjV88ovujFN1U34OEK2DZHnHZfqcsCvgsqG8vdtEVVE6cPN17sQL3yP/6jbVzDQgmau9lHWBwAtReXYzxiqFyiZgq9mgcOYjlg9npJZz5u7IzG8r1R+E1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331326; c=relaxed/simple;
	bh=qc4+vz7nNBQX6rw27KLvTXvTj448QyhgejGiWWuvDsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNrI7ripH08vKFDaNt8myrURfMtDifLZShmBej+xpGZH+J67/oLOh8FHsFpGl5eVWttEtN022IdWxpaiFEZHSUPpO//WipuKc2JXJ/dVJdadPISp+Yk24HGzfamOM2RNbi3G7ZETUSJu7JecOEBWCVqbFnx7Yho+3aSqQ7My+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j//e9MG9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j//e9MG9"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f0407330a3so9040601fa.3
        for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722331323; x=1722936123; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbTPUWP7dEvHs9yHy9hlJD4fx65Y8B6hataVoHic/KU=;
        b=j//e9MG9uSZm2g8Jw0ovfxr/F9Ag1t1kT/74oUIS1J1ovZr0pNtftIHs/xQXnir6wc
         pbWELROuHevgxVZNOrbOLrgre8IQAMQOPmGb/U+jrSqvL4gEgc5AyaDNgyMLRdMQZQ73
         VgIP4S/7SkV7JCHGC4yt/zWTeAgyX1Fepsdrn20266AhcrSImFTtgu3NWi4BmgMTUbel
         ZOCxT5KTn7fA6WSep0oHi2rFtrqtfatn4kFOr12x8Qpl6XGu3rTBm6Hs7mzMB0SudEhH
         C6VJzbdQ7mCog1CGNnXsMH6w6XO6/kifoCq/Z/4rf4TyQIe2WQC9uJrf9Fd/qqmkMVGn
         osVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331323; x=1722936123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbTPUWP7dEvHs9yHy9hlJD4fx65Y8B6hataVoHic/KU=;
        b=v0VQGu++2bUV9GcAw5/qGqrxNb51Bgss2MneIvSzBQu7TwPlfkN3kaH54RlKPP00yR
         SkOGbwT2fXXgAgIBZV9PbkrsKUPmK7QfvvXmITXTvp45PhYMnvV8oDGeGu0HB/ppbRae
         G6EM7Gf/PIBQ8ytO5/ElndMiBx6iLhTVpLAtl/9J9xYE8I+1gmtK6zk5J88mb6jcX7tI
         DW3tT6tTYqPVK8Er6Krfhe4M2rQCQcJ+MK3XCHZjKuxQioKwOtASSqaXOH2q/03vR1qH
         Q4zO91GlgwDd/6aUA3jF3bnjkZX08TRX6aUgcit0vOhq+xU9tuCjnrZVS64FtdaDyYcv
         KiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/5hsgic2+rrRnhDgp53uvS8BuNbOEuHUSM4HCe6H1WXi8Arc1udTQRdjwaq8X0FRKtzPvPGt47usMP6S1UstxbDoSqyM=
X-Gm-Message-State: AOJu0YwwQpEsZWpIA2p7Y95OhbenqOwrGJeaBnsEGPe0wxU6OZLflzX5
	21f/bGJI/ob7tY3n7xX+NxcJ1xLsfURf1ZyEiJ44UONRqTgvQvqSoQmRR0A0r/w=
X-Google-Smtp-Source: AGHT+IHFbaEWsPpnN36GEwy4+3Xjn07ym7RpZkkVMFK8u4jwJ6w8wTu0z813D8wad9QBLW/ixrXKNA==
X-Received: by 2002:a2e:8508:0:b0:2ed:275d:aa44 with SMTP id 38308e7fff4ca-2f12edd67f5mr64620911fa.28.1722331322853;
        Tue, 30 Jul 2024 02:22:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf2e62dsm16009241fa.29.2024.07.30.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:22:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:22:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu-qcom: add sdm670 adreno iommu
 compatible
Message-ID: <aim6b46amzzrfg6pohmdjr6cnhnmxqwfidlebqeou22cjludb3@kwi3mcjf7v4j>
References: <20240730013820.41702-4-mailingradian@gmail.com>
 <20240730013820.41702-6-mailingradian@gmail.com>
 <9c4a586c-e9f2-44eb-a8ce-0b3943b07de0@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4a586c-e9f2-44eb-a8ce-0b3943b07de0@kernel.org>

On Tue, Jul 30, 2024 at 08:23:44AM GMT, Krzysztof Kozlowski wrote:
> On 30/07/2024 03:38, Richard Acayan wrote:
> > Add the compatible for the separate IOMMU on SDM670 for the Adreno GPU.
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 36c6b36ad4ff..7f4b15be4a11 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -539,6 +539,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >  	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
> >  	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
> >  	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
> > +	{ .compatible = "qcom,sdm670-smmu-v2", .data = &qcom_smmu_v2_data },
> 
> Do the people even read the comments? What the comment is saying? I
> admit it might be not precise, but "500" and "v2" are the same from that
> point of view.

Well, the comment speaks about -500 explicitly, because -v2 have
differences (it is known that these platforms require more quirks).

> 
> NAK.
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry
