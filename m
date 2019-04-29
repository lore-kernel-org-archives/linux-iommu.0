Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF373C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 10:03:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B321E20644
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 10:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B321E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59DAF1EEE;
	Mon, 29 Apr 2019 10:03:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A4B561EEA
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 10:01:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5341B608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 10:01:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DBF80D;
	Mon, 29 Apr 2019 03:01:11 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FFC3F5AF;
	Mon, 29 Apr 2019 03:01:09 -0700 (PDT)
Subject: Re: [PATCH v2 11/19] iommu/vt-d: Replace Intel specific PASID
	allocator with IOASID
To: Auger Eric <eric.auger@redhat.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<e542fd95-acbe-05e9-e441-27dff752c21a@redhat.com>
	<20190426140133.6d445315@jacob-builder>
	<f06a9675-278f-51db-f385-e1305b3795d6@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <7529f2ca-167b-5e65-9330-9093638e9f91@arm.com>
Date: Mon, 29 Apr 2019 11:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f06a9675-278f-51db-f385-e1305b3795d6@redhat.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Message-ID: <20190429100051.x4X7ImMjmB4_irOI83fJoQIhARi9oOUGYZFFpBVW8h8@z>

On 27/04/2019 09:38, Auger Eric wrote:
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -5153,7 +5153,7 @@ static void auxiliary_unlink_device(struct
>>>> dmar_domain *domain, domain->auxd_refcnt--;
>>>>  
>>>>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>>>> -		intel_pasid_free_id(domain->default_pasid);
>>>> +		ioasid_free(domain->default_pasid);
>>>>  }
>>>>  
>>>>  static int aux_domain_add_dev(struct dmar_domain *domain,
>>>> @@ -5171,9 +5171,8 @@ static int aux_domain_add_dev(struct
>>>> dmar_domain *domain, if (domain->default_pasid <= 0) {
>>>>  		int pasid;
>>>>  
>>>> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>>>> -
>>>> pci_max_pasids(to_pci_dev(dev)),
>>>> -					     GFP_KERNEL);
>>>> +		pasid = ioasid_alloc(NULL, PASID_MIN,
>>>> pci_max_pasids(to_pci_dev(dev)) - 1,
>>>> +				domain);
>>>>  		if (pasid <= 0) {  
>>> ioasid_t is a uint and returns INVALID_IOASID on error. Wouldn't it be
>>> simpler to make ioasid_alloc return an int?
>> Well, I think we still want the full uint range - 1(INVALID_IOASID).
>> Intel uses 20bit but I think SMMUs use 32 bits for streamID? I
>> should just check 
>> 	if (pasid == INVALID_IOASID) {
> Jean-Philippe may correct me but SMMU uses 20b SubstreamId which is a
> superset of PASIDs. StreamId is 32b.

Right, we use 20 bits for PASIDs (== SubstreamID really). Given the
choices that vendors are making for PASIDs (a global namespace rather
than per-VM), I wouldn't be surprised if they extend the size of PASIDs
in a couple of years, so I added the typedef ioasid_t to ease a possible
change from 32-bit to 64 in the future.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
