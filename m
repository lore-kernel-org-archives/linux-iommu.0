Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB02B9BB
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259463; cv=none; b=FmPEdT/UIoKWV12TgeUZG+RJi4vQciiJeOLV0/07wzXTkuEetid1Y3A4XuCrHY26AcQqwhyEZaWM30jx6y8c3JhPl/wgkhK2dSPfUryjhn39Gt52DE2LPSldaKj6Jsn+glIWi/MfXkYdMIni3xBfdGEer9fQR9xp0oCaaYgNAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259463; c=relaxed/simple;
	bh=R7aTkSK8LzamfibqPPRgrapEWH4gpUvYnVlGUh0t8VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEt8c4m36klFm0jn7pzmBoftGiBWVePZ+C8jdsIUTxaznBDpi5f22a66EJkownPXmxZedsKxrmUzcNM/QHnebmnAAUSni4mAdNKcUPg7naOy8DjPcouUonMCmmhsEcxMf+MyMxEl12gyGfm/pOOMoWbnbm9ujO0pEQzt/jHSIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThMJLbJa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThMJLbJa"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334c4d6829so4826628e87.2
        for <iommu@lists.linux.dev>; Sun, 01 Sep 2024 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725259460; x=1725864260; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH7RzCro9KR4PRaykVwLoW43L7IaVQTY4cssEPtIQ48=;
        b=ThMJLbJaLvIsekQKcVYPNCZdnsbv/ckwjplcMWQ4RdWVYfG5V5fkIZbTWJjetQQT1U
         l/S7JQDrTmbwDL1ABnkHXlp85s0TXbk2iYDO7adHHdbFvMcZE9c7xLwlOzAGYom990Jh
         mce+sXrH9IH59tGPx8eP2M3Qa98XHtD75rGjH0dD7ia6ki20GkuwaLuLfBfSOthQHLq+
         IRmOVBKFXWu9fUyJg0HjN0FleuA6oCIvs4MLJQeEoxIwejakc2XHtdG6m7mrGI+fmkGt
         sEAAvut0UN2gsuKuL8hA23+/obfvCm9x9lLnqlmaRsM2Fx+DP9odm685nWfDVW0oqe98
         0zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725259460; x=1725864260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH7RzCro9KR4PRaykVwLoW43L7IaVQTY4cssEPtIQ48=;
        b=QSN/7o0QAoSIYBR6BpCfG1bjdqUlccJuy2nz7I/RL+/YMHpoRzAYg2PuVOKvLEpyNi
         WkWS6DSbxYzBUiPTGeRoFgKq/1DZu4hGWgdDu+JGlFaHZZhc0TsLVRIuixPVO9ooQeLQ
         /Q7i2ofYxt4XjhXhMzTzYmY4dRYvwSTjWE+pJlRl6VoktGpOZ2syALq0aHAtVr0U+Tw2
         LPq+ktzpywpOsNxjlzbubQzwAPrj1VkbdJpMssz+RctcqQHmZTM3OrJmA3tBCjEX0P8w
         awySUH81dxyYj6cW8nO0vjZ85LGGcLTJlyx+ZnqSXLupF+4E8iH6y/pXFd/twyFgAVj6
         u0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCfBqkFXMmwPk7F57LX9iDP5PwG2m+Yv9LXQ5iu+0CG2sfuuM6EZq5ZuiyVU56/CHJ+GsC3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS59KmjggG95JIoAFDaOD7mbHxnRhERONcHdwrmFlpyleyhLjY
	Ovs4pqGXTkcYVUf5pPV+Lq/Yqg8XRVc7xHq02TH4iLUtq4h8/mQT8yHEsIWP7y90h8qWPrX0KFt
	jQEvRzLAftSKeJ+SkA1w9unSGj9/imj4/oWVM
X-Google-Smtp-Source: AGHT+IFbawU2TahiECCxc4cujiBXi/0Uu1UqBdaFktG1PDxaMqgHctbDawA3cYVC2uTrs+onJIsV86/d0GK9AwaeNlg=
X-Received: by 2002:a05:6512:3054:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-53546bab7a7mr4884671e87.47.1725259459240; Sun, 01 Sep 2024
 23:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829120504.2976612-1-sachinparekh@google.com> <2024082941-lagging-escapade-d9d8@gregkh>
In-Reply-To: <2024082941-lagging-escapade-d9d8@gregkh>
From: Sachin Parekh <sachinparekh@google.com>
Date: Mon, 2 Sep 2024 12:14:06 +0530
Message-ID: <CAHH62BpRkkAE_c9KC-D=OXh0j7SME=FSHGN0Y8C7C6naW=NvnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, will@kernel.org, robin.murphy@arm.com, 
	lokeshvutla@google.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 29, 2024 at 12:05:04PM +0000, Sachin Parekh wrote:
> > Installing a kernel module that has an iommu node in its
> > device tree increments corresponding iommu kernel module
> > reference count during driver_register.
> > Removing the same kernel module doesn't decrement the
> > iommu reference count resulting in error while
> > removing the iommu kernel module
>
> Please wrap kernel changelog text at 72 columns like your editor asked
> you to :)

I had wrapped while creating the patch but I suppose it got messed up
somewhere. Sorry about that, I will fix it next time.

> >     $ modprobe arm-smmu-v3
> >     $ modprobe test_module
> >     $ modprobe -r test_module
> >     $ modprobe -r arm-smmu-v3
> >     modprobe: can't unload module arm_smmu_v3: Resource temporarily una=
vailable
>
> Does this happen for any in-kernel driver?
>
> Why has this not been noticed before?
>

As per Robin's explanation, IOMMU drivers are not intended to be removed so
that could be the reason why this hasn't been noticed.

> >
> > Cause:
> >     platform_driver_register
> >         ...
> >         -> platform_dma_configure
> >             ...
> >             -> iommu_probe_device (Increments reference count)
> >
> >     platform_driver_unregister
> >         ...
> >         -> platform_dma_cleanup
> >             ...
> >             -> No corresponding iommu_release_device call
> >
> > Fix:
> >     Call iommu_release_device in platform_dma_cleanup to remove the
> >     iommu from the corresponding kernel module
> >
> > Signed-off-by: Sachin Parekh <sachinparekh@google.com>
>
> What commit id does this fix?
>

I think these two commit IDs are relevant in this context:
512881eacfa72c2136b27b9934b7b27504a9efc2
07397df29e57cde5799af16e8f148ae10ed75285


> > ---
> >  drivers/base/platform.c | 3 +++
> >  drivers/iommu/iommu.c   | 3 +--
> >  include/linux/iommu.h   | 1 +
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 4c3ee6521ba5..c8125325a5e9 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *d=
ev)
> >
> >       if (!drv->driver_managed_dma)
> >               iommu_device_unuse_default_domain(dev);
> > +
> > +     if (dev_of_node(dev))
> > +             iommu_release_device(dev);
>
> Are you sure that all devices that pass this should have this call made?
> How well was this tested on different systems?
>

I am not sure hence I created this patch to understand if this is the
correct approach.

Thanks,
Sachin
