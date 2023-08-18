Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5111CA7
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 05:35:30 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-407db3e9669so122821cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692336929; x=1692941729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIkvyPStiVOM3BXBPHJZAc578+XILOao7zVTBu9PtEs=;
        b=Cz3m2zl9Hggfk9iQS1J+Ma4o2HgOdSJmoi8Z21q0eZEy6QoF0xpJJy7zD1iSKs8QsI
         /K8LvkszJ8LOM02Axuq/4R19jNVyieCdRb7/UVr/4ofKcveXTJmNJV46LOY00VHMHZia
         DzqvTOjZApRiKTpXi9nroCBCxx30Wz2ClK1LxcJ/nI/D3JxmnhbOSZZlcHecpPDinBU9
         BqqhGn42fPixNS2aPPkItChLr+EXwdE7qkbbVQbyudOc9ZQecxuRr6QfM3lDbvRfQs0k
         y71d4/dJZD2mIyoIlurfFATc31A8Su/gv9sOeiPw/ZkIaG1KvoGlyVGOC0UzLzJJl15I
         FG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692336929; x=1692941729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIkvyPStiVOM3BXBPHJZAc578+XILOao7zVTBu9PtEs=;
        b=Xnf+J314dGZoIe+p+1DW/r2dG/f7NBvTpwQRrq7hk+8TLLSo7OsS7ShXko/eSU65mV
         cGSpSBGb2loT4Bn/9qbKhw6grk0O+2jl+155dkRdja/xjyBV8DdK8Y/6EAAReQOj+RiX
         01V4wHr6C1fS4bUvEgZs6FvI1z4RQrMmpStUqa07IPBINKMscUofQxvKuf9gkB/3AKG8
         8L1cSj938cRma42KwJMaetj9DzUg8ICdnC4k6JwJoXmivsAojw/ika5o2uGggGX45iDZ
         5zHO2yzg8Xz+ciOR1iKMjcb9+6kGjaPamB9KN3G56/HsYJKgCviRvgRMM1WiVzjrq/3j
         qbJQ==
X-Gm-Message-State: AOJu0YxZvnBpVdB26IXnJA3DO9X0/zeV/FryIhikSQkxBjj6/mx70ot9
	vicmWUM2cXPE5wscn+5TkncBnv7fl/Fd8LbtUgwuew==
X-Google-Smtp-Source: AGHT+IGyKBjAQDPxPn9PvmYN5kNv4FHlwRnVLyWO7NfNCoa4cOaxZPhMNJfp+Z8/QK9BDYk8mitfSfyXYKhEbzoV2dg=
X-Received: by 2002:ac8:5c13:0:b0:3ef:302c:319e with SMTP id
 i19-20020ac85c13000000b003ef302c319emr157986qti.8.1692336929243; Thu, 17 Aug
 2023 22:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
 <38eea9f2-7c55-86e5-c0e0-e02f419c4331@arm.com>
In-Reply-To: <38eea9f2-7c55-86e5-c0e0-e02f419c4331@arm.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 18 Aug 2023 13:34:53 +0800
Message-ID: <CAKHBV243MUtVN8sf1O+u7Qseq-1YMmSdX-hVx0=t1o-9dni-WQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, jgg@nvidia.com, 
	nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 3:34=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 19:16, Michael Shavit wrote:
> > Add a new arm_smmu_installed_smmu class to aggregate masters belonging
> > to the same SMMU that a domain is attached to.
> > Update usages of the domain->devices list to first iterate over this
> > parent installed_smmus list.
> >
> > This allows functions that batch commands to an SMMU to first iterate
> > over the list of installed SMMUs before preparing the batched command
> > from the set of attached masters.
>
> I get the feeling that any purpose this serves could be achieved far
> more simply by just keeping the lists sorted by SMMU instance.

I initially tried just that, but then you need more sophisticated code
when iterating over the list to correctly batch operations by SMMU,
which is the more common operation.
That first hunk is very unfortunate though... Let me revive that
version and send it out so we can better compare.
