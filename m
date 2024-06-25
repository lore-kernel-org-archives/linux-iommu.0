Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37273158D75
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320382; cv=none; b=i01HHOqhDuO+g/eGCsu2hkHDcQKF9pJAImeAaYhSiwq85DpwtolWpEsd5JS3zixRgIbI9NLcmYZ5taI8rsdQvB8yibTYp5Yq8DvVXjgrMNmhAQJc4VvAgBOqizo7om7oVF/xl/md2eNW6A7hTjuQR0q9gnO2m/aKzS8h1tZygKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320382; c=relaxed/simple;
	bh=Yp7I2FiVKh+KMKAdM9SGW2FFGeM+i7tZKjv8+TY0Guw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGUMw0ImkJff8mvDOVWJ617FXdoHwb+iuesT/6pmtMvCCxHuf40Zdhbyvt3dU8dVdmpBnlBpEHFrk6+CwY7xVHUIqu3dhooJShPUGESUuRXJFPtjfopEzLHGyyH4IPys0foOxICWy7e+ebZTAq6RYQy3tPbyRVZJ0XZDuHtuZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zkzwQBFo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkzwQBFo"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02da9b2db7so5065227276.3
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719320380; x=1719925180; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Ay60vtgcGfFCitsZDB5AKtYOW2UuaM+JMlbTIwmNo=;
        b=zkzwQBFop+4jJSbcS6ddx1XZmWMd+rxDKQMF/yZJYTdiXyVqh6h1a4acrvfGq9TieB
         CsucV1GHaDDZ8ByTHi4qYSrzcyE3gF1l+bjspb2/kwcXMfD4frsSMXUtZmM0/A7sb/WE
         JhHMYeq8bhVJ8vp9SO5FPUdjwndiGS69Y27fUgeBrlb+oecA+N3NRSGBB/CHvPEWovrP
         W72hFNbC+NmRngRETe5i8SWQhfkTUkNN3gUbHtWMtRmkAJ1yro2CC++RVfKKMVHpN+Zy
         2ITQSWQpBPaDA6Lwz0/f+G2pAQxoPTgic7gGbgYC/Z6C36PLd3tqrjrsICryfN1A7npX
         7Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320380; x=1719925180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3Ay60vtgcGfFCitsZDB5AKtYOW2UuaM+JMlbTIwmNo=;
        b=sOBBod7L+IDN4QMmz1GD/ulJb4SnqKwF4XQXYZgFAUgpfWbPyPBRQGxH7NR4sYKD2A
         33zpj32eTfmZfHBrL5zsaBC3rX3HbwwR1M0546gt+lddRf7fmCaXktsmgq3vdQDavXPC
         BSKDy7z6OhRNzPjybNCyY+WGcVbHJf8oC2BhTEGR71CouR68MIazjoOUrMa1fMcnmGu4
         idzRV57fBPm6lR5YvnzZMEGyyc6two7LFewaIALHOd+IZt7lTrbtAmAEZH9fvHIe32Nq
         CS7jYjVhR1n1vsHMOnO9NhFJKdvlkwkn/W8kcekAdmh2gCqFpgfB9oN/QMiXTJjqCplQ
         dqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG4Hf5bzfUwZQRnkZG9SVfFimaxMvn4PLUOFZ5afknmAHIo35mvl/V+7Pm4u4g+H/MPXFCs30JUS1CBJi6vcaYZTxQUK8=
X-Gm-Message-State: AOJu0YwW5UBDi4ZSlG9yX7HwiAQjPPPNoNe1BiOx4UnJ82nxqbpY+ZLv
	Cw/+wRRECeOwoa6g+w1G7S+eOMB38M33Bbmizwu3O6z/HA+SleC4oUWXNrusYC0acdW18ec37Lc
	6StJi58uX3Wgrjj58PVabdPtHnK80gJkMRE3Jkw==
X-Google-Smtp-Source: AGHT+IG/uaVakkrgSD4WKuGcBcbaZo5fAtSTAyu0sxOZcikQA0BHcryR5jI9ISgR3vlev1QYzK5GUigCBoIhwmTN5Pk=
X-Received: by 2002:a25:69c3:0:b0:e02:bde0:f2ce with SMTP id
 3f1490d57ef6-e0303f7f157mr6765502276.31.1719320380162; Tue, 25 Jun 2024
 05:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-6-quic_c_gdjako@quicinc.com> <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
 <CAA8EJpr3GYimirDz39f4n-3hDAxFWzo+9fdY6MAuxaNguouVFg@mail.gmail.com> <3e816509-a12b-4658-85f4-c0d0037c6a64@kernel.org>
In-Reply-To: <3e816509-a12b-4658-85f4-c0d0037c6a64@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 15:59:27 +0300
Message-ID: <CAA8EJpr1G4eq5xJn0z2JQmpXY89UK13uk2BWJCgROsFP_-NkQw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Georgi Djakov <djakov@kernel.org>
Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robdclark@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, 
	quic_sudaraja@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 15:57, Georgi Djakov <djakov@kernel.org> wrote:
>
> On 25.06.24 10:50, Dmitry Baryshkov wrote:
> > On Fri, 14 Jun 2024 at 21:05, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
> >>>
> >>> Add the device-tree nodes for the TBUs (translation buffer units) that
> >>> are present on the sdm845 platforms. The TBUs can be used debug the
> >>> kernel and provide additional information when a context faults occur.
> >>>
> >>> Describe the all registers, clocks, interconnects and power-domain
> >>> resources that are needed for each of the TBUs.
> >>>
> >>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> >>
> >> This patch now prevents interconnect drivers from hitting the sync
> >> state on SDM845.
> >> The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
> >> enabled, which is not a typical case on a normal system:
> >
> > Georgi, before I start acting like a bull in a china shop and sending
> > reverts, any update from your side?
>
> Hi Dmitry!
> Thanks for the report! We can easily add status = "disabled" to the DT
> nodes, but please give me some time to take a look what would be the best
> way to handle this, as i was out last week and now i am still catching up.

I think the simplest thing would be to move the TBU driver to the
arm-qcom-smmu.c instead of having it in the -debug.c

>
> BR,
> Georgi
>
> >
> >>
> >> [   26.209151] qnoc-sdm845 1500000.interconnect: sync_state() pending
> >> due to 150c5000.tbu
> >> [   26.217228] qnoc-sdm845 1620000.interconnect: sync_state() pending
> >> due to 150c5000.tbu
> >> [   26.229926] qnoc-sdm845 1500000.interconnect: sync_state() pending
> >> due to 150c9000.tbu
> >> [   26.238008] qnoc-sdm845 1620000.interconnect: sync_state() pending
> >> due to 150c9000.tbu
> >> [   26.249068] qnoc-sdm845 1740000.interconnect: sync_state() pending
> >> due to 150cd000.tbu
> >> [   26.257127] qnoc-sdm845 1740000.interconnect: sync_state() pending
> >> due to 150d1000.tbu
> >> [   26.265159] qnoc-sdm845 1740000.interconnect: sync_state() pending
> >> due to 150d5000.tbu
> >> [   26.273189] qnoc-sdm845 1500000.interconnect: sync_state() pending
> >> due to 150d9000.tbu
> >> [   26.281206] qnoc-sdm845 1620000.interconnect: sync_state() pending
> >> due to 150d9000.tbu
> >> [   26.289203] qnoc-sdm845 1500000.interconnect: sync_state() pending
> >> due to 150dd000.tbu
> >> [   26.297196] qnoc-sdm845 1620000.interconnect: sync_state() pending
> >> due to 150dd000.tbu
> >> [   26.305201] qnoc-sdm845 1500000.interconnect: sync_state() pending
> >> due to 150e1000.tbu
> >> [   26.313207] qnoc-sdm845 1620000.interconnect: sync_state() pending
> >> due to 150e1000.tbu
> >
>


-- 
With best wishes
Dmitry
