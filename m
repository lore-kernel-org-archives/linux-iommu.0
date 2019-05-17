Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79531C04E84
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 07:11:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544CD20868
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 07:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2C465504;
	Fri, 17 May 2019 07:11:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1D894415
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 07:11:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A0914710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 07:11:36 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F899C0624A1;
	Fri, 17 May 2019 07:11:36 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E797B5C241;
	Fri, 17 May 2019 07:11:29 +0000 (UTC)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
	reserved memory regions
To: Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	lorenzo.pieralisi@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, 
	sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-7-eric.auger@redhat.com>
	<ad8a99fa-b98a-14d3-12be-74df0e6eb8f8@arm.com>
	<57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
	<fb9cd4ef-d91e-e526-fc6f-6cee43e70bb7@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e4df1eb4-6fda-33c3-741b-7497855c6362@redhat.com>
Date: Fri, 17 May 2019 09:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fb9cd4ef-d91e-e526-fc6f-6cee43e70bb7@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 17 May 2019 07:11:36 +0000 (UTC)
Cc: alex.williamson@redhat.com
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

Hi Robin,
On 5/16/19 7:53 PM, Robin Murphy wrote:
> On 16/05/2019 14:23, Auger Eric wrote:
>> Hi Robin,
>> On 5/16/19 2:46 PM, Robin Murphy wrote:
>>> On 16/05/2019 11:08, Eric Auger wrote:
>>>> Introduce a new type for reserved region. This corresponds
>>>> to directly mapped regions which are known to be relaxable
>>>> in some specific conditions, such as device assignment use
>>>> case. Well known examples are those used by USB controllers
>>>> providing PS/2 keyboard emulation for pre-boot BIOS and
>>>> early BOOT or RMRRs associated to IGD working in legacy mode.
>>>>
>>>> Since commit c875d2c1b808 ("iommu/vt-d: Exclude devices using RMRRs
>>>> from IOMMU API domains") and commit 18436afdc11a ("iommu/vt-d: Allow
>>>> RMRR on graphics devices too"), those regions are currently
>>>> considered "safe" with respect to device assignment use case
>>>> which requires a non direct mapping at IOMMU physical level
>>>> (RAM GPA -> HPA mapping).
>>>>
>>>> Those RMRRs currently exist and sometimes the device is
>>>> attempting to access it but this has not been considered
>>>> an issue until now.
>>>>
>>>> However at the moment, iommu_get_group_resv_regions() is
>>>> not able to make any difference between directly mapped
>>>> regions: those which must be absolutely enforced and those
>>>> like above ones which are known as relaxable.
>>>>
>>>> This is a blocker for reporting severe conflicts between
>>>> non relaxable RMRRs (like MSI doorbells) and guest GPA space.
>>>>
>>>> With this new reserved region type we will be able to use
>>>> iommu_get_group_resv_regions() to enumerate the IOVA space
>>>> that is usable through the IOMMU API without introducing
>>>> regressions with respect to existing device assignment
>>>> use cases (USB and IGD).
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> Note: At the moment the sysfs ABI is not changed. However I wonder
>>>> whether it wouldn't be preferable to report the direct region as
>>>> "direct_relaxed" there. At the moment, in case the same direct
>>>> region is used by 2 devices, one USB/GFX and another not belonging
>>>> to the previous categories, the direct region will be output twice
>>>> with "direct" type.
>>>
>>> Hmm, that sounds a bit off - if we have overlapping regions within the
>>> same domain, then we need to do some additional pre-processing to adjust
>>> them anyway, since any part of a relaxable region which overlaps a
>>> non-relaxable region cannot actually be relaxed, and so really should
>>> never be described as such.
>> In iommu_insert_resv_region(), we are overlapping regions of the same
>> type. So iommu_get_group_resv_regions() should return both the relaxable
>> region and non relaxable one. I should test this again using a hacked
>> kernel though.
> 
> We should still consider relaxable regions as being able to merge back
> in to regular direct regions to a degree - If a relaxable region falls
> entirely within a direct one then there's no point exposing it because
> the direct region *has* to take precedence and be enforced. If there is
> an incomplete overlap then we could possibly just trust consumers to see
> it and give the direct region precedence themselves, but since the
> relaxable region is our own in-kernel invention rather than firmware
> gospel I think it would be safer to truncate it to just its
> non-overlapping part.

I see your point and I agree. I will implement that.

Thanks

Eric
> 
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
