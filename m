Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80F1DED5F
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924176; cv=none; b=IX7mlzvX9+oBXDTUfBQy6NWVVWkaEZuFrn5jc0aPzdMsQb+mKtaA4vcOUcj5qTaVtdZZ18movWvx2ogx9y0fBpHR5eLX7oU0tDHsl5FvilO54KziuNE0KgwnNU/ylqQ6F6Ko72+ygZeIrAOsg9gP5XTfWc6YzdvqtLbp9D/NA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924176; c=relaxed/simple;
	bh=Sr/JZJ5a5nqZ1qW6UeELtW87nb40WYfkNLJCTM59nLs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA1AaKRMI+aJXj8JK6MnXL9KR5A3jowJnemPhVX4gVTWwWltSvDb/5D9u2rkiyahUbelo8vrvYsC1pSv9HxXr5XmpmdMvP6aicR+JTghUaHDxtd3V3sPsglOaY0yGSx4cYGmcJ86pOYyCpRymu/1ngJIIwSwJ5uTDXDwDjZdc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJrPOZ/c; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJrPOZ/c"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-332559ace6eso38611041fa.1
        for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754924173; x=1755528973; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MbdwcE6qIc0EwxhkUAtAkkmZpnTQkGEmHg2AGb+L6A=;
        b=TJrPOZ/cxwCzQik1rRp8KuLjNUgk9q/mF0p4xOADZSBh+/keU21oRQqlv/tFW/TQul
         n3OHL4KSmZB/eBWbw0xTvS8CweBtM4Dc7m10J74Zf849r8JyG2BTKr3UU5H6OH5v0WKP
         X9dORVhsQExvxvxIULlK0Xs5nrt+bclFOMo0B9+4byyn6vJ5xqx/T2uR2DMjsOVB+r2w
         +mDqalfzBJdfsDlaoG5ZHR7zvM05wZayjFfiyTkt42l3IJgscQtcIY402DFbnNA5kG4o
         zDHuz8nH1HLl7yOe09l9j2oqCEocA5kHq8Oo7mImNwt9RGhjU0uG5ZvfNWd6iXCCOuzS
         Tc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924173; x=1755528973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MbdwcE6qIc0EwxhkUAtAkkmZpnTQkGEmHg2AGb+L6A=;
        b=NTVVlKnFd48kswoBFMW134jaXAXnUUq3W62N3TXXqRIjjSE/Hr1HFonCzoymwG8Rfx
         AmKM/DSByZxRGfifgFzA0nOf+ZoR+elbG06SgNlZoZsxRL04qeZ5Ory9E8k7xhbQgIPy
         dd4jSr27Eh2Z+JwJ3TYAxw+PVIEv74H+CdifHaw7MevMbi8pZoyqL/neR2xBfPmvq87/
         WUh1sSgXQGYZbMDdLLZuwRM130OTLGnI73y9oyGEItxN3l6c6DN8S3s99xS6nYJR9+0b
         FMjJUQV8D50R+V36c2DVPNcACNK3r/UJ/aupGxvdCXxbtw2UmYbASTAGq9nrvnzFZeMG
         w+MA==
X-Forwarded-Encrypted: i=1; AJvYcCXKlnhL/QUnjzKDc1WTpCxJvY6ArxwJU5Ngan/78Bku24DaYylbuy0VM6GofZgkwoJImzXodA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw84/BZgcwZwtVRZJR79z5XQfInSRKczKeQv7BTv+nAQZA0qyoc
	1CmwxmHeuwC3olEcgC3Np1ys14t+yGBXJi04UH29pe/TCptlsMzcL/bV
X-Gm-Gg: ASbGncszaQ4HmfoSoq3FWSPggx25in9CpwlopMj9SO9iuUur1fmuXcevrDOFWQdKbsI
	W0dKJkSN5b4h4fkA5YFu3uWYuGJgkcmscmKtGuzlZECcBbV4DRHDakmTWfQ1GepePDj1vTUc6BR
	KkyY139YtMMQ34GOhZTmpUY/Ui+lvXCSso+cG9QRvrHxoP+lQWR4pTCBRbxUHqpVg5Vi3pOvqbG
	wRMdTC6X6w08A7GE2+O2tTz5FRJQZjXo06WHgbrOXVWmGae1OvoRvt9iMz9SQJT+BKdp++Ej+Nw
	WmCV9KfgpxChJn28lFvMlLk8hjJ4IaKGlq1FFJiiTpZbjmaKUOUVhWtYC3pzbB4u7dz1PnAsQTv
	84vdrNmIXmqcMP6A3+FxsZCmL4HGeo8MWOTTSlaGxaNSLiITQ4w==
X-Google-Smtp-Source: AGHT+IGRHHXrSOrCUMkrwKfldelClnCJtFN21p0fHiQD2i+xxAbPXfghsGQVTTI8je1KDeQL54bQWQ==
X-Received: by 2002:a2e:8a90:0:b0:32b:881e:9723 with SMTP id 38308e7fff4ca-333a2265b8emr22577041fa.30.1754924172216;
        Mon, 11 Aug 2025 07:56:12 -0700 (PDT)
Received: from pc636 (host-95-203-26-173.mobileonline.telia.com. [95.203.26.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272a7csm41552511fa.15.2025.08.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:56:11 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Aug 2025 16:56:09 +0200
To: Dave Hansen <dave.hansen@intel.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Ethan Zhao <etzhao1900@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <aJoEiajJwlWuXyax@pc636>
References: <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
 <aJm0znaAqBRWqOCT@pc636>
 <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>

On Mon, Aug 11, 2025 at 06:55:52AM -0700, Dave Hansen wrote:
> On 8/11/25 02:15, Uladzislau Rezki wrote:
> >> kernel_pte_work.list is global shared var, it would make the producer
> >> pte_free_kernel() and the consumer kernel_pte_work_func() to operate in
> >> serialized timing. In a large system, I don't think you design this
> >> deliberately 🙂
> >>
> > Sorry for jumping.
> > 
> > Agree, unless it is never considered as a hot path or something that can
> > be really contented. It looks like you can use just a per-cpu llist to drain
> > thinks.
> 
> Remember, the code that has to run just before all this sent an IPI to
> every single CPU on the system to have them do a (on x86 at least)
> pretty expensive TLB flush.
> 
> If this is a hot path, we have bigger problems on our hands: the full
> TLB flush on every CPU.
> 
> So, sure, there are a million ways to make this deferred freeing more
> scalable. But the code that's here is dirt simple and self contained. If
> someone has some ideas for something that's simpler and more scalable,
> then I'm totally open to it.
> 
You could also have a look toward removing the &kernel_pte_work.lock.
Replace it by llist_add() on adding side and llist_for_each_safe(n, t, llist_del_all(&list))
on removing side. So you do not need guard(spinlock) stuff. 

If i do not miss anything.

>
> But this is _not_ the place to add complexity to get scalability.
>
OK.

--
Uladzislau Rezki
