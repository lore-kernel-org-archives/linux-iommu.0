Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0057DC433F5
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 00:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 965444298F;
	Fri,  7 Jan 2022 00:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rS4Zv5_gsZuJ; Fri,  7 Jan 2022 00:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A91742991;
	Fri,  7 Jan 2022 00:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A873C0030;
	Fri,  7 Jan 2022 00:36:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0744C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D609A40184
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ic0NpmKqPWO for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A54A1400E5
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641515781; x=1673051781;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=EkfKPQpb+SxTuleKwyjV6r0f1bhBPsTCAoGe8AyQC4w=;
 b=D0TCen4FESg0wVQFELmL3mFqto4PjM0A7f2vOtjUcdWZ09PkPPtoAjHl
 yJ8xUjos2fMJmWH7CiRcaIZvVcNorQJQmyvyU0qKwlvJfnlVgXvWqjq/m
 6Z+BlkK4gdao49XJZE7nkGhTiioET2DP+nQ+iJ9V/qSsKezSal8nI3xbY
 rKjymDk2KhlKROoLQ9E47o5AieUGu4m6qv8pV9eZgURJBPgnSdIICUCgp
 QA6WL3EXVJSCgkUxbBNUvyvsCLTz4KTExKjfdIsHVOZtzh5O8hzNFXWqh
 LnFkZIRAfMBTTokUfnQLlSSOO4zN+kSo6b07R6FPwUp4S/5kEBIxK3Yzu Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303517236"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="303517236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 16:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="527184334"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 16:36:14 -0800
Subject: Re: [PATCH v1 6/8] gpu/host1x: Use iommu_attach/detach_device()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-7-baolu.lu@linux.intel.com>
 <20220106153543.GD2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2befad17-05fe-3768-6fbb-67440a5befa3@linux.intel.com>
Date: Fri, 7 Jan 2022 08:35:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106153543.GD2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 1/6/22 11:35 PM, Jason Gunthorpe wrote:
> On Thu, Jan 06, 2022 at 10:20:51AM +0800, Lu Baolu wrote:
>> Ordinary drivers should use iommu_attach/detach_device() for domain
>> attaching and detaching.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   drivers/gpu/host1x/dev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
>> index fbb6447b8659..6e08cb6202cc 100644
>> +++ b/drivers/gpu/host1x/dev.c
>> @@ -265,7 +265,7 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
>>   			goto put_cache;
>>   		}
>>   
>> -		err = iommu_attach_group(host->domain, host->group);
>> +		err = iommu_attach_device(host->domain, host->dev);
>>   		if (err) {
>>   			if (err == -ENODEV)
>>   				err = 0;
>> @@ -335,7 +335,7 @@ static void host1x_iommu_exit(struct host1x *host)
>>   {
>>   	if (host->domain) {
>>   		put_iova_domain(&host->iova);
>> -		iommu_detach_group(host->domain, host->group);
>> +		iommu_detach_device(host->domain, host->dev);
>>   
>>   		iommu_domain_free(host->domain);
>>   		host->domain = NULL;
> 
> Shouldn't this add the flag to tegra_host1x_driver ?

This is called for a single driver. The call trace looks like below:

static struct platform_driver tegra_host1x_driver = {
         .driver = {
                 .name = "tegra-host1x",
                 .of_match_table = host1x_of_match,
         },
         .probe = host1x_probe,
         .remove = host1x_remove,
};

host1x_probe(dev)
->host1x_iommu_init(host)	//host is a wrapper of dev
-->host1x_iommu_attach(host)
---->iommu_group_get(host->dev)
      iommu_domain_alloc(&platform_bus_type)
      iommu_attach_group(domain, group);

It seems that the existing code only works for singleton group.

> 
> And do like we did in the other tegra stuff and switch to the dma api
> when !host1x_wants_iommu() ?
> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
