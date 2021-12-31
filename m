Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225F4C433F5
	for <iommu@archiver.kernel.org>; Fri, 31 Dec 2021 01:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9996260C1E;
	Fri, 31 Dec 2021 01:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXpZG8NE5rcm; Fri, 31 Dec 2021 01:11:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E53960B7D;
	Fri, 31 Dec 2021 01:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46875C001E;
	Fri, 31 Dec 2021 01:11:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9ADC0012
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 747C94043B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HphMXXlykEZf for <iommu@lists.linux-foundation.org>;
 Fri, 31 Dec 2021 01:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F9BB40178
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640913085; x=1672449085;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=6rk8MecEhpwbWspAjVxoCvCgMk2ueISFEzgwGnGfDMs=;
 b=bhWQq9Muqdvps269JyGlZZj1Kv2qfCqJ9WZyrR6oliUlKQXppSk3hV+K
 ofh9gvAWjzd+uactpRp3dSLhDiQtvLYmIERxt9aU1YH7FxW+v9fXiAL6p
 A219ZLJQDiK3dxhTKqQECSakIz9Oxkdk6ZScwrrK+4RxVHdiuHTsWW3EM
 5Q7cg21Lzmz1fcZGLfamVk4ax4JmyYDwL33zXOmMqntxws7eoseMnEuZW
 HMZZegO1NgmlUzn/sks4KfocF32Vs+98X3OC/DlrfjSTNDf9sMitoPkS/
 bXYHQ+O57tchXAuyhIEJzHMx3q+9Md19DOTU2aeYDAo43mamqoOijdof5 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="222425797"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; d="scan'208";a="222425797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 17:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; d="scan'208";a="524573848"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 17:11:15 -0800
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <568b6d1d-69df-98ad-a864-dd031bedd081@linux.intel.com>
 <20211230222414.GA1805873@bhelgaas> <20211231004019.GH1779224@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5eb8650c-432f-bf06-c63d-6320199ef894@linux.intel.com>
Date: Fri, 31 Dec 2021 09:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211231004019.GH1779224@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jason,

On 12/31/21 8:40 AM, Jason Gunthorpe wrote:
> On Thu, Dec 30, 2021 at 04:24:14PM -0600, Bjorn Helgaas wrote:
> 
>> I was speculating that maybe the DMA ownership claiming must be done
>> *before* the driver's .probe() method?
> 
> This is correct.
> 
>> If DMA ownership could be claimed by the .probe() method, we
>> wouldn't need the new flag in struct device_driver.
> 
> The other requirement is that every existing driver must claim
> ownership, so pushing this into the device driver's probe op would
> require revising almost every driver in Linux...
> 
> In effect the new flag indicates if the driver will do the DMA
> ownership claim in it's probe, or should use the default claim the
> core code does.
> 
> In almost every case a driver should do a claim. A driver like
> pci-stub, or a bridge, that doesn't actually operate MMIO on the
> device would be the exception.

We still need to call iommu_device_use_dma_api() in bus dma_configure()
callback. But we can call iommu_device_unuse_dma_api() in the .probe()
of vfio (and vfio-approved) drivers, so that we don't need the new flag
anymore.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
