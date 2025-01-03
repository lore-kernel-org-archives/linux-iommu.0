Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9181FCFD6
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928218; cv=none; b=bKirI9GZi/KhzfoIS5/vY1BbIksq3TlM7c0qwC0evHnoiCa2DwnI19R3PZWhPFhnYem9F1P9z4ivywi5xNNAMi46cPQZXbsJziOF0x9Ums+Z09sIGuSjAAxfEk/6dnsdsunnhd4FO3JB4vJg+UFPYeWgVKiPHyFNVhqHFnH+cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928218; c=relaxed/simple;
	bh=8ZRxQBwY6b/olGpKehwm6xum2J+FNJPoX+p5VhHODY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6injreCamAirkI6deYXcArw9Q/ndIMotAxZpFXBbahXR+wqF8SkbXxAZ3/kcqQMjpyZxaNcKVMt29lS3Ak3gmbJ2hieqLaBbbGIcb5c8qe3xaJvCRxTrwMmQ+KY/JYmrHl2VMYGwdSUB6MBlOToeK3PATeeuhVcD8qaN0usag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILSrZkmz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILSrZkmz"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a78b39034dso44527875ab.3
        for <iommu@lists.linux.dev>; Fri, 03 Jan 2025 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735928216; x=1736533016; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn5PAch7XdWTWHNIRarY/0lUl5EQINJyEEFjNVV3NLk=;
        b=ILSrZkmzQUEYPX2kPwwds3N7TRz9jDFEwcPCb/PguDbI5Y4xNUYf8Ps4MXMNjek7EV
         Ghz0Y4sRmBgOysvR8P7vrYrfvXctVo5kujYxcw5/JwW4/86hAWHa12XpWlwb0ZxTx/O4
         S8xEUILWvAv1YRcyFUluAaga8s0HuPOn7KSrF2eMSsEwBPFO43yX4Q9Rk7PkLNF6YJ6W
         93RyiJjHcsJKv8yv/6K4zj1IPMdOQlFOm4P+ada2BzeOl2gczIX5SFF9+MszK9huTpqT
         GJFM0O3AeikDQn2s8ZmX7/XIdu5rs3IDZw/sPsml2c4bXNAEm3lCjmLES147q+WN+MXt
         3Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735928216; x=1736533016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn5PAch7XdWTWHNIRarY/0lUl5EQINJyEEFjNVV3NLk=;
        b=mONyzuz2EhUKc5E75JAMNusl7HAn/ebdNBdE2z9y5ImUDVPlASA2R3UwbLaAcsEMxi
         N/Edof59HHhNjjqAYSCPVhySjGkiW1aok4GOHjTRrf/tTq97mMNLNdFh5aOtm2LZMoTW
         IpiatqgPR/0fJ7MbHYE/t378qHX6qq7GXaz3KVA2bihFMijaQWu6f9etBkj3jgGJm/vs
         MAt0UU9/kC1l1JSk1HuyddVkGzUz/qakou0erT1ZCTD6HFRZlEZfUntztQZ1OcuMSGbf
         1ch05oB9uy15xOLXSHo/0E8ySu0Y/cm1w+kTVuHRtJJgxbqW+lWLQiCG+ZvCsRY/U99U
         otNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWELhHGBsRDd/V4ie40MrR6VUS3ehq6hOYPMYadTZ4gNY9HZgmrg5njClfKVA/fuDOylQwm4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHf4tTfm6vEqt48ktoC9m8f7GzyDbCOipulGxTiGJT8Kcv45+3
	+5Amcnq55hysj2DFJLFsFngmRtBVQ5YGXBgHnFGe4LWOgdUZ8CnpPB6HvynIejO2DCMXug8JRx2
	TFiwUR9MWM38RwHT9H29g/01NiyE=
X-Gm-Gg: ASbGncv2Dsvjuw3I18WFPDFSH5XquXoavYOJT0Fw0yp/czVr6OLbtpEOqIIRpMRILHS
	QuMaSQGEiF+BRuFHFFES0NZ1dlppeWDY2iaidYLWEJ1vtlTAj20ZgIaITf3yY740PDU/W
X-Google-Smtp-Source: AGHT+IFkvWah3qxhzEMeR0lXa3avHR/olEfCKY9qWp0cniyQbDoTluhhzT5PfOFVB94chXa1QUUdUshg5EOLFdZeUdA=
X-Received: by 2002:a05:6e02:194a:b0:3a7:7124:bd2b with SMTP id
 e9e14a558f8ab-3c2d514f8e4mr434511105ab.15.1735928215590; Fri, 03 Jan 2025
 10:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <28bd756a-e0bc-49e7-9415-4c05d38c5e28@quicinc.com> <20250103153716.GE3816@willie-the-truck>
In-Reply-To: <20250103153716.GE3816@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 3 Jan 2025 10:16:43 -0800
Message-ID: <CAF6AEGua_WfLd2PQv42NK3R1oOgJ8wNf6yt6We4tH0GFkHPnoA@mail.gmail.com>
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Will Deacon <will@kernel.org>
Cc: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robin.murphy@arm.com, joro@8bytes.org, 
	jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 7:37=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> (please don't top-post...)
>
> On Mon, Dec 30, 2024 at 06:45:29PM +0530, Bibek Kumar Patro wrote:
> > On 12/12/2024 8:43 PM, Bibek Kumar Patro wrote:
> > > This patch series consist of six parts and covers the following:
> > >
> > > 1. Provide option to re-enable context caching to retain prefetcher
> > >     settings during reset and runtime suspend.
> > >
> > > 2. Remove cfg inside qcom_smmu structure and replace it with single
> > >     pointer to qcom_smmu_match_data avoiding replication of multiple
> > >     members from same.
> > >
> > > 3. Add support for ACTLR PRR bit setup via adreno-smmu-priv interface=
.
> > >
> > > 4. Introduce intital set of driver changes to implement ACTLR registe=
r
> > >     for custom prefetcher settings in Qualcomm SoCs.
> > >
> > > 5. Add ACTLR data and support for qcom_smmu_500.
> > >
> > > Changes in v18 from v17_RESEND:
> > >   - 1/5 : No changes
> > >   - 2/5 : No changes - reviewed-by tags collected
> > >   - 3/5 : Addition of
> > >     pm_runtime_resume_and_get()/pm_runtime_put_autosuspend()
> > >     around register access of PRR related private interfaces
> > >     as discussed in v17_RESEND.
> > >   - 4/5, 5/5 : No changes - reviewed-by tags collected
> > >   Link to v17_RESEND:
> > >   https://lore.kernel.org/all/20241114160721.1527934-1-quic_bibekkum@=
quicinc.com/
> >
> > Thought to follow up on this thread to highlight the latest version (v1=
8) of
> > this series, in case it was missed during the vacation period.
>
>
> I'm waiting for Rob (Clark) to ack the last patch, as he had comments on
> the previous version.

You mean 3/5?  The latest (v18) lgtm, a-b
