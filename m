Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB973793A1
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093997; cv=pass; b=YA8YWJig+o2QwaaA0EfHJj+T86lL1iPX9o1Z5k8+e8zaM7JVQ/rtPqSTnaS5fvgfRq1MpybHOjL+WA1DkevmcQ0HmlVhWjBCbBoCbkrc6DPfVgY1fnelh9LpXwNrAvne3ofIwGX7g5Hy+KtxN5Fb9EimIySeknp/L5xd/wUaqew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093997; c=relaxed/simple;
	bh=cdBxMl2hAVhNIc25QWUuK78SdurupBpgKnwJrav1VP0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVEWV0KE7PCiMQX85/iqSM9+EkZjPPe4cLioGKKUhEtE8XAwB77nzWbs9gvewwE4jXjiKdEyhelPkrU1dQ4+O+KA8itBLVsD9r3qOdpCzlhZiju8QEd9bMmFjoNuU1F0RlQ1EfrjoPrt5OB953J21DwLTZsRjTAsujk9zg9NIzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KfzXzVfH; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KfzXzVfH"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fdf3735e14so341872137.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 00:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772093994; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+NfJGWkeKS5Sl6AQhvEaHIm5ZRDjc7PG+QAPxP/1izMROePS8OBWMeLFdK8XaRd9R
         mCrJ3+xTpy1LSuPXxtDKqhDIB5fX/YW7Cmkb1cpJ5fO1+eZVQiRAHUqbn9ncoc6osk3M
         weIsh3N1myYuzjKChfJKMXDRiFyjG9uUFVSgQ6aFdQcjW/oZ5zpcydIbNV2w5bkVjZnk
         1JoKRc103wI2P3CzmuW9hRQ+WWAJDbKDhkxVW8WMgWZ+AAbK0JeTiZ/ZSi8Fmu514AKj
         L+M3+y/hTsxk2NiQTFiSc9ELRlTY8FrWU3hGzCweXkCcaHrA7ybfs+56hrnsXHGB7Ukf
         tIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DtFIIVRotBA0wMwfgLQC8UuujLTYkQfIRNv/mVGEs6o=;
        fh=mRN9RUSEGbLX1zoeD6xAKPWT35nKQhJnXEVQyxqUEHM=;
        b=Fg06JGys7c2XJ0r1eVt8ryuk2I02qJmxuwBB45lsrdQgWhFOA1M7OMaQEfDSmJygpo
         cEZVo4pNykntDnQaP+zxMtY0/iHeSALQGhxa5yaXJy8A8rSCNpctskUYbl7zDiThNHTV
         fxgcomYmRnUsXtMTXIDK5PbasqSVCUHmzJsQ9YB0Hr6UeR8LKraJ9Yy5wyxsw6jy8E23
         /QMrLWEgZV1RhTqOZ3sbfRkD/zGU0i6zH52Lv4mQtp1Ibth6bAn+DmCHO/jMO40jsYDN
         Z9ewOluZfyWcEbiV5metl+meGhuRaBzEyLaQcOyu2Iu5ZpmnNPE/vkmWUqyFIP1xzIUj
         IPJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772093994; x=1772698794; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtFIIVRotBA0wMwfgLQC8UuujLTYkQfIRNv/mVGEs6o=;
        b=KfzXzVfHg5DbiAeymzlmCzmF4AwWyNA3ZJ2uiEngMJ368ObZQkIWTywX3/Wa2/qPOy
         BKaXs22FTS15o48mW5QoYqxpuxrPG8R6w1cZhQ00ej3Vd7Keajq572Wl5pwtd0RJhNOH
         Ev9MMAj6p7YEXXyeXXpf3KALmycSL/FMz6zFGSVJhC1rxgn7rRmylbDQ4jelmaJBjT0Q
         qBY7JIG6NqvJG6a2qQCDiuzug6JU75psOEeu1n7jDiI5POawEzPmTnHTPsge+MOSKL31
         c+j73WlYIv1YNEOgDUh/eyVPD83VI/ehHwvdtiYB6YdgSaf2/fA5g/g4byrNkORAp88T
         Me6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772093994; x=1772698794;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtFIIVRotBA0wMwfgLQC8UuujLTYkQfIRNv/mVGEs6o=;
        b=q4CttyLNnARpbKLjAdKA72dNqqE//+0D8RYxAe67v6bFrceoMSI5PxBfcuMIlFe6Od
         gUvltbZ5hWN+kJfh5pGYZwoRdXWtBLR7r0GzHtmHPfBOXlOwcQ+iBOAqWqLh8l7UrPWX
         InOe+Y3Z8lAhTKCe7DLfo4WXzaxj/7R5ZA/0ldd9CuWdOSi3LkL2X4Z0+OIccCt0OUGH
         NiqBLWvCJzH5Vt45/mYkjvA0uPLz+Eh3VRzGGdaRUmloZqcMhZbUU3+xWE99sLUruBl/
         aUmUTydWCYNyDSC8ZtDDZ8mtq4FlRj4DqhXtY3JBvPj8qJAuzqGsJqhfsEsjznSLJZFP
         Mo7A==
X-Forwarded-Encrypted: i=1; AJvYcCWlrOugoc9VOcCpogwfJOi/z+4FyDE4vAYD1FESL1bjOS9Hr05yzxLePH1HBUQXYNldCERu6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWtWHMfknXFGqr2DmOWNSiilor+VcDH2t5RBJcJMpPQBfDazDY
	LNPKA8n/MZ1vwmJiRwOAl1w1ummbRNRiYz4vgw3rmFykmhLujj5brw9tlI2QEdAAYaJZxKNwNzV
	FQ75gml6tGwq418+qK3Ux4nkWLFb7IrZkmEZgvfhL
X-Gm-Gg: ATEYQzxkZldpZw3ZAThCNy8KZ+XROt3ySV2NxbSX6ig6jAumk1kLv+hThMbjn8e9Txy
	a6V7YpNW+CMMJRG5eXb+VWsO9drKbxciwVuSChPLlLJcHsHTTzGQt690NYIaa3qqjYR5Cu4AuM8
	dtMX/6YlmgqRYdTeSCuwPm5MuFvvGi0N2jKPtGC/obr8bX35lZCzljkLsPeiAXUsZwPDhgjGWx1
	s5qGMYyI/HnCdHpVNTBFHjyNwD2sa7KcSCpOy4MOrRBUoUl3c6u/dtP4eZmDYXKiXsf80JXQq2e
	NSBvI7DcHC7/JY8FhvVBUsw5qcWQeraOVf3L+gYl75EiKO1QI2d05eRAA9sR58zikWCxyg==
X-Received: by 2002:a05:6102:3586:b0:5f5:3dbd:700b with SMTP id
 ada2fe7eead31-5ff209d60admr700294137.7.1772093993676; Thu, 26 Feb 2026
 00:19:53 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 00:19:52 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 00:19:52 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aZ7-tTpobKiCFT5L@google.com>
References: <20260225075211.3353194-1-aik@amd.com> <aZ7-tTpobKiCFT5L@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 00:19:52 -0800
X-Gm-Features: AaiRm521_jXlXSJX-4uKdrVOZ3AmqJAuqV9X1wXlubDjr97NXoS5-0me4TVgZLc
Message-ID: <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
To: Sean Christopherson <seanjc@google.com>, Alexey Kardashevskiy <aik@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-coco@lists.linux.dev, 
	Dan Williams <dan.j.williams@intel.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	"Pratik R . Sampat" <prsampat@amd.com>, Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Feb 25, 2026, Alexey Kardashevskiy wrote:
>> For the new guest_memfd type, no additional reference is taken as
>> pinning is guaranteed by the KVM guest_memfd library.
>>
>> There is no KVM-GMEMFD->IOMMUFD direct notification mechanism as
>> the assumption is that:
>> 1) page stage change events will be handled by VMM which is going
>> to call IOMMUFD to remap pages;
>> 2) shrinking GMEMFD equals to VM memory unplug and VMM is going to
>> handle it.
>
> The VMM is outside of the kernel's effective TCB.  Assuming the VMM will always
> do the right thing is a non-starter.

I think looking up the guest_memfd file from the userspace address
(uptr) is a good start, and in order not to assume much of the userspace
VMM, we could register the mapping with guest_memfd, so that when
there's a conversion or truncation, guest_memfd will invalidate the
registered mapping in addition to the rest of the mappings being
invalidated.

At LPC (2025) [1][2], people pointed out that needing to force unmapping during
page state changes (aka conversions) are a TDX-only issue. It seems like
on SNP and ARM, the faults generated due to the host accessing guest
private memory can be caught and handled, so it's not super terrible if
there's no unmapping during conversions. Perhaps Alexey and Aneesh can
explain more :)

Will said pKVM actually would rather not unmap from the IOMMU on
conversions.

I didn't think of this before LPC but forcing unmapping during
truncation (aka shrinking guest_memfd) is probably necessary for overall
system stability and correctness, so notifying and having guest_memfd
track where its pages were mapped in the IOMMU is necessary. Whether or
not to unmap during conversions could be a arch-specific thing, but all
architectures would want the memory unmapped if the memory is removed
from guest_memfd ownership.

[1] Slides: https://lpc.events/event/19/contributions/2184/attachments/1752/3816/2025-12-12-lpc-coco-mc-optimizing-guest-memfd-conversions.pdf
[2] Notes: https://github.com/joergroedel/coco-microconference/blob/main/2025/optimizing_guest_memfd_shared_private_conversions.md
