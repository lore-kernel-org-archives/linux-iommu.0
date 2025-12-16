Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE933F8CC
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925413; cv=pass; b=qW/nsPbEzjC0f3VYgrQqwz4Hcqatssn9nk7CvtwhNATpoft/FiyQ+YgoStAuQUzpLQCH2YUZbBy2m2eM/7EWQAdfxwXSbQbloGxANSyRqs/1zjzy78OC6yJA9kmhECj6cOAKmeh6UhqFTrjIFdxs9yqmYeSfsj5SoLcB7ymaCLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925413; c=relaxed/simple;
	bh=260Gx93PQtFFvgFubBx8Mp5L6uwwDH+dbANf4PLO6kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ0nFew/xJKCFZpF3h+86T3s0U5o5mPo5Wc+omiD7D4naI0ZUBGw3Psw78FkN011P8Sp0iKhQczl1zTZrcNtB/X4+Ej8J/Se7dzMm9s2wL2rO4b/utDCmUbQmDoA3qMHmZFxMcmZGJ1OgcGDMku/JcH8b+g13xY8phim+N4L4bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyIM5b9a; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyIM5b9a"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee147baf7bso88081cf.1
        for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 14:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765925409; cv=none;
        d=google.com; s=arc-20240605;
        b=lRtghfWr6nKsuRyXxiHmIZrRVSuXF2hOvNJsLG0k9vYUSeVtoeIm+z/agAPhiWu3jL
         SGv75Fd8nIw/deF2HeNC6CB3ZpB2q5qieDGPlHk9cdzYIeV8dXA9klp0sWW4uprJoBss
         0xCDJVsfLOBtKK49WXTfEbq2okEm3V+qEOIxFKFR6j3w7fBz+iNvGdu5JaWbnnmgL4TU
         WTsuolPlqVtPdU3aySiPoczZdajOXePXO8qRrVPxrLCLUJUvhy6pyKTdtoIl+r3yBeRz
         5Pvkqx7A1VExAOv8iprLqi2QcHTKrJlJY9aF2OCORJhssmsg9lbQFVnA1YlvRumGT6bc
         ISrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62+SRIZ98WwwWs2kgA6doBGmZ5Cs8CyuW9dLlAZbi6s=;
        fh=mZIDOMO0MwIEFXcXtxUPUqVylCMlQekG1Zhwg2P+08Q=;
        b=j1rDHFK5XnmCfJeTa3AA+xeLxvc90BaagP6S+GrntBox3rUMiLBIHhRSLhaYFOzvG/
         DTpm+1XYw6OGgCDf+vhUx11yLfOjilajp2OfqmQ53Ibsx8TdW9OG+Me5OpbiKNecaH2Z
         09GrDEUBP61KwQUdKBlNE645W83BtJOiEy03QJGhyP3vigzUsfKPFYsAzDEx+FFZHuZQ
         YRltCBKb/vYi/DV9waGhmzN9rLxncvN+LkkaJcljEd/JJTDWoP6lZscxkq6pJiDTD1Tf
         6vToFrV0h9KFXjzcZc2IW9xsKbN2MQs4Buz0YatSw/Uibol84GDfS8zb3tGzRgtZ/Ktm
         XkUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765925409; x=1766530209; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62+SRIZ98WwwWs2kgA6doBGmZ5Cs8CyuW9dLlAZbi6s=;
        b=OyIM5b9atX0tBvsLQ5CXVr7H583tqGF+pW2ADINpbXe3rfOr0OPIYuu83yLPFCQfkC
         2g55CP+ExUTNJFlNfiU84JfVLznwhGI2Q2rHppVTTaFlmQrHeRhxvapNXl3syZzQC5H1
         PVuPBA36IUwggyigR/tmRfqm+FDpbjCibh6Mxr/vX+NGwdXJGwIXpUgGJRtOXgwHoNkN
         QQ+v0ksSlOQEcq/FHDSSza8FQWeZXXDuXPYTDzdxIIz6H5WnrXqchp2Ff6IhbefN4Y5l
         E5PYzHnohOsKkRFDaTKKHYrsCQQ8REBrJjYQfGgqIn9QSWUqOw2T1WEnnFB0Cd+H1WRk
         9zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925409; x=1766530209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62+SRIZ98WwwWs2kgA6doBGmZ5Cs8CyuW9dLlAZbi6s=;
        b=cF57woqYmwYSKJ8vwZOu1Wjpvqk+pEnVuZBKZV27Gsn4rQp5Vs62Bav/hChdkdgZcp
         LKVYzLNfB4/GOhYaGQVzmG0V+WnEwYATgtNp60hcujPyabvxdtI6bdFBfEwGOsdFMjjh
         axZnor7pWeBPBn+N2EvxL61iYZKVQjgrzRrih0uOiLrmvMvN4xhA7Vb1CWFCsjtI4XdP
         gGdmGx2Q1vtO2HnME8T/yqE51YbzY6Bbu4oq5UdY8Qd5f1przhJPGW1Zug9VN4geyLBp
         ZrGK2fOu/0vlfOh9/uRA2Z9s2exZf4yh1b+nu/MoACA+x9s58xieXb/H0NclkURmGSm7
         ZHtw==
X-Forwarded-Encrypted: i=1; AJvYcCWksEmkT/hQukvIRu+335rspzWYZH7vH3FlLQ2bacHia16qp/BjcrDnpdX5xS1M8BgGVM5tRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQIkedavhoKgtNOpNG0yDWSOylfOgnCyW7wnfHaUpKAa5SjCwi
	tLHrpFP/RbHTmpsQZZsWk4Ktv59EqSR1ciQLvvwC2ctO3felmWop1KZMq1TAiKBzm8a/n5QXn9d
	4jZ0NV/5VfuuPUwgP1LMHQaOy3Vr8bYiIVSs9c0cW
X-Gm-Gg: AY/fxX4yuj3yefcOqoahEQhSswzk7bd8636mtlpUg9olec0hB7a7+HtURksu1qEiaqm
	R1GQJy0yRO7m0nfbW6YQveEKCKXmeqPH2ndsFJzSdb2FmIBp6SCGnVTs0rk0lGurZ3mB/Mh0g63
	bC1QqDxitSt2F2AjZR/50J4ADHzeEERNALxOwj4BviJR5AzEWVPMWNj3MroVA/EeScfW1BayMAK
	xh8Hev8s2unwvpYTPelhhP6guzhFAu3uiAV3YimIi83vA/E7snFAooz1kaGhMlkqa1I0yliuEQ2
	Yg8o/G3p6g52DC+klLi0p3h1PhXOOg==
X-Google-Smtp-Source: AGHT+IHRovgVdEdoTpfJBQNPndiAvLg4h0XYlICvrVg++0Z98jb8QPhOp+hOCQlqL17fWZvobnxYO4M8LzufWJx4ZGI=
X-Received: by 2002:ac8:5808:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-4f3546d6609mr1208081cf.19.1765925409187; Tue, 16 Dec 2025
 14:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1765334526.git.nicolinc@nvidia.com> <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com> <aUB0t4MSf624Wwmw@Asurada-Nvidia>
In-Reply-To: <aUB0t4MSf624Wwmw@Asurada-Nvidia>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 16 Dec 2025 22:49:58 +0000
X-Gm-Features: AQt7F2oAVNd4BF3J14ZyQBuIyHCibuWRhpjMatdY8mcWa6Ix5db5Jg_y5HhSJH8
Message-ID: <CAFgf54pDfBhx8j0M0JJfJR8kDwqOyPem7W1E8kpmBur5q2pjxQ@mail.gmail.com>
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com, praan@google.com, 
	xueshuai@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 8:51=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> Hi Mostafa,
>
> On Sun, Dec 14, 2025 at 10:32:35PM +0000, Mostafa Saleh wrote:
> > On Tue, Dec 09, 2025 at 06:45:16PM -0800, Nicolin Chen wrote:
> > > @@ -1207,12 +1223,9 @@ void arm_smmu_write_entry(struct arm_smmu_entr=
y_writer *writer, __le64 *entry,
> > >             entry_set(writer, entry, target, 0, 1);
> > >     } else {
> > >             /*
> > > -            * No inuse bit changed. Sanity check that all unused bit=
s are 0
> > > -            * in the entry. The target was already sanity checked by
> > > -            * compute_qword_diff().
> > > +            * No inuse bit changed, though ignored bits may have cha=
nged.
> > >              */
> > > -           WARN_ON_ONCE(
> > > -                   entry_set(writer, entry, target, 0, NUM_ENTRY_QWO=
RDS));
> > > +           entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
> >
> > After this change, no other caller uses the entry_set() return value, s=
o it
> > can be changed to return void.
>
> OK.
>
> > >     }
> > >  }
> > >  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
> > > @@ -1543,6 +1556,7 @@ static void arm_smmu_ste_writer_sync_entry(stru=
ct arm_smmu_entry_writer *writer)
> > >  static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_op=
s =3D {
> > >     .sync =3D arm_smmu_ste_writer_sync_entry,
> > >     .get_used =3D arm_smmu_get_ste_used,
> > > +   .get_ignored =3D arm_smmu_get_ste_ignored,
> > >  };
> > >
> >
> > I have some mixed feelings about this, having get_used(), then get_igno=
red()
> > with the same bits set seems confusing to me, specially the get_ignored=
()
> > loops back to update cur_used, which is set from get_used()
> >
> > My initial though was just to remove this bit from get_used() + some ch=
anges
> > to checks setting bits that are not used would be enough, and the seman=
tics
> > of get_used() can be something as:
> > =E2=80=9CReturn bits used by the updated translation regime that MUST b=
e observed
> > atomically=E2=80=9D and in that case we can ignore things as MEV as it =
doesn=E2=80=99t
> > impact the translation.
> >
> > However, this approach makes it a bit explicit which bits are ignored, =
if we
> > keep this logic, I think changing the name of get_ignored() might help,=
 to
> > something as "get_allowed_break()" or "get_update_safe()"?
>
> I think "ignored" itself is brief and understandable.. Instead,
> perhaps we can add a kdocs to make it clearer:
>
> /**
>  * struct arm_smmu_entry_writer_ops - STE/CD entry writer operations
>  * @get_used: Output to @used the bits used by the hardware corresponding=
 to the
>  *            configurations bits set in a given @entry
>  * @get_ignored: Output to @ignored the bits that are listed in the "used=
" list
>  *               but allowed to be ignored by arm_smmu_entry_qword_diff()=
. Each
>  *               field (bits) must provide a reason to justify that the e=
ntries
>  *               can be updated safely without breaking STE/CD configurat=
ions.
>  * @sync: Operation to synchronize the updated STE/CD entries in the memo=
ry
>  */
> struct arm_smmu_entry_writer_ops {
>         void (*get_used)(const __le64 *entry, __le64 *used);
>         void (*get_ignored)(__le64 *ignored);
>         void (*sync)(struct arm_smmu_entry_writer *writer);
> };
>
> ?
>

A comment is indeed helpful, but my point was that "used" and
"ignored" make it seem that they are mutually exclusive.

Thanks,
Mostafa

> Thanks
> Nicolin
