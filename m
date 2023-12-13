Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA872C846
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hZXxc4RN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67ac8e5566cso48224936d6.3
        for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702473600; x=1703078400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=hZXxc4RNE5W7JvlpVbkdTDnJtEpj69rEpkNObjt/CFgQsE/uiUwpcNAY/YkFheZ46O
         Gy0PhEweVHm29J3J3UGTZP1KsmrjIQppDzEPPEdSL88B4kQVf2lUjo+V8L6WR/php2WM
         nWXTPa0v9H1/kw9Va2rnnhKlnIn7pR5//janQfQkaAdksGNTTT9B6ChRdA/jwy7h2jcZ
         J59fJtOCUiPFfxEBBWdTABwyriyoWulYtzslUlctPFRMcbjGTT3dmfqc70y902dC+qAg
         JHVfdUEYP6VJlJLvOAtbE4EzPkYVFKkatqt6Kl1jRsK4chaTDuT8gaiMRtBquTZl5qJB
         HOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473600; x=1703078400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=pH9mItoKKNUrP2otJceowiHsbYmri9VKyk+WOX+ejxe+GYk3i+vGs36m1CP0jTXLfV
         GqqH+tAa5xaPPP8utaiZ1qzDaMioUI5E/O7BYBOzE5hn3F46/m8x49VuT1r5LbP1NoUl
         H67uT3cNKPrBpJoxiBCe1jNUnAvU8MxT0+Q6u2rPCyrVgoucezN9/QpvpmM7byW7UclW
         q063O5FnrqRfNLm5f92l1RVyCg6oWaLC/FOZFG8FtJwJtqgT4eS5Stgn7E9uIJoLqqhD
         9XAuGYjUZR4LaGaMuSeiywiwGdG54+uJJCVkVKbI35sY9gAea3+x61mvtCvjM24L1ZG8
         NJKQ==
X-Gm-Message-State: AOJu0YxOoKrRs878eznea/HJuVtum4j1Krx/KdSKF8pnKtI1DjmQ0h1q
	AfVjl8HaugT+JcGyaw0AM5slLQ==
X-Google-Smtp-Source: AGHT+IHBRIb2molU2pUmRSk3m8apIaaHB6x4+xMRVsRdDRSbKUM6I3jsw6DfyySmptvv5fd5r5efyw==
X-Received: by 2002:a05:6214:9d3:b0:67e:f7f2:2ba5 with SMTP id dp19-20020a05621409d300b0067ef7f22ba5mr1223954qvb.85.1702473600381;
        Wed, 13 Dec 2023 05:20:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm4481925qkn.129.2023.12.13.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:19:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rDP9a-00Dftf-PX;
	Wed, 13 Dec 2023 09:19:58 -0400
Date: Wed, 13 Dec 2023 09:19:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231213131958.GF3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
 <20231212141208.GA3013885@ziepe.ca>
 <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
 <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Dec 13, 2023 at 02:15:28AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, December 13, 2023 10:05 AM
> > >
> > >> 2. This is not intended to work only with idxd and uacce. right?
> > > It should work everywhere, I suspect Intel Team didn't hit this
> > > because they are testing IDXD SIOV?
> > 
> > Yes.
> > 
> > > Can you guys also test it as a PF
> > > assignment?
> > 
> > For PF assignment, probably the driver (vfio-pci) needs to enable iopf.
> > 
> 
> We haven't merged anything for SIOV yet.
> 
> so the base of this series should be PCI functions (PF or VF) and vfio-pci
> has to be extended with whatever required to support iopf.

Right. I suggest you target full idxd device assignment to a guest
with working PRI/etc as a validation.

Jason
