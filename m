Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB8E555
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983825; cv=none; b=jLlk+dn0WvcGF8GXqYTIcb1UaWcxr1EoF3OJjaXuhxoOd+aQdD4ADedu7ndl4XvpGVSTWOBm7WPilrGI/Gfa3T5bfm8abHso5D2yR4mGUl2kRDMr6hNEn8Mwx0cQt7svvE7s4sKdeLO1ESObxydJOe1N8zJPWG7jUVkX8zA09uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983825; c=relaxed/simple;
	bh=Cnktq8nDwOo0enCBi8xzUPVV/YQByN0c6KsnAyAr6qo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdFJdxSV3sBUwInEOpN2GhYkNmbmru69UjZ70E3oi7zz1wTYWSRspEkY/lsjpx92H6WFSr7wD+eUsX+lQTwIgxDzvLE9vbRK4wul6ITB6YSt1h6KL5hCgfL1D2qLRutMZSnz/53gt/9oHzjocS2DOKoRLf1P8Z/8KzULEFucDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NOfOAshs; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NOfOAshs"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IDhPpX310236
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 08:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744983805;
	bh=WNj2Be0bKSfGk+fsGABndEIKFa0Oidh9U8eYMXOA2ds=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NOfOAshsqJxkwafY5dgPwxjMkNwFRwWVc5bemqBrcPclY5Xy/klRH9ioK/07GcrwY
	 OP2M/cROoTuC9+oD47MyO41WFVfv5PKiqVBc5aEOnx+jlEWSfQaEyfw6zIPSlHd6tK
	 OkbqwLKecAsg090lWHGb/o4s4Ji5I0sc7MTiNY8Y=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IDhPbo003348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Apr 2025 08:43:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 08:43:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 08:43:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IDhOLc051358;
	Fri, 18 Apr 2025 08:43:24 -0500
Date: Fri, 18 Apr 2025 08:43:24 -0500
From: Nishanth Menon <nm@ti.com>
To: <huaqian.li@siemens.com>
CC: <helgaas@kernel.org>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <jan.kiszka@siemens.com>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <s-vadapalli@ti.com>, <ssantosh@kernel.org>,
        <vigneshr@ti.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Message-ID: <20250418134324.ewsfnze2btnx2r2w@country>
References: <20241030205703.GA1219329@bhelgaas>
 <20250418073026.2418728-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418073026.2418728-1-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:30-20250418, huaqian.li@siemens.com wrote:
> 
> Jan Kiszka (7):
>   dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
>   dt-bindings: PCI: ti,am65: Extend for use with PVU
>   soc: ti: Add IOMMU-like PVU driver
>   PCI: keystone: Add support for PVU-based DMA isolation on AM654
>   arm64: dts: ti: k3-am65-main: Add PVU nodes
>   arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
>   arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
>     behind PCI RC
> 
> Li Hua Qian (1):
>   swiotlb: Make IO_TLB_SEGSIZE configurable

I see at least 3 or 4 maintainers needing to co-ordinate, gets
complicated as I am not sure which maintainer needs to pick up what
patches in what dependency order. This looks like a mixed bag. Can
we split this patch into independent series for each maintainer with
clear indication of dependencies that is spread around a couple of
kernel windows (maybe dts comes in last?)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
