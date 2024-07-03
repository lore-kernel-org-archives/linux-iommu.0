Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA8140E2E
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000503; cv=none; b=HfICXvyo7GNAu2OGTTgT+26UKB99eoFfILfy8oeqpBWVIpdl1yUdsFxVjnMJoBqz0ga0C7BcQ0kgavNf5s/XE3txnDLdVZREIouFJ7KlQbSLXgdCYMkIjw47LEW4/GXPzPBpNuSc3ELImGZY7LkbWOsYfaG7N2Bwou9vGh9uT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000503; c=relaxed/simple;
	bh=k/+CTBpj1EiCKMxmYiMFK6O7Hti0OmObuybzNT9VcZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ0Y5Zv/f2AnmPw4D7GeprzxT9uHVeTiPLK6PXjD+dLm5tzpwrUPeGbEwgWxb1qNKVFx+95XwozVDXJvvhErRUAbNEGr4/T1XLZdM6cn/N6IqWgmTbwxTGIHHHU0FZmom3x6vCheZ+onDVyZ9n6sc29stoWdz17KFAM2idCIxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QR7G/rtP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QR7G/rtP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-64b3655297aso46643087b3.1
        for <iommu@lists.linux.dev>; Wed, 03 Jul 2024 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720000500; x=1720605300; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRpouyYlT8w2vDlaWB3dgP182H0ox0N2Q0MheHmPiuY=;
        b=QR7G/rtPi2pcmaQppXeuKF0s9MAB/tkmLvGZ3gzTxGEwO/sd8fj8eCixs4WBLohJdd
         KBA8bHwRfJurzkC+D9Rt9Jvvx8PxnVkI4Kh3z9hitJ+lw+G+y/lMq9OsNdxaNDfGK9S0
         SWgSS9eQ81BqxYIXl1q4vWN8mwjRMuxbYsUBYUWHQHtNzZHqLg5T9nHDfQOrGcSw+R6x
         e+gTO6+NfpNo+5ZHK5nQJvww3TNUHeXwQPy8S8W/GVw6g9z5rs4PjXfiTmxsazIFAss1
         Kjc19St5/nkZqTbSW6tERXB7CvpxKFxus0AuqzckSz6ouyv8TI002nTZHC6oiQwTa4cL
         onCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000500; x=1720605300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRpouyYlT8w2vDlaWB3dgP182H0ox0N2Q0MheHmPiuY=;
        b=gd+KHAG2OciJVOMXzrZMT5iJ3BTCHXG+Ce0M3WvOQIUY3Zxv+HP1h1PGxzh2UYGQgO
         U2WnhVSM4EAqta282hYSxQcraSOExV7uUnAFgKUcjVqv5PxJ0xqJXsaObVZ/55thsF0f
         uOipg69VN0OC/1lCZffRGgOwluL7bNYrY3v5CruVs8K8Bvc3Q/tWEljGrpUCfcctvy7r
         gVqy88QD6eyJqFb0/gIMqE2a69c0jswLo6q9iY74MHRVjoHEkB8t9t65NyJhXJHwGC++
         XNsQug8dsu/f5s3U35bLBmsPiJ+w9a14LhowJKBJPEqtaFwrXyHPDoY0J4F7Ni0enOEp
         xPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyBDfS1QaXrkvYzUJUa1OYYB3chPnh2RGuE2qD6i+8i2DO52dBCly5fdQVjBK/IZ5OTFVFgCk/gYUwNQ9kqYGalYRx9c8=
X-Gm-Message-State: AOJu0YwxNfBHA5Spon0IbcT16UQhWPgigfKNyUc0CEHT5m5qbdPBo0om
	EKX/03kB7kBWCdgsF2Qq6J4dAfkhxauYzHwBiV+TsYGFf3UyHlMdISDE02xfbYNboQiMkijphMi
	4lq1RsUaUDOtDnpf1yyDyTaOBFkJvRCGl7u1ylQ==
X-Google-Smtp-Source: AGHT+IHoNzBewnWkhcdAH2IejqHRntRYwy/kVJsz9+740G9qHkKMZZR3MQADqefkEA2eUyN1XlgmAmLhG8Zvd2gJPFA=
X-Received: by 2002:a05:690c:804:b0:64a:7d9b:934 with SMTP id
 00721157ae682-64c7277c728mr123416777b3.16.1720000500575; Wed, 03 Jul 2024
 02:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-6-quic_c_gdjako@quicinc.com> <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
 <CAA8EJpr3GYimirDz39f4n-3hDAxFWzo+9fdY6MAuxaNguouVFg@mail.gmail.com>
 <3e816509-a12b-4658-85f4-c0d0037c6a64@kernel.org> <CAA8EJpr1G4eq5xJn0z2JQmpXY89UK13uk2BWJCgROsFP_-NkQw@mail.gmail.com>
 <20240702163908.GA4635@willie-the-truck>
In-Reply-To: <20240702163908.GA4635@willie-the-truck>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jul 2024 12:54:48 +0300
Message-ID: <CAA8EJprGja_L6QXVmfSqoeMKCmSrf-qBeAWNToZDe++AsZ+Nyg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Will Deacon <will@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robdclark@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, 
	quic_sudaraja@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 19:39, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 25, 2024 at 03:59:27PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 15:57, Georgi Djakov <djakov@kernel.org> wrote:
> > >
> > > On 25.06.24 10:50, Dmitry Baryshkov wrote:
> > > > On Fri, 14 Jun 2024 at 21:05, Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > >>
> > > >> On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
> > > >>>
> > > >>> Add the device-tree nodes for the TBUs (translation buffer units) that
> > > >>> are present on the sdm845 platforms. The TBUs can be used debug the
> > > >>> kernel and provide additional information when a context faults occur.
> > > >>>
> > > >>> Describe the all registers, clocks, interconnects and power-domain
> > > >>> resources that are needed for each of the TBUs.
> > > >>>
> > > >>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> > > >>
> > > >> This patch now prevents interconnect drivers from hitting the sync
> > > >> state on SDM845.
> > > >> The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
> > > >> enabled, which is not a typical case on a normal system:
> > > >
> > > > Georgi, before I start acting like a bull in a china shop and sending
> > > > reverts, any update from your side?
> > >
> > > Hi Dmitry!
> > > Thanks for the report! We can easily add status = "disabled" to the DT
> > > nodes, but please give me some time to take a look what would be the best
> > > way to handle this, as i was out last week and now i am still catching up.
> >
> > I think the simplest thing would be to move the TBU driver to the
> > arm-qcom-smmu.c instead of having it in the -debug.c
>
> The TBUs aren't used for anything other than debugging, so I'd really
> rather they live with the debug code.

The problem is that not having any driver bound to the TBU devices
prevents interconnect drivers from hitting the sync state (and thus
lowering the bandwidth to the requested values).
Being that late in the development cycle, I think we should fix the
issue in the fastest way. So I'm close to sending a revert of the DT
changes. Setting status = "disabled" doesn't qualify as a logical
change as having TBU units enabled on a platform-to-platform basis
doesn't make sense.

-- 
With best wishes
Dmitry
