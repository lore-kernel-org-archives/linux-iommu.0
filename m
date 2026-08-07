Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6942CAFD
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116327; cv=pass; b=MyY7maTqurxYNGlzwckE+1eoDGYwZ27Z6ccxFrpzxeLmDpNh9sr44K01z7B1LHfnVqeqZx/aUFJn4oO24M9U0uelCmrfjc8GnjLIDBr99/sEZqO7Oyn0pOb1Akg/N6bUjb0Gh6eTZw9aI2GpBsEsarRUGY37Pe95IFOalbgS+m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116327; c=relaxed/simple;
	bh=jFMOfL5Pv5EjomGzOk1gsjAPgr7PAL00YNzc4TmILmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUI3mk8gFwjMPraN+SdVBy9aN+CW4JtduzXt5eymWgy4qhCzZkPIdt0Pg7l+MLHA7hvSVsG6KtS22TF1QGfAh7S2OSyBWLNp4m4UKmjvjyz4bh3LWVf4yG9fasOD1QG7EQBT0/pnL64Rk+2ZCJwgyhI4TiFkpwultnHINjy2uFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A5sKGv4B; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5sKGv4B"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso4079771a12.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 08:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786116324; cv=none;
        d=google.com; s=arc-20260327;
        b=huQCmyddWoEFA8OxpGX07rWmpcml0LX7pMqugadsbOFaXiV+4/ZRauGlm+WKsEyUJV
         hPKqu6OzRQqn921nWvHmh0SNuXwV6l7kIMHdeBs8jcpq8opEABDhTdb15/gvjHmY1Koh
         qT/Pmcj8DHXjr48ukEVKo6y/gijtAwDTCIZlEXcaCuRH5jZgoLGSuBm2LWmaJIRsejcY
         83MBTlEtRqSgBZAxNYJ8kYdIpsVGoMRkDdcLG1bhXAQCLgS2v8BqZDW3wfy33PBYkvto
         VWC+3yQzFldXqpoDOpZDY9cXn7pz2GWQRD3LaTgSKz40WkR4fJmgXrn/ZAqr93+6KYCR
         I6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jFMOfL5Pv5EjomGzOk1gsjAPgr7PAL00YNzc4TmILmM=;
        fh=UGM0HLh6X6Kg8lG3EXsCR9DDNyecb+dqMSiOcvAgzRo=;
        b=LvLjxf/akTi6DLvx5Ctf+OfhO9rDX56h2GvBrxd6miOA1nxl6ljbJ4UIQvTR7oFGwB
         GefpSSuMaFQpMlHJ9Z1jILIj35UgOODP0WGwru13XqbRDZXNQltSnZGPumdWgBcX84qx
         ry5WheIW5PnPtlyy4dNBVJmAN6DWpZTIBDX8c52mbna4I/2nUbx3qWlP4Ssp+raXjyM0
         ZWqIXLz54FvMiQhSk9Kz/Md/5uxxzuPRJ2bUaTzmAvsZ1cOsxYks2wTqLO7GwZqgQ++X
         BPg2txPCDLEH3QUOLRLW8FDKvpTyqr02DGb/mA7/oVsLaZZciOcvGYeLPFeeFLke5JNJ
         ps3w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786116324; x=1786721124; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFMOfL5Pv5EjomGzOk1gsjAPgr7PAL00YNzc4TmILmM=;
        b=A5sKGv4BsUYpBsVq8DXlozussVD5r34GOHlD9oRINA6s63gdBZCzqVairRJxh7cnwG
         7khJz46IVWAB8ATHuDfv+m/wGL5Mk9rtvRccpPc7IoVbOfNnJUx6llbzt573ljEprlle
         J6sUoLQFymEu69DELMCN/Ut2FzfF2umyH7Seq2qVDQkoSDxjMEvkLJlM1WH48fevZWgG
         PBXt1pE5kG0NWSIs8s3doE0RZax8S7XtMZukuoPtSi4SZ4NypSTePOROpTC2sa6XtkeC
         4BDz2TuKv79FAUu+kO75FYgiLrRyM1SVx3q/Te+zkfgYAcNY32OTRXThxT9Aq5xRvKGt
         IriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116324; x=1786721124;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jFMOfL5Pv5EjomGzOk1gsjAPgr7PAL00YNzc4TmILmM=;
        b=pcxnb+eVs3OEpUXVAYmgXbkK19I/bZFmlW9pi8i2E3KBdAUYIbSVVs4f8YGOLtiaSg
         YxULc2yq5SUbngSVfl9BYHrmMMmWDd6uNqEMIDBhyeoFzHbQp7d+0xgkv7+Slb89Q5yN
         dTHabcQ34/a94g7aXv1ZnUx9K9oH3gLqyf24c9RSSxM3+bJNZ9CN7jbTJhUlec0w1C3k
         cU1IEYZflo7pKujdP43yOpgz6Rd+MG/VW47ykjUBUfkEknEqKTtesK545rGx+8JZoyP2
         YMOqTjr1F1Hk9jMnJk5fGdz7HIvqrmZy0okf37Gp4NqmnxCKGwJRrRX6I/7r2QbbmgxH
         K7yQ==
X-Forwarded-Encrypted: i=1; AHgh+RoD6NKxEGk2kEvI6JVmUsXFxeXL5KHa/qnLAVXTHZa1b1JvWHZnzhQ5Jq4Qvv3bErfSKyJ6TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YylAMQ/4VFXutCyfeyE5u0DoTDddCKBYbREdpiV9wAbaSNUCsSM
	TKbBXHyauYaJ2srp966MkESH3YE6YkYy33OFTZ1iBgUpXacbpQ1eQ/23jwp0EfJ6j8Bk8LHimfu
	qQgbLvzUI7JYdfIrRhEFRp3fiv/5k9HKbvRqxXqFJpA==
X-Gm-Gg: AR+sD10EHO3TCGCO6ToXVIyGucwX+U/U3Es9AeOA3jGDqDVp9QNEDXaLUCOg+95uHlU
	MZb07xIHrA3WeAZRL1wECuYrKjZ0emR8qkRl727PzE7PVaNK/8l6GXQ6qH8vcdkofU2auyElaQ5
	G2oZ23IoTlB2expuncz3La2jm5N8hnrLmAlaa/k7i9NHuRfNSOBYG8gjiFIyr/D6AKjOPWG5Ep+
	NuSEjf/FjzoxZG40wC07yO8oxY895Q1JIYNFNiUqio/MxoO2OJOstSpo4VXK1xE9LkeCAESBlej
	W7CxTY3vo/vCLJZufM3/qPrnRZDAV/gK8S4tP9H0tIFvI8nU0xCBkNmws6skN0UBr/lLWU8JGoX
	b3F4=
X-Received: by 2002:a05:6402:1e8e:b0:6a0:8ac4:f055 with SMTP id
 4fb4d7f45d1cf-6a14f07c8edmr11239086a12.4.1786116324014; Fri, 07 Aug 2026
 08:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck> <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
In-Reply-To: <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 7 Aug 2026 16:25:11 +0100
X-Gm-Features: AUfX_mzVQ33goKUmAZD3cnZPYWgLmpoH7Rq86A-Q6fueTvaPphB8yY86QV4o3lA
Message-ID: <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override feature
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	jyescas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Will & Robin,

Thank you both for your review feedback.

On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 26/07/2026 2:16 pm, Will Deacon wrote:
> > On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> >> These two patches add support for a new "arm,instdata-override" DT property
> >> that enables the override of the instruction/data attribute of incoming
> >> traffic to Data by setting the INSTCFG override bits.
> >>
> >> It is intended to be specified when the smmu can't guarantee that these
> >> attributes are provided correctly from the client device.
> >
> > This is going to need an in-tree user and a much more detailed
> > description of what is being worked around before we consider this for
> > inclusion.

Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
yet for Laguna SoC which adds the smmu nodes and this property because
1) I want to land the initial SoC/board DT first
2) I want agreement on the DT property name. Currently I used
"arm,instdata-override" which is what downstream used. However, since
this is intended to work around silicon errata something like
"google,lga-instcfg-data-override" might be more appropriate?

For Laguna SoC the first in-tree user of this is the amb_smmu smmu
instance which is used by the Synopsis dwc3 IP. The Laguna dwc3 glue
driver is already upstream at drivers/usb/dwc3/dwc3-google.c

> >
> > In particular, if a particular client is emitting data reads as
> > instructions, then a better work around would be to avoid mapping its
> > domains using IOMMU_NOEXEC. But I can't tell what's going on from the
> > limited description provided here.
>
> Unless it's also emitting the privileged bit and thus falling foul of
> the implicit Unpriv-W -> Priv-XN rule, but then we also have the means
> to deal with devices which actually do that themselves (hello pl330...),
> so that would seemingly only leave the case of some innocent piece of
> AMBA-interfaced IP which doesn't expect to need special attributes, but
> the system integrator has gone out of their way to tie the AxPROT bits
> to some wacky value, which I would put in "erratum workaround" territory.
>

You're correct Robin. It is an erratum workaround for the Laguna SoC
due to some custom usage of the AxPROT bits which differs from the
standard ARM SMMU handling for Privileged/Unprivileged and
Instruction/Data transaction attributes. The effect is all
transactions appear to the SMMU as "Privileged Instruction" accesses.
The software workaround in this series enables the SMMU's INSTCFG
override feature to ignore the incoming value and treat all SMMU
transactions as "Data".

One small clarification: in the cover letter I incorrectly said this
was set only for some SMMU IP instances, but that is incorrect. It is
actually set on *all* arm-smmu-v3 IP instances in the Laguna SoC.

Does the above provide the additional detail you need Will?

Thanks,

Peter
