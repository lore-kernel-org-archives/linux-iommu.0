Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC86C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 16:08:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9FB64F9B
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 16:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9FB64F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB2AA43196;
	Wed, 10 Mar 2021 16:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmnTwImOSZyl; Wed, 10 Mar 2021 16:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D207D431C1;
	Wed, 10 Mar 2021 16:08:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A934CC000A;
	Wed, 10 Mar 2021 16:08:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D587C0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 16:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CC9643196
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 16:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1WfOn6FKbYEn for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 16:08:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B816431C1
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 16:08:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E45D564F4C;
 Wed, 10 Mar 2021 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615392478;
 bh=7sTMvplzl4qRhmylBff3JMaWNZ6VDs7GHryb8IWMb8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PIIVIbrunaUx2mEUOz6ZJxHRH1se7E+5o1HDWFnKHf8eRzIiylHjOZmg5NZShqUGW
 hjBa9elVXNdk4eDdsGhTeXYuzv3/BXbX9p/KFb7ybT6VG90bTEx1lnCRZOw2RFaiFz
 xUEZGv0mJM9hDLsvPxYJiJZDiqjW49MgbOGmc1zY8E3cbyvNj4DU6HwresgdU5wkaD
 /6Nzn59UjeidTCW1K7nx7/asBj1lP/sYdEKM7aFPidqM8CVyvFTnzvC3yn1XacZioJ
 H8pxELt905xod7Mk5tdYLPuc5q0SIB1frKl7tHHxsimgV+p7eYBm76eNyVHMHiOgX+
 s9X5laJqNqC3Q==
Date: Wed, 10 Mar 2021 16:07:48 +0000
From: Will Deacon <will@kernel.org>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210310160747.GA29834@willie-the-truck>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-14-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209062131.2300005-14-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Claire,

On Tue, Feb 09, 2021 at 02:21:30PM +0800, Claire Chang wrote:
> Introduce the new compatible string, restricted-dma-pool, for restricted
> DMA. One can specify the address and length of the restricted DMA memory
> region by restricted-dma-pool in the reserved-memory node.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index e8d3096d922c..fc9a12c2f679 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - restricted-dma-pool: This indicates a region of memory meant to be
> +          used as a pool of restricted DMA buffers for a set of devices. The
> +          memory region would be the only region accessible to those devices.
> +          When using this, the no-map and reusable properties must not be set,
> +          so the operating system can create a virtual mapping that will be used
> +          for synchronization. The main purpose for restricted DMA is to
> +          mitigate the lack of DMA access control on systems without an IOMMU,
> +          which could result in the DMA accessing the system memory at
> +          unexpected times and/or unexpected addresses, possibly leading to data
> +          leakage or corruption. The feature on its own provides a basic level
> +          of protection against the DMA overwriting buffer contents at
> +          unexpected times. However, to protect against general data leakage and
> +          system memory corruption, the system needs to provide way to lock down
> +          the memory access, e.g., MPU.

As far as I can tell, these pools work with both static allocations (which
seem to match your use-case where firmware has preconfigured the DMA ranges)
but also with dynamic allocations where a 'size' property is present instead
of the 'reg' property and the kernel is responsible for allocating the
reservation during boot. Am I right and, if so, is that deliberate?

I ask because I think that would potentially be useful to us for the
Protected KVM work, where we need to bounce virtio memory accesses via
guest-determined windows because the guest memory is generally inaccessible
to the host. We've been hacking this using a combination of "swiotlb=force"
and set_memory_{decrypted,encrypted}() but it would be much better to
leverage the stuff you have here.

Also:

> +
> +		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> +			compatible = "restricted-dma-pool";
> +			reg = <0x50000000 0x400000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_device: pcie_device@0,0 {
> +		memory-region = <&restricted_dma_mem_reserved>;
> +		/* ... */
> +	};

I find this example a bit weird, as I didn't think we usually had DT nodes
for PCI devices; rather they are discovered as a result of probing config
space. Is the idea that you have one reserved memory region attached to the
RC and all the PCI devices below that share the region, or is there a need
for a mapping mechanism?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
