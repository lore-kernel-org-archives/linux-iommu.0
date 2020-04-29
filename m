Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C24C83003
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 03:35:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A31206D9
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 03:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ekeNfq/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A31206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7603388268;
	Wed, 29 Apr 2020 03:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xd+De76oNTT7; Wed, 29 Apr 2020 03:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9AA11880B3;
	Wed, 29 Apr 2020 03:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6DDC0863;
	Wed, 29 Apr 2020 03:35:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17C88C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 03:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F27A38614A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 03:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ksi3PRIIbBBq for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 03:35:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0C71985F85
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 03:35:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588131348; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=RKZjGjRaRWOMA4bE7u8bYNMGSYHBc1o/5aoxXJ54jnQ=;
 b=ekeNfq/NESZkvn3ssaiQrFsTjAuduUOnmKFiH5wiUi17WPoDZ26tcXaYlwIhaLz/NCp6laaG
 VJM1kgIkDvrkrf8j0j+GsZSal4S90Z1w+GtoyLAJ8pQoEP03KlL9SCaD8F96bIYHOhsawbbY
 1dbl/29qifKBAwZbk1mZxBUgTeE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8f614.7f8a47a88b58-smtp-out-n04;
 Wed, 29 Apr 2020 03:35:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2AEFAC432C2; Wed, 29 Apr 2020 03:35:47 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C61BC433D2;
 Wed, 29 Apr 2020 03:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C61BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Wed, 29 Apr 2020 09:05:39 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429033539.GB5097@quicinc.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
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
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

* Michael S. Tsirkin <mst@redhat.com> [2020-04-28 16:41:04]:

> > Won't we still need some changes to virtio to make use of its own pool (to
> > bounce buffers)? Something similar to its own DMA ops proposed in this patch?
> 
> If you are doing this for all devices, you need to either find a way
> to do this without chaning DMA ops, or by doing some automatic change
> to all drivers.

Ok thanks for this input. I will see how we can obfuscate this in DMA APIs
itself.

Can you also comment on the virtio transport problem I cited? The hypervisor we
are dealing with does not support MMIO transport. It supports message queue
send/recv and also doorbell, which I think can be used if we can make some
change like this to virtio_mmio.c:

+static inline u32
+virtio_readl(struct virtio_mmio_device *vm_dev, u32 reg_offset)
+{
+        return vm_dev->mmio_ops->readl(vm_dev, reg_offset);
+}
+ 
+static inline void
+virtio_writel(struct virtio_mmio_device *vm_dev, u32 reg_offset, u32 data)
+{
+        vm_dev->mmio_ops->writel(vm_dev, reg_offset, data);
+}


        /* Check magic value */
-        magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
+        magic = vrito_readl(vm_dev, VIRTIO_MMIO_MAGIC_VALUE);

mmio_ops->readl on most platforms can default to readl itself, while on a
platform like us, it can boil down to message_queue send/recv. Would such a
change be acceptable?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
