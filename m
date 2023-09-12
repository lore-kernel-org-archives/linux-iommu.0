Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5201FA8
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 18:48:13 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76dcf1d8957so360950785a.1
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694544492; x=1695149292; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbb0qJrpeNEdih88ihlJDw2cQGHPKPk+m7Sl3b1zNWs=;
        b=oBYpmlN66CCanJaDcqMiaI8RLoa3tIWiNX8QSH9AnmU34IF/oXptl0fck7gbkj1Qph
         SUe1isM3s0cLZRHjuosQcHXJAwtVYduHobSf1/I40QsPqYDyin10iSgmr6oAlGC1Oo0e
         CPS0aJ8Hm3xoS1zDZNTYClNZKyZSyCitrKXXuZYm7nNMTGTZXA08W0HHOHA1Zpss3K/e
         gV/O302YN2v8aaeMQXGehEJ1gMoULW23LJIjK9/Ds6lHOii2aINM9WRJvn+G0dLB6uyl
         oBnaaJ2TUSevQFTLEKw8DIYCjwD6A0wH4pDz28o0KS81z3xL5MdxvMEh4TXazhqvBrJb
         NnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544492; x=1695149292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbb0qJrpeNEdih88ihlJDw2cQGHPKPk+m7Sl3b1zNWs=;
        b=o9e7q9kqhnlPL2AYt1qDIRTbJ5pPRrReBiewXqQS+llq1/8TJxQjinzO+/duoK72nL
         r12E54EeZe9W5E6qxiAVoJ3QZXDIR6/TRe/hyEUN3XFBSGGUTylrsGgoWDqONjuKvvDz
         d03XY8To7Z4AHdfUQK9KquCldyw4lc5hsQFcPMJN4XSujUcq0mu7Wd2IbZgmbYIjxoz/
         Sgi0vc2HkD/PyoM5DYq3rj4iFu3O2xAu9fNcHoYXfCvO33meP3r3f2BGQeBb/i5G2BrZ
         ni5/AJ64IzQTgRjdTZVbmNj5v+r3HGd0PI0dtkk04Y3aNmwwbd4dbDnuYLN95m8gArBk
         nVYA==
X-Gm-Message-State: AOJu0YyK9Ij2DhdyQEVQucyHVKhnJ8m7PP8sdDg/Byv4nwRWG/Ko/LIx
	LcVNGvUsNokFnhhaNjazMD2GTw==
X-Google-Smtp-Source: AGHT+IGXmyG6x2lvtRPLD+VSgXPVEbOb4AmwI9591z9grCfwmqYdqQ4TVwwy2Ekws8JrO66wMBAb2g==
X-Received: by 2002:a05:620a:2453:b0:76f:f34:c309 with SMTP id h19-20020a05620a245300b0076f0f34c309mr280904qkn.53.1694544492510;
        Tue, 12 Sep 2023 11:48:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id s16-20020ae9f710000000b0076ef0fb5050sm3394520qkg.31.2023.09.12.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:48:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg8Ql-002GJL-FW;
	Tue, 12 Sep 2023 15:48:11 -0300
Date: Tue, 12 Sep 2023 15:48:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 00/11] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Message-ID: <ZQCya02ruKHq4wsX@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:35PM +0000, Vasant Hegde wrote:
> This is part 4 of the 4-part series to introduce Share Virtual Address
> (SVA) support for devices, which can support PCI ATS, PASID and PRI
> capabilities. These devices are referred to as SVA-capable devices in
> this series.

I think this is broadly close enough to how it should be structured
that I would not be averse to going ahead like this.

The functional issues still need to be addressed though..

Jason
