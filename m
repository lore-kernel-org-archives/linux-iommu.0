Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96A1420D2
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887818; cv=none; b=oh+pC542VL8ISL+6l4+Ylhch0gXIhyIVPejfcza3q/XETVKqD+zM93wLQoa11PXy20an730yPbschVNt2KzKm3C6LtC7qmRYD9xkzb27jWcb+1K0hDQ5OdhkjSOChwWXj1Smj26aCpDqUG5PP1zyn4bx9iFDn6eNBGu1FjR4Fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887818; c=relaxed/simple;
	bh=DIobH/pU80Zp7oCxEnbTAgh4qK5UveR6Ntsc6J70nh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjAg4B9TTKNsGP41RB8d77zvPyxeg9XbZXvwayktEqeTnptyCwnzWe0axMo/aC+3OweLTHwp9eSAYqzOAngw0ANA5MbiJSsvjxWNa1q9+cXPPmEp+ZKSrv83cWn37y7FgdXet2gRltWNaU3XodlVx28XUIoVwyEmuvczyqFOSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jBLxEc3l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jBLxEc3l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a8900bb93so16915541cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887815; x=1707492615; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPiaOD3cBsyS5OjYUKhO9PRQyCvL9OaMbBqS+gF3xwA=;
        b=jBLxEc3lGmCDZWFYy47T9DDIqWTh5ULrienCsBlo8paTUx/f+YvZI0JNiLRGHs0Hzs
         3ztSYq6O2fB55YcV30pjXbzQvo/q8XDKAY7mIjAmzuzrwb0cWNdRE3r9M1dkVfJbwIZJ
         OWpTTAXtLaZSy9bzp6RZk1f4509/VJ+qgpu0Vtd57EbHRlLfPAmuugIahl58bhaCQnkr
         Vdb/G+uTi+tZ7TBYBbYJlyYgqJtyKkCnV21vpDmjddnicMlqIcxQDt+R8DgR9h/XqvXn
         7tkoniaNhn/p2ntcrYmTSNw7Yf4tf0r0yz0BmmAgX0WHDRsekPEUGMiFV5mX8+/+vdye
         AnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887815; x=1707492615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPiaOD3cBsyS5OjYUKhO9PRQyCvL9OaMbBqS+gF3xwA=;
        b=PK1QebY3y7EXA+wFEyNEdqr31fUg85cvoDOqELVvPx0M6K8xQ+3g7yrzRPK2wAxM8V
         OWPieIbjZfLWf1CsMJxrhsORX7V3747lr7kbACxZkolObi8K41OC96u8zqg0L4fn8zq5
         01XlvpEv2HMy5IxxCCOFBUK23POvNM6qCk/h+t8mVlc+TmgLzSVXuWEz0+K6UEgGyCmO
         xhX/eGFQkSUR4GoFGTrRgkIA5VK+Xwg1rnxY0TQqwWBCUfmlsJ4UR0z3f+XSsYDjo/wG
         VlZMJuFWAu8Vh78AN2XAS1URn2nXMPKN91L8hfomSr7p1BzkpXs7JzvEFoeZIlo4vl6+
         hhNA==
X-Gm-Message-State: AOJu0YzFulIRSXOxekRYczZSJ13Jp9k4eiuYFWXGNrPkaGUPh1kwvuDM
	N15hCBvfn5N+ZgXPQ2xNrB5cnnnJkg3eX+3mpLSBuf7lHw9Em8DDJHovb+w9Npg=
X-Google-Smtp-Source: AGHT+IF/HWsLZlcdZWPlR1pBa5IRrBpCqFicr6rA4MruYWS6d/ECTIuxsGN/kevPt1TlZHm4n+u8cQ==
X-Received: by 2002:ac8:530c:0:b0:42c:840:7daa with SMTP id t12-20020ac8530c000000b0042c08407daamr841753qtn.27.1706887815725;
        Fri, 02 Feb 2024 07:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcp3h2M+KINmSgEaxTfCOnqiaX1FdbI4ZaLGwv5L3u4LNwI6W+BH/9imk5VwVSb8o+FUnzBspmfocx181Wx+PNEvxgGjookfIJyqFD2OEHZmEH7Dld047MYuf89AJQaI5W6OC5+ZSiCe+2bPafMdgXsOk4hnM+kE4i0hIouQeGuorg4Xpf+DnYxkbKnVXN8wSfq99Ok2GQUojE0qY45Za1
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w38-20020a05622a192600b0042ab85638fbsm916402qtc.44.2024.02.02.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:30:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvUc-00AwEg-N9;
	Fri, 02 Feb 2024 11:30:14 -0400
Date: Fri, 2 Feb 2024 11:30:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 05/14] iommu/amd: Fix PPR interrupt processing logic
Message-ID: <20240202153014.GY50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-6-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:30AM +0000, Vasant Hegde wrote:
> * Do not re-read ppr head pointer as its just updated by the driver.
> 
> * Do not read PPR buffer tail pointer inside while loop. If IOMMU
>   generates PPR events continuously then completing interrupt processing
>   takes long time. In worst case it may cause infinite loop.
> 
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/ppr.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
