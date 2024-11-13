Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7C111A8
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506780; cv=none; b=KU2IBNx53ViSCN9K+0VgR5yTz/7iUfvQZePoX/Dr7NCJY/B9+VdPrxDKBhsoQEum9Y16bJ/i8QgSWY11Y7WEGHXiWGKlvhDp/1YnTK8PeTh3VqlNVMO3e9kupqCphdYB6OKeDNMn8adyF8dxkcs82gd0UXYE31VlPengCNxXmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506780; c=relaxed/simple;
	bh=ZKjs/sS6J+4Rn1KfgIsLXQ0nvZlO/kfOP0s+1aJUtHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxxsddv6h7nmV26B2NwoJ8K6HWZx+3o/1I4EkC+5A0FuUThuCzC1QeJG05AldaI6aU2sN2RMN5x5y2gif+syBKboTyBQA3xG/dp9LIuLMxXapkEyMU2dXJCQ7Xj+7k/J7LpxMGsz+R0MOn70apHU9w4qxSH8918HTNGTM4OV5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdCxtgYX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdCxtgYX"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso94535231fa.2
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 06:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731506777; x=1732111577; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FgbyqIYn4WEhSD+EDJWH53wmgZdzw5uXoaqskg60tQ=;
        b=WdCxtgYXnaMbitJkXqsEm0eMqMdvwd1VMgP4X6QQljVIKXWAp2jokWyneJh7bwdDgS
         ss4o7PD1QbkYWWwlgUHq8MNG6rwib3e+YrC2rHMjghFl+CV2x1hIx1YVZj7D6x5Nw3AC
         xjscaCWNAJWEiaaFjZN7Yk/cT26rkBQbdzeztjBbJ91w+ZhGAwtOd4TAZmGZ1TcsPyVv
         xek49Fwf4ajyfjzu8GmnZjYD3Ha47UyI5uhTB0HFZD9dyhPso8hYJ2BjRKoPnIy8ymv2
         c9OugXlxUVEUpllqpAJWRxsj5UeqUgMRQHQI2wlgNigoXpd7zYUU/dPIu5vIyqOObggU
         lHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506777; x=1732111577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FgbyqIYn4WEhSD+EDJWH53wmgZdzw5uXoaqskg60tQ=;
        b=p8Hs80UA98Jmr5FB+nNlEaIPFQfYcezhRRkIavb35xsYr9wTe2nPwLM8K61e6s6pgN
         pMN76I/soVAiAwM97daTFlwiV7kYXsQSd1fuizMLjDnjb0gQnztdS7zLBEVL5nbALtKW
         Ff2U9KGE1IbzgoaFJP0v8BQj0gbAvY2NnzE7eYD6n/dKl/9NIRJ3NDDzdsTstPSWP0bZ
         GVMbCdAf5GX8gmINhvFxvZFsb09+ktF9W2butqWX3XXjIgPDDf6yp4+2AnPge1rX3cHA
         vKgrQF5Kiqduw2rrWypCARoHJxt261Po2VDi2mhQ4nmaKhpL4OGEhGiPYzaaNVfq3/49
         jWnA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2LDfcmqSllFY6fC5lK/HTdJQ+SOpUvAQFyFerf9PxVGjc/bal9uF0TLx2qsjl6LkI0rp1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxclNCvonR1kNduGxizASJcm94lzM7XDu+0X2Q6NZvApysTmgiI
	+01wmHNO8BEe0JrZUzR29nlQ3PD6ThshHB8XPeCz9jUFBOAvz9Hauh0GRbvoOtpFmGF1EKzUHyC
	bmvPPSxHA3ZXk2jiMwcgW8tjjW6k=
X-Google-Smtp-Source: AGHT+IGyssDKQ92Cobn0CtFhQzBMVyaZc7uN5SwYajk5gaNkrdUasJ14YzSQg3PYYMNDKJIMwIt4QZtkBVizFZbwx74=
X-Received: by 2002:a05:651c:554:b0:2fb:4f8e:efd with SMTP id
 38308e7fff4ca-2ff2028a97amr153898021fa.32.1731506776866; Wed, 13 Nov 2024
 06:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
In-Reply-To: <20241113132031.GF35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:06:05 +0100
Message-ID: <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > >
> > > +static void write_dte_upper128(struct dev_table_entry *ptr, struct
> > > dev_table_entry *new)
> > > +{
> > > +   struct dev_table_entry old =3D {};
> > > +
> > > +   old.data128[1] =3D __READ_ONCE(ptr->data128[1]);
> >
> > The __READ_ONCE() in place of READ_ONCE() does make this a
> > lot simpler. After seeing how it is used though, I wonder if
> > this should just be an open-coded volatile pointer access
> > to avoid complicating __unqual_scalar_typeof() further.
>
> I've been skeptical we even need the READ_ONCE. This is all under a
> lock, what is READ_ONCE even protecting against? It is safe to double
> read.

Even without atomicity guarantee, __READ_ONCE() still prevents the
compiler from performing unwanted optimizations (please see the first
comment in include/asm-generic/rwonce.h) and unwanted reordering of
reads and writes when this function is inlined. This macro does cast
the read to volatile, but IMO it is much more readable to use
__READ_ONCE() than volatile qualifier.

Uros.
