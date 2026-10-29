Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279032;
	b=BlALMmQd/mCLfWLu5Sxg/lz9u66/u5o/Sw0UCZOnJWgVcy+qxAtREmEZySiO0Pp8Ltvu
	 iWtmp38C8PIgG1oOo1nBdfU/l5U4bll9zZcYd2dMMMDmYJVu8GBC7HbWFbdamXLbTxfsp
	 nUv5dN4Q6JjU7Gq6M0zoKsSsu2mNn34EKiPeKy32XvhjYiL6Lfp7oIx697rIVHVdo3tmE
	 zfUX6maCMajsd6La1dzCfo2mF6jRgDAVOzNZ3vzvm6ytbeeCOtodHBVm9alFpevBXD8jj
	 zJTNmfZ72DswPn0mx35CHsYtOtx2WOw0zP3ksIeGUhFDFJIz6D7CfC6SXaKd3b0QOUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
	b=Vh909g/GqacisPOYu7DvtlQkV3s/ci90fr5slMUO8wbj1aAy/8mls4m93jYMcRyglQWP
	 x2Bc07OCmtRQclnm+AMcCFLQKOBL1YMkgj1Yi3K61iEP+d8IHG8cy9NVrGlX/2UZMAHz9
	 a4XtKi+APDJGi54oBeZ4vw6K+bhqGu0qmBLgyKmsMe/n2hM8/qHMgwQYkiBSH/HMqC4rv
	 HUzTMyF2D6VeNDwL5igU02OVvZrwEy9Jn+O1tevr3DDv60nDTIKgimiIlA17j9k+HlCdQ
	 L8l9iH3D0qE9IV20IkHSipJOWBYjmVQMSNv47yDoYo83goyEPDd5N9+Zncr2I5Oh3tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJ7okvH2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E10606A321
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E10606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJ7okvH2
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53653e30353so31942081cf.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279030; cv=none;
        d=google.com; s=arc-20260327;
        b=Jj2MqDg9i2/ipbhChDrlTIz4jqh/FY3c93rkEWFxn3DUVg97LaH50vN18E9kyRXBFL
         K42uMEZugYPbvPgY/6jFIDlzgwsGCi0z049G/JfyZkv5w9dWvfeYqf8WKQVwplhf7tj9
         OV89Dyaj7KPn2zGbLYFCSksU3540f9nngOaz777LBMfF0hfjYv7CMcj1oNR/yKcH9iWm
         6Fk+TO3/TB9FguOcDv5aNrp4ZT0dys+9Bz02gitkiLxQ7AZfKmN95LX+0KnSxfIbZvtc
         revistG0rliWQmMExVGM0Mpx85yYfge/VgGZkXHr0G8xl1ogKtoTd0uCl538jDGGVJxl
         mKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        fh=AoPzPXVcWxBKTcz58w2R7tt52h4UICv0AM/tTLP9Lus=;
        b=pFFOP+z4kUnJW89REx1Dm0nTljSdjQH+2qid/S3pkUsDtFXdchPg3yEwrOwH7JaINb
         yXHHG0rBTGCGhEKGReCDcVorJdYU0HWlMGEeYkGE5Grtq4mn5eq3LD9ttDH9yJQkgjVm
         /5SujaIqmoIplFCtKqQkAg20IJ4nZkmmeTIWmURqkzp7ybXyXw4M9PQGR/zphV0JE9tc
         e1eko8ksaxsDk6S5g1Msic6C+12mXX2qapQ3zxuuDrD7cIFfJ0dVgq/v4BXEP7B7EQBz
         ZO3SY1KwgYN0GiUYW2S9PgiQa+uLCjfWn34XntTtJNSridGu1a6rps+9mwGZLPbNwT28
         70nA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793279030; x=1793883830; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=CJ7okvH2KOmyou6LsTFV7UZ/bM35c/mXkHSaWH/tz/FN2UP4pxV2fMu3lbTmVJXgyj
         DTt+QW8pQ+2HO17+aqj2jHnjOUteE9Sg5tnXk0OSi2328kTsRUvhJqvEElruiDP7yDtW
         o2nrpH5FfJ8XVJhaLiqik52doHvEyjnc3Uigq1Fzty8oIZmFizdIBVOnSlDfx7eiybWN
         M/Ceq/7EjrdpWh1VtIDZs9AVzrLtAiHTs5jNWEIO9pXbdapqKWwMBst8NKC19FVqoM9T
         fWQTas/GOTh3m6EIx79hZhmO9KczA2sG498QeUaZxkhbYl97ipCaujNPDxzBlxH8jlST
         DOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279030; x=1793883830;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=Bejxs0zujpC3jBpUuTozfH0rzXn5tXXt/7VaXfIxIIeoOQa7tlbbkjIb6yvmfC0blF
         aFp+039U2IMl3FetiVmXUgd7ptbh9zb9Rb1gIBALXi8nfAZfF3yg87uCbROyAIh+PnQa
         dME1bucWKpxg5BWcsw0q9byMz8v965SPdn6J/DFgGBfTmLOl1cjUFj+khoOETrbzFZmf
         PJ/V1BBXs1RZqbjGuaTy0i/4NEahse96x0RHgcYa62jv7Kauul/aSg3QtdaRk5UC0rwq
         tfUOr2t3tEM6NJxSe2xnUGKOE4VySWAWuE2vwp96diEO29YVEyLO5mNkFk1zDQ4qT2x4
         BPKw==
X-Forwarded-Encrypted: i=1; AKwUvBxhGH2LWbLXlHhQ3ZBSpE/LsPepHKTQ4/vsQ++jAk/lVOumMBNv55k8CuuDXVRbsWdzJ36Ppg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLjuOtRbkUXSgZfFHWvUq1T14636D6I9gROTHbW18HWt1TUMMEj
	SAWSVd65lblt7KxsLkIOf2dOoBbYwy0klUBHbPJ8yYqOOT6mBeEafauiSgY5jTFrL2lKrZyjCzK
	2qvjdQMEq85nQ2j9YU5aElFO6O2khx+EGLX4TSqov
X-Gm-Gg: AYBFou37Nrg8/NKs8VZO9GGzrjAH5FqMQNCOuWZUyxTlDmcTeGnNsT0Jyw+a91miBFK
	9FMBsw5e3wyN/Z56C7IkCWaGrFc/LNhMP6U49EyqYCZVdTIazYWj4XJSLCs3V65axc7yaBhIUIe
	HWtnYKcgzsXJP/SNU2QxCB0FKZr5KdwMGDv1+HWqKyHoQsxQvNNLvqDE2mAOEhCp+4Ur05rqiP1
	9Aq5mk+O7N4hXEGdjLkdVIE3ppKnPqILjnc3TYGC2ATU4ct7WsaZRH1tOVk+/o+qXHPWQ7ovnyI
	0eluU8ec6mF7X4p0a6IJ8wU/4FbOQQtFAr9qldX346BXwv+U/yVaDfvnEZ1KUGfvCy9N0PMJoHh
	EVMCVsPlOtymspa0VkVKeFInKnDm1gUNg7eNs++KZGaPGOcrQuNE=
X-Received: by 2002:a05:622a:528f:b0:537:b9f5:e05 with SMTP id
 d75a77b69052e-53fcc7cc0camr87903901cf.69.1793279029444; Thu, 29 Oct 2026
 06:03:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:03:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-14-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-14-griffoul@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:03:47 -0700
X-Gm-Features: AclHuK_J4_B8WHMj3lc3Bqk_zMBRzyMWVypxyBk9aFiFYwwISWnD_-KRrJmOcto
Message-ID: <CAEvNRgFYecSKycFLkxwyK7gWZqKTXTPJVetSZm8YBbo0kg9tTA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in the
 sample provider
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> The sample provider fails get_pfn() for an absent page and keeps its
> frames on a punch hole, so tests cannot exercise a provider that backs
> a hole when it is asked for a frame, one that backs more than the page
> asked for, or one that frees the frames that a punch hole gives back.
>
> Add MPS_NEW_FILE_FILL: get_pfn() then backs an absent page with the
> whole 2 MiB block around it, and put_pfn_range() makes the pages absent
> again.
>

Can what MPS_NEW_FILE_FILL is meant to illustrate be illustrated with
the ioctl that sets memory present?

> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
>
> [...snip...]
>
