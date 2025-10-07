Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28614155389
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859685; cv=none; b=Qx81fqtXjxbzTj0IwvlLtWdXACWCwU/8TBWRS5cqhtTu8m96gP+kiI5E85voOc1Mk9gFPG5n/xqRa9wWLxvifixmpcPRxo47UjdFUjUWUBxybTA1UWTZH9R2p5CKvYSLUnl2Wo51+Drgoj6TPm5wpaAaXw44I2VSFLbE9ttnw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859685; c=relaxed/simple;
	bh=2r0JdXKCeVe9VBGPBX7YgW5LS+LGefnDxCKhK7rrcWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/TyF2yUt3N44lhZTESlB6IXGcXzWo3OvKeSQAPc83o7axzq16ctkYGcBLMbXqwvdkFNOaQ9nPyc+7Whxkwn6+RDHEvB381M8YJSA6Dfd8BfzwxXTJStBwsCco+9x6qxaBAfwffsAmMtt88Di8C3r/pF4r15yLwnBaeb4PkAz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT90yram; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT90yram"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc5bso6859951a91.0
        for <iommu@lists.linux.dev>; Tue, 07 Oct 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759859683; x=1760464483; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiHdAF668/2CebNhsKGCc+Mo+khp6HCpNN5SRyYyO0=;
        b=fT90yramFp5HV7LH/ALHkJDSdhOzqZP7tenhu66vaNglzj80+4qgRduY1GqGotHXd7
         30tbFBRovLUXzTj5oKhfqbbBFxfzdOod91UOaaKbbML/n98miTTZdiRVQMPnER/e2+2r
         VPgHDdOZlmP1HNktQ7uSKxrc97OziTRJejDeHKA8L0BdkQAe66w3BJBitg0fJY2KuLi/
         r+SLM3gUZ4Vsd7f83+1DmnqhZUgNwLuf+ZyyPyVMKOnPi9Nn7L5EqINvvWsW9R3ChHjt
         18snikzonoPAIe4F6u+Q6IX17paSAvE3dE5rx3VD0DKx+ud3jq/h5iYqXh27A/jzzh/Y
         1A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859683; x=1760464483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiHdAF668/2CebNhsKGCc+Mo+khp6HCpNN5SRyYyO0=;
        b=El7oU74nX1YnEHgS7/8qkaAspvKzLGWZzt1FRm5uxtxkS74J5IKrD6d+FmzbQwXOF5
         3++sbSOttxY7nUOYSiriNKDBX2rNstarKXIjahrUU+q103DA7hS0ocGdT4SavzWqEmp1
         mF+QV3I5fjLP1OqG6EY2cwhUVKNLqFSO2+O4ueVtoI5cxZrX4PXKC9WabQLCSjBb8dwD
         PwqP7OW8DR0xx7nfKbhoSRcyHx8EUyMhA1N4UasslRaFWAsdzkcE56Qi5LhofXtEk7Ql
         VwITsKj93IAEcvwIykRX7eVWNARFk36DpBkE16rPCUZcbScc8whK1S0k9+LWQi2q8Pjq
         bAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXnfqYvJd+PsABmUsSTQvvQd11YQKDCO088lbZuOwfCCdZ5b5rEqdDjjAPkWEfxBC5FiEoOWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTZaj9oVrfCXK8+6qRsJRgcdPlJWom8F/4qW7od4j4Ib17BpCv
	xxdvyKkBR8jL2tEGLShcqmbaSOAJl4P7dOyy5k5oxZivmpHF+r+aA1nvD0/v48hq7ypGwyTr0yc
	flZx+0g==
X-Google-Smtp-Source: AGHT+IGJlrr/LCzcUL09z20onDWdDhGAc1LfHCBGyLIEH4WKBfa0LY3kl4bE3fyFX7Z6M3k3Fcs24jbGwFY=
X-Received: from pjbmy15.prod.google.com ([2002:a17:90b:4c8f:b0:329:7dfc:f4e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:339:bf9e:62a6
 with SMTP id 98e67ed59e1d1-33b51129786mr472557a91.11.1759859683491; Tue, 07
 Oct 2025 10:54:43 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:54:41 -0700
In-Reply-To: <20250918130320.GA119526@k08j02272.eu95sqa>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315031048.2374109-1-seanjc@google.com> <20250918130320.GA119526@k08j02272.eu95sqa>
Message-ID: <aOVT4VlumG01X0Hk@google.com>
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Hou Wenlong wrote:
> On Fri, Mar 14, 2025 at 08:10:48PM -0700, Sean Christopherson wrote:
> > Synchronize RCU when unregistering KVM's GA log notifier to ensure all
> > in-flight interrupt handlers complete before KVM-the module is unloaded.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index b48a72bd7b23..b314523d9194 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
> >  {
> >  	iommu_ga_log_notifier = notifier;
> >  
> > +	/*
> > +	 * Ensure all in-flight IRQ handlers run to completion before returning
> > +	 * to the caller, e.g. to ensure module code isn't unloaded while it's
> > +	 * being executed in the IRQ handler.
> > +	 */
> > +	if (!notifier)
> > +		synchronize_rcu();
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
> > 
> > base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> > -- 
> > 2.49.0.rc1.451.g8f38331e32-goog
> > 
> >
> Hi Sean,
> 
> Sorry to bother you. I'm reworking the hardware_setup() path in our
> internal multi-KVM, but I didn't see any usage of
> 'amd_iommu_register_ga_log_notifier(NULL)' in the KVM code for now. Has
> it not been committed?

Huh.  I completely forgot to send (or even write?) the patch.  I'll send one
shortly.

Thanks much!
