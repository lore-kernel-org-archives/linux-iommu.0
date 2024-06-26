Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4B11849F0
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409773; cv=none; b=qE4+RX0w4Pqo2BGRLN31tYf7fe/8jCdZMjTXL7uFUmtj/PHXMdLmeZOqFD43f+yvTv2+K18JVp1DClb7iFSAgGIt/WP3eb0ReCWVZ6kQzaYQu0wfyp4FY3WJdp/IdqU2BIg6CN8upvL1QKMvVfi9bsc0eDYhBLdjc5LohbkxgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409773; c=relaxed/simple;
	bh=meI7zQuYpjGQqkBcKVyQVMDLDC0Y16VJsozKBd6D9/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEIycsNi+KK8h4b38NHjb21AcCPF6eaRr+CiOcuaUZuaah3VDNLP7zmP8xQ8p7jbzbWoFBtQWxWAzcnhcurqkvkBsmm0z7PzuJqk9vz98WFyTkjiMLrf0eXuDHBLA3Qh1HekShUjrV1tEOLpsMgD090oBCVssJ4cXPMEwOrdzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nir4xlEj; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nir4xlEj"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80fbf874128so393530241.2
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719409770; x=1720014570; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRB/eQv1O8vFo1RpEOFuZT1vlG0b1HHSUcdSwe1QW7c=;
        b=nir4xlEj5ikh0FTRTlxRBSfqGuggJk8pP14hkCLfY+D+QyQ++3xuUe1cyzgcL5JJ0Y
         Mkpvo1SpktLUnhkuVmAzO1Q+nsCTM7eyufJM8dcCrCqA0l0Hnr1KTeeJLti6tld4cVg8
         w/OzW4XUT1TtzcOEQYphS38yEXDg4hPcEIi6U8EXUiTg/p8qFYWXuTlHyR8Nrxi3cf+e
         8cebuQche6s4r5yjCLmTVvECTdD6JW8nE0dtqXmHNs8gwkalfFyfwCpeQ54dcIJ0lzNI
         msuRu3JoYbUNBtGmebVnjaacFWnYIgo7MHSoqigwk1QRMc3TZM91oLy7obQOa81gR+pd
         SkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409770; x=1720014570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRB/eQv1O8vFo1RpEOFuZT1vlG0b1HHSUcdSwe1QW7c=;
        b=nQpPBSPo6F+T6TEFOV0GRPvMSZiGDpXH2jtDdgdxd2lBhhYN9SvwaX8Bgz7iW6Dg2X
         CEFr3c1luqgLJr5EozhK+uYf7DYsiPL2jLG55nfiBjo1IdrlZ1PLAueUSHQY7kcxKgqB
         vsaLcaPha77w93358f2kfKkPXgAnVLwkZwlbpVY6QNjUCc4cRERmEv9OsC2zRKITBmQO
         7I0eDGwFE8F49jTw3uNQzmvig/plnQ0mAS2PNSfC7lul7VpnNLdFjFjxj9qxmfazj3x/
         0+xTP4ATo15dCIa9jt1DZVrxkTv2zggSJ8ehQvXk7n/LXxel6S8HrmtEo/toVw4l4GtW
         Izpg==
X-Forwarded-Encrypted: i=1; AJvYcCUz005txzQdoGtIJN9dSEOnbVzr33da6XK9A1bFo2lTOs9ePPEyd+KdalygmsWJYpc1DPdcvlYM9vTUPcyCXZTdzkfPJ7I=
X-Gm-Message-State: AOJu0Yzo8FvU/f196QKDoG6T5LDTwCcc+DxF9voCSUYILwuVUHpLvu3d
	LT7U9+QcMmzeBJl35+9NiIvPDKyYEOIFewDmsOF6x2YJk0aU3Jsi0Oyl/3gPm18=
X-Google-Smtp-Source: AGHT+IGq9IFhSGjEjZNPj70KKXqaMuS5Ln6LwVIpSv5QFs5d/tixqxxA/GlJAm8IFYicQuE0oioy3Q==
X-Received: by 2002:a67:f35a:0:b0:48c:4fcd:f718 with SMTP id ada2fe7eead31-48f52a9bf89mr8746008137.20.1719409770587;
        Wed, 26 Jun 2024 06:49:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f6ab41dcsm19532971cf.78.2024.06.26.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:49:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sMT1d-00DE0t-DW;
	Wed, 26 Jun 2024 10:49:29 -0300
Date: Wed, 26 Jun 2024 10:49:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
Message-ID: <20240626134929.GW791043@ziepe.ca>
References: <20240606034019.42795-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E8767AB63378C81130528CD62@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Jun 26, 2024 at 06:53:04AM +0000, Tian, Kevin wrote:

> btw in concept PRI will not be enabled/disabled when there are
> PASIDs of this device being actively attached. 

Please don't bake such an assumption in.

non-PRI paging domains can be attached to a PASID and should not
enable PRI.

PRI is enabled when the first PRI domain is attached to a RID/PASID
and disabled when the last PRI domain is detached.

Jason
