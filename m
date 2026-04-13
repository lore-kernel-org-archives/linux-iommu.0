Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886723C554E
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084176; cv=none; b=n1lEEG4hdXIkxQ+5bVOQRnsTLJUQrjzZJDVfkiWFlSGxtaZRCfqmW3ijJ95sZNer1YMV4Im8bprMW6D20Zrpkx+4Z+/akYonUgI+HHiLEBRX/uz83CS3AJUdsZ+VB4L/VrACUAlKl1hnY+SGmY23hsh53KRY61nAmU0ZHAR+rjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084176; c=relaxed/simple;
	bh=90ZMP4TNlxyJ/Yeh1tSOQGp5I6K5IIQxFKoVAV2OK6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBxSPPO5ttFnCsxRiHAakS9ME1R6uT8jqIoI5/oiqQaiYxjQOxQ3w8NfqHtbyEKi4ARFg0Weq4qHLTtc3Vhfx6zST+K48fcU/7LXY5/T4vXP44K5JZ+eN0obSLotWOoWVoF+vn60itV+j/K+y0/0RzJE5NeXhnuQVMvNJUwO6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BUVPpPqh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BUVPpPqh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6b9bca48so57367461cf.2
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776084174; x=1776688974; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOgoRtm/p/VFr1yy216q4ryxbtSDlK7xGvp+FYzmvUk=;
        b=BUVPpPqhlKV179nJs62JtyKmh0PlLQJd4mPNdj06tCiVtlR6klAwa1okDIHzibhWpb
         VtVfWvCDv4VwfZVtUygs/12DYn2MK+B0IuFLABr/VWlxlS1dmwfsPF2nWD/pYYgCNZdo
         3iUvCXgmy4p/gVMFQkPeZHo9+CXhG1+cr/VYFPr2eS/7CJK1ZvHLKiTP6Sa5YZItAaD8
         +fwwUCXGw5nqKyU7ONsR3hDJMgM+6fLpmqo/H3ojXFVdE5Ncnoagq4aRq6c1p0gEVnYA
         TJPDNy69Ymtsb67uElkrcMI17xmUTmuqnfBjV0ntTwmPkzZ8Y8j6Lv2vz+w4qaqQ1CIy
         Quxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776084174; x=1776688974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOgoRtm/p/VFr1yy216q4ryxbtSDlK7xGvp+FYzmvUk=;
        b=kvhtxyTDbhTovl7nB8VwCCApvi37pUj9bJTGEfnyh8m+GzSPppw0I+CKGMyVUNpOKp
         Lu9kGeicvQYcn9QGWjQ1lDgFmNGvMcBUI85DTxOPwyeQ2zgauL0fwMp4dqLKeFCaSDVI
         xDqEVzkrKAGKzfjzFS/q1YCsA1h/sqZ9ZWDziO8R4ukCVGCZ/VI7CJYHm+xKNHofFzMO
         2EosYs2A8J2GjINugYGrluA+30gCIvAXyCWbEW5eVa5ykk1AbSaqDgLIFhGeWYAOm0GY
         m6t1NASaD1KSZj5oPH0gypvm1setFEn3O+eXlnN2Dc81wvJhYRy0AUiXda0hqx+Nt4y5
         F3jA==
X-Forwarded-Encrypted: i=1; AFNElJ/Bg1nv9QzF+d37oIRdLgFUBL60b3Ug4Jx5nFuh8bWdj93pQ36N+itFrOZxHw8CzXs/u66ClA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWpvTl2/BHTF7lb175S8pc+E4gniydFEy8d19XT6XkoZ5ly+qV
	vJrzktKcZ6HnJOM83Tr2i+WUQ9Px2GYah/4Z6FC3+57rBtZ3pysWA7GwoHDaoj+U6A4=
X-Gm-Gg: AeBDiesWXFQ3BN4naZy/FZSrQrgMa480ogEOUfz883r1Q6/6qitpWSuiykr7/mi+0gl
	HGujxgIKGr13inpuDCbfoJd0U8RdXKzMaI9dBiHk3JCfdDKF8mafGnrWOwbuRy+gQbs6fnmJxn5
	naUNirOzO66UH0pMyCvc5PynZ2R3cOg1MyNHzf8L8xcm9R4MHNTo/irRAqlRJvXqanTWBQpj6i3
	EHKjk10t+pyEokv4KGKSFiimTLyAEnk/OMSYIlRw7/sq4i21Q3xFQWQ0QHNMQ0MDHvIV3aUVBVu
	bUmnmdEGg7fjJyA9mQlkEvhVk66MeV8zCrUmD9M4egbbI8Cijh6j4b4HKSrVEc4gzcRkKNnCglH
	7B/pqn9JwD2bnLQTBPqX7cLYgDwLo+tUxbySVEfj9+xdFHpA/ZjttUXI3TsF+0lbTZmftIt/W4R
	ug8jtwjKjb648izUQ8AESy/PgPHxnOREgCWys6U1MPS7xp+jYO1PoNwMsfFuJ5hIG6KZfdrsD7n
	xZ/yw==
X-Received: by 2002:a05:622a:1f8f:b0:50d:736a:624a with SMTP id d75a77b69052e-50dd5b95bafmr219462791cf.1.1776084169641;
        Mon, 13 Apr 2026 05:42:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd550036fsm81771801cf.21.2026.04.13.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:42:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCGcq-00000005AiQ-1fsL;
	Mon, 13 Apr 2026 09:42:48 -0300
Date: Mon, 13 Apr 2026 09:42:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
Message-ID: <20260413124248.GJ3694781@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-6-smostafa@google.com>
 <yq5a5x5vba49.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a5x5vba49.fsf@kernel.org>

On Mon, Apr 13, 2026 at 12:49:34PM +0530, Aneesh Kumar K.V wrote:
> > 2) Using phys_to_dma_unencrypted() is not enlighted about already
> > decrypted memory and will use the wrong functions for that.
> 
> Can you split this into a separate patch? I’m finding it difficult to
> understand what the issue is here. Adding the unencrypted flag multiple
> times to an address is not a problem in itself. Even so, I still do not
> follow when we would end up doing that.

I think my comments show how to address it right..

> phys_to_dma_direct should depend on the device state.

No, it depends on what state the CPU address is, which in some flows
would have depended on the device state, but by the time you get to
generating a dma_addr_t it should be based 100% on the current state
of the phys_addr and nothing else.

Assuming that a T=0 device must be presented unencrypted memory is an
easy hack but it doesn't work when we get to T=1 devices that can
handle both encryped and decrypted memory. Then we need to track it
explicitly.

The only places we we should check the device state for T=0 is at the
very top when we decide if we force it to swiotlb and inside swiotlb
when we decide if the allocation should be decrypted. Everything else
should flow from tracking the phy's state, and be tied into the new
DMA ATTR UNENCRYPTED.

Jason
