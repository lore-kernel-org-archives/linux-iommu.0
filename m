Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3A6C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 11:33:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1A6208CA
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 11:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1A6208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ECDCB1B05;
	Wed, 12 Jun 2019 11:33:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2B1001AFB
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BE3DD79
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:30:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9C428;
	Wed, 12 Jun 2019 04:30:33 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93383F246;
	Wed, 12 Jun 2019 04:32:14 -0700 (PDT)
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-2-jean-philippe.brucker@arm.com>
	<20190611052626.20bed59a@jacob-builder>
	<95292b47-4cf4-5fd9-b096-1cb016e2264f@arm.com>
	<20190611101052.35af46df@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f68f4ccb-1422-4f93-dc9c-2bcdf61c9ed4@arm.com>
Date: Wed, 12 Jun 2019 12:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611101052.35af46df@jacob-builder>
Content-Language: en-US
Cc: Mark Rutland <Mark.Rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
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

On 11/06/2019 18:10, Jacob Pan wrote:
>> The issue is theoretical at the moment because no users do this, but
>> I'd be more comfortable taking the xa_lock, which prevents a
>> concurrent xa_erase()+free(). (I commented on your v3 but you might
>> have missed it)
>>
> Did you reply to my v3? I did not see it. I only saw your comments about
> v3 in your commit message.

My fault, I sneaked the comments in a random reply three levels down the
thread:
https://lore.kernel.org/linux-iommu/836caf0d-699e-33ba-5303-b1c9c949c9ca@arm.com/

(Great, linux-iommu is indexed by lore! I won't have to Cc lkml anymore)

>>>> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
>>>> +	if (ioasid_data)
>>>> +		rcu_assign_pointer(ioasid_data->private, data);  
>>> it is good to publish and have barrier here. But I just wonder even
>>> for weakly ordered machine, this pointer update is quite far away
>>> from its data update.  
>>
>> I don't know, it could be right before calling ioasid_set_data():
>>
>> 	mydata = kzalloc(sizeof(*mydata));
>> 	mydata->ops = &my_ops;			(1)
>> 	ioasid_set_data(ioasid, mydata);
>> 		... /* no write barrier here */
>> 		data->private = mydata;		(2)
>>
>> And then another thread calls ioasid_find():
>>
>> 	mydata = ioasid_find(ioasid);
>> 	if (mydata)
>> 		mydata->ops->do_something();
>>
>> On a weakly ordered machine, this thread could observe the pointer
>> assignment (2) before the ops assignment (1), and dereference NULL.
>> Using rcu_assign_pointer() should fix that
>>
> I agree it is better to have the barrier. Just thought there is already
> a rcu_read_lock() in xa_load() in between. rcu_read_lock() may have
> barrier in some case but better not count on it. 

Yes, and even if rcu_read_lock() provided a barrier I don't think it
would be sufficient, because acquire semantics don't guarantee that
prior writes appear to happen before the barrier, only the other way
round. A lock operation with release semantics, for example
spin_unlock(), should work.

Thanks,
Jean

> No issues here. I will
> integrate this in the next version.
> 
>> Thanks,
>> Jean
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
