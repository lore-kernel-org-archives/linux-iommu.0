Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593817;
	b=CHHPFj/5Gn6DO7Avp4U8Gp7eHpZP5fHJAbuhImvRkcLjxs1yv3xJ0BhK21YSLVUzC47A
	 y3bRkmJUy+cghxT9OcDArC36YkmmIkhiuJ+O5rVmAWIy1tSX2+H7lzUZgcJCTfWfm53bz
	 2OVRsQrnHLgljSlpd6pfag+S3CnLf0m46mayVlnGlLEgDNzap1kyx0irYvdSK8UhEoXas
	 z9OnDCtMVcX7+sqrncSI0zh7UhUxD90qFEEVKooSQxjcJZqlKFpZDGsMOVbEbuvX7q8B9
	 q8C0HuStlTpELkTdm5PMgOG69CnR02rcjdVjihpk/NvSFGZXo89TucPYw6Tf/Hrskvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QNDs9IQfET5nPgzLBLhmWzmWUMfQlNAVK09is5NvctM=;
	b=OQi5qR/lYwhXLJ33gQ16ey/Im1oASwJQoabVXPO1npjvBcbj7rzHHdOfkuVmqsqKNcrX
	 L705+EGsQ0yF2/MzxLhO+KjDBMxR6yM6M7HXMeQJKCUm3hMnI6z48Ha3aPNctF9ToDTM8
	 KfTFiQSqS3jxufrYQIgLqVsvOwE/3QoG53Mn+FlSQEj609G4996IKZmg1dHT5NGYLUuyp
	 X0T45U53Hy9jw5e8b8V1Y9vqMTNZVf89p4ZZSth2cOwUYsakDE47X8+IHMoU58l0e//XW
	 UX54M24eojGxF8pUIZ7hdy1O0Y0txKXAtF/EPSJ+8j4psSR64w7XMt9p9/vevZk1Tog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+Y9wQbZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4811606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 08:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4811606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+Y9wQbZ
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b3f9cbafecso737770a91.3
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 00:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593816; cv=none;
        d=google.com; s=arc-20260327;
        b=JVRniKY4qgxEpulQOTniBExoxTBIQB/aECHnDLnGvYjdfEX9qb+aMEvLKg/hNlsHdF
         fa0bBRKwx3+qZsUCTU22EpntiAm7g/gf3of6ZcthL+948zrdW8hG5pKWhCY0cy33epPo
         7qZfXlk0SCLvoYAqPIBj2RRwIj5PquFHSISNmVs65mdYAjgRkm3G5FN/MP5wZn2lzPxx
         8LZ2xhuuofBTlue94bqA7jM1H1laonhoFGcOXVQ9OJWz/jriBeWRZosDgEQE2c/A8TXM
         2uPSwQ3dHuEZ+L6jk6M7UbFy6oEACeDyfS2DdBg5uMm9VqSM6J2QRf4iGb1CaMDtJPZO
         dyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNDs9IQfET5nPgzLBLhmWzmWUMfQlNAVK09is5NvctM=;
        fh=A81aw07oggrBSJ2NrEsOgsqhauq0wAmNtJdGCrWfJek=;
        b=hGmGW4/1uMV3zzfqgez33SSfNXW6aOR4k1mxv2gxrKNOlKe3xIoN64Al1D2OwrTnNp
         cD6GheBMBc9GyXeIXNkGeu9uPKQH2piOh8rWDRvKYvP6V47zUcdyBnDPddARNpDZq6X5
         rInRVBSrmlVxOoZOcLt1rDgm51GaeSNB65boyoASEp+c/sMp0+oLiYnzl9e5wBfx2yx9
         37A791dQCpHE0aZ3YBz+80HVLnPnKi2YFYqwC4DLcgLmB9aNoEksk4B4j2NEjgYAYgfJ
         L2n+Isc+OyAWAhpZXgRU9vRGIA5P1GLdkelnEEkmCfrKIqNkswTp+TBj++blSf9iLFdL
         ZZaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593816; x=1796198616; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNDs9IQfET5nPgzLBLhmWzmWUMfQlNAVK09is5NvctM=;
        b=o+Y9wQbZNbtMcq1NsSFYHVCTu4zTguLjUWZjvoWty9L2BfLs03wI15v96Bx9PZJTeT
         ngyRlCTJb/ZjGbviXakAtV5lvRkfdxdgD+3NVmGZuldRDX2iE/9lmoFz4rKkCvV/cUHM
         ffPn02UoyNG+UuD/FSxlVMw5SPPTQf40/JQLJ6gDDB+O3TMGWP4CqxWMevhYQ9ZpMt5c
         gnUd1QJxWt4tgCNgZacTbTJ0zvuQGti3Pk5rCoSzKD9+IzvbiQYWB6KLWa7ELsDd45/p
         ITiku2Xz6Gt9/fffY+62fHIuA53MQW8V0rWtvQDMO34yGIpMQcfMWpgafmC+lC/zg7nR
         MyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593816; x=1796198616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNDs9IQfET5nPgzLBLhmWzmWUMfQlNAVK09is5NvctM=;
        b=vm5AGzQ9kcm9uK8sWtSIbq3NQ7LvYjTAAPhV79Gni32rhB9kF5dTtps3qcZqsp8mu6
         JqosTK0rwmufrAg+9YeHLBxgkmOu9cmykO8+lBk2dqzRgB3Y/xJWGvzpTyFlG1tFaFlb
         vUb13fvw1sQlo4LPPXGxcf+/JLAfBtwsTOXwA8XLGjBBE9cbEFxZg2Zoh1o8Q98u+/ES
         KAqurzfIvrm9hh51d+FdfSJGDq8nudYfk7X0IZDlub7UtrSqFCiI/vOt5ZVbvZNuoj8x
         PzCRz7y+gtGx6hY//TwFcu/IyupzJ+yKr+YTy979LeZW4UQnHUyGv9Vs+04ORZxMkJSQ
         5QcA==
X-Forwarded-Encrypted: i=1; AL+hErGMt3yajAxR5Le2WcuWkGxrcEVIbvgla0xoAMNKR8ykACxajb6ttqtMOaBpW9mvcN14wX1jzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9fRwYxgztM7JWeWA53Sgsp2trSqzPHhIAtxLPj82vgxo26ZYVO
	uvXYUnX5+7MwJk8GTdXnXBasOlmwxK7GkpP99nwgU3IRpmGA+VdrneCmHEkT5N58ByuJFo25Aij
	VWucJ0qHH75calEdaUkbiDt+5JK1xXYA=
X-Gm-Gg: AZFdTZektI9EOPnt++r+jLG7U9U+nuViVTGqm4pCysA0Go3xVDNdXGSjBX+rEE//5mX
	G7Di/uV15yfSaQsFrfW1+l2YMe5CuSKIOlFqIM4Id2kGcSV3yChl13allinSnByrlJBUP/Z1o8Z
	f4KIMum2fLKMqB7g7aPzfU6y5lIIyzNM1N6kR6tTr6H+dorfFpM4/9EQnmPMSU3mJt5fRbI1aq2
	pBO5SooQMoIRHOR68rgkzxMaDUdk86eFNNAK+wzkbJL7biZz/kizBLIveNGCyugulHjKyzsP2id
	QN8OiISGsozcQxAArNa19XELrIPlsrF5NSpxG9k4zXQdtEAnaueg8Wsx0Q7HAbNZxbgIAsAuPpr
	CgfE/pxJwX8ZLeUorU99o6VvTtORJkahPN4AnevonYl1Cw9SyiXG1D0f9F6OD4KSHQbCqq9gk84
	1Rh9I5gLwvM2/v
X-Received: by 2002:a17:90b:442d:b0:3b0:d0be:f02c with SMTP id
 98e67ed59e1d1-3b41c98a095mr26505625a91.6.1795593816031; Wed, 25 Nov 2026
 00:03:36 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com> <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
 <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com> <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
 <4420a997-82e9-43e6-8ceb-5ede44594c51@linux.intel.com> <ecc47f2f-d0ff-4aa5-9d46-6a0b9ed8c468@amd.com>
In-Reply-To: <ecc47f2f-d0ff-4aa5-9d46-6a0b9ed8c468@amd.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 25 Nov 2026 16:03:24 +0800
X-Gm-Features: Aa3M54oVnmxp-GwpSucJqDs0BCYTl-BITaPoTpOvLRhz7vPVh1iZnm8zpKOg-jw
Message-ID: <CAH78Gvvf92NrPTYU=hMs92FavwX67NpgeHBRqZ6TDziNg45-tA@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device removal
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Vasant. Patches 11 and 12 cover the teardown paths I was
missing.

One question on patch 12: when the completion wait in dev_update_dte()
returns, can a PPR accepted under the old DTE still appear in the log
after the drain has observed it empty?

Happy to pick this up when you post the follow-up series.

On Tue, Nov 24, 2026 at 4:53=E2=80=AFPM Vasant Hegde <vasant.hegde@amd.com>=
 wrote:
>
> On 11/22/2026 1:09 PM, Baolu Lu wrote:
> > On 11/21/2026 10:13 AM, Qihang wrote:
> >> Hi Baolu,
> >>
> >> Thanks for confirming the VT-d ordering bug. I'll keep this series
> >> withdrawn and won't resend it.
> >>
> >> I still have one question about AMD. detach_device() calls
> >> iopf_queue_flush_dev() just before amd_iommu_iopf_remove_device().
> >> That flush only waits on the iopf workqueue, while the PPR IRQ thread
> >> runs amd_iommu_poll_ppr_log() and reports the fault through
> >> iommu_report_device_fault() directly. What ensures that the thread has
> >> finished reporting faults for this device, and cannot report another
> >> one, before the device is removed from the IOPF queue?
> >
> > + Vasant
>
> Yes. Its a bug in AMD driver. In fact we have bunch of issues in AMD driv=
er.
>
> Below series fixes some of them.
>
> https://lore.kernel.org/linux-iommu/20261105044801.399466-1-vasant.hegde@=
amd.com/
>
> I have another series which handles draining. I will post it once above s=
eries
> settles.
>
> -Vasant
>
