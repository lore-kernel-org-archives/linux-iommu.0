Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A86C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 07:46:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8A22086A
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 07:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8A22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D9BCD67;
	Tue, 14 May 2019 07:46:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 29F37C21
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 07:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D636A27B
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 07:46:44 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 704FCBCD24;
	Tue, 14 May 2019 07:46:43 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0791001947;
	Tue, 14 May 2019 07:46:36 +0000 (UTC)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
	<44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
	<7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
	<1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1edd45e6-4da3-e393-36b2-9e63cd5f7607@redhat.com>
Date: Tue, 14 May 2019 09:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 14 May 2019 07:46:43 +0000 (UTC)
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raj Ashok <ashok.raj@intel.com>
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

Hi Jean,

On 5/13/19 7:09 PM, Jean-Philippe Brucker wrote:
> On 13/05/2019 17:50, Auger Eric wrote:
>>> struct iommu_inv_pasid_info {
>>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>>> 	__u32	flags;
>>> 	__u32	archid;
>>> 	__u64	pasid;
>>> };
>> I agree it does the job now. However it looks a bit strange to do a
>> PASID based invalidation in my case - SMMUv3 nested stage - where I
>> don't have any PASID involved.
>>
>> Couldn't we call it context based invalidation then? A context can be
>> tagged by a PASID or/and an ARCHID.
> 
> I think calling it "context" would be confusing as well (I shouldn't
> have used it earlier), since VT-d uses that name for device table
> entries (=STE on Arm SMMU). Maybe "addr_space"?
yes you're right. Well we already pasid table table terminology so we
can use it here as well - as long as we understand what purpose it
serves ;-) - So OK for iommu_inv_pasid_info.

I think Jean understood we would keep pasid standalone field in
iommu_cache_invalidate_info's union. I understand the struct
iommu_inv_pasid_info now would replace it, correct?

Thanks

Eric
> 
> Thanks,
> Jean
> 
>>
>> Domain invalidation would invalidate all the contexts belonging to that
>> domain.
>>
>> Thanks
>>
>> Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
