Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26272F999F
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734327; cv=pass; b=L1rC5JvuB8sB9kC1HWmNOVroZVk4Whu5CpC/dUof6RiGkOhw7ItgL207pgPufFIWUEjWsI26WqINLwZZsFZuQTVbmmXBXEPcdiApCEYur4x7hXTHIAGCPNBGUUiSV0TtsuBFFJ/VQPdotPyu1Hd+x7Zvizz5nUY7D5d4utDMsqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734327; c=relaxed/simple;
	bh=2eZu3wNs8iUx1piAwoxHcZPkglWSOYzLI0WFbNjPqu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZdjkIFrZXpfC28M/y4xJ1X7UlBKUP1zejfiNIZri1zT6nVsEwSp0+56d1Q3r03tc6gsUnJau06UMeZfpElsf0GUT/0AwN1APOSDge8ru/gBXGl83A7WT2xXKqyo1lWNGZcbc7XSLJq2ZOBWT/ZywS+gBC3mfb89JxguAzdohm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgS9ssaq; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgS9ssaq"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11f42e9977fso458c88.1
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 13:18:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767734325; cv=none;
        d=google.com; s=arc-20240605;
        b=jMtcbJA8S0v+EsgmLGzHjcw261LYiN0zG5r025ge63UerPSGl6lB1WmNWDLBXEOUQC
         sAWiZvHrNlGqRYhQtJdMo4Bt9tskMcZnzVbT/IZ7tqsxqT7/ptkDkGSsczYS81LrAC4c
         l0FHjspXRzgtLd4XWuj+TaK/nzKcIlbK9nu0UTU2PM6TEcToahyUa+l5ZYyD8laRtnkz
         U97W2d5QSMQY/9xlihfqOmexKnvi/gJzs9pxISmBa+c7Q3QYDu6OsAq2CJBW6RUk2Qf0
         /8ObIzlb+irrHB7V7p8/kiCCyRWOhNR2jLL9TYEVRHkQ2X83YP1YCcmMRFLiKbtg3RqU
         SUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VGVuujQe5nx9sEZAaa25hNtXumT1G+7mUeDPEY80VTs=;
        fh=AbULydefbk2aQ3Fdgcb3GeS7CrP3K02oLnPza3ioTA8=;
        b=RM/DNuWx0iuUi00fXqyvRXfEj0k/RfSoWx7IMB4T6zIZVryqnjdRYN26Ffu3iRUo6U
         NmOIp1pkSDyThsY+9t2U+m+pJQFTde+7tIHEavOnYB2tvflBchkrCOxBWA30E+Dqg8xY
         nUCGrScLduHHcZgSIAMAwbii/bz7XTjGLaBUV1lx94XktAKjsVeRqbduFI7TUDciYikv
         5mm0mAB+5HSUtG5aV3XFu2DsHAQ0A25PrpvG8gXWGHRA5udMU0Zf0FkielQERPZRN4Px
         bgIeKD5pGfgqpkziPZsKsJU9Xv4moqiXMKa8D9vLmHP01XOxyRDJRjzx/Jy/yjtx5YnY
         JrMg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767734325; x=1768339125; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGVuujQe5nx9sEZAaa25hNtXumT1G+7mUeDPEY80VTs=;
        b=FgS9ssaqVyoU3ysVVtWUqu0pzmbMzTBJ2Ek3DM1qn5hGO5Kjf2BdO/smbhm1j/Jwvq
         Q0Mdph1S4HP88WoqdhBAUdpwJmMArVYgvM0qVCL34rsxinzfuDCvU2DFbdX265hMnwmP
         /MX+UBk6hDcJhEeQ7CBVlEg9xulaTJTQIfubJHEV1Rl4mez8hH+5IRrrTAzC9VD+Ah1q
         fY5r2oNC4qirSUEN1wMVLsDvDCTIbKmkrHVOCA2N6bCNYmBgarLMHT/gGgMOnuBsC6Qp
         arHg0kB/z4qvYehEoWNh7nAaI2jIA5CpDnObRV/CRi8HERGkIsO28JU6It3Iq8LF72SE
         C3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767734325; x=1768339125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGVuujQe5nx9sEZAaa25hNtXumT1G+7mUeDPEY80VTs=;
        b=Q6LS0KcVUxSBqK5NTAtSRUWweKg0LoYkUtmiMzdOAeWSLu4RL5DR8BLkjNjUalwrWi
         ZKUYaP2rzcGUez4LGBiAHIu4nhuHrhDrS1EPzOhraF8sFYsg5U744rfLzkm6nCxLfV2d
         mBF4ylM0VwnDjF/bf4n1JNpd8SX/AKFSI/PtiTPlCeIdo8eL048m59/YXQs2okj+vuJt
         SJBVHjqsmu7UkhiCZqWCvn6eEIDTlbrGwctnb6ZlDv4JMOwdyFsmQhcpDmkHs6TTKMBT
         GHNQhJb4Z8e79uXvnl87y/f/Z6IHlkyzluIY6CEtsWSggKdknfFJ5yn380MZafzvaYac
         y1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvJ4PfpVj/Z6lVsXGGvUB6zvwW3YYtXb28rQMwY5kH6Q66+2rlhgXyFvB1hJhkjHRXYLjXqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz50HXJp+2V3wfWN3fu9oKdgHjkgrSNlku8lSmP8XsiZUbS0LC/
	Pu3vAw2mlR7TsXoMey0vsP80S4HNMEqCnS7tS8vZe+ptOt044nETmO7oQEZKLe1ewRDlqZvEZAJ
	go5nkzt/JbPbApaCtE9gAHIAq+H7sHHElCwZJxwf3
X-Gm-Gg: AY/fxX7c3kVoUVMa686V5BljrJQVw6163f9eZXZJQYB6EHZsDTwtFOfpQVyMXwGi9kK
	iYvKTJdi/5DsQynIumQUFzqp9SNTvi8lcFE0vrO6N1Xboi6ahVq1UUuWj7uBF8lac7UoWTvAEpP
	gttZRTJf/Yvg9NU2m8U+F1mgoHOIbm5mnTwtUFuvneUWBnfnyFWG7WxMFZDX7RBmSRGSlMkZTTC
	MsXD4HEC9S5VqaYCeJMhmsnpQZN1fHmi7XhSVkwOvSA4jZYip8rdpA02kRBxbAUY8NYyBTkBxFV
	3tlxdN6nBbaa0lN5O+vKcxg=
X-Received: by 2002:a05:7022:49a:b0:11f:25fe:952f with SMTP id
 a92af1059eb24-121f8640d66mr27564c88.8.1767734324206; Tue, 06 Jan 2026
 13:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com> <20260106162200.2223655-4-smostafa@google.com>
In-Reply-To: <20260106162200.2223655-4-smostafa@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 6 Jan 2026 13:18:29 -0800
X-Gm-Features: AQt7F2o1wSEXREnLHU0_pBEPtmmqdHD2M-tusioq9HwIDAwG5VqNr9DDjNwqNyE
Message-ID: <CAAywjhRceyE7WRaFY+Kyy=hGbMjzT9MJDC=+Y4kbXwvOxuDRSA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:22=E2=80=AFAM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> Using the new calls, use an atomic refcount to track how many times
> a page is mapped in any of the IOMMUs.
>
> For unmap we need to use iova_to_phys() to get the physical address
> of the pages.
>
> We use the smallest supported page size as the granularity of tracking
> per domain.
> This is important as it is possible to map pages and unmap them with
> larger sizes (as in map_sg()) cases.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 91 +++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-=
debug-pagealloc.c
> index 1d343421da98..86ccb310a4a8 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -29,19 +29,110 @@ struct page_ext_operations page_iommu_debug_ops =3D =
{
>         .need =3D need_iommu_debug,
>  };
>
> +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> +{
> +       struct page *page =3D phys_to_page(phys);
> +       struct page_ext *page_ext =3D page_ext_get(page);
> +
> +       return page_ext;
> +}
> +
> +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page=
_ext)
> +{
> +       return page_ext_data(page_ext, &page_iommu_debug_ops);
> +}
> +
> +static void iommu_debug_inc_page(phys_addr_t phys)
> +{
> +       struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> +       struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> +
> +       WARN_ON(atomic_inc_return_relaxed(&d->ref) <=3D 0);
> +       page_ext_put(page_ext);
> +}
> +
> +static void iommu_debug_dec_page(phys_addr_t phys)
> +{
> +       struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> +       struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> +
> +       WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
> +       page_ext_put(page_ext);
> +}
> +
> +/*
> + * IOMMU page size doesn't have to match the CPU page size. So, we use
> + * the smallest IOMMU page size to refcount the pages in the vmemmap.
> + * That is important as both map and unmap has to use the same page size
> + * to update the refcount to avoid double counting the same page.
> + * And as we can't know from iommu_unmap() what was the original page si=
ze
> + * used for map, we just use the minimum supported one for both.
> + */
> +static size_t iommu_debug_page_size(struct iommu_domain *domain)
> +{
> +       return 1UL << __ffs(domain->pgsize_bitmap);
> +}
> +
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, si=
ze_t size)
>  {
> +       size_t off, end;
> +       size_t page_size =3D iommu_debug_page_size(domain);
> +
> +       if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
> +               return;
> +
> +       for (off =3D 0 ; off < size ; off +=3D page_size) {
> +               if (!pfn_valid(__phys_to_pfn(phys + off)))
> +                       continue;
> +               iommu_debug_inc_page(phys + off);
> +       }
> +}
> +
> +static void __iommu_debug_update_iova(struct iommu_domain *domain,
> +                                     unsigned long iova, size_t size, bo=
ol inc)
> +{
> +       size_t off, end;
> +       size_t page_size =3D iommu_debug_page_size(domain);
> +
> +       if (WARN_ON(check_add_overflow(iova, size, &end)))
> +               return;
> +
> +       for (off =3D 0 ; off < size ; off +=3D page_size) {
> +               phys_addr_t phys =3D iommu_iova_to_phys(domain, iova + of=
f);
> +
> +               if (!phys || !pfn_valid(__phys_to_pfn(phys)))
> +                       continue;
> +
> +               if (inc)
> +                       iommu_debug_inc_page(phys);
> +               else
> +                       iommu_debug_dec_page(phys);
> +       }
>  }
>
>  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>                                unsigned long iova, size_t size)
>  {
> +       __iommu_debug_update_iova(domain, iova, size, false);
>  }
>
>  void __iommu_debug_unmap_end(struct iommu_domain *domain,
>                              unsigned long iova, size_t size,
>                              size_t unmapped)
>  {
> +       if (unmapped =3D=3D size)
> +               return;
> +
> +       /*
> +        * If unmap failed, re-increment the refcount, but if it unmapped
> +        * larger size, decrement the extra part.
> +        */
> +       if (unmapped < size)
> +               __iommu_debug_update_iova(domain, iova + unmapped,
> +                                         size - unmapped, true);
> +       else
> +               __iommu_debug_update_iova(domain, iova + size,
> +                                         unmapped - size, false);
>  }
>
>  void iommu_debug_init(void)
> --
> 2.52.0.351.gbe84eed79e-goog
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
