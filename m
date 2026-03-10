Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7B2DECD3
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107124; cv=pass; b=uUaipCNIQqDoC9kly8FbjvKFypK6npNaADxhtjAesAAQn3gqycDKBDKORVuDPlXdjWszhBnQhWPEnfrkIlg2tBemu7Q5P34ySuWwyMAJp3Zw34kZcRNyovxF26evGJidwWg6fNftw+PrW+iS5oy+DK495X9Z1m1ddtyEgfVrMfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107124; c=relaxed/simple;
	bh=cKGvl7hXBpLPpOMQDVO0kfGUfkp+ed2B1FlNSTwAniU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4DneOHrGUChrqTPmpkOfg9pY58+ErE9aKsT69jNRAEwiTPbBKxw4RUYE6kgQHicuqRxYEQh0HKvPBbngC8YgKsL3aK/wODCTYgr7A3FGueHa1/vLSxSmG+lMkLQsqgkEPyZYLOHfEbWQKeBupI33wQJA8D2ZWLCFCUO+HmeUIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4aeoh3ru; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4aeoh3ru"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50906a98ffeso282011cf.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 18:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773107122; cv=none;
        d=google.com; s=arc-20240605;
        b=fXH7yzKCFS1ZjRgyfb3eyfnpKvms5OJLh/Y/HNsAmMv7vldazOqRb+1/phqNiUraWF
         ex1NPSEigBpRVyAe0hUN18/RVJoZZMA05whv2IMFEFvG7LWoVTytJwlFAqwYcEV68CQI
         IUNOe1WN1RnaScSS6w2k9Xu6Hb+U2/hQURDturnddfeVR7CiFba9AIfFE8DPMAJHclbj
         3DEuk37yS6pbyb+fvqyz9xqUxWkl/DVmqATDM/PcuPvrXnMCQgk6aHKS10Lyol4rOvHS
         ziFTHzJRsl7ePpDR7MKy/bMNHdT5Zik19T5Z0KDOGOuiOo5idmVH9lyEaIY8twRP5Xdg
         sa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEnwoda65kWT8Ifl/pQYpiblhZ85YShpDfIhHV51lr8=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=gAGPuSOn8aTx62FyipsOAemYCZlLeezA1PZctoPa1j+4BVbb/AFIrW8YqtsZBTjHG3
         5lLOmfpAxJbym+Ce2NDmIkuCiPPaGp8O9u5dJZkzZG4cLmP5LIlOZwKDJS5RQhfqf9L8
         NhqpqD5UZMSdellaCvEH+ShrYa/QZJ0LF8JS8eYfOVkPrYd38iMH32o24jJ1ACVYmo42
         uyErv8AJS4iBXFMAeeBricCB9xNngm4SvPooYQBRopRpj8u+Ffe2tiqg5xx5zcitt7Kb
         Ka7B2weCeOXk5XEsRFP6lsnruxmfka+wuSMuSFudLPdhqS8nkH+7x5YBneWfCMvjQorw
         hRbw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773107122; x=1773711922; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEnwoda65kWT8Ifl/pQYpiblhZ85YShpDfIhHV51lr8=;
        b=4aeoh3ruMNhtuGN2Pypldc5tuCvXYxQcVtG4pyIjQkC48Tz9UXdW8uGCS9fCVTY43S
         +kRtZupmpQ4OpYsU1P7K25zGPb39E9IC2TL6tLGfWEMu8e/hoPccwmjMq48toZFYJ8kU
         o93nDRx5VBIBDWQ848JBUvElC0Se/mrrcYpz4TcoGYCx1DBRxqQylMYcbFmM45OFkkZa
         Sqkxk/bFakWHqx9z/vlaUjwiibW8GxyGqw82DQSy8WT0MP6SpIYB8ylOTQQ7Eze7/Trg
         N12QEWzAD8108MxI+eOD3l1KM4IFLMk5n+Wr5bdEq3JCHKBCySUEwGyBOCXGh1SxsvO8
         hhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773107122; x=1773711922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uEnwoda65kWT8Ifl/pQYpiblhZ85YShpDfIhHV51lr8=;
        b=w2HNwj488nXOEzBb8VdipfdprrPPLdfqNzS/zGfw+H5SY+nMn8r2wJX/ZvF6Us6/YR
         CEwF0B3iI1jRr6UblDkAPlBHX/J7mNY31deKnTTtPThMyznzUh12rsFtpquSJpSu7oez
         cPc0PLorw4Tyjn/lS65gVXtye7ZRgyS9cnYNa9fsnurFAEwJcoTC/gpzZBMVifpvCGq7
         yXq3WbQVYiHSfJ8fs+FgzqjbHeUXlIMPlcyNfwtnZ7b9rSGybuxk1sf9Do+Ojy52LLqh
         4ojXVQ/e3wXZiKePpAjxC0dtljx0VGH/kCiyMJrkZmoT2SPvMCWKrZT6Ui03qdljlVSw
         VfEg==
X-Gm-Message-State: AOJu0YzPqtCvE4lql/R8YZ+tAbjGMzLvWGbsWcM12Y0KlrJdpkC2ucU+
	p4aJ7QbqtK6MeRI2S6jK+FfKOPEnk4oUp29/4IKT1Jp5m9KNHGPSYaHyTDiGh0BaJ250U+XatbU
	2vqLI95XZFnXqeX9HKmxnZG7qf8KXqkTHXZkZQGAh
X-Gm-Gg: ATEYQzy9VfzfbcyVxvGnxqHMf+UymH3NnDBLo+atrxxquDShyHOrzW3g29C/dd6g+gn
	2uonUh29NKW6Qe1emnyajnq9u2YW7xwwB39YW36wU10yaJ3qfd1WYCbKtzZs1XrHoc4QJX/tOY2
	Bxs4H5DxEgbvAAQljGv8WvQpPuyvs8wfMPPoJNT3nQy7peSVY9i0rA4mlXnjwhpYtSWv+vZOVAZ
	RbiM99zAg0rgJbpPZQsADYrFOv75fLb9DH1HgjAfQflObCaAXtC4McXayC8Wtl7dWY4yS56Ula/
	c446
X-Received: by 2002:ac8:5f82:0:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50926d58ceemr6140781cf.2.1773107121256; Mon, 09 Mar 2026
 18:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-8-praan@google.com>
In-Reply-To: <20260126151157.3418145-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 9 Mar 2026 18:45:09 -0700
X-Gm-Features: AaiRm5307hgsyLKxtMZvsD3T-CvZnsz5ylqAN913LaDoUUaiwPgys3kKd667Gwo
Message-ID: <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       u32 enables;
> +       int ret;
> +
> +       /* Try to suspend the device, wait for in-flight submissions */
> +       do {
> +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =3D=3D 1)


I understand we must follow the rule: do not elide any invalidations
while SMMU is still enabled. Otherwise, the following sequence of
events might occur:
 * The driver clears a table descriptor
 * The TLBI command is skipped
 * The driver frees the page that backed the translation table
 * The page is re-allocated for some unrelated purpose
 * SMMU performs a table walk and then descends into the page that has
been reallocated, misinterpreting its contents.

Can you disable SMMU before setting nr_cmdq_users to 0?

>
> +       /* Disable everything */
> +       arm_smmu_device_disable(smmu);
> +       dev_dbg(dev, "Suspended smmu\n");
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +       int ret;
> +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> +
> +       dev_dbg(dev, "Resuming device\n");


Try to be consistent with these messages.  Here, it says "Resuming
device" whereas above, it says "Suspended smmu". Also, try to align
new messages with existing messages in the driver. I believe most
other messages start with lowercase characters.
