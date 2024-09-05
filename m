Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BB19B5B8
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541203; cv=none; b=mS+NvwxLQtbQ1qhoN2OLTP6xhQkp4F6EJA0cUDzWZWCKlJidzNO60+iStnQ/MjSw4qG/rN28yC+yW1/O7Bzt+koPyHxU1nZidchMwrplppST7ZroWDV4e3NDw8ywAMRO8tI7HIcpHI0buP2w9ubv8DcpK0cEewxSn3ySJFPtmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541203; c=relaxed/simple;
	bh=4uY2WQgSivZ2VQhFIdlGE0xY62rtVvkAX6QFj3t2Dqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVvrJ4xM9TqAuHL8ZIO3/Qj8Msk0ryvx0HB7uemD3fCcTFbLue9zRPv1YeYq+N3y7YYxmxVckUmltjJrNYuJYoYDV459Ve9J0vLUe2RrN0R0Yjt8WcLa5nAea5BttRWJYM6BhuzLIGGvKFGwWa/JeRIBCrv1j6LCH5DHBovPCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNNidq5R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNNidq5R"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f409c87b07so10028401fa.0
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725541200; x=1726146000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8aymMdGqVKINPmql7jmoZbSERwTF4J4EhSuMd5HKKg=;
        b=RNNidq5R3ioGPkILT/v+hTRuJGAZ5vuO+bpHcE9qyZdejEM4adQa94BbiionVTvujM
         4DCX13/v6ItdvdBfN9d0a2VMi46m7ikwgIMr//mCIjhkB9Zx5w2PNHBjsp5lKx/Q4A6A
         Fiy2o4dWJoqLzzstkVOU4iFrTzAlI+x60jmd3wtWD17sHx15Bf4qEAzGcszJm8EY2HNW
         16stP/N0ditnOpNJQCfE7QSrjI4T828AfdzY0j6L8JbSEABSZPPOcDs//Sfkv5RSR7EV
         OWlgm0V093zb9RnhlBkKsSI97/6q4Dg+bhVfzomez7IkUZIjGMyG3ByqB+KRBx6ocvWV
         9iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541200; x=1726146000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8aymMdGqVKINPmql7jmoZbSERwTF4J4EhSuMd5HKKg=;
        b=oxXCdhu9SKPtj7FpQLoKkia5UwtBPADrquRfxgfzoUqOPGiZGhA9LnljSvwdDFu5jW
         Tn4olGLB1qqt2BUVISTIoOU4Qwuhv1ORQEqOAYOgA8mYIgb/2AznFxjrLKVtxOrStcFC
         sXjWD9xcf/iKruBbBTd6G8Ah33IJ+pEP5uyX9tLBnCjNjzpI/1an1XUdXTpsqGJLxmwc
         co7eooJDatXSiv9B+UWAhN1vvFjcSdmy3GnyACW2oO8t02e3TRLADl3yRo88QnTAA6Tj
         LEyfh/NQTYZrNFFsMk8XntT1vc/3aatDhgkbNu/b7eD5u2vWkPvrcAUaqrsAsd2Jj98b
         P0yA==
X-Forwarded-Encrypted: i=1; AJvYcCWWyY8E4r3yIjEyTgJhiMdyhrGxU46ZEXmRDeoTEyep20r7QIK9JEc6Km330rjYIVvoYjAneg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+prpF6W3bro1kE3aU94iaiFezAAYCANkGciZsdHVP7yCImZK6
	l84mRJSgmAaw3v6Vcryps4fE3MXQUWFza3gCv/9cm8j1YMkrYhxx
X-Google-Smtp-Source: AGHT+IF9QchVfib2TGNl44/PzgjS0URPqGUjbcmYR3mRhZSVqTrRZTQB8Yjb9zSWYe+zZesnRPDrWw==
X-Received: by 2002:ac2:4c4e:0:b0:52c:9f9e:d8e3 with SMTP id 2adb3069b0e04-53546b40c79mr12956646e87.31.1725541199344;
        Thu, 05 Sep 2024 05:59:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5356cbbbe15sm242758e87.211.2024.09.05.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:59:59 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:59:57 +0300
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, sudeep.holla@arm.com, andi.shyti@kernel.org, 
	tglx@linutronix.de, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, broonie@kernel.org, cristian.marussi@arm.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, wim@linux-watchdog.org, linux@roeck-us.net, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@quicinc.com, quic_psodagud@quicinc.com
Subject: Re: [PATCH v2 00/21] arm64: qcom: Introduce SA8255p Ride platform
Message-ID: <rcr6bphq6qojq2cchv2vurymcio5utgaa63a5p7pry5pslab6d@q4fi2pkdxg3r>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903220240.2594102-1-quic_nkela@quicinc.com>

On Tue, Sep 03, 2024 at 03:02:19PM GMT, Nikunj Kela wrote:
> This series enables the support for SA8255p Qualcomm SoC and Ride
> platform. This platform uses SCMI power, reset, performance, sensor
> protocols for resources(e.g. clocks, regulator, interconnect, phy etc.)
> management. SA8255p is a virtual platforms that uses Qualcomm smc/hvc
> transport driver.
> 
> Multiple virtual SCMI instances are being used to achieve the parallelism.
> SCMI platform stack runs in SMP enabled VM hence allows platform to service
> multiple resource requests in parallel. Each device is assigned its own
> dedicated SCMI channel and Tx/Rx doorbells.
> 
> Resource operations are grouped together to achieve better abstraction
> and to reduce the number of requests being sent to SCMI platform(server)
> thus improving boot time KPIs. This design approach was presented during
> LinaroConnect 2024 conference[1].

Please don't send new revisions as a reply to the previous patchset.
Always start new thread for new submission. This is documented in your
internal 'upstreaming' documents. If it is not, please update them.

-- 
With best wishes
Dmitry
