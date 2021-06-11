Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F87C48BE5
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 12:49:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21034613B8
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 12:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21034613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E18BC404C1;
	Fri, 11 Jun 2021 12:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRSNKKqNw85C; Fri, 11 Jun 2021 12:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E19B4404BA;
	Fri, 11 Jun 2021 12:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0E96C000D;
	Fri, 11 Jun 2021 12:49:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3053C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E18B083D4A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvC8tzVv43fB for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B9A83D12
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:49:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FF5D6E;
 Fri, 11 Jun 2021 05:49:19 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEB23F73D;
 Fri, 11 Jun 2021 05:49:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
To: Will Deacon <will@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
Date: Fri, 11 Jun 2021 13:49:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611104524.GD15274@willie-the-truck>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-06-11 11:45, Will Deacon wrote:
> On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
>> Domain is getting created more than once during asynchronous multiple
>> display heads(devices) probe. All the display heads share same SID and
>> are expected to be in same domain. As iommu_alloc_default_domain() call
>> is not protected, the group->default_domain and group->domain are ending
>> up with different domains and leading to subsequent IOMMU faults.
>> Fix this by protecting iommu_alloc_default_domain() call with group->mutex.
> 
> Can you provide some more information about exactly what the h/w
> configuration is, and the callstack which exhibits the race, please?

It'll be basically the same as the issue reported long ago with PCI 
groups in the absence of ACS not being constructed correctly. Triggering 
the iommu_probe_device() replay in of_iommu_configure() off the back of 
driver probe is way too late and allows calls to happen in the wrong 
order, or indeed race in parallel as here. Fixing that is still on my 
radar, but will not be simple, and will probably go hand-in-hand with 
phasing out the bus ops (for the multiple-driver-coexistence problem).

>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 808ab70..2700500 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
>>   	 * support default domains, so the return value is not yet
>>   	 * checked.
>>   	 */
>> +	mutex_lock(&group->mutex);
>>   	iommu_alloc_default_domain(group, dev);
>> +	mutex_unlock(&group->mutex);
> 
> It feels wrong to serialise this for everybody just to cater for systems
> with aliasing SIDs between devices.

If two or more devices are racing at this point then they're already 
going to be serialised by at least iommu_group_add_device(), so I doubt 
there would be much impact - only the first device through here will 
hold the mutex for any appreciable length of time. Every other path 
which modifies group->domain does so with the mutex held (note the 
"expected" default domain allocation flow in bus_iommu_probe() in 
particular), so not holding it here does seem like a straightforward 
oversight.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
