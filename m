Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2135F8DD
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870517; cv=none; b=Ueagl528lvyXfSVLHq6J+41qtaNSMSpZseyDQpwj2xDp968ijUdhBnHCvVB/ooABbMc+7RugbD+E1xqtbftL+CmGdsBkjdRtUYKthf000YUc5jPLJr+acluoGiXwtH6VPeV8cznexBsWdM8nq7/qk8hMnCbJ9JfgyIN9hfXc2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870517; c=relaxed/simple;
	bh=LGLll2w1K7nYdPxKWKQGQa73I0oepbjGDV19qUBmFGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3CrV4USDZj8PY1FDj5N7TFMa1gRpxHqvi0Wg+2O9FnQqaVnM7L8xvXv0c8L7Iqjyqma3tzXDTuyuYZVCUDmNw36B+KdAuETx4VTr2wHS0+diNlDSW8vPNXMCYNMnVGIb9HsCuhKjXtjWdgUhqIwobAmckHEHabSlLMLA9904qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtUrZAsv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtUrZAsv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb8d6e98aso8911cf.0
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764870513; x=1765475313; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TXaUcbFNy6mBH2M0ThOyLe9dm89s2cza651potg7VA=;
        b=TtUrZAsvr4u7BpWq9jz775E30QteIxT+VukLHY3f/t40T4oEXNJVVBSdZXAXf+ndpc
         CPSUGFr75wVMfbASDkvir3OJ8yGoxHCYn+cEW6aT+5RgMo8hSm4R4I30eMZ3ISrjcAAf
         dHF1sUZSmSpQIqhSXbmaKY4BKRVBkqTY7w1bjiztGhmNk0gDhYbFEFk0MXdRABJbGIQi
         owGzME/R3wRoWmNQRR82TmeoGooR+RUaJ95eTGeiIA87yjaRJNzl2aEMC9UGoCrMFXle
         cEK9db3N39s7h4g+yvVimJ3zlXHenf+/o34I3OrAXR+1Ap4t3HZfnuXwihbRo5mXLPSw
         ystw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870513; x=1765475313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0TXaUcbFNy6mBH2M0ThOyLe9dm89s2cza651potg7VA=;
        b=PhYASmDYfgk5cngacW3ow56j0A3uQET8MFzeSxr9UjojMux5lMwB8g4jg9dS7I/A4t
         1iPbuJLUSfyatNmh49EcrBjfLFY8DZOczPfe1ZSkpiAFXDqfSva8QeCtmde06gCKdmT+
         pUEnkCfUMX6ROENiZu2tm0l0FAAZtvvvLPX3Igp5LJEjpee+YzTgDrj3pxF4gExXQv34
         VAleTCxbUFw796TSG91Chfd85pDAtzJv97TnxHPNxgD/aFQwkmurjABmBQUfRTE0i4+7
         DgZtpnhy94OQZ2Z+RK9ZCXgDVpYaYfQ63XWchPLonrEsxFGuNuoNVDuZ6HU6TCo730BM
         Ngww==
X-Forwarded-Encrypted: i=1; AJvYcCWRmVmJhiTKAGOcyEfSpHqEcgvVPKxvGTyouw2TNHoeMTVZN5eWdDl6zf4t1dLJt6YrAgBUMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUhz+EvsR4sdd28BcCkYbfbGAGBSu3IbZBU29ipsmnCh3VDUQT
	aazdB5C25YyUqVbS98u76HKTIq8P3XyS0ct1RS285e1XoGgCAfT44jXcBdPcUxBIJP26tdt8kfb
	RyCEhxFKQ2qpdRnj2tO/Udi6oBeV2n+IzI5UEnmZI
X-Gm-Gg: ASbGncsqWL+L9PRvQ/ZaZ2QTnZb7ZIxeBC7oyE+ldvRQxc2dAT0vi0QeuJuCrMZDLaK
	89IUAHR8PEmSWSS+H9SIpqfPlI4AE4kTyDgzS0j0UiHXcnU3mAPUOhY0FlduvWnRF7EpJIKgpN2
	mRewk5r4EbCYZubj/G76+6Tqazg5ClN/n0Ksre6FMGXh0LCiJQaNSnnw/oOEzWVOfY6i85+YBie
	lcQ7ezpjRULgRIQT/TAP43ByeNSz0+RwfhuZq5MN/9XAuPWOiPtrbhqX10Nv+KkjvsX7uh9jGKg
	REHlYvVMjDNcVOnbmllYN0P7k/g=
X-Google-Smtp-Source: AGHT+IFMCdWYU0D+qB/KJ+GxdZ7Ek093ZcQosiHc/vbb1OYsShq23cIsjWbgfUmzgk5zToR3uyYFamiimsUAqE9fXtY=
X-Received: by 2002:ac8:7fc1:0:b0:4b7:9c77:6ba5 with SMTP id
 d75a77b69052e-4f02cd66e50mr4265281cf.15.1764870513031; Thu, 04 Dec 2025
 09:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20251202230303.1017519-21-skhawaja@google.com>
 <9236c22e-f931-43a0-aafc-2179f53a0afa@linux.intel.com>
In-Reply-To: <9236c22e-f931-43a0-aafc-2179f53a0afa@linux.intel.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 4 Dec 2025 09:48:21 -0800
X-Gm-Features: AWmQ_bmAnb9FotEj3S5YQ9ZRB6_0CORiXTzMnRMIBnZZhmVDLTVmXySnOcTz4_c
Message-ID: <CAAywjhTDE8+LQHKtjU5u2Wuq898f8SSgchA2DgjSauNjo6_NUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/32] iommu: Add APIs to get preserved state of a device
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:24=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 12/3/25 07:02, Samiullah Khawaja wrote:
> > The preserved state of the device needs to be fetched at various places
> > during liveupdate. The added API can also be used to check if a device
> > is preserved or not. The API is only used during shutdown and after
> > liveupdate so no locking needed.
> >
> > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> > ---
> >   include/linux/iommu-lu.h | 67 +++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 67 insertions(+)
> >
> > diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
> > index 95375530b7be..08a659de8553 100644
> > --- a/include/linux/iommu-lu.h
> > +++ b/include/linux/iommu-lu.h
> > @@ -8,9 +8,76 @@
> >   #ifndef _LINUX_IOMMU_LU_H
> >   #define _LINUX_IOMMU_LU_H
> >
> > +#include <linux/device.h>
> > +#include <linux/iommu.h>
> >   #include <linux/liveupdate.h>
> >   #include <linux/kho/abi/iommu.h>
> >
> > +#ifdef CONFIG_LIVEUPDATE
> > +static inline void *dev_iommu_preserved_state(struct device *dev)
> > +{
> > +     struct device_ser *ser;
> > +
> > +     ser =3D dev->iommu->device_ser;
>
> This might cause "NULL pointer dereference" issue if the device is not
> iommu probed.
>
>         if (!dev->iommu)
>                 return NULL;
>         ser =3D dev->iommu->device_ser;
>

Thanks for this.

I will fix it in the next iteration.
> > +     if (ser && !ser->obj.incoming)
> > +             return ser;
> > +
> > +     return NULL;
> > +}
>
> Thanks,
> baolu
>
