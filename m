Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C414AD2B
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472676; cv=none; b=HUPaqpqpD3Rnmiid4DxX3z6ItM+l+/+tqC1E8SxiGxKI8bHcaKPmc+NvNUs70eZRPnJMBgoqgryj/5xGwNYhkEIZA2pCXJNnqY8vo+dkWYZqL6dOsOTRuDK4fnX6MbidvRHVNLixIdMIns7rotMPADN2WXV9VbldUIOeIbevfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472676; c=relaxed/simple;
	bh=9x+M+9APIGN3rhHl/tijNJMgK0ojb20CQmY/C3fB0G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk/slsZN5Bkr+8i8WgVpaX+qnjMlwJD1lxzd4a8yNX6JhuDC3R/8HU/l6xUh9qcwtyFF8KPC6oVGgSK7IbpgZGsqiCoeYdG9SSN5lU9hGVfpzPcVWU5cCEfpRMCizW+lXo7ox9TJ1FQ38cRPA+FaA38SYPd5JJqFu3YFQt5pz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrGE0ZmI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrGE0ZmI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e8a8ff4083so19308771fa.1
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716472673; x=1717077473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMOUYCMFihJdUjCJHbJ9rJQeq23/qVjfUy+xhBp831s=;
        b=SrGE0ZmI/d2kWUJZzcep5q6L8VwSj5rbOQUogdvDIvidrB2D/iEjxKPb5r0YsE8h8d
         /EzAtSwiEFWn1f7fZvA26JtngzGhihV4MfqvBx3o66UklR6Rb5956Z0mMv14XtBbj/k5
         pXTjVh35zwYnVQXetWT4SNbsUpifClWFz9nbVlHtSoorhN6kb5VNZDKMytByA8S730OI
         9elecX6N2YLYDgFmGAsKprDWNvL9E39hJ8pRmPYufm2DNYzKZUH1YoAKmrwtNlyMFvue
         F5aImASKRWFSD231uBi692l9sIkoOAYtWqMxJJ6mpuZgzixs2CIRy5GZQ8sQOp7822z2
         xyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716472673; x=1717077473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMOUYCMFihJdUjCJHbJ9rJQeq23/qVjfUy+xhBp831s=;
        b=fJF6w1EmLVAQyGlFSYNF16Zd97WIvxUxk4JzOUMIXb3JvOMnnNru7KOue0ulP/VQJc
         eUjYxMM5l89PvUGgVeiecoObRb9pjhsNa9MXUn2BBtOhdY+6etrwSvuBNBi/vcWp3vBe
         vcmdnBD1odvNpPw6gJwo7XJQRHU2WtCAuM7xNn3tMfHbR6VCL5eaKizPA4kwOmtmDsHr
         GB0+e11ILkdVl98qybzlacmVY83iPUSNiSJrvFiAsRUX8OgWk56wPTYpjvpuqXtQJaKz
         8LuCnFWH92zr+L+8ilkJxLyJ6yvWl/OKRRRgDFYDyZn5OEze9nnHS4dtHs4bq0cRdVND
         f1sw==
X-Gm-Message-State: AOJu0YxQKWKor557GK53UCyaVbpqbxbJmOpDldRMDGN1g9u9/MWXIpgP
	2cYH61dSHMPtuXVhBfFMh9EFwo1wmkAGbEP+xPccXd4RswCfdiqCoE8p/x9Z0fElCfKOHx3osGV
	fpMto3tvNTJYhPydoph14EpcF6wk=
X-Google-Smtp-Source: AGHT+IG1AWvf7EzaCj7fIX4aVnfazLDZAwIEGt9b/u9Mld7qpT6ogzIh7jbUih6lnSJBTd3lTfPQEccB+HOkQQTlk0Q=
X-Received: by 2002:a2e:9087:0:b0:2e1:c97b:6f25 with SMTP id
 38308e7fff4ca-2e951b4f30bmr7752721fa.1.1716472672458; Thu, 23 May 2024
 06:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240522082729.971123-1-ubizjak@gmail.com> <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com> <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
 <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
In-Reply-To: <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 23 May 2024 15:57:40 +0200
Message-ID: <CAFULd4aXBAxPS7hXJ_RKMzZu60yTr7gK1m3K8z0yq1mjYn3dyA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 3:44=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2024/5/23 21:34, Uros Bizjak wrote:
> >>> +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
> >>> +                                (u64)virt_to_phys(entries) | PASID_P=
TE_PRESENT)) {
> >> Above change will cause a dead loop during boot. It should be
> > No, it is correct as written:
> >
> > if (cmpxchg64(*ptr, 0, new))
> >
> > can be written as:
> >
> > if (cmpxchg64(*ptr, 0, new) !=3D 0)
> >
> > this is equivalent to:
> >
> > tmp =3D 0ULL;
> > if (!try_cmpxchg64(*ptr, &tmp, new))
>
> The return value of both cmpxchg64() and try_cmpxchg64() is the old
> value that was loaded from the memory location, right?

Actually, try_cmpxchg() returns true if successful and false if it fails.

            tmp =3D 0ULL;
            if (!try_cmpxchg64(*ptr, &tmp, new))

The logic in the above snippet can be interpreted as:

if we fail to compare *ptr with 0, then:

            iommu_free_page(entries);
            goto retry;

as intended in the original code.

Thanks,
Uros.
