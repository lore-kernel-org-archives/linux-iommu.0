Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A6BC8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:35:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2771020838
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="q111EpsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2771020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9EA7876CF;
	Thu, 30 Apr 2020 10:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fiT4yMV7KsRp; Thu, 30 Apr 2020 10:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDD2686AE5;
	Thu, 30 Apr 2020 10:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFFCAC0864;
	Thu, 30 Apr 2020 10:35:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F182C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 76E48204DD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TF22rq+r4Ben for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 10:35:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id E6599204B6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:35:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588242915; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FacaeX+QW3gZe3CsWw46u78war6rqHZGj6J6LKrNjcs=;
 b=q111EpsLYVfjfuqMCY4uE7I+CwAgSMpyqw9g3GOVeVQXnDpJkHlzwfyKm3bL5ZjXtoJwhr5r
 H9mYSRTBfk4AkKY8TGvTHUpLFuTQwfRy+ZM7e7bERQfaYOgQ33qqQ7Pj+aXTbZHHRF49gZl3
 8FW07z3TBAZ14eioX/oxttifp10=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa9ce.7f843e726ea0-smtp-out-n03;
 Thu, 30 Apr 2020 10:34:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3AD09C44788; Thu, 30 Apr 2020 10:34:54 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 73383C433CB;
 Thu, 30 Apr 2020 10:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73383C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Thu, 30 Apr 2020 16:04:46 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430103446.GH5097@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430101431.GD19932@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

* Will Deacon <will@kernel.org> [2020-04-30 11:14:32]:

> > +#ifdef CONFIG_VIRTIO_MMIO_OPS
> >  
> > +static struct virtio_mmio_ops *mmio_ops;
> > +
> > +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> > +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> > +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
> 
> How exactly are these ops hooked up? I'm envisaging something like:
> 
> 	ops = spec_compliant_ops;
> 	[...]
> 	if (firmware_says_hypervisor_is_buggy())
> 		ops = magic_qcom_ops;
> 
> am I wrong?

If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
example: message_queue_send() and message_queue_recevie() hypercalls).

> > +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> > +{
> > +	pr_info("Registered %s as mmio ops\n", ops->name);
> > +	mmio_ops = ops;
> 
> Not looking good, and really defeats the point of standardising this stuff
> imo.

Ok. I guess the other option is to standardize on a new virtio transport (like
ivshmem2-virtio)?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
