Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD511E00A7
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197266; cv=none; b=VgEV3v0lip4twr+QR/Fri19uyFFIi3i6CliFkhTiOHyJWWzyjkGHoVnK3JpgqE77SnGn3bP2FvRxetzr0HTC+OAxttSUgqcji9jotaJu0B6l5yKTL5mNA5gxDwWvWYZDnaakqLJ7TQO+8g6zoasAFxhFpHUHibFA1LAvPxYZ6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197266; c=relaxed/simple;
	bh=zvtMZtp5ZFWxiSkY66nztDv/vjqLXEPxyjWnZTntGxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdGN6+HTc/yfC4srgbgI4V4mo8D2RF46Xal4XdScUpcyuiTUw3N3sXjv7sUgTc2bnnvlvCh7biUUW2pS3SLdnHO6JOZGVLorfVunh+XQyPE9IS10FAOJRytzs6pblfBSDlUKFvD4x9zPIucQq0124nHuOmH2VDQVe345puXA3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7n6ULNx; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7n6ULNx"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce3000761eso3727655ab.0
        for <iommu@lists.linux.dev>; Mon, 06 Jan 2025 13:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736197263; x=1736802063; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOzmxccnce1E7CXNiUs8eoUX3tWPwgiUu+2R9Zn1q5U=;
        b=d7n6ULNxyyTxLsvhVPpAj/qSERLWNlLb06ARDlyL1SV1tdJHj/WUMSBD45BswTfD/4
         IwX1F5D8KivDQXLgdC3IwD2ySn4xbOlZaMAXqQ5kT0SkSDiKPNjd3eHrlbAC8rMFscsV
         V2TcExxoW50J/lhH/19Ten+oS1gdSPcp9AAoLCUG+8C191Rmyxe6VYs6tljhv1uqnxTQ
         AoUhFPG3UHhKyO2s0qnjnzuD+tIJ9ljQY3zbwo+e7zlKZfNQDjqOX+sC2yrL6Xkl//z1
         GooVSXTCECCPwcdXwDq5QswWKuhl9Z3xleNy8YbaZMZGshpyVvKnznoo92R35+H/3CxD
         zl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197263; x=1736802063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOzmxccnce1E7CXNiUs8eoUX3tWPwgiUu+2R9Zn1q5U=;
        b=hXIxiTAbAHLlXstsdVEMqpADQeIcV10u2xAMwtH2raE4MvBkU5HzoIuf3ZJIfpSEil
         tn7SlDYxcCowKytN19uakcDJoy++m+17OiULzDSa2ktIhG43L8NTNMNZUsKXiKB8D5Vk
         qpC+Fye2NuxXZYAl/MlWDhTfvsWVzqMnxAbT7poNLckSO3pqEBPl+pkh5f8+2mMpmOfY
         uWcYBGYmIhzHPQwdsy8u7Qfo/v9B80gX68XrjakojqEzmc544aCQEtfZ+UVM5IuR4O5W
         XZnhbSBB/toWGHDROagKYvFXCHqXti9MU3SnfZzf/mTI5y2h9vKOwly56P+u/49HnkW4
         KxiQ==
X-Gm-Message-State: AOJu0YzScVJKmLJyj5f69FgMhP9KMK8l1HqlIEhy+nmBd0B+Lsy5B7a1
	MPutKbyN8RSiQE+JRS/Zq76Eq4z474DzqsK6krZaJsuept9KZlCs7oyadpB35wkIT7q9/pCRoJQ
	AOpZ/HYRGcq6GMEel9TGjyc0+6Go=
X-Gm-Gg: ASbGncuve2nH3ODa48Em4L6IqduJMrNg4p1vCG5tHJRSSdSmFwEjVaPT2x2Gmxzzivj
	isMPMxJz/etQ7tQcJA3j6p1jmbR034DHsXQYfEvO+R21FMEln2ulPHM078ai4ltzy9ElO
X-Google-Smtp-Source: AGHT+IHqQnod+WLMTaza+oYE9/HZ2z8HLcXB/MzbtBLsKVq4Jqi09Mbkpt4Wcf/3+HNCWqrXskcu8GZwWbHmP3/D/R8=
X-Received: by 2002:a05:6e02:18cd:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3c2d65e508dmr468450635ab.24.1736197263407; Mon, 06 Jan 2025
 13:01:03 -0800 (PST)
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
Date: Mon, 6 Jan 2025 13:00:51 -0800
Message-ID: <CAF6AEGtNBoWnLA_dBBC-4U7DrWLO+hM_-9iraXgc45Aj885nCQ@mail.gmail.com>
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

Hmm, we do at least capture ttbr0 both in fault info and from the
current submit, so it would at least be possible to tell if you are
looking at the wrong context.

BR,
-R
