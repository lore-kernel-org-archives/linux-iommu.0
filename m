Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F02F872
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424600; cv=none; b=jbO+fwOL9CbMj9874IMlnK+Vkpj5BQmGhqdUARiikkrCcJhV2xc9p/694VklGpbx49V3oh2JRb89if7JVocmdEA0QGgqSx8kT9yuBbH0ocQoNN4t2MOSgY1U1+7HIJv2RyAx4lSApXPy7F8iQCRvcvl1RNSDEBPpj3dXxCc9Kp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424600; c=relaxed/simple;
	bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMrX4pnsKdS0A7jw0BbjjG6gZzHt8oRsX4qitkTITiIm+0DTbGlj0iKR/IhbvDDLiHLj0FhE0W1Qsh3RV5dii1v3GH9XF4/3to0Kckhb8HVmLTQnhDjvvfXvFlE3sX+97lU60C27npL+aVdJPrWGP0zPuYf0GxpOgmx/78gh+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR38l2w8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR38l2w8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4de60f19a57so29141cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759424598; x=1760029398; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
        b=WR38l2w89acuaCIi8VUA9NNO0DXqfOe8f2br2xgNvB2yzy5hDM9hQSuOY0QJBAXWAz
         Dg1+WI64KUIUCBuFX3F3jnEZqS4375YFHXTTqaSf8xxHfWTYlavjTt6C6GRTDLDLFIrF
         s3EgLDMjnpOLl8qrEf+9QgoSUZEn1E4rYDDqIDJioOD/R+05aX7sgcsa+TVbFj3j4VOB
         I+wCJB0qF+/EpsXGy8kTZ0CHPao6v1KJuk7CwLUgk0oqzTt39WM+47s0uaVOZN5SHlGE
         /2HkAXqZfexihDCVfmg7x6XXYPwusjY6eqMpHY1x2Lnth9kMiPbIZNPB6kA73iwaqmKd
         bgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424598; x=1760029398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
        b=r+AZxZOkv+VBCoEmD1qNVIZNlquDU0hf1QIxt9V4CeFpT4IjN7X9IP7+dN6IEiTR80
         XUDwymorANewWVGiDfWJD2IN1Ib8orfYgCSeCqiYAFGKdX2F85NPd3WdM0hONQ0R0D3G
         qlcpKy1nG9Sy5cMeoC7TeHJJem7y+8ETV+FPHdHUpxI8bRoZhnOWpAsMVPn1s50oJUA7
         k+8JLq+5jvLYQ/QjafD2r+p/mgaZcAgUmsZH03bep9GuTYW3n6rBI1ws4ALmd9vkaNHh
         SsRFyMB07O7XCGzKyP/tsoU85xBU/0ehPQU7Pmk0v6LeAhcSrE9VCnAZs4ZZFHhGet3z
         An+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSiRRuRiE253MVkPlOc3t8Q7Z7rvf2Nb11KESH6iSkzoNs9NrvbL4m6/+UwFIqi5aCsiF+4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3qc/HKGaHIzeYnLSt0nbMFaHGune6iqAxIjVuqHZWkGMkoD0u
	5hl/W3DXlPzQQgRmftZ4xHAFidgiJRtur76WKn2plBmLslqwbTIVSB/5DBrCgArTXwpFWZlXv6C
	m7TdbdHWq0OyUgpycs9PSFdNdCoxdb2gKPLhwHdWA
X-Gm-Gg: ASbGncupG4alEQSLt1neAq10GZUX7EpoQ6m1RU5X1fnDMc9RvuLgNm1PF/rH6SfZT0v
	D62VVSNmVNgjo/XUTJlF6TfIU7thGLFhAbPQ8iGdSQTOL1KVdn6EHdFEyHapPB0DsoosLzL1byY
	CJ3mp6FGFviCbeZtOkGypI//cQExtzrI299xL1r20FtoJnVoD2ATlwnTYKoRH2r1K0aFdznYr+l
	2lU4JvgFpMOaWdWPYijyK9Cu3FiFTfwtFQ/CMqtt6DHqiP60VrLSvpudGP72XCykXfLyy3id13c
	TVzDaA==
X-Google-Smtp-Source: AGHT+IFcfdsLo3nl95pglK0oIiBcavSwsf32aKpQ2y2wm7BVnvTy3LNj+ZhguDZmbmWXKhCmFuaDsyjuhCPmvrLVttY=
X-Received: by 2002:a05:622a:1807:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4e56c83ecb2mr5629671cf.9.1759424597142; Thu, 02 Oct 2025
 10:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
In-Reply-To: <20251002134112.GD3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 10:03:05 -0700
X-Gm-Features: AS18NWAi0bfqRXKx0xb0v3E2MBmqsrGh5NbhfEqpQd8Ru5iozeldkFaXuLV7kyo
Message-ID: <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Oct 01, 2025 at 06:00:58PM -0700, Samiullah Khawaja wrote:
> > > No, finish should never do anything on the restore path, IMHO. User
> > > should directly attach the newly created HWPT when it is ready.
> >
> > Makes sense. But if the user never replaces the restored iommu_domain
> > with a new HWPT, we will have to discard the old (restored) domain on
> > finish since it doesn't have any associated HWPT. I see you already
> > hinted at this below. This needs to be handled carefully considering
> > the vfio cdev FD state also. Discussed further below.
>
> I think the simplest thing is the domain exists forever until
> userspace attaches an iommufd, takes ownership of it and frees it.
> Nothing to do with finish.

Hmm.. I think this is tricky. There needs to be a way to clean up and
discard the old state if the userspace doesn't need it. And I think
the LUO (session) FINISH event is that trigger. Basically if the LUO
session manager (VMM or LUOD) decides that the finish needs to happen
and the iommufd (or the underlying HWPTs) are not restored, it means
that LUOD has decided that the VM is not going to come up and the
preserved state and resources (domain, device, memory) need to be
freed/released. If we don't do this in "FINISH" then the system will
be in a stuck state and the VM scheduler cannot schedule another VM
using the same device and resources.
>
> While the domain is attached iommu_device_use_default_domain() will
> fail.

Yes this makes sense.
>
> > This is the part that I was concerned about since I was looking into
> > the auto_domain. Users that attach to ioas directly and use
> > auto_domain would not be able to restore the mappings before attaching
> > to the device.
>
> IMHO luo users need to be sophisticated enough to avoid auto_domain.

Agreed.
>
> > That's a good point. But it might be tricky since the ownership of the
> > device is with the vfio cdev FD. So if vfio cdev FD is never
> > restored/reclaimed the device can be FLR'd. iommufd will follow along
> > and discard the domain.
>
> Honestly, I keep wanting things to be kept as simple as possible with
> as few exception flows as necessary.
>
> If we make it so that iommu_device_claim_dma_owner() is aware of luo
> and the only way vfio can get ownership is if it is also restoring the
> luo session then that sounds perfect.
>
> Attaching a non-luo VFIO would be blocked by the kernel so we never
> get these inconsistencies.
>
> > The more interesting case might be where cdev is restored and bound to
> > iommufd but the user never recreates and hotswaps a new HWPT. In this
> > case we can discard the restored iommu_domain and replace it with the
> > blocking domain as it should have been if the device was not
> > preserved.
>
> Maybe the HWPT has to be auto-created inside the iommufd as soon as it
> is attached. The "restore" ioctl would just return back the ID of this
> already created HWPT.

Once we return the ID, do we make this HWPT mutable? Or is this
re-created HWPT just a handle to keep the domain ownership?

I think if we make it mutable, this will really complicate the design
and we will get into the sanity checking about attach/detach and
map/unmap calls on this HWPT. I think keeping the restored domain
attached to the preserved device until it is hotswapped with a new
HWPT is cleaner and simpler as you desire it to be.

I think if we consider FINISH a point where everything is supposed to
be reclaimed or discarded then this problem is solved. This should
also allow LUOD to cleanup the resources and create new VMs using the
same device and resources. I see you suggested in the other thread
with Pasha that we can make FINISH fail if things are not reclaimed, I
think that also means that the system would be stuck in this state
indefinitely. Maybe this is correct since the domain is owned by VFIO
and needs to be released by it.

>
> Again, this seems to avoid special cases as once we exit the special
> luo mode of iommu_device_claim_dma_owner() iommufd is always
> responsible for the iommu_domain.
>
> Jason
