Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF45C8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 13:00:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBFD2078D
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 13:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBFD2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 17BF624C39;
	Thu, 30 Apr 2020 13:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIIYMHOu0M4O; Thu, 30 Apr 2020 13:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A834524DD1;
	Thu, 30 Apr 2020 13:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 845A9C0864;
	Thu, 30 Apr 2020 13:00:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73866C016F;
 Thu, 30 Apr 2020 13:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6F7F786D5D;
 Thu, 30 Apr 2020 13:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2SrxAZMIV2c6; Thu, 30 Apr 2020 13:00:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E41F786D55;
 Thu, 30 Apr 2020 13:00:02 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 03UCxqYX019571
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2020 14:59:52 +0200
Received: from [139.22.32.49] ([139.22.32.49])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 03UCxo1b023033;
 Thu, 30 Apr 2020 14:59:50 +0200
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>, Will Deacon <will@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck> <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck> <20200430111156.GI5097@quicinc.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
Date: Thu, 30 Apr 2020 14:59:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111156.GI5097@quicinc.com>
Content-Language: en-US
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, mst@redhat.com,
 alex.bennee@linaro.org, jasowang@redhat.com, konrad.wilk@oracle.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 30.04.20 13:11, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:41:50]:
> 
>> On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
>>> If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
>>> set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
>>> example: message_queue_send() and message_queue_recevie() hypercalls).
>>
>> Hmm, but then how would such a kernel work as a guest under all the
>> spec-compliant hypervisors out there?
> 
> Ok I see your point and yes for better binary compatibility, the ops have to be
> set based on runtime detection of hypervisor capabilities.
> 
>>> Ok. I guess the other option is to standardize on a new virtio transport (like
>>> ivshmem2-virtio)?
>>
>> I haven't looked at that, but I suppose it depends on what your hypervisor
>> folks are willing to accomodate.
> 
> I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> (for life-cycle management of VMs), which our hypervisor may not support. A
> simple shared memory and doorbell or message-queue based transport will work for
> us.

As written in our private conversation, a mapping of the ivshmem2 device 
discovery to platform mechanism (device tree etc.) and maybe even the 
register access for doorbell and life-cycle management to something 
hypercall-like would be imaginable. What would count more from virtio 
perspective is a common mapping on a shared memory transport.

That said, I also warned about all the features that PCI already defined 
(such as message-based interrupts) which you may have to add when going 
a different way for the shared memory device.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
