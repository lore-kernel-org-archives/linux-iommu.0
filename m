Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939447;
	b=kt6eyTYovAys1o9lGuKd1srT11jkSkyuY2dseanIEz5ihBgB97uifdE5bOWMwW8Ejwz9
	 +s4xGIOlFUrxrJUCDVOwxAcOvlkwilqSWKwqiWiuj/DKxXVp329t5w0Ye20iQvC9mQQV7
	 Z6Q5VQJM17h8uk3mvnWw8CrnckHh5OcuseV7nM+rVUIZmdi33CMK1vt4Rj67qHjBCSkjw
	 eTNB6wG0a81SU3Vi0wTEaNMauWN6XirEGcNectf3r40TVNJ7zjnYwxxgNeZyxMAob1OpQ
	 2FdXbUnCNgJy7w1kGXlCGFY3vWsHJbTUeW/Nc3fpmBL+44PIXYKUULFDs5NkPNKwvkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
	b=x/41x/cr+OXZZoiRDYGo9VlXvQpRv2FBafObltCL3ldO060F2cXWznf0PbmhLou+cqf/
	 hgCMu2iGznqVHgTmajSD9BojVOr9WGyid+QNCazgjRKB6FTWKN4r6DvuFp+uibL6eUWui
	 jbZLd82BsHYaYwF0IhJPTd8kcW1wfOcZyqqKpMQc6D/EhQwijrw0B9xp9nF6ucw6FvlxL
	 34CxC8LJF6emR96LiQbvLT53WaeLoPmBhAsymCOWNt0/1/lrsjwViHnd1TzxFbSSwysfj
	 2NaFCcZ9lTzBXjhNl9H90VjXtmeM1JoSBI4IOsDigBjnqCzwXBjhQHditvO+GJxGO1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YXcqM/54";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4104606A33E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4104606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXcqM/54
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ace2e3a2acso1390251fa.1
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 20:30:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793939439; cv=none;
        d=google.com; s=arc-20260327;
        b=I7qxoGF4ydvkEtCdluBHOdBubQp3wF+jALLcgznlbibF3jdZ/pyLIxoYw2KAAwAIz5
         gNcMRZDyav5c834ZUQAqp6AOMjuteC2glzEgOQ+XxuCeI+dwlH68/XGopGma9mmtojwe
         YdqLJp6LjurT5FwL+35TwIKGufS0qpPvd+U9n+hqYKkME9jJGltWo3zs3KXQ1hdXbOKM
         Z6wKoGSBha5/SPu12CgDNNFlWt0jXWXcGnu/QX4BuJOXHe4etRqIvY6LkPic14x4FLZM
         rknYYL5o80aDa96Ctyr3ukIKWmrey2QzCMcxovIaccjMuGFTMdNToZko2PYFlfLYX7Ml
         kw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        fh=6omyseleiYWaYZVpbEo91V0kzxmWLbrtjk5u87I2vQs=;
        b=jQfMK/4OpaRpCRFP6uL0XRb/jmNPL9otPd1wji2ab3j/fqviIx7992zWeVtjdl8xS2
         Tju1UBNWQHqiouW3mvGjCMJpiNrN4VdWDRAOfk9EbHtlN+R5gA+R8R9PyfvTHoiaK/IV
         +77BUjQJDv5hQ+PHB2ZanCZWAGokIuH5+lA+NneR1oETgSpXau7icOn4qVtVgV+SFSvQ
         VVa4kviBsYAog4/i/pgPqttevUbhPRKJ/q61QR9MjJpXV5d6EUA38Ymu/OxmvhkX84H9
         Ohsg6WcizpuOeenD9/l5aER9yAYDmYqI+j8UXOQ7iZ7EnmiP47e63ggor096slyAoaPW
         aHJA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939439; x=1794544239; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        b=YXcqM/54dQzpthUqrx0bLm1hAh3cz6aVgiItfkhTmitMqrDXzmSZrqYFAEwCJ/OgBV
         czjaQk++vOgwWEKa0JsvTqa12JhtChz3V7TfMFB1D3YtEUPv0tPAtPDWo0YuCQ2Y2hva
         9zEy1L/EbxHlW2y1nK6foRDRDzj/IryLPe3cBIzEPKAQXsKT2zT8P6aTZ2glMS+9TWTe
         1Vb4lURQK4C+wDtt6/AP83QPqIvvpkYamfEn4v5hYRyL28s8CSdQ4uGilbcoY3NMTLmT
         4vDntCrmWL71Vf7mmvH9ST0voSCnK+3Bd4A6SwFVYBMkVwKUA3NM97UZIsEwblsIYyvX
         tImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939439; x=1794544239;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bZ4yl/FmN9vHR0lstk/51fTiXqlhJ6EnDHaciWBTDCU=;
        b=Hr82Jiub2bSk7mSrAupcDCJJ09yxlUPDsZNwSSV15CIhvEvIAVe9LKC+SEN/go8jte
         OQbo2MzqaI6Yc5G/7VnVsSOdtlnAy+e5mfM6Oj2EEJM87uf9hKEWNKzzUxhGOYxfr58a
         fs/TAVlCbSe3Vus8eZjSX/cT8reYCQRo0RJjiNFLxrb+rDB1rNMYwNvy8fZ+zliglTZ4
         hLSKIehdlYtvErw+ptM8Ez0/lPH0fO/HRN3LZMNjQszXoFQxa+ojkmUo9jDrN6X2LO5F
         Nv3MYLtarojOHV/azRbQ9zeT17MbDX+kO0dftzjmRSgRxDZPPf1WvXpAE71d7KENeQH2
         M1vg==
X-Forwarded-Encrypted: i=1; AKwUvBxj4HeSDZURxPA9mF5xBxfQ1dIK3RgXaHWIIweWHmp+ogU/ega+FHVZWX+uicEERTXqI9ApTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8wUO30Sd1hK/tKtvIZZxCOOjmpjVeQ7q1Ffd4Z6pvgdsjq1Jar
	iy6SVQTNIyaRWqtj7FjR1axcgRFer2yvDQUr0vXeKwOmOwe2BqB1QQQHKH+N3ZtPoNoncoUlZrv
	huFLow9Va5/XHX2Q7517CbXFmYaWaXRA=
X-Gm-Gg: AYBFou3HRuKh2+gur0dNKnnj8xAQ1ZwNnWq/ZBL33dCVHsmgabmFyUYOFkiv9XSjk5d
	o/1yX12lcHWL48kOGjA195uZPCAvVTT0RDrG/9HPwmNFq/fNTOrtXUXvlJOtfxfKWSsrYPvOR85
	hTJn6tGMpOJuRLj0fdRwneaDLABiCQ/eBqfevxtoh2MSfcro7rzhV3myB2rHpU9rNU9qOLzTmLl
	hEgRRA4F38jwEVY2ktN2CAEVbhn7rmHs+hG88bPHdHooroSnfObCYNreBR0lmY71Tza76zVbZvY
	LCZc0dChS/KIahVr4Wc7vQ2Spzt7NQ7G7rbAmOSnsrRdasX3IQ3pe10x66GYiWs5O3wTbAwZEDK
	bSYdfevN9sl1EZtQAl8tNFG8NDMgjQu7LHKRx
X-Received: by 2002:a05:651c:1466:b0:3aa:fd7d:6164 with SMTP id
 38308e7fff4ca-3acf3d327c7mr2354821fa.25.1793939438713; Thu, 05 Nov 2026
 20:30:38 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105192738.70664-2-oss.patchbox@gmail.com> <20261105141427.00005946@linux.microsoft.com>
In-Reply-To: <20261105141427.00005946@linux.microsoft.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Thu, 5 Nov 2026 23:30:27 -0500
X-Gm-Features: AclHuK_mkkVdBlDxyx_u6RLLv2wIIoQ5_PS9z8DWzBm3NCMPC1YbiMhFv5f354E
Message-ID: <CAGG=RgBRojswF0P_YNFaZET7b8W0MnDAEN=cH9J4xLn0vUkxzQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 05, 2026 at 02:27:08PM -0500, Yuho Choi wrote:
> > hv_iommu_paging_domain_free() frees all page-table pages with
> > pt_iommu_deinit() and only then asks the hypervisor to delete the
> > device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> > fails, hv_delete_device_domain() only logs the error, returns the
> > domain ID to the IDA, and the domain is freed anyway.
>
> Isn't there a WARN_ON on this path? I recall asking for one ..

There isn't one yet. hv_delete_device_domain() only prints the error
with hv_status_err(). The driver does WARN when a flush fails or when
attaching to the blocking domain fails, but not when a delete fails.

I'll add a WARN for the delete failure in v2.

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for the review!

> Looks good but I think it is incomplete.
>
> if both hv_configure_device_domain and hv_delete_device_domain both
> fails in hv_create_configure_device_domain, then unwind code will do
> pt_iommu_deinit thus have the same UAF problem.

You're right, thanks for catching this. If the delete also fails
there, hv_iommu_domain_alloc_paging() still frees the page tables.

In v2, I'll make hv_iommu_domain_alloc_paging() call
hv_create_device_domain() and hv_configure_device_domain() itself, so
it can leak the page tables and the domain when the delete fails, the
same way hv_iommu_paging_domain_free() does.
