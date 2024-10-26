Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB9224F0
	for <iommu@lists.linux.dev>; Sat, 26 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729966716; cv=none; b=mC0weTYwZrSpEfFVTon0cSe218IdK8e2r2RIBQ4PTp1r5K+hYjgk0zF2sqr0vbQBl1I+6AUekj0oiyI2Mefgjp20rutr34NBL9Gc42UTHdH8C2Wy8rSDXnUbfMHPPeoEjA7ptZMkiq1Oz35p4ZuaOsHlhrdz9tmdi9+euFemwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729966716; c=relaxed/simple;
	bh=mLUZ286GPbKzQ1G8TxZd2G/6DT+8CQKrGlwx0R4zdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py2KSl9ZCnNT10S7NkbsiU/Gl9UalaTD9y5r3hkAgYL/8nqMuduFYk99Jv22RMjVWeE/o+pcPcUKotZ7KA7XeFLCgynxykt6MvBluluTtE2+cPFjjQVFJQBLvh4j+RHNoVFpTOwQ2VkylT4R30LUGFLdAc3SvJEtqqljYNtp0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdF/qIqV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdF/qIqV"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3282556e87.3
        for <iommu@lists.linux.dev>; Sat, 26 Oct 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729966713; x=1730571513; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr+0jRvi1NT0IJOuOscYHQQgaFgqgoi2S8/w67o5wxU=;
        b=IdF/qIqV+xtFitkzEeTBNaz+MqIB0+X2gT3abDHBx0025zG1x/KJs96HUOhVuFr++q
         buquO34QKOY0kU/lLU91qdRXh/ZBQsArFPpiF3xYEk4WamXopDGWv5ifhWtIlXc13ip8
         RU2xKmOMqsNcclNdFs3z/xLBaMTQ8RMRrPYWnZ5lKD+Srh2zCp+MxjJkG4ya3hrXFboF
         Dq+sDVkoEkV7HJ6w3H2YqpwJJDGtKQfSUqqk16oVDS+VQy8NQAMjMPcLT0HtiQdJxCCF
         Gg3R0/LhsdOJOh47pM4XOw8832cjwLyyK5gFKh4hZkFc2EeZ6S/flwjzc4UoYOeCOQ63
         XByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729966713; x=1730571513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr+0jRvi1NT0IJOuOscYHQQgaFgqgoi2S8/w67o5wxU=;
        b=kgZDTMY3qL0Gf7uKZ+BYxh23oF4n+Dqkluf8JEe+Ei5wHrwpRYxhg8/veGcUWH8KyX
         nhqDhnZ3OqKAQ/Neblxh4JEP3C4sE+gZVqwPMXQeF8atpbHUcEBKqkr6pZ2bTzlPIM14
         YZnzjL4m9TwR86ynx8Z7rtPJ09kQiQplefNBJIGvOLoB2kQcXhIsDsUgGCRtC15tDQoA
         LFTjwXXmfKmXfLF3uQz2cNNW3VYUohlH2s6cBWnwfHT5VUz4Qclq+vXUZBPI52qT25eB
         d3gvRS8e29PnzWj1oCgoiFbWlTXIxApHmhPH7kT3LJErqQSlxQ2KWd1AYhhT6tnXXc72
         rXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl+e70h7gY3nyd2IHoaJOWnQCMpkn1ahMQi1q3mtXEpBQksVt8HmxhBjwSfz7zwpE1orlsFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcex29kVWd2cPPFyRPBP0laqyzWYC/urh4RyBildpnO/7lhOij
	6y61H72sBVCN2jO8u8losjra+yaB1rki+SextRoBxNIlhESrNQbGtXwdQeLwc6A=
X-Google-Smtp-Source: AGHT+IHV18CqxOkaMvlzQe0OOHQoINVJqyxJyEeaJmdcBaU//KGhWUqaFp4ObZCcBr8YBYAq+CXG0g==
X-Received: by 2002:a05:6512:3b06:b0:539:f607:1d2b with SMTP id 2adb3069b0e04-53b348b7c7bmr1048338e87.7.1729966712681;
        Sat, 26 Oct 2024 11:18:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e124610sm567623e87.84.2024.10.26.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 11:18:31 -0700 (PDT)
Date: Sat, 26 Oct 2024 21:18:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	robimarko@gmail.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <nhthg2rlfatc2pyhsuoulvo5447cxg7buv4aq3r7r5amsmjjoq@pgfyvvegfron>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
 <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
 <zsphor7rpbwx4km6uxpepky2h7atbgjn2435puygmpssfc36mc@wkquqxud2yij>
 <8c9804f2-ef4d-412b-97ea-f521dfd35ec2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9804f2-ef4d-412b-97ea-f521dfd35ec2@oss.qualcomm.com>

On Fri, Oct 25, 2024 at 06:45:01PM +0200, Konrad Dybcio wrote:
> On 25.10.2024 1:06 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 10:54:24AM +0200, Konrad Dybcio wrote:
> >> On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
> >>> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> >>> to limit DMA address range to 36bit width to align with system
> >>> architecture.
> >>>
> >>> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> >>> ---
> >>
> >> You probably also want to mark it `dma-coherent` (see e.g.
> >> x1e80100.dtsi)
> > 
> > Is it? I don't think SM6150 had dma-coherent SMMU, at least it wasn't
> > marked as such.
> 
> I don't think I have any documentation on this, so.. one way to find out!

I don't have qcs615 at hand, so a purely theoretical question. But how
should it break if we mark it as dma-coherent, while it is not?

-- 
With best wishes
Dmitry
