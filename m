Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D01101
	for <iommu@lists.linux.dev>; Sat,  5 Nov 2022 01:36:18 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id b21so6397943plc.9
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 18:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlpIERxktULlh61Fyw4EChQNh/rwsViL1kaSCYfVIQ0=;
        b=bMVL7bS8QQ9MG2vqCoAIUVBnMLnPACYil2ZaTiMBZC8BmwZqDeVJ3yYOzSVz6lGQ2s
         YKYV3XBMu088T05AOFBeNqxQMcYvJ5ubln7mevmoWmjCutaFGy1JQpjez5ghSwUv7Dhd
         YJCkpSoK5/4Kta2AN+ri0uw12d5C8FU05Fiqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlpIERxktULlh61Fyw4EChQNh/rwsViL1kaSCYfVIQ0=;
        b=0upAjs30doEm1SiGaeL59vfvo6x+PoXooFAyENLoZTgB2pgHgcFr7lkk+B6padUxXV
         3uZuCC77lV2TJPpGsKy52kvRZWnhECc/fJDAsFDxG15R0y7Jf8/gmraL9yt0qb1sSYzO
         HVQDOCv+rpU6BRBgzezWXUhUKdvS6qL6rXg2T7OH72Mpi2bV+35sD1vxkyfjiIZOY/IY
         02kX+a+9jUblUB69kO0TLUrLZSZ3L6OngFT53nSm9Wu1kwz1+kp96KF6CDYBDlhbcmO5
         WykVs9JTi+IuWuwnKnpwUekUFxIPBelMnKMechf1ttWGtq0EBVS/KK46jOLArVOiFyZu
         rd+A==
X-Gm-Message-State: ACrzQf1AeXE/PoNYJwNNn71hE4JChlZU8Yb/9unekZ+U2FC0/LBpKS0S
	E1l5CXQBVch37YVzSjifI6tuTg==
X-Google-Smtp-Source: AMsMyM7egzA34TbfNzwbJXF9p4DvUQBXJw7NGr9dvOVIrtAR3OfhLz4m+niOS4RaB3jc18ab2REGYg==
X-Received: by 2002:a17:90b:4b09:b0:213:32e3:24ed with SMTP id lx9-20020a17090b4b0900b0021332e324edmr56209126pjb.109.1667612177698;
        Fri, 04 Nov 2022 18:36:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:db3:7e2d:1c04:dd29])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b0056cc99862f8sm247398pfq.92.2022.11.04.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 18:36:17 -0700 (PDT)
Date: Fri, 4 Nov 2022 18:36:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Avoid races around device probe
Message-ID: <Y2W+DxePm8WcUn46@google.com>
References: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>

On Fri, Nov 04, 2022 at 07:51:43PM +0000, Robin Murphy wrote:
> We currently have 3 different ways that __iommu_probe_device() may be
> called, but no real guarantee that multiple callers can't tread on each
> other, especially once asynchronous driver probe gets involved. It would
> likely have taken a fair bit of luck to hit this previously, but commit
> 57365a04c921 ("iommu: Move bus setup to IOMMU device registration") ups
> the odds since now it's not just omap-iommu that may trigger multiple
> bus_iommu_probe() calls in parallel if probing asynchronously.
> 
> Add a lock to ensure we can't try to double-probe a device, and also
> close some possible race windows to make sure we're truly robust against
> trying to double-initialise a group via two different member devices.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

If I've tested appropriately (there's always room for operator error),
this seems to resolve the problems I reported:

Tested-by: Brian Norris <briannorris@chromium.org>

I haven't reviewed closely enough to know how precisely this is a
regression (your description sounds like you think the bug existed some
time before that), but based on testing, this sounds like:

Fixes: 57365a04c921 ("iommu: Move bus setup to IOMMU device
registration")

But even if not, the report could probably use:

Link: https://lore.kernel.org/lkml/Y1CHh2oM5wyHs06J@google.com/

And most of all, thanks!

Brian
