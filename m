Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A73FB234
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871999; cv=pass; b=EypM1CWG6m9BvJPN0rNxU5TwSQp9AhE9wHtWYsWC6XMUkM7HKHyF/aUnUDyxsHG6AYoM73ODsLvwe6yoZc+cI9mHfagZJMsWcbbA+9sr6Jzh6QuCJldJp6uszssia3qoiUcy3ZQS8JAvtIaJxnQnpVX0zyxpIu7NgMbK3IR4MTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871999; c=relaxed/simple;
	bh=ZZ7jjc2Z7MlEyWpqG25mdLQhus67sDNziV9lhVgNUPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbvsYrB6scyGFWRplKdSDMPMCN5XCiUd9H2q2rdyo/VWg/EtJ2qEFvlcx0nVOPxn8z3HD5oIhASdZlNUOmcVEpUbtNRSeT/X50KNzUGZUY7CkUeONYHcg4HwqfBzBeZCfImN++agi88HiaxlSdTFpsAgN9WiDpidw86rnTMo6qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvYpswU3; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvYpswU3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee243b98caso794281cf.1
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 03:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767871993; cv=none;
        d=google.com; s=arc-20240605;
        b=fquXg1V7wl/1ZG8vnJQHecMHlx/uXZeyI3/IyYAcqWrPrz2B9sEy97BpO4Myq2GIi2
         hicVppt3A8ks9l2gBgDXVTq5zv/G3lxnNv3wRcg5qioRGuzQIe5Eef4Db7i8KLqUszLE
         09Y9fJfAXae7JAqnQDH1+b4TQe86kNTkFSPsSTSBL13DOcHO+4VUVZed2VhVoySHfu3t
         UyA4dW4Quv8Asamr2BwX9CQ+ZRUOYwzZ3qxki3JozXdlp4U0r53vgmep8fkccrLz/u5L
         DY5sOu5A9czylC2/pIwpLf5c2SITPzgkGdNkrSJ0zB0MarHCukL3J+nktU+NtCjWoGNt
         REiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uOaQcEvqH/Hd3NqzripTRIq0Qw/v1bGv7C8UVSeJmM=;
        fh=Z6LTCHLFE3BrGnnR3qdtH4YnIjgrpehFd0z5RjTI/k0=;
        b=OtPIPfjl2TWnYzAxGGGWNjurOfeJgb2B5aE30osopU7k2WBZigaTPFGgMb8CNN1LQQ
         Rb/LxhRfglX4AXn8ir+in6IP1BDYN6ECG49p3BLq5zy5dBF1J4CohyaYExTxO0kS8kpP
         VPMJoWC3IIwApI38vtf5K6PASn+9x05OV4kyh19ctx7gqlig3uozeF596l10eM3977a/
         h6O8phJB7apJYBPghNQUiWTzDCw65gsQNAYtcyPVUd2lsInJTZliP9VfrYzDfSeCPf1d
         Z218HC4wmS/Cv9dlg1qe5tDgBPo8uF0gOM+AVofQJdRhg87Xcl8jLSNpcH1Oui/n2QGx
         B6YA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767871993; x=1768476793; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uOaQcEvqH/Hd3NqzripTRIq0Qw/v1bGv7C8UVSeJmM=;
        b=CvYpswU37CXvzoNrXlNpn/ltAsS9Eq0zKRH/+jccxwvkwb8kcNt8Tgn6hPyR5kSN8L
         IXWSEiLpEIZhIuzIzZCCkvYb0JvUAV8oshlb9FXGtndieKeCI4F7BZ68AxwH4uvH9Z83
         Mt9m2XBjNm9+0hcSaQbWMKFMIibUi6fx1Q/PjnlK4zXkNJzoX2HRGtLAM/4enS8rTSjq
         P/HptPvSvZKzYQgzsMzK8fhI+ubONLbVmhvEAYyU6EvFjwu2t8/qxyDrjVEHQBOG6RZB
         fWUckRB6qtjdBuh1t0W7Q/QwE/YSUwHi93XbSQh7LB3q1GC53ZY1uG5CIXdWq9Xahtbl
         VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871993; x=1768476793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uOaQcEvqH/Hd3NqzripTRIq0Qw/v1bGv7C8UVSeJmM=;
        b=L9lsvdEkItcGUZeC1Ro/em75xG24ATV4CYYwN0MtbVgvGYd6c23xE0m1BCG+Eig7Ml
         3Ay4sudeh5kzJDOG+GJEOLouWZOkezOVYvGhnPDtvWFptdNlhDy1beeKLc1VkwgrXbuB
         PBd6nWEHSnN8JJ3IUYOFhDZeAYuzBlLHLDLng/jv8Ey5lXgO5uV0EAhBbl2/CIVQfNwv
         R5e0WeoBTWy+inlpAhw/hm0bZcVCF7d1BvxWJ4dblLVEPyLSGp83tQV2RONyWwv/Ms97
         7+qJKldx8i5lp3OPGCFmBa2VxpGgWwc5xA2PNIiAfne3X6dRoavWNGWNrBCIWOk8WwAi
         A2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUVVzowSIYX369D1o+dCYr72pcbOVDGQeBwGRcL/ci70uqCUihVnvS/KfwTOTAcmUuJEJsScQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFzVD8Wlj1MX41DB/By/nGPWr2fUPr7DGycRlYNTKvMl4DpGt6
	dZ/fQd1va29njEgS1AbEZ2h4LNxMEq/hzj9FPnRmWyCuJ62OeMR+hIQmOZDHLMtU8oGbR6p2Fnt
	2oDCXbEXrdaTk16LLGV0GkhgpvrxXHwiJQlN7m5UK
X-Gm-Gg: AY/fxX4QsKU2eEwyQyOtkQk8djlYiMuahIOrXF9oYBRSrsm+78DA3vfouTgDneL2eiS
	bYaFXHwzEz2geJH16M1kLVbcDbwxnkxzXfZOmg87npxG0vdGs2WMNKpcqbipEGPQdBq6ndAzmRy
	LO9+tjMmAVxVwWdddTzYfDkEERHBXZBFCS/Znsbq7HYCw2n/UHjI6MNuJ8tnxrnDGPxZiCPDWOS
	J3HtOSBVeV9ktCZeRjYkibhrCPyvB2ixcXS5r1xFOK8WOFkE5+mPBNNaRWp/H0koribbHqkFysv
	/iL7VmhW5c9zf9owJrw9c1lufNiAMA==
X-Received: by 2002:ac8:5ac3:0:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-4ffc0a77967mr7353911cf.17.1767871992772; Thu, 08 Jan 2026
 03:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com> <20260106162200.2223655-4-smostafa@google.com>
 <aV56BWisUQTMK2Gk@google.com> <aV-PvBqQ0Ktiha8e@google.com>
In-Reply-To: <aV-PvBqQ0Ktiha8e@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 8 Jan 2026 11:33:01 +0000
X-Gm-Features: AQt7F2pw41zErLif-3uwryiAOrSOrZpnIkyTexwr9_jBpysRxSFYAMim5EQTGb8
Message-ID: <CAFgf54o4Ja7jQwxo6XyW+JaT+aUuj3O2dvLqOTb+YSVCKTdvyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:06=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Wed, Jan 07, 2026 at 03:21:41PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jan 06, 2026 at 04:21:59PM +0000, Mostafa Saleh wrote:
> > > Using the new calls, use an atomic refcount to track how many times
> > > a page is mapped in any of the IOMMUs.
> > >
> > > For unmap we need to use iova_to_phys() to get the physical address
> > > of the pages.
> > >
> > > We use the smallest supported page size as the granularity of trackin=
g
> > > per domain.
> > > This is important as it is possible to map pages and unmap them with
> > > larger sizes (as in map_sg()) cases.
> > >
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  drivers/iommu/iommu-debug-pagealloc.c | 91 +++++++++++++++++++++++++=
++
> > >  1 file changed, 91 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/io=
mmu-debug-pagealloc.c
> > > index 1d343421da98..86ccb310a4a8 100644
> > > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > > @@ -29,19 +29,110 @@ struct page_ext_operations page_iommu_debug_ops =
=3D {
> > >     .need =3D need_iommu_debug,
> > >  };
> > >
> > > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > > +{
> > > +   struct page *page =3D phys_to_page(phys);
> > > +   struct page_ext *page_ext =3D page_ext_get(page);
> > > +
> > > +   return page_ext;
> > > +}
> > > +
> > > +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *=
page_ext)
> > > +{
> > > +   return page_ext_data(page_ext, &page_iommu_debug_ops);
> > > +}
> > > +
> > > +static void iommu_debug_inc_page(phys_addr_t phys)
> > > +{
> > > +   struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> > > +   struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> > > +
> > > +   WARN_ON(atomic_inc_return_relaxed(&d->ref) <=3D 0);
> > > +   page_ext_put(page_ext);
> > > +}
> > > +
> > > +static void iommu_debug_dec_page(phys_addr_t phys)
> > > +{
> > > +   struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> > > +   struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> > > +
> > > +   WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
> > > +   page_ext_put(page_ext);
> > > +}
> > > +
> > > +/*
> > > + * IOMMU page size doesn't have to match the CPU page size. So, we u=
se
> > > + * the smallest IOMMU page size to refcount the pages in the vmemmap=
.
> > > + * That is important as both map and unmap has to use the same page =
size
> > > + * to update the refcount to avoid double counting the same page.
> > > + * And as we can't know from iommu_unmap() what was the original pag=
e size
> > > + * used for map, we just use the minimum supported one for both.
> > > + */
> > > +static size_t iommu_debug_page_size(struct iommu_domain *domain)
> > > +{
> > > +   return 1UL << __ffs(domain->pgsize_bitmap);
> > > +}
> > > +
> > >  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys=
, size_t size)
> > >  {
> > > +   size_t off, end;
> > > +   size_t page_size =3D iommu_debug_page_size(domain);
> > > +
> > > +   if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
> > > +           return;
> > > +
> > > +   for (off =3D 0 ; off < size ; off +=3D page_size) {
> > > +           if (!pfn_valid(__phys_to_pfn(phys + off)))
> > > +                   continue;
> > > +           iommu_debug_inc_page(phys + off);
> > > +   }
> > > +}
> > > +
> > > +static void __iommu_debug_update_iova(struct iommu_domain *domain,
> > > +                                 unsigned long iova, size_t size, bo=
ol inc)
> > > +{
> > > +   size_t off, end;
> > > +   size_t page_size =3D iommu_debug_page_size(domain);
> > > +
> > > +   if (WARN_ON(check_add_overflow(iova, size, &end)))
> > > +           return;
> > > +
> > > +   for (off =3D 0 ; off < size ; off +=3D page_size) {
> > > +           phys_addr_t phys =3D iommu_iova_to_phys(domain, iova + of=
f);
> > > +
> > > +           if (!phys || !pfn_valid(__phys_to_pfn(phys)))
> > > +                   continue;
> > > +
> > > +           if (inc)
> > > +                   iommu_debug_inc_page(phys);
> > > +           else
> > > +                   iommu_debug_dec_page(phys);
> > > +   }
> >
> > This might loop for too long when we're unmapping a big buffer (say 1GB=
)
> > which is backed by multiple 4K mappings (i.e. not mapped using large
> > mappings) it may hold the CPU for too long, per the above example:
> >
> > 1,073,741,824 / 4096 =3D 262,144 iterations each with an iova_to_phys w=
alk
> > in a tight loop, could hold the CPU for a little too long and could
> > potentially result in soft lockups (painful to see in a debug kernel).
> > Since, iommu_unmap can be called in atomic contexts (i.e. interrupts,
> > spinlocks with pre-emption disabled) we cannot simply add cond_resched(=
)
> > here as well.
> >
> > Maybe we can cross that bridge once we get there, but if we can't solve
> > the latency now, it'd be nice to explicitly document this risk
> > (potential soft lockups on large unmaps) in the Kconfig or cmdline help=
 text?
> >
>
> Yes, I am not sure how bad that would be, looking at the code, the closes=
t
> pattern I see in that path is for SWIOTLB, when it=E2=80=99s enabled it w=
ill do a
> lot of per-page operations on unmap.
> There is a disclaimer already in dmesg and the Kconfig about the performa=
nce
> overhead, and you would need to enable a config + cmdline to get this, so
> I=E2=80=99d expect someone enabling it to have some expectations of what =
they are
> doing. But I can add more info to Kconfig if that makes sense.
>
> > >  }
> > >
> > >  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> > >                            unsigned long iova, size_t size)
> > >  {
> > > +   __iommu_debug_update_iova(domain, iova, size, false);
> > >  }
> > >
> > >  void __iommu_debug_unmap_end(struct iommu_domain *domain,
> > >                          unsigned long iova, size_t size,
> > >                          size_t unmapped)
> > >  {
> > > +   if (unmapped =3D=3D size)
> > > +           return;
> > > +
> > > +   /*
> > > +    * If unmap failed, re-increment the refcount, but if it unmapped
> > > +    * larger size, decrement the extra part.
> > > +    */
> > > +   if (unmapped < size)
> > > +           __iommu_debug_update_iova(domain, iova + unmapped,
> > > +                                     size - unmapped, true);
> > > +   else
> > > +           __iommu_debug_update_iova(domain, iova + size,
> > > +                                     unmapped - size, false);
> > >  }
> >
> > I'm a little concerned about this part, when we unmap more than request=
ed,
> > the __iommu_debug_update_iova relies on
> > iommu_iova_to_phys(domain, iova + off) to find the physical page to
> > decrement. However, since __iommu_debug_unmap_end is called *after* the
> > IOMMU driver has removed the mapping (in __iommu_unmap). Thus, the
> > iommu_iova_to_phys return 0 (fail) causing the loop in update_iova:
> > `if (!phys ...)` to silently continue.
> >
> > Since the refcounts for the physical pages in the range:
> > [iova + size, iova + unmapped] are never decremented. Won't this result
> > in false positives (warnings about page leaks) when those pages are
> > eventually freed?
> >
> > For example:
> >
> > - A driver maps a 2MB region (512 x 4KB). All 512 pgs have refcount =3D=
 1.
> >
> > - A driver / IOMMU-client calls iommu_unmap(iova, 4KB)
> >
> > - unmap_begin(4KB) calls iova_to_phys, succeeds, and decrements the
> >   refcount for the 1st page to 0.
> >
> > - __iommu_unmap calls the IOMMU driver. The driver (unable to split the
> >   block) zaps the entire 2MB range and returns unmapped =3D 2MB.
> >
> > - unmap_end(size=3D4KB, unmapped=3D2MB) sees that more was unmapped tha=
n
> >   requested & attempts to decrement refcounts for the remaining 511 pgs
> >
> > - __iommu_debug_update_iova is called for the remaining range, which
> >   ends up calling iommu_iova_to_phys. Since the mapping was destroyed,
> >   iova_to_phys returns 0.
> >
> > - The loop skips the decrement causing the remaining 511 pages to leak
> >   with refcount =3D 1.
> >
>
> Agh, yes, iova_to_phys will always return zero, so the
> __iommu_debug_update_iova() will do nothing in that case.
>
> I am not aware which drivers are doing this, I added this logic
> because I saw the IOMMU core allow it. I vaguely remember that
> had something about splitting blocks which might be related to VFIO,
> but I don't think that is needed anymore.
>
> I am happy just to drop it or even preemptively warn in that case, as
> it is impossible to retrieve the old addresses.
>
> And maybe, that's a chance to re-evaluate we allow this behviour.
>

I have this, it should have the same effect + a WARN, I will include
it in the new version

diff --git a/drivers/iommu/iommu-debug-pagealloc.c
b/drivers/iommu/iommu-debug-pagealloc.c
index 5353417e64f9..64ec0795fe4c 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -146,16 +146,12 @@ void __iommu_debug_unmap_end(struct iommu_domain *dom=
ain,
        if (unmapped =3D=3D size)
                return;

-       /*
-        * If unmap failed, re-increment the refcount, but if it unmapped
-        * larger size, decrement the extra part.
-        */
+       /* If unmap failed, re-increment the refcount. */
        if (unmapped < size)
                __iommu_debug_update_iova(domain, iova + unmapped,
                                          size - unmapped, true);
        else
-               __iommu_debug_update_iova(domain, iova + size,
-                                         unmapped - size, false);
+               WARN_ONCE(1, "iommu: unmap larger than requested is
not supported in debug_pagealloc\n");
 }

 void iommu_debug_init(void)

Thanks,
Mostafa

> Thanks,
> Mostafa
>
> > Thanks,
> > Praan
