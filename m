Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFFBC83003
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:56:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3512072A
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3512072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 13673875BC;
	Wed, 29 Apr 2020 10:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0eVRiCKNN9Z; Wed, 29 Apr 2020 10:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6223A86F74;
	Wed, 29 Apr 2020 10:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E57AC0865;
	Wed, 29 Apr 2020 10:56:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073BDC0172;
 Wed, 29 Apr 2020 10:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E9D5C87742;
 Wed, 29 Apr 2020 10:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyAlNZhC4CvE; Wed, 29 Apr 2020 10:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A2068773D;
 Wed, 29 Apr 2020 10:56:15 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 03TAtvj5019413
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 12:55:57 +0200
Received: from [167.87.241.229] ([167.87.241.229])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 03TAtuRB023743;
 Wed, 29 Apr 2020 12:55:56 +0200
Subject: Re: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
 <20200429064458-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <303ace66-950c-955d-d750-74de5054788a@siemens.com>
Date: Wed, 29 Apr 2020 12:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429064458-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 konrad.wilk@oracle.com, will@kernel.org, jasowang@redhat.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, christoffer.dall@arm.com,
 pratikp@codeaurora.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
 alex.bennee@linaro.org, linux-kernel@vger.kernel.org
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

On 29.04.20 12:45, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
>> On 29.04.20 12:20, Michael S. Tsirkin wrote:
>>> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
>>>> That would still not work I think where swiotlb is used for pass-thr devices
>>>> (when private memory is fine) as well as virtio devices (when shared memory is
>>>> required).
>>>
>>> So that is a separate question. When there are multiple untrusted
>>> devices, at the moment it looks like a single bounce buffer is used.
>>>
>>> Which to me seems like a security problem, I think we should protect
>>> untrusted devices from each other.
>>>
>>
>> Definitely. That's the model we have for ivshmem-virtio as well.
>>
>> Jan
> 
> Want to try implementing that?
> 

The desire is definitely there, currently "just" not the time.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
