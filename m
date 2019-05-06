Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646DC04AAD
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 21:12:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ACD21479
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+otEGFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ACD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 082685370;
	Mon,  6 May 2019 21:12:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F4CE4F9F
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 21:12:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 227E1875
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 21:12:10 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8E5A9206BF;
	Mon,  6 May 2019 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557177129;
	bh=H60Z5JzAVob3LUpzvsBUSRMR0trBUI8gbEMi3qxwp30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+otEGFalj9eUa8HjkWOq3eWomRR0iv//fLaRm9B3yuPSfOBCIZvDJKe0Fq8mIlDK
	c07TwmQDq5yc63UxbnrMEy0nGxTs/9VZOCUoEk7CUeMS5LlepJ5a1GrjR2nxDYHN9X
	jAi8+NP3yU9tXbm+wfK6Muzjk5drQDrBn7+4gdB4=
Date: Mon, 6 May 2019 16:12:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource
	entries to host bridge
Message-ID: <20190506211208.GA156478@google.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
	<1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, May 03, 2019 at 07:35:34PM +0530, Srinath Mannam wrote:
> The IPROC host controller allows only a subset of physical address space
> as target of inbound PCI memory transactions addresses.
> 
> PCIe devices memory transactions targeting memory regions that
> are not allowed for inbound transactions in the host controller
> are rejected by the host controller and cannot reach the upstream
> buses.
> 
> Firmware device tree description defines the DMA ranges that are
> addressable by devices DMA transactions; parse the device tree
> dma-ranges property and add its ranges to the PCI host bridge dma_ranges
> list; the iova_reserve_pci_windows() call in the driver will reserve the
> IOVA address ranges that are not addressable (ie memory holes in the
> dma-ranges set) so that they are not allocated to PCI devices for DMA
> transfers.
> 
> All allowed address ranges are listed in dma-ranges DT parameter.
> 
> Example:
> 
> dma-ranges = < \
>   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
>   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In the above example of dma-ranges, memory address from
> 
> 0x0 - 0x80000000,
> 0x100000000 - 0x800000000,
> 0x1000000000 - 0x8000000000 and
> 0x10000000000 - 0xffffffffffffffff.
> 
> are not allowed to be used as inbound addresses.
> 
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> [lorenzo.pieralisi@arm.com: updated commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..94ba5c0 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>  	return ret;
>  }
>  
> +static int
> +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> +			 struct of_pci_range *range)

Just FYI, I cherry-picked these commits from Lorenzo's branch to fix
the formatting of this prototype to match the rest of the file, e.g.:

>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> ...
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
