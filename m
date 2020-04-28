Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE7C83009
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AD620757
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QyEtjtii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AD620757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26A5887667;
	Tue, 28 Apr 2020 17:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADDUEJsfv4v9; Tue, 28 Apr 2020 17:50:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F29F587657;
	Tue, 28 Apr 2020 17:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D588FC0863;
	Tue, 28 Apr 2020 17:50:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEFDC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 17:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0AC7687657
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 17:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBBEnfmezFW7 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 17:50:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BBC87875B4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 17:50:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588096205; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=RU7G35ytN1BEFIjXJLTsdCsbIgjwEPp3gbageUwxBUA=;
 b=QyEtjtiiiLGlDNxjAO2FFXh/UsI7M1ySagTcqgweXY02aVIH5Vwm0b2MG/S432EEHfrsGLOF
 GDs/vyqEwIthxbw62ybQ8emflUVllCAK6UZIrRekNg+92sVuDOmwlqlm45j2zSZCBcn4YB79
 ojbTfJgcRzd6JwUJaNuNJ5Ez7Kc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea86cc8.7f844417c0a0-smtp-out-n03;
 Tue, 28 Apr 2020 17:50:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 511EAC43636; Tue, 28 Apr 2020 17:50:00 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B39A3C433D2;
 Tue, 28 Apr 2020 17:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B39A3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Tue, 28 Apr 2020 23:19:52 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200428174952.GA5097@quicinc.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428121232-mutt-send-email-mst@kernel.org>
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

* Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:

> Okay, but how is all this virtio specific?  For example, why not allow
> separate swiotlbs for any type of device?
> For example, this might make sense if a given device is from a
> different, less trusted vendor.

Is swiotlb commonly used for multiple devices that may be on different trust
boundaries (and not behind a hardware iommu)? If so, then yes it sounds like a
good application of multiple swiotlb pools.

> All this can then maybe be hidden behind the DMA API.

Won't we still need some changes to virtio to make use of its own pool (to
bounce buffers)? Something similar to its own DMA ops proposed in this patch?

> > +void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
> > +{
> > +	if (!bounce_buf_paddr)
> > +		return;
> > +
> > +	set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
> 
> 
> I don't think DMA API maintainers will be happy with new users
> of set_dma_ops.

Is there an alternate API that is more preffered?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
