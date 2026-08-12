Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF641E6AE
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532735; cv=pass; b=AaJg+9+oqk9JcJO3wfke8MyOxVlahmOk4qgFAsCdVKAHeB53cdihzGpHLFjCgANOvjsNdaqQcxL0+9+ZbVojDC0MAY9YSseiqPyjRzi5O5nQFEGBgh6WTacZqusJ3fdspC7JtkXPsJiBon8uDCKaGlIDOmSyB49ofCb/Uh0uZ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532735; c=relaxed/simple;
	bh=UZD7WI8dncrhHFTt5wBM2441bClQpRuU+h3oUUaO2Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvLAcOfgFe3NZ7z+Ybj/23JGja6BEWfJpZBm7jI75YARiMpbJEwRauhST6ejP/+8u4eGzwoxWaB3xxIYobJUW3/qmapvJywEJvDSPd199PdGR+V2tEoJa667+D+XIhYgYasq/qnfX8LbUujLHfgOvb0SWrmqlGmaMOrcWJz56Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bi9sKOVS; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi9sKOVS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso1293332a12.0
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 04:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786532732; cv=none;
        d=google.com; s=arc-20260327;
        b=AHfkuF/+ptfAQWyPEezrloOrQOXNz8bGtRjTVMaRcNpR+9W359x8n0NtlqpDAtrInQ
         Z7DnBsDnnDkcJh7hOSBeLr/nXD764Taq1AiPcuGR1ttPzkjak8p/FeAmVog7bBSpc4+/
         4Af8vVzHtVQIwUAa3SdJ37aPX27CZZbTDMRHIjDrzs6z8s7KMpCIM2CIVv8PhzSicvYY
         fUTE5Vkahxq1/E1KVklkHnCSCwT5f1/4CIvn0vtNiSDke8UFMnQJjtbs8TaS6l5HCmzd
         6BSnRYbpkDTHNH9t3F3pH6nYUh/s6nXbZ81SCrjESSGtxfFQ9cM7CLDS1NADiSIED6D+
         ROKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TAMJucX98od9lFQS19sQLl0kAJ7auuTQYd+7WMR6MJ8=;
        fh=e9PMhY43z68U7CVhnckiYJKsqTvFeDTg4gSDtR+TilU=;
        b=AC46FlTlWT5Ai49O/sswnrCbA6g1X88mtL6JGTznBRo6FnVpybVoqk3wex8tWcu3hW
         Euv3V6dDhwVNtUSaoo+tXE3Oz8NK+z00rgWwWh4LEVlltlSlH7LMPOsqGEoKmgiR31qY
         ZfeS511BkPYo8xv7/pifC3xVHEbS1GAMQmqWZLAiLYf53sQ8js+u8AYUQk4PNYBHa+GJ
         moexYb6SQdyqxvkBKMvXHr0bcEZWnEWyEMoIwidCnXeXJVl0Ue+a1fBNbP6x2SuE0fjc
         VyhpJNmd4N5biO9R2d1GklOuoZgS/IaOI2O7aap90oqBF/QaxhfnKL/HppSGfW8eUVIo
         TLYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786532732; x=1787137532; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAMJucX98od9lFQS19sQLl0kAJ7auuTQYd+7WMR6MJ8=;
        b=Bi9sKOVSdjqrBwlgk/EPnBJivFrjXNwZMEEsBZ3SVuCekXnu8Ma1oph6xcxVaRCFWV
         ToZFUIuYHiqazI353YK04r1TGvdReszNc1YdUpvEdPDYpbczzTfYVblkqs/ySBDCoOGG
         E9DEmTd6hn81uSCz9OFx5oEzLmDuOaF64MQJ3SLVX1SqHSYP48N9rXc2VbITM5s2geP3
         CKKWCLUtKqWuAR4Biim6CfPbuDBaK0R4QczGPMjDdlVHSF+1eA/mFOth/DC6T2CuoAEl
         i4E5KZJdhkXhFSiDK7IGCoQwf3VpU3JcAUiKjYo/ajLPgvQAhOsRNvKo3jw5iNxcr98z
         elZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532732; x=1787137532;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TAMJucX98od9lFQS19sQLl0kAJ7auuTQYd+7WMR6MJ8=;
        b=cPKuv+/f9KV8tCY/R+EXwtrBiZbU6eN0f8GvUMf1oAjc8zsi1lmcaNNGXDaleuP0Ka
         5/z6rg5M2S/jC+jAFjiX3aN3J54s+vFCtns2bsLl6a3IXDWYe5H1OqEo5z5NBDv6VP0V
         ktkMapz/90FuKl/W8n3R/oZlGpIPzBhNbs+cfVZBqwnCAFfAHLZ/Rs25lPXlkhAFtFM0
         Y2tJouqkNmUx4+eive2gL0MlzZNTOUyLKwaB/vFgqHVpyTNktsvYV5gps+Arhgy8Xgxf
         CwBwSh1bA0OO4s4sEh3B5xf1SVKoy3zyyPTV9NbaobhsSEPZ5XnFVv/Ijp0b8z819Fu5
         Awcg==
X-Forwarded-Encrypted: i=1; AHgh+RpAiidVha+r1PaJbHKvTqn4HFCJtKo6u1k2n5lV3HFApghkBV5HvoL1Cultqp2IsX6mit0gVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU59DfWzaY/f6eCbjZt+TB1N/t6Jigj4FuVF63rc1fbpCXipPg
	doG8JTjpHh/tN2PRwGsq5yHOpiEd0bhyb6jkG7v194xoklaJE4VP9hVT866YzQ0yzvxh0gw+trm
	dJ6M2YGX5hzMUO89dqqZ4E8ETxse59Vnyb7A1lS7wEw==
X-Gm-Gg: AR+sD12dmnnuHVgb0dugvGwidDZ3PPAEhw/pJ8BAvWF7G6lxZ6LWs7Itf0gn248Zp8J
	nYpsZoCpwwsSHQz4w4etiYBUOivbsRxFlwyD9isDk7+wEkQ+jwWQVz/oVHiO5BlJe02hZYCvHBY
	eed2yGs2Va5mTFUS4V7+YZD/dudttdz6VyMiSGMr9k7QbvSth5ks5ByoFgZ22xXrtyI9qSF+98V
	V/Z0PEI0rJO9Kf+U45bEGuqSIu05NNWPGqDXg7BvECxvpPs8aYVbRZIHNLVzhDcn8CCvgvmYhHG
	9RV0YsiB/MDQFEJQPLJBoaQHEqtkiL10K4Gp5TbItMCKg8RAalokaJDiSQMMBL690cvadN6CE4A
	6xQ==
X-Received: by 2002:a05:6402:3228:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a375e9645emr1820229a12.4.1786532731531; Wed, 12 Aug 2026
 04:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <amYIuhYenP4-qHyV@willie-the-truck> <0b7c0272-5506-4aee-82b3-76a78f2b39dc@arm.com>
 <CADrjBPqZFDvyLFpDy1YP9qrMNUCtZYtJhiaDd0iTnmB4ZYO8GQ@mail.gmail.com>
 <anmvW1LkypAGW6Sc@willie-the-truck> <77edba4a-b6b0-4b50-9328-7c177a0af283@arm.com>
 <anxN6RwREhUEuddT@willie-the-truck>
In-Reply-To: <anxN6RwREhUEuddT@willie-the-truck>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Aug 2026 12:05:19 +0100
X-Gm-Features: AUfX_mwI8H7TXg42iNqR_RkOIUIpO3gOTAkuA-Ll7XQip0ZZWi-1F1xt3OUBfdI
Message-ID: <CADrjBPqRPaZiwpj+cPznsXe79dsXa9kAObLKEOBQk0W5PovU5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add arm-smmu-v3 support for instcfg data override feature
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Mostafa Saleh <smostafa@google.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	jyescas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Will,

On Wed, 12 Aug 2026 at 11:41, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 06:16:56PM +0100, Robin Murphy wrote:
> > On 10/08/2026 12:00 pm, Will Deacon wrote:
> > > On Fri, Aug 07, 2026 at 04:25:11PM +0100, Peter Griffin wrote:
> > > > On Mon, 27 Jul 2026 at 11:53, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > >
> > > > > On 26/07/2026 2:16 pm, Will Deacon wrote:
> > > > > > On Fri, Jul 24, 2026 at 01:39:41PM +0100, Peter Griffin wrote:
> > > > > > > These two patches add support for a new "arm,instdata-override" DT property
> > > > > > > that enables the override of the instruction/data attribute of incoming
> > > > > > > traffic to Data by setting the INSTCFG override bits.
> > > > > > >
> > > > > > > It is intended to be specified when the smmu can't guarantee that these
> > > > > > > attributes are provided correctly from the client device.
> > > > > >
> > > > > > This is going to need an in-tree user and a much more detailed
> > > > > > description of what is being worked around before we consider this for
> > > > > > inclusion.
> > > >
> > > > Regarding an in-tree user, I haven't sent the Device Tree (DT) patch
> > > > yet for Laguna SoC which adds the smmu nodes and this property because
> > > > 1) I want to land the initial SoC/board DT first
> > > > 2) I want agreement on the DT property name. Currently I used
> > > > "arm,instdata-override" which is what downstream used. However, since
> > > > this is intended to work around silicon errata something like
> > > > "google,lga-instcfg-data-override" might be more appropriate?
> > > >
> > > > For Laguna SoC the first in-tree user of this is the amb_smmu smmu
> > > > instance which is used by the Synopsis dwc3 IP. The Laguna dwc3 glue
> > > > driver is already upstream at drivers/usb/dwc3/dwc3-google.c
> > > >
> > > > > >
> > > > > > In particular, if a particular client is emitting data reads as
> > > > > > instructions, then a better work around would be to avoid mapping its
> > > > > > domains using IOMMU_NOEXEC. But I can't tell what's going on from the
> > > > > > limited description provided here.
> > > > >
> > > > > Unless it's also emitting the privileged bit and thus falling foul of
> > > > > the implicit Unpriv-W -> Priv-XN rule, but then we also have the means
> > > > > to deal with devices which actually do that themselves (hello pl330...),
> > > > > so that would seemingly only leave the case of some innocent piece of
> > > > > AMBA-interfaced IP which doesn't expect to need special attributes, but
> > > > > the system integrator has gone out of their way to tie the AxPROT bits
> > > > > to some wacky value, which I would put in "erratum workaround" territory.
> > > > >
> > > >
> > > > You're correct Robin. It is an erratum workaround for the Laguna SoC
> > > > due to some custom usage of the AxPROT bits which differs from the
> > > > standard ARM SMMU handling for Privileged/Unprivileged and
> > > > Instruction/Data transaction attributes. The effect is all
> > > > transactions appear to the SMMU as "Privileged Instruction" accesses.
> > >
> > > Ah, so this sounds like what Robin was worried about.
> > >
> > > > The software workaround in this series enables the SMMU's INSTCFG
> > > > override feature to ignore the incoming value and treat all SMMU
> > > > transactions as "Data".
> > > >
> > > > One small clarification: in the cover letter I incorrectly said this
> > > > was set only for some SMMU IP instances, but that is incorrect. It is
> > > > actually set on *all* arm-smmu-v3 IP instances in the Laguna SoC.
> > > >
> > > > Does the above provide the additional detail you need Will?
> > >
> > > So it sounds like using the instcfg override on this hardware still breaks
> > > IOMMU_PRIV and IOMMU_NOEXEC:
> > >
> > >    1. If you don't pass IOMMU_PRIV, you still get privileged transactions
> >
> > However this is inherently true of VMSA stage 1 anyway - I admit I had to
> > double-check, but we don't have any user-only permissions (other than
> > perhaps execute as implied by explicit or implicit PXN). IOMMU_PRIV can only
> > _remove_ unprivileged access.
> >
> > >    2. If you don't pass IOMMU_NOEXEC, you do not get execute permission
> > >
> > > Is that correct?
> > >
> > > Perhaps it would be better to override PRIVCFG to force unprivileged,
> > > then reject IOMMU_PRIV and ignore IOMMU_NOEXEC?
> >
> > From what Daniel said, it sounds like the privileged attribute is still the
> > doing of the device itself rather than the integration issue in this case,
> > so while nobbling PRIVCFG might also achieve the end result of making
> > IOMMU_READ | IOMMU_WRITE pages mostly not fault on reads, it seems less
> > appropriate as a workaround. Particularly since IOMMU_PRIV is exposed via a
> > general DMA API attribute, while IOMMU_NOEXEC is only accessible to
> > dedicated IOMMU API/io-pgtable users.
>
> Ok, I did a bit of digging internally and it looks like the situation
> isn't quite what has been described here:

Thanks Will for taking the time to dig into this.

>
> - The issue is that AxPROT is wired so that all transactions appear as
>   instructions. This is an SMMU integration problem and happens
>   irrespective of the client device.
>
> - Transactions are _not_ forced to be privileged. That appears to be a
>   mistake earlier in the thread.

Yes, sorry about that. That was my mistake. The information I found
about this issue unfortunately contained that misinformation. Daniel
Mentz corrected this in a follow up email, though. In the next version
I'll use your and Daniel's more verbose description of the issue.

>
> - The reason privilege is interesting is because of Robin's point that
>   the architecture forces privileged XN for unpriviliged W.
>
> So, based on that, I think the instcfg override makes sense.

Ok, great thanks for confirming.

Peter
