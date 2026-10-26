Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049253;
	b=IYcwl9uR7VQGE7FOzs11v3kyMNb9kJF2vd6SwiLYwjHhonGLEZ5l1mXspYjM6nWjfZ4q
	 GXDhD5bTrWi5ISzWMLGrmOBIp1qJwiao+Lfx4jsRDaSGfrbwQo/nr8n6GXByEzNCwRsi0
	 NMwFrdRouJEC4Cy23XXSS10FL6CDD/kX3rDO64VAp0DJUT68h1VzwM4CO2zivkmzO5JqK
	 1J65rUksfhyqMjVaN2ogQYSzJ0iHWo7YoA/WFABcn0QMbqqyT86jQLX8AC9Q4HBv8/OZ5
	 f4vsPh+g04LvWxIc1DjvYD84bels6EWqsiZ/os9rmI+RzgJnHdXYwqUI/VhRWRyjUYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
	b=0raipqWkDmfnQSLlA72sjUaclp/BB2T+s7+j5EjdFuhJ9wDbq9xoi787DXPf5R0DRHKF
	 MTx6gr8QTdlz6BcRyLkrDwatBdu+Cczaj8wxpoGHNYmBS8DY2VfYQj/BmdNkfWmN42CSy
	 MF7+JcoMtlHyx78ZGu/sJEYof3RyF8Vey3bbcug+U87dmA/2OWV5+ImXgKcZpVJI7tvzs
	 iXVDKDFBcKMkOMlEVQ4ZEyKb2gbt9ZQfD8t6yRj6bqry2mzc79xoC4OL6OJrD11QwVooK
	 3rdGNQ49kwTC/HDyUk+aVjgJzEtosGqonmV3Ti28Wf63eCR/NMmBjEyBONRYVZpc5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="uMY/pJuy";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AA606A31F
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 21:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15AA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMY/pJuy
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1602582b3a.0
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793049252; x=1793654052; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=uMY/pJuyqnXFquXlaQgbXXn/WLKQK/n+3UD8OtorTMynGREvFGk2kWQCxGjnV+CGBd
         zUM10wRLC+73bkS+rKt/q0gnqLvCUVRW11zkardjYkgI6O04fpl7MsywNnJ1bW5FL5gR
         qwQdX/UuZhJ0Hd7nka3/Xye9XxtpHUGRNz8QeVKx53rvCQS3x0UnmFtvdkDPJsTgCRe1
         VG2nR//bVQr69oW9wDfCMgQW4wQ96rhKOdnm+R47sVzfcUnlO1AQlw6sgt1X2HCa7sHQ
         fp+WdlntTGL+VwHHpoDrlpbSTNCfDOSHr1Wd/3YpYhYJdgYeAnPTvJ/tN5kRf+xGDPlS
         GrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049252; x=1793654052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=hnbeNm3FWvdL22Wup7dM5LjiLlh/dUkoBDG5c+TmHHtayg6famZxJguGWqqfS2hjAp
         WA+EBRvuwTaNmykwpxEr/nbb7FJPx2i4OoyEEUlFdCJsC0hbnJxWfHjq9cnSlTeRU9kE
         TvEee6n2MpOITt+eVDWY1WVGvR3zkc0UfJfVxbqHn+yxGLZRggy6mcgc3l+3CIYxuj0U
         egg4FSb4NXuHVdvIB7bP42e/99nO6KEZhQzHmP1uDiE2pPShjhyJJthZk8ZXL8nRwPK5
         hkNo7hMaC310OxAH7bMTk9HmxPK4cj8po/rwiUaXwwXXdfwuDzCUSN/e2+JFsbJb6eNJ
         jwcA==
X-Forwarded-Encrypted: i=1; AKwUvBwoKOGbdHSttKjx91sHnUPEH36od1AZ5F0MKP6/hE0rhbtbRQbtewCJ5Y48tdOjVHbiHa1O3A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLge2YeIrLeasHsInDBDOOnjy+tjngAelsVNOv+wg8/9QzuF+MQ
	2e4inR6FA1WWeS7UgCKzqycITDxmJfu3Ir8FaawcGu0KsSEpIzlRb3Pb8Bnps4or0g==
X-Gm-Gg: AYBFou2df2sPj3oWfbw6WdRwmskmmTAE/je0GSPYO1Qm8bIiSZRmjUmK2OB/Pn5uA2g
	bcJVL70gp3hdql2YU6A4t82D7XorcKxc4/VrmFLAr4ee/n51M/AWhxolxc74p0udYDByeaS8x5/
	OjwJCMo5OC0hAbdyBayU2rfSNEpueWGS7DrEYDxIR+6R6TUCD5/j8uFGO/0dMGWgosFaqqOfGyJ
	u3wKlWt0TbQtYiUo9arY1FCsh+4w9r7TyWcvaAVH1/QGBTVQQfCGUv5KL9XKFMYwNPBuMDS9efX
	Df4ipFNIAlCddQ4g6c3ULLdZONAlQo2wa2ybQnnM1Sq9pdKAIM+Oq+lyFbCXetDp88Q5Hj9LmAT
	nCqzu4tdHXhbi+32cOS22atcc9ayARXMEJiWhf3vvy3efjsAHdyJQeWVOOkiZVh56na5nNVvvf9
	Bh6ht9zreVW6WuivDYkNheZ3o8qBsyy6AzT70mPzNyFszgkOmyb/CCmUzClK30aqB+xBkiFnOx1
	9xqmaTErnnWyOUd4/3vqufv6PCkQKNmsmU4cDZEkdTFA4zxyAyAsxMQIKQIEFaDkrlxGvuhYuFY
	Uni7qX+xDfe93fk9Nid22QCLooW2EmVMOOrOlPQTGq4=
X-Received: by 2002:a05:6300:6bc9:b0:3e2:3392:53e7 with SMTP id adf61e73a8af0-3e7a1b97750mr5308652637.0.1793049251805;
        Mon, 26 Oct 2026 14:14:11 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b372888sm1666157b3a.30.2026.10.26.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:14:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:14:05 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at_CncIPYCxOVkLo@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
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
In-Reply-To: <9huzzew0el59.fsf@tarunix.c.googlers.com>

On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> Right, Required bit should be source kernel payload property to tell
> target kernel that the payload must be handled to correctly deserialize
> the data. It should be source kernel (userspace) responsiblity to make
> sure it understand the target kernel before doing liveupdate.
> 
> Saying this, During deserialization, target kernel's required bit is not
> necessary. So I propose the following truth table.
> 
> Source hdr  Target supported[i]  Action
> ----------  -------------------  ----------------------------------
> 00          0 or 1               Accept: feature absent in payload
> 01          0                    Accept: ignore the feature data
> 01          1                    Accept: use the feature data
> 11          0                    Reject: -EOPNOTSUPP
> 11          1                    Accept: use the feature data
> 10          0 or 1               Reject: -EINVAL (invalid encoding)

Yes, this matches what I had in mind for the semantics.

To be explicit: the source kernel should set the bits for each Live
Update based on what is actually preserved, rather than generating the
header from a static per-kernel array. E.g. memfd would only mark a
feature present for memfds that actually use it. That's what allows
rollback to an older kernel as long as nothing being preserved depends
on the new feature.

But looking at this again, I think the required bit is redundant. Whether
a feature can be safely ignored is a property of the feature itself, not
of any particular file. Every file that has a feature present will have
the same required bit for it. The only thing that actually varies per
file is whether the feature is present.

The required bit still has to be conveyed to the target somehow, since
the kernel that needs it is the one that doesn't know about the feature.
But it can be conveyed by the feature's number rather than an extra bit:
split the flag space into required features and optional features, and
assign each feature to one of them when it is defined. This is similar
to the required_flags and optional_flags approach in struct pci_ser [1].

Keeping the same header shape as discussed with Pasha:

struct kho_ser_hdr {
    __u32 size;           /* Size of header + payload in bytes */
    __u16 nr_required;    /* Number of required feature bits */
    __u16 nr_optional;    /* Number of optional feature bits */
    __u64 flags[];        /* Required bits, followed by optional bits */
};

Required feature N is bit N of flags[], and optional feature N is bit
nr_required + N (using nr_required from the incoming header). The length
of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
are numbered contiguously, so there are no gaps, and up to 64 features
still fit in a 16-byte header.

Each bit just means the feature is present, so the truth table becomes:

Source bit       Target supports  Action
---------------  ---------------  ------------------------------
Not set          -                Accept: feature absent
Optional set     No               Accept: ignore the feature data
Optional set     Yes              Accept: use the feature data
Required set     No               Reject: -EOPNOTSUPP
Required set     Yes              Accept: use the feature data

There is no invalid encoding left to check.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
