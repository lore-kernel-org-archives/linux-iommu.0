Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CB1F937
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 17:34:15 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-44756c21105so826467137.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691084054; x=1691688854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Xa9pYsN9q26Cy2OfWksmVuBviyVuvzRMdasYi4RPE=;
        b=ieYA6bVxf1lbXkgHAn+hXhVfxzKe711nmI2r+8a2Pkje45GQmKLftZmaLt0qar82gg
         SFBl/K1845mX6+FAqPkGcjyrpBXYikncS74nQOppvoyKSHXe0rCclfsEAXrPauDBdjLV
         e25KI/Uu6/whFSVJCUzOwGJkV3uYaP9OmOzDMNjjkk1ts8gnSQW1ex6gNo+0kzwO65XL
         HyypX83EJT7/21befwOJ9uRlgd3lhXqtj1LN6iNBdvKWKSCrS9QQZFXiZGxHkCMMLy82
         +seRRUC93Y1mRKPJn8r746QD8Gi1bfCC2+B+iopA0nXA09o5X8xylmqFAP/A/rLnnA0P
         /oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691084054; x=1691688854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8Xa9pYsN9q26Cy2OfWksmVuBviyVuvzRMdasYi4RPE=;
        b=bqf2qF1iOoVECxHrM8lG4BJ+z3/w/rNvypINTtWoEHCqNjRaPER3U27wR4u+VWwyme
         MfcTgJ/YW2nj+C99O9jbEXg12v7nPiwOvJGZdnZ//8X5jU3RyfdfLSceaRTG50B05Tk5
         p7EjrXPD2GvCQqOtIVdEQi3LsyDBT+2QrkhQlTdPpYStvmo9lxIsHsJh0NwXK7LQovsY
         +UHRAuq0wuXnI+Cap+qlYONmJEIrHpoIcsKOLgFCXFoN6k9izeVE3O1iynONY0i6empl
         rMB8KG2OQVwzF1Fuax6hISDHiwhXqRQg3PBmUgfwCYR5S8pCOmEmy+wIXahwHNhZ/5Pw
         VOJw==
X-Gm-Message-State: ABy/qLYTp7WnEFQUYCeSCH235lcgwua7UT5WnjiPtlQHtBR5m1eLo3SY
	y5pGkXpmCn9DnV7rjlKLUMOCyS7QKhgweAUuaNk=
X-Google-Smtp-Source: APBJJlG6pjOoG0q6RAsawh+9qeUBUHt8XE1GKbQlIBPYmQFLRffHoU6WGPDLy5lU6fh2CQ1SS4cFWeU/BvylteONzOI=
X-Received: by 2002:a05:6102:d8a:b0:443:5524:8f8b with SMTP id
 d10-20020a0561020d8a00b0044355248f8bmr4828038vst.4.1691084054017; Thu, 03 Aug
 2023 10:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
 <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
 <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
 <20230802094725.GA28241@lst.de>
In-Reply-To: <20230802094725.GA28241@lst.de>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 3 Aug 2023 23:04:02 +0530
Message-ID: <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma region
To: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <jstultz@google.com>, Pintu Kumar <quic_pintu@quicinc.com>, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Liam Mark <lmark@codeaurora.org>, 
	Laura Abbott <labbott@redhat.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2 Aug 2023 at 15:17, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> > So, forgive me, I've not had a chance to look into this, but my
> > recollection was "reserved" is the name we see on x86, but other names
> > are possibly provided via the dts node?
>
No, I think "reserved" is the name hard-coded (for all arch) in Kernel
for global-cma.
So, I don't think this is x86 specific. I am checking on arm32 itself.
When we can dma_alloc_coherent we see these in the logs (if dts region
is not present).
cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
Now, with this change we will see this:
cma: cma_alloc(cma (ptrval), name: global-cma-region, count 64, align 6)

> Indeed, dma_contiguous_default_area can also be set through
> rmem_cma_setup, which then takes the name from DT.
>
I think this is a different case. If DT entry is present we get this:
Reserved memory: created CMA memory pool at 0x98000000, name: name:
linux,cma, size 128 MiB
cma: cma_alloc(cma (ptrval), name: linux,cma, count 64, align 6)

Here we are talking about the default hard-coded name in Kernel code
if DT is not defined.
So, in one of the boards, this DT entry was not present and it shows
as "reserved".

> > I believe on the hikey board its "linux,cma" is the name, so forcing
> > it to reserved would break that.
> >
Yes, everywhere in the DT it's defined as "linux,cma".
You mean this also should be changed to "linux,cma-global-region"
everywhere with this change ?

> > Maybe instead add a compat config option to force the cma name (so x86
> > can set it to "default" if needed)?
>
Yes, having it in config is also a good option instead of hard-coding in Ke=
rnel.
>
> I think we'll just need to leave it as-is.  I with dma-heaps had never
> exposed the name to userspace, but we'll have to l=D1=96ve with it now.

Can you point me to the userspace utility we are talking about here ?
I think we should not worry much about userspace name exposure.
I guess it should fetch whatever is declared in Kernel or DTS, right ?
