Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539A191484
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032843; cv=none; b=jkD7JThQbzaezsW2jOgHv3MJfz9sQ/Z38m+NPAbz2WIcdx7eAA3peCQw3+dqxLWYphnDs291ExXBLpE6JdPsnZ1n9Cn4LBwrejCtXe+aAftUhCpVfiN3uKYA9EStuwVttJRjr6u8KZhoPlN80U4xuK6RzwwRntLfHQoXcZmBhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032843; c=relaxed/simple;
	bh=T1jo7Zrlo4mLt8ZBkLRxTxtANdZbWXej6AfFl76Q/ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpqoXU6Oxe5cP9qJwlXFRI397loYu3HsgjDbMlRIuzDuEOuVN5arNRiy47gAZk4Bvm0uQm/vTdESTkSKvE/oaKD8+pvddAL/opAcKPKb5AhZzdKpXtHgIul1tyuh/fWTO/eTt5Zuqdh1UoQLmmWjQImj88Ic6bycCx4sMf0zSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=ksjjtp36; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="ksjjtp36"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591c98ebe90so6156190e87.3
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1764032839; x=1764637639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1jo7Zrlo4mLt8ZBkLRxTxtANdZbWXej6AfFl76Q/ko=;
        b=ksjjtp36VItzSDL32gefbNTaaispCvCNVQKZKAwcPIE9EcuMNV+26PNxJb5yP32Gd9
         4HScbX1dh4MwDSydNTyA/oollYxH6RpjOS3P1Iw6GMlS9oCS76SjNZQ9I411E3JicDBW
         pemiN58xFqhTSMJteXgZXc6ZPxJUHY2WJsZSyViB+KaGXQf17Ep+nEbAdCL07a8RDaS0
         vZ2O1NXOyQe+t2xZSUUvBADFCTVw4HSoZoh1diyQe0UGpDWndorX+9YVgeYndjPsb0C7
         qGs7KyZRF05NFrrGwn4jQPKtgDnH5t18mmYeJsOeryxAo4pqJdXVe1vDL+CBWdn6TtbP
         FZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764032839; x=1764637639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1jo7Zrlo4mLt8ZBkLRxTxtANdZbWXej6AfFl76Q/ko=;
        b=J2r3pZAzLXBXi4ozmKKM6ZN1zONmB9anTKpu6PHaFLfp8gUax3FZdDV0t7JiluAumP
         YFUi2qOFMfpk87aYkzvOXhNlaGXNB+vsDNT8AXu60yqBqimos7hpDkUhXZR6nKUEt3h3
         2ioNXJtnMyJjvthSxTsw+SaYy4qVAJMTOzSPq16t36uvg1DOXJHJHfuI4m0ZYmzsdE+y
         VfDmo0avlpRMFzjkIs0eh2gT5V4HmnOdOmNpmMbrTpnBoFmlMzQwCR0csA07iN2cMEIN
         04+V2D1JMwrXBO1/sPmlAZbCRJdVgBWi35/+X4rsCjgIpnPi6fvB/ywkUImuGHt92opA
         AGqA==
X-Forwarded-Encrypted: i=1; AJvYcCV08YPPG2If608SotnqcK7YlFbC7rCIBpWPQAwa6AcPSCzJDjD946Eyek02Yll0tDdROz+FdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/9piJxkIvaVIlbOYEoSYiPF9GKR31PaulKDKRmkx57Pb+ipzi
	5du58St/oXGlaFowWXvabJ+gB0uKaePpinPYn+nHoZ4sVT9ZO35YrZye7DzRIFq4t8yaLoREI36
	cehogKaMP02Y96Vs/FL7gNMeCpWDNljbA7ctYsr7tUw==
X-Gm-Gg: ASbGnctQ+ivNXozsKHdFCjY9j26DlDj+Xt6VmYi6OIyyGtgopzLASVGxOfMpF5YSk7R
	EVv8eIVL3P+O/tV9KlT1Jjssq57OiXDv+kiiqv0CdoLi9+Kqdrnj+ebc3EisFopBmABQKkr6V64
	Max5zX9h8yZhNaK98Xe7Yc7h7pqqXppQE+muAZpY+JfUsf4V4Bfb39pr6EJ1RFzya0ROHFbpm83
	GT4qVfJFx+yJHl2HmyRbN1ElNPuU8lHnlAbrnPI+gNkkMZIAwsJ3l4MWsxup/zZHkob3K+13bAP
	U1C6Bg7eP2W+JVQqxaa19WQcEA==
X-Google-Smtp-Source: AGHT+IEWfPG8AohEqRDLhLe11Aamo9h/t64fP7hYConoFy0B3LY73Pz7fdtRA71Qy85UBlV7qKD7oL8EynapHvyL+Rg=
X-Received: by 2002:a05:6512:3ba3:b0:595:9d86:2cc7 with SMTP id
 2adb3069b0e04-596a3ed966dmr4044716e87.39.1764032839205; Mon, 24 Nov 2025
 17:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251111051952.1985154-1-aashish@aashishsharma.net>
 <aSSP7sG0OMFGElS9@willie-the-truck> <78b9feb4-f756-4d44-9472-95ffad58647a@arm.com>
In-Reply-To: <78b9feb4-f756-4d44-9472-95ffad58647a@arm.com>
From: Aashish Sharma <aashish@aashishsharma.net>
Date: Mon, 24 Nov 2025 17:07:07 -0800
X-Gm-Features: AWmQ_bk45BRU6OS1ZENqv0YMViHPvZdqqeTu5zTH2Fh-r-8wdC22Xjb2ucpFIZ8
Message-ID: <CAOUjTQukFZd2bgB67u+3gn6b4S3RLur07+iZS3fiznjU26e_+Q@mail.gmail.com>
Subject: Re: [PATCH] iommu: Remove redundant null check in iommu_iotlb_gather_queued
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Dmytro Maluka <dmaluka@google.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:16=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-11-24 5:03 pm, Will Deacon wrote:
> > On Mon, Nov 10, 2025 at 09:19:52PM -0800, Aashish Sharma wrote:
> >> The callers of 'iommu_iotlb_gather_queued' always have a non-null
> >> 'gather', so we don't need to check for the same in the function.
> >
> > That's not obviously true to me, how did you check it?
> >
> > For example, msm_iommu_pagetable_unmap() appears to call into
> > io_pgtable_ops::unmap_pages() with a NULL gather pointer.
>
> Indeed I think the only redundant check is the one which seems to have
> snuck into __arm_lpae_unmap() not so long ago (which the other callers
> never had and still don't.)

Apologies, you are correct; I missed the invocations where gather can
indeed be NULL. Please disregard the patch in its current form.

However, I'd like to share the motivation behind the change, as it
might point to a semantic fragility in the current API.

While auditing the ARM io-pgtable code, I noticed that whenever
iommu_iotlb_gather_queued() returns false, the code immediately calls
io_pgtable_tlb_add_page(), except in __arm_lpae_unmap(). This
eventually invokes iommu_flush_ops::tlb_add_page(). Many
implementations of this op assume gather is non-NULL and dereference
it directly.

This creates a confusing situation: iommu_iotlb_gather_queued()
returns false for two distinct conditions:
1. gather is NULL.
2. gather is valid but the queue is empty.

The callers, however, seem to implicitly assume the second case (empty
queue) and proceed to operations that would crash if gather were
actually NULL. For example, if __arm_v7s_unmap() is called with a NULL
gather, it can lead to a crash:

__arm_v7s_unmap -> io_pgtable_tlb_add_page ->
arm_smmu_tlb_inv_page_nosync -> iommu_iotlb_gather_add_page -> crash

While the lack of reported crashes suggests gather isn't NULL in these
specific paths, relying on iommu_iotlb_gather_queued() to handle NULL
pointers feels inherently risky given how the return value is
interpreted.

Do you think it would be valuable to refactor this so that the helper
strictly checks the queue status, making the callers explicitly
responsible for NULL checks, like in __arm_lpae_unmap()?

Thanks
Aashish
