Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2E34CEC
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 15:15:27 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-54fb46d8631so4748292eaf.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684250126; x=1686842126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq/FuI0gOpzvfdbdJmPxEDUFLUJapP40FhB8TwSxte4=;
        b=L+1zPFmW5cqaEZ8kDZNuGIvHzRjiWIY5LDPieIsyuUwsfWODiprrFL9z1ACcunFzn0
         I6HwUjq5w5lWXfbHBiRpfFi/w2GNXEoLaeqhhHO/lJkmchlxJcOTkQf97xxLlKAgppij
         L0/hIFsegcALFm9jpOkLi0HbRonHz2o7lVDpUvILuifHg0YnPWB/F1X1EW7qMrgT6qkt
         OV+oq71g2eVyLCfnA6Or7Pypk0Gk27mRkMTE/L0mSF66zJk7FC8ZErFOxywjff6zJ3xU
         Gk5tTMMG/P9wa0O8RccyLN0B2zaesV++dyqlFvXQS+o7q3gic8qktZFDBtM3oz0+09Wi
         Ymcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684250126; x=1686842126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq/FuI0gOpzvfdbdJmPxEDUFLUJapP40FhB8TwSxte4=;
        b=H2mcnDvSKMKVSAUNay26KOjFC1o/lH8YZPe7B7io3vzsPU6m+P1rGw5BdATA+pTJHn
         oGv+XcUq7C90fFT5oruIHOorxoG6Vc90dW24r9/vcr3CtshmyKTJDE6VrTfTcW+JjF9O
         MrFZ0cG0eSF+EAP7SWzdZK14E4JoMyWELE/GYnGGp7tXUjjSpyyFPoHxwOiV9oD+SuGn
         CN9jItXvzXgo5yfIrduovPXfoR5nd//HX/2qnUDVdKrpEWJcVkUJsPa9YMEb6aiJXI2b
         nieM/RQw3MkAVtxfgu6kYLUvTjeZeGv7kmhCH+pktTRXA8DisQ8JBYtoOeleZAxl/v3a
         Yosw==
X-Gm-Message-State: AC+VfDxpgsUixFgWMBZUoifYg44uOj7y+rDa8fsRlxmvanO4PWRjPOQS
	UcsTBOLNZBAAMbQs1lduVGc4EqMS6p6J4SC73Rk=
X-Google-Smtp-Source: ACHHUZ7hKL4wO1p9Isk5Bui22fhJLNa5nygADjpBUbV+o2pAu/UoDAHH404cjCkf0SKnWfQ6CFLLkp8mJhYNtAT/qQw=
X-Received: by 2002:a05:6820:291:b0:54f:84d1:51ac with SMTP id
 q17-20020a056820029100b0054f84d151acmr10945948ood.6.1684250126328; Tue, 16
 May 2023 08:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1684154219.git.robin.murphy@arm.com> <CABr+WTnzNPfOGbAmy-E3pH9U5XR0y2PdVmDd2gtnv67ByEb_0w@mail.gmail.com>
 <11d8adf1-75f5-5728-2139-e32aae6e6c49@arm.com> <CABr+WTm=SehaNVaFym5FM-tpCvh93Ma_xG3xX5PuGt6n9+xh4Q@mail.gmail.com>
 <aadb69ff-732d-cffc-ab44-398269a11d4e@arm.com>
In-Reply-To: <aadb69ff-732d-cffc-ab44-398269a11d4e@arm.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Tue, 16 May 2023 17:15:15 +0200
Message-ID: <CABr+WT=qZvvW5QqCW_J0V20-56d_2+xkdPs0FcgiJZiY6K0CCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu: tegra-gart cleanups
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org, jgg@nvidia.com, 
	digetx@gmail.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 16 mai 2023 =C3=A0 14:31, Robin Murphy <robin.murphy@arm.com> a =C3=
=A9crit :
>
> On 2023-05-16 13:16, Nicolas Chauvet wrote:
> > Le mar. 16 mai 2023 =C3=A0 13:45, Robin Murphy <robin.murphy@arm.com> a=
 =C3=A9crit :
> >>
> >> On 2023-05-16 10:53, Nicolas Chauvet wrote:
> > ...
> >>> For what it worth, I've tried to test this serie with "grate patches"
> >>> (1) rebased on top on 6.4-rc2, that would make use of the tegra-gart.
> >>> That was on PAZ00 (with only 512M of RAM and 96M CMA still allocated)=
.
> >>> Unfortunately, this lead to the following errors with display problem=
s
> >>> (no character displayed in lxt-terminal and etc)
> >>
> >> Thanks for testing - it's quite possible I've made a silly mistake
> >> somewhere, but just to double-check, does the same happen with the
> >> existing driver if you boot with "tegra-gart.gart_debug=3D1" (or at le=
ast
> >> enable the parameter via sysfs before the DRM driver gets going)?
> >
> > Using echo 1 > /sys/module/tegra_gart/parameters/gart_debug shows the
> > same messages and the same artefacts (missing refreshed window
> > content).
> > Using "echo 0 > /sys/module/tegra_gart/parameters/gart_debug" revert
> > back to normal...
>
> OK, cool, so it looks like a pre-existing bug in the caller, but I guess
> it does mean that unconditionally enabling the checks isn't ideal until
> that can be sorted out.

Seems like I had a non-default option with tegra-drm that was
controlling the way tegra-gart is used:
https://github.com/grate-driver/linux/blob/master/drivers/gpu/drm/grate/gar=
t.c#L19-L29

With option 4, occurrences of failing allocation are experienced more
often than the default 0 options when only "scattered BOs are mapped".
Also with the default option, no noticeable failure is seen.

Thanks.
