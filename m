Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22209349CE7
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906744; cv=none; b=RP2Hy1OwheQfSHqzDhKaeGfCarDrTb762a40PXFPepiFFzZAIcyiUmuipQCeTHmY/agT8Vj8pNDNhd+U1ZYD3q3Ox4QiDoZT+B/mi2tdRSs/4rpknmqLkrx1KEdhK9prlZnpjzkE8yvZW4/oPer1Aik4w/hpl9ZKL+4vSE5en9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906744; c=relaxed/simple;
	bh=RNXkKFPQ93ogE4JR3suD8/iYTS6/DkqLKIppv5cQ7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7gVPar/a5Hsur2zYH3pJ7mnIaV0jJvWTkT4QOcxeR05MF24SOL2I98rCp6qGFkq/iapkf6OcbFGCztewB6C5ViFXtTY2DUO3rZ/3PQLR1pmJO6FyG5zmk6QA99DBB5eni6KYNUElXNPy3G1DVp4KTgtXMKMQ/KxrmMBG1vr3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AcSMHrT1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AcSMHrT1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb973e6749so669699a12.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784906742; x=1785511542; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr7PU9QdQLaE9g7OxEq1p1hH6fPGZz9aJy8GzEkv17Y=;
        b=AcSMHrT1PO6c9H5XOwfpa44OqSa7bEYGAGWKMtgPdl+SW8kqxuccAy81vilgNVZZUC
         1xL03j2uelMuZB6brd871nUDTnKHiJ5MwPZxOdg2xQc0u23rnGrIChcD2ErH0z3opa/N
         c5mPV47MBiJ/WYY/VsB7ZRQb0WdLWQPDWUqHJx0Tr0xg9yPREtPV51UrScvtX7SFRFIQ
         LRJI9kYiNAhDLOmg+NR960995H/qdW3OlUIzcFKJMvrabtEVc3CMBkloWzi8H3hLmv5P
         E8ADHq3aHEn6t69uyVcwaktT0NMANEiz5irY+udJYWAXq0KiyfgQwYiiUrqez3uKs2+d
         iG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906742; x=1785511542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr7PU9QdQLaE9g7OxEq1p1hH6fPGZz9aJy8GzEkv17Y=;
        b=pgClPvMkYakN93ph2xzsa2AwvspEbqWefNZUag3btC9ow+v7sjzQgJSIvaCCvdldTV
         OjDSkmSXlVS80kaJRH4L4Rp+OFF0JNak/JNbE0AB6S5iDIoFf4V9NsB12y/cktlLe+x5
         wqVqdkFqFbfO298dHiMpicPvhZ2l8ENzNgIx7i6VnvPXv0xoOdO20trU3WgHB1nNjVrE
         2p3W4DmOFmajWhZGReorKDFquwMtfKWvbEKqZhIJrvK1QA8PQJGUtWgAIUmK0hORBYIU
         5G08bEShOYq2Oz98HaHFbb89Zd7mKbOMeNo9rfz0H5TEBCBK4pF6uixEXhLWfyo8iz0f
         ruQw==
X-Forwarded-Encrypted: i=1; AHgh+RqXuYFJw9/NBVmzkq3fxKWIDeNsnb5X7g/IrpdHUmONev+heBbB92BN+Vt+atlQo1AGGq1iRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGklmakMsnFAIzb27Fa/SLCPNKq6T/7yx+LveF9hm5Fr21ftC7
	0H1GMPus0u63E09MqEPG3C80V6aDGWwARqNMrY43ZL8ndEw61cVJM6nsCLdYj1bo+mG8I+4bLlR
	kONl2
X-Gm-Gg: AR+sD102zPtey9+W5IySRmD9BdhNVBhQKYyTFhcqn1crvYQDgPu3gvwnFtmIjupJCmw
	WpbPu19eiX0PYi0YpALN+eI6rKURyWdl8K7hYdrA0f88Z0vFI0SYKeYANuDdcLwGONJ8CAS9kzr
	uamJlWZmKPbfmFpQxla9EfoifYutyPssy48NX+Usk2kzEJKcUGQ/zvO2/yk5/Z4dbLAm7Ip6ELo
	bdk8Cm2iWj30ke5CTyuPLoapGMjKRZwE7ZOX9nDauOmBDZowIdfykZ+JG2/owwYa/IfpKl2Pg+r
	GwisJpoYEx3eQU9j+jogzISAIVGdp7SU+jnHVQtFe20cQkSpmCmUrhCXvMf9YCk1Ak+ip3OdVsp
	JfVKrqXd8KXHuVKyNXyUwNLij3SM7TOahmDpydQUg4GpN9rmpiPluDlOLa03P1IE=
X-Received: by 2002:a05:6a21:6b16:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c44b00772bmr8719542637.17.1784906742420;
        Fri, 24 Jul 2026 08:25:42 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59434fsm590606eec.24.2026.07.24.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:25:41 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHmO-000000002o5-3k7t;
	Fri, 24 Jul 2026 12:25:40 -0300
Date: Fri, 24 Jul 2026 12:25:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, nicolinc@nvidia.com,
	joro@8bytes.org, jpb@kernel.org, catalin.marinas@arm.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amOD9GAz0j7wMMij@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <amDEmlcyC3Tfmkel@willie-the-truck>
 <acd85a2a-af1f-4ebf-8370-773338d4fd15@arm.com>
 <amFCQDrEowvL28O_@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFCQDrEowvL28O_@willie-the-truck>

On Wed, Jul 22, 2026 at 11:20:48PM +0100, Will Deacon wrote:

> > We might block traffic in the process of _explicitly blocking traffic_!?
> > Whoop-de-do, surely?
> 
> Hmm. I have very vague memories that there were some virtualisation (?)
> cases where Jason and Nicolin cared about the type of event that would
> be generated by concurrent DMA (e.g. bad CD vs translation fault) but
> maybe I'm misremembering.

Yeah, it is actually important for that special SVA mm drop/release
case. We need to write a CD that blocks walking but always generates
translation fault.

I'm away from my computer right now, but if sashiko is saying that the
SVA flow that uses EPD generates a racy bad CD then that is a bug that
needs to be fixed. Possibly by ignoring HAFT in the used calculation
for the EPD cases.

We should also try to have a kunit to cover that specific mm drop flow
in the SVA code.

Jason
