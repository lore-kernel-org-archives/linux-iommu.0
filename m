Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763195;
	b=NmH8WvvXVz3mySpqF/b8+LT/uk/pUaPXwcXI1shU4gCKIgfwyxlTKwN5WHlQVYJL8odO
	 HW+QzAESuixM6mZCW+mOYMj8hNuklhBMDU6i/lKsMEDeAw0Pl93F/9C0omcseJD+WDcYa
	 w8I7UETz4TYCZ1r6qAYRKDe+qCShx8c3Xn5oiYsJP2Rx2ik1N3ilQ8LF4rfdcDCZtG0dA
	 FdkRCxadbHbkv4uP+CpcWR+kqVDg+V3xpgkgmzVPerXl7eMOMAA05ZUyT2dvTszimDUHz
	 WUx45+Wvm8DJctOx3ZvhH6xTWSOwgIkdxuMNZwBas9o5EPW8IkP0bmNH/5CMQ+c4EHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=x3fqohRU8/o+/rWwlUOj67KW8Xe73r+lpb6xdIN08VU=;
	b=IDT65rtoA+YehwJXaLuAuC2gXobF7jmWZepjIv7Pc1ovtvxWrN2QxWTRBZ60tsNevAag
	 tLWJOaMFYh6tVGZSnlf4m4xNodmhCIGKIRmSbqf0bJHBzcyCVM4IC4rreyXk3FtjFqnyy
	 38dqu9VAyVgx04+SmcV3ojLlqdPzvUXrH+qSAhECf462NEXda7gEDpi+OF7Smcte8NBjZ
	 55t/8Ur3ncB4gnSF+CN32ZP6r9T4t8OSK9ciPGFoUTsw0lqmBhF/i6uB1M28rTeK8c2zP
	 jW0z3Il/DY5rMAGRWuosHrfNpy/CCPuviliiCSpZng2osbzqDDOS1uRMZEMUqRZGnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lT2E5Erz;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF4606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FF4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lT2E5Erz
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e7ad9f78dso101725885a.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792763193; x=1793367993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3fqohRU8/o+/rWwlUOj67KW8Xe73r+lpb6xdIN08VU=;
        b=lT2E5ErzognHLdEzwxKtA/aBiKu/JpAqQ2q9W/89NaFRMbjWynlmf7flYi/BreKXtk
         Iy7f9f15SukYHQy3beR1qfkezljdWqur+J1MB5Wh2nYJDiI69Tb9R6jiL4tqguCi2cSk
         kdWcUCScF0EZgo3a/gILT2ld3aVqYRsPnK0TpUpKYB4NdG/d3T9ofApFGJgqifEHWlmM
         F/P18BOQEmuurW8rrARyNajsmR7R+8vxuSMnQVH3d469rnEHhhi/wEBd0rR+uvb5M2CE
         r+daemaVvWOibqYE262vuFhjDyNXkQykEM8PNDwu4z5l5qI3DwkQ+CmtN8CuBCowrh+2
         x/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763193; x=1793367993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3fqohRU8/o+/rWwlUOj67KW8Xe73r+lpb6xdIN08VU=;
        b=pAmcES3keINdQvSN7KgZLQwR9zpq8oMnbmZe2JexfSW6xrxa1vBV2upUheriyDi2Rk
         XndHQTGBaiLNGe7+aoef/KOUIgcqh7Tkd7TCz4LEx37mMent+lMnVylHModd7wXM0+lt
         wLbBM+Evi896xFERX1RDrQ/4oMaA6Hk+bBDOcv3xf/VBJhLoMK8+n/P8Rih9QjOjWX3J
         4CXQWxPhUIWK1G2pTH0FIHcDE82/o2g/fbYwEReyEHFouJwjVUtqXPt+fHOPgMRe31L7
         ZsoXjIG+22gq8o8oh9E6v1Ujm/ahh1VEj/zx7lXfoaAxj0ONVWbb73zgYYWtPcKOESTZ
         yPcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZlpLnuQ7bNI0+S710Asr3+/LzADi/zsZre9m3J2bgLMtaqfcsf9Y5DfnjRPijke2DVg/fsw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJqBRd9sMciNkkov7pyBvtPZsefSfeoV9RviZB+8JdJLYFh+nki
	TMQiAnEx7jAmlXap9i8tH5rsKyp4nAyHOIHv3bnaLlZX10XUX9aO1hpltqpgD55VC+s=
X-Gm-Gg: AYBFou1W2rXISLFPf5PseQZ676jpVLoD+tX9FOtKsy1jNN90C1H/qcthhOCivapMVgG
	+cztkXnB9HYejtmyfcJYyegIYux5BuTpTDX9mzkAvXNGAx10vH2LVMdN0yK8OrY2JjLA7VSpyA/
	Q4SlmxVs2+W+nuPKt+A5ZJDdkAtTbvohK8eqyEaKb2RmRUDP8MucOlujhre3nTIkyLq88LqtdlF
	bIhpGR22RID6bMbMfBclwULsl8NIyyvPlWnZPsarxPXuHmJO7KZV7uPuslPtSPmGZksITKIIEqf
	UH1ZsYdKmd5K8D4/0IFoSdxOPnSJos7ocLcLPn04PNXqeU4hYfHZcGacK2W5d9zVVxj4c390dSC
	09YPHKsO+iIHVN28wpv4tGbEFZCPcykiHFzhFcGBwo87bzCcOxjajOlkW2dnnkIeW0y3TjtYGKo
	CNMCa6p44q0/TrTyDpU7MPE75NZXIkcNfOUvYFyBqYqaqT5/PZ8UiCwrEMqc8rERd2NYza6vEIO
	OQKLLkdUMeHOUvs3Gv/E49S3mMLL3TDyq1mQyVhRMnEJ4ng+4/w3PncGiAaO43SPPpgKGCdAMQC
	k7alQptc8N4GKgW8ZfbNb8kkkMSFti/W/jPHgNmYho4yGmFiD5G9lxbw2vA=
X-Received: by 2002:a05:620a:2853:b0:93f:dea:3b7e with SMTP id af79cd13be357-93f6f78721amr391556485a.24.1792763193248;
        Fri, 23 Oct 2026 06:46:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404722bccbsm21296085a.8.2026.10.23.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:46:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFbK-0000000GhDh-3AUl;
	Fri, 23 Oct 2026 10:46:30 -0300
Date: Fri, 23 Oct 2026 10:46:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless
 replace of CD entries
Message-ID: <20261023134630.GA3977851@ziepe.ca>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <40a2e1a2-138b-42bf-94ea-a42fda128c22@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a2e1a2-138b-42bf-94ea-a42fda128c22@arm.com>

On Fri, Oct 23, 2026 at 01:10:56PM +0100, Robin Murphy wrote:
> On 25/09/2026 2:13 am, Samiullah Khawaja wrote:
> > This patch series adds support for replacing IOMMU domains with S1 page
> > tables hitlessly, that is without disrupting the ongoing DMAs. This is
> > one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.
> > 
> > S1 domains are programmed by CD entries in the CD table. During a new
> > domain attach these are updated using arm_smmu_write_cd_entry(). Since
> > ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
> > considers it a non-hitless update and sets V=0. This means such an
> > update is disruptive and would generate translation faults if there are
> > ongoing DMAs.
> > 
> > Replace the CD entries by using an unused temporary ASID in the
> > following sequence to allow hitless replacement of CD entry,
> > 
> > - Update the CD entry with temporary ASID.
> > - Update the CD entry with the target TTB0.
> > - Invalidate the temporary ASID.
> > - Update the CD entry with target ASID.
> > - Invalidate and release the temporary ASID.
> 
> Why bother transitioning through a 3rd ASID? The old and new pagetables must
> contain the same translations anyway, so why not just: switch ASID, switch
> TTB, invalidate old ASID?

The target ASID may be in use by another CD someplace else. Doing it
without the temporary could contaminate it with wrong translations
from the original TTB0.

From a driver perspective we don't know why the domain replace
operation was triggered. iommufd can trigger it for domains that are
not identical. Corrupting the target ASID when we don't know for sure
what is happening is not safe.

Obviously Samiullah's use case is hitless between the same translation
so it doesn't need the extra ASID, but the driver can't know this.

Samiullah please include this explanation in a comment..

Jason
