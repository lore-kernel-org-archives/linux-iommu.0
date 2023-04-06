Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4DA29
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 06:23:29 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id x17so15146208qtv.7
        for <iommu@lists.linux.dev>; Wed, 05 Apr 2023 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680762208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLfPdHhEmpnTRLSZFpVmB7w8tvZr0eV5OBeSk/h6cZo=;
        b=Wrjpx4/InWSH1rXxlkFn7/hLkiei4tBXGvEQhUOc68z0zM5bPba/Iolfl1UrbzSD3+
         rQ20FM0QXwDTkGezJKskXJl9TYjoNqgAc/I6hfzTHP5JhDa9TxnuO1IjaGHRmUK2w0mp
         YX9UcTaGGT4WIbLJsRNV74gR3bMviEipXEaFExpXofvJNYWl343sl3/OI3VkIng5igwu
         I7mUjnSBVeohzHVbIm7Ohxsp2pTtqBPBSyX6dMTo2Pp/RNlauwwM8bIwIuvHq3aLrb2e
         BOHcDwPlGryCN56Hd4KRj3R18Vlkb4kZ5GFZftDpuhjACviJ6z0ZV9K2gsvOhfXk07gM
         IDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLfPdHhEmpnTRLSZFpVmB7w8tvZr0eV5OBeSk/h6cZo=;
        b=MYs9toxiXCuejz+i+FE4R+ZyVNX2AxsVPg6qBseW2GuJ/WoUxJBR/VJz1Y8NEzfl2/
         4NF+/kcL2SdFXsisE2D+rNTeCh6dBaZl0uKFgD1/eSkOa6lEdLaEpiGgd99XmzgH8ftf
         Gd7mvwKEC/6b4rkyR+tckSgJd4S46x4YqaDXtdUt0drK0208zA09Tsp45Cp0euIU9Wnl
         V6toqwRB+w2ZQH80ypt2A7Ca4LzCoKG/BxD5K8DzaH9FhEkN/SGMJOEe9fLIJ+e1PGQe
         GgJePUC6htCcgvtb24kZsQjqM3yD9I0IUiiiG/Mx/XzjQLi6SnoMGQppeyDKQ4O9568w
         7Mgw==
X-Gm-Message-State: AAQBX9eqO1qnCnng9gKCdP8ui1mszxae1m+JU0p4eIf02MQ0yZRcf8yS
	y9xqjE7uAt04ZE5hhVwdMuv8H8PNtTCwctHsaL9WfA==
X-Google-Smtp-Source: AKy350ZEiRM94OBAjqWsIQYygM7ZXTU1+vy1bngs3DszBwDy0kY1b9kaeghIr9m2P9xnWV6MdlE6zotHIzpIstBdRDk=
X-Received: by 2002:a05:622a:1892:b0:3d9:556b:10dd with SMTP id
 v18-20020a05622a189200b003d9556b10ddmr2171669qtc.11.1680762208541; Wed, 05
 Apr 2023 23:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia> <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia> <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia> <ZCxOMSvR+6rYbIfy@nvidia.com> <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
In-Reply-To: <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 6 Apr 2023 14:23:17 +0800
Message-ID: <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, 
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	qianweili <qianweili@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Apr 2023 at 00:50, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 04 April 2023 17:20
> > To: Nicolin Chen <nicolinc@nvidia.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>; kevin.tian@intel.com;
> > yi.l.liu@intel.com; eric.auger@redhat.com; baolu.lu@linux.intel.com;
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > jean-philippe@linaro.org; iommu@lists.linux.dev
> > Subject: Re: Cache Invalidation Solution for Nested IOMMU
> >
> > On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> >
> > > My preference is to have a mmap'd page, so the interface can
> > > be reused later by VCMDQ too. Performance-wise, it should be
> > > good enough, since it does batching, IMHO.
> >
> > You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> > meaningful to me.
> >
> > There should be no mmap on the SW path. If you need a half step
> > between an ioctl as a batch and a full vhost-like queue scheme then
> > using iouring with pre-registered memory would be appropriate.
> >
> > I feel like this is a topic Shameerali should share some insight with
> > since the Huawei implementation will rely on this SW path.
>
> So far the tests we have done are mainly using IOCTL method without
> batching and I don't have any numbers to compare against the batched
> method yet.
>
> [+Zhangfei]
>
> Zhangfei, do you think we can run some UADK/vSVA tests with different
> Invalidation solutions discussed here and compare?

Hi, Nicolin

Do you have mmap branch for kernel and Qemu?

We are using ioctl method now.
From the testing, the TLB miss impacts performance a lot, so we use
huge page method.
After using huge page method, guest can achieve comparable performance
with host.

More details:
https://docs.qq.com/doc/DRXlpQmpTSlBZTGZZ

Thanks
