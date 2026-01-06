Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A834DB46
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714603; cv=pass; b=cXjy0CPi0gAhTgKdATMXGEEogfpR7e/2fe486qAKw81zSdiWb9gIaoozoUMeZl/0lnRRrxItWwaRpVNX1UlvtXgxnnyg7NM1B8O70ZL3oVW4rXfLK5xyF1cgUQjKdB5JNCRoHyufCVzp+mlNzk9AacGD44uFdrXE6HHwclWUBgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714603; c=relaxed/simple;
	bh=48fVzOvLrZOQEbkvM5UMLnlpv+imRIa8TVsOVuFn/vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy/tv5+m+To8n9p1IW5QJ89fsaDYtDjz8vZtdN7lj/lwdTWka7Nv1ARrplSGD4inyXrtuq0WaKKaUTpcCgJYtaiDeU2Y+JKX+7gczcExC6j9Zgn9NQavQyID8+OrJ4Nz+t5p+Yo5wJfZBXhs8LugN3Dgvp8+NkLk7f3HulNCOwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+uQ4hCa; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+uQ4hCa"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee243b98caso433671cf.1
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 07:50:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767714600; cv=none;
        d=google.com; s=arc-20240605;
        b=T+/B4fHv+Q/8ZlCCOM4lDxXfNEHlgWjji0i/Fmclkd+XjKqQq70ucNkWcEHaxKSWlC
         njNXQAx+VMHEBsUw6m3+4BLW7q+mobTJ23ighaSdtCaRlcMRACErGpzb13zx4SqZe2zp
         vSZExYTWadnviSZO334vPgSq8swS3+bwgoMSoqZybOoFQ2cq0+ZJynb5a5UwJIZ1vshs
         f8ldCNWjwKvOqmfQH7M0tOVr4HgVgA9fp1GhxIX5G/44o0oSWncHcSYdx2vSekZRNFqI
         OqGz8gGDLWk5zYgqo89Y4hF8wF+F2AhIQPheoNKehhkntgWTsQjRWSbID0WLtwp1Mfgt
         79Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4u/XP2Qb+qQvDlOXEIcff9WsDxL9SWsqniXEl78vuPY=;
        fh=Ha3yOnx/0InWM6maFXdcjjq8bzVI9IfCjTNPGXOHGGw=;
        b=RVt+OFrWJW2GGp4bZMlcwUrGjJCAZOLkVsxu6+7jc+Tcj0NNvodzjwfXzw0TuXQ3v/
         QitOAuTRAFocDSamnzYcDfUKdzzFk0JQGr+zACpMvSDKQhsOArnUBfl4VORzjHPy5//V
         lUcI/Nr3HwQTOHsXIU7ZAZCa8EYXRz9c3euRG1+iB6DbdulkqshuIzBC/LSXlpRm7pWQ
         P1URhqlLFPFbyLjQMfy+K9ZyAi8oth58m2xnDJADyiV5UnjJxUUUaeF2NcqMALzZYiP5
         vXboxXfrYMnsyAlKm1xjoGb/BW0rDGwFL/DjhYKnC+rco/j5ESKJ/MHyU9h8MkvU7sVk
         89ng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767714600; x=1768319400; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u/XP2Qb+qQvDlOXEIcff9WsDxL9SWsqniXEl78vuPY=;
        b=S+uQ4hCahVpzYryvQpG6MCAHFl0wM/DzyQZvkpk0AgejvcQhFJCm8NX/3BJF0Ca8gv
         veEjgUC4xN8nbFC4hx+2Iqz3RbgY5lWrkkU36WWAaFp0zO2KAfBMUh2F9Z4zMEj4G2ww
         v09V+4SfCctv9sY1VeV3LlvQ6k/ANm0SI25MpOJLau3Sl0+Xh2dXJj6ZNaA2Bx9w4VyO
         S6VrPtslaazrZyfUVlVBqFBK1g6T8QeWKXPNwqLPK6/cIv1gDamNLZISPVsDgTtEFYTZ
         bHhzBsoDTvg4zQkXBLPvIzXTR7/cmgqIlZU8mRp206uDJuc+eqMPeG5OYZ1adVPBATZN
         5gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714600; x=1768319400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4u/XP2Qb+qQvDlOXEIcff9WsDxL9SWsqniXEl78vuPY=;
        b=XP/J97sVgfXle7mbDddVS7EJco6qP1p0LHuBy3EoHrszDyEJ3ZWkCYt9duiWj/pvds
         8gar0GLEnIxFAc8DM5VuMbEwIqzYGBuhJPaHmchOB0+TjUHifwTOtVFGtr4Xb43DOFCr
         10v30aBC6xSgibAmwQeLa/OcSIsPHvnIQD2Ys/QzO64Bqfx9187noDCJ2uYIl0RVLnvz
         fB34b5rry9mK6rXRkTXGk48fHpZtkvvTQGtUnPnhMhshu4+Dpydy+mNGqpKzQ0ZPJY6B
         4tnTG2uYFvCHWU4RscLvddTv3/xUHT8nHX6YX/bx4JYch+JvrvD9BALhnxZ1KR+TVRVo
         OF3g==
X-Forwarded-Encrypted: i=1; AJvYcCW6zH8hfoaL6GzMjhw2OJNJJErdQGSSwuNJiG/NUE7HDTNLB0fpHYO7kJOo9eIUjdCOGu4ipg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydyTxQZ+QbP9fJIl0vNbloA5qqLqoXE/xEgaL/DqsuLv5wh87h
	iTjd9JxRWURZckvhtLQueaeHZ3YH4wB6hP+dZwJggFHg3uoWOfBsgmE6JRqRCAV7u7FJPmJQAan
	H1EixEqtVPeChbMGRsBHMaNA5ZuM0IfgvaQMICApi
X-Gm-Gg: AY/fxX7bYZhfnuwqr80idOvOUurb5MzoHyOyuxZk5O6YaA2tnr+fdWP18KE5GTTNPh1
	WbVduY00auoRw2K4cc7DJtjlYgweiujes8iqxtzmxlyCKH2a8gO32ZRL0AvQHdFo0CPDBgvQSFR
	8Qt42PqnsCZony8R6YVitQVFlfq/8heqbyuV8s8DrlFiU2n/jCZ1nt8re0R+B39tY3+cuvDBFIK
	cc3XpHeL1z/02eyiELmmn1+57qdbVyTBlIfPixQwmqwMP1sr2JW96RMna3ke1M0ThFkIBgyNHSO
	pQeetSYFEFAAElqRWE2OeRKnIQ==
X-Google-Smtp-Source: AGHT+IHbCEXPRNDYInsMRbyk944URhHinQrSqdn9SMJ0HiaUkC2VNjD/GTcHUOOXarpMrOxvUsEyl1eweg53sx9OpUM=
X-Received: by 2002:a05:622a:90:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ffa961f4cdmr5690451cf.7.1767714600009; Tue, 06 Jan 2026
 07:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251211125928.3258905-1-smostafa@google.com> <20251211125928.3258905-2-smostafa@google.com>
 <341bbfd9-e6bb-4d1e-b9c0-9077dc3eaba3@linux.intel.com>
In-Reply-To: <341bbfd9-e6bb-4d1e-b9c0-9077dc3eaba3@linux.intel.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 6 Jan 2026 15:49:48 +0000
X-Gm-Features: AQt7F2oA1CBb4GrIbCitr-B-G-VTljeq1aZHCjWlK0-2EsS6hRvCfN68ucTwj3A
Message-ID: <CAFgf54r76=RF0TAkJ42VDnRkwYf0=bjRk-pO1dq3zzvxGBThww@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 2:22=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 12/11/25 20:59, Mostafa Saleh wrote:
> > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > page_ext.
> >
> > This config will be used by the IOMMU API to track pages mapped in
> > the IOMMU to catch drivers trying to free kernel memory that they
> > still map in their domains, causing all types of memory corruption.
> >
> > This behaviour is disabled by default and can be enabled using
> > kernel cmdline iommu.debug_pagealloc.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  9 ++++++
> >   drivers/iommu/Kconfig                         | 19 +++++++++++
> >   drivers/iommu/Makefile                        |  1 +
> >   drivers/iommu/iommu-debug-pagealloc.c         | 32 ++++++++++++++++++=
+
> >   include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> >   mm/page_ext.c                                 |  4 +++
> >   6 files changed, 82 insertions(+)
> >   create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >   create mode 100644 include/linux/iommu-debug-pagealloc.h
>
> Do you need to update the MAINTAINERS file, since a new file (iommu-
> debug-pagealloc.h) is being added?
>

Sorry I missed this last time, that should be under the path of "IOMMU
SUBSYSTEM",
I am happy to maintain it, but it's up to Joerg and Will.

Thanks,
Mostafa

> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index a8d0afde7f85..d484d9d8d0a4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2675,6 +2675,15 @@ Kernel parameters
> >                       1 - Bypass the IOMMU for DMA.
> >                       unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHR=
OUGH.
> >
> > +     iommu.debug_pagealloc=3D
> > +                     [KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is =
set, this
> > +                     parameter enables the feature at boot time. By de=
fault, it
> > +                     is disabled and the system behaves the same way a=
s a kernel
> > +                     built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> > +                     Format: { "0" | "1" }
> > +                     0 - Sanitizer disabled.
> > +                     1 - Sanitizer enabled, expect runtime overhead.
>
> "iommu.debug_pagealloc=3D0" has the same meaning as "unset". Would
> "iommu=3Ddebug_pagealloc" look more appropriate?
>
> > +
> >       io7=3D            [HW] IO7 for Marvel-based Alpha systems
> >                       See comment before marvel_specify_io7 in
> >                       arch/alpha/kernel/core_marvel.c.
>
> [ ... ]
>
> Other changes look good to me.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
