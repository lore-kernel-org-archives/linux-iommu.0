Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470551474C9
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301854; cv=none; b=ut7FI8+Y4whTKcIAKiutCnaTR43ZyiP6NZq/1casgHtj+WRH50hV/Ry78lGQDEdHdCSsIIAjq7MpNeCPQGXIwffKslwDR+If4bMmEpJqBNhQZhwAnGTrgIi612VR7LUHACOq2+YDU96tKj6iTw56VT+6kkCmu26bqkbGnAwOI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301854; c=relaxed/simple;
	bh=8jxcS8tRiE+LFLUa/aufartj472cje7N8ZY+g8JTF0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGX84liDV4T3a6K9reFNlrwuTpoKok/ojOWm05ROljsG7pmqempHgvOpG/aJxvgwJV6mB+/zF6o/IiimiE4PbOfRkGwzjkbzhrzq4F6w904MiVnGIGeSwZIxtxklVee77FbMqZ7QdXkCtzmFU+1+f3qPBOhDEhxrirKVHiQgSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AosLLykb; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AosLLykb"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02e4eb5c3dso4259623276.3
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719301851; x=1719906651; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RTZZV3+tH/geYdSF4ruzYz0JFAprmpnlQN133kk76E=;
        b=AosLLykbqaP80SpxgXo9aW6+UMyDmfRhBpyESshEsE450VvO2VFyz7UFfC1nr6pMxC
         itPNp6IxorgKBnXdK81Y6QWpDpUyhOxjxPyRQkvWJIZS2uiX9zeNioaGukLZeJBFsyff
         FH6w2hspU8t6/+jE9WzbyhNoiC22gWGzJKsPlqOR8dOtk/YJHthfHJl5y8O0uWgw3QnQ
         JGSHX1teXoicd3QMfwMfe8zPbKA1bXu+MDFhVESWwjO9y1RXGxpa/3rOpd5AuEbgMoQK
         gAOrzokbfdgpYceoKC1b3TDJ/dzmHzQdMhMaO67NSIpSy81XwqhiSYQVbzT6aEKa5Nu2
         Pr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301851; x=1719906651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RTZZV3+tH/geYdSF4ruzYz0JFAprmpnlQN133kk76E=;
        b=FccG3vZFJdkKfeVBWIkPY5YwQ0innMDGAfXRvawqOnvOjxm/rR/unp5+FznfsrwxNZ
         uzaztmPwm5hsV78/bLCAaVhb6HLW/4XpmZkFutChhtBXI5Jt+NFr24bHdVuD3RC0DNMi
         QObQpoReoNEtDjvQc+r+yjuLy1LOyJ6e9st3Nbm1N/ft8EEmOXqzG4T9REoX7v6vf4oT
         SUmCpA+j89M0PuOSp3oah179h1P/pTD1lcPxGxEBqWK9isGYTzb1NuYOK1+WU4EMLBJz
         t7cMfgZFBOKvyylQQbIxJErvNvB1Zob5KTDbzC52SwXouhOl0RyROZ8a9N7tLF8imLSb
         GGLw==
X-Forwarded-Encrypted: i=1; AJvYcCUr2f5v6YMZtVBiMdMas8QCvPDgVpw7LLUWf45bjiCbYCtaluk0BMpgwd8rGLHMbWD6Hyj7/sYk05k7TFjORhUcaEvEIuk=
X-Gm-Message-State: AOJu0YxBrLEuXI/+dCZKT3SYeuCtebTqi6xvMfkDAI0wDOxU8+Te4dx2
	mslABdPJFuztn7SBUjAyzRo987ZQJSxiY9suzPKeu9yMdlMPdGLLDwMQYndF+b+NXcfTj503lej
	6k/bQxmvuFOUtYCrUoOGtSal3C9vjvNxniNOOuw==
X-Google-Smtp-Source: AGHT+IGQ3OTSR0KC1/SpE/IADAGxFrimSZmnBj4lcnGkw++5Ft8jUp7w1CXLdHosE9cv9AXQbpTdIr7RsWD+lOF76b4=
X-Received: by 2002:a25:dc0c:0:b0:dfe:2488:c056 with SMTP id
 3f1490d57ef6-e02fc29d8d8mr7663761276.23.1719301851256; Tue, 25 Jun 2024
 00:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-6-quic_c_gdjako@quicinc.com> <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
In-Reply-To: <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 10:50:40 +0300
Message-ID: <CAA8EJpr3GYimirDz39f4n-3hDAxFWzo+9fdY6MAuxaNguouVFg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	iommu@lists.linux.dev, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robdclark@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, 
	djakov@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 21:05, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
> >
> > Add the device-tree nodes for the TBUs (translation buffer units) that
> > are present on the sdm845 platforms. The TBUs can be used debug the
> > kernel and provide additional information when a context faults occur.
> >
> > Describe the all registers, clocks, interconnects and power-domain
> > resources that are needed for each of the TBUs.
> >
> > Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>
> This patch now prevents interconnect drivers from hitting the sync
> state on SDM845.
> The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
> enabled, which is not a typical case on a normal system:

Georgi, before I start acting like a bull in a china shop and sending
reverts, any update from your side?

>
> [   26.209151] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150c5000.tbu
> [   26.217228] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150c5000.tbu
> [   26.229926] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150c9000.tbu
> [   26.238008] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150c9000.tbu
> [   26.249068] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150cd000.tbu
> [   26.257127] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150d1000.tbu
> [   26.265159] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150d5000.tbu
> [   26.273189] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150d9000.tbu
> [   26.281206] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150d9000.tbu
> [   26.289203] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150dd000.tbu
> [   26.297196] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150dd000.tbu
> [   26.305201] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150e1000.tbu
> [   26.313207] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150e1000.tbu

-- 
With best wishes
Dmitry
