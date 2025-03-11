Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479771DE3CE
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717069; cv=none; b=ZxJ/o8zrj1gCQBPrh4niV9nSBpHd+6OSKuNe7OwWotq8TugWUi0zbwdYpHFshavOs8H9CyNOFJXz+KW4qZ3icgqH4iYAjRJsratMzqYpgwXoZ1c4Ou0yhTWb5QUm63icu4x2dViRMHLzT5ojp8XIHJgehSwLJXRMtbHrTkEkWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717069; c=relaxed/simple;
	bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFa7HnywXIWRghPL9eTs0uDC6oC8LE7yrbNoaszEss1BCF0a8xDIpekq2ReJl7nZqQAo6qXyjAeLyIwRViWg5sGahxicZkcGBUNuYZZw9nmzXQNhD8LYR1GykiOb5Twadn60/mwW9EdVs2NxJaxz3UxT0z4gsjnSxGU3RSXj8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsxMz+gq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsxMz+gq"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549644ae382so6935424e87.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717065; x=1742321865; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
        b=UsxMz+gq9yIm/dFiHyN8ugrRor7scDQziv3pJmHfLtY9wetMhxyIX6lzZiUknPJRbn
         w6emJCyf3BE4brKiB/FczgPXHxW78Hzv3t0jEmLK5ogAQaBHXRYrvtzA8Z5XRA+CU2zU
         zUoapwDJqL8RJEfFEnH/xCMpgtWUDyE/luDSoD5ORoq/AWsK6JYnqnVxarAUu5E1VpU6
         S97vgZdKYP3OruamVOA5vDvTaCZr7Rd1tJgGwDAve7YK1EKrdtAvgcVR/sQKVFKl2DVw
         47NoJYFnJhZjQ+xqPkeFW/XIGZLyRSRlt1qIpAl6ECnM06P5KoD1e+n95G6wuALYACEz
         K6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717065; x=1742321865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
        b=ObPMEzI9BO2AMlQVKfoCJQBuKlDAlPp8TbnyLmzpYwuyXDNcGcTs5T5KbkrYEGvaWs
         xn6goJ4remGzlpdCsBjiGLIEr+8KfdG6hZ1KO78LiQJHzzxsDSzyLojWBqwh1cpsoITu
         SU0zFuCwjnsKbF1yls06kgUO2i2S3maiwRVB9Y2KpU6EtKeL39a9dQ9pKi7hJPOxTvof
         AE18k6xLggfhyCUTLQNpkRysuy3pHM117fHnmJ7lpXXz19icNCCyEvvtTYYAyPQowT+1
         xfXLcPPw/gxkmQsb3v9+oVgttz7B99eIYCncVugMiDBrOoJEx0T99d6KKajyyACYHJI/
         CadQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QeugTAlFd+H4RFhgjHonDI5J+nEwqZgt8uHyCWp0I1lSoVUk0szpDrTmvEN9dxt3jMh7sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx69Ra+IjAAvW05AremdTYyP4spLqJfqmqGZ1okGBlIyOe5G92R
	4aCKz4cXQqNxBdCKmabWmME5IsLP7p7cCQuZfmkpS3DOAh2tZzQ/0bK7Z2y8mmnNsAoo3km0Hoq
	Z9h6gm9zb52/a+MfhnGKpyYe89Wc=
X-Gm-Gg: ASbGncubHM+S8BnLUwG60ovLG9zE0bExvLWizs0z4nbR73DtNUPONoOTS//g7s31Ika
	1cUdydBzwDpHEdL120cqeeX5AJJXroRvybF21flYeZzD9RO48eXenDsQlSDJqkRXg9aB0sRDoXB
	+/J5slFzHiHid5/SmHuiwq3mEseA==
X-Google-Smtp-Source: AGHT+IEYrR3iuVb9k7bTT8zIzdeCEs1XeQqQDE64pk/im8l6F+pZMmJa1FuK6qJVeCb7epxnxpHYTAZTWwaqAKTXhR4=
X-Received: by 2002:a05:6512:2386:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-54990e6764cmr5155120e87.29.1741717065084; Tue, 11 Mar 2025
 11:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
 <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
In-Reply-To: <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 11 Mar 2025 13:17:33 -0500
X-Gm-Features: AQ5f1Jotsyx4CiMaVUlC-vkoovHyzT3WerEGqfj6ILGnt1v6WPD-tu9VOLKyoNc
Message-ID: <CALHNRZ8YUjMq0NfAT10wajFJGWaxGWarn-z2C=1Obf0ewT13gQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Daniel Mentz <danielmentz@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:55=E2=80=AFPM Daniel Mentz <danielmentz@google.c=
om> wrote:
>
> On Mon, Mar 10, 2025 at 9:51=E2=80=AFAM Aaron Kling <webgeek1234@gmail.co=
m> wrote:
> > I am working with the android kernel. The more recent setup enables a
> > minimal setup of configs in a core kernel that works across all
> > supported arch's, then requires further support to all be modules. I
> > specifically am working with tegra devices. But as ARCH_QCOM is
> > enabled in the core defconfig, when I build smmuv3 as a module, I end
> > up with a dependency on qcom-scm which gets built as an additional
> > module. And it would be preferable to not require qcom modules to boot
> > a tegra device.
>
> If you want to build arm_smmu_v3.ko, you'd have
>
> # CONFIG_ARM_SMMU is not set
> CONFIG_ARM_SMMU_V3=3Dm
>
> in your .config. I don't see how this would enable ARM_SMMU_QCOM or QCOM_=
SCM.

I went and double checked my defconfig snippet and I have to
apologize. I put the wrong thing in the commit message and caused
confusion to myself and the entire discussion. This is what I've got:

# MMU
CONFIG_ARM_SMMU=3Dm
# CONFIG_ARM_SMMU_QCOM is not set

Tegra186, tegra194, and tegra234 are supported by arm-smmu, not by
arm-smmu-v3. And these are the relevant archs I'm trying to work on.

Having the extra dep doesn't break anything, so worst case I continue
to carry the extra dep or this as a downstream patch. But I had to at
least try to decouple unnecessary dep.

Sincerely,
Aaron
