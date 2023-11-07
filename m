Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E2FE3A
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LZGYHLkX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-41cb615c6fbso35971311cf.1
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699364141; x=1699968941; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJdeh3Tu4RuBH/vZS0nZO7enl4I4KMXymve8I63o7S4=;
        b=LZGYHLkXMRCgu4IKoo/BM62yPz9gpW730fOnWnQsjlGwCv3vtGxp3Ko6Ohdvmnly3F
         ZkFORUJO+8NP5lWXD6OI034NB+GNE1v4UStbeIVJTXBiAlDIerdEw4MPsxiBe2ghFy0Q
         LVpwpjRWqw/g5dPe+gKnhMZthEHvbJIwWMf/sjPEQgA7q/DaPZP4AZM3O8zXuycPY4kI
         TgkO2LBzK7JQyjElYGX64vhrWAX+Zursfr/mQrRZwo7pkApKTrFgcB/HjS3PYGTOD4yI
         /fbPmwZYKtx9nZJBpjasmLWuhIzlINlBY3T4yLxStmc7vaC9H/tLaQKnXVKFEqgi4fGQ
         rrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364141; x=1699968941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJdeh3Tu4RuBH/vZS0nZO7enl4I4KMXymve8I63o7S4=;
        b=Xhi6RjEt4yMmFbfgIDF+JcBMgtblaOKfzMV0mRv3qRudI7JYcBRdV9zZSf3TGocsDe
         C/vNlYfg+Y+98/5XQ+zYCg70kQOLI21dIU26F5nHgD8YFcvKcFbpxJwucbvDBKFLn+Jj
         vrAiW9Bqf6kV8oNnk9ZJ3Va88gvXt2Ewe4aDDPtOvZ+wVgQjzl+qLkF+AO+SvP6bo8+H
         mYDdutXIAMi4S4B6zZfhq/nXLQw6lwy/yr+Bstd/xOlHZmGA4bfxcTgW/pLe3zM33Y5n
         Zo9hQJNPMWEaqsFGonxEFMHU7s9PN2HmOyOS4he2WS9dWNP3ZYvvKPtTecrZryv2PB1y
         rjWw==
X-Gm-Message-State: AOJu0YzRgV19xKVUyMOzgR7/+70P0MzRiclxd2sKuBzazfik2Klyeu1L
	Kyg6mwM8z4qo4uh5Jpjd8bc97Q==
X-Google-Smtp-Source: AGHT+IEWxP+gc1tuMCS3txq2TQih0bdLy+UisDyL/4iUeP0mVZSOldopeM3okRflTYrLHJMp4I8Vjw==
X-Received: by 2002:a05:622a:509:b0:419:6954:3ba2 with SMTP id l9-20020a05622a050900b0041969543ba2mr38336237qtx.43.1699364141297;
        Tue, 07 Nov 2023 05:35:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g14-20020ac84dce000000b00417b9f5b883sm4314228qtw.2.2023.11.07.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:35:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0MF2-001Vkw-BG;
	Tue, 07 Nov 2023 09:35:40 -0400
Date: Tue, 7 Nov 2023 09:35:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 11/12] iommu/amd: Add IO page fault notifier handler
Message-ID: <20231107133540.GB4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-12-vasant.hegde@amd.com>
 <20231106232059.GW4634@ziepe.ca>
 <60a594a3-4b06-91e6-d2b1-17ca0ff58e8b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a594a3-4b06-91e6-d2b1-17ca0ff58e8b@amd.com>

On Tue, Nov 07, 2023 at 12:12:31PM +0530, Vasant Hegde wrote:
> 
> 
> On 11/7/2023 4:50 AM, Jason Gunthorpe wrote:
> > On Mon, Oct 16, 2023 at 10:43:50AM +0000, Vasant Hegde wrote:
> >> From: Wei Huang <wei.huang2@amd.com>
> >>
> >> Whenever there is a page fault IOMMU logs entry to ppr log and sends
> >> interrupt to host. We have to handle the page fault and respond to IOMMU.
> >>
> >> Add support to validate page fault request and hook it to core iommu
> >> page fault handler.
> >>
> >> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> >> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> >> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> >> ---
> >>  drivers/iommu/amd/amd_iommu_types.h |   8 +++
> >>  drivers/iommu/amd/ppr.c             | 100 +++++++++++++++++++++++++++-
> >>  2 files changed, 107 insertions(+), 1 deletion(-)
> > 
> > These patches don't seem ordered quite right, the patch creating the
> > SVA domain should be last, it should be organized so the SVA domain
> > doesn't work then following patches fix it.
> 
> We support PASID without PRI support. Hence we have SVA related patches first
> and then PRI enablement series.

How can you support SVA without PRI?

As i've said before the right order is to enable PASID v2 unmanaged
domains without PRI, then add PRI support, then do SVA's mmu notifier
as the last step.

Jason
