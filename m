Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914125D8E3
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919592; cv=none; b=vC37wXBy6DSb7KKDji54R4HF6qiVXGlcvuib/c2off2hAP6kZW86Hii0Vi0n355EZHbdgJ0EF77381xJ3TnRvtzy8pNj76UwUWhPT9u9bpxPSMnPjCoS/DmiTY5FNri5boBHJSkGdCvWuODV7Y2zWIfRKe19pVigmxOEM8Sniz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919592; c=relaxed/simple;
	bh=hX7j39KuBtfx62cb+FfMb+wdzma6pluOWhzZ3SQuChk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeJe1sJU8hcjRXHLLWx2+NTbrVnjfmeRdQvWaRsuCHU57IBW8KrsZKqjUjB2LhT0JPMKiSWSgHzn2KalMWg6bsFf7c592ZFARDP2055Mil6WkbDNJ9ybUg25ecx4LcBcB2UjFzvIn8iOFGBD7/Ym5mktq3ww1M0RkZttxf5oVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDZTix9I; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDZTix9I"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso10916a12.1
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919589; x=1743524389; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI/QR7Z3r7OzvyQ5aczHHjWY508V7BgP+OodJUdVOuE=;
        b=jDZTix9IbxZSL1CpCH/jhnX8xYDWyJc7k48mjF2/e9ewwgaFaWtDgxwDjwq41U70RT
         XLp1sKJ64Eg5V1bq5wCrbAZB5KOgdQFdTWqxRIqogLleAST/hQEQqNn7hhLZS1kZX4cI
         YrNaIyTvN/XjzIrbtsqqQlBXqIJNgWyrkjKd+olH/Uk79D9QEB//anmhj7MCHlQAd77T
         4b3nuyAQnit/IMTxGKpPftph9DxXUQ/B2YveLcZZs4izS+8aqMsuHehfNCfMb4IQ1/Xe
         V+wsuALejvwZYEK/qGksbw5VemyDcRy9XvB8nQm9T/UbNr+hQed2KJ45htT5iGH+H7wD
         aUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919589; x=1743524389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI/QR7Z3r7OzvyQ5aczHHjWY508V7BgP+OodJUdVOuE=;
        b=cWYxTi/3rjFX245WEbAbkBNdpQd8v1mZLl7StXP0GkaVW1aQ8urdfBu/6FbS5TpQfO
         WpmHtkdXwDRs/KAw7p3vB+hppVXDIgieHmdZI7VMYBYlFNKiHjvNxCw+H117JtmsCmXp
         lcpdC6rD/kpui3QQ++c68IG8iWkcGSwGeqJJG4zj3DBOdjj2tdvOe8R6vC6GretAo6g+
         IbnWjYMmLyAlerX6rlp2EEuoRGcl0gqC1sIPJuEpDNFTwQtCDG60LKhcKzIKAqPE6gPi
         cQfod+eNgy+ssGfegI6ZUOPa7rEDW/JH9M3L72OlvaoX9BU/CeRXd2/suOqT68UufS/m
         zSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWn51wSlJfYWpveUeBIdO2JxrlOvbsWvo37pygsqe4uzbEf0tiBaY+wHBMKONW6IDtv+cYwDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyUGNN7s12pSLZ3+/t0+4Wta49gJqmcJ8pBBRLU3Tr3hO9Sqi/
	sLdVm8B73MPCp6VZkYBTJeL2tIJ5cDpsgWAY1FQEFhyQjVbl7TJ+IL9mN3BMTvFUtq/CICSx5B1
	2bkZ8un3mFNbfpNfLz2SpqdviJJyJ7tlxC0ud
X-Gm-Gg: ASbGncuvHpFyyfAOi9bM6oa9mJzNc+XuyajYfNvE15hYW83uWRDUJWaHi5QBZP58jXV
	1o55dVn9X4We8UwzpA9eF2COeMiR9l9hCn+9I+D1S/hGRD5ZLQH4p59CLwVGjEzqHtYnw1U0Uiq
	kdyKEW9mjRNkI4fsAH1aTF3AVCJj9EV9mdmDCZC5+nOOsVn1i8Nsuj8H2JYjI=
X-Google-Smtp-Source: AGHT+IGcHhSgYFSPkomlxGEUgD70Qk5m2WkID7BK0JNgBpXpK8HuUXaknwn63jcrL04nURhDbcdW5PYEl4p6a2LRL+g=
X-Received: by 2002:aa7:c841:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5ec1e429182mr351627a12.4.1742919588770; Tue, 25 Mar 2025
 09:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com> <20250319004254.2547950-2-praan@google.com>
In-Reply-To: <20250319004254.2547950-2-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 25 Mar 2025 09:19:36 -0700
X-Gm-Features: AQ5f1JrxVLI2uWKEpDtbQLzSj5Dmj8YCvIhbMXEjmWE2lwuAZraaeGHsIWDWxXo
Message-ID: <CAE2F3rBo9MM+V6_5aCgQxbK9cfxm1FNnR0etphms7fJ4t3xzOA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:43=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> @@ -4754,6 +4773,13 @@ static int arm_smmu_device_probe(struct platform_d=
evice *pdev)
>         /* Check for RMRs and install bypass STEs if any */
>         arm_smmu_rmr_install_bypass_ste(smmu);
>
> +       /* Setup interrupt handlers */
> +       ret =3D arm_smmu_setup_irqs(smmu);
> +       if (ret) {
> +               dev_err(smmu->dev, "failed to setup irqs\n");
> +               return ret;

Do you need

goto err_free_iopf;

here instead of return ret?

> +       }
> +
>         /* Reset the device */
>         ret =3D arm_smmu_device_reset(smmu);
>         if (ret)
