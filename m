Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA32CA5
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 17:12:55 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4476a50c64bso1688171137.3
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909974; x=1691514774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjQ83+bP/eZvrnu5mLPteL9v32upNHucn015ldMT4Lg=;
        b=eqleB+PpZKRzf07CkM3xQAVn2NofBi6SMHQMVVOvtjj1yAdQkkEpzST4P2npF+ejbz
         6OeHxWZxrhXtqLOSpyOOfUpXFH2lHhWamSLonMZ1o9NLYn5M31P6SwoZhQMpsBD3Rgxi
         jKQMJxbGcSSl685ayD3GcRoQfH5mg2NTm8mJ0XSQfkMgIrKRafZUto7la0ReRcyYsYF5
         6g7JxTndHY8g7HTBuN5JR1VCzQCKdRmiz2umjOQr40oPXi6MbozGZp1POTJ+c2RgDyqb
         MBwz+LZfTd0zNq7XYymhuV448iJei5cgunB3imBi/pb/Bc6n3nGlkvRDpu8PdAC/v1zX
         /Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909974; x=1691514774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjQ83+bP/eZvrnu5mLPteL9v32upNHucn015ldMT4Lg=;
        b=DvsKtEuhrQVjo6KovHpG7Us22b6HvnZ/oY8d3UqXjywMY9/QW13QcOvEZo9BgZPeXP
         XwRa/29fgZyqXQjjTCyb+1up1gGt1Cf7Q6QNb2xaHJAVkcSouCeiqHC5VUUQmOJlzp05
         cdEdS9rTWTJJ8R2V6kBQcq6luX+UBxzZsSPN4Rr24X2KXq+TkbfS+gTekEwS2mBHnLoG
         RywuAB3RM7sczhzRc2h/tmbTz5mjATZdwYQpEaQy83caikDXeKlYtJVjAALrTZ99mPJy
         rn35wzpHiIFrn+XkcIjYstah91DMVjcx9/OrQJDjQPip8rGYaqbCiGXKMPuZjY7aGL38
         UIYA==
X-Gm-Message-State: ABy/qLYMvdnY2KPZBaGAlgTrVi1u3IjZVMVHKsFsv1ml3Gsk3cf+VHVJ
	uYTjhFxYViLb8MhWjLlg5kqApSrvC8RcLaLjXxE=
X-Google-Smtp-Source: APBJJlGnBieFRVxRgawFgQeh8nMkgg8VXaX2ymYIkKzgsSDMdNymXxpqVlXrzhUS5zrV6ie9HEECZVtXFldDoVWXz7k=
X-Received: by 2002:a05:6102:8f:b0:447:48ab:cfe9 with SMTP id
 t15-20020a056102008f00b0044748abcfe9mr2671039vsp.5.1690909974270; Tue, 01 Aug
 2023 10:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com> <20230731112155.GA3662@lst.de>
In-Reply-To: <20230731112155.GA3662@lst.de>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Tue, 1 Aug 2023 22:42:42 +0530
Message-ID: <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma region
To: Christoph Hellwig <hch@lst.de>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, iommu@lists.linux.dev, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Liam Mark <lmark@codeaurora.org>, 
	Laura Abbott <labbott@redhat.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,
Thank you so much for your review and comments.

On Mon, 31 Jul 2023 at 16:51, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Pintu,
>
> On Sat, Jul 29, 2023 at 08:05:15AM +0530, Pintu Kumar wrote:
> > The current global cma region name defined as "reserved"
> > which is misleading, creates confusion and too generic.
> >
> > Also, the default cma allocation happens from global cma region,
> > so, if one has to figure out all allocations happening from
> > global cma region, this seems easier.
> >
> > Thus, change the name from "reserved" to "global-cma-region".
>
> I agree that reserved is not a very useful name.  Unfortuately the
> name of the region leaks to userspace through cma_heap.
>
> So I think we need prep patches to hardcode "reserved" in
> add_default_cma_heap first, and then remove the cma_get_name
> first.

Sorry, but I could not fully understand your comments.
Can you please elaborate a little more what changes are required in
cma_heap if we change "reserved" to "global-cma-region" ?
You mean to say there are userspace tools that rely on this "reserved"
naming for global cma ?
