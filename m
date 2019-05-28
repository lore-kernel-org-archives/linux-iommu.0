Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68CC04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 11:52:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617F120717
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 11:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617F120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D03561C50;
	Tue, 28 May 2019 11:52:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C43441BAD
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 11:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C4CC581A
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 11:51:21 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37A12C072269;
	Tue, 28 May 2019 11:51:21 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 402E65D6A9;
	Tue, 28 May 2019 11:51:14 +0000 (UTC)
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Duplicate iommu_resv_region objects
	per device list
To: Joerg Roedel <joro@8bytes.org>
References: <20190527085541.5294-1-eric.auger@redhat.com>
	<20190527085541.5294-4-eric.auger@redhat.com>
	<20190527152303.GD12745@8bytes.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <26e14927-0ec5-2472-54a2-4498a2145c19@redhat.com>
Date: Tue, 28 May 2019 13:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190527152303.GD12745@8bytes.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 28 May 2019 11:51:21 +0000 (UTC)
Cc: alex.williamson@redhat.com, dwmw2@infradead.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com, eric.auger.pro@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg,

On 5/27/19 5:23 PM, Joerg Roedel wrote:
> On Mon, May 27, 2019 at 10:55:36AM +0200, Eric Auger wrote:
>> -			list_add_tail(&rmrr->resv->list, head);
>> +			length = rmrr->end_address - rmrr->base_address + 1;
>> +			resv = iommu_alloc_resv_region(rmrr->base_address,
>> +						       length, prot,
>> +						       IOMMU_RESV_DIRECT,
>> +						       GFP_ATOMIC);
>> +			if (!resv)
>> +				break;
>> +
>> +			list_add_tail(&resv->list, head);
> 
> Okay, so this happens in a rcu_read_locked section and must be atomic,
> but I don't like this extra parameter to iommu_alloc_resv_region().
> 
> How about replacing the rcu-lock with the dmar_global_lock, which
> protects against changes to the global rmrr list? This will make this
> loop preemptible and taking the global lock is okay because this
> function is in no way performance relevant.

After studying in more details the for_each_active_dev_scope macro and
rcu_dereference_check it looks OK to me. I respinned accordingly.

Thanks

Eric
> 
> Regards,
> 
> 	Joerg
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
