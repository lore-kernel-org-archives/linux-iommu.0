Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340C255247
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151114; cv=none; b=Ip2yqBZBSM4IDo3/8GhEXVUe+3wzTs2WdfFJFXI5rHY+1CNyF99tkJVOXT3HYDkc0ejeyN+S7JxXXCsr3yeZIZtgvZiQxfUGyW1zjA7HQ0sphHw9QWnYOBnWpATzOXtj4u6QBx4LkpOtMG467anJAmcV35HfFbzpDDQsL1+lIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151114; c=relaxed/simple;
	bh=ccAlpK2GJ8AJvkq+fowLZF3c1eIeInVWDTpL7xW7Uc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnWk8pNxLZPe3PnYqAIMEibMj2LMhHUZ1NDs/o4b7+hJwUlnBL9IEREEKroUmMF/deovr9AjhLlC6/1L0FPaBTIaHk5WKqkc6Yo2QbwxOSVzTQ728pRq5y6sLqyKfJuVm0khndvjVVBZVtU26euFRoHrhhNo2/0WamB+VT1vgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBgjLumj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBgjLumj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73691c75863so7648233b3a.0
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744151112; x=1744755912; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIgnrXOk29PXtGhJ0MJfZMA68k7F5ofitj+uGIUhqWQ=;
        b=pBgjLumjeUThdSbFAbPa7cuBJYsiBBuXju+YDc4d6t2/Xqw2bfAJqBBRCgEfXjMtU3
         gfC9g7vDYZEWLUT5+tBOvn/92fnWOCjKZdxuOiNDLrrO86YQMDwyIaMVqXhqOrzhF+sz
         s9WoAXG+lXlhFcxWsI98pL8W8plioTfR54S33weQbHrJZeXQYtey5EfFFNpKmz4tMXb9
         5NG2n3+qRc/NrFld55bDO3o8bUJyP0ZaOkQwf+nwpvlLOJVKOtmV/tUkIyTO1dVFLLUo
         0nRaTKwsJYpGdMzvVIbGQyl15XoS2rg+0brW7OnJ6ng1NcVmVNS/PkX6e1zl/tqtVkJI
         oKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744151112; x=1744755912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIgnrXOk29PXtGhJ0MJfZMA68k7F5ofitj+uGIUhqWQ=;
        b=fUk47kOjssSCn05mMDwBDUCJ7osrSgIXVpt8ZnUK+AcxUTMbxjvWfuk/4B+0nlPag7
         R9uAYQYgvshw1zbFq8HVjZUlnrWT9hv+ZB64hP9xzKDdGJ4wkxCSJ6oZ77sVa1r3ahq2
         E5ExrR7Jlhuo7KdNp9OCwLByswAgRo1L4ihYMzhEJapn1UCJ4EoJ3GJW1mSat1iHAn5h
         scTBpfuRmrn59LBb1MebDlRvKZSnfh3n8qBnfsF3W71Xcs0juKMI1Fxe6adopgZTwYxy
         VtMIzYPD+7RVTixzxjcAh98T0TT267J04GKoIAyuPnyyTRtAqI1JWrNa8DA8FHkIlc0i
         FGuw==
X-Forwarded-Encrypted: i=1; AJvYcCWVAdHsc6+20ewovVpPchAm+a2toic0qNmDVb1/Ozh2S+QJIYqTtXjZKLmD0UnLGyeKQ0Grmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXzjAkLhSL/oI35k83V2EU/J6vfSNtmvb+RTz1BovSx3IsHJzb
	Zw1i0mOun9LMKPWrKwrgZUDlYOwWtoCIUe+VYFve2P0ew6lFgvgeLyxf8z2D1hi6Byq3mWc7XtI
	cpg==
X-Google-Smtp-Source: AGHT+IHTqPfvPHA35LrKeVma6IN8V+jh3iCyiyfrKN6jlTE/sMMd957ClboQYBC0BvqEPRp7vq7SpPie8ks=
X-Received: from pfbef12.prod.google.com ([2002:a05:6a00:2c8c:b0:730:796b:a54a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2285:b0:736:baa0:2acd
 with SMTP id d2e1a72fcca58-73bae55297bmr811030b3a.20.1744151112304; Tue, 08
 Apr 2025 15:25:12 -0700 (PDT)
Date: Tue, 8 Apr 2025 15:25:10 -0700
In-Reply-To: <8b061b2d-7137-498e-93b2-0cb714824d7b@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-27-seanjc@google.com>
 <8b061b2d-7137-498e-93b2-0cb714824d7b@redhat.com>
Message-ID: <Z_WiRqRjNzmrh_YP@google.com>
Subject: Re: [PATCH 26/67] iommu/amd: KVM: SVM: Delete now-unused
 cached/previous GA tag fields
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 08, 2025, Paolo Bonzini wrote:
> On 4/4/25 21:38, Sean Christopherson wrote:
> > Delete the amd_ir_data.prev_ga_tag field now that all usage is
> > superfluous.
> 
> This can be moved much earlier (maybe even after patch 10 from a cursory
> look), can't it? 

Ya, I independently arrived at the same conclusion[*], specifically after

   KVM: SVM: Delete IRTE link from previous vCPU before setting new IRTE

[*] I was counting patches based on my local tree, which has three extra patches
    from the posted IRQs module param, and so initially thought the last dependency
    went away in patch 13.
