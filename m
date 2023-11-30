Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E9495DC
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jWwf10q1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d852e06b07so684381a34.3
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701361109; x=1701965909; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f388p6khdEm9IytyNAUyUPfkbdEEtVluUY0RkvUGVFA=;
        b=jWwf10q1BMORlc2IG0cIO+mq9hjLxAGzJYy+eycfGTS0V8fPBVkCthjjZgKQcmNCtp
         kHuD+cue0SDn3TOK22wNNxHI9JtlFo9G/mlEJi5eQS5LQENYlBPbENAe8n2jYDTkSgyX
         6dyZKt3xIQ7VwDFm31nd3VuJrGHRk8gtINxhpf+r2FlLxNrmV3HIE2RanciPPr+CM9Y6
         xo3J17i86STIZPSy+XoXtrYNbHrEYc75CSKVcvoBEEkdqp5ggqT1wUFXb4pgipkK9Cnr
         KDgzLXNfq0ADyvhgd1Pfo+lhEKpjEj8J3MJ3lEOgAlxAKkOFs2W6dLmSQW2NlKssGgiZ
         E7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361109; x=1701965909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f388p6khdEm9IytyNAUyUPfkbdEEtVluUY0RkvUGVFA=;
        b=lbiLjoQfxIId76LPnVzu7Dfe29HOODS5LkCb80zPBeMgEhW47RT9o/kN06vlvJkkb2
         S2Z96KWtEDaJhDRt6SjT5JR4NVPpi093degNOeTU4e3D1FcWUY9iKdZ+b1U+iz/ySh5O
         U4hafNLwsIPSk1Rbce4UtqyoUT5+4jqmqJjWUxPt6iEOuW3sczgcpX4FmOzuWFOuw7Y/
         77uPhbSNZuqCLchGMHZleMJyBEW66y9uh2U/7hK2aRsntV105f7p/a090EnhhiOtacvw
         GbQE1Uw7AEzxN617iQReyvIRj9iap7xd3zID9Sr7lXYa6sEwfZ77eb/TYkijCEBnKBHT
         Zyuw==
X-Gm-Message-State: AOJu0YwqDYZ8SQil3tRfbtiF7LfctqoOu2zFS9YwqH3vu7YjLXRrxzH7
	EfvKu/xytWej0t3doRGG9iXuJg==
X-Google-Smtp-Source: AGHT+IFv7l0L+LFSF+UpdHaHw4IOgcZudH0HKJZBuut8BXVFTzhAcQqpYJkgimrLs127L26mH3dWPg==
X-Received: by 2002:a05:6830:1653:b0:6d8:4d34:4f1a with SMTP id h19-20020a056830165300b006d84d344f1amr13513otr.13.1701361109112;
        Thu, 30 Nov 2023 08:18:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id r14-20020a056830120e00b006ce29a19dcesm198428otp.26.2023.11.30.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:18:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8jkB-00624i-My;
	Thu, 30 Nov 2023 12:18:27 -0400
Date: Thu, 30 Nov 2023 12:18:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Message-ID: <20231130161827.GD1394392@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <20231129201324.GL1312390@ziepe.ca>
 <8186755c-fe80-424c-9b50-06ea213b3b17@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8186755c-fe80-424c-9b50-06ea213b3b17@linux.intel.com>

On Thu, Nov 30, 2023 at 01:44:19PM +0800, Baolu Lu wrote:
> On 2023/11/30 4:13, Jason Gunthorpe wrote:
> > On Tue, Nov 14, 2023 at 09:10:35AM +0800, Lu Baolu wrote:
> > > When IOMMU hardware operates in legacy mode, the TT field of the context
> > > entry determines the translation type, with three supported types (Section
> > > 9.3 Context Entry):
> > > 
> > > - DMA translation without device TLB support
> > > - DMA translation with device TLB support
> > > - Passthrough mode with translated and translation requests blocked
> > > 
> > > Device TLB support is absent when hardware is configured in passthrough
> > > mode.
> > > 
> > > Disable the PCI ATS feature when IOMMU is configured for passthrough
> > > translation type in legacy (non-scalable) mode.
> > Oh.. That is the same horrible outcome that ARM has 🙁
> > 
> > The issue is what to do if the RID translation is in identity but a
> > PASID is attached that should be using ATS - eg do you completely
> > loose SVA support if the RID is set to the optimized identity mode?
> 
> This fix only affects the non-scalable mode that doesn't support PASID
>  features.

Ah, OK so it is OK. I'm glad the new mode supports ATS against
passthrough.

Thanks,
Jason
