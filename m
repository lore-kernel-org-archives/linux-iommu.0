Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47D1D9A50
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018846; cv=none; b=Cov1mp/6yVXRqP4T+hqTbRs5qMrLYlK2nMy1sqOshK9j662/jl1xM0Ai71IXOTd3bwjviebGzY76soGrDziCiSql90MlQwl2rfWJhuURVfSAjGxpEcfxQ0BysS2fFYoaHhRJHbl+uYTPfPZI3XEJP87Nj2AX7mADQ2O5pmcqht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018846; c=relaxed/simple;
	bh=ik1jANny4JZC7b1ww6qMIuIouYXWD9SXAV9Tm69kocE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re7q2wQ8DCboK6e44kVKlATvZ2i/WXZUcZy4/msr06EeNyNMZYRYMQHV+4+NA1Omo0h0EfYvOhN4J8SPcPYeoTTuqCLuHmnwNrAidoJMgO0vzZ4iQqU+MseuDMnWhoKCTqnuiP7Uc/uY1Vwh2lJ79xu3dCIEQO4+uRvYlhC8btA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=iDi+HUYl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="iDi+HUYl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so1255351a91.1
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1737018843; x=1737623643; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV0FE2GNI/NjTuPPZBCSl4b/181TO/jsYtqVMyKlwQY=;
        b=iDi+HUYlZRDjI7d+3pnPWKsA1TXQ0VmjYsqVeceZo8W/kkgmx+hqBNFaqSpH51GgQv
         6ht95RsJHi+jcx5kjFKngrv6WQsGveFCozw9S5k49dltPhv158FxUyc2TWERw0MiU3rB
         X9BAxlrkDTutNJj/kCPGdV8a+tVRBdA9kleTnoQkoMdTxRTRz0N76zEEcHFuT/lZO44G
         57DOl2TVaLqTAh5m0Kxzu6QbkE5+cUixGe5W/dnHC7OeHmkJJgjG4iMKhHvTynkz0nk4
         83NElw4gQ2qiI+RJ7mbvae70L5xStXlSP69hP+MLtreWbBMQ21mYGDnN0czQ99ffTGJs
         FDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737018843; x=1737623643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV0FE2GNI/NjTuPPZBCSl4b/181TO/jsYtqVMyKlwQY=;
        b=InlORINNvICdsoqYn1en8aRq25gYOJw22bKf+Xj1Wqw7+C6+CX9490JH+kxQbRMUqA
         bCtCHsHv3gXZx2kbIk8hmOznsUMFELE0C2kQU0y4fIWjPJE7NECESd4UqUcvE8ps7FiW
         J/Hz6H9HiNPCyUX97ej+v8J69blJjzH0jexSlrleI8yKs9L0t9nUwqUaup9kw1iu2Jo8
         tzG5juTMuiKN3SeTMRAH4gOstCzzNgsfP/uDfBiwa8p38bV/wa2Yn6GBlqcGaD5BVCnD
         sEhhkgvyVubuy+g1DVpnqAWXyH+LxteV6CwNaGaHqsLJl9UqrLXCwHq6nMQXFVbVhiJm
         STAg==
X-Forwarded-Encrypted: i=1; AJvYcCXXTEK9q0yZLRiBkc4mmFDXQu8GcnLJ2MKLEGn+9UVyE5IYRKkWI+V8CzDHJNDpGIxhEur/lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnZJyIfx36zK/z3ZrroCa4/3DP/wgUNWVswFemkTAYRskhrOnO
	arswyiBj+CkNr41PtyZgtU0JWy3y4veFZlSSFk0zs826YnyvM5kC0Wcg4SUPtDEUxNahFflZKdN
	wHXQx13RlT9yUiTvvHDPGDanJjPb2yTqN0TGh0w==
X-Gm-Gg: ASbGncv/YerYsa22j+0w9DGv2xu4RFF6VOEt8Ec1WFBJU39ORQo/UsXFzII/jQQXDo/
	xJ8VvBLVZ6GmEtBkUkP7rNT9ApVVI4Gix+VYvLn4=
X-Google-Smtp-Source: AGHT+IEjZmLnlSrM2c9tJMzrCQEX+VT7/9poFZl5CaNTLm4Gep2OpQ9AnG0xm/tqxK9P21RK1G0vXhdV9Pjz15wyMWA=
X-Received: by 2002:a17:90b:248b:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2f6f32e9102mr18527641a91.11.1737018843058; Thu, 16 Jan 2025
 01:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250114160630.1122885-1-robert.marko@sartura.hr> <Z4h4WePiB7G0BZj-@google.com>
In-Reply-To: <Z4h4WePiB7G0BZj-@google.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 16 Jan 2025 10:13:52 +0100
X-Gm-Features: AbW1kvb6Wbch-_SDtQBSBmayQ1PiWkForCyaBaSp3jeUes4jaRjU4HfPWWZB49o
Message-ID: <CA+HBbNHia9X+9LcR2oOJ+q9RhCaknTH+EZOu44FNo1TS9o9VhQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing header
To: Pranjal Shrivastava <praan@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, luka.perkov@sartura.hr, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:09=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Tue, Jan 14, 2025 at 05:05:56PM +0100, Robert Marko wrote:
> > str_read_write is currently undeclared and thus compilation will fail w=
ith:
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1911:25: error: implicit de=
claration of function =E2=80=98str_read_write=E2=80=99; did you mean =E2=80=
=98sb_end_write=E2=80=99? [-Wimplicit-function-declaration]
> >
> > So include the missing linux/string_choices.h header to fix compilation=
.
> >
> > Fixes: f2c77f6e41e6 ("iommu/arm-smmu-v3: Use str_read_write helper w/ l=
ogs")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501111926.qOpnlK9J-lkp=
@intel.com/
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 0e4cbb2c64d7..a0e395da8a88 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/pci-ats.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/string_choices.h>
> >  #include <kunit/visibility.h>
> >  #include <uapi/linux/iommufd.h>
>
> Hi Robert,
>
> This fix has already been merged to the arm/smmu/updates branch [1]
> which should appear in -next when Joerg next rebuilds the branch.

Hi Praan,
I looked for an existing fix but couldn't find it before sending it.
Glad that it was already fixed, please ignore this patch then.

Regards,
Robert
>
> Thanks,
> Praan
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=
=3Darm/smmu/updates
>
> >
> > --
> > 2.47.1
> >
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
