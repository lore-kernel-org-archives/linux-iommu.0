Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB61F180E
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380340; cv=none; b=RbB6j+Rj+A3oJ1UfBmCmYwJDHtMP1/rLTMKuKIwFcyiYdO2Ri6QvCPwjK4pa9PhflXm9u3F+Nubc0cFRdSK72PZl/Kyc1mecImkuhXT7cOHxBpFikYscfFqE9Zk3gh9pEn7v/wobC+aef8lQ2f8Fn9Db1TU2WJ0vAvbtB6tFvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380340; c=relaxed/simple;
	bh=LcCxHr/aKoOVUR1Sw0imNBOIdr3QEisUuAtNnbOkc3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQ1akdeYY350H+AOCm0hEyPu86Mte1sK+xmQkqfqBzjHy6Hi3lgWbWOQfOkTZuYIdHUI7BoKk1cErNmbWfv6nWcMnGsvNlt4MX/JSHzoX+Nk5KAGwyoY2vYYLKC7jxO+hetOFkTUcreMvF6sgiKQJjnZRhO9d0tUPPCG/3tL7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXzik/Mc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXzik/Mc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73720b253fcso1625584b3a.2
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380338; x=1744985138; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NggdV5zQ72L1tKbHVRgRvou6wNmW0trj6aXwwFQdZyk=;
        b=SXzik/Mc0DwL3Lbw/NvN2N6UvUsm2eDu736sE3EFRuYoQXBBnemv1R3h4S9fbH2H7B
         oaOqF1SurnZnJCK67qzPNQHZzdjM6Bap1kqgAuqLxOfLrz70Iy0cd8iOWPWD4zVYbQyj
         MzuM32yon//mZSNaHJBotgW/2A138yAWZMHkVGkE3G1HJlfrmI9hbeeUrGqgnXTZgORP
         DPRpbS0P5SGFV+6W6wjWkg9Xhha6D6a/VLYB5quz/FfQMbVMFCv6AuLn9qBjunjz7cxD
         dhnEfskuyOiOJuJv71Kz/TqtKvvB5pig6RfbTlkyjTuJ7JSs5fai9CSU/79EcyKDrUNp
         aJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380338; x=1744985138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NggdV5zQ72L1tKbHVRgRvou6wNmW0trj6aXwwFQdZyk=;
        b=jretU/ryHvjopcGA2qYMRE3LNMYW1WYl3MtGKNyfmsujF8A19SWLSpaNNLqWzTBIzs
         +OWLbDcU88kf4Q9bO6XzJHuz8buRLadRaMzSfE9IgYgTzOy5qQbclcb0DjMz2PnDVRiJ
         BShwwDCRW1ryygKt77rc97H5UAqgRqZAPtfpSZ3ZipGWIJrW7sOPwpmbFz6vPJ2zzCtJ
         MjVoTxJ4dk0zPR5bDY9hYWGq0SHLSLOc1LqhSk3CIEZldZSAm35Our7INiLwxyhCo0p1
         DoizL6yGrYtKyEp7n7eqHWPai8CL+BvS/ciZHbG6j4y0A23mRdWGRSQRQLEET5dVxySL
         xz/g==
X-Forwarded-Encrypted: i=1; AJvYcCXQX1NaAkoszGwXUDtPK/HRVk1HyOhHz8cC17v4andGpyPlA8dcYjRW7n3+/zTBu2jaCKFPuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9dlyjomeSD5mk9S7Yrwv4pEnFH8Xql/9HxYoJxwz/PwETnu60
	iXwfthfegdajDXvDlL/5FwnCh3ezWiPEqVtkurQTceL680HraWxqDqs0P8FFqjdQsH/2gNaBqF0
	ceg==
X-Google-Smtp-Source: AGHT+IFjPBn8fKWi3Brtj7UOiEH0emgtsawhip261+cOAlJwse7965CBbiVxkrP/JH9W1Oa/e0ROd9eyYMQ=
X-Received: from pfbgj26.prod.google.com ([2002:a05:6a00:841a:b0:736:3d80:7076])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1387:b0:730:75b1:7219
 with SMTP id d2e1a72fcca58-73bd1202f32mr3762228b3a.12.1744380338381; Fri, 11
 Apr 2025 07:05:38 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:05:36 -0700
In-Reply-To: <686dced1-17e6-4ba4-99c3-a7b8672b0e0d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-6-seanjc@google.com>
 <686dced1-17e6-4ba4-99c3-a7b8672b0e0d@amd.com>
Message-ID: <Z_khsNAbh4kIhKVC@google.com>
Subject: Re: [PATCH 05/67] iommu/amd: Return an error if vCPU affinity is set
 for non-vCPU IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Naveen N Rao <naveen.rao@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
> > invoked without use_vapic; lying to KVM about whether or not the IRTE was
> > configured to post IRQs is all kinds of bad.
> > 
> > Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   drivers/iommu/amd/iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index cd5116d8c3b2..b3a01b7757ee 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3850,7 +3850,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> >   	 * we should not modify the IRTE
> >   	 */
> >   	if (!dev_data || !dev_data->use_vapic)
> > -		return 0;
> > +		return -EINVAL;
> 
> Hi Sean,
> you can update following functions as well to return error when
> IOMMU is using legacy interrupt mode.
> 1. amd_iommu_update_ga
> 2. amd_iommu_activate_guest_mode
> 3. amd_iommu_deactivate_guest_mode

Heh, I'm well aware, and this series gets there eventually (the end product WARNs
and returns an error in all three functions).  I fixed amd_ir_set_vcpu_affinity()
early in the series because it's the initial API that KVM will use to configure
an IRTE for posting to a vCPU.  I.e. to reach the other helpers, KVM would need
to ignore the error returned by amd_ir_set_vcpu_affinity().

> Currently these functions return 0 to the kvm layer when they fail to
> set the IRTE.
> 
> Regards
> Sairaj Kodilkar
