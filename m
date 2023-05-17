Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503075255
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 05:55:00 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53404873a19so186944a12.3
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684302900; x=1686894900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD2vjNSX2CRlbQjilqB2EsGGHkDf0f9MkzQEA1smnmg=;
        b=ZSOPGJSOeD+Ae56OftEqSsy+iNquVSksSVB/ubJK8Clb6s26DJWxAN4ZjKGRKPWsNH
         hl8pFLtBCa53OexkTogpIYNx5SzV8qZVyKj/fJ2NxbfSLP7EornT0RO65pvYDiwjhhfj
         SB2gSsqumUWO+hf0eDvZ8SnIivRRnIQJfFoCLNAvRskFVgabOVlm4GhPVoQPVczgjOyd
         7sFkRupkj3WJPB1rTqGbKpBrQe59u0Qr0JGCuA/HOYo/rLStmStiaFY6DJtLLgF+HXWV
         uH563kNHqNmU59PwVPyF170aTb4OmtfDQ9M15VKCIz9OCKPYTK9RjSHP4jbd8ZGcl+Ws
         ZADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684302900; x=1686894900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD2vjNSX2CRlbQjilqB2EsGGHkDf0f9MkzQEA1smnmg=;
        b=Npb0Gt+Bqjx6qtHkgp8W/yfhetisheRufGVXYYmvdr350xcKncQjDWaSNrxcNJbQSm
         QY6WGX9QuCjCaPALvw3OtbYNXcoBGTr4dNltp7h9UIuPpKWVQ2tfJ34fsES1CdkeGnAT
         KnNNoI2kqqc6zR1doS/P6cUyzc3c/paOZRTveLNyXOvxCXm6Ha/EGiOlr8u1CDL2IPZl
         cLP60tgsuov6eLJMKXuM2WW0B3frRWb+MZIXWc3vEplkzRlmoJhskIIE4LDiJ2vALPwl
         3PcJpumeWyxSGrIeAp5XZLNOAeani6t4F/8n2bIal0l2kpETUqo1UOvPUlPO969HDxt8
         iAjw==
X-Gm-Message-State: AC+VfDy1eocYopqwtXdaaKZFlHIHhCCuQmOYGqtfpRmhIfMiDzu9oY9p
	wc45l4pv6PLVcn/mHf6XpRRF4CX9MrNJmT6/XeYvbQ==
X-Google-Smtp-Source: ACHHUZ4gyns5hMoFN3qfln2/VRnm31xyk449zYFl++tXnMGWGLqlE5Yh8WF6gO8FvB6bI0mTIt6MLo1/heRK+lY6FlA=
X-Received: by 2002:a05:6a20:2583:b0:106:feff:40ce with SMTP id
 k3-20020a056a20258300b00106feff40cemr5505097pzd.1.1684302899584; Tue, 16 May
 2023 22:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com> <CAMC_AXXgBoRZOaDpCex+g_YeOdPQpKD3moQ8VMsqVEm2nqSrjg@mail.gmail.com>
 <2023051703-unpaired-phonebook-58e9@gregkh>
In-Reply-To: <2023051703-unpaired-phonebook-58e9@gregkh>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 16 May 2023 22:54:48 -0700
Message-ID: <CAMC_AXWqKU1snX7TCQzgpPMPmMWFxYq8-Lyd=KaUGjoF4GBFXA@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nadav Amit <namit@vmware.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sudheer Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 9:38=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 16, 2023 at 01:59:16PM -0700, Jon Pan-Doh wrote:
> > Hi Joerg,
> >
> > [Cc'ing stable@vger.kernel.org per Nadav's suggestion]
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

Thanks for the link. Added the Cc tag as a reply to the patch.
Apologies for top-posting previously.
