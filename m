Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0467C43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 06:59:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7810D2085A
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 06:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7810D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C0AD2FB8;
	Thu,  2 May 2019 06:59:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DF2392F9A
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 06:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 66C2C711
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 06:58:39 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D8BE30820E6;
	Thu,  2 May 2019 06:58:38 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72CF91001E61;
	Thu,  2 May 2019 06:58:31 +0000 (UTC)
Subject: Re: [PATCH v7 05/23] iommu: Introduce cache_invalidate API
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu, joro@8bytes.org, alex.williamson@redhat.com, 
	jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, will.deacon@arm.com, 
	robin.murphy@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-6-eric.auger@redhat.com>
	<a9745aef-8686-c761-e3d0-dd0e98a1f5b2@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e5d2fdd6-4ce1-863e-5198-0b05d727a5b6@redhat.com>
Date: Thu, 2 May 2019 08:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a9745aef-8686-c761-e3d0-dd0e98a1f5b2@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 02 May 2019 06:58:38 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190502065829._etESdsNbjtQuQT8gEGOHB8bhIy-hr9JjhbbZPPfkhI@z>

Hi Jean-Philippe,

On 5/1/19 12:38 PM, Jean-Philippe Brucker wrote:
> On 08/04/2019 13:18, Eric Auger wrote:
>> +int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
>> +			   struct iommu_cache_invalidate_info *inv_info)
>> +{
>> +	int ret = 0;
>> +
>> +	if (unlikely(!domain->ops->cache_invalidate))
>> +		return -ENODEV;
>> +
>> +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
>> +
>> +	return ret;
> 
> Nit: you don't really need ret
> 
> The UAPI looks good to me, so
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Just to make sure, do you accept changes proposed by Jacob in
https://lkml.org/lkml/2019/4/29/659 ie.
- the addition of NR_IOMMU_INVAL_GRANU in enum iommu_inv_granularity and
- the addition of NR_IOMMU_CACHE_TYPE

Thanks

Eric
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
