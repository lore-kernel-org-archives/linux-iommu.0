Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DA375AAD
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499961; cv=none; b=B+qq/K259lPG97IMrlgqDZe9yxy6a4IHu5SRksmYjHXq36A1+0qE2O6EU00wt1RhfuP2N5sFyXle9n4jKKiDikkATEKoRb5v1vAv7YRt3oUnLS6g7veirQIxGItG6bXfe9wu191l3L4KB2sBsR4opmqR3xgFjGWZ6kAZj+UvBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499961; c=relaxed/simple;
	bh=VpRWbnLBmOW52eWfeba/JJdhQXbjyJk0Idet3KASW58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBUaGDTs0mfz6mKBid6efyAmLpyB1ya/7LgYSfXsMk1EOSZsG/ElAl99KftFAeFaELcK64xq+fFmBqqVXdch9Z0DXdCdoG80yEO3hnQjHD3N8NHvuPka6PELXaOqdJ12Vcqo3/m63N36Lmgj1r7zoVKs98P0mB2DJrRJkXov9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHn28dyh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHn28dyh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so925e9.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778499956; x=1779104756; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QffmlXKfGIQMvoSpoqBH5tpd14K+nt5m82a+AK1qlTw=;
        b=aHn28dyhFVxnq6bRrWpSZ3AtJd8fSFjLTB1+3QSv+Exm/Aat41rhJWjiIz/CwnPY/U
         o5p8Lcm2J0i7mdSRODyaljYEzHpO57+sVtnk47+cL7H37QvFYosyp46i2WDpkeh6erhw
         wVM/MpxvSWJnxiYmc5QWFXT77EhxmR3UuKz02Mu0SVHkjvcNMlQF62Sqd7D2SURdlKuN
         RdpfDmO6mzl0F7SQ4MwCegzvxVM717QCvDhPr3KAjAAh0vc47lD0pNM6ESP566xH+/aR
         b61243QgoMil9fUwI0Vq4XEFAFBSi9MDBuQfYp3Ui1UazLivoX/yKAxLGB3prHgg0dFE
         tIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499956; x=1779104756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QffmlXKfGIQMvoSpoqBH5tpd14K+nt5m82a+AK1qlTw=;
        b=GuIjIBR0m36lTdeRbcyki6HvPeX+uPfh1b5TlPo5YkIJwEDLaSMFoDTjJ3aLfD4xoc
         bAIIRbqw5pd3fgsOqH3vtKzM2PNbgH+hRdsmEx5tq2tmu1nTC1FV+Y4DzFcYZIeaQSKz
         sN7HXC9NawcQgACLoRC7BKgL77COqidW6SVZhLy/vy0KlPsoE6C/xPPh0MTplTDC+RiG
         I9kH68QKz/FrJzuaQ0A9hW3PYNhSUB0FI6h2eU+T7ZTNjUOISz1/bKsdYquDygBvanrb
         BStvEA+bWEW6byM5yW002Btd7YgCqktx+UoETXOzbmc9ywMoqOCeSdxDlFA1NqUKSFT6
         ttFg==
X-Forwarded-Encrypted: i=1; AFNElJ+xUldYTHWWOwPgX/pBgcy6twmZVS/JM2gNyIc+EtVddu64IW2hpHqh4eCtUg9sYCfHq8f09w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOjArl8MiKocghsWWIoEXWH5G87StHvw65u3M+j19X3aYh9z3+
	oAHs75L5WvXHbViS7OSOmNMixm0oprv3m8HJzD6+LiwXGX04gp/1kaOkcgSfc8DZ7Q==
X-Gm-Gg: Acq92OFj4pKY9StSVQTMRtH+r+2vwnt8dcqzyBJaVGzQakyP5cY4qcqLFHTQZfN8fcR
	Ml4c1PAUD6Z+RgO1pZ/BcPr1+VD9eoV7wo8x+m0DDgZFJIUX1uTFl2BKwQFqYOhXTZa6YWLLOoV
	ZxeUza0vAi7gv+LgmmOlrY2fkh+i1Jq0isDp/hDBbnwwKPiGSYCXKco6rLPgYPtjDUXx9YhuT9L
	i8i5YSdJKP3NfHY4NnJ38VtPeBIPDA2Tl8OVeDJX8g7UzQqjearZFJ7WcAqH1dBovl2ljLqI9K2
	ZvgZo4y+vV+cLMbN+S1o6S3I3ZbxIAcSmfTWa0Tf5ZTTje9weYYAQiSTGCUHGuHbGuw01CkKCYs
	5v0LSIb03+J/dbv1ReyLHYUSIo5gz9lU0/GUpe27KNcVs9w/RXSYHUVH34br5vYQsgFbIl+ceUi
	/UE5FkEW5UPCKn5itu5MGoH5+VPyP64u0iq8XtzoXbQnUi4SQQlbynYA/cxfF9r1CpfWQ=
X-Received: by 2002:a05:600c:348f:b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48e6f4f6da0mr2636305e9.1.1778499955998;
        Mon, 11 May 2026 04:45:55 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm25552833f8f.26.2026.05.11.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:45:55 -0700 (PDT)
Date: Mon, 11 May 2026 11:45:51 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <agHBby1qBvR6cmJY@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
 <afoYBYIJOTClsdLS@ziepe.ca>
 <afoeIVIGE-JjYy22@google.com>
 <afsPfEzgGtAFrN5P@ziepe.ca>
 <afxd8Km40A5ulZvd@google.com>
 <20260509232931.GJ9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260509232931.GJ9285@ziepe.ca>

On Sat, May 09, 2026 at 08:29:31PM -0300, Jason Gunthorpe wrote:
> On Thu, May 07, 2026 at 09:40:00AM +0000, Mostafa Saleh wrote:
> > But that doesn’t solve the problem, which is: At some point, whether
> > eagerly from the page table code, through gather sync or a fancy
> > invalidation array, the driver will need to populate a range
> > invalidation command (tg, ttl, scale...) and this logic is better
> > shared with the main driver which is this patch does.
> 
> My point is this patch doesn't share enough. If you do need to issue
> invalidations then share everything below the top level tlbi entry
> point and don't try to make a pkvm version of the entire logic just by
> ripping out the range logic.
> 
> There is no reason for pkvm to need a different algorithm
> here. Especially when you get to supporting ATS and multiple devices
> and smmus you may as well just use the whole thing.
> 
> Which is why I suggested to copy the entire call chain into a shared
> file

Agh, actually this seires doesn't deal with ATS, which I think is
wrong, propably we have to issue CMDQ_OP_ATC_INV for the whole
space on every S2 invalidation which has to be done per-SID and
as it can't be done by VMID :/ or just hide ATS support from host for
now, I will look into more for v7.

But anyway, we don’t have to share any logic, the kernel driver
is quite complicated as it is designed for a different use-case.
Doing that makes the hypervisor unnecessary complicated and
oversharing this logic makes the kernel driver less maintainable IMO.

The hypervisor only needs to share the architecture spec of
populating commands.

If that’s a problem. I am happy to re-write the RIL part in the
hypervisor. It's not that complicated, but I thought it makes sense
to share as it is a HW contract.
Otherwise, we can break this part into some macros that are called
by this function and the hypervisor but that's maybe over-engineered.

Thanks,
Mostafa



> 
> Jason
