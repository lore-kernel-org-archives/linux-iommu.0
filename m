Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D48320A
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 09:03:23 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-401d1d967beso278041cf.0
        for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688979802; x=1691571802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDvlTdEldAjp9QqfQochOyagIksh+FIdIBf/hoyipkE=;
        b=kv1cnlyouFrs36YKmDTZUDvolITqZ0ag8Sr4yCFIQfwEWIeVTn7OujqhJq38rEzpKe
         Gp0J+ihfNiYJu4AWsjyf0FhV+FEone3TORXNFsXMryLX0PbyvHmQkXkL6eQpm+zj0a9q
         kb0LkDzvlZ+CteTuvMa9MlFEswrM9N7aOSTKUWDSY65tCn6MtMWaDEFcYLUZOjtDkzf+
         rLCHjUUgNwT6B57T0quwAtH9arf2x/ONZhNP130aRi8omu+cit4ZheczI7NjjIr+lGxm
         +uyutW+84+I05qYabJAj3dqtA48bH5NQCKtXP55CbTny2926vQnfu/889NRmrbGNruwJ
         04dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979802; x=1691571802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDvlTdEldAjp9QqfQochOyagIksh+FIdIBf/hoyipkE=;
        b=IW/r/FaaF4r7GpM657GYkWaWQ2m325Rate3KVTG9vE+j15wsj+9tPe7dDgpCNnctI/
         aEHkimQHGVk26yyx8NnoGkDvXVQWV2DFJblRVUuyIZuaAyASh4cLlOIBXpzOyQF3RGIK
         lmhVnWLl5g2tNhlnsgg2Qdqld5h8VgKq/h/Ng/w8YxZLP6ViVFzXXcVwjb848b0y+3mu
         WZyNZnpII+MTPvIBO1R/vmzctALe8hGdg8kN9t8owZWdT49oraelhIVWDnHEYs/fTQx0
         RI2PWhQuwJY28Edu5/AXIY7O6GgWpsejfkYHO8wRXCMicIR3UxCvcxwyouRJYqQ32CGp
         36FQ==
X-Gm-Message-State: ABy/qLbL02Yq6hmMdRNeJyDEkEpcJ1aBr89qENWrhfQH6L2nR4JBP9Fw
	bSD2kEbSblPi6v5GtD7f1m/+OJc+MzxrPkKxDRuYrA==
X-Google-Smtp-Source: APBJJlHzLs/VWv5bWoYR0pnt4P7XDDBupgcW6h8SPpcgZwgGsH5t00P+7CEDiJBLgX4c2u4KCjlYHDjBVRqKXS8ggXk=
X-Received: by 2002:a05:622a:130b:b0:3f4:f0fd:fe7e with SMTP id
 v11-20020a05622a130b00b003f4f0fdfe7emr178967qtk.3.1688979801838; Mon, 10 Jul
 2023 02:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230707104857.348353-1-praan@google.com> <af4166f9-7b86-6c12-a8f8-ee0398743dd6@arm.com>
 <CAN6iL-Qu97hFbpOEPPtcVcWo_+=zjFy5fjJU-UnAqnY=ebFptw@mail.gmail.com>
In-Reply-To: <CAN6iL-Qu97hFbpOEPPtcVcWo_+=zjFy5fjJU-UnAqnY=ebFptw@mail.gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Mon, 10 Jul 2023 14:33:10 +0530
Message-ID: <CAN6iL-QWa=DNmfGDJHeOncZMktFyQ3LpNGiRu1Aa4cyQofdTnw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Expose an API to set identity domain
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, nikhilnd@google.com, 
	mshavit@google.com, iommu@lists.linux.dev, svarbanov@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Robin,

Agreed. It's a security v/s performance trade off. The main issue
seems to be when a PCIe endpoint maliciously spoofs its ID. However, I
guess we can avoid that by making the API platform device specific, in
that case only the device which is a platform device can use the API
to say "Hey, I know what I am doing, bypass the SMMU for me". Will
that be acceptable?

Please let us know if there are any other ways/suggestions that allow
us to install bypass for a single iommu group sitting in front of a
platform device (This device is not removable/hot-pluggable and always
sits on the system).

We're trying to achieve something similar to
https://lore.kernel.org/linux-iommu/20230710082252.9702-1-svarbanov@suse.de=
/T/#u
and trying to make it generic in the iommu layer and not specific to a
certain IOMMU hardware.

Thanks, Pranjal
>
>
> On Fri, Jul 7, 2023 at 5:24=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>>
>> On 2023-07-07 11:48, Pranjal Shrivastava wrote:
>> > The iommu driver has a function `iommu_change_dev_def_domain` that
>> > allows the user to change iommu domain of a group through a sysfs entr=
y.
>> > Currently, the following steps are required to change the iommu domain
>> > via sysfs:
>> >
>> > 1. Unbind the driver
>> > 2. echo `domain_type` > /sys/kernel/iommu_groups/<grp_id>/type
>> > 3. Re-bind the driver
>> >
>> > This change introduces a wrapper function around it which allows drive=
rs
>> > to change their iommu domain to identity during the driver probe. This
>> > faciitates bypassing the iommu for trusted IPs/devices for performance
>> > without needing to unbind and re-bind the driver from the user space.
>>
>> So a malicious endpoint now gets to bypass user policy and pwn the
>> system by simply spoofing any endpoint ID whose driver has decided on
>> the user's behalf that the user trusts it? Brilliant!
>>
>> Sure, this is probably possible to an extent already with the
>> IOMMU-driver-level quirks for integrated devices, since we're currently
>> not considering the topology of exactly *where* we find those and
>> whether it looks right or not, but c'mon, let's at least not
>> *intentionally* smash a big hole in the trust model and leave an open
>> invitation next to it.
>>
>> Thanks,
>> Robin.
>>
>> > Additionally, it helps in achieving this functionality when the sysfs =
is
>> > disabled for a system.
>> >
>> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
>> > ---
>> >   drivers/iommu/iommu.c | 21 +++++++++++++++++++++
>> >   1 file changed, 21 insertions(+)
>> >
>> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> > index f1dcfa3f1a1b..36f158621dc5 100644
>> > --- a/drivers/iommu/iommu.c
>> > +++ b/drivers/iommu/iommu.c
>> > @@ -13,6 +13,7 @@
>> >   #include <linux/bug.h>
>> >   #include <linux/types.h>
>> >   #include <linux/init.h>
>> > +#include <linux/dma-map-ops.h>
>> >   #include <linux/export.h>
>> >   #include <linux/slab.h>
>> >   #include <linux/errno.h>
>> > @@ -2908,6 +2909,10 @@ static int iommu_change_dev_def_domain(struct i=
ommu_group *group,
>> >       if (ret)
>> >               goto free_new_domain;
>> >
>> > +     /* Make sure dma_ops are appropriatley set */
>> > +     if (type =3D=3D IOMMU_DOMAIN_IDENTITY)
>> > +             set_dma_ops(dev, NULL);
>> > +
>> >       iommu_domain_free(prev_dom);
>> >
>> >       return 0;
>> > @@ -2921,6 +2926,22 @@ static int iommu_change_dev_def_domain(struct i=
ommu_group *group,
>> >       return ret;
>> >   }
>> >
>> > +/*
>> > + * Sets the default domain to identity of an iommu group
>> > + *
>> > + * @group: The group for which the default domain should be changed
>> > + * @dev: The first device in the group
>> > + *
>> > + * Returns 0 on success and error code on failure
>> > + * Note:Presently, this function shall be called only if the driver r=
equests to
>> > + * change the group's default domain type to identity during the driv=
er's probe.
>> > + */
>> > +int iommu_set_def_identity_domain(struct device *dev, struct iommu_gr=
oup *group)
>> > +{
>> > +     return iommu_change_dev_def_domain(group, dev, IOMMU_DOMAIN_IDEN=
TITY);
>> > +}
>> > +EXPORT_SYMBOL_GPL(iommu_set_def_identity_domain);
>> > +
>> >   /*
>> >    * Changing the default domain through sysfs requires the users to u=
nbind the
>> >    * drivers from the devices in the iommu group, except for a DMA -> =
DMA-FQ
