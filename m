Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245733E8C77
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337786; cv=none; b=JendxVsemxwSwJ9mmJq3i8sszc7Dc3Ie+kkaEkBlWAQmMRQrlOCzIvPvCRqgaHhQxqlpQxaXhJdnct6Jk+wK4xPlGrRc+UnO0LUUaBIVJzgpKQFxucq6OhjYDdKQS31SW/i83+4fqSsb1yP2kOLvv5UnaNgLywZvfoH+RIdkJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337786; c=relaxed/simple;
	bh=O8gk8Oab/8Yh/UbOhxGmRmYe8r7hS31rff/s5CMCyew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9LtlxgdWNYPduRR8k8vbEh6dH7l97deOPFlHC+jRBQuiLdKkIL2SlmqyHTmnXm8D6xMPcaST65fcWWb5fjLThfcgCa8pr5+pWQtb8ykTlQqg3pqfR0NqBADK3vwm9bL1IQIC78r6LJX1UlkfkKez3WoYABKL3nldBdoPhbiYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7Qzmgwu; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7Qzmgwu"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e4636205so9935778eec.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780337780; x=1780942580; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTQ3ch2eeCj8LQYYitehSqnw/gDN7HGabo3htxsM7cw=;
        b=I7QzmgwunTNS6C//P5DIyqaSFD8k2Jpim0z9l1n9EMWWw3kPRRMAjNo4jR+MLZt6AX
         mZ2fyteik290ngj5fBrBaIWJ8VVWUuXpnF12W+SWjxlSx93WKKPJLZsCDNvZ3Vqhmais
         iYwUV6RRBHIKD9mSLrO2HVnB8KWVXyBkHITLQtHYlpTlP6mUKL18CtuHH+LI/C3P0hFJ
         FkmGYcmOt/Bhrs8SQhzPjmsKW5BJ4OFdG8huUt3CRjY7LKn4D3J2Vn8HlJUoC9sjkhY+
         1n08GpF7deXtiwSwT6vnwIOPeGk51RMw/iqAKz7TqczckXlX+WzsgCsZun1kytKYW+jB
         a9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337780; x=1780942580;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTQ3ch2eeCj8LQYYitehSqnw/gDN7HGabo3htxsM7cw=;
        b=J3IjXrnjtjo5+IG7cGN+0pFp7VI2nF+j1x64Y/XCBRObFNduZmWMw+8zhIVm80A15g
         +a+1nyzCgUlNT6VGtvqBBucs9dVWlvMMmuuUPMI4jGC57OuhvkJpMAjKS97VTVjuPWF0
         g5uMFIL4ZiOBkWesTZlMklyivVm7ye6UTbVzLxRiBQ/hYLwWzXTHj4eFA9zS6QCA+8mz
         RfudAcMdB4lY5lpCOiKznTQ76y4u8sh2zmdJH1sv+k1wkrkShYqiZ9JCtEQ8V9Xzngb4
         N3QEa8ooMwToEZ+prDJYcmy/17NpTjFe6RVNVjfpB//4wdqr7EZEWTSUBlh1ZDLabcJH
         Iicg==
X-Forwarded-Encrypted: i=1; AFNElJ/7eMfazgf5rHGbEYsZdnhWvsPyc1GCvw7ClcSDlzhjhkfoWksugm1xfEVpAWDbFykTRqshXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhHa+VOsYiqjig8cTrog6WzoIFuIYANa3oUWsgu4lQcnpAbE4x
	MYsUX0QfEMhslyd3YtVQjYLVDSsmpSxn1SAx54DxjT3AwqXLhVN6yrYLl2Z9HW+eBIGosRgphKD
	/Ug==
X-Received: from dybvi11.prod.google.com ([2002:a05:7301:530b:b0:2ed:d9c:cdae])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b05:b0:2d8:df01:d9f7
 with SMTP id 5a478bee46e88-304fa5f5380mr5959267eec.15.1780337779712; Mon, 01
 Jun 2026 11:16:19 -0700 (PDT)
Date: Mon,  1 Jun 2026 18:16:18 +0000
In-Reply-To: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601181619.721505-1-wnliu@google.com>
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map helpers
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 6:11=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, May 28, 2026 at 05:17:24AM +0000, Suravee Suthikulpanit wrote:
> > Export amd_iommu_iotlb_sync() and use it for nested domain
> > iotlb_sync so nested attach paths can flush gathered IOTLB state.
>
> [ ..]
>
> > --- a/drivers/iommu/amd/nested.c
> > +++ b/drivers/iommu/amd/nested.c
> > @@ -291,4 +291,5 @@ static void nested_domain_free(struct iommu_domain =
*dom)
> >  static const struct iommu_domain_ops nested_domain_ops =3D {
> >       .attach_dev =3D nested_attach_device,
> >       .free =3D nested_domain_free,
> > +     .iotlb_sync =3D amd_iommu_iotlb_sync,
> >  };
>
>
> I don't get it, what is all of this for?
>
> iotlb_sync should never be called on an IOMMU_DOMAIN_NESTED.
>
> "nested attach paths" should never have gathered IOTLB state.
>
> Jason

BTW, amd_iommu_iotlb_sync() is designed to flush a protection_domain and ca=
nnot be used for a nested_domain.

Specifically, the current implementation explicitly casts the domain to a p=
rotection_domain:

```
void amd_iommu_iotlb_sync(struct iommu_domain *domain,
                          struct iommu_iotlb_gather *gather)
{
        struct protection_domain *dom =3D to_pdomain(domain);
```
