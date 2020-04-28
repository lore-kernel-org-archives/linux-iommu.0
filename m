Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE95C83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:54:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3C42070B
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 22:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ywBOYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3C42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ABA63229D4;
	Tue, 28 Apr 2020 22:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJIkGUCzodBQ; Tue, 28 Apr 2020 22:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B30782154E;
	Tue, 28 Apr 2020 22:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A116C0864;
	Tue, 28 Apr 2020 22:53:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49091C0172;
 Tue, 28 Apr 2020 22:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 31DFD843BD;
 Tue, 28 Apr 2020 22:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0jQFLgzv8dFO; Tue, 28 Apr 2020 22:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8C45D84273;
 Tue, 28 Apr 2020 22:53:56 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ACB2E206D9;
 Tue, 28 Apr 2020 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588114436;
 bh=ywVtSYZTVnlMl6doGY8VJNhfjwkHTSTfeN9miNjuHLc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=K8ywBOYNFWIro+8tTcJPkzDdktI4MKmTQFI2jKuDDCZxz/UPDSdJCkEwANhDBlV4Z
 +AD2jXT3SglB96bLRp2T+E2dhPpvIycmfgpopwde4gOSyMWOMgY/EG/59z2V1xC782
 pzdsNh2DvdLoOlNaBrJ/mPX3Dl7yMXVfFt5esrDw=
Date: Tue, 28 Apr 2020 15:53:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Message-ID: <alpine.DEB.2.21.2004281542010.29217@sstabellini-ThinkPad-T480s>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 jan.kiszka@siemens.com, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org,
 pratikp@codeaurora.org
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

On Tue, 28 Apr 2020, Srivatsa Vaddagiri wrote:
> For better security, its desirable that a guest VM's memory is
> not accessible to any entity that executes outside the context of
> guest VM. In case of virtio, backend drivers execute outside the
> context of guest VM and in general will need access to complete
> guest VM memory.  One option to restrict the access provided to
> backend driver is to make use of a bounce buffer. The bounce
> buffer is accessible to both backend and frontend drivers. All IO
> buffers that are in private space of guest VM are bounced to be
> accessible to backend.

[...]

> +static int __init virtio_bounce_setup(struct reserved_mem *rmem)
> +{
> +	unsigned long node = rmem->fdt_node;
> +
> +	if (!of_get_flat_dt_prop(node, "no-map", NULL))
> +		return -EINVAL;
> +
> +	return virtio_register_bounce_buffer(rmem->base, rmem->size);
> +}
> +
> +RESERVEDMEM_OF_DECLARE(virtio, "virtio_bounce_pool", virtio_bounce_setup);

Is this special reserved-memory region documented somewhere?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
