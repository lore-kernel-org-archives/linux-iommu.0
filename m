Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08B33EB02
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639306; cv=none; b=WItD2DzAHCWzx3Xd72+iEvLk99NpuZBIHioLvUTbpHxHbqzM0SNK4wqWLssNOOF0qJYfYvp+WRwBHDI+lSNHhF9gXQkp+i6jGJvfwzgt1ZBn+Z9666OtoIU2tFqqsv2acgZO7MCfUnbCWV07afeSIvnCyUb+SXduFxdxJ0x+NzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639306; c=relaxed/simple;
	bh=8N6sbBAWid/ZYJztu1ECpBF8QM5YL+5wF3MbJNf6KgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZOaNvsRh50kn5y2e7Cf6jbGBQhb/AmYAB7gFxmNfzqGxQUl64TKTBvZ4NXS6UYfWch8k0lLaORPX1IH5tetcQOUNGkYQkqDCgtBLkp3j/QAFyDyQoibgqOw74s8C37Y6V8XEF+VrBLMyZ8JxJk1qq4fkRW3LDV9jbWhDp/Pl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VdA6SsPo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdA6SsPo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so286937b3a.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767639304; x=1768244104; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DpxS8rpJviMrwQBnUs6BNFBrH4xHFjBHXZzxcPZ11E=;
        b=VdA6SsPoHIRZqPlllxXoESNdOb2aw8SF23xeeR4KeOK0B9rYQtvIxLoP4pzVi4QVL/
         Cw8jYCB0NkYrBnZEu655/578aLI3PA/2RmIcp0d0KW3GkJ2ZIXScFYWNMMz1e+KfrpsQ
         yzBDbJtSmospRL1KuAgYIpiEQEC7qTUADODTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639304; x=1768244104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DpxS8rpJviMrwQBnUs6BNFBrH4xHFjBHXZzxcPZ11E=;
        b=Xlb6TtarIHOGgfL5dAS/57j4wi8rPuov0qSnXUVHsVUO1BtQiB7Wogz+182tlqJpjm
         18LB68blZyr5rDIwCtUQ2lPoN0sCPehz4JabussC2IHx5glKt5eSL2Wx+aqzEuGkSCxK
         ZZl467tC888nlhJSJeV/zWYesEwssCwH0wCJnyyyTMVb3gVp5rv3Dl7bSpOBFYPcSVUb
         cI7rbNc2XJ7map4j7px76LgMUrj+rFswHwt8APBCl0k02AG3VMqfa8bYZRS4CdM0SHUv
         bU1QdIjeScKyO067jC7/HaQS6XFGB41eiBrk9MyYugQSMbNx4P0faqk86niml/l7IHea
         dCFA==
X-Forwarded-Encrypted: i=1; AJvYcCW2TwvbG8tW8NqaodRF41fSKq142xvnlZAusrJhe+cxdn0TDkr8o5kIf08gqE3uozu6l2o4Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmbtoId2RZdmkdQoqLz17PFo7AT4Jh4M0qaBrxt1CRfgi0TdfG
	nycKeqzSp9eoprvBhbxcUm9SHeZUCalmX3KF6zOeUet5CklbfX6FxNKJiRepP3TMlw==
X-Gm-Gg: AY/fxX49Cid4zKpdU6OIR36S32XcRtUeAF1NR/BaLwYXmi9vDLi6FLMa/PzlANOdejH
	Y4fNS23rdVHGsAK/w40Fu8xgG5idBJYAOsPRwlR0+pUJJI1w124PefAuhh8YEaaFFZHAAaKSq4P
	J6OFNTAitPkJRn/GCh/PsU7c/r8YdXvNU1zyj0/uGp7EOJv/DLixD1hi7W7ibZDLBKE/N3SPhNg
	b5LDGzd4+fc6iCqb/0JNSOijSZeLJFGdZQwR1rk8ihhZxt+yk2EtbAss8oAmA6+CXPlTL52npzB
	ZEGvltmPf4NrOx/nAJ8BMVI1r/1ZGaDOwWswpRummUn4q+oI76K90SgfoX3Mg4eiJZPjODU9elg
	XTV6RII7ObXh4ozgAY6M4ZLgXr2yuT3n8ZMPB++KunVJOcbbX3P+Bpmw7HXP+BvVZcdQisj2gkP
	AehXGvR83R
X-Google-Smtp-Source: AGHT+IGmDE0QeurRLjjRHeAoA4yBYARtAMlpXceX0Y11k7mpPzrXKm6iX0itkPmBxWioX0MmbudKnA==
X-Received: by 2002:a05:6a21:6d8f:b0:35e:7605:56a4 with SMTP id adf61e73a8af0-3898237c8b5mr235964637.51.1767639303711;
        Mon, 05 Jan 2026 10:55:03 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:1194:8740:be25:ee08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8afba8sm68540a91.13.2026.01.05.10.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:55:03 -0800 (PST)
Date: Mon, 5 Jan 2026 19:54:53 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <aVwI_SHHGPl0xndu@google.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105181200.GH125261@ziepe.ca>

On Mon, Jan 05, 2026 at 02:12:00PM -0400, Jason Gunthorpe wrote:
> On Sat, Dec 27, 2025 at 06:57:23PM +0100, Dmytro Maluka wrote:
> > As discussed in [1], we don't currently prevent the compiler from
> > reordering memory writes when updating context entries, which is
> > potentially dangerous, as it may cause setting the present bit (i.e.
> > enabling DMA translation for the given device) before finishing setting
> > up other bits in the context entry (and thus creating a time window when
> > a DMA from the device may result in an unpredicted behavior).
> > 
> > Fix this in the same way as how this is already addressed for PASID
> > entries, i.e. by using READ_ONCE/WRITE_ONCE in the helpers used for
> > setting individual bits in context entries, so that memory writes done
> > by those helpers are ordered in relation to each other (plus, prevent
> > load/store tearing and so on).
> > 
> > While at it, similarly paranoidally fix updating root entries as well:
> > use WRITE_ONCE to make sure that the present bit is set atomically
> > together with the context table address bits, not before them.
> 
> The PASID entries should not be manipulated 'livel' in a haphazard way
> like this in the first place!
> 
> Like AMD and ARM build the new PASID entry on the stack and then it
> should be copied to the DMA'able memory in a way that is consistent
> with the HW's atomicity granual, paying attention not to 'tear' it.

As I understand, the "consistent with the HW's atomicity granual, paying
attention not to 'tear' it" part is already fulfilled for PASID entries
(and with this series, for context entries as well):

static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
{
	u64 old;

	old = READ_ONCE(*ptr);
	WRITE_ONCE(*ptr, (old & ~mask) | bits);
}

I've been assuming it's ok to manipulate other bits in place as long as
we take care to only do that while the present bit it cleared (i.e.
while the entry is ignored by hardware)?

So IIUC the only problem with this approach is the redundancy: we do
this READ_ONCE+WRITE_ONCE for each invididual field in a PASID entry.

So while I agree it would be more more natural to build whole entries,
and the existing way looks strange and not the most efficient, I'm
wondering if it is causing any actual correctness issues (apart from
those addressed by this series).

> This manipulate-in-place is just asking for trouble, and can never
> support replace or full viommu requirements.. :\
> 
> So while it is perhaps an improvement to do this work, it would be
> better to fix the root cause issue if someone has time..
> 
> Jason
