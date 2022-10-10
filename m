Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6B2903
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665408711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJGeF9V/MoXaikUEGMn2u1NvTRVBjYGZdHRWBxMpLbI=;
	b=KETmMs7mPRMWpxYRIg9aVMRbhzDTwPws+kWVd76bIDGqqhj8iNXir9nJrnq0QySF7f50zF
	2Me3z2TC43CK3oG6Uggm9N5yKxiKShAJY+rd1ioHjhxx9q4AQ5RRdA4oGqWctFbqfvxut9
	icxBvPFUkZIitQUJ0azOk7RoqJeQvRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-XyAh3Kh8Mxet9K3X_qLo4g-1; Mon, 10 Oct 2022 09:31:49 -0400
X-MC-Unique: XyAh3Kh8Mxet9K3X_qLo4g-1
Received: by mail-wm1-f70.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso3085494wmj.4
        for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 06:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJGeF9V/MoXaikUEGMn2u1NvTRVBjYGZdHRWBxMpLbI=;
        b=h+gQkWKFF0BO2rhd7VMpJ1/TIH8KTe3+hhPSTLl0NxFlh11holNs2e4pBgsaLPzNdi
         EUX7Qiw7vz7JGNolm7zICeaZP32mtJLxnN6iEdDisdkQXMLrVCamddxI46AsQ5wAaB7d
         QdpWF0aJwS3WabNJ2iax1VjmXF4FMTB9w9vlC14uZKMj7nVULDwKK8/I3cFIMZ/yT4iC
         MQq7NXw1ZD+vTz6AfnU289dkCAXfrN3tPAtPmNrz3PJCqAH5ZWVlx5xi4ZIITicRhlnU
         qursaIR4LoN7iwnj2x55iAxORp1hUA/x7LVZAjIdzEczhFsKK6TFQ36IpMEW2q/O4arw
         PUfQ==
X-Gm-Message-State: ACrzQf3SLeDItrTanwbiv46FkiYXUcr4gjFQ5bmQmHH+RXXuGYuaaI+3
	RLeZeSwT43D4fPL89+eb6YzE9ggFYXtL0/NcsNeI69g7rmISzvZLnC/l4Qv5RNYS7j6NROkCZbR
	a46zd7r5mE2rKxg==
X-Received: by 2002:adf:f345:0:b0:22e:3c6a:7797 with SMTP id e5-20020adff345000000b0022e3c6a7797mr11673999wrp.374.1665408708469;
        Mon, 10 Oct 2022 06:31:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wjZZU7BOH9KCFMbGPPXVrYHKODak4lHEMkIpHbbyxiaEJhhHKREr+ozKugFN6VMO/U6q7nQ==
X-Received: by 2002:adf:f345:0:b0:22e:3c6a:7797 with SMTP id e5-20020adff345000000b0022e3c6a7797mr11673982wrp.374.1665408708244;
        Mon, 10 Oct 2022 06:31:48 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c1c0400b003c5490ed8a6sm5961672wms.8.2022.10.10.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:31:47 -0700 (PDT)
Date: Mon, 10 Oct 2022 14:31:46 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Charlotte Tan <charlotte@extrahop.com>, iommu@lists.linux.dev,
	yian.chen@intel.com, dwmw2@infradead.org, joro@8bytes.org,
	junichi.nomura@nec.com, Will Mortensen <will@extrahop.com>
Subject: Re: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
Message-ID: <20221010133146.yfd5ywmq7okpbp4a@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220929044449.32515-1-charlotte@extrahop.com>
 <b03d2ce8-739a-ad53-9cb2-ff09c4ce6f2d@linux.intel.com>
 <20221010132842.7ptjknebkvhsiqyf@ava.usersys.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221010132842.7ptjknebkvhsiqyf@ava.usersys.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon 2022-10-10 14:28 +0100, Aaron Tomlin wrote:
> On Mon 2022-10-10 20:03 +0800, Baolu Lu wrote:
> > On 2022/9/29 12:44, Charlotte Tan wrote:
> > > diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> > > index 0bef44d30a27..0e99cc1aec08 100644
> > > --- a/arch/x86/include/asm/iommu.h
> > > +++ b/arch/x86/include/asm/iommu.h
> > > @@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
> > >   {
> > >   	u64 start = rmrr->base_address;
> > >   	u64 end = rmrr->end_address + 1;
> > > +	int entry_type;
> > > -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> > > +	entry_type = e820__get_entry_type(start, end);
> > > +	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
> 
> Hi Baolu,
> 
> > Thank you for the patch.
> 
> Thank you for the review.

Hi Baolu,

Please note that I only responded as I offered the Reviewed-by.
Indeed, Charlotte's feedback is final.


Kind regards,
-- 
Aaron Tomlin

