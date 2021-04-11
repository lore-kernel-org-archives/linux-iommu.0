Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6843DC433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 23:49:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72E7611F0
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 23:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72E7611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956736061A;
	Sun, 11 Apr 2021 23:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nC_qWoP8TOc; Sun, 11 Apr 2021 23:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67EAC60601;
	Sun, 11 Apr 2021 23:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B798C000C;
	Sun, 11 Apr 2021 23:49:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF3EC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34F8E403AF
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-DhhafjRBOJ for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 23:49:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C7B640143
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 23:49:25 +0000 (UTC)
IronPort-SDR: 2LmryDPknkJ5ww8HJ/smhXyclHmWJ8+GKUiheV27+tsGFBFOAPKdFCZIdfPlIU4D0Bh3VwchYp
 eVXDYyEM8p1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="258060219"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; d="scan'208";a="258060219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2021 16:49:24 -0700
IronPort-SDR: bD4D54lCGzxs/O6N1lptfZGUcvuKNR0SFkvzvLX9G5zIazPCN8TreX47efQwJgz4lEpLZHWWAR
 DYVzUrLMwMBw==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; d="scan'208";a="423561225"
Received: from jiezhao-mobl1.ccr.corp.intel.com (HELO [10.254.214.21])
 ([10.254.214.21])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2021 16:49:22 -0700
Subject: Re: [PATCH 5.4 v2 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
References: <20210407184030.21683-1-saeed.mirzamohammadi@oracle.com>
 <deca9431-a52a-2818-4493-5a6ffeadccb9@linux.intel.com>
 <E3377E7A-073F-4D9C-92FE-8CC4836343AF@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <036429a7-9924-7ed5-6be9-2bd087594e9b@linux.intel.com>
Date: Mon, 12 Apr 2021 07:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <E3377E7A-073F-4D9C-92FE-8CC4836343AF@oracle.com>
Content-Language: en-US
Cc: Camille Lu <camille.lu@hpe.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I guess you need to ask Greg KH <gregkh@linuxfoundation.org> with this
Cc-ing to stable@vger.kernel.org.

Best regards,
baolu

On 2021/4/12 3:36, Saeed Mirzamohammadi wrote:
> Hi Lu,
> =

> Thanks for the review. May I know when do we expect this to be applied =

> to 5.4?
> =

> Thanks,
> Saeed
> =

>> On Apr 7, 2021, at 5:25 PM, Lu Baolu <baolu.lu@linux.intel.com =

>> <mailto:baolu.lu@linux.intel.com>> wrote:
>>
>> On 4/8/21 2:40 AM, Saeed Mirzamohammadi wrote:
>>> The IOMMU driver calculates the guest addressability for a DMA request
>>> based on the value of the mgaw reported from the IOMMU. However, this
>>> is a fused value and as mentioned in the spec, the guest width
>>> should be calculated based on the minimum of supported adjusted guest
>>> address width (SAGAW) and MGAW.
>>> This is from specification:
>>> "Guest addressability for a given DMA request is limited to the
>>> minimum of the value reported through this field and the adjusted
>>> guest address width of the corresponding page-table structure.
>>> (Adjusted guest address widths supported by hardware are reported
>>> through the SAGAW field)."
>>> This causes domain initialization to fail and following
>>> errors appear for EHCI PCI driver:
>>> [ =A0=A0=A02.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
>>> [ =A0=A0=A02.486624] ehci-pci 0000:01:00.4: new USB bus registered, =

>>> assigned bus
>>> number 1
>>> [ =A0=A0=A02.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain fai=
led
>>> [ =A0=A0=A02.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-id=
entity
>>> mapping
>>> [ =A0=A0=A02.489359] ehci-pci 0000:01:00.4: can't setup: -12
>>> [ =A0=A0=A02.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
>>> [ =A0=A0=A02.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
>>> [ =A0=A0=A02.490358] ehci-pci: probe of 0000:01:00.4 failed with error =
-12
>>> This issue happens when the value of the sagaw corresponds to a
>>> 48-bit agaw. This fix updates the calculation of the agaw based on
>>> the minimum of IOMMU's sagaw value and MGAW.
>>> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com =

>>> <mailto:saeed.mirzamohammadi@oracle.com>>
>>> Tested-by: Camille Lu <camille.lu@hpe.com <mailto:camille.lu@hpe.com>>
>>> ---
>>> Change in v2:
>>> - Added cap_width to calculate AGAW based on the minimum value of =

>>> MGAW and AGAW.
>>> ---
>>> =A0drivers/iommu/intel-iommu.c | 7 ++++---
>>> =A01 file changed, 4 insertions(+), 3 deletions(-)
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 953d86ca6d2b..a2a03df97704 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -1853,7 +1853,7 @@ static inline int guestwidth_to_adjustwidth(int =

>>> gaw)
>>> =A0static int domain_init(struct dmar_domain *domain, struct =

>>> intel_iommu *iommu,
>>> =A0=A0=A0=A0=A0=A0int guest_width)
>>> =A0{
>>> -int adjust_width, agaw;
>>> +int adjust_width, agaw, cap_width;
>>> unsigned long sagaw;
>>> int err;
>>> =A0@@ -1867,8 +1867,9 @@ static int domain_init(struct dmar_domain =

>>> *domain, struct intel_iommu *iommu,
>>> domain_reserve_special_ranges(domain);
>>> /* calculate AGAW */
>>> -if (guest_width > cap_mgaw(iommu->cap))
>>> -guest_width =3D cap_mgaw(iommu->cap);
>>> +cap_width =3D min_t(int, cap_mgaw(iommu->cap), =

>>> agaw_to_width(iommu->agaw));
>>> +if (guest_width > cap_width)
>>> +guest_width =3D cap_width;
>>> domain->gaw =3D guest_width;
>>> adjust_width =3D guestwidth_to_adjustwidth(guest_width);
>>> agaw =3D width_to_agaw(adjust_width);
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com =

>> <mailto:baolu.lu@linux.intel.com>>
>>
>> Best regards,
>> baolu
> =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
