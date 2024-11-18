Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4E1A0BF3
	for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936134; cv=none; b=aAGK4VgOKVLrN8yyc+dzz0ycpb0bNRcWhgEnnaeTefSIh6piJZZYfEwKCG6VNwKnHS0DL30vW8AavZKDyAZIuqSYswWPpCt4TeY1I0R/pe35JAxrFPzWFRt59bRFwqVAurbxqGDChHUCja9YTAa/hW7CZoua4ihToc7Y3i/qfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936134; c=relaxed/simple;
	bh=8WZWHjrrpvf6/wJGZvis8eIJoW+Xx+9uwID59tAg6dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+vspc0J9SqT2qThOqZ99/oR4RgY9+C4RUgevtbAHIloHu7XtR8MEBv2cOUceAwQQ6Pnhn/2U+rYCuK/K9tu6Wk4gvrXoyi3v0TkP2cfJSJBAH37VcPVpVeZozwQp7Za3ssEhCSKVHR5ApZhTQDlBXeOI8fh2O0SMhbhsNnD+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0eHTEfz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0eHTEfz"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f53973fdso3862726e87.1
        for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731936131; x=1732540931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHlRycREef525moGSk+vFsAJO6g0zablcSaT2Q6MMzE=;
        b=b0eHTEfzTZ1FYfy9TpkbQ5Rt62ShYogehAP4oJXSSlRDQOr4pqvuWZr3Qzj8QCiwlD
         Bfx6MZomk/3UB1MqQtpAZDuSnwQrYRRNrbqLDkJRp2yZKAx4vZvlx4AyQvH1/AMIsn5G
         JmclUDzBk1Gsa8KC8+Z/J/1ujfXxxQ2F7HIKPsTjNKgzZH7Iaoh4CizcErpPh6fQ/PqG
         0cpZRYblfG5ywtN/a3nkBRT+6AMW+985H27kOjvjXdidSLfe4+29SMGroFY1JRr+jRXr
         8hiNwS/3Z7dHPAXYG5jO+Y2dFd8ppg/G3Y7JCHbbhac62hzs4Ko1MRn7gA5e94IoJfTZ
         LduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936131; x=1732540931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHlRycREef525moGSk+vFsAJO6g0zablcSaT2Q6MMzE=;
        b=uMaLkvxFV3CPuhfQKgmqqKpVWmmJJNAuPNSEi6fR7id9SZ4DwNZYzYgulqLJ+8abS9
         bFANMndernZgl2f6b+OGzs/3UsdO4N8X5h4BzZ+EjbXgYUdOgeanaV6oLqpw+ughCADL
         KB1ZSNWXobA7d+gdKT9dzx4B5cm3/o5Hx2NPdM+Gft2UcwHFzistWSKNz91e9/E/aYeQ
         eta2hXt17v2Mkgn76LNsBZCrOpLJZauQ9ssUZt2pGSZVD05GaF3fk2QngPu25Zd+RuGh
         D+Mp30Fh4Syby0/Cl/XufHHiQfr/kM7JTheDdQ2FgVRwU2MYYFc3t1qhKsv7DTrnvcoS
         NYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ojOM4hCTCoi0dBIjyLd3M0YjcgL8HRd8qdT/rqfGnLV0gOr9eeCqTVBP3abEadB8F+dnJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpape07NdIhEWqNr3d3AhYa4GtCIJQxC2zCjKG+aYVFfXEJSOs
	oBA7Po0lxa44JIjs0jfylhW1W4JZPcsA0pjV+rUWu3qJ9ZQ0E3wXGD7Pdq3nLq0=
X-Google-Smtp-Source: AGHT+IEth3Rs4CRCnHxcAkRLL3QYVR7t7ZRuvLES7ZeMPLIutcz17tWZ5cEK7b+lVyqxjvupb/VQnA==
X-Received: by 2002:a05:6512:ac8:b0:53d:a821:390e with SMTP id 2adb3069b0e04-53daafed725mr3889907e87.7.1731936130882;
        Mon, 18 Nov 2024 05:22:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da654880bsm1611327e87.225.2024.11.18.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:22:09 -0800 (PST)
Date: Mon, 18 Nov 2024 15:22:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <buu6l7re4tqauqsbfhlryf223lt4f3624jm2b2nnhexwxmymtk@7hrpd7ht3aff>
References: <20241105032107.9552-1-quic_qqzhou@quicinc.com>
 <20241105032107.9552-4-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105032107.9552-4-quic_qqzhou@quicinc.com>

On Tue, Nov 05, 2024 at 08:51:07AM +0530, Qingqing Zhou wrote:
> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> to limit DMA address range to 36bit width to align with system
> architecture.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 75 ++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
