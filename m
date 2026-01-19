Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D63803C2
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838155; cv=pass; b=T9siGH9D+LTl9kSUJKOjlBWo/MuXi2W80i1rQdZyEsfS7zJY214cTxHE8NPhR/MAS+PGQ9l70fqhATQlgN5GlHjG6h3aD5dCGPTc2MmwWALLCbZTDbqmA2XJV7C/pseeeynm6co2UCOQRTVkNXDB1g38fQZdHX7Zwx7ykmzjA5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838155; c=relaxed/simple;
	bh=oerooPL/kgCTBDoz7+mJmsEkb926v0K+H8Qy8IVf610=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuMguS54xbsljQb3trs9Y88U2ZKhGwRJDeG1JUQCTPV0mFE5R9PFo1X6G/xJDpeZjWtsHBBUGt/bBMX9IG9uiLkubhX0G7eOuVbMQNDW6/XAkXoZJF+pVOKegqRsrW01UF+kGsu7wimJQKWqDkwFx37mHY8kORAZhemzTXHGGVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w92tSb/l; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w92tSb/l"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-501511aa012so20791cf.0
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 07:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768838153; cv=none;
        d=google.com; s=arc-20240605;
        b=XVMpFtaXcOJ473JSbKQ+G0lcMTevpFq5oGF6RTJPvFmVNHp1kdnAySaBijWf+seMil
         sYtTWxtBOm4Et9jYuW6mbc3tu6RfarFfqi7uQtzeyQUVxGedhsTHDnX4qq4fipQ769ZQ
         cgp1+uki6A+4Yob0wg1RPh9uovM4jFfvi8Ys4s35IQHmJTVymguC0hqgfXllOQBlakup
         e5qtqwO1s9lAd20lIUmRSCNqbFHWfk8OcYSoBbJ4qNoljILH2fFfqQ4thRYPkhev7VqJ
         mFLJ0cjNX77nDLGZqfCUj9sKHxi1vMn44J3czEyK5FKs2AsBGLVymMcIInCoBWzQ64Iv
         IEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+CVQOz4f4pv4FZJxEWXVriYAxqFNoe7HY/c+6oYXd4=;
        fh=lNKEI/RzlUpFA2Xk6saK9qZpCPIO6/ort2eXzj+xSHs=;
        b=TR/XsRZ2bxZClFxsviHpWR+txUi+LXyZFgJhSTEEuncHeq0X6CWjArvI0jxecG77wC
         WADozPIHVlZM6zokbWQQolZRcZGPD8TxJhGCvFxonmn//OTszKP6z9Bkb18kA3cCjog7
         O7Bq6w7lH6RX5HWMecHADFZRVVdTrmscpgjU7gXMsT59S5KT3/5WNQwqtxshCda4Fsio
         1oNUoHI1oJ5d99DotzpIEdTxBK9lwOtdrQWw4Wr++X0PNYSmD7SKB2RVHXNDvqilLvDp
         qKixnNj1WnUq7coKIJ8dRplwCvVbWy2Huyq0zXq79X+T0DDVJa3HhQFvdlxFgfdPpS1k
         bVJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768838153; x=1769442953; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+CVQOz4f4pv4FZJxEWXVriYAxqFNoe7HY/c+6oYXd4=;
        b=w92tSb/lvdG208ITIj8pULf+KI4D1PhocizpAMm+j/cR0bKaCqadQWKtdmL1BpwzOL
         2VmTO5UsOPc/mIgdXBupx1D9PFfFU9hHRfUTDKFVCc7/7azZlr/yBw4h50mxFcEppFJF
         KC5MeuqRPX8p8/9aJtw51dfgezvWcgM5XH/QA/wt/ieuHQaQ7aHHHqDWAGuJgRkNl9yL
         UyzGhLl4oX4jPTRe/Xw3SZ4Vt0kxWBkiGmcq6DPiuNXMpnP9uWesY7dfg4PjcCTVROrA
         v4jga3ubN7bVaCMSe8Dxld2UqecxFn0gxLiljrt/6LA2LtfZ+D33qI0L9B2KBceb6JaG
         y60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838153; x=1769442953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+CVQOz4f4pv4FZJxEWXVriYAxqFNoe7HY/c+6oYXd4=;
        b=VCRM+zEasJhUAuS/iQUqL86KE2WX9iIj9Wv8BPJYl/QrDavGQHKjR5T6sIrvYQtiVB
         eDvRAhSCJ1hphUdtIIJDj8dq1mxfzVwxPMacoHFfqeT3aeDdlpMj4VMkXLAFLqNY2/um
         h5XSoVaBz3VZ7IltRuubQ87ya61lLHC34Tq29s8vCmmMUcI3EkwjIXUehiwo6lS8OUt3
         GVcZ2CWFiq2e9vCtdxpAAhRgaJhEZUJCJZQmdcQY1pckAux9FcPN4+YnGjVxqV/sVlh5
         BEoq78752BvoMfHVuWNDHS4OPMXQytnuGYMv/BxbRFqEjHO2lHlP/fU1goqoBi9O2liL
         rI9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0EpWlf6KJqp760AEI6wQJIhT+Zquvtvf1Fc0JjQ61abirmBaswqg4g7ubiybAUTnqkRqx/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS0qX9/V90czZwXxyVCu2jOJze6fhIP0B7sO+U4gZTAUpxYd/c
	BV6fI6kzKj6xjXSvjfBY6O/QHrXGu7436OzDqayGk8SQpALpBXDl+VYmaQ0Gzbb+Of8xVD3sq0G
	fM28/XAsgQotbsXUFxgSxFr+gT5b37a91GDKu85/G
X-Gm-Gg: AY/fxX5ip6psYpsC5qXFWkPIeB2VRkYMuiCG1hS1nPgC/XeUnRqgKKvDsAI4rI5JqpZ
	X13naymSXfQNOPzJ70yOWZ3hxsmBtihT5E4ytGdu+ZeCHNwcdHw9lAsuG+u4keSInGJCpkX7rQx
	Q9vqy21NG8pwPGosjsZ3GjLxbWBTRjbwiioPdRaMRuDe+1uTCwqQVWXh6kEdNlyOFB+YfIy7D0U
	tRymSnODW/5i2pK/4FDjYXCesCqNjyTWSwl6k86ccjxnyN1+hJsNzTyPg8C7BmHBE+Fuu4=
X-Received: by 2002:ac8:57cc:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-502afaa0b9emr21378741cf.8.1768838152806; Mon, 19 Jan 2026
 07:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260119142246.3821052-1-smostafa@google.com> <20260119142246.3821052-2-smostafa@google.com>
 <qu5oksvcaytolppeeale6rwf4bzvckvfdg3iw77kowrg4fn24a@p4hmieukkttu>
In-Reply-To: <qu5oksvcaytolppeeale6rwf4bzvckvfdg3iw77kowrg4fn24a@p4hmieukkttu>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 19 Jan 2026 15:55:41 +0000
X-Gm-Features: AZwV_Qiw2HdJaRcL1F81HFaiwCNZCPdmUTScO3KLcBRCPXV-fWTgDvtVV_i5AzY
Message-ID: <CAFgf54pFzyAj5MKBx8xcuME-BGGWS1ZZLkw5vSgN8sGPftq88A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/page_ext: Add page_ext_get_phys()
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:49=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Mon, Jan 19, 2026 at 02:22:45PM +0000, Mostafa Saleh wrote:
> > +static inline struct page_ext *page_ext_get_phys(phys_addr_t phys)
>
> The name is misleading as it indicates that the function returns a physic=
al
> address. Maybe name it page_ext_from_phys()?

I will update it.

>
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline void page_ext_put(struct page_ext *page_ext)
> >  {
> >  }
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 297e4cd8ce90..5fe65a0ac4f3 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -538,6 +538,29 @@ struct page_ext *page_ext_get(const struct page *p=
age)
> >       return page_ext;
> >  }
> >
> > +/**
> > + * page_ext_get_phys() - Get the page_ext structure for a physical add=
ress.
> > + * @phys: The physical address to query.
> > + *
> > + * This function safely gets the `struct page_ext` associated with a g=
iven
> > + * physical address. It performs validation to ensure the address corr=
esponds
> > + * to a valid, online struct page before attempting to access it.
> > + * It should return NULL for (MMIO, ZONE_DEVICE, holes, offline memory=
)
>
> It should?
>

Yes, I can make it more definitive as "it returns"

Thanks,
Mostafa

> -Joerg
