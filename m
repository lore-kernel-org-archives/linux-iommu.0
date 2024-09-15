Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EFDDAB
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408173; cv=none; b=elM4HyccehRwPeL8sKDI2n666324A0c/CM7vO20AwYQDBcQPiIS+GykSj9wYwiiNTRAWrMYkkxOoRxAH84fS99BKSwG/HRaTBwEmLnMeQvXcbT6DxTwbBR4Vjr+T2JfykJDVogol9/vnQel3jOMjrYZcN7fJ4ISP0ww635+K4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408173; c=relaxed/simple;
	bh=rhHSv45EQIjmqKG+v5smUwofVqEGAHE2syWw8NKSku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK9XSI/gNl1nDHYDZrJhGg3wHI4C3oMjPGnhBB8QAmbIzrZiNugBJmtdL+g5yEpc6aGHwOnl74cpk+cwJzSvcPFRSYq7swix7cJWpUvQTtfJKCZDRulHW2QPB1WAUztu6hOeXyEDQ7h9lix/ih2RR//WikVU6oK4BSHsn7X6cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BmqFl5iF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BmqFl5iF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c35427935eso19734436d6.3
        for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726408169; x=1727012969; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQSY+HxRYKjtmeSVzczlvhSFfHMIgoo6GYpKTUSvR44=;
        b=BmqFl5iFi4/dH+tF/C9EJBeH9gANPVXTNELmBacaI68ep0mobsZQCJCZiaOeTsMmAr
         elS1/nXOxjpj/4TCPYabh2yb9SnTxmmQ5K1YaS1+O6KpMpPVFIVeEvSWm8jv5n4vM1wM
         /wnEzNRmd1voYtb5cPqGDKN4XiT/4hbBRr4MeShK47MYEyZ8msdj2thKw2yvvCdLqWa0
         Lk8J/TgMIOPHWF14p2cMv6LLFeksJHFIj7cRPMom/8gXOGn2pWhJjdvTZegveMz1Jr6s
         k7bqHYtf7vImK3VJY2fFSLZVGBwdjFxW3mpNFFyJH/Z3nqisjNR7g5lFTv7vJSfVuF3x
         TGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408169; x=1727012969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQSY+HxRYKjtmeSVzczlvhSFfHMIgoo6GYpKTUSvR44=;
        b=dwvKgh8aOKruqY/jGN26FKtQC47PJNNOYAIZNZsslnxE2ET4ngaQDhyU1jFeCgjRcD
         ZG/+DN4tzr/gYmr+iA1WEwGOO0/WMApPm5yYz55CyNkQ5hhOVfJZvzuORIUbowTNmjpT
         +OrmhS+N5c+luj9FJB4qDj9aDYu+CBGs898GSLuMdUGTpOfZQ9g0NxnHgzzNq8MXovuj
         ufUG6qqUrDbzfbtco5TkXZVBSjSVANwVmeVBNUwzF6QcxMjOCJ/LvLENGDccnwja50mq
         OfSL3Oaza3RCqrXR+PycN27Mlmt3cQ2dih7BFWnFhLo0i4me3IZG9k6DrGiJreCcF+hT
         12qA==
X-Forwarded-Encrypted: i=1; AJvYcCWXOT80sraWLI6KG7DFdk7zt8XSOMwYU0T9HKI2eBpEEbcnIc73hnSe30V47Q6CnAMpiOe4pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxChepjT6e9qFmdxInacMvZpL9Mc2t/B7NY6MlU/3+A9rQujFFM
	OiC8VMWEdJpj1xl2l3WMUceQ/OUklR4joVqPgJgFqNeM4uC7p+8+v5apOWhXVDI=
X-Google-Smtp-Source: AGHT+IEXGpaCl/mQNXW/CoMuFa734dsgdykEt4UauT0ExIPSiflRLIVu7EdfH4PeIuQg+qc3WKiStA==
X-Received: by 2002:ad4:4f34:0:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c57354767bmr150622686d6.2.1726408169525;
        Sun, 15 Sep 2024 06:49:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7aee43sm15811046d6.111.2024.09.15.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:49:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppd2-007dBf-EY;
	Sun, 15 Sep 2024 10:49:28 -0300
Date: Sun, 15 Sep 2024 10:49:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20240915134928.GD869260@ziepe.ca>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>

On Sat, Sep 14, 2024 at 01:49:44PM +0800, Baolu Lu wrote:
> On 2024/9/14 10:53, Tian, Kevin wrote:
> > > From: Baolu Lu<baolu.lu@linux.intel.com>
> > > Sent: Saturday, September 14, 2024 9:18 AM
> > > 
> > > On 9/14/24 8:52 AM, Tian, Kevin wrote:
> > > > > From: Joel Granados via B4 Relay
> > > > > <devnull+j.granados.samsung.com@kernel.org>
> > > > > 
> > > > > From: Joel Granados<j.granados@samsung.com>
> > > > > 
> > > > > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
> > > > > Move
> > > > > all Page Request Queue (PRQ) functions that handle prq events to a new
> > > > > file in drivers/iommu/intel/prq.c. The page_req_des struct is now
> > > > > declared in drivers/iommu/intel/prq.c.
> > > > > 
> > > > > No functional changes are intended. This is a preparation patch to
> > > > > enable the use of IO page faults outside the SVM/PASID use cases.
> > > > Do we want to guard it under a new config option e.g.
> > > > CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
> > > > for the majority usages which don't require IOPF.
> > > > 
> > > > Baolu?
> > > The OS builder doesn't know if Linux will run on a platform with PRI-
> > > capable devices. They'll probably always enable this option if we
> > > provide it.
> > hmm then why do we need a SVM option? In reality I haven't seen
> > a platform which supports IOPF but no pasid/SVM. so the reason
> > for whether to have an option should be same between IOPF/SVM.
> > 
> > IMHO the point of options is to allow reducing footprint of the kernel
> > image and many options are probably always enabled in distributions...
> 
> To be honest, I would hope to remove the SVM option some day. It's
> nothing special except listening to an external notification and
> synchronize the caches when the page table is updated. It's common to
> all cases where a page table is shared between the IOMMU and another
> component.
> 
> As for CONFIG_INTEL_IOMMU_IOPF, my suggestion is that we don't need to
> add any unnecessary options unless we see a real need.

You could possibly bundle the SVA and IOPF options together

I called the new option on the ARM side CONFIG_ARM_SMMU_V3_IOMMUFD
which seems like a reasonable cut point against embedded vs server.

Jason
