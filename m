Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4A165FB9
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097148; cv=none; b=NeBjLtrouMUtFimpO8/7XbHnmsvrT5jed5BE6NDwjZSBACOJpgenSd/iKAv4MtOtmt03Jgp/7wmQfcRAs23dHXMY7EZyzg8X0Y/+XE1zWV0Kt1tWwzo7qhOviQgGMaThYJDPYdP/XBmWhc2T+oB99isIQSueYA4p387sYKka5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097148; c=relaxed/simple;
	bh=1Rv56/oBFuyRJwYgTZCyvFrjtKjGcVyqzKsoClMQ1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrfFLIs9CCP00HwrhJTMyfJXd4qI4REKRIwCzRRNq/q8huawmt63ky4wUhndt7kJJbw3gSYte0C+NKw7SIMjfxRiRbysMaaqtMEvJSdLqhen6khuYeX93o/o+nIZQBGwjdYsPyMpZF5TnsWaRqdu0bk0+DT3K24zHQ86n15ZH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cYzC+81l; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cYzC+81l"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7da09662332so109354839f.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715097146; x=1715701946; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdwrYxvKykWEvU1ciSRbQbFvSgqU+2A+2xiS1iPvfJQ=;
        b=cYzC+81lvG5qAokr0LYqLY92TWHqQKQZL/QQyysqrNs0+w22TdYFRXaQLAeXGpw3D4
         /FB9S690i3pCJNpVr2iTyJHQ+S3Yhxg9vtz3O77wfe1C0kjdFjbmuXcBWacl9pqD450/
         9lJeBJlXcGVJkkcomI4dJmGWybZ5K9wB45KhGE+hnMzyOd+VY724CI58PyXWWtjljBV4
         djj8HT4QUTQdH4tgnvgIsBgdHLkzm6lskN5VU7L2TBw5i/o57IsjDBwPoDtwdjMQZv4w
         QTnPpEEGJcyEiYVZqglQlAad+LwQTW9dyyoUeNyt/ZxPUZkHHkPn3loM+Eu/4MBApbux
         SEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097146; x=1715701946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdwrYxvKykWEvU1ciSRbQbFvSgqU+2A+2xiS1iPvfJQ=;
        b=i2bkACD3jQbNvxfxc/shvWlUe4p/mEdQJ1ych6GqTfj8Bik22VnDTWUVIl8qT0B2GU
         ILCHQFFOnkvBoIicv+D9WJaVEfA3ynyvhFeKPlE2XthpwqMqLLo4MBU2BuI4GYa0/l/t
         pPXI7gNqAKAHSWngoY+jrEnPij21Sz0l6jP00/Qu4rgs4dIL7DzV/CLokkHauSww8494
         zmdr9PS+7EQAIdVGbgdXY0G2uPLiQOkeiJLnyYSUeyERcFTzQrneI0Bl8UP0HvcxTRuw
         sDdcEWvHbfiSqPlkvmmlCuTNz3bw6Bnazt3d+ywqBN9e9RClHpi9mNEtRhh4vpkbTWQI
         IvzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeXFThY8KVNmT9zHfvkv5A5GyBdf0iKB4w49JVMIsSzLyy16ZCzMQBeQUhlOo81XqHtqCJybEXlSzjwFQBK6VyZuaiTdQ=
X-Gm-Message-State: AOJu0YyVVjiMtKQ5g+p0phrVpRmwoGdRiyZxMMufddEx3HeMYVpR6au0
	gdR0sXjlQf35vQIJkauo2OprtwazFeNIzmEu/aF0R4GkwVes2LLRr0ffKWh3aueEHvxnIkQVbN7
	CkONhF8efHkwcZKMsM/UFd8xXEImQ0CI9CG0UXQ==
X-Google-Smtp-Source: AGHT+IGgeNVgdFJDVuDgv9ivECfpykkOYp4g95K8N5g+DPVmrNpWUToncN7f6H6A1ruTyO44ONnmAEe/3TdfEor5yQg=
X-Received: by 2002:a5e:db42:0:b0:7de:c47d:a740 with SMTP id
 ca18e2360f4ac-7e18f722d8amr13408539f.8.1715097146605; Tue, 07 May 2024
 08:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-4-zong.li@sifive.com>
 <20240507151516.GK901876@ziepe.ca>
In-Reply-To: <20240507151516.GK901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:52:15 +0800
Message-ID: <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:15=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> > @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_=
iommu_domain *domain,
> >       rcu_read_lock();
> >
> >       prev =3D NULL;
> > -     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > -             iommu =3D dev_to_iommu(bond->dev);
> >
> > -             /*
> > -              * IOTLB invalidation request can be safely omitted if al=
ready sent
> > -              * to the IOMMU for the same PSCID, and with domain->bond=
s list
> > -              * arranged based on the device's IOMMU, it's sufficient =
to check
> > -              * last device the invalidation was sent to.
> > -              */
> > -             if (iommu =3D=3D prev)
> > -                     continue;
> > -
> > -             riscv_iommu_cmd_inval_vma(&cmd);
> > -             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > -             if (len && len >=3D RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > -                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > -                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +     /*
> > +      * Host domain needs to flush entries in stage-2 for MSI mapping.
> > +      * However, device is bound to s1 domain instead of s2 domain.
> > +      * We need to flush mapping without looping devices of s2 domain
> > +      */
> > +     if (domain->gscid) {
> > +             riscv_iommu_cmd_inval_gvma(&cmd);
> > +             riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
>
> Is iommu null here? Where did it come from?
>
> This looks wrong too. The "bonds" list is sort of misnamed, it is
> really a list of invalidation instructions. If you need a special
> invalidation instruction for this case then you should allocate a
> memory and add it to the bond list when the attach is done.
>
> Invalidation should simply iterate over the bond list and do the
> instructions it contains, always.

I messed up this piece of code while cleaning it. I will fix it in the
next version. However, after your tips, it seems to me that we should
allocate a new bond entry in the s2 domain's list. This is because the
original bond entry becomes detached from the s2 domain and is
attached to the s1 domain when the device passes through to the guest,
if we don't create a new bond in s2 domain, then the list in s2 domain
would lose it. Let me modify the implementation here. Thanks.

>
> >  static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> > -                                  struct device *dev, u64 fsc, u64 ta)
> > +                                  struct device *dev, u64 fsc, u64 ta,=
 u64 iohgatp)
>
> I think you should make a struct to represent the dc entry.
>
> Jason
