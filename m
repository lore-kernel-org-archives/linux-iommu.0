Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6E1DF993
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197193; cv=none; b=EwRfnijtlBqeJiiKt7pFmwxtf89P5D5JRA79on1MfjMen7dXpBCb1sXvju3FQdAcbVAJ/8iRT9WR34JOOc9BWdajohdiGtOpQ4MthJz8/W5JptU0Ocy+x+kRt+Ev0tAu2ROe8F/WJxxhKgCE/0mbww3T/AlFiQkr1BKnNnmmuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197193; c=relaxed/simple;
	bh=rcl+1SJA9ofyCXwS1P0TUFxWyoLXf0nJvOCIMKWwf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJrVrHRt6HFfOuCWoM8zCwmljvyznWyGDiYTrNOpGVDSYEltWtz4FL/1hdHS79N94Oa/ferXA0f8wukSlWDak+TzjskDTJr5FKvQ8TXHox6+UEHYzoYEgRQVijjRuNyoYEmt3rsJ/jtlg/BvJH7DvG8GKV47PPjWGBNzrlHQshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4fLrRR2; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4fLrRR2"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844d5444b3dso566786739f.1
        for <iommu@lists.linux.dev>; Mon, 06 Jan 2025 12:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736197191; x=1736801991; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHlppqM6gvLh+wGWzZMvi4bmlnS1UEsF/Gy7XASBKeY=;
        b=D4fLrRR2fbzuFPidnUclJCvJJO35a+ekNMzRr/Uv6R3LmpW3MIBoojRwVv0uKX+Rlt
         E1KGAOeiPDzP80vfOP4JGVOCaC+BYeSbjiEERSvqWX/q0rEAbstAH5/DVuigHYLPE/w+
         oQp18aYjCaXFyrs94G+kd7snAJohFoxnvEJ+EsmIrZ2SVQ82OBBTyQqDFF735r0adSdX
         Leclav+I1KSOQZWaoc6U5kz0EL6JcWq2aZ5uzya42PdKBKVqD+s2HxLlEKFqHXaWOxs6
         N9m/uQgEeYgEs5iDQvG28/HoUjs2SKx0NsDRUlE98QGgPomP1EAIqZweTsdk5LDPSWg/
         ZjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197191; x=1736801991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHlppqM6gvLh+wGWzZMvi4bmlnS1UEsF/Gy7XASBKeY=;
        b=Zq9v228qfyEWXFf9lDeECtSTROCHIgMdtbiCPlr264R4Xf6pjYKNCkoeck7uJVE95I
         e54RWeG6VkCHInoxfGW9XDOiSwchFjYO32pFzS2/8f9no8Rggl1e5oFXQ6OFW4M63396
         kQLEuzvqwMK3PLLP5FVXE6x9loLETiDl5qIKzJENxPogriIPFwT4Vm/GxF8pVTnX7vPj
         PspzKA2xfrD7KJTWOAIRF46eZ1OJZgvMiPacNQqRjcemjBMiDyrkL+f4S/mdn2727IfN
         SN8B4GiON0tZuFmh9ZuOF4mFVtNw3T2B8q2pMteS8T2jckI39Gqcqulz6E7nIFL40ssE
         rB3g==
X-Gm-Message-State: AOJu0Yxo8qW23hFwy1UFjjWSluVUAyapRnGSnO4EH6er9icPXHjkSiBq
	24P4XYLp8CO/B5TLBJJ7WzYFiijGHJdLXcAS3voBBKgh0pC7uT+h6ySZu8S/o+m9sEN/WLieYUK
	KDJF+D1okubI3M+4hrN1FMX0pFE8=
X-Gm-Gg: ASbGnctHbTksjZOo+gjdJimBDhjCRTvw75V3kj5yK25iFfTxwxFHrUw5hySg2mr4mSU
	Ks0rSEK5gD9ciHRCfA6ZU2GLHb+Cp5nr7fMjYJah6PvF+NrIzJnHvsrYrSaUMDajMCllp
X-Google-Smtp-Source: AGHT+IFsoTqFksRVcj1Uq3xa18RTL4eR+t+8QWVvILYJNxKFRhJkMed879iGVSYCfUIJr246vFnKVIb3m+mEWzm/jDc=
X-Received: by 2002:a05:6e02:3385:b0:3cd:d14c:be69 with SMTP id
 e9e14a558f8ab-3ce31d7b353mr6421065ab.11.1736197190870; Mon, 06 Jan 2025
 12:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250102183232.115279-1-robdclark@gmail.com> <76b822f0-c4c5-4d47-8e0b-c1eee513e228@quicinc.com>
 <48373519-2867-419d-9f51-e7bd330b311c@quicinc.com>
In-Reply-To: <48373519-2867-419d-9f51-e7bd330b311c@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 6 Jan 2025 12:59:38 -0800
Message-ID: <CAF6AEGvDGtP_AAwDYnv5C3Bdg5dJk2muNUpT+yGYe8bn97OSwA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 12:11=E2=80=AFPM Akhil P Oommen <quic_akhilpo@quicin=
c.com> wrote:
>
> On 1/3/2025 1:00 AM, Akhil P Oommen wrote:
> > On 1/3/2025 12:02 AM, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> On mmu-500, stall-on-fault seems to stall all context banks, causing t=
he
> >> GMU to misbehave.  So limit this feature to smmu-v2 for now.
> >>
> >> This fixes an issue with an older mesa bug taking outo the system
> >> because of GMU going off into the weeds.
> >>
> >> What we _think_ is happening is that, if the GPU generates 1000's of
> >> faults at ~once (which is something that GPUs can be good at), it can
> >> result in a sufficient number of stalled translations preventing other
> >> transactions from entering the same TBU.
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >
> > Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >
>
> Btw, if stall is not enabled, I think there is no point in capturing
> coredump from adreno pagefault handler. By the time we start coredump,
> gpu might have switched context.
>
> -Akhil.
>
> > -Akhil
> >
