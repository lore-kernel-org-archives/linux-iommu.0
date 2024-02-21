Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49E2566
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502253; cv=none; b=A82/vh2PHmruzBX9zRGf908RV8+XB8rOOD6b3q55b4+MvPXk54QkXN9BM6CHbQz8oN+xbVhPj8BEXnvsqrwbLc0ewEjLS0YkmbMb1QCqJ4Isi5Cf74TM15vZVOA2j0lc/uKFaxjfZE//QqrYGaUppxKBZ+OOhATn5iyWLikvJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502253; c=relaxed/simple;
	bh=AB54ClpKXDvpnrBLD+hTBZ/toGRg4PgxYjTpJQsitZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDx92jmuo+kUyFqWJGpLIU3Dqc5ZBWQoIQsBbRpUND5S+NiWZzXev8wCzXgzo2z4JA9txXKuCea5sWm/KdeJlmp76DJ1sJeqZGMkYbBYNhNgcW4SvKOLYCWm1QpkjqaQIOJIK7pPHN3vG81MJwPTWqMAJajaeZ3Yck03HuPAchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwUDi0an; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwUDi0an"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d228a132acso54557421fa.0
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 23:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708502250; x=1709107050; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIlfzaJtbpobJhT/QtQhJEs40EZRm7KSI11K44WZ/H0=;
        b=ZwUDi0anbdCB1EdYzl49JjSXRQZEe3c899yym46wPK7zxvKvK+U5bmGHS92TR28YkH
         MktWb2X1Ggsb0sHTB7vw9iE/aF8hhxoaxcv1pPBPb/f0QIIhOozEUt0tEdIdBY43Md2t
         O3Zvdz/eDLF+YgYix41JY/kS8iJ+lmMEQj6Bh1ypzZNH/PpSpcE52I3O9ztmhNuxHsCl
         5UHjwMwhNBp1u86D00i0MCVHG4Ign4Mjix8H+FIQSev3SFs5PQR7tYDiE0AY3vPLA7lI
         ChJ76QvGVvEY2NDfM1M3fTRy7cshkQQnh8odu08e9IWHkqhX+sMdxPEcOek6pc9I2hy7
         oFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502250; x=1709107050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIlfzaJtbpobJhT/QtQhJEs40EZRm7KSI11K44WZ/H0=;
        b=CTnNt2beSshvm53iXVa12KNU1u4Oksooqcqb43UfH0gaKjVbD9CA0FS/wM0iwgBbUs
         ypZxfmj+r4bxP9+m8O0auzcdKXtO9byyleTT4DhV6u2dbv0FzGjnrQ8rU4Oo6Q2/RHjq
         aDFZpVYMvC9ZJATmaLr0YdjKnn2p/BxdnLXjBwmYzn3VEYXTPNv7XdcjHUs8KSrrke+F
         PGjc/N8DvPoO4TZa+I5FMqe0v3gOzaDKrTRVfJDpKcRZAqIaKG+JHphH8cEIGrrXKg8z
         XmKmLCb4oXqspAauAhEgNFHHlBO0+RmNg9WhcvAsV5dRxnKwYZEu6BzLJvsP89pvr9QX
         ICiA==
X-Forwarded-Encrypted: i=1; AJvYcCWNdsIkh0N5EVTt+NaEFytSIi1lOAW2e/qMGaZ7g7kl3EJ7SnlMOEWPoUFGU0+o14o/5+23kjeh0SfPmYUOGXBKq2RJ2I0=
X-Gm-Message-State: AOJu0YzCOIm4BnmtzN1JAoDZFspKhHD9dka6SdChabeukmizv+BsvjOl
	4mq9SnRXXjkzTsPRDZONYKHv3CrbvZTpGG4jORfQT4FW/vvnp3cjEA0ES/jskpaiBfd2n1v54Gy
	Vjb3Zg3wvgZWiQSkJVypWz1xjbwEjobZdh6xmJw==
X-Google-Smtp-Source: AGHT+IFU9WdK5/zq4/rMxq2vlJNHhDSBEpgmu0q9In/YQA3as7Vz1CeWQcIVD/rwNBkHvTjNoYwp7+qN/PhC5L8OlwI=
X-Received: by 2002:a2e:9256:0:b0:2d2:51c9:ef4e with SMTP id
 v22-20020a2e9256000000b002d251c9ef4emr1078626ljg.11.1708502250005; Tue, 20
 Feb 2024 23:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221061832.430-1-zhangfei.gao@linaro.org> <BN9PR11MB52763F2A7B45747622C9B17D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52763F2A7B45747622C9B17D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 15:57:18 +0800
Message-ID: <CABQgh9G5QLY6_EHQiRVP=02-ONdcPQA6w-ryaN9OosdvhRoxyg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:09, Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Wednesday, February 21, 2024 2:19 PM
> >
> > The accelerator dev can provide multi-queue and bind to
> > the same domain in multi-thread for better performance,
> > and domain refcount takes care of it.
> >
> > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > removes the possibility, so fix it
> >
> > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  drivers/iommu/iommu-sva.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c3fc9201d0be..a95c8f3a5407 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm
> >       /* Search for an existing domain. */
> >       list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> > next) {
> >               ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
> > >pasid);
> > -             if (!ret) {
> > +             if (!ret || ret == -EBUSY) {
> >                       domain->users++;
> >                       goto out;
>
> -EBUSY is not a right indicator for reuse.
>
> It may simply indicate that the pasid has been used for other purposes
> e.g. attached to a domain different from what the caller expects here.

Thanks Kevin.

How about this

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..20b232c7675d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
        struct device *dev = handle->dev;

        mutex_lock(&iommu_sva_lock);
-       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
        if (--domain->users == 0) {
+               iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
                list_del(&domain->next);
                iommu_domain_free(domain);
        }

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..a16ade93db25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3551,7 +3551,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
        mutex_lock(&group->mutex);
        curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
        if (curr) {
-               ret = xa_err(curr) ? : -EBUSY;
+               ret = xa_err(curr) ? : 0;
                goto out_unlock;
        }

if pasid is already attached, does not treat as error,
and domain->user++ in iommu_sva_bind_device.

Thanks
