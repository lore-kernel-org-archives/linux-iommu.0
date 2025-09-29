Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C82AE8D
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167156; cv=none; b=G9sqsZAqhHbC92VNKs0e3SqDLKVktY8UQAR9jijO5WTdaDZLj9LSxZm721KPGNCNWZCzJITMvZHAQUc+AyjQiLEVPfg19IQSCq0iyp30p3JzZdPUypa9Gs5EtprwI3GrZ1vsAFqlmFHFrbsV6m02VhQLmnHUMIQ69RGg+2ucnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167156; c=relaxed/simple;
	bh=i26tWblqD2kj5kZi8jIbcdu+RsfecXi35c3q7jgCbYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prjwbSnDVtjENh+mLdlZ4wm7d+XJF/vqyvvjuMIxI2cbuNYRNAGuqixy/v4HvldbsO6SPutIsiIC4KFlFSBqHCkIlcrShR929tCAqkwhYySt02btrkaD5wxu1DPE7LH8hs3hjLz9bh3jeXgsbOuurcjfWANH5B1b3MgklufCjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5dOaeJC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5dOaeJC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso17341cf.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759167154; x=1759771954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gP+FkFVxk3JmNmEBDG5is95S5Rx3sgEp0E99zIUcCU=;
        b=B5dOaeJCrEiJWig/H4TRzT5EzQe1+xkhMCm+swk06KHcfuEXvwT3QgKA1lHFFMy+mx
         sWfAVpmickVUG+Ii6k9QmJunDmw5LqcNPoq9Ip78j087NGHcTFWy59YqpPrNA5OvyEj1
         PQnQGaQNlkJo899pL1igVZvLMHnO6t0QfIAElnDmiLud/v/V66PvFE1WSiR1F1VGrT7J
         sRHhIL/ipdM6MhIQGj4e5wbx0IoU9tIivpK+4Z4HdvUyaMhewcQNdyslu9Pi0NbZPh59
         mCNhNSjui+LZ2QIpfEPL1wkYls+GdplpeflubnBIv1JNrUGMH22fch22WQbzQVJ4IGxq
         B1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167154; x=1759771954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gP+FkFVxk3JmNmEBDG5is95S5Rx3sgEp0E99zIUcCU=;
        b=Ok/qIXwoOtzBYeFtPPavhtFAO3lnVdU7FswoQPw+vP8lfTDnKHD6KhaP7i6d+P2kNx
         pzu/sOQcG4cIr+Freasy9mS7ImXH7mZeC2g+y6Ve9hNBaAh5arlon4ujNkIIYDRZdbXY
         5uKiYAi8WkmD4mrph8QAgbk/qJD68lphUJt1C9Arm/368ZY5BdoOkd7zp/65+Td2if+p
         zrTg3Qk/F2/5BvD02bDpcm/axG3sz+WvpHSHcf/yrwY9rEERuZpC2s+c3E6EQE9L5ACr
         mv3UWfWzgZEeev0u3HMIugDmYA1q/9VTzIHskXH02lCPd30RvPmhqaPH26FxIXheTW7S
         e+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXIYwhN/7RfNYda8J6SyXfjttjh9Dea3XiPp0uOVQMrIg+OVbEKCSvVjSSC/psFRXaFzLCPzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywuw/B2et0o2T1UAMGDtBkx4acc+HA0jrr8b6ecAWonB/BUTVMG
	l+E68IkS6yDJVUP8TmGyw66iM1wGCm3evyWQ/Y7FNyf+y34yKJp4+k9wAGk1emLEqfkwLDdSbDe
	exeNrTHLfke84cCBQhirwvm8A64gIqWlnDJr5geB9
X-Gm-Gg: ASbGncvfBgNx1Ramb5ehoKGgLd62HR0Xd5TwpGyRIa5uSa6gyGlO3OofCyORnY7n+Er
	M5z83idKx33nYDOuYwNRFvyon1c78N5LMEHuoRbRcM4+5ccujrP2jJNBjxxo92BOYvvS5iLOhTt
	rVd8Gxe7zktznFlG6m5DOFXzcKXeP28eKR7K1uIZoO5sO96aHnt7HamDRFCf6C8eFE/Yg083rMB
	BQbW/oXm03JZTAqSHlh+arOALnbwkeCyL4XKLA/6ne79DBhcNBgZTk=
X-Google-Smtp-Source: AGHT+IHmyRBJY+NPLhPm23O0UZCfrf2ty1VXXgGY40TDiyTQytPHueYBQlcuVku1ppOvYkhHsF7stqBYU8Ees7G0Jj4=
X-Received: by 2002:ac8:58cf:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4e2d46ddeb5mr513761cf.13.1759167153615; Mon, 29 Sep 2025
 10:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
In-Reply-To: <20250929160034.GG2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 10:32:22 -0700
X-Gm-Features: AS18NWBCZ7IARsZC6horuFBUsx85Jwy5drEC5yooq70AqjTNeQNiRqk_f-hjdnM
Message-ID: <CAAywjhS+X5o3B60hKZiioTCqT_7cYThRTz09fHmi4WnSr3ceYA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	YiFei Zhu <zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:00=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > +                          struct iommufd_lu *iommufd_lu)
> > +{
> > +     struct iommufd_hwpt_paging *hwpt_paging;
> > +     struct iommufd_ioas *ioas =3D NULL;
> > +     struct iommufd_object *obj;
> > +     unsigned long index;
> > +     int rc;
> > +
> > +     /* Iterate each ioas. */
> > +     xa_for_each(&ictx->objects, index, obj) {
> > +             if (obj->type !=3D IOMMUFD_OBJ_IOAS)
> > +                     continue;
>
> Wrong locking
>
> > +
> > +             ioas =3D (struct iommufd_ioas *)obj;
> > +             mutex_lock(&ioas->mutex);
> > +
> > +             /*
> > +              * TODO: Iterate over each device of this iommufd and onl=
y save
> > +              * hwpt/domain if the device is persisted.
> > +              */
> > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_i=
tem) {
> > +                     if (!hwpt_paging->common.domain)
> > +                             continue;
>
> I don't think this should be automatic. The user should directly
> serialize/unserialize HWPTs by ID.
Interesting. So the user should be able to serialize/unserialize HWPTs
before the Live Update PREPARE event? But what if a device was marked
for preservation but the user never serialized the attached HWPT,
would that be considered an error during LUO PREPARE or should iommufd
serialize the remaining HWPTs here?
>
> Jason
