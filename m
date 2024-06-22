Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580F5F876
	for <iommu@lists.linux.dev>; Sat, 22 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095038; cv=none; b=JukjX57Zkqyr8XWP7iHkGubzvRw8aGNkbXUTRrP7bEBU4ffi8IYtmHNnVXrNd8V/x0njwD49nZC+82Baa3WHSwB7lq7QLj3LGno+JUHfFdyS4rdLhl8NDc6R9/L37nWYUjxdALIHiSE16IgrANdRMR2QCAZ/qhLs43RDF+VfFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095038; c=relaxed/simple;
	bh=EqV1qFCG++Nzhr7AacdvIDDpDmZjV9W7typc/BXWX20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baCR93NXdIIxm8Uh47SgVuob5YoKPa0Hckvi3uot4+I4oHmwPazTkSchHNx7e//iD3BxGHJ1pMsTkF3JSh1B+IGCMM1VKj5c/38iqLnM6fihXGOIcyRlJAvrI5j+S+XYTj4GKpbQ8nKdnBX455UtFmvigyZdlvlXVHdxtDm29VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcreINWo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcreINWo"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72477a6096so17208566b.1
        for <iommu@lists.linux.dev>; Sat, 22 Jun 2024 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719095035; x=1719699835; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9caasNtPciKtQdTeYYYLBrHobFYeJt44kO2irBcxd70=;
        b=hcreINWo6sPmAP+g7Y0CRNMBwLDeG3XwxYtIC1+Wa0UR9PBfpbkvxkSxTCJIVn7e9q
         /JpDDaEEL/a8XiqKSb7WMifKhRTfWVr7ezRg/WEbSZbJvPyus3BjekL2WKLak55d5T4p
         ckj77gpZvN90APHR0mCAf3NXyqzi15QV6hZ+Qc/XlgKxTv++9XELm8i4p1k9VAnyKIoL
         u1U9PXZz0EDpMFEEWsjKyqj+KpT55GEuvnvHfEplP24g0+2G6U7jlcUGpWbbMfGwQBfO
         61St8Rpoh8Zkmf3g0NM1oL5bJLT/tudX7kt+X932Ce09AX0/meAlQ8X1+yh0I0lhUzIC
         Fdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719095035; x=1719699835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9caasNtPciKtQdTeYYYLBrHobFYeJt44kO2irBcxd70=;
        b=Uk9NB9VRHJUY3Ld910HRqrF6ZFDuOlBcPA4b9WxDf0e8nPHlcQj6I5cljBPbH0k5K2
         GdtZVXFu8iDXhjCXsxiGBNB/94ycZnDMPRaCSznwQEqr2CsMYA0mOZNQ0qfy1nfNewqs
         LeFxd+oAEbdGXgIuGe4vWR8bX3qrjUQ/EkvU2VNq2N+axVG6rHzHE+ttHLpVe9ZsGXaD
         vrJSF1LnY8MNkVrNy5t4CoNlZxTXyx3gGp4Rvn1DoRn7N6yQqvc37gzWb/RXgvGwtR7R
         +5Rnew2gEHzDZuGgpeENrQkVep9oxn3GnWyumuZ7x4J6rRl+P63k6xCmegINDN+WstJZ
         8Y9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoiDM1+Ja5GA5T5G6JsrCL+iY0nOxhXu4mMl4RObu4OPLrCAYAzmJjnvlx2MSB6id8JEB5vF358z0th/posR5v0kgd1AI=
X-Gm-Message-State: AOJu0YywH+Bgwyfg4R1MPEi/X4D+bv0MxHAkQgIstrvAokFcJ/29OUtr
	sdXMKi8aYFQ95n9HnqmaUXcSb4Me86NkbISD17WYmQPrrjFvGVqlNMd8x9VHCEPK6584FOYK16/
	twH/tDZOXoct1fLBAoKW9ml+PeVE=
X-Google-Smtp-Source: AGHT+IEKr2CGX/X++Hn4E16EBYaSb0Q6Q7lHDkmdWRWksxAExg4pWThLuqgYIiIDj6bT7jw2IsluN1TGHXGOQYF6r1E=
X-Received: by 2002:a17:907:d409:b0:a72:4a48:7e89 with SMTP id
 a640c23a62f3a-a724a488300mr5784666b.26.1719095034815; Sat, 22 Jun 2024
 15:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1718994350.git.robin.murphy@arm.com> <0dc14431c8a495e1135fc1d9c4500d4cb96b4e39.1718994350.git.robin.murphy@arm.com>
In-Reply-To: <0dc14431c8a495e1135fc1d9c4500d4cb96b4e39.1718994350.git.robin.murphy@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 23 Jun 2024 00:23:18 +0200
Message-ID: <CAHp75VdnoOyKYbaNtr_UKn9NMSzXR1Syn9W7u0qtLgGuwYX6-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] OF: Simplify of_iommu_configure()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:47=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> We no longer have a notion of partially-initialised fwspecs existing,
> and we also no longer need to use an iommu_ops pointer to return status
> to of_dma_configure(). Clean up the remains of those, which lends itself
> to clarifying the logic around the dma_range_map allocation as well.

...

> +       if (!err && dev->bus)
> +               err =3D iommu_probe_device(dev);
>
> +       if (err && err !=3D -EPROBE_DEFER)
> +               dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);

Hmm... I'm wondering if dev_err_probe() can be used here.

>         return err;

...

> +       dev_dbg(dev, "device is%sbehind an iommu\n",
> +               !ret ? " " : " not ");

Why not a positive test?

--=20
With Best Regards,
Andy Shevchenko
