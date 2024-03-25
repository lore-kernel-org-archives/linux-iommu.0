Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C9C14901E
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365754; cv=none; b=cK8Z6WXjfa6G3YmwJJY31LHsK7mRQCqrBXRpeZYDBJe1aWp8U9JuITfgDEOwS6aC8HfrW1Bd/WSWayEp2YDU3yDj9MkmumG9ERhcP7Oju4eEigEHOW6ynr1UoPbC0B69ciJfAUMtuMr3CttL21RMsnY25O9dJaCrtpPO2g5WdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365754; c=relaxed/simple;
	bh=zuuRLIdNBIlNLEGYbk6ULd4H1b21ct6ABbZqwRJdAhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flofeAFE6ZlSN9m7BZsXKRoZigYr1eYDWg99srz5miG3t7HcXPN0wpXB4juP5f5OoL6byE3QK7cvuLeuko4VIC+LHTC0MkzXmbPTF/v3kIJ9rbAyuhL6wrO/yqAVZJO19lkH+WtzAORUXd79SDq4qa+ByAvn1KRjinL4+M0SGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhWm5M53; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhWm5M53"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430d3fcc511so375721cf.1
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711365750; x=1711970550; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fswRbpq1Azoo81vFYH7v6iwrGnvkxgu1pBA+tSxE7iw=;
        b=DhWm5M534ypQeoJPftoof77Ob8mCqEhLl1mIkZNDhG/n/pXr8uasluYxaIXkyZKUFk
         oZhF9pGm3ORTCg9TVB1zWrvttN2NBQZ6YZbihuSdWiyXaMnfL5G4SlxCKZC6HYMShK9u
         m4Wu325F7ixlDqwklsGP/IWN001Vqi8WsI8Of9UT+MA0Nb4Cb6cprPewdtagHEjm6N/E
         r/HEz9u8UkQTSaBVkYzNLcySeXQlBNonGvZmRyauufJJ5AxGqwuqmo2gwLBJdSQC6+qX
         hIEDFtysj2o/QTUJTTNsHysn6q67WPtS6/zNg7kc20B7dUT7E3nZWxKWq0RF0iKPTwyV
         oaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365750; x=1711970550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fswRbpq1Azoo81vFYH7v6iwrGnvkxgu1pBA+tSxE7iw=;
        b=wd2JkeRvibbbzzkPoP7qCbXcPtKAWQ/UqssfiW2bkNIp7ejZ8bVEkFKw9+wP1ukBOB
         S/1XtTlwVl8iTF9XHdT1+dHW0AtLFzGM+zZaetqbvGS3XuLzHAZPi0Z0lJr2Hv/j6KxQ
         PgeqMA6OtJ5kUVFdsPxEgccIn8tsPJjH3HejcMTroGM6L3t2MwgGdIbh/uu73oqdHDz/
         h+Wg8bEP0tv+rqFbmu0vmEcXy0GWI++/YgAnKBicQWrPKSiLEfcl5JrWOV04rN0bEJHp
         +3Im+fwtd2bXRaaSIAr/2ReZ2IZafRctFKUJiXX37JTE97RH04v2qm7hTw/wNuTnHND1
         ivrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUixL/tXcIRvzn84kOH8j67Z/TWMce8bnePvJkuR94J6TQvkD7DKxy2rqg8hQ8OcWAI3CveZDlaNsPRuGysIMtKW5c9j9Y=
X-Gm-Message-State: AOJu0YwF9/ATlRZM07yxLPZfa87G7CUcKGn55tPScwMP5pjM2WBq3zRA
	f+ZP2wLomwPkcI29hS1se1gDOeM6rwuHTsvDsCQUmUhllWL5JbYrVTYqoU3RYzG7Sdv233ZTlbS
	ZQ/cAiI4zQUadJ3skwV7h7AWc74oK/zNIgpXd
X-Google-Smtp-Source: AGHT+IHQGX28cPSFl6xAZACYCo+ZudGeONxBVCv28uRuNCF5PjvfM9cmC/ZMEZ1voEurO+bHophE+1qzdb6vsaWpxGo=
X-Received: by 2002:a05:622a:510c:b0:431:542a:38c with SMTP id
 ev12-20020a05622a510c00b00431542a038cmr237900qtb.28.1711365750272; Mon, 25
 Mar 2024 04:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
 <ZgFQVy-gIJJKL2IG@google.com> <9819d9f48ad64fb8a704a0a779010581@huawei.com>
In-Reply-To: <9819d9f48ad64fb8a704a0a779010581@huawei.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 25 Mar 2024 11:22:19 +0000
Message-ID: <CAFgf54qSbNMQ1XTnV-YSZV=gqwN+JJy0S5ziv=fUfinOXGZ9jw@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Update SMMUv3 to the modern iommu API (part 2/3)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	Joerg Roedel <joro@8bytes.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shameer,

On Mon, Mar 25, 2024 at 10:44=E2=80=AFAM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Mostafa Saleh <smostafa@google.com>
> > Sent: Monday, March 25, 2024 10:22 AM
> > To: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: iommu@lists.linux.dev; Joerg Roedel <joro@8bytes.org>; linux-arm-
> > kernel@lists.infradead.org; Robin Murphy <robin.murphy@arm.com>; Will
> > Deacon <will@kernel.org>; Eric Auger <eric.auger@redhat.com>; Jean-
> > Philippe Brucker <jean-philippe@linaro.org>; Moritz Fischer
> > <mdf@kernel.org>; Michael Shavit <mshavit@google.com>; Nicolin Chen
> > <nicolinc@nvidia.com>; patches@lists.linux.dev; Shameerali Kolothum Tho=
di
> > <shameerali.kolothum.thodi@huawei.com>
> > Subject: Re: [PATCH v5 00/27] Update SMMUv3 to the modern iommu API
> > (part 2/3)
> >
> > Hi Jason,
> >
> > On Mon, Mar 04, 2024 at 07:43:48PM -0400, Jason Gunthorpe wrote:
> > > Continuing the work of part 1 this focuses on the CD, PASID and SVA
> > > components:
> > >
> > >  - attach_dev failure does not change the HW configuration.
> > >
> > >  - Full PASID API support including:
> > >     - S1/SVA domains attached to PASIDs
> > >     - IDENTITY/BLOCKED/S1 attached to RID
> > >     - Change of the RID domain while PASIDs are attached
> > >
> > >  - Streamlined SVA support using the core infrastructure
> > >
> > >  - Hitless, whenever possible, change between two domains
> > >
> > > Making the CD programming work like the new STE programming allows
> > > untangling some of the confusing SVA flows. From there the focus is o=
n
> > > building out the core infrastructure for dealing with PASID and CD
> > > entries, then keeping track of unique SSID's for ATS invalidation.
> > >
> > > The ATS ordering is generalized so that the PASID flow can use it and=
 put
> > > into a form where it is fully hitless, whenever possible. Care is tak=
en to
> > > ensure that ATC flushes are present after any change in translation.
> > >
> > > Finally we simply kill the entire outdated SVA mmu_notifier
> > implementation
> > > in one shot and switch it over to the newly created generic PASID & C=
D
> > > code. This avoids the messy and confusing approach of trying to
> > > incrementally untangle this in place. The new code is small and simpl=
e
> > > enough this is much better than trying to figure out smaller steps.
> > >
> > > Once SVA is resting on the right CD code it is straightforward to mak=
e the
> > > PASID interface functionally complete.
> > >
> > > It achieves the same goals as the several series from Michael and the=
 S1DSS
> > > series from Nicolin that were trying to improve portions of the API.
> > >
> > > This is on github:
> > > https://github.com/jgunthorpe/linux/commits/smmuv3_newapi
> >
> > Testing on qemu[1], with the same VMM Shameer tested with[2]:
> > qemu/build/qemu-system-aarch64 -M virt -machine virt,gic-
> > version=3D3,iommu=3Dnested-smmuv3,iommufd=3Diommufd0 \
> > -cpu cortex-a53,pmu=3Doff -smp 1 -m 2048 \
> > -kernel Image \
> > -drive file=3Drootfs.ext4,if=3Dvirtio,format=3Draw  \
> > -object rng-random,filename=3D/dev/urandom,id=3Drng0 -device virtio-rng=
-
> > pci,rng=3Drng0 -nographic  \
> > -append 'console=3DttyAMA0 rootwait root=3D/dev/vda' \
> > -device virtio-scsi-pci,id=3Dscsi0  \
> > -device ioh3420,id=3Dpcie.1,chassis=3D1 \
> > -object iommufd,id=3Diommufd0 \
> > -device vfio-pci,host=3D0000:00:03.0,iommufd=3Diommufd0
> >
> > I see the following panic:
>
> I think that is probably because you are testing with "nested-smmuv3". Th=
is
> series not yet fully enable that. For that, I think you are missing few p=
atches
> from Nicolin's iommufd branch,
> https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-03112024/

I see, thanks for clarifying. I think we shouldn't still crash the
kernel, but that's a problem for part 3.

Thanks,
Mostafa
