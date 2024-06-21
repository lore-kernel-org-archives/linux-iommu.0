Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B717BB1C
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003118; cv=none; b=KM2CKQcTQw9JgssQp6+XyLtv3ghawEonyZs4RGd9MO5qBjhiDBfTt+FpRMsbfAEfhGiJJBgcpqf1xTeutmsV2c/hp8jVGer9w7is5ZtYskhh4gEiyGeAI4YAC4LAV3W9fG9I8VkNKvGMli5SeObGpo7kFLQzU/grfcLGChLuZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003118; c=relaxed/simple;
	bh=Oh3fHeV4znlvxEw6zOAQuavyv3NjqYzTMJ90QD3QnrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkF5j2/LsytF+wyhCW9De8CjhFSxFOCUka65F5kg2WH3JmiDt1zfbodejtrbF/BSPcK2/Stof/Z7Kl7NGf7Nf6nEn9cD7WbpVuxSzb7GVZnCEmRqTaYVIAoWQMQkF7uq2oEwQCgZBluCRomfpwEwZ7HD3JERzU9q/gabYaTYkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5Ln5f+M; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5Ln5f+M"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-443580f290dso473741cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719003115; x=1719607915; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lArdc/1wZ6cGMV0ZmDn9MYnxqrFzIsvvBqrD/IAOOXM=;
        b=e5Ln5f+Mffe7cVJMy0g4WRJWNt8L34GlvvsalmKHO4Sbh1NSmP2duK1vFqjBE5Bmvh
         miLKgiAxSsZb2EPRmfznWw86DDbbkXQxRtOQUFHigyX5QCXf1h3hok8mGnSrhhUNnHg5
         E3/LsTrE6WWfMfYto9kL4yug2B/I7VI20/62X0uLdTjOKsEHu5bULPPz9Zp4YaSlYQQ7
         GGFtLCQ7wB8O9Nbd6U78SV5ZcW0IFqgMkG7SWdzOHzaerHogctQw9BAOYMqaxEgMKpr0
         18wBi7CdcLowAXMSF7P0H7DyfegHKy+zymCRybmF0ynqWXhslyaUPIbvL4gxj+10z57e
         IAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003115; x=1719607915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lArdc/1wZ6cGMV0ZmDn9MYnxqrFzIsvvBqrD/IAOOXM=;
        b=aW2bey1KTs6wbFZVA/jlXHYrCvQdHRIe+DOdCQE9r/wun/cA0amHC9GCr2I513Oqwi
         7sgBwRvtwNeP4enWl22z+93owNCMpX6xp/VC7QJyhOPGFPcxAqESyxHupLkUP0gN1GAN
         iuYPRZ/EayctZ3EcOeWk8CYhihtInFI89NrC15gMs33rYu2oncFhT9I2VXf7ByZ8TsEx
         C0CVuP4AbROzlC3ntTXSS+lv1F4q3DlgRZ5UEGr9OOhE8YUGEo0iww1/NUV7R2FW0ttC
         f5jLjKbWUHm7MKS1GuNyxDEiXYjfH4vpjtUM+YQDlSOA8inpvlXUXttCtjpNpqZpORke
         LWqA==
X-Forwarded-Encrypted: i=1; AJvYcCUNkYkyKapRyqCFLqtS+G+HBkqvayqCx7nHy7s+x8l/VD+ooxZK1nsEuVavCLvkcuNA71xym3/+A7O2I65xd3X+AoHQgSA=
X-Gm-Message-State: AOJu0Yw7rnPvDSnCcK3AJwWdF6NtKX3p6xqp9scL4ygrnzUCOiosuhX1
	2gfRiTSublj94wjHMygdqaWdgztrf9WqOfd3FbDdiVrDMxH/MMChRtdJ65mt/j4inz52E7q/nNk
	HeYb0CqP0QTqBYYFVAI8jnLNGmjacWqNZWQ1x
X-Google-Smtp-Source: AGHT+IH5yoYBlppb4JsqH83QVq/VXvffOxaxcg76w1huEHrI0GcDKG80KYq2O785kln/S9G/4ZJBzT5QZpUnTZkr5kA=
X-Received: by 2002:a05:622a:1a01:b0:444:92a6:188a with SMTP id
 d75a77b69052e-444ce2be63dmr496101cf.9.1719003115301; Fri, 21 Jun 2024
 13:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1718994350.git.robin.murphy@arm.com>
In-Reply-To: <cover.1718994350.git.robin.murphy@arm.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 21 Jun 2024 22:51:16 +0200
Message-ID: <CAGETcx-nBb43181Rd4HC6HQF-6=XOufA05e8Zda+LBBfhwvagw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy=
@arm.com
>
> Hi all,
>
> Here's v2 of this little cleanup, with acks and the additional cosmetic
> tweak suggested by Andy. There were some slightly non-trivial changes in
> the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
> given it a quick spin on arm64 ACPI and DT and all seems well still.

Hi Robin,

I see in this series you talk about figuring out if a device has a
driver that could match. There has been a "can_match" flag in every
device that's set if a driver that match it is present, but hasn't
probed the device yet (for whatever reason). Just pointing that out in
case that makes things a lot easier for you. As of now, we don't
handle clearing it when the driver is unregistered, but if that really
needs to be handled, that shouldn't be too difficult.

-Saravana

>
> Thanks,
> Robin.
>
>
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
>
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 36 +++++--------------
>  drivers/acpi/viot.c                   | 11 ++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
>  drivers/iommu/iommu-priv.h            |  7 ++++
>  drivers/iommu/iommu.c                 | 20 +++++------
>  drivers/iommu/mtk_iommu_v1.c          |  2 +-
>  drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
>  drivers/iommu/tegra-smmu.c            |  2 +-
>  drivers/of/device.c                   | 30 ++++++----------
>  include/acpi/acpi_bus.h               |  3 +-
>  include/linux/iommu.h                 | 15 ++------
>  12 files changed, 65 insertions(+), 133 deletions(-)
>
> --
> 2.39.2.101.g768bb238c484.dirty
>
