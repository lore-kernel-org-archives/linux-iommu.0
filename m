Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5BC8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 11:12:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB3020757
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 11:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tdni3ZMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB3020757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C00F86BB9;
	Thu, 30 Apr 2020 11:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4b7e0Bew_t3Q; Thu, 30 Apr 2020 11:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E38E86BB3;
	Thu, 30 Apr 2020 11:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A93DC0889;
	Thu, 30 Apr 2020 11:12:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5121C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E8E886D2C
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxdVZuKyVOun for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 11:12:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A12CF86BB3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 11:12:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588245140; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=XKOYbc1TPw2rm1iRNmfQra/wU/JM76LfaUCtYzQ89Ow=;
 b=tdni3ZMXL80YMNHUCzfb0mmeLxJ+PvijlK5pjwtuYh7sQ+a9ZH76HxP00Kxe6FxwiOoNJu9m
 //2qOe5Nl98oMIarh4XIcUEnLcitfP7PnBZ7WSL35xC8v8T10q3ErfB8GTjfIz0tgQuqvcfl
 AsKoxfdBz+iS/H+R3YGqW0bFUoI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaab286.7f1b788efe68-smtp-out-n04;
 Thu, 30 Apr 2020 11:12:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8A82CC44788; Thu, 30 Apr 2020 11:12:04 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C4305C433F2;
 Thu, 30 Apr 2020 11:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4305C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Thu, 30 Apr 2020 16:41:56 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430111156.GI5097@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430104149.GG19932@willie-the-truck>
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

* Will Deacon <will@kernel.org> [2020-04-30 11:41:50]:

> On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
> > If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
> > set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
> > example: message_queue_send() and message_queue_recevie() hypercalls).
> 
> Hmm, but then how would such a kernel work as a guest under all the
> spec-compliant hypervisors out there?

Ok I see your point and yes for better binary compatibility, the ops have to be
set based on runtime detection of hypervisor capabilities.

> > Ok. I guess the other option is to standardize on a new virtio transport (like
> > ivshmem2-virtio)?
> 
> I haven't looked at that, but I suppose it depends on what your hypervisor
> folks are willing to accomodate.

I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
(for life-cycle management of VMs), which our hypervisor may not support. A
simple shared memory and doorbell or message-queue based transport will work for
us.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
