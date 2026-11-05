Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910667;
	b=MT6vjU1h8wN7uS99goNNuwEMNnGj3VZTJ3YwKmvj+f4mTWFv7GNJkQX5Zsz39WYlL0L6
	 kKT2tPzgeIPbcC4pYv+rQd51IOKAUGzikBoIrtBrzqi6jNWHQkaxsUigN2GwAL11B+/98
	 5z3Yre7PAbc/3LpRbP8tSfINtaqAOpDYJEkJFXdaBzn5NM0IJES1ggGKmntn/7vfiThU7
	 S6EfcdN4RKCYCH2b5kfyIBu/bUpqpS9Bv8HuL0Fg21zUJbtNxAvjPQPiOlCu7X8FmEDzS
	 TSDeZurQpE5htf14x5tYc44ZTB4JheVWXNX2mCLQQ+TUuu21nWaxHekR8lq5JPGFD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
	b=EHAS+vgQ38elFXW7k8tzhet7GT2iFkwfxMHPtBbR0Nd8n1NEnPj0pDyFOlTkApi20CZL
	 6LxyfDLN0EcrJPWnATLMUO9lN6tKYYHcyzEZFadNDihWe5QRHhYg3P9PujziddVgcSDvX
	 q7j3Hu2z4vyUDT+7nlQWJhpnCeVoP5Q5B8KpD/9swtmvLLwCJL+ywPlEcSs74hJI+TItW
	 TIIE1FU3p2NLmoSe/VmJkixMgBd3PqzWLqS3fU6LIiqw+6G7zqhSoJiBymjZGxyLnPX0Z
	 8RkMaCAMx59HGSi2AqD+Pg3GkxE+Hz03s8iNwf/Fh3I+C+AS6SlQQ+6vpQQqdoTUm5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="QeKcS/ht";
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E72606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 20:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E72606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QeKcS/ht
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99071945aa7so1215780241.3
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 12:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793910666; x=1794515466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
        b=QeKcS/htQn8xA4zo/BVIl7BG1hXne0lIOpYH1DAPhpG3wpI1gYb+/Y3ZnXA0sguo4Z
         qVtAahR5N/l5lypqZSZs/RfBmY2Ipa3469VzOrwuXkITE8HmfoflNRMkm1PJjHsgbh3O
         jqzqxytTAcv+KUMkP+W1LZzeXF5LkPv9k0CjPYDO5P1DMASdV1UZ7rzQNM8DIobnCts9
         0ArJo30ukO5eDPGFZ2JrefmSqSJekfHZqabLiKCWs+GLOQ5wWJI3xOXHqg01vdV0wZZU
         34+wQf3YG2LpyyblHFW/X0KcMK3e8Evcz3rBcRz3tbrPkEKnwakkSdVLC+vbg+yWMpaQ
         qzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910666; x=1794515466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vn/nQy7tt6P3ngQqcb52WlxWUAoV6PqlWG/Vx0RkwMM=;
        b=Hk6kUdReVEc1Q0kuJejglM5i2TMkX3Ghuo6zsD++ob9IOrWvIZobjHKEv5u4k/QAPI
         egMtQ/7t+3myQpD439BYD7iXUefOHOmXzJkGJReLYz/c/J52XTG0kxT0igEWaH2pzpBR
         w5kwNPFe5YwbUen7mm98Dq8XCl1py2PC1oCCErt62AzvhBzen/53gIKsvjaaJrUtk2mG
         F4jns05IRiO39gj+WygWJonWHy0jvS0feGe9rw55/uKJ74PJAekjCnaJBw+AdQGVLUi5
         gpmrGUAcoWrmKX1iEWlVbMtNvRCLke2WuCMnTweQcKr/5JM3QosI3zy3oSxYpyBL3ADz
         hrww==
X-Forwarded-Encrypted: i=1; AKwUvBzXHsKA6obToXr/4p/sW3aLuWf7Xfr+LbpJUMIrLwjXfq11RrCQVhBooInFs9jIIG2GsTEzaA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9iSs0YMZwSrHXZRgC8nMjvq46oEwP8McFhdKVuUjzgGu1sdt2H
	fQ6ZtjmxUZ/LDHUle7fkd6MkSYKUVgZEj9TELUqoWYrGb/s2FZ+rwqwWTMVtDkLGTUE=
X-Gm-Gg: AYBFou0r085qj961+MGBU6dpnvezigYoA4X5YkPMFLN1CxvHa8av70jRNIyaIil1h9i
	pj0ISwMnlRNbP1oxyKOHKu8ojaZXCxZzDD0GK/fiJtciyrWk5KluFzyHellR0XpjtCILk+x2MRs
	XYkTVgRiVi/T4qlz2avvmDGw8BHm01+dAcs7uDaqO5fzKGU2UVYl83edqxAcQucBmt2nTudsG3W
	VC9xbViG2jCRTpYH6xvRVYSxAjcTX+/Az8uHpHCIzjMLNSY4BrVX0KxvYd0Atb+JS62UFn27gal
	XUuINI1DB4i5wUyWAHYK3BS5T/0exBp3uUQgPMxV3pOP5BuT61lYe8H9fgZWBdRvbcauCYnkHzd
	tfV5+3d0LnhssczyXAWLvKWoHEMixe0dFja8DNCZOVYF6UNxgj0dHOsT1p937RvZA9hjiQtA3wj
	/x8SEcLoFMoFII0/vv1sEqicPIS08frBuNVRHGVOWONzAaDqRTy3JbRXOHqyMQpl82sRHdZqYEV
	4XJFwKQOfjC+IIgTeV3/4ZTADr+tSIeZCIJsS9fEjELwyvrCkiXdXgPo5jqSgqUufd71guiYyac
	lEB81rQbPk9mBKBV42mdLZdqVptFSJVL/rU6WlE1GJo/5EV2bE5QyrGPDUe7Laq0TFnbBbc/oN+
	NjNvLlGDgyw==
X-Received: by 2002:a05:6102:e0b:b0:7d2:7266:2c8a with SMTP id ada2fe7eead31-7d2a165f989mr692943137.32.1793910661522;
        Thu, 05 Nov 2026 12:31:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm5070410137.3.2026.11.05.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:31:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP46u-00000003hoW-1qsZ;
	Thu, 05 Nov 2026 16:31:00 -0400
Date: Thu, 5 Nov 2026 16:31:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <20261105203100.GG663069@ziepe.ca>
References: <20261105192738.70664-2-oss.patchbox@gmail.com>
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
In-Reply-To: <20261105192738.70664-2-oss.patchbox@gmail.com>

On Thu, Nov 05, 2026 at 02:27:08PM -0500, Yuho Choi wrote:
> hv_iommu_paging_domain_free() frees all page-table pages with
> pt_iommu_deinit() and only then asks the hypervisor to delete the
> device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> fails, hv_delete_device_domain() only logs the error, returns the
> domain ID to the IDA, and the domain is freed anyway.

Isn't there a WARN_ON on this path? I recall asking for one ..

So long as that is there this is the right way to continue

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
