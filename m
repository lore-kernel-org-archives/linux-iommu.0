Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E542048
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738832; cv=none; b=OJWYpNV2RD+zKM1PlTqJhEuwCOAUQYZcBfOY5HnYxHHMqqWt34upE0UEUf0tlDf/INLaiREYQuShRUKXd9NvIZ1XRdQs9KnmC3hhKvJqVhDVgtdlzUt1YwVi0Bpl1etNAZydVUkF0aA6/LqoBmwDBD1VMUn0w7FQodZttz5IcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738832; c=relaxed/simple;
	bh=tUgqPwi+mnLgh3m52Kj7rKza4u0MGRXoQihTgo/Cg0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALjVyN/fSHi9mayJ9WZWLuxDjAPInqcwqTFa1Xg5ccNf8vkSJtWgDSMs068Vpc18NW65XvAD3TzFCbEnCfX4dx9if+87ro0THUsYyEotMWKp8B5kPruoZaKJpFJBfDUvwTc3NyZ3tRxGM3weupREgjwfwEGBCUFE+ICkOy9xu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUNpHIpP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUNpHIpP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso2515ad.1
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779738831; x=1780343631; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wnz7hVVsDiAyrQ4cJdC+k5tS7r3C13ynOdjjWKu+xog=;
        b=NUNpHIpPtfPueXwl/lYEJsPD7JgsGsDpzy5l1jYjg6rjF44Rf+P+Ya+5po/35ZzPTT
         zA+6SvpVBsqXm6JH/e0BPuahMTaA4tcYQ8Fl/FiVuPISQeFO74Ujr9T2t1nzISarrW3y
         H2hpCF6Ecw5EB+OH1ZKfeknvwHHnqM027AsHByt1OxMBmC9QDnUFoCm/liIFiamxBtJN
         yryYWChS1Qu77ffRGcA6xXC3TJGXeO3cNKV2qdGyc6g4gX/8tx3+MYzCsKRFZC3WIPrM
         5iMKURuIRL2nMao29miYRX1p33cEfqga/CIO1W3ZYC1VvWkaspsduE8QpB3mmjBhWuoa
         zT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738831; x=1780343631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnz7hVVsDiAyrQ4cJdC+k5tS7r3C13ynOdjjWKu+xog=;
        b=bTCGN56WXjCJ4j2/R7dcnwnnNZnnRn69MfH8flslEXJYzdjEGOA9/HlLtKhuDy+GHH
         fjfrSXg903BB/iFudCv5Ji5z87qVuHfE6ft5PIZOfqWOQohbpdvX6pNXLTYpSSlB4BXW
         yVpO6QBFGqf9+7fv9nOTTOIPszr/RUHXmSG/Cg9A2FTJa8hmLuMsIBrW+gTQv5D7Mu7V
         hL9CZEg1W4Z8DwHOMxeKxrBVmkmSYVwFr38A8d0XEdgASjAJgi4NODeg7J7F4irrb0TD
         5TVKp7Y/gCZFToexOoVoELWONkJ5hdQN4s/gu1fB/DU3mtx9OvtMvzl/tpUKGcBjxsaH
         vQCw==
X-Gm-Message-State: AOJu0Ywf2AlNg1NkSlOL0qeoIaTJXnL+sOrRJAVS5poWM6cu7QdH1bdw
	NQwLHQX98AJp/HZbm+zFOfmRw2mIJJ5SfTwedaQursBnkHzMadwyropHg+5eHXwJZg==
X-Gm-Gg: Acq92OEEUlIYo8qxidwxa6rfZ2QJx78SYGl1fylkVNUt1Er4iYiqyaOoUh7EJgbNteT
	WnmiBhsEfD1cGRBoSLuR1oyNCf4LTkw8oyvfA7kyTWtquBg8mW0dAMT+kRj/YTt3jblZW6j4Lt5
	PMjX+CwX1UxPklsQsoMo0AEV/2uwzds55QEqvuSkBRuq6CSrNDOBBSqAkOaSBXVl4K3szoqfOuU
	0IKYKzIde7byheTElvhXn0Q3rS/dxLwjPxMoFRDWoW4l40fmrxOTGD4Z3sGkA6RPEvMzs4BSQdG
	6Cd995V981q9MNhrbxbxNnhYMZEK/8BivPr6Jp6mmDirmiuyfAoJs51AHH3eo6UZ9v7nmLt0gvG
	yNK7XNjDNsWKXyX6zVIzgrQwGHoZzCjsWtZWkY277MPyNxSSKaj7Peq1gacttp7KxCvTiUnj2HK
	BGHM1ZoLSJMqlW5tGqmIGqKfpOvYC+YOzlREec7rg6g0X/Qty/DmLfON0qKcCwcTSBi3NV
X-Received: by 2002:a17:903:1252:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2bebea02de3mr4008845ad.10.1779738830555;
        Mon, 25 May 2026 12:53:50 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fe3c9bsm9897001b3a.52.2026.05.25.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:53:49 -0700 (PDT)
Date: Mon, 25 May 2026 19:53:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahSoyIh_QFvDCor5@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-11-praan@google.com>
 <CAE2F3rApNZbpxhRSKircaERMDUUtBOhjTjUSahcpV7Z6Cy8oEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rApNZbpxhRSKircaERMDUUtBOhjTjUSahcpV7Z6Cy8oEQ@mail.gmail.com>

On Tue, May 19, 2026 at 11:31:58AM -0700, Daniel Mentz wrote:
> On Tue, Apr 14, 2026 at 12:47 PM Pranjal Shrivastava <praan@google.com> wrote:
> >  /* IO_PGTABLE API */
> > @@ -2823,7 +2883,16 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
> >
> >                 if (cmds.num &&
> >                     (next == end || arm_smmu_invs_end_batch(cur, next))) {
> > -                       arm_smmu_cmdq_batch_submit(smmu, &cmds);
> > +                       bool active = arm_smmu_rpm_get_if_active(smmu);
> > +
> > +                       if (arm_smmu_inv_is_ats(cur))
> > +                               WARN_ON_ONCE(!active);
> > +
> > +                       if (active) {
> > +                               arm_smmu_cmdq_batch_submit(smmu, &cmds);
> > +                               arm_smmu_rpm_put(smmu);
> > +                       }
> > +                       /* Drop this batch to ensure the next one's fresh */
> >                         cmds.num = 0;
> >                 }
> >                 cur = next;
> 
> Correct me if I'm wrong, but I don't think this is safe.
> 
> Let's say arm_smmu_is_active() returns true and
> pm_runtime_get_if_active() returns 0 because dev->power.runtime_status
> != RPM_ACTIVE. In this situation, is it safe to skip
> arm_smmu_cmdq_batch_submit()? I think the answer is no.
> 
> My understanding is that it is only safe to elide invalidations when
> SMMUEN in SMMU_CR0 is cleared. Imagine runtime_status is
> RPM_SUSPENDING. pm_runtime_get_if_active() returns 0, we elide
> invalidations despite SMMU still being enabled.
> 
> I think that to decide whether to elide invalidations, we should
> exclusively rely on the Q_STOP test in arm_smmu_cmdq_issue_cmdlist(),
> not on the RPM framework.

Hmm.. the Q_STOP flag indicates the SMMUEN state 1:1.

Alright, I'll drop reliance on get_if_active everywhere and simply elide
based on Q_STOP. Even if we race with suspend/resume we should be safe
in that case because of the Q_STOP checks within the issue_cmdlist
(point of commitment).

Thanks,
Praan
