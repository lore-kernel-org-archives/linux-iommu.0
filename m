Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8AA187332
	for <iommu@lists.linux.dev>; Sun,  4 May 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746390590; cv=none; b=Wo0tgC1FaGoobjRc2TXxaj/6bAZaTONXyrvo6uBNRure6LM7bjNKJTKqhKUNoSPzGonN9DbUISppnnr2z1yVyweGmLyFwW9Yi8aRRaUhPVKqv3mlpK7vglafPJLoMsYEYpZLtLH760HEiEe/vh0cuVZvhPIkPaB6S0ZzLyB/hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746390590; c=relaxed/simple;
	bh=VF6rBhm5z9VC9w26nQc//QMOoN7euRCTK7vUVz1DLuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb6p1VNXLbaSn8qDsoUFK+VQaezj29f6fH6W8Iddxig5Jj11gjodsYv0xu3r9MtSxQ3H9uHXPognvM0hW3z5ehEqpn7kKkafx+1pLtEW2NTh7HeBL22KIBRAhE1lWxJH4TbLWD4seHKzkLaSjd7Ey4/nbJvAqvV+mFpRAQTAXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFjpluQp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFjpluQp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so7386a12.0
        for <iommu@lists.linux.dev>; Sun, 04 May 2025 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746390587; x=1746995387; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhv61duqiyVxNobxcTH4eWj86ORkp4PnwStcVqY+EG0=;
        b=sFjpluQpnqwmJkXUKjNZK9kBWv6UZJGt/KNlIxtxzNJaxoINr8aEc7okq1z51eyisg
         syjKtRD0QadaAvj2xfv8C8+ocdu/tCKJDMv/iZ+ZLMhRFypCAc7HpIAuQjfLEh+K3IHp
         K1TTni62XUQ+BEUiPQhifXrbgpj6uFLbHR+3JgHBIZFMuZ/Wy/jjU6bN8d4nSjhvyj8Q
         Q8d2cChaBZUZP5hJ0eKQPYDc+JZbcmCPrmXVg80ERZvSk5VFnZ2X0fBsfegsW8B/rur2
         RuPBvtX7xmJdF0O5zk1pyw7H7/yLr3Rm3aOaPl4lxL1E3PH264peM/gwzWlGvs2RXdfD
         dnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746390587; x=1746995387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhv61duqiyVxNobxcTH4eWj86ORkp4PnwStcVqY+EG0=;
        b=MoXUA+E2UKFy0o6NbgZ9+jRsxVgFACivUznOHZiKO/9d1DQzeGB/++cdU+AOdUpTZb
         /n/h4Ggzj1SVdRS7yG/OdiEM6Mm45avWFlxnsqAyDxVXwkZ0ebj0P8VireAw8uKP0qK3
         8O6UC+ntAoN8kvsYL2XJrQ4NE732bghaAuQsmz88GuWMeNsRic1enDe1O2At4Ez+tWcx
         2Kt7+g45G6HJQ84KNz37pAU1S3LF3ChvXA/LbCptV5xRw/2On2mSvoeBP4uErLVOBNv4
         aVuxc65pFc+em2N2SFWXrSnLE35nTnVi9eV88uNR7wK3UuyW46ZYttR60j/UGcFj+ezB
         ikXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxqC+PoF3AVb7FYsFOCBWt7EJlt2M08s2xphrxiTet9Jy0OUaTuULbGmbwsQ8CpYNqxi2qrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvT/QtJrjovxp/mv5a1gnwg7FmQhI5TXdPTTuKP1BV1xuQpzs2
	ra7BQbR0aTBlKZJNt9Aq5VaYfXlaGVZk/oypIdWFb33Hmr6cCrUq8kYxAkuP2lh95WiRgB8IWTs
	taTwGrzf4d64K8v/IpHxCqWedFvJOuYoxAlw9
X-Gm-Gg: ASbGncvljL3S+OnHFaqZn8rYwyrXti/1AevdnT5HvNzlCLzRXnUnHAq0atDz5ldsdxu
	uGC+THyDyf0FhG7Q4VmBUMK4HXmoYTRGWW0MilufdZ+wqU107JwjgulF43LKPrDXbeWOXqWpjGy
	g7WgduJmBme1sDmvdUceM=
X-Google-Smtp-Source: AGHT+IHtuXgcwkBLwR2+bNSAfujhGg4o+NWJc0BiGZM6cQk+OFzwGgPfmg39rOlQpoV9brvYlP/NYwOjKaumaJSAP8A=
X-Received: by 2002:aa7:dcc6:0:b0:5f8:3633:9dae with SMTP id
 4fb4d7f45d1cf-5faaa1fec39mr91169a12.5.1746390587105; Sun, 04 May 2025
 13:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com> <20250418233409.3926715-6-praan@google.com>
In-Reply-To: <20250418233409.3926715-6-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 4 May 2025 13:29:36 -0700
X-Gm-Features: ATxdqUEgESFbPahQ_7VQDNhWKimQ1BHs8cxa2u8uWIGZDSgSc2nlrX8jLxHnqSk
Message-ID: <CAE2F3rCs3-Ppoa+y-X9p2HBP50gow+bP-_v+LX0SYc40UmgVLg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 4:35=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +static int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> +{
> +       if (pm_runtime_enabled(smmu->dev))
> +               return pm_runtime_get_if_in_use(smmu->dev);

You named this function arm_smmu_rpm_get_if_active but then call into
pm_runtime_get_if_in_use (There's also a pm_runtime_get_if_active).
Shouldn't this function be called arm_smmu_rpm_get_if_in_use?

> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -506,6 +506,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsi=
gned int ssid)
>  #define MSI_IOVA_BASE                  0x8000000
>  #define MSI_IOVA_LENGTH                        0x100000
>
> +#define RPM_AUTOSUSPEND_DELAY_MS       15

Consider moving this to  "iommu/arm-smmu-v3: Enable pm_runtime and
setup devlinks" where it's actually used for the first time.
