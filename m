Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC941C6C
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620463; cv=none; b=i143BdzqeNCGoxg4QEwikKPzOSRvymrWXHiIeO8ByEf/Kj652BHr+VcDO8iBSHa5joNq1bXRbCI0nJYY08waMwhefAZp4hKHR+Ql4iq3wzja5s60/fdOsu8fVu4w0MuW+GiihD5Fg4FzYs4A2rDdNS9U3Lx/rPP08/5YJZgMmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620463; c=relaxed/simple;
	bh=sUdALHFj74gKLRdps43bCPFw5VQP45qJykCrkheTLss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Slrk1vFReWIeLelzJtul2WwSQzkJdOeeh50ZzNfuAmKf6laJAF9CooieL7ZqYjHumMAnP+M5H+ELeiP7YhTFQYzCrBpouzgRzoKffz+os1ypDZJnrSthTsU1m1UJx1CKp9++tzSqZk1NsJzBT3++/OO+Sf26gLQYM6C6fCGHgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksTnf4Yh; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksTnf4Yh"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso3158975ab.0
        for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 07:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620461; x=1735225261; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGSpD3+3yxS9yz0CYWixS3C/FoBfovGzSM7W4jlHvCA=;
        b=ksTnf4YhYbHvA8isQO7j5zfFhH6yLRyAJ1TILA/pfJP8VMYKXiHxQMu2d7nQRH9fAz
         4eeJs917nBednspUCxcKNm5If978YFpUZyUfUd76fb41EpYNsGJwLDd7+j9PHzaCh/Ki
         w+z+XTHrayRuanyse/wKiFEw1cEFVn8FDJM7+Vsz2WL6XmnBmu1ReRPxmMXRIhm+kbhO
         koXQeLz7nfclh82BFGuQWvzTiWgF5g16vYfJIFTgFogQ4Tq7NeNvUnU06DXqFRUhFAAn
         VzbAmdBbpwS+SrB0VF+jE7FVyquwqGLanC4Ca07S5o90kD4j51WO2oLzz5WiJegcCYW8
         lHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620461; x=1735225261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGSpD3+3yxS9yz0CYWixS3C/FoBfovGzSM7W4jlHvCA=;
        b=VQ/3oiajaznUMV0apwIbJFeobsaztrV6ijkbJVfOQry+zimHzLiKvygN3ZyNydmJIa
         BrXRwTjRjkj9PktGdOOsqy+zOAyoc9OXDynGvtxbqpdXilUwme9sK9BkPziwcLDszZIR
         SuLSH1FBnKC9TSBPuJbZA4kJQNkp/yzTHDe81Q0vocXxsFSZyrrZn7oWrwH6eH8PuEgQ
         pPpMrhM+/ZxOCxQlIPnuC2SJitXV6sk8G2VEwhTpsgXykqSDw+XXmzDfYLZot9GumnZ7
         Z85Qu1w0ykxbpaDW0/hKMeB5YX16Pv4JzGTOwlTnMZkYdbd9bBDMlxBrp70ibMAET5A2
         08uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOGIjZ4WljE6bhxa798/sDjjyT9Yu14SRE03DVCzpAjOBu8wb9i7r+Bh9FXNGwgXXl0W1xiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5flm7pMbYimy7yDweVPCQEKEYQvKkG/8KEOlvPhrFjymuJhSx
	T1ykSqGt8KP+UOx94bFA6M27eTNcYAX/lX7Qlapz1csGrMtf53vBebchNsTIf9PzAwUYbqGQzfc
	BEHqTnoqFYqM8OAudYmotrZKvDKg=
X-Gm-Gg: ASbGncvoYTBuiOYFZrkNwtVvR2S+f8y6RlyeZzFLyM/YBGfvp2yOW1ubdo7t8/uV520
	6llcSd/fjVRP981mW34moxS5oeVmNxQcz0TaQaw==
X-Google-Smtp-Source: AGHT+IHp8ABABtvQh+2yyPlFSULZ37QjpTpYXLauYn/rtYNis49Ni4sKHQpdMdeMDdPO+HGJ2/oxRYIljcvIQuXYhZ4=
X-Received: by 2002:a05:6e02:1649:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3c02e1e9aa7mr36636045ab.9.1734620460446; Thu, 19 Dec 2024
 07:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216171017.4881-1-robdclark@gmail.com> <20241219113019.GA23640@willie-the-truck>
 <41d93dac-4ef1-4cc7-a7b2-24c8289f905f@arm.com>
In-Reply-To: <41d93dac-4ef1-4cc7-a7b2-24c8289f905f@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 19 Dec 2024 07:00:48 -0800
Message-ID: <CAF6AEGshSjOr1DE63WiXwAyH39-Tz9B3MEkKUo6sg1jpQPYZcA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:08=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-12-19 11:30 am, Will Deacon wrote:
> > On Mon, Dec 16, 2024 at 09:10:17AM -0800, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> On mmu-500, stall-on-fault seems to stall all context banks, causing t=
he
> >> GMU to misbehave.  So limit this feature to smmu-v2 for now.
> >
> > MMU-500 has public documentation so please can you dig up what the
> > actual behaviour is rather than guess?
>
> Yeah, I'm pretty sure that's not true as stated, especially with
> SCTLR.HUPCF set as qcom_adreno_smmu_write_sctlr() does. However it is
> plausible that at the system interconnect level, a sufficient number of
> stalled transactions might backpressure other transactions from entering
> the same TBU, even if they are destined for a different context. That's
> more about the configuration and integration of individual SoCs than the
> SMMU IP used.

I am aware of the docs and I've spent most of the last couple days
going thru them, as well as the errata, since it would be unfortunate
for debugging to disable this ;-)

The scenario where things lock up involves at least a few thousand
faults in rapid succession.  Disabling CFIE in the irq handler and
re-enabling when I resume translation does stop the flood of irq's but
not the lockup.  It might well be something about how the smmu is
integrated with the interconnect.

BR,
-R

> Robin.
>
> >> This fixes an issue with an older mesa bug taking outo the system
> >> because of GMU going off into the year.
> >
> > Sorry, but I don't understand this sentence.
> >
> > Will
>
