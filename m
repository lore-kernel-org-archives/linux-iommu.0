Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46C193089
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836145; cv=none; b=OvgQ/X12hl1CDWIM0Cd8OewejsVQj2cy1XTVHHl5t2B+vNrGk8g9dZVmVpUSx7oIQlsulglomw5yJqhN4csqy82gilJ4OTK2gDkwg7BIeFzIVrJzpjS/cTRDXnbVgVfbrM+bD0f9UPNJ6beVevDej7awhcA+vLMEYCEob3Tieek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836145; c=relaxed/simple;
	bh=PS5iJjvSFPbK5FEXLziypu7fTXMABNu84miiYhvpt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2PCqJyOW7ISoyhHeX9o4/lGe3pm85oZnAKu2Bw+BQJrD7PjqJ/s6W/tng3j3nh4DrNlxrcqq4oA9kPUjZJVaG6RcA0LHhipM/j512Or0G8hThJdfoeqnisertGfgRGsGZez/pKNG810T8KWLD5oPegEzkl88vpnCIzeBz20Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmYtezYF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmYtezYF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2092079e87.1
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 23:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729836141; x=1730440941; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HDN7ytRNWgu54yGYE5OkdeWkkOZdTmdIR9oyQdGmkg=;
        b=KmYtezYFGfU0LJWHKtYW+sX/OTcNNG4UIdcApdeQIou9KxoKbKTMx4yCvwmbo5lkYl
         yHB06hxWcsPCxyvbqc1TGhi3pYFxYcudRp8gqA43uU+Sz3FePQCPDxlyUGhaHEOS3y2q
         b12Isd8tyLr3YetiN7ms8uiNZGrP/a4+Of66o/dxDUS99M9qdq/g4KgBkRq2nhXYf3LT
         6+Lj+DelX28KflvB/S4p69II0pJvxiTS6Xss4VROdciN0S3/zEs4DQLaGXLbXHcCv22p
         jgFT/yonDOMKqESOqyVDg5rJNK3NLnERS7Yhc0rcaRX0YKjZS0yvw0snX4/BapuBVxAE
         sfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836141; x=1730440941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HDN7ytRNWgu54yGYE5OkdeWkkOZdTmdIR9oyQdGmkg=;
        b=gx0pg8sbqirnEmkPVAfHpexKzq5d9besqjg3H3nhsGiSggGlmxndx9b7PMaaOaLA9L
         yTIymP3cyVp3OxBlYE/R714eW3jTk00svvpzyEAsbANDCM0Qqq4E1kS3+Zy7CMPjbHrt
         Gss7GbSeHxKt0cEKAgAd/2SO3cq2nqEQxa2a4zFX+iEe6vjSmSxioTUvLDRtvgkEYXd3
         Qi0yTLYnc79DLTX1078isKWVPnG95/yuwS6plflB32QgrM3TqAVA+5zdh5GC+8fEdwne
         A7jcbDplzi8fEpFCWi0APRNxAQ00D1DCYkpeNmNcojtxYRsNIGXVxcszB4++Pm9HkYhQ
         I5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUbSDVw/bifb7/YDoHlcMM9FuXMLf2RQDPcSgVMUkMHmB6JbCeplqiwOVrj4Sd3HjNUtmNp4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOs00Qkn2Eh4lPicOt6xEtjkkOHmfJN8VXlJMSbp+5gqNyYSq+
	2ULQlYkL7Ay0kIX+Jeh601h/pul5OttUF+bgAlaU06WsOjpsFDDPqCy+/5sI5Os=
X-Google-Smtp-Source: AGHT+IHSF6yq0M1S4molwHLUXGCrEjlPNYfcVTYft5wUoKPFyLEjD1ZMI1kRxPr5tkpFvG1fma7bFQ==
X-Received: by 2002:a05:6512:3d17:b0:539:8c02:64d5 with SMTP id 2adb3069b0e04-53b1a32ed07mr5399220e87.27.1729836140645;
        Thu, 24 Oct 2024 23:02:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af34asm62909e87.144.2024.10.24.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:02:19 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:02:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: qcs615: add the SCM node
Message-ID: <flk7n534gfqyivlbl72qco4k5d3c6ravevumjfoh6464pe3qg4@r7ns6zr2i3bv>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-4-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025030732.29743-4-quic_qqzhou@quicinc.com>

On Fri, Oct 25, 2024 at 08:37:31AM +0530, Qingqing Zhou wrote:
> Add the SCM node for QCS615 platform. It is an interface to
> communicate to the secure firmware.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index ac4c4c751da1..027c5125f36b 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -278,6 +278,13 @@
>  		reg = <0 0x80000000 0 0>;
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-qcs615", "qcom,scm";
> +			qcom,dload-mode = <&tcsr 0x13000>;

No CRYPTO clock?

> +		};
> +	};
> +
>  	camnoc_virt: interconnect-0 {
>  		compatible = "qcom,qcs615-camnoc-virt";
>  		#interconnect-cells = <2>;
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry
