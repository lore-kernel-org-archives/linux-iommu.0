Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3425BC433F5
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 01:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0F8F41FBA;
	Fri,  7 Jan 2022 01:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3F_g1xxDD0Ez; Fri,  7 Jan 2022 01:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68C1F400E5;
	Fri,  7 Jan 2022 01:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2554DC002F;
	Fri,  7 Jan 2022 01:54:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6990C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DA79833AF
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNyUHuWIbPpu for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A5E7833AE
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641520482; x=1673056482;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Jt8G5RvicmESM2ejSPAMQP973KFNwwweQUosaDpYZ+Y=;
 b=icHVwR+Bx3qfGy28JP7zxYLqxQK75AAZipFoinDX4WewSRCoHtWRV4W0
 6i4it/3shDLcHYtn59uz/vWvgV2vOqCBuB4zbHSzSFAJOMjESQu3fr5W1
 I7bg33PJjTmryfnmLgE+zcTp4QbIOmYvpM6wfHG/MPbpb2UopJN/Bvsm/
 aaJh1zYKYmBXeRjvzoe6rarbLSAkeqo/tskdhv2Y8hIF79S81OphlEGWA
 Fuq9CNwsgKuNkUNhEuMpNsknUvGRI7zbxyuUErqiz3mIU6d6a0150sJda
 tSyIIpBbIH7tXlmeeBANak3Omt/6SX6ZtWE1GiuLC1uDhw3fgA8ad8EXj Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="241603460"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="241603460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 17:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="527209969"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 17:54:34 -0800
Subject: Re: [PATCH v5 09/14] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20220106183224.GA298861@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1545319f-130e-3750-ea00-082a12b73852@linux.intel.com>
Date: Fri, 7 Jan 2022 09:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106183224.GA298861@bhelgaas>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On 1/7/22 2:32 AM, Bjorn Helgaas wrote:
> On Thu, Jan 06, 2022 at 12:12:35PM +0800, Lu Baolu wrote:
>> On 1/5/22 1:06 AM, Bjorn Helgaas wrote:
>>> On Tue, Jan 04, 2022 at 09:56:39AM +0800, Lu Baolu wrote:
>>>> If a switch lacks ACS P2P Request Redirect, a device below the switch can
>>>> bypass the IOMMU and DMA directly to other devices below the switch, so
>>>> all the downstream devices must be in the same IOMMU group as the switch
>>>> itself.
>>> Help me think through what's going on here.  IIUC, we put devices in
>>> the same IOMMU group when they can interfere with each other in any
>>> way (DMA, config access, etc).
>>>
>>> (We said "DMA" above, but I guess this would also apply to config
>>> requests, right?)
>>
>> I am not sure whether devices could interfere each other through config
>> space access. The IOMMU hardware only protects and isolates DMA
>> accesses, so that userspace could control DMA directly. The config
>> accesses will always be intercepted by VFIO. Hence, I don't see a
>> problem.
> 
> I was wondering about config accesses generated by an endpoint, e.g.,
> an endpoint doing config writes to a peer or the upstream bridge.
> 
> But I think that is prohibited by spec - PCIe r5.0, sec 7.3.3, says
> "Propagation of Configuration Requests from Downstream to Upstream as
> well as peer-to-peer are not supported" and "Configuration Requests
> are initiated only by the Host Bridge, including those passed through
> the SFI CAM mechanism."

That's clear. Thank you for the clarification.

> 
> Bjorn
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
