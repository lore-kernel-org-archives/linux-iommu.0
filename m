Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE553C8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 13:33:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27F82074A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BMv+gEtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27F82074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 681E28872F;
	Thu, 30 Apr 2020 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9LPII0kspdF; Thu, 30 Apr 2020 13:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EE65F886E1;
	Thu, 30 Apr 2020 13:33:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C375AC0889;
	Thu, 30 Apr 2020 13:33:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED43C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 13:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 686FB8872F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 13:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vTsMK9Pr1OKR for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 13:33:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E98B7886E1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 13:33:35 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588253618; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=CuOvrrJLy80VLlsv+8kdk0jI2oS0V9P+u4Q0xRy+jj8=;
 b=BMv+gEtQIDfGOaJK4B8uetPTtb12zWD3IzBgc7uRdEPq8dlBlz7EsK6hpE4dDacecEYXFtr4
 gOchmb0AcLRMCzeuaCCZlpArNLEDkxa/XOtsXyBW6QEy6iH7D3X36pnj4LtljuCq0wTGEVl/
 SlfzJjDUdhvyb2YeOSw3LDOWMQI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaad3aa.7fae58df6fb8-smtp-out-n05;
 Thu, 30 Apr 2020 13:33:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 539ABC43637; Thu, 30 Apr 2020 13:33:30 +0000 (UTC)
Received: from quicinc.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 53CA5C433D2;
 Thu, 30 Apr 2020 13:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53CA5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
Date: Thu, 30 Apr 2020 19:03:21 +0530
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430133321.GC3204@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 pratikp@codeaurora.org, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, Will Deacon <will@kernel.org>,
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

* Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:

> >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> >(for life-cycle management of VMs), which our hypervisor may not support. A
> >simple shared memory and doorbell or message-queue based transport will work for
> >us.
> 
> As written in our private conversation, a mapping of the ivshmem2 device
> discovery to platform mechanism (device tree etc.) and maybe even the
> register access for doorbell and life-cycle management to something
> hypercall-like would be imaginable. What would count more from virtio
> perspective is a common mapping on a shared memory transport.

Yes that sounds simpler for us.

> That said, I also warned about all the features that PCI already defined
> (such as message-based interrupts) which you may have to add when going a
> different way for the shared memory device.

Is it really required to present this shared memory as belonging to a PCI
device? I would expect the device-tree to indicate the presence of this shared
memory region, which we should be able to present to ivshmem2 as shared memory
region to use (along with some handles for doorbell or message queue use).

I understand the usefulness of modeling the shared memory as part of device so
that hypervisor can send events related to peers going down or coming up. In our
case, there will be other means to discover those events and avoiding this
requirement on hypervisor (to emulate PCI) will simplify the solution for us.

Any idea when we can expect virtio over ivshmem2 to become available?!
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
