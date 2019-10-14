Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4764C4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 14:05:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FCB2083B
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FCB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0E78142E;
	Mon, 14 Oct 2019 14:05:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 59CCB1389
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 13:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E74FC5D3
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 13:55:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0982A337;
	Mon, 14 Oct 2019 06:55:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224D83F68E;
	Mon, 14 Oct 2019 06:54:59 -0700 (PDT)
Subject: Re: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>
References: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
Date: Mon, 14 Oct 2019 14:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 13/10/2019 15:28, Daniele Alessandrelli wrote:
> Hi,
> 
> It looks like dma_alloc_coherent() is setting the dma_handle output
> parameter to the memory physical address and not the device bus
> address when the device is using reserved memory regions for DMA
> allocation. This is despite using 'dma_ranges' in the device tree to
> describe the DMA memory mapping. Is this expected behavior or a bug?

That does sound like a bug :(

> Here is a reduced version of the device tree I'm using:
> \ {
>          reserved-memory {
>                  #address-cells = <2>;
>                  #size-cells = <2>;
>                  ranges;
>                  mydev_rsvd: rsvd_mem@494800000 {
>                          compatible = "shared-dma-pool";
>                          reg = <0x4 0x94800000 0x0 0x200000>;
>                          no-map;
>                  };
>          };
>          soc {
>                  compatible = "simple-bus";
>                  #address-cells = <2>;
>                  #size-cells = <2>;
>                  ranges;
>                  dma_ranges;
> 
>                  mybus {
>                          ranges = <>;
>                          dma-ranges = <>;
>                          compatible = "simple-bus";
>                          #address-cells = <2>;
>                          #size-cells = <2>;
>                          ranges =     <0x0 0x0  0x0 0x0  0x0 0x80000000>;
>                          dma-ranges = <0x0 0x80000000  0x4 0x80000000
> 0x0 0x80000000>;
> 
>                          mydevice {
>                                  compatible = "my-compatible-string";
>                                  memory-region = <&mydev_rsvd>;
>                          }
>                  }
>          }
> };
> 
> It looks like this issue was previously fixed by commit c41f9ea998f3
> ("drivers: dma-coherent: Account dma_pfn_offset when used with device
> tree") which introduced a new function ('dma_get_device_base()') to
> return the reserved memory address as seen by the device. However,
> such a function, even if still there, is not used anymore in latest
> code (as of v5.4-rc2). Was that done for a specific reason? Or is it
> just a mistake?

Hmm, it looks like 43fc509c3efb ("dma-coherent: introduce interface for 
default DMA pool") removed the caller of dma_get_device_base() in the 
alloc path shortly after it was introduced, which certainly appears as 
if it may have been unintentional - Vladimir?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
