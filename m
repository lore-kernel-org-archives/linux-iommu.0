Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D76340DB2
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643551; cv=none; b=dHcu4RGE2d+hAwaO+uK75MJlZdfPGFzzbHFPxQPjjTccMe9WRUGC73xJ79RIz78EdMNmal6+OYrNL70cUvksHYxut5mVdMxfKEFzwXeo7uSzHEJN5FK3DHXXKVXkkUE4U3XYilGcJHGDw34G1AY6KBtNOltxYJwcyhNK3oNlPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643551; c=relaxed/simple;
	bh=8onnp3FD4r4gnlk8NIzgK2RDbreeCwfl2l8x2h8gxzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o05TijRqPkc6gYFZnT3/oWnKY0BQ4aDNlgmOB9CTHAGUGC5H1j1ZfTJ7LV+FFVKcUiFHWJ2bJyl/TN9znVL4EqpFMJ4bkEnjY3apimrFpHdg/xsD8ipmoJVNBGW0M534PJtXKy2+xyJhbHleU3p1V/H2ZiFmsSD+qVUn4memlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fMNoLnnX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMNoLnnX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so512109a12.0
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767643544; x=1768248344; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ew672O/Nts/+UtFO3wzfg5UyDse9xguRdTmeMwK7afk=;
        b=fMNoLnnXVBxTwckDUdax5YjUn6vesZhfJlUnjO7iJcI9igAyCY7KCfyjyWHPjQ6aoE
         gEDhtobxAUiKFkYdR3WTlAWswNMZga/ntzhL4WBkwiR52fqremfwboSoZafeq7IIx5LB
         pi1O5mxggrpkcugvByl/Vhe1Df4ephbIxlevA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767643544; x=1768248344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew672O/Nts/+UtFO3wzfg5UyDse9xguRdTmeMwK7afk=;
        b=ZDaQgLcCPRVh3Y63XoI7cWRqWAcyg9sZ90nkohxqWv8OfVQ6GxfFDfnPp6iBe+MyFd
         bParyy9Ke/cPI+dzAxjSZEkTISf0msV4ObcgMVEBmuSv90MjXX7U134gVr6OMj++CLOD
         yMhxqTsQujawZwWJ+zerLGvM8NXmuZrBoO4zb57JM1rlrlHIyE43atID6qydRwNEfTP3
         Z61qI8u66eUPmWKrdPBl2bRrDt9z3c4KDM7CLXUapatHDnPDW8dL3FKsQTHxRHSVFPo7
         pIgiAP/W4hri6sykuPsApgvZoC/E+uzxpzjA7MHPctwXujXNF6WoClMIsJ1/wJqW2tWQ
         L5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcvPDLHjjm7AClC3r4i1lPmZnG9NOnNPc5ooiLhrPABlPhosEdj5rj8Nn4sT+z9Xjj4mpwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YygIeYHGKnhl8oAcSVpg4lLRJRb66dOcVeoDiXjFpU622p8rhj1
	VdHSGjkB1clyWXjJDnAHjaYGV7ZoInv6q1LimhWOdPUiEZR8sbo5B+mpp4W1LpYhgA==
X-Gm-Gg: AY/fxX5SnwRSyNWH/aK6gmzTWl2DoHjahJSXJ3IyVtsdFvCsEtB84w+ksmfzKT0C9zw
	6gf8jnghkiBk8b/4UXyfVlHW06ZQggQZrOIuNBVuQ2Xro0p4gygP5BVcP2bCUIoR3tlx2hir27K
	i/DICvwI9N+/cH0ONaX364QU+fd1uB9afp8Udya//OXo/ovKVjC1XtQeL4kPKGyFU8N4DAeF0c8
	fcn9kDo96oYgkcy8+GLkanm2ORxnqln4q6VgOPh2ResL+kyj9wNbdzpMPmcQr579jhJiIUD26fV
	CLb16suWQRYWgL46VNJHUdDGWQnpoF/0hNP3lyGfggc/foPeiiCDrK7CsmcJuvtgW6JiUIurM1Z
	5UeJmjgLhxTTLKDbgfH13rGdUEAUhMnzOYJ0D9meS8mjbqmNlOPEZp/mVkSi+Rt5QdBi6EvxIHF
	83dtyVuws1
X-Google-Smtp-Source: AGHT+IFnoPKyqXFFa+aZwlgF/IhySxChhcDm/NAxdw2bW0ctWFC4XdEoMeB5iCV0Qzqx6MBgcjekTw==
X-Received: by 2002:a05:6402:40d1:b0:64b:5c4e:e695 with SMTP id 4fb4d7f45d1cf-650797a069bmr507356a12.29.1767643543910;
        Mon, 05 Jan 2026 12:05:43 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:1194:8740:be25:ee08])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf66214sm304743a12.27.2026.01.05.12.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 12:05:43 -0800 (PST)
Date: Mon, 5 Jan 2026 21:05:36 +0100
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
Message-ID: <aVwZkFQ-iQ7OHMi2@google.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105191410.GJ125261@ziepe.ca>

On Mon, Jan 05, 2026 at 03:14:10PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 05, 2026 at 07:54:53PM +0100, Dmytro Maluka wrote:
> > > Like AMD and ARM build the new PASID entry on the stack and then it
> > > should be copied to the DMA'able memory in a way that is consistent
> > > with the HW's atomicity granual, paying attention not to 'tear' it.
> > 
> > As I understand, the "consistent with the HW's atomicity granual, paying
> > attention not to 'tear' it" part is already fulfilled for PASID entries
> > (and with this series, for context entries as well):
> > 
> > static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
> > {
> > 	u64 old;
> > 
> > 	old = READ_ONCE(*ptr);
> > 	WRITE_ONCE(*ptr, (old & ~mask) | bits);
> > }
> > 
> > I've been assuming it's ok to manipulate other bits in place as long as
> > we take care to only do that while the present bit it cleared (i.e.
> > while the entry is ignored by hardware)?
> 
> If these are only done while non-present then the only issue is
> missing a barrier before setting present, that should be a one line
> patch, no?

Yes, a barrier, or alternatively WRITE_ONCE for any updates of entries.
The latter is how it was already done for PASID entries, before this
series (so IIUC for PASID entries there was already no issue), and my
main goal was to fix the issue for context entries as well, so I just
did it similarly.

> > So IIUC the only problem with this approach is the redundancy: we do
> > this READ_ONCE+WRITE_ONCE for each invididual field in a PASID entry.
> 
> You don't need READ_ONCE if there isn't another thread concurrently
> writing,

Good point. But it was there before this series.

> and WRITE_ONCE is pointless if the HW is promising not to
> read it due to non-present.

As long as we use a barrier. And IIUC vice versa, if we use WRITE_ONCE
for any updates, a barrier is not necessary (on x86). And WRITE_ONCE for
any updates (for PASID entries) is what was already done before this
series.

Although, perhaps even with a barrier, WRITE_ONCE is still desirable to
prevent the compiler from doing strange but legal things that involve
transiently setting and then clearing the present bit behind our back?
(Not that I'm aware of any compilers doing that, but I'm no compiler
expert.)

> > So while I agree it would be more more natural to build whole entries,
> > and the existing way looks strange and not the most efficient, I'm
> > wondering if it is causing any actual correctness issues (apart from
> > those addressed by this series).
> 
> It prevents doing the replace operation, which is a correctness issue
> for VMs.
> 
> Jason
