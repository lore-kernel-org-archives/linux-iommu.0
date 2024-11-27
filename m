Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3820012B
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740801; cv=none; b=dZZQAwfeZqvfSekBzb4OhJgdVzHMlMxH3jkhiebzg8VOxQSI9GxmObwalqhI7QilL7E3X0RsmIMvKQEBzpw+1AHjcWlOokprdlMAmhDv2JJKNICmHSK+FN+JAzYh5Pv9pdJmgU42WVDf7laBaKcHt8Zg8qEHQ82ni/3Ck1Klweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740801; c=relaxed/simple;
	bh=IuBJCWL9QjL9+h3I0iqc0WLsLCqNLqP3RR2e5Ui3iXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYYJ0QfDiXE6e7boFtOJmQhYYAl5gKoT1DCxr8hImjYpYUtJ4epxYC3qiFVTaSm6ZHkZaIPYbrrRxUNowci9vS0NXZWVwZ36lotX3IQPZM/5NDHx6r7E7QuogTbhJMpWV8mijFYwNEMfkqs+K/wpo2BZZTdb8QiylmVqUfperCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bx8FH882; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bx8FH882"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21238b669c5so15495ad.0
        for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732740799; x=1733345599; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XoEGE0REspACdPpZMbnc3EiG7K3MFbWXH7RAMyf6flQ=;
        b=bx8FH882JrYs9WFA+TD+aSQI9tBsCoUUdQjqyV2y/t+dxaXOAF0/G2nT5VvgW7jhB4
         KFSX+M+q8M69rCe8ST3NZzpu5w05qf7G7njAIhTVF1wnm+9e/EwITZwloEKRzqU9H3zY
         Bzcn2e1N8t4mXqMF3AsyKkh8TM+QvPxfnrIbod4RDhSOK/tgOmt2lbVuiZUy5wU8nJFA
         0RZ2o+eNmrS+2mru3kSMY6tjWYubGD1kQ2RR93qtNsb/fSMLjlZAdvmNDmELA+ENF4HU
         moi/QGz3aSg5J7mZ7HgtCu4qsVi9tKj1fs9ISRN7FxYDhlMSLn6axQ1gWfoEiY3Av48Y
         UxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740799; x=1733345599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoEGE0REspACdPpZMbnc3EiG7K3MFbWXH7RAMyf6flQ=;
        b=Gi2tH+zLhjD9GZM1sm8PALD7g1xHTF4BwtzHIYECgZthtitlT374DET78QhYi6ngvg
         VkK7LQFVwMRw9tQkE7uUKO82/KbEZRKiuAwTMknxwSTj5aX4srsjcYD6h7LISi/XZXEV
         VrHRO1GzzHUgOTc7aAkVJVDaf8D7kb9iLuc9QvrBJ2NG7otMHrxre4XGKYhXgUphP59E
         9PyOWKrQ43vDSf9wkLIs6jaoiTTHxpZ7N/OnyvlPFX6yWR2CfPSTmP48a5QxBiY4dvFE
         BIrjqp7LcjQbJvBhrmQ04DmGJvIoSVlamPNiokSar8tcTvBsxz6E1/NxXbVlt0aO6Ah+
         T7TA==
X-Forwarded-Encrypted: i=1; AJvYcCVXy9+AYVSPWTrt3gPLKBeqpiNGv6KMKiNI7lh5VyvgJSOlU84GObp0KZskJnnp2BU8yvvJ7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP+/9/0s98qRSFnskrpXTH9HT6Ah0a2WYXslVZWgY3wrZsBGQV
	ccYk/Nd3Z6DQENtHTgJAOZJXqHQqHUKi06SoGgtKj8X5uBboAvQflYSARfFgLW54pTYKle4hg9n
	kPQ==
X-Gm-Gg: ASbGncsxugKM9M8MBTmb5pL7JwWcb11fz/lSld8QFFaEdE7FqWzqHuwbBebFKk08jBR
	ejbDcoShaBBf3Jh3bIM2lC1srqSyu4iOpKkERDMaZbvqlvaq+uVcjllS3i4pE0Jw9NrJDgolzLf
	/rokwMfNzDS6W3GFpmOl1BS5es0RjfVkCP+eyc+Hr+qasZLlJHptfBigGfjsHKEYoVxgPU4cQzd
	/L9qJJzUURZ94cckqmaK70QX84zBS+7v5QS2lut2OMeNE7zqC4t/VNnTvJm205Dwy3oCMLsBIxp
	+QfumhRGrFY=
X-Google-Smtp-Source: AGHT+IHUPby4sBkywXwYlACjBuRklzsPV02eD7OuvJUGTbd8VAUGvrok52zca8ZzZKJHMJM+niy3BA==
X-Received: by 2002:a17:902:f745:b0:206:ae39:9f9 with SMTP id d9443c01a7336-215204c9444mr324295ad.21.1732740798711;
        Wed, 27 Nov 2024 12:53:18 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de470414sm11054394b3a.61.2024.11.27.12.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:53:18 -0800 (PST)
Date: Wed, 27 Nov 2024 20:53:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Z0eGtoLovKLBml6R@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <CAE2F3rCO1PbzMEdJB1zRFK+FsbYa0w2TWrGL-XV6y9A9vrqytA@mail.gmail.com>
 <Z0blg7wbWr05qp3w@google.com>
 <CAE2F3rA1g7+KoOAjr5CUnD14zsnmnDxmW2KSpVZmdtzoA8ggrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rA1g7+KoOAjr5CUnD14zsnmnDxmW2KSpVZmdtzoA8ggrg@mail.gmail.com>

On Wed, Nov 27, 2024 at 11:42:11AM -0800, Daniel Mentz wrote:
> On Wed, Nov 27, 2024 at 1:25 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > +       event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
> > > > +       event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
> > > > +       event->ipa = raw[3];
> > >
> > > Shouldn't this be
> > >
> > > event->ipa =FIELD_GET(EVTQ_3_IPA, raw[3]);
> >
> > No. For this, there's a reason for not using the
> > `FIELD_GET(EVTQ_3_IPA, raw[3]);`. As mentioned in the cover letter, this
> > was the root cause of the IPA truncation bug, i.e. FIELD_GET only
> > fetches the IPA field without trailing zeroes, truncating the address.
> > For e.g. IPA = 0xfffff instead of 0xfffff000 which is faulting address.
> 
> I disagree with the term truncation bug, because the information was
> never there in the first place. Truncating the IPA was presumably a
> conscious decision made by the architect. It is not a bug.
> 

I'm NOT claiming that the HW or architecture has a bug.
I meant that SW can't ONLY look at (and log) bits 51:12 only which the
`FIELD_GET(EVTQ_3_IPA, raw[3]);` does (the values I've shared in the
cover letter are actual values printed on QEMU). If we'd wanna use the
`FIELD_GET(EVTQ_3_IPA, raw[3]);` then we'd also have to shift it by 12.

The architects provided bits 51:12 as IPA since the min Translation
Granule supported by SMMUv3 is 4KB, hence the last 12-bits will be 0s.
Thus, an "IPA" or "PA" (in S1 only) *has* to have the last 12-bits as 0s
hence, I'd believe IPA = 0xFFFFF would not make sense as min TG is 4KB
and 0xFFFFF is not 4K aligned.

> >
> > Also, since the definition of the field is GENMASK_ULL(51,12) it doesn't
> > work for events like `F_STE_FETCH` where the Fetch address field is:
> > GENMASK_ULL(51,3).
> 
> Using the ipa member for FetchAddr appears to be a bit hacky. Can you
> use a union in the struct that combines ipa and fetchaddr (or
> fetch_addr), and then decode either field depending on the event id? I
> understand that no event type has both FetchAddr and IPA fields.
> 

Ack. We can use unions, but I'd still say that we can simply read raw[3]
for all addresses as the spec marks them as 0 (not RES0).

> >
> > Since the SMMUv3 spec ensures that the bitfields NOT representing an
> > address, i.e. fields other than GENMASK_ULL(51,12) or GENMASK_ULL(51,3),
> > are zeros. It's safe to read the raw[3] dword directly.
> 
> Somewhere in the Arm ARM, I found the following language:
> 
> "The RES0 description can apply to bits or fields that are read-only,
> or are write-only: For a read-only bit, RES0 indicates that the bit
> reads as 0, but software must treat the bit as UNKNOWN."
> "A bit that is RES0 in a context is reserved for possible future use
> in that context. To preserve forward compatibility, software: Must not
> rely on the bit reading as 0."
> 
> As it stands, I believe the code relies on RES0 fields reading 0 which
> would violate this rule.

The fields I'm talking about aren't marked as `RES0` in the spec. For
example, if we look at Section 7.3.4 in the spec, F_STE_FETCH
*explicitly* marks non-address fields as 0 not RES0. The same can be
noticed in sections 7.3.10, 7.3.12 - 7.3.17 & 7.3.20. Unless I missed
something that mentions that the "0" fields in event records are RES0?

Additionally, I don't think we can generalize this a lot because the
SMMUv3 spec also says stuff like: "In SMMUv3.0, FetchAddr bits [51:48]
are RES0." Now in this case, we'll have to read the IDR, figure out the
SMMU version and then accordingly mask out RES0 bits because they can be
UNKNOWN, which in my opinion would be a bit too much.

Thanks,
Praan
