Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E33C2BB85
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:47:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22972137B
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+54tsoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22972137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 858BF88164;
	Fri, 17 Apr 2020 07:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTMh5qmi7Tbi; Fri, 17 Apr 2020 07:47:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 071F188162;
	Fri, 17 Apr 2020 07:47:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7796C1AE8;
	Fri, 17 Apr 2020 07:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA36CC0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B79BE87609
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10rVrIFC3Gmp for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 07:47:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B199875B9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587109628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OnCFlVZKT1kcPJl0tm16QfqztTjiCxEfefQVkmAO2Q4=;
 b=F+54tsoLXnprRNxJwQMKk+GDOP7FcUV1nZhgZ5hb4qxvCcpBv3w+nH+D+a9ZHVU5gO807e
 Cn1nKRlvzU+ahsaQRqa0Y3NF8Bq7fBm2X/DEnJ02I5KupT5SWSWFoChXYdCebF7ufaQicr
 oqbqpdqc/Gp1gj0ECYasH79HMCJQ620=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301--znvfP_QP-a_NK8x7vIE7A-1; Fri, 17 Apr 2020 03:47:03 -0400
X-MC-Unique: -znvfP_QP-a_NK8x7vIE7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116C118B9FC8;
 Fri, 17 Apr 2020 07:47:02 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E56D9129F81;
 Fri, 17 Apr 2020 07:46:56 +0000 (UTC)
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410124557.4012b99b@jacob-builder>
 <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2025736d-e7f2-d746-e030-e609b2f465e2@redhat.com>
Date: Fri, 17 Apr 2020 09:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Yi L <yi.l.liu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Kevin,
On 4/17/20 4:45 AM, Tian, Kevin wrote:
>> From: Auger Eric
>> Sent: Thursday, April 16, 2020 6:43 PM
>>
> [...]
>>>>> +	if (svm) {
>>>>> +		/*
>>>>> +		 * If we found svm for the PASID, there must be at
>>>>> +		 * least one device bond, otherwise svm should be
>>>>> freed.
>>>>> +		 */
>>>>> +		if (WARN_ON(list_empty(&svm->devs))) {
>>>>> +			ret = -EINVAL;
>>>>> +			goto out;
>>>>> +		}
>>>>> +
>>>>> +		for_each_svm_dev(sdev, svm, dev) {
>>>>> +			/* In case of multiple sub-devices of the
>>>>> same pdev
>>>>> +			 * assigned, we should allow multiple bind
>>>>> calls with
>>>>> +			 * the same PASID and pdev.
>>>>> +			 */
>>>>> +			sdev->users++;
>>>> What if this is not an mdev device. Is it also allowed?
>>> Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is just an
>>> example of normal use case. You can bind the same PCI device (PF or
>>> SRIOV VF) more than once to the same PASID. Just need to unbind also.
>>
>> I don't get the point of binding a non mdev device several times with
>> the same PASID. Do you intend to allow that at userspace level or
>> prevent this from happening in VFIO?
> 
> I feel it's better to prevent this from happening, otherwise VFIO also
> needs to track the bind count and do multiple unbinds at mm_exit.
> But it's not necessary to prevent it in VFIO. We can check here
> upon whether aux_domain is valid, and if not return -EBUSY.
Ah OK. So if we can detect the case here it is even better

Thanks

Eric
> 
>>
>> Besides, the comment is a bit misleading as it gives the impression it
>> is only true for mdev and there is no associated check.
> 
> Thanks
> Kevin
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
