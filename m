Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD11DF72C
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780863473; cv=pass; b=Q7B2+JpFRkXgHmmDmr0vNrmMwxd4/Sqb9ZvfjTQjMMivv7c938pvOkdBC30ZUaGU7v51fUK+n6JygQiIPUSX5mX4FZ4+GZ5ndCzxtnENCwo5VwX1yIUzEvSoqJsS+GEojVxl5ckq2YWbzk6SsHb69kAkUcIHF6F1JmBZgdDIsUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780863473; c=relaxed/simple;
	bh=g6uuxZIkXubi8+X9lswk1jK4SbY7z0xRZU9Q0sQS/WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL4bfwQ0wSTvhBw3hY2ImerVAGSLoRktpll1d2O8wcLpo2IIm7XCccEeHeTr/t8K/hVuOEcHr4y8rdhcoTIY/7B/9G0gdno3TJ5I5WBAtUe6U9goIHgYZJ1rZ+sxruKgePIC1vrrrqYAzUZwIkSiefIg+4Ge8ZCD2VsVq7E/1NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyJTUMSb; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyJTUMSb"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765331535so1319291cf.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 13:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780863471; cv=none;
        d=google.com; s=arc-20240605;
        b=YIFWRfyrOLHAk2QcAYt7ByXdZkA/KkAKzSP3zkPRAv4WSIraS9oNoo7XHDfTrqVzWb
         958emkwHyHRBYCvhIeJA+BQbXx3FZ3fwbwubvCfzVM7ClHfPPJGCzaes6l8Yr2MKf4qu
         qrQ6rlHiAHhp+tndAVJRuKlE+79fCdKstYnXSyOBTAidhY+2rixdsmHeTdEy+njfb9Hc
         aiGwlys2wu2gNsO9wYm76Gy12qoa9pcKApGqaHIRebebeP2MVGL+s6PMV4Bhv/kRit8U
         ibz4w6wsQUusxpjIISh8U0feaLxP+6LRwGx7SXKn0wWYs8BFW/F8i1nzDakpZAGThlpa
         9ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g6uuxZIkXubi8+X9lswk1jK4SbY7z0xRZU9Q0sQS/WE=;
        fh=OxJE3g/Cm7kqgqFkRcT5ih39IPlccoba+9tgLvpnTdY=;
        b=Mn4S04ygxzR42LrpsNY02Y5cIvKMlqpm/J+g1arzsPiOGHKdriraANqVC+ac6ySo4M
         7BWrf7ALCMZV6EthgFtCZtc2W2V33RjO3Vfzd7b+OL/WyYn88GhWhBM1M2wvS660/6rF
         YQulLeJ9sGfgfIqcHu3otBPCFbPjdjfSmJN6eM4bvD0J4FhljBe5hsjgyHDMfVvxmGt8
         APxHv7EHoWhju3oH6rvdpC8eH8yTFCu6ZBE8cS0BVmQMnMbt8hwJbq0CJ32qLXIX3rwV
         zniSgREyO5madQUvS9st8Nc8DMhedNXKrVJXLGxmD+f/zkM1XRQBQz3gbhcO5KXPkwV4
         3lRg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780863471; x=1781468271; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6uuxZIkXubi8+X9lswk1jK4SbY7z0xRZU9Q0sQS/WE=;
        b=RyJTUMSbbnm5wp8I2pj3pUyGAfMkMOPGMq/mDUECh5qpDOZf9bmt2sHfzh+fcb/TwU
         mbd7Jw8Yav7pe0e8BRPcTBkTBSnZeFBUSvwgBchfMlBQ0G27l7D77xM2Cx0J+53LtiFl
         Dxjt536WoO5XkibZRfcEWoMWByWrvemjKNVAwDMEU4NCCgzEg/MUDarTQSs/6VOsoUra
         +Xd25kAPa2EASfulYgKaNt4+lSWU77Zb0zUN+C8qUY+vOq7yUeDGqw4Btu7Uu+BXQoo6
         aXp9+Grp+FhXuF0NUSsa++6WSX6j3iX82jGWSwv6CCN/dbgBOmqJz61f3f/QVg2MvaTh
         HFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780863471; x=1781468271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6uuxZIkXubi8+X9lswk1jK4SbY7z0xRZU9Q0sQS/WE=;
        b=ZExhPXi4mfk/9gKpYNw4YpbDxcnSdp6pMFxkdLwGcBI7cbX+vr2PIrnse/HcwOi0y5
         x5yQ3G+IGEVxayHVvSxeZUqQPdPCEegRWtOv8M+24sGlNZO+XvYeEg15iVCEhAygyXn1
         vIEufRBP3F/68/NJCwmVB4w1w164fcMNfvnIF5izCD9Qyu/z5KNQF41lkXhI2wo/W142
         CUlL6D+yUtGs3F4nabAzONZfiSm6J2eX3ZanWtKr2PBh/FmhBEh+mF9cOMMpxpXm4vo+
         N8iqidm8QQW4q6e8RGdw889I/YMqnHOL2ddzTXMikfuDOQer/k6MhIR1FrXKJZCiUeI3
         eQdw==
X-Forwarded-Encrypted: i=1; AFNElJ/dV9GmAm+18q+6vEvwXI+ii2bh95y5UXAmdwYGayDqeVVuquN4V5bEPzdPZj50StIzxD7K5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJfLu6U2b0RiHOpD89D9NNUDl+M30ar8y1aFWvQyfLiLP9ACY8
	62zrqTlnOfjh7mQAjdUDybV5y9KsoeQ0C+KjHbR6Wn2ccDtYjdYYL40W8J+gF+eJVuGQxGXHcQ2
	ORsVFFQHANK7kbH2q7fCtFP8TTKaMntZeirQIrOZn
X-Gm-Gg: Acq92OEh8rjgD2ioSleBb8CohGVCgDLGmAH+tJWs/dv95huz0+t4mLUsiCtngpOe+xa
	kK2/RUAntDy8D7WSDqTdVshIgTzukVrC6cnZCpNnPZw4UfmH/vR5gIXTe4aFaNbBZc2WlyEw1v1
	6JtcenMqBJxDTcsAX5anQd3TKXvU/N9U4TnhlwhGEo4eQNcu09XD2yTm0qXl1BU/Bo8FVgPiOwG
	Wz/5Zu6fkuDaoAAmsf+4Cpa/NLTseMpoSkdti0D6vvg68vRIYllBkVc/McVr6sItrs4ztAmpT7H
	uknXNcLsHrN72Ho=
X-Received: by 2002:a05:622a:2307:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-517982b5301mr23485141cf.22.1780863470425; Sun, 07 Jun 2026
 13:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com> <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia> <ahi3uY9YZZtR1Lq5@google.com>
 <CAE2F3rDeZe+w7-V6hyJtSOwCj619E5SNtjJjZ1-yu1sVdf=35A@mail.gmail.com> <aiEm0yuNtG3PGJ4D@google.com>
In-Reply-To: <aiEm0yuNtG3PGJ4D@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 13:17:39 -0700
X-Gm-Features: AVVi8CeF-_WsFzniDWXOyB8GfBOgqVxzvT7rGKVs_9DlSPru2oeVHWYao6nDKEM
Message-ID: <CAE2F3rDwx9qX3O0GQOJ-CQ1dqREKNp3vf_PkWWP+xmyEHRuOnQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:18=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Jun 03, 2026 at 03:18:32PM -0700, Daniel Mentz wrote:
> > On Thu, May 28, 2026 at 2:46=E2=80=AFPM Pranjal Shrivastava <praan@goog=
le.com> wrote:
> > >
> > > On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > > > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote=
:
> > > > > TLB and CFG invalidations are
> > > > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_F=
LAG via
> > > > > the arm_smmu_can_elide() helper.
> > > >
> > > > All the arm_smmu_can_elide() call sites here would eventually elide
> > > > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > > > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
> > >
> > > While issue_cmdlist() would eventually elide these commands, the
> > > can_elide() check is necessary to return early during suspension.
> > >
> > > This avoids unnecessary stack allocation, cmd building, and spinlock
> > > contention on the cmdq->lock for threads that are anyway about to be
> > > elided.
> > >
> > > By dropping these requests immediately, we significantly reduce cache=
line
> > > bouncing and contention during unmap storms. Furthermore, the early c=
heck
> > > also allows us to specifically trigger the WARN_ON_ONCE() for broken
> > > devlinks.
> >
> > Hi Pranjal,
> >
> > Have you observed unmap storms in a real-world use case, or is this a
> > preemptive optimization? I would not expect a high rate of map/unmap
> > operations while the SMMU is suspended. If a client device calls
> > iommu_map/iommu_unmap (directly or indirectly), it suggests the client
> > device is RPM_ACTIVE, meaning the SMMU should be active as well.
> >
> > I am in favor of removing arm_smmu_can_elide().
>
> I saw some with DMA_FQ (fq_timer does batched async invalidations) but
> the early ellision doesn't really help with perf which I agreed to in my
> reply to Nicolin as well.
>
> The early checks were dropped in v8 (except for invs_array and for the
> WARN_ON in inv_master).

Hi Pranjal,

Please correct me if I'm wrong, but in v8, I can see a call to
arm_smmu_cmdq_can_elide() at the very beginning of
arm_smmu_domain_inv_range(). Isn't this the path every iommu_unmap
goes through?
