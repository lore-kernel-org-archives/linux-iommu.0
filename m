Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BE425CC6
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049959; cv=pass; b=iEHB4OhHlwBkqhY+0MCfF9ainG9b5XANThOe60CwupqW8tLFnNHsPxg/MgguJg3tSd93ZaQD4WWrME9s/5yO/vQnTQjOwTjB8YZJ+OquJSUGO6i4eB2tU5vQdTvFtKz74hSaWbk5saSxoV46MbgGfagxgvRRYKs6YoEh1tyybvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049959; c=relaxed/simple;
	bh=1qGvVqwik+E6UaA8EtHo8Y9hkD9P8wNTkAKesdsaWMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAGu16E+DOFF7YDBFYdqamts1YV4r0QuJR5AWJyww27gD8JCENOiTpQlZ+b4/vSG6tmWC1MrNFIM16zyyP/RlhTTlHrvEfbfawCBxN6PC4Ph4rPMY1rRvIr9icPz/QyZ0X7WrbgvPbx4VOhBCcdzK97vamN2KAyPqxOuFm/ikyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCeGvwbL; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCeGvwbL"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so907553366b.2
        for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 06:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049956; cv=none;
        d=google.com; s=arc-20240605;
        b=EbzMwJpedfi4mxCQeJ9eAZ7gyvxSYTRFdTZVHuZQGSDXt9ociK8cXw4L1bZLsUkTc/
         KuAGvkltmIHeYVbGimzGwyAVYOAiMP+y6HlgxS6VjcRIj1cmg8Tmd0oU59J0uQH0MIK2
         KtnuP7sZYcBo319XdVhM9iTVID99ajMVU2YslNubEkt7wi36aSURyXxqsQFPl4cxSBu3
         KwVpehbKP7q/DlsTOJ8e4Yn15KDmvyrCCS2123KKYxENUBjrudftFYbrLsEiDFdDME8O
         gNr38s5hpXs10IGxMYZ9n8InF6Mta254PPNJgaurX6YkkcKk/TsYjipMw38Gd8BGqHIz
         G5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qGvVqwik+E6UaA8EtHo8Y9hkD9P8wNTkAKesdsaWMI=;
        fh=egmQabHXursBa2DUtw2aqJeQrCw4A7rM+eG1IZqLVwI=;
        b=kA2qJuPbZ3WSGTgyrNY4cpY2ONxBrlTRex64KyYV8kk6mRagVMNZrnagHUDItVPQMG
         rVf/MgCgncm5GlBCIe301eQzRvPS0agejD89pP9O1nUquYu/MSQU0lRdNiiXCY4DETxD
         khSqfcZ1XoryU2AR4ZzRjKHpyVTzZUiNp6VnlsEr38b4Bg4P4UzKcjPczW7B3wXcon1R
         eM8RNf4OneukxLVMu5POJOWH6dCBggmWMMMTiFGLOovF4lsI4DT2FXbeoujHpRzPeXxw
         2qPxx2wVd/AQd3i3aICYONO4+VTjOr8cKgJqn0Ab30frnQF033spk8YfYbMJ0EJTjQ/a
         bqEg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049956; x=1775654756; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qGvVqwik+E6UaA8EtHo8Y9hkD9P8wNTkAKesdsaWMI=;
        b=DCeGvwbLmSh1963eZupkMYKwXkyrFY2j2igrMJsD+Td3qim/0JGxTFc2rOwIYs1Dw/
         CYEQEB59TtQyEh8GT9NfGmPJXUi7ks2CZ+sLhv4J6NZBh9RcGb2ix91X1ubc7k14SzQX
         2zddueY+oMEUt6jroKjJ4LjNR7aMtlL6tw/Y5FRZucYPcF3DQ1FxmM17E2NG0EitzGs8
         Q2cwlCsHpKiQ0kNYFB3XEheabEXW/YdIvLUUd5bLweQcNNf1VkdhVaj9b25tGAhm+XAk
         V3ML2SltzYYId5lpdMWSvaGzxELYY/SLPDRQtkwrx5cmm4K4IaeymtrydQv4HL9MLad0
         ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049956; x=1775654756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qGvVqwik+E6UaA8EtHo8Y9hkD9P8wNTkAKesdsaWMI=;
        b=WSY7ThV/iVQkVwWrkr4q1auivKb9cwbpjKSyiLlGHC38QWZFIraCZgNdqrnjgztaiT
         /6L/T+ydUAW/87h2AaQH9JTQ/iUAmZbp2CLiaEU3V8CM7ud4+b3Yt1sUVK0iXUzcVnmb
         m7kuJ7HDm5VOLDBDEhKRCUvItuRjawJ4Wk80MGFIoLVIHpFZyT+dpMZb6xadltvDT79z
         9q4BWHFaFaAbb19TKPukocAjadPB6Dhcz6wZ3gxO1bX91dPtnfDBb1kbXIZIPVFSsnhv
         2L8WQV6dMl80jJz7MwEwMVps/kz6fGDW3IH9i1CfLD7xIUhDltBUlXdsJt8gfW8X/t6X
         yiMw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZZ2QAqLzXcUG/Lf/rxdkE83CQwgDy8EEiX7eFfY60ggu/8I8opUobOErWM2/ypiCaVappQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMGgj3MlrMoAZAANYkdwe1DKjHkBXWbZDWq2JbHwkEY6bgiF7Z
	OXq+HqlTr5jPhwboZJV8BT6SX+kQ4V4KTI3gPH4+gqaPW8DPQEx457Ipxmzqadbbumvt2Q/V2su
	RzVQpX3mK6er36ZPzN2wCuifRYJl1oZI=
X-Gm-Gg: ATEYQzzycnMOCRgUyy9TMjS/qHLGzYGvyYr//UkBkEUg/FhAWV2iRcDbXF+tfToJsaq
	9HUFbm+ft82Os+lqKdJWxN3TGXCicGRSFGebc6zK7WlkS8N6fKxRagJc4RqoewFCJxKl63R9xN6
	45+upFiwCRW0KWnAWQ/MMoYyxwR7ZIUqpfMsmeMgmoplswOGT5kKdHofKMntAGcdtammp39q3R5
	Y3bvRE44RsCnLb6tswuZKgI3OxyjKjjA1Jcykte6Ym9LvKVcsZ09OkJJ0OdwSPD2DLcXNd9uI8d
	op/nJrpQrEzgeFJ/CJKL0VtLDFKoKghvQXGVGOmxESGBN7E3NpxbIcWsapvvmUOLhRYgQgoDpYI
	cIRuQetE=
X-Received: by 2002:a17:907:786:b0:b97:3bbe:e42b with SMTP id
 a640c23a62f3a-b9c13b0a2bfmr237863466b.28.1775049955607; Wed, 01 Apr 2026
 06:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260327124211eucas1p10425a28f67736d2043e7e4dd77d58e72@eucas1p1.samsung.com>
 <20260327124156.24820-1-mikhail.v.gavrilov@gmail.com> <6270d4f0-85e4-496d-8db4-87ccb791ca4d@samsung.com>
 <c9ded35b-fc10-47d8-bfaa-cecb4fa91add@arm.com>
In-Reply-To: <c9ded35b-fc10-47d8-bfaa-cecb4fa91add@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Apr 2026 16:25:19 +0300
X-Gm-Features: AQROBzDDLArf0c-hToXUOK8do2aJGAPhYCPRDaClvBGUScWSaymi-rt5o9xqIis
Message-ID: <CAHp75VdrGk=foAzQBJNRNDZ1yfFY8p-tC_ApM8_gN4EehpmN_Q@mail.gmail.com>
Subject: Re: [PATCH v2] dma-debug: suppress cacheline overlap warning when
 arch has no DMA alignment requirement
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-mm@kvack.org, 
	harry@kernel.org, vbabka@kernel.org, akpm@linux-foundation.org, 
	stern@rowland.harvard.edu, linux@roeck-us.net, hch@lst.de, 
	Jeff.kirsher@gmail.com, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:11=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
> On 2026-03-30 8:44 am, Marek Szyprowski wrote:
> > On 27.03.2026 13:41, Mikhail Gavrilov wrote:

...

> TBH I'd be inclined to have CONFIG_DMA_DEBUG raise ARCH_DMA_MINALIGN as
> appropriate such that genuine false-positives can't happen, rather than
> effectively defeat the whole check,

I dunno if you read v1 thread, where I proposed to unroll the check
and use pr_debug_once() for the cases which we expect not to panic,
but would be good to have a track of.


--=20
With Best Regards,
Andy Shevchenko
