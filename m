Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BC63CB
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560110; cv=none; b=MIJXrIDpGmk2UW0xbDEGn4V5xi6zl2GRKTs7pSTje/o4EZEvQaYmkWKKwhK10R2s4cK72B6CmBFUZh+72SFWysWTjl68Cusx77Nrk3yq2AaslwnmHnCwR/Bw+ZPE3qGwq4o5joUrRGTlwO3QMAvKFMuP55E+5ZsTh2a5h499p7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560110; c=relaxed/simple;
	bh=Xks612s/7rT6Q6ukp30bszt+1cZ8l1ePIW1QRk5v5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRH72nrLhl0nIgJP0qh5GKIfrANr5XwUAPKaTlwLEx/3yCEFDvExd7hFX/Utnyj4aifFB+5sjyPm/U4o+Fh9aY8SRfefVUVdYokh2hOUsV62iUmMKFrqm6ZnzcFupu6r5Dz8q3V8hI9NlQDY2AhcTP38jhT67ctyUIBc4kv1KEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OSTidWTu; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OSTidWTu"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ab9d01c479so4551906d6.1
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560108; x=1717164908; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=OSTidWTu0LeXoeEKwFrY/NSpzewRxfNLge5K/8K8tLde/2cko/QtuQjzPPOJ4va76S
         +qAKn8IJu5H7LxKoeSQIVBVLALbdXL2V/jtUDta4jRjDLBE9fLXJutuLQryx53G82t7P
         tfWuF8ePm7L2hk15LxhRTSBR6c767H717u4YjRsSo9h3uHiU17pYsUPexxqHcPsSz8fx
         sOmGjZE/AdXJYosXK69hFZjwqaW4uBxOoMr4gnXqXzqcwc25fvXL9hhSGTViBcjGrN65
         WuZWKSrc0pZO7PWNEmjWPoAlg8YjaWvvS58vLH/OPUXgSoOjn5OHQKvAFPB1FwC6lpYh
         UKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560108; x=1717164908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=CEA9lRlwt/x80+tX8tI6FBUNXRvkbFyJ0izL5Y2z1PGQQqXXGQR8irATkuXQvsWjS8
         v089TBMLBURXg8qn5A7jth/FKjOHiEW6fnW1NXW8IPCh6qON1XCEPLhKbEos8C8DOi2T
         TLUcsJUzT/qO9bY6qR/72IlpbLB5FGtO7A40aSRz8D/XUfg4bmXhGT6rGQnA7FVxw0Xr
         kLisLGdhSBsL8eHOk52EKnyNNez6vx5jypy2klbHohazUREn8B6yLX/CJIVHhjtTx6cG
         vi+PsRJQ8UaxFcbjVqOrsGa6Gsfb7Vg0JpLVau9aDLlqxYWMNPGEsVDCK+eX79B9yOu+
         DUww==
X-Forwarded-Encrypted: i=1; AJvYcCXzckh453wYlRScKQCmVjEpHiT7CsCDYPfKflQVf6OnZt3Qyid91Xcfx5KWdXMwJ7yubbI4YLWaHnLw1FEuoNLyYaDzehY=
X-Gm-Message-State: AOJu0Ywv+rU+OBombWTbdS4gbKnpS3SlmYjwijxQclD9crcdc7qQY0Uo
	tA6BEQM8CKc3VySJYQI3ACxwQQqN78hkGn+J6DTWtRYTWz84LchFIz9LEhyjoUY=
X-Google-Smtp-Source: AGHT+IH6Ac9WsdsUZJ58JI8yWFb4+VExingKf2US7XYudAGfc/E7XKaMftG4JYXDj6Yn+MrOVUjI+A==
X-Received: by 2002:a05:6214:4981:b0:6aa:3dc9:4b2 with SMTP id 6a1803df08f44-6abbbca5e8amr26530426d6.5.1716560108113;
        Fri, 24 May 2024 07:15:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac071048a3sm7543566d6.69.2024.05.24.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:15:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVhK-001JcU-UZ;
	Fri, 24 May 2024 11:15:06 -0300
Date: Fri, 24 May 2024 11:15:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Message-ID: <20240524141506.GN69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
 <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 04:59:18AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 11:33 AM
> > 
> > On 5/20/24 11:24 AM, Tian, Kevin wrote:
> > >> From: Baolu Lu <baolu.lu@linux.intel.com>
> > >> Sent: Sunday, May 19, 2024 10:38 PM
> > >>
> > >> On 2024/5/15 15:43, Tian, Kevin wrote:
> > >>>> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >>>> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>>>
> > >>>> + * @length: a hint of how much data the requestor is expecting to
> > fetch.
> > >> For
> > >>>> + *          example, if the PRI initiator knows it is going to do a 10MB
> > >>>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> > >>>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> > >>>
> > >>> This is not clear to me and I don't remember PCIe spec defines such
> > >>> mechanism.
> > >>
> > >> This came up in a previous discussion. While it's not currently part of
> > >
> > > Can you provide a link to that discussion?
> > 
> > https://lore.kernel.org/linux-iommu/20240322170410.GH66976@ziepe.ca/
> > 
> 
> We can always extend uAPI for new usages, e.g. having a new flag
> bit to indicate the additional filed for carrying the number of pages.
> But requiring the user to handle non-zero length now (though trivial)
> is unnecessary burden.

It is tricky to extend this stuff since it comes out in read().. We'd
have to have userspace negotiate a new format most likely.

> Do we want the response message to also carry a length field i.e.
> allowing the user to partially fix the fault? 

No, the device will discover this when it gets another fault  :)

Jason
