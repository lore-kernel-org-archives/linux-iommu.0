Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033AE1C282
	for <iommu@lists.linux.dev>; Wed,  3 Jan 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCVrf+fH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4283b8dc8b0so153401cf.1
        for <iommu@lists.linux.dev>; Wed, 03 Jan 2024 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704300464; x=1704905264; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8szgohDqTCu/X8mh/qJBvJ8B3Cp42vKTFfB8hxy5sQ=;
        b=zCVrf+fHtQQcE1N8Hq21mLMdUn1hx4TSZepvK/Z7BKjkZ8eSyATX1ehUAbkQ8uquNX
         OQtaVhu7kpVk1/4EHIi/NoQNfdtCOR2XdJFLa/EBxdWgVYrZSWYBpITggPwJ9Nl851tq
         2FyQFtR11e8qp/BDBQLuLrZG1xN8pPLuSnw+IX/huz649TQA1rNvheY77YniCggrs/EY
         KofDxh3fB+WsrTF0p9z/UWQ5/685mXUOtKnZitGZY0jDe6B7IbWaQY+Bqg//sPZfbyO4
         L5SEUJ2xXwzzNiqR/R8CFwqF3ueFyqk8VaRNHYkKv58LyN/z4gvumey1Sqd3UL/RbaVF
         2MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300464; x=1704905264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8szgohDqTCu/X8mh/qJBvJ8B3Cp42vKTFfB8hxy5sQ=;
        b=l1aUBmHRCTI1rhRB+Z6ktpruup1oyUfocve9Rn3Du+GmNI4Y8cI7x4ar9TkM0qT8za
         0e/2SngVRzntRmRrObqk1F0SZTffAguzB0QopcQrUFSSVx0jTrZzbbVb3o5ZS/27HisI
         o/xBfCh5BxtFMMw0cjWQ4tur4EMMl3BZSDRKBE5Lc3y3p/J9Gtp98S6mEdfRBenrDTYL
         cNi37RNYPQFAA7DiRJVlj6kfVtweHYszBjdxEuEqYIapncqyr66B/QnXdcQo04RNRFlH
         hkfx84xQQOXshe/IIRjrKWZsI34iT4XYQ/zKLAjbOaUKQjlL3vad3zfCe/jORynYddOC
         D6LQ==
X-Gm-Message-State: AOJu0YxfBmlojOPykUYtQzm/jLQ0+0IvIOqqRHkuWsTK9MnPE+i7W3dK
	gyQ7jkQSo2ZnnI4s/e7uD0zWI0ANfrrasIxDFklnTlLmQTLl
X-Google-Smtp-Source: AGHT+IHb3RdjPmAPrQ3kAwuVsc0IcGpArAnMW9m9XwPaCx9ZJ2dOfRacjn3NRGGgP567gp+QPmQkfQCu81IvmD10Mls=
X-Received: by 2002:a05:622a:1041:b0:428:31d0:253f with SMTP id
 f1-20020a05622a104100b0042831d0253fmr219104qte.17.1704300463638; Wed, 03 Jan
 2024 08:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com> <CAKHBV26v9V7UqqLP+h3yxpPtAewNOOw6zD3DNfDpcejiL1Fr7w@mail.gmail.com>
 <20240103154932.GO50406@nvidia.com>
In-Reply-To: <20240103154932.GO50406@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 4 Jan 2024 00:47:07 +0800
Message-ID: <CAKHBV26YXCenMm5z5O=1DHqfNADOD0Q5yfytiPtX_rHBXYHf_g@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:49=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jan 03, 2024 at 11:42:50PM +0800, Michael Shavit wrote:
> > On Wed, Dec 27, 2023 at 11:46=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > >        } else { // hweight8 =3D=3D 0
> > >              set(qword_start=3D0,qword_end=3DN);
> > >        }
> > About this branch: wouldn't it be more clear to explicitly do nothing
> > or warn if any of the bits differ? We shouldn't ever expect to see the
> > STE differ in unused-bits position.
>
> Right, it should be impossible considering the used consistency check,
> but if we do hit this case for some future bug the right thing to do
> is fix it up and keep going. A WARN_ONCE would be good
>
> If we get here and set does actually make a change it will be to
> change an unused bit which is 1 to a 0, and we've already taken the
> position in this logic that is something we want to correct.
>
> As before since set should skip the sync if no bits change this is
> effectively a NOP.

Yeah I realize it's a NOP, it's just a question of clarity. Having a
call to set() without a warn or a comment could mislead readers into
thinking that this is a valid branch rather than a bug-catching
branch.
