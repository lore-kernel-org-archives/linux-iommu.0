Return-Path: <SRS0=HAYh=TN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A3C04AAA
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 17:10:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E68208C2
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 17:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E68208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4776F0F;
	Mon, 13 May 2019 17:10:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54DE7EFF
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 17:10:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2440A27B
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 17:10:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2DEE341;
	Mon, 13 May 2019 10:10:11 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFA893F71E;
	Mon, 13 May 2019 10:10:09 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To: Auger Eric <eric.auger@redhat.com>,
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
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
Date: Mon, 13 May 2019 18:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
Content-Language: en-US
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

On 13/05/2019 17:50, Auger Eric wrote:
>> struct iommu_inv_pasid_info {
>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>> 	__u32	flags;
>> 	__u32	archid;
>> 	__u64	pasid;
>> };
> I agree it does the job now. However it looks a bit strange to do a
> PASID based invalidation in my case - SMMUv3 nested stage - where I
> don't have any PASID involved.
> 
> Couldn't we call it context based invalidation then? A context can be
> tagged by a PASID or/and an ARCHID.

I think calling it "context" would be confusing as well (I shouldn't
have used it earlier), since VT-d uses that name for device table
entries (=STE on Arm SMMU). Maybe "addr_space"?

Thanks,
Jean

> 
> Domain invalidation would invalidate all the contexts belonging to that
> domain.
> 
> Thanks
> 
> Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
