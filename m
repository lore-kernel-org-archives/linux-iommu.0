Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446129;
	b=ES+jb29zGLMIEzi6gQFU9xO3kd0KUCOmXbODwDu14Usyxxfk5WuV2bfYKalrZ48mm8bi
	 LuWcTPg2W6A10RiujPD/IKyGB31OTat3e6MwBwax8OFwskhowfgO2wHPv88NDJBuDPuxz
	 q/sccjWNjWLC6czrtcwBwN0LwqOXub8LICpWD7MjswS7db/PYoBzNQHTLcEpPc21ejIz6
	 8+zXA7UZqVoGbwCNF9RpNBtjLTWe0l+srgxHZ5HJkRcWc+gdrnz0AptnIrqn526G7jh1E
	 AV/81Up27dIcgJOgkpEdSsq/Y9BG//PcsBD/Yfo8Y4KAd0MPfwoz7PDWLRcekc0lyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ci49uusmkp8II7KfoBVWSn4YQVElmt181gLWu45xies=;
	b=sTfnIvaZwwXbPN1ULnogc4FG8yd+23zdMcRoZNFnZbYT0SprEOn6tIeeQ6tUK/H29/2H
	 FhS+UO9Yxtqb8GtUK4gocFJL+YBDUI6i/nOFLAgkJHDa4gUuDwZA7boykX9YsseJx2Tvj
	 1DcGmds3BXe/wBP43du6r0hD7UgER+UEqM+o6SsEthW5ZuKYkjlqBiVSOaqOv+Ed8Y68+
	 bkoyP+5sENORVoZh+0tPdMA/m/6wzn5X7Fara8IXuBgu3tqqsm2ZpKjovjtb2GH0k8wzh
	 Wa1QU+EviVglCV5OxHOlUbzmkbJhTcaWT1cS444O7VV5xZGZE766iz678Cmar/xEBNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=S5IC0IUx;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FFB606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FFB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=S5IC0IUx
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92116a3ef3cso51661946d6.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795446128; x=1796050928; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ci49uusmkp8II7KfoBVWSn4YQVElmt181gLWu45xies=;
        b=S5IC0IUxhbDg9gnTOWMXy4RldBBz5l1pbuI1fRGqaEQT1j+A4KzYHZxIN8wqfYXNpt
         B0EiNuV2jXWLSfV/uRFNHklJL7gFyxSfJ9JTW/PWcEiUrY10qJbua6rNSzg4aTOvlhS3
         f+y+GirRmGkq0MwiBBAKf0jvXzSHXkF0aaVckV/FUaD7/pth+IBEgErY5Vmv5b5L3c86
         9Dz3YRqrAfW6TXQA8/57C4gp4uBS8M8VoY40T2b3fKIw3KOjJslbaFP1ezgdCRPTGJ9G
         lkFAy71ps3+TEKm2qghSTVOFN6lJq0msBXf+jLyjuEBf2xaUZYjZuAadOMTh8t4LmYyl
         wvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446128; x=1796050928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ci49uusmkp8II7KfoBVWSn4YQVElmt181gLWu45xies=;
        b=s9Pmv7vnNbIo1kk06FR6XVcNDacERAtUQp9YljuYuItQlBF3BEcLSjZzXuG7EGbIAo
         UIPCJ5RWB3Gezj2VMZ7JrvKBKMzhS9JLnsY3MKsRTrh52OXIbtHe32Lu1MvYW3i82Lni
         K4ungHaptqK/DNkdYBVDaxtncGTM1XVgbNuXkyMOmOhT92ttStUPRVMT48IVkHSDR/5r
         goBL89HibRjDaB3SwdqV35oqP26x9UvPtkHodYIn7Wp295bSXtzcSCpqW7RB/SoUHP8E
         sgxBFqquWBJbOMu27hngt1UQJ7zvWbVbNlz5ofFoaBuZcgayPqbPlLv1HuCkf2UlJ3nx
         9ePA==
X-Gm-Message-State: APuU4Z941iNXNFLQSXeGZgoEwuuu987N5iYPtnDUEmadJvv7mski7sQD
	e4rRWQ8gYwMlbDFkGv7m5OiL+eRMd62R055Cv+Pp5z+jCzpGA4YoRbrls4zy/A6Bmqc=
X-Gm-Gg: AZFdTZcTi/LK/wYqo7X1rh7LAV9k+D08jlHCGunLAVDMYZdvHxVR2+Uv982XodUO9Ju
	9grKjsMbCpLEXY19dAdhEpid9cmYXMM9nUyrBZ3td4IQLudbYP4iLPvJwc2CiM8Zxr5a32aP5fa
	e2FQyyg05RPrQVVSmAZZONvrOn55ysUq3tzhfbubTAQRsCUWY3o39QlctIyhrdNtZaE2WkBcqBo
	HjyR5gHYXY4SJ2d1LGxDqLplTQ20Q90n8e6UHOwj/7cPwRbT69j/xTiYNhfwFSMuZ6GcueCI8sX
	e1Rk0DTEqqCsS4tNQPwmc+92Jd3SYFAcAfC9bcuj+TO2ctZyvedJkfFc3NO8bBzdNOj4L5HR4ka
	WvSEfe2ymd7zRZLeAeIngKRz4nqAbHpMBozw8C1Vv6sLOqEhqGfEf48Qr4SWJyO8bQf9IL/O6Cj
	7+J0qlqczMKKnSzHMC37Fwfx1RZyQvmUmkGs2hxBU0+EIGbvQ5grl8BU2dyb/jExEu10mZELsTx
	CJ4Xjl/7v5VzBuGadAdS6miRPsO+W/tM1Iyt+DU+7urqTBxfVNvg2z9WaKNq7Z5ZFAdqcGwPnCn
	Ig/z9353cys6YL4F65uzIAMNDOAEdCzqU1kOUWTN3ugfI8K/z+nOrfQIl+pTFWYNtH+c/6fJll/
	BuOw=
X-Received: by 2002:a05:6214:5192:b0:920:ee9a:783e with SMTP id 6a1803df08f44-9212de35fc2mr227222546d6.4.1795446127973;
        Mon, 23 Nov 2026 07:02:07 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24aa8sm108183266d6.42.2026.11.23.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:02:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVYT-00000000rNM-3I0M;
	Mon, 23 Nov 2026 11:02:05 -0400
Date: Mon, 23 Nov 2026 11:02:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Mario Limonciello <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Akshata V Unkal <Akshata.VUnkal@amd.com>,
	Nathan Blomquist <nblomquist@gmail.com>
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
Message-ID: <20261123150205.GC179082@ziepe.ca>
References: <20261120152308.76894-1-vasant.hegde@amd.com>
 <20261120192653.GE1133597@ziepe.ca>
 <ce52a6f1-bb8d-4a40-a500-1af32746cba6@amd.com>
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
In-Reply-To: <ce52a6f1-bb8d-4a40-a500-1af32746cba6@amd.com>

On Mon, Nov 23, 2026 at 04:54:39PM +0530, Vasant Hegde wrote:
> 
> 
> On 11/21/2026 12:56 AM, Jason Gunthorpe wrote:
> > On Fri, Nov 20, 2026 at 03:23:08PM +0000, Vasant Hegde wrote:
> >> DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
> >> an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
> >> The IOMMU walks v2 page tables without observing CPU writes still held
> >> in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
> >> on every entry, but the v2 format has no equivalent bit, so v2 walks
> >> are not kept coherent.
> > 
> > That seems like an enormous obvious hardware bug? I'm shocked it was
> > released like that..
> 
> I believe this is missing BIOS programming.

So a BIOS upgrade fixes it? Seems rough to patch the kernel based on
sillicon ID then.

Because you also have to block viommu if the S2 is non-coherent, this
patch should be updated.

And that's a big impact for a BIOS bug that will be fixed for some
people...

Jason
