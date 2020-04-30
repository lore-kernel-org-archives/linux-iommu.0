Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992DAC8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618722082E
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvlDRD0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618722082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1B4EC88692;
	Thu, 30 Apr 2020 10:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcEZHSeJuqpZ; Thu, 30 Apr 2020 10:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F91288604;
	Thu, 30 Apr 2020 10:14:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21EACC088F;
	Thu, 30 Apr 2020 10:14:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3573FC016F;
 Thu, 30 Apr 2020 10:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2F32786B83;
 Thu, 30 Apr 2020 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8PHaIFYqtW7; Thu, 30 Apr 2020 10:14:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BDB07869C9;
 Thu, 30 Apr 2020 10:14:37 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 546C52082E;
 Thu, 30 Apr 2020 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588241677;
 bh=K4iRN3zCPNFjbTseot6WcbvyRWpaRNNyZ8e0DoLGw0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JvlDRD0fualhnU0GtkqaCGYeK0Ta5RV7QlJMm+JXxK6sJpn+Ba3M4ZH+1i92mJL0x
 heHHfzv8MWGQl/ku3fbX8+JeRaDczFuoMJh77a7aya9Z2AA2yQdeG6kk2+w4pu21MY
 nx67itkvi/2CXKxGbdHb5la8yWUNEL0Nqkcfe3pc=
Date: Thu, 30 Apr 2020 11:14:32 +0100
From: Will Deacon <will@kernel.org>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430101431.GD19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 jan.kiszka@siemens.com, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, pratikp@codeaurora.org,
 linux-kernel@vger.kernel.org
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

On Thu, Apr 30, 2020 at 03:32:56PM +0530, Srivatsa Vaddagiri wrote:
> Some hypervisors may not support MMIO transport i.e trap config
> space access and have it be handled by backend driver. They may
> allow other ways to interact with backend such as message-queue
> or doorbell API. This patch allows for hypervisor specific
> methods for config space IO.
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
> ---
>  drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
>  include/linux/virtio.h       |  14 +++++
>  2 files changed, 94 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..69bfa35 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -100,7 +100,35 @@ struct virtio_mmio_vq_info {
>  	struct list_head node;
>  };
>  
> +#ifdef CONFIG_VIRTIO_MMIO_OPS
>  
> +static struct virtio_mmio_ops *mmio_ops;
> +
> +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))

How exactly are these ops hooked up? I'm envisaging something like:

	ops = spec_compliant_ops;
	[...]
	if (firmware_says_hypervisor_is_buggy())
		ops = magic_qcom_ops;

am I wrong?

> +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> +{
> +	pr_info("Registered %s as mmio ops\n", ops->name);
> +	mmio_ops = ops;

Not looking good, and really defeats the point of standardising this stuff
imo.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
