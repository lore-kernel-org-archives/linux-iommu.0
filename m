Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A422903
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665408527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tu/9/xvN5zRnM6x1NCxFnRYbnKf1X6xX6Lbr0GDsjhU=;
	b=BqQcd6xTDOAn3EsBBWw6ZNMF7D/IO4RBljI2sfAka5pwlQTAvUufxrLc+ECNsrJx+vDv20
	yovDn9LRfHSyz/D6shdOl0j9vqhIH2pXdKtOD2Les7Gqc4Ar8RRLf5SfYzdwehb75DLLKE
	KbjZ75HjJ64vvqiJb52+URIX2OVRRjw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-rDLL4-w0N3ugB0e49pW0gw-1; Mon, 10 Oct 2022 09:28:46 -0400
X-MC-Unique: rDLL4-w0N3ugB0e49pW0gw-1
Received: by mail-wr1-f69.google.com with SMTP id s5-20020adf9785000000b0022e1af0e7e8so2780322wrb.11
        for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 06:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu/9/xvN5zRnM6x1NCxFnRYbnKf1X6xX6Lbr0GDsjhU=;
        b=cLAFPctizt2ORFdMYFPaZVmBioCC1g+gCD0Nj84CHyeUTZpJYXP2ErG860y6ZA0geF
         JNJKqlNJeQg0Ny8pzNE3/s0a3KF3BIli1DzRxmLgRDAQSrsDzKBmUs2AAoLaexJM2yOr
         tqEcWe6ls+4tMjWN/n30ey1GgtTrIMzSId/fll47ur23mmgbRs88dth39CvqHbhHD5Mb
         FsqyKUPpVm188Xx+/E34esAKm1MYHRFLvBRhc09ljo0Kexym+WIrPHdvsBPshV0NIIgQ
         vhKa+wK+T1WCBZG77uPsuv9Kv6VwBm7XHMz3TYYYI7HmaKtDXAEDIlgDTODW7T3rNnz3
         7GEA==
X-Gm-Message-State: ACrzQf2wTGfoat/rtqZjg/4xBqOI7zd9mo4T79VDalRz2Q6HlK510IPL
	6XXSvgn2zEEDuaEDh1u4PR8eLkaooGKuJ/ertJC6uxUqcKDiBonvvWKRUfO/k+Zn8z4fziSHm24
	q6ScWz99ZflyU6g==
X-Received: by 2002:adf:e381:0:b0:22e:335b:7c60 with SMTP id e1-20020adfe381000000b0022e335b7c60mr11821899wrm.332.1665408524200;
        Mon, 10 Oct 2022 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/0LP8Qs6PMr/jzDn3tJOHR0DMWRXW3hH/hyz8Ex9y1dVUZ6i62nxkXiyQj6c+5P4Fw6gmfQ==
X-Received: by 2002:adf:e381:0:b0:22e:335b:7c60 with SMTP id e1-20020adfe381000000b0022e335b7c60mr11821886wrm.332.1665408524030;
        Mon, 10 Oct 2022 06:28:44 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003b4fdbb6319sm17848852wmq.21.2022.10.10.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:28:43 -0700 (PDT)
Date: Mon, 10 Oct 2022 14:28:42 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Charlotte Tan <charlotte@extrahop.com>, iommu@lists.linux.dev,
	yian.chen@intel.com, dwmw2@infradead.org, joro@8bytes.org,
	junichi.nomura@nec.com, Will Mortensen <will@extrahop.com>
Subject: Re: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
Message-ID: <20221010132842.7ptjknebkvhsiqyf@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220929044449.32515-1-charlotte@extrahop.com>
 <b03d2ce8-739a-ad53-9cb2-ff09c4ce6f2d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b03d2ce8-739a-ad53-9cb2-ff09c4ce6f2d@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon 2022-10-10 20:03 +0800, Baolu Lu wrote:
> On 2022/9/29 12:44, Charlotte Tan wrote:
> > diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> > index 0bef44d30a27..0e99cc1aec08 100644
> > --- a/arch/x86/include/asm/iommu.h
> > +++ b/arch/x86/include/asm/iommu.h
> > @@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
> >   {
> >   	u64 start = rmrr->base_address;
> >   	u64 end = rmrr->end_address + 1;
> > +	int entry_type;
> > -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> > +	entry_type = e820__get_entry_type(start, end);
> > +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))

Hi Baolu,

> Thank you for the patch.

Thank you for the review.

> scripts/checkpatch.pl complains:
> 
> CHECK: Unnecessary parentheses around 'entry_type == E820_TYPE_RESERVED'
> #71: FILE: arch/x86/include/asm/iommu.h:31:
> +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
> 
> CHECK: Unnecessary parentheses around 'entry_type == E820_TYPE_NVS'
> #71: FILE: arch/x86/include/asm/iommu.h:31:
> +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
> 
> No need to send a new version. I will remove the unnecessary parentheses
> (if you agree).

Yes please.

> I will also refine the commit message to avoid long lines.

Much appreciated!


Kind regards,
-- 
Aaron Tomlin

