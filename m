Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980E1A9B30
	for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940754; cv=none; b=QHy42JaXQLLAio0HvnAux3oCxxPLGTtFV4mw7nt2ew1MusBRboiKKcJwGqwg6YwmKBCZPMgFDaREleLLwAbq60MNbzeIS4EElifgh5h3fXQhmONJv8edUWJ3lQUUwJbT1sp5g9Yca6fZCAKodYM+Tnx54mxUSABhN8XDcbzg3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940754; c=relaxed/simple;
	bh=BC6dgZpu/Kre68GQBaTE0qMJ7A9bxvl9WN55esV2qYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxt2qPDzVnQvtkABCF67i4J6BfDZnrTFAMRafC7oNasxzNpi9rs1m/65P/6jxOy4xxTRr05ekYJCd0eUaLy50aFJ/fjgGlHX7HnuAG6xcdYDyO7uIG+Dxv7S2aKtCoETgT8B6TxE4DmvN51GkULSJKifK0s35eqZAgXy57SoYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f79myPDY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f79myPDY"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e9f8dec3daso31379197b3.0
        for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731940751; x=1732545551; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpSDLLCiFqZ+5i7REgdBLPfhOaMYuIy1hAA6x67KYek=;
        b=f79myPDY46e33TUZ6Z18GK3/RYfbUAvEVDfWzNBe/qXWQnc7q5IfQxgicbgYs3W340
         gTr5BhGiCpJo6YUCo6ODqZEAwRRn5kED6Uc7/ipAM5K9nA9dAJUSEeMtEPSWxag0MSy7
         kHBD11ADI5NjaAEwEjw0S+9rec7jH2kyQLUgTn/Fs8zbsma48OJzKvZCcuZHRucf/tu/
         6AWw8DjrDBCfqvZeb4J9XtAEUg+D2TlLKzS1JYRwbI8GDN2jqALf5H2GYZaTD7WI4XH2
         t94kFPc4PEGcXmzirKi5Kx5rbXb65fxwthfmQ/j34dujdEuU9vtvnjIITa5gDcNqEUPU
         FI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940751; x=1732545551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpSDLLCiFqZ+5i7REgdBLPfhOaMYuIy1hAA6x67KYek=;
        b=W9u2eFHfV4NYZ70itQV0zZnZqJuhKT6fxQgV4M4pbTDbJ05egCOj8PAYU5469+eJIU
         tV1hD2HuhkX6xzkZn7zZuHHMOpbNvltPIPsqDPUup4hhN+B47pcTOco+cGjbHACS2KUG
         tb0u+mox4D7y5E4ry8uUGG+fBIARIUfV+fFgW1jjf1cDGcD4+kW2cZFuRNJbESjMist0
         wvNLkx4xrvKhUUuey0mAht1Ffiek50KyVB3sp9jE9PFlEHPA1urypepNLKZ3keT1TQpf
         LCUA7u155yeK2khF7RFhsCegvpZMDgDRthsYLLAysQFDEJUjeRoyEQljfrqSsKe4x8MB
         LEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6v5LfjJyWQGqA69gST5VtnLeK4TGLb4EBnFfVMYJLQKXLMR2dJmbzvRI4JNbKMTDpzedurQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwREMWsCj8wiNAhyCPFEn1NMCtqDxUOaJiZ+aINbzZpownK25lR
	u2bUBpCftboE0sRqAlTKsHOzh7lm45OLhAeP+xWdCHmYNveV74hVuFdGiFVsdcw/2IvlPwVf4oG
	9HMi3vzPnczqlxV+fgWZFAeo+JqYsTXlNcWP6Hg==
X-Google-Smtp-Source: AGHT+IHcxZP0Ath2/RjkGLMJxqqaiGHP0b+6h9Soy7AfLhFb6uhahD7NhGEvfbdoMkjB6y+o/cSPi6JDoO2JA9z4VLo=
X-Received: by 2002:a05:690c:6806:b0:6dc:7877:1ea3 with SMTP id
 00721157ae682-6ee55a6c9ebmr125661007b3.17.1731940751262; Mon, 18 Nov 2024
 06:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <mcyes5nikfr6ptzorlttrzvtjgh5zugmbo5ao3pkh4q2r5h6j4@vonmpvsqykv4>
 <95843301-2061-49bd-80aa-c443e3694438@quicinc.com> <348605e8-a583-49c2-8921-dafed033f53d@quicinc.com>
In-Reply-To: <348605e8-a583-49c2-8921-dafed033f53d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Nov 2024 16:39:00 +0200
Message-ID: <CAA8EJpoGpA4AoUvnf_Nby5e0u1hGjMgyDuv4TVkejZyidBp=Jw@mail.gmail.com>
Subject: Re: [PATCH RESEND v17 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 14:12, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/15/2024 10:43 PM, Bibek Kumar Patro wrote:
> >
> >
> > On 11/15/2024 4:26 AM, Dmitry Baryshkov wrote:
> >> On Thu, Nov 14, 2024 at 09:37:16PM +0530, Bibek Kumar Patro wrote:
> >>> This patch series consist of six parts and covers the following:
> >>>
> >>> 1. Provide option to re-enable context caching to retain prefetcher
> >>>     settings during reset and runtime suspend.
> >>>
> >>> 2. Remove cfg inside qcom_smmu structure and replace it with single
> >>>     pointer to qcom_smmu_match_data avoiding replication of multiple
> >>>     members from same.
> >>>
> >>> 3. Add support for ACTLR PRR bit setup via adreno-smmu-priv interface.
> >>>
> >>> 4. Introduce intital set of driver changes to implement ACTLR register
> >>>     for custom prefetcher settings in Qualcomm SoCs.
> >>>
> >>> 5. Add ACTLR data and support for qcom_smmu_500.
> >>>
> >>> Resend of v17:
> >>>   Addition of minor fix of the build warning reported by kernel test
> >>> robot [1] by powerpc_random config [2].
> >>>   [1]:https://lore.kernel.org/all/202411140748.6mcFdJdO-lkp@intel.com/#t
> >>>   [2]:https://download.01.org/0day-ci/
> >>> archive/20241114/202411140748.6mcFdJdO-lkp@intel.com/config
> >>
> >> Nit: then it's not a resend, but a new iteration. RESEND literally means
> >> resending the same patchset.
> >
> > I see. Since it is a simple "int i" and so did not feel worth a new
> > iteration.
> >
> > Thanks & regards,
> > Bibek
> >
>
> Let me know if you still feel this should be a new patch, I will send
> the new iteration then in that case or I'll wait till further reviews on
> this series.

I think it should be fine like it is now. Thus I marked the comment as
"nit", "not important thing"

-- 
With best wishes
Dmitry
