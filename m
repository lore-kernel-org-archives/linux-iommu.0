Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327A1DAC8A
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717665; cv=none; b=r0yyLCpA8Uw7rlxvAEeSt5iYwF8l8d7rfitnlhS7nDzGxk0hGSJAVpUFX2Scgb/mGEoW3UccNf2Z6AcKPjppoBlniwW8m7Fo/5M3s0Xyd9vqd/hFCsbgGrkAYNUKxZJhbdVwDZTyhA9RB2G5XMr3y4SbOAWn2wl/4FTVfO2sr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717665; c=relaxed/simple;
	bh=aUV0IondjJOlifc/AFBrmGbiFRVeHn6X+5Oa2ZmFrEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkX1w95pUK9CELI+9JJApMXTYSufCHLFzSqL00K0J/awQ0luSAdyIEGOWLyJ8MC5FDiuklYriMdAG0qCACaCbfUrp+kCdWYWzCw3tlUzX8iBUenxUBX6y0Sdse0bSuBp5p27s77fzbZPFJDhC54jIBslHZnUgkbpz2mhtDjz0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUYIjshN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUYIjshN"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f72c913aso6501689e87.1
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 02:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717661; x=1731322461; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GY9AgZx69IB/wIQj6/wa+fQjfQnAMQkYUKbBgmf+Z34=;
        b=qUYIjshNSrkWJyyV0rQsy07T9mQh3A2QMgLChS801DBWkJozaWq9UxQ8QktirxJG59
         RGTXyOJjOG54fC+1Mm2/6/d2sru0AL0rb0pt1Df5y1iwZCbh2C4Ks5VE8ey2q3JzWGyf
         H2I1+y7SYMoT+wm+54DelhVA2qaitWq0VvqTnnVoUO8wizHPR5uaWQebp/AERKfkTWHC
         5Frrq9p0lKYM0cZkCVDKR67dhfeXG29LaldYQEd8x7u4LDnq9JdjfouFsiUghB4umCj3
         KBLb4qkbAcRYdGsjvu9z3BH1YTwmNQ04O5Vprxs2hEB7pY7i9E2Uu4TQ5Hyq9sp0Vi70
         wdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717661; x=1731322461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY9AgZx69IB/wIQj6/wa+fQjfQnAMQkYUKbBgmf+Z34=;
        b=ode35J1mO4Lsu7ZjEtGOe15yBNECHdR0zve2xZmw9WoJJxsjKoF4GkgqgcYH8pOzty
         1IQkaqq8r6/6sl2D4sp8H89qba98raomVwaj44bul+nqq+Ln1gojIQ6aKZabuowMPqam
         /5Uj0FsrdvJJcf4S0NPPm14okjAFUVCM+cod5eI7PcGh1hMwi+Q3F9fEaRQaLLT9SY3u
         lHe9bvgPMWkLYjkvbl/w1xTOyL2T2oGxRDqjdhIj3xlrnxZ1Cds4H3hedlayzHPP9vFP
         YQMzTC5ESt8rRNmIEi+0/juV3Njvo+KYCwV4D5oFEN08/gA73pC25LWL6ueQrmmoWLyx
         M+DA==
X-Forwarded-Encrypted: i=1; AJvYcCXh1I/LjHMvzFRWYPQFeHfblbj4HCDlZgHyFeapJrh6PYWYr3yT7Fo87jN/DpyueSWIgWEmxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNRntur/FFCf398qLq3lP8EXb4XuN4KsERt2BAjTodzu5BAqLn
	jLLBKHnhmCpyu1gqt3XBw18SqT0xfCCMDHxk/cL/qPUoLHtQUZKLlDgC+RNvLN0=
X-Google-Smtp-Source: AGHT+IGqkDRFxaICpNkxHcdIF4Gwos3fTDVpvDhXDkvrsCCP7zR+hSMSBAkfTFXT+bl/YZGqQ4m97A==
X-Received: by 2002:a05:6512:4024:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-53b34a19102mr15696007e87.37.1730717661423;
        Mon, 04 Nov 2024 02:54:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9ce70sm1637885e87.117.2024.11.04.02.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:54:20 -0800 (PST)
Date: Mon, 4 Nov 2024 12:54:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: qcs615: add the SCM node
Message-ID: <yzpvee7xzbdni5ueroktbogqlbakhi555i3zm25twfd2vuytnc@mecdt3l45qxr>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-4-quic_qqzhou@quicinc.com>
 <flk7n534gfqyivlbl72qco4k5d3c6ravevumjfoh6464pe3qg4@r7ns6zr2i3bv>
 <645c9887-4df2-4ab2-a048-ba79a97b8d2f@quicinc.com>
 <vuz5mvmi4srbwdopivu543cdndybjy5cswc3zmukztldyv22ql@27les6xz7r74>
 <234d5fba-928d-480c-a9bf-1a8c5fc6f58d@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234d5fba-928d-480c-a9bf-1a8c5fc6f58d@quicinc.com>

On Mon, Nov 04, 2024 at 03:36:37PM +0800, Qingqing Zhou wrote:
> 
> 
> 在 11/1/2024 2:59 AM, Dmitry Baryshkov 写道:
> > On Wed, Oct 30, 2024 at 04:42:19PM +0800, Qingqing Zhou wrote:
> >>
> >>
> >> 在 10/25/2024 2:02 PM, Dmitry Baryshkov 写道:
> >>> On Fri, Oct 25, 2024 at 08:37:31AM +0530, Qingqing Zhou wrote:
> >>>> Add the SCM node for QCS615 platform. It is an interface to
> >>>> communicate to the secure firmware.
> >>>>
> >>>> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >>>> index ac4c4c751da1..027c5125f36b 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> >>>> @@ -278,6 +278,13 @@
> >>>>  		reg = <0 0x80000000 0 0>;
> >>>>  	};
> >>>>  
> >>>> +	firmware {
> >>>> +		scm {
> >>>> +			compatible = "qcom,scm-qcs615", "qcom,scm";
> >>>> +			qcom,dload-mode = <&tcsr 0x13000>;
> >>>
> >>> No CRYPTO clock?
> >> NO, response from Qualcomm clock team is "the current QCS615 RPMH code does not have the clock support for CE clock", so we don't configure clocks here.
> > 
> > Is this going to change in future?
> NO, from Qualcomm clock team, the clock/BW is handled internally in our trustzone and do not see any requirement change going forward to move the clocks/BW vote to HLOS driver.

Nit: please wrap your replies at some sensible line length (72-75
chars). Normal email clients do that for you.

For the patch itself:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> > 
> >>>
> >>>> +		};
> >>>> +	};
> >>>> +
> >>>>  	camnoc_virt: interconnect-0 {
> >>>>  		compatible = "qcom,qcs615-camnoc-virt";
> >>>>  		#interconnect-cells = <2>;
> >>>> -- 
> >>>> 2.17.1
> >>>>
> >>>
> >>
> > 
> 

-- 
With best wishes
Dmitry
