Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70384101D7
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:27:11 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-407db3e9669so419881cf.1
        for <iommu@lists.linux.dev>; Mon, 07 Aug 2023 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691411230; x=1692016030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfw4eA1M1eAizs+i2Rvt7ynF9VVbRXwpBeFGZm5EOCI=;
        b=uIY0vvVkH2wTUXghdeMKjG7sWv1UPL4IrjF8KZb9DWiN+hBfBqFVzfJCWntahzNMtr
         4XAjyqRRNaPl8oIWv9qPHCh1xmDXV5fN8d5QrC/vex5S+GxAojZBWuWtgle7WKUXEniI
         mMJsHXkjbr0EIToRLK/ClI8deBg5KqaDA6kOiqaKKGTk8iqsnbhAqidcVJwgWz3cdvRD
         1sMW58L5GV4xeVePIWDut2t570I9BnQdPGYhL8WRElEfzRuHVsedF/OAMY1Jv+lcR1gq
         bkRcebLmUZRaezXlf5nAj26AbsnRJuQCGRAhJeHCWEhy2HfipDf/KNBc85r0tzHFE6Hf
         pVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411230; x=1692016030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfw4eA1M1eAizs+i2Rvt7ynF9VVbRXwpBeFGZm5EOCI=;
        b=S7jYZM0uwkP5u1ElSrCBb0K+rWgH9s1ZsHwLEIijTHMBjDG/3tWQCkzdDgn1K0G60/
         R09URsEQXK2A2Mghn0gEf876B2qMkn5/N9cxAbUc9m1njlAnut+3KVF8wP+wdjXsyqlT
         kLYrxHA5M2bOzqmxh9a6gGDW6WaCYPHVnSXgcieuwCAP2/bmagfeEWiUvhG+9ubfBGlF
         rAZhrKYl7mys5ZkZmhSnmuYDDZXc8wkeuvR1x7QW1pn295a0HDZyfRrWILIOPBStLWGE
         NjywCtkVGWbfsX2IXqGL2nWyasbD44npV2m42WahdBV2fkesORZCB4xArEsfuxXlJtZh
         SFVQ==
X-Gm-Message-State: AOJu0YwR5RcJ78/TYO+tfWK+TpRHfPvXhg6XUGdeFDUqsNHVvlBuFswi
	B2c9v5CdNzn2gcW0HR1nY0fCF51RqI37mH5NEd3P+w==
X-Google-Smtp-Source: AGHT+IEAMtAejquu7vKS5bRdlWrv54j4W0GWjho09B82bo5P7V0+fV18nd9ECZezJJyK7/3WFBcTOADuTwl6f009U7U=
X-Received: by 2002:a05:622a:1a12:b0:40f:db89:5246 with SMTP id
 f18-20020a05622a1a1200b0040fdb895246mr360275qtb.21.1691411229975; Mon, 07 Aug
 2023 05:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <ZM1eAGMxLwZWjt96@Asurada-Nvidia>
In-Reply-To: <ZM1eAGMxLwZWjt96@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 7 Aug 2023 20:26:34 +0800
Message-ID: <CAKHBV26VmoYSF5eRVmAt3zn29o7Db+r1WGUZ5PXpUVcswi2fHQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 5, 2023 at 4:22=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
>
> There are a couple of places calling this helper but they don't
> check the return code. Not sure if they should check too and do
> a fallback like this: if so, this fallback can be squashed into
> the helper; otherwise, this should be fine. Anyway, if there is
> a need of change for those, it would need another patch I think.

Yeah noticed that too; I think those other calls are technically OK
because the call can't fail when writing to a CD entry that was
previously written (it can only fail on allocation of a leaf table).
It's also not obvious how those callers could gracefully handle this.
I'd prefer keeping this commit as close to the existing behavior as
possible.
