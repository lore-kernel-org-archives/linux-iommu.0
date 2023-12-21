Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1C8F5C
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SaaQ3Orr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42784b919b9so3142381cf.3
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 21:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703135661; x=1703740461; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPm674rXSCwxQgD/8kQz5c0fP5ST0f+zOSOq7hzl6LU=;
        b=SaaQ3Orr1rNGHKMT26npiR6dsIPY5/OTirE1Skz7DBBTWwBaWkWkqaRCgBZKrtzrQ7
         kVJuxIippktU2Wy78uwcuUmNtqXL6g1/yJezP+RxcW6xhQaG9CqaXBAjU1UPC/nlhOgy
         DbUYe1SA2hmYO1MV3vjuyJaC8X7KwC8mvtS12CbB7KqyYWgNyTY/OG9JXcFMgoJALRVy
         S/3uPmWOWwP8+iWeTDwJaTOhecrJ9k5JRrmp9Wh1oMBhruMGufwLB0fTKV+78V3bl3Ea
         mt9DGhxyEgIVQ/V1Ex6VcJdrqLPisw4jVvKKwp9EPSiXL5rgJlz+e6gjSG8MyoU17BYj
         LTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703135662; x=1703740462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPm674rXSCwxQgD/8kQz5c0fP5ST0f+zOSOq7hzl6LU=;
        b=u4wI6wdEs/HwHRBPCg28o5a9xbsK4IPJufRq9BytV0VS1FS6jdwkDGIIQBwa9mpPhf
         iGV6sJjLmP/3N7dQIU02KySc0NDgQq2DaGPDyNlVNrg8uaEynmLw3whcRox4UWlKedV+
         gQ2JJ8F0cBOn0hkqWb/67ViysD+FsiA8dEX6KT6pemEqzPEKFTCtjhx8xQ/UmNqtNqDg
         ASDIh1RdCZDL4SIqrUZxI7d+5D/7wB+AGg1KB2ZK+YyTmintSz55+5hUofQaPgGMkn5c
         OZwArc7Olr1C1wsfl6Zm0Kp1FHvotFlWaSn4i19rl5HWzOOgfYZwtBKrauHH5+Fgs0s3
         SRwQ==
X-Gm-Message-State: AOJu0YzVqWhEE6V6TsSvzi5917nVJMfcv+IZYWfBJspxiYbv1h4nR3I3
	cxUR0YMTkqQ+sVf2kjFcI+1lG1SEmSlKewjYJTLGVg==
X-Google-Smtp-Source: AGHT+IFIF1kvdOQPV+kJwz+HvYp+BsGI4zVt5IRuyYg3yYDH4YeYNF4H2ORzJCxlpNLtqey20DUdsVzsI8tO4OwIYkI=
X-Received: by 2002:ac8:5747:0:b0:412:14a8:24c8 with SMTP id
 7-20020ac85747000000b0041214a824c8mr31395413qtx.8.1703135661768; Wed, 20 Dec
 2023 21:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com> <ZYO8IqiHeqs8LktJ@casper.infradead.org>
In-Reply-To: <ZYO8IqiHeqs8LktJ@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Dec 2023 00:13:45 -0500
Message-ID: <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:16=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > This series frees empty page tables on unmaps. It intends to be a
> > low overhead feature.
> >
> > The read-writer lock is used to synchronize page table, but most of
> > time the lock is held is reader. It is held as a writer for short
> > period of time when unmapping a page that is bigger than the current
> > iova request. For all other cases this lock is read-only.
> >
> > page->refcount is used in order to track number of entries at each page
> > table.
>
> Have I not put enough DANGER signs up around the page refcount?
>
>  * If you want to use the refcount field, it must be used in such a way
>  * that other CPUs temporarily incrementing and then decrementing the
>  * refcount does not cause problems.  On receiving the page from
>  * alloc_pages(), the refcount will be positive.
>
> You can't use refcount for your purpose, and honestly I'm shocked you
> haven't seen any of your WARNings trigger.

Hi Matthew,

Thank you for looking at this.

Could you please explain exactly why refcount can't be used like this?

After alloc_page() refcount is set to 1, we never reduce it to 0,
every new entry in a page table adds 1, so we get up-to 513, that is
why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to
dma_set_pte() macro. When refcount =3D=3D 1, we know that the page table
is empty, and can be added to a freelist for a delayed freeing.

What is wrong with using refcount for a scalable way of keeping the
track of number of entries in a iommu page table? Is there a better
way that I should use?

Thank you,
Pasha
