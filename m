Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D72198E63
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542519; cv=none; b=qqKfyA7XdkTfGoKPro0jMg7a8d6ZCnj2PBjdgV5K/veP+Q+xoEc55e4xVWnz9e5FPkS3Skr6CDwv1zFjBbYZx2x4FAzmnLM3q4L5hV639F7M1zFvOzTprfYfnyu7LcI+mxmRzdd6jXzaEmhnU1qHVrQhC0a4Zl4oOWISxV3hkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542519; c=relaxed/simple;
	bh=tvMGH6acHpq0mf3wOpKqkyCyArZRu2SdyTDclFxOFhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOa8i5294xSxja3QafeS7XdX+GEfS/WWKezW7uarmwOlWnD+vBIVUSj9/34ks/v3uTnwBzVWqId5s58JzYJwFgHXb9PDodd1NP0OlQHGh95OVhmvbFvX/YK9anudpSpWwPoYqmjhs7vG+bRFZQw2UnmTzM21f55qAvEwAPjEtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmq7oAus; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmq7oAus"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso1272944e87.2
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542514; x=1726147314; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmlFpgXruyMe2tR2xQCFFCz5LQ41UoitHBNzmaLBXlg=;
        b=vmq7oAusGHSyqrRVWN2BJZl/+PbMIT9ZRnbrCLgwclA4075HPXLYsarrA2TWRNnDzv
         Xb3mfjyogZ/vhjpSthe+2CVm2mlVWQEWEpJeylyQ68BAXes8HA0haoJBCBEPnxpOOpT7
         Uwk1QuIG+Ncvy6uVk4xah0RzA/+vRBwtsw8kyC/Xg6DpO4gy5k2uVgN5mM56p+qPXnbz
         PqUjezjBsX74/nVAj1blW54UCwvMVljtJ9V4ifr/NGEPs49e/gYYbsyFu4EgfFObhYvK
         iAKZkw27UnKW48hAPXhxHdB66lNXi2JmqlJFDCWqm9gMcAgj27MG/U9Nj/rDcl2jjssq
         lg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542514; x=1726147314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmlFpgXruyMe2tR2xQCFFCz5LQ41UoitHBNzmaLBXlg=;
        b=kog6vwn9oap1RCyRiF2nlC9EtRLEFzqw2lFZM/PN1CMsoktDFLwJ7m9xS7mDkLvBk8
         D1aVi3mNiGxBwjHLIBuoU1iJZ3MwhOGFhObtE4X5kiSZ4PdawXidoaLYoOlpVlmb522W
         NiI5Oq0E/CyscQXKaxHqycLXSps3WbeB5f7xuO4Uqj26WoTtnS7yTzS5WKWt/Ni5vb5S
         49NodjKUd5pFw3d5kLzWDDBmLZY8QmkKUJxJoCC5tzkT2Rd58xHYcJywWOXILwlWLFG2
         BhZmZ82O4ql/ic4jrksZuIRcPraSaxDWeb2DsnPXxrhVAjEmFnsOw7/ti6KfkzYqq42I
         KFfA==
X-Forwarded-Encrypted: i=1; AJvYcCW7GhdRyM+kJyjxdJuJVUkQ7QKW34obJmLgaJoAm8D4tfGBKfkAZpMncVkJqirA3yplXvrjbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO6sf43NO0Gll0t5jAyJFRRs7Mb90mtc9Iub3cmYQN0g3z/7ma
	JgYoAxjlIMZf2atYnvaKa12dCnW7F3dR2ZdHo85CZq7QG1U+ACKNZSQ7s1t/VKI=
X-Google-Smtp-Source: AGHT+IGX+rtcdbYxBe2zl/yQqy3m4+s8S5Tpbx76wjpbCC2RqHyz/t9kDhohpfiwytRMDDou5RYhfA==
X-Received: by 2002:a05:6512:a8b:b0:536:54ff:51c8 with SMTP id 2adb3069b0e04-53654ff53dbmr899587e87.17.1725542513261;
        Thu, 05 Sep 2024 06:21:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53653a926besm140835e87.302.2024.09.05.06.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:21:52 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:21:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net, sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de, 
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jassisinghbrar@gmail.com, 
	lee@kernel.org, linus.walleij@linaro.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, broonie@kernel.org, cristian.marussi@arm.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, wim@linux-watchdog.org, linux@roeck-us.net, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@quicinc.com, quic_psodagud@quicinc.com, 
	Praveen Talari <quic_ptalari@quicinc.com>
Subject: Re: [PATCH v2 16/21] dt-bindings: spi: document support for SA8255p
Message-ID: <kyy6wb46zt32e6mxcw66xrzlourhvwxnxhhq3pxioxkabs3ny2@hyhb5bjeuoka>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-17-quic_nkela@quicinc.com>
 <sdxhnqvdbcpmbp3l7hcnsrducpa5zrgbmkykwfluhrthqhznxi@6i4xiqrre3qg>
 <b369bd73-ce2f-4373-8172-82c0cca53793@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b369bd73-ce2f-4373-8172-82c0cca53793@quicinc.com>

On Wed, Sep 04, 2024 at 05:48:35AM GMT, Nikunj Kela wrote:
> 
> On 9/3/2024 11:34 PM, Krzysztof Kozlowski wrote:
> > On Tue, Sep 03, 2024 at 03:02:35PM -0700, Nikunj Kela wrote:
> >> Add compatible representing spi support on SA8255p.
> >>
> >> Clocks and interconnects are being configured in firmware VM
> >> on SA8255p platform, therefore making them optional.
> >>
> > Please use standard email subjects, so with the PATCH keyword in the
> > title.  helps here to create proper versioned patches.
> Where did I miss PATCH keyword in the subject here? It says "[PATCH v2
> 16/21] dt-bindings: spi: document support for SA8255p"
> > Another useful tool is b4. Skipping the PATCH keyword makes filtering of
> > emails more difficult thus making the review process less convenient.
> >
> >
> >> CC: Praveen Talari <quic_ptalari@quicinc.com>
> >> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> >> ---
> >>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 60 +++++++++++++++++--
> >>  1 file changed, 56 insertions(+), 4 deletions(-)

> >>  
> >>  properties:
> >>    compatible:
> >> -    const: qcom,geni-spi
> >> +    enum:
> >> +      - qcom,geni-spi
> >> +      - qcom,sa8255p-geni-spi
> > You have entire commit msg to explain why this device's programming
> > model is not compatible with existing generic compatible which must
> > cover all variants (because it is crazy generic).
> >
> > Best regards,
> > Krzysztof
> 
> I will put more details in the description of the patch, though, I had
> put the description in the cover letter for this entire series.

Cover letters do not land in the git repo, so the next person coming to
perform modifications can not understand what was so special about this
platform. Please always provide all reasoning for a change in the commit
message.

-- 
With best wishes
Dmitry
