Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811866;
	b=kIzJqKBTqagVusEVfFDMQ1YJq9bMuBrJ3Fcms/oDiv8nDdeoA+WQ79UcVyjPIu3rA5sh
	 NpmRxeVMJ4UbFO/6ZQ0DOYA1R3MBISJ+uHCCvUJDuMbrfqQGnSBczzwwygrZVnEwOdk6F
	 2fd+maiDUGNzKpIMwaU/BsnpcmcaJlE5zBsVLfW/f7HKdzzkFn0jl8zBR2QzvFSZsaGSC
	 kGRCI+1mr/ZDgH13e3L3dp8exIZpNi9XfVtyBr1ptLYBd/+y26FjXOmoPXH+15qU0xuyi
	 EqWqfRR9DJ+Gov/rzuVLDSggFYqbPeVACObC70S11ce04jcEwicdy4le0+cbToChSFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
	b=tYfOyDaAYtRR6r/BY7neU2iXOdMjgCbjrGlgLzLS0799QTbjg2oWZ11rT/p1sUO1Ezyf
	 JRokh0Nd21Z+hhfOwv73Vm/Id8H9t2lwD67fz3xtHjL1WgPGcaWP6rIq6WG0rAWBfANK4
	 UDmUa6y1XEYgOwVMmOO/CD4mcZIA6HOnaKlQ7Lskqd2semUVwJgUSsWlb9OAqGH/MveBm
	 F8+HL+8P3/Oc038wUOvHL1mndhRzTmfL7F6n7UNmIjB+LyrxOfc0nlkXox4H2lT/+xaXj
	 vWv9u5dmp1ooKRnqvve3HNrl6TVXcnE0SThUHqsNbBxJ9Q0MqkPbfi/ZNYJtao7l5hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DNO26KrD;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AB606A32C
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43AB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DNO26KrD
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53665358476so9804581cf.2
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793811864; x=1794416664; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=DNO26KrDPv/XfgcvjtX8rAQrPvSucC8AOI03Q93kUhGBFOYgahkuLW6p+uO3NnTf+F
         g9I80ShT6KyJHKxZ0TIDp77zusw9W21KZzdRxN21FNNoD15A1jyxJm51SbZ2k9sJGl2r
         WZ6yO8/3FHdIS6beOts5NLRDODmFc295lngjzdOAlR0qJU83BhGsIKfxeDX+nhVqAOta
         As4mHxZvFdX7BotWZyIfETmhPVs/D7bXbRfwBK41VGl1/+Q0S7xSLrLUS5FTJ+QLlnrG
         33CmAvjJTtiGkVgG8tCLQJBM8q5Wu4poQfTZhOa53uAcOgEr6T6kWtCbbIAtVORtvM5H
         aG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811864; x=1794416664;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZ2u1qS+DdTsseNe8GTnRAh8VDL2cIoDDHTiVhBBm9I=;
        b=YKZQJEQVmiBxGYqvRmIfJ0aS99brKZwjgpAgbY6gSEfuo7uIGpVVaoCv2oQ98m0+tL
         6kPDn7AO2szHCTEX7SX42fQoQ/391kZdyZflLPkpf6hLSrmcCUceTAwkMweQzfo5aLt2
         GHM+6xf6HbBvlDjjB3DMrUo7+Bs+9bTIn+83fgILfCXiHBvK9xgcgFo//PbyV0VoNxyl
         2WSP/8sIQDfyI4jY5cNOVpclXqjDTEe5jZYToa1gW7PRycPhxTHXWwrB4IayoRqI51rF
         dRgTlE0ZUhlnhR7v/x4RiVxAKXa6vpA5P9nm+rib5KfRIPo98pBqrvWyC1/S/NLKlqMa
         gdDg==
X-Forwarded-Encrypted: i=1; AKwUvBwcIavCLyo5pV/KywimnWZbuvoNSj6LG7xdA/Cfj7t1mIK1qYKsx3YKB446h2zYEksZ9zzecQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+JXYuC5eWz2W8Rutg62oxuHRM6gt2Zv+AZarZDSYy0JwlZ3KcU
	YmtfBKUW3R9VmM9Q3XkItGrpvXLvFlZ0Q8Eq71yyH2I/dRw7ghH+l5oJ0avxRIF7ioU=
X-Gm-Gg: AYBFou28tffwsh/Jbe40Zrcq2ac3LixqdxcjF3BCwtNzyzD/Zbjz0ifz8c4MV3QP8ra
	qk1CmcL2CSWJM6hYDcxi5Ve7/bLqNUmKKV9wWkvifvql5PPboWS5RUOCPPPWqEt8AO/Diivk5if
	TjD8XVPRRiraPyQYgZmyTpAYnVCrQnibctlj0lH5sfXNA/AeKIvv8XjjsGwhOuh6SfFXKq7YtK4
	Sge7yDMpX4Kz4vAIowz5AWxnFRVtJB375ffKKKmjyxl5BEZpQ3jUFWL5WpGhh4yAb6ApL/BXFKa
	zimyNiqeQz/GnfRLVsVlDhHY1/iY2XvisYpCLMv+koPNBJN1zz2TbEB3nYV+kCx7PedoBzac3fu
	elHebfQFLrdIvfwXuhMNvIvbLVMe0igauByRZUjESJ1MYsE8dTYp1ZXNs2ivsKC65SkQbmabbWv
	y2drAqh+yp1yN/pSH0XGGXHDjDUuvkyDzBw7H7c4JuV2dEQ6fHdlBD4av8CmIyuf7MtkzxjDGEj
	92jyqtyFjfr+EVf5J/vpBCQydxt7LmTZbIgI2Xmw0CmC6v+tdTU2BlclMLbhARZsOpgHT2/D594
	fNETdfnse/LnQloMbkRtcv7ShN8tGYMBIGI8iEBlKJ5PbmNAmkyDK0ZBhiuOBsug+CfVqzLgHqD
	uxMp3FFkNxg==
X-Received: by 2002:a05:622a:e342:20b0:537:83e9:e46f with SMTP id d75a77b69052e-542b3c732f5mr202335741cf.3.1793811864442;
        Wed, 04 Nov 2026 09:04:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c49ab3sm28279301cf.19.2026.11.04.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:04:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOePP-0000000Gg2b-0y2m;
	Wed, 04 Nov 2026 13:04:23 -0400
Date: Wed, 4 Nov 2026 13:04:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [RFC PATCH 0/9] iommu/iommufd: Add hypervisor external attach
Message-ID: <20261104170423.GR3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <atiaKG86qcifKzBT@google.com>
 <20261026114917.00005a22@linux.microsoft.com>
 <ausHmkhAegDEyeKV@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausHmkhAegDEyeKV@google.com>

On Wed, Nov 04, 2026 at 10:23:22AM +0000, Mostafa Saleh wrote:

> > IMHO, I don't see any change needed for the host-side attach between hw
> > nested and collapsed single stage, if guest and host attach are
> > split. I think it is up to pKVM or MSHV to handle guest virtual iommu
> > mapping for both cases.
> 
> Although the hypervisor (pKVM, MSHV) is managing the guest IOMMU in that
> case, I believe the host should be able to decide the guest virtual
> toplology, as that will impact the firmware tables populated from the
> host for example, as in the nested case the guest will see an
> architectural SMMUv3 while in the collapsed case it will see a simple
> HVC based IOMMU.

Yes, this is how RMM/etc are working in CC land.

Untrusted hypervisor defines the vPCI topology, trusted hypervisor
implements it as instructed.

Jason
