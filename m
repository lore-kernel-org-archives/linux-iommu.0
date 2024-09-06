Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AD1B85EA
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651075; cv=none; b=Ggku30Bznc1OYL/Ewp/XyIX8fckAPMDPXjVqS8IMNH4tiiJAeR+gWpjRqnUFpD9IHecz/0N1RKS2qLi+a3jmYnKNDxrR71ZLQYjYGpgmrFg8FqvfpI0BIyNlUSpgrPIJEGaw46CWIzJ0ukkVxJlW48FoEqZNLLjAg1sjl8/WNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651075; c=relaxed/simple;
	bh=98O+mHWBCrwkb1Hu1r6S00THAU1t0ISFTYgtXw/8kuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7PGaInpfhQCnCLQ7JAWdhE4VP6sO+/FZdgFf0g5RsRHeHPoFkpaGV0ZIPG0JeVwbkxD3rCFAB+fDntP4jFvgal0wH3wYXIkz2S7lwh249Wd3S3+zLYcWU3hTscKdBD608kpEqXyIxH6MucoeARUDtr0VKUpKu7nkGB8xAJw0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFiRyesY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFiRyesY"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7528f4658so11051021fa.3
        for <iommu@lists.linux.dev>; Fri, 06 Sep 2024 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725651072; x=1726255872; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU6fY42HxjMHwn9M1PhjICuTtsea/6zud/1cFxYT38k=;
        b=HFiRyesYbU5dmzuqoEAu+qzC/q6HLpYrRYa+I/eik/o/3641ar1vXL7hUlXj3uTyxR
         Ria1AEIigm0XGfGKQuGxh5aOZT6lXicPjYGso2OmWexCZTy66pzqWJuYeuNO1v7ZCkLo
         DcB5d3RoFjF2Rw0kXqbSK3sRJY/1TjvynQEBfu+4e+GmDpGkcM1L9IOqXHa8dgciHaIO
         7PXcoG35eojona+Hfw+ZbSd+XwiyN6HByKBEQ0O46IR5spNwXcmztKs6eaDzo5PeVTXp
         7ZFzcyR7/9bVrOaMnmuT+JC/X+1UZlu+KLoHa/kKZpFK5FNDhp5FFrElMb9oLxvcp/IN
         uiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651072; x=1726255872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU6fY42HxjMHwn9M1PhjICuTtsea/6zud/1cFxYT38k=;
        b=fkdGY3BZeIaf+F7CfICSb1DoPcAnvBMYPZ42eNVBAKRJxF86+Q4CzoXSJqKvHIIuS8
         p3DR60claQ0KPGim5btItzv/BFd5WYDodydczjL76xhEe7P58NEleP5r+zto08DdIck5
         sD1gnan/pe/7L8y6MP80hC6K/5JV+C5XDIjacq+TQyiCoXwITlUX/p7mU/k7AQF5xumz
         Mqrrp/pUsaNnu/71hd0H688u8h74TS/HG+FkJskd139TfPlchrXbcrQJDZDnUXK7ztIX
         zEpIyD1D9HL4ACGqSmhxrdTF8FJbx/UQ3j+gwSrJOhtmbRTt1ugDA6Euzg6z29VzD9ki
         gZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFPBpgxCjbGi8w5oDXZ29MYcHTtCg1O0klEDRpbZagR82L6EUMWKreNLlHretLcODBCOL+Og==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWSEGbbJtkHKC5qjO70CZ/5Yz7g2YURfDcDsUAf9sAogl23QrD
	75ZKBird4zri79QYFP0OCF2YdIDCUOYT6KnciCDASJ1Oog6aFqNd05SUU44ONKzVFm/7kgUKT4k
	PO+NCIkhdhxcVF88kY637pqU9bTE=
X-Google-Smtp-Source: AGHT+IHozveXLLlaeMtebjuOMmEiUzPWhdK+f3KapkCj8+YNnkeoTW1w48uuLFjYiCSxq1qs/waknZ1yKxe2+UT7HA4=
X-Received: by 2002:a2e:bc21:0:b0:2f3:aed8:aa9b with SMTP id
 38308e7fff4ca-2f751eaef7emr22940111fa.5.1725651070968; Fri, 06 Sep 2024
 12:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-3-suravee.suthikulpanit@amd.com> <66db2589.170a0220.6f57.d691SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <66db2589.170a0220.6f57.d691SMTPIN_ADDED_BROKEN@mx.google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Sep 2024 21:31:06 +0200
Message-ID: <CAFULd4b=jUUPk3ZEzyfkeCZLOkQT9OXaM_Vx1Okw-00xwcU7bA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, robin.murphy@arm.com, 
	vasant.hegde@amd.com, jgg@nvidia.com, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:53=E2=80=AFPM Jacob Pan <jacob.pan@linux.microsoft=
.com> wrote:

> > +static void update_dte256(struct amd_iommu *iommu, struct
> > iommu_dev_data *dev_data,
> > +                       struct dev_table_entry *new)
> > +{
> > +     struct dev_table_entry *dev_table =3D get_dev_table(iommu);
> > +     struct dev_table_entry *ptr =3D &dev_table[dev_data->devid];
> > +     struct dev_table_entry old;
> > +     u128 tmp;
> > +
> > +     lockdep_assert_held(&dev_data->dte_lock);
> > +
> > +     old.data128[0] =3D ptr->data128[0];
> > +     old.data128[1] =3D ptr->data128[1];
> > +
> > +     tmp =3D cmpxchg128(&ptr->data128[1], old.data128[1], new->data128=
[1]);
> > +     if (tmp =3D=3D old.data128[1]) {
> If you are able to deal with the failure, why not use try_cmpxchg128
> for the hi 128 bit also? It is more efficient.

Indeed, just write:

if (try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1])) {

to substitute the last two lines above.

Please also note that try_cmpxchg128() updates its second argument on failu=
re.

Uros.
