Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDD1DD0C9
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854380; cv=none; b=DzbEdFT5QOStdJIE5WP76ilZiPi/1XlCAg4iFHvdIAKYqd5ER21wZllVT9MmpE0KvBg/EFOY+bcHsxBmMdPIrh6oGHEnD1aPyStVPJ10FByN3of2HMskL8W/0jBaLXktut2jwrcPAUrw/QbdnDbKBfFvykQSm0Vzyg3mEBzZnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854380; c=relaxed/simple;
	bh=jtaPclHrmNUj0OOQtmFmi0d/L5BXAUDlUF8D6hLtdhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I49ejr9S1EmjBLeCR9EJn+Lfr5FFXZlqtmgwCxt70xNvT+3zcG31brxOo6KH05zpRgdPWdKNOJU3mpW+4V7WKYXK/jH8ft4DJ1Ki7KwVPMjg0SPvrS+TzsUFhdC7WbCenIZRy0lxkjdmqudM0ws+yKNAantRfxjUqC4h9ky/5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xmuc5wmF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xmuc5wmF"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so16455671fa.1
        for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729854376; x=1730459176; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ408GkSv6FKcDj3LbYcJBQXIjGsLP11MfIJYKrpseo=;
        b=Xmuc5wmFw4JNBDThq0tU3dVjQBbl04CdnDfOXejRAT+9qKnmBQ1Oy69bvXSq4NTehE
         RWrKU3h77/K0+fZYYTIpwymyFmWiTf0OQqVaIPHDggKCxKHF7Tt/Eo/2oJ0BCdjYOnF/
         Bmepx/CdG1OJdPiEtRbeH/r8fsbA3YAdi9bcW/Le0TdnzdWLdcO78d9BeAsJoezsRhbr
         S/lkDPdozVNuWqFtKe4Esm7zSZYG8B3LvkV86nfgfHi/U+jF2l/dWFUb1Zm4OSA/59Bs
         xGU7RU97FkBFNCcYe3EOrg9JenWgA72pgUSepl0HolCBU/3/zGArQnB+3uLmdfZt60zx
         TTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854376; x=1730459176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ408GkSv6FKcDj3LbYcJBQXIjGsLP11MfIJYKrpseo=;
        b=dch05DOrNWbnlbt676nVUlXRiRGZA3JWjFdzaTLi1u8H3HCw0eMjiWUjLY8+B+nbrR
         7eTHl2PeuOzuS2se8t2U+q8wE4NlsWSN/bgWfU3etzQT8RljKgurnWdoMtSIbKqVTgGK
         TfD1gft7g3VmsXLQHvRDcwvAPhc0EQdNfBXrTQmIzqnzdQk0E20CxtBPvHkG0D4F/IeT
         yCpd8biClNeXBd5DDAZdN379xFeOUcQkeYHuD11ndpTxh0XPFGcH2HdUwfj5OR7RA8R6
         eeiCCx4UXgBN4dzBRM1XTGeSB02Xe9hl+Mkqstxry//2Nirw19rfEReHZyjMMaFWUwoK
         YRMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAd3Hmvdvitcup11VvbwGQu66K7IDhdqwo/f2PjdMWJEAUZ+WJReXyTIS2cNCP1bsUDZD8fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkYTshcpcfAm48CJq12f8AjSVeLhrjdC5G+ik70imHE7XxiteS
	4TRti0oVHkr8hH5+KaoEQ7BSIXEk0mXQ3uCCS1YJlk6nkLrb2vGgEIVgu+GEHKo=
X-Google-Smtp-Source: AGHT+IF+VxvbiEWOkVh7f/0HfI+Gnuj/Q5Tm25LhUJRLQVlSwMKKkXkucoVkGr+79kTD4Fupo5kr7A==
X-Received: by 2002:a2e:4612:0:b0:2fb:5a7e:5072 with SMTP id 38308e7fff4ca-2fca825b992mr24918301fa.34.1729854375895;
        Fri, 25 Oct 2024 04:06:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d19c1sm1449371fa.82.2024.10.25.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:06:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:06:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	robimarko@gmail.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <zsphor7rpbwx4km6uxpepky2h7atbgjn2435puygmpssfc36mc@wkquqxud2yij>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
 <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>

On Fri, Oct 25, 2024 at 10:54:24AM +0200, Konrad Dybcio wrote:
> On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
> > Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> > to limit DMA address range to 36bit width to align with system
> > architecture.
> > 
> > Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> > ---
> 
> You probably also want to mark it `dma-coherent` (see e.g.
> x1e80100.dtsi)

Is it? I don't think SM6150 had dma-coherent SMMU, at least it wasn't
marked as such.

-- 
With best wishes
Dmitry
