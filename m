Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A612BC0650E
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:07:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873082086D
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873082086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 57AE6DB4;
	Tue, 11 Jun 2019 17:07:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4383AD0A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:07:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B70B8174
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:07:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 10:07:44 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga006.jf.intel.com with ESMTP; 11 Jun 2019 10:07:44 -0700
Date: Tue, 11 Jun 2019 10:10:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
Message-ID: <20190611101052.35af46df@jacob-builder>
In-Reply-To: <95292b47-4cf4-5fd9-b096-1cb016e2264f@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-2-jean-philippe.brucker@arm.com>
	<20190611052626.20bed59a@jacob-builder>
	<95292b47-4cf4-5fd9-b096-1cb016e2264f@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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

On Tue, 11 Jun 2019 15:37:42 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 11/06/2019 13:26, Jacob Pan wrote:
> >> +/**
> >> + * ioasid_set_data - Set private data for an allocated ioasid
> >> + * @ioasid: the ID to set data
> >> + * @data:   the private data
> >> + *
> >> + * For IOASID that is already allocated, private data can be set
> >> + * via this API. Future lookup can be done via ioasid_find.
> >> + */
> >> +int ioasid_set_data(ioasid_t ioasid, void *data)
> >> +{
> >> +	struct ioasid_data *ioasid_data;
> >> +	int ret = 0;
> >> +
> >> +	xa_lock(&ioasid_xa);  
> > Just wondering if this is necessary, since xa_load is under
> > rcu_read_lock and we are not changing anything internal to xa. For
> > custom allocator I still need to have the mutex against allocator
> > removal.  
> 
> I think we do need this because of a possible race with ioasid_free():
> 
>          CPU1                      CPU2
>   ioasid_free(ioasid)     ioasid_set_data(ioasid, foo)
>                             data = xa_load(...)
>     xa_erase(...)
>     kfree_rcu(data)           (no RCU lock held)
>     ...free(data)
>                             data->private = foo;
> 
make sense, thanks for explaining.

> The issue is theoretical at the moment because no users do this, but
> I'd be more comfortable taking the xa_lock, which prevents a
> concurrent xa_erase()+free(). (I commented on your v3 but you might
> have missed it)
> 
Did you reply to my v3? I did not see it. I only saw your comments about
v3 in your commit message.

> >> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
> >> +	if (ioasid_data)
> >> +		rcu_assign_pointer(ioasid_data->private, data);  
> > it is good to publish and have barrier here. But I just wonder even
> > for weakly ordered machine, this pointer update is quite far away
> > from its data update.  
> 
> I don't know, it could be right before calling ioasid_set_data():
> 
> 	mydata = kzalloc(sizeof(*mydata));
> 	mydata->ops = &my_ops;			(1)
> 	ioasid_set_data(ioasid, mydata);
> 		... /* no write barrier here */
> 		data->private = mydata;		(2)
> 
> And then another thread calls ioasid_find():
> 
> 	mydata = ioasid_find(ioasid);
> 	if (mydata)
> 		mydata->ops->do_something();
> 
> On a weakly ordered machine, this thread could observe the pointer
> assignment (2) before the ops assignment (1), and dereference NULL.
> Using rcu_assign_pointer() should fix that
> 
I agree it is better to have the barrier. Just thought there is already
a rcu_read_lock() in xa_load() in between. rcu_read_lock() may have
barrier in some case but better not count on it. No issues here. I will
integrate this in the next version.

> Thanks,
> Jean

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
