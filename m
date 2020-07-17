Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7CEC433E0
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 10:29:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29AB2070E
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPnBjgC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29AB2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BB8320406;
	Fri, 17 Jul 2020 10:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6TJJlSCwiwN; Fri, 17 Jul 2020 10:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4A73A203AB;
	Fri, 17 Jul 2020 10:29:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C5BFC0865;
	Fri, 17 Jul 2020 10:29:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 203EBC0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 10:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14E378814F
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 10:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdbRHeg8caAP for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 10:29:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 46EEF87277
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594981740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsLQzqU/DSHbl54CuoL1GP4Qg8GB7o5Im2iyC5P3/Y0=;
 b=LPnBjgC1iZcfzhmDpjD2IU7YI+4eLAa9QKSwl8OhWnm9ofbcT6fzuo2vmN3COR38KfGB57
 cDAcNSAU1fKyhalUGAuujgZfHNdbGxskvMEy1FRjcaAxzz9EHRtdILrp2tJ/1okgdY/EtW
 Cw0SWUeXx3qrJ6rfokskj7hta1PxSyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-8xMqunhAM1yEke4WMmg9cA-1; Fri, 17 Jul 2020 06:28:57 -0400
X-MC-Unique: 8xMqunhAM1yEke4WMmg9cA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D02B380BCAD;
 Fri, 17 Jul 2020 10:28:54 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 851855C1BB;
 Fri, 17 Jul 2020 10:28:44 +0000 (UTC)
Subject: Re: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-4-git-send-email-yi.l.liu@intel.com>
 <20200713131454.GA2739@willie-the-truck>
 <CY4PR11MB1432226D0A52D099249E95A0C3610@CY4PR11MB1432.namprd11.prod.outlook.com>
 <20200716153959.GA447208@myrica>
 <f3779a69-0295-d668-5f2f-746b6ff2bdce@redhat.com>
 <20200717090900.GC4850@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <74ea9416-6bcf-1e71-33f9-b61d7d853be1@redhat.com>
Date: Fri, 17 Jul 2020 12:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717090900.GC4850@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Wu, Hao" <hao.wu@intel.com>,
 Will Deacon <will@kernel.org>, "Tian, Jun J" <jun.j.tian@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 7/17/20 11:09 AM, Jean-Philippe Brucker wrote:
> On Thu, Jul 16, 2020 at 10:38:17PM +0200, Auger Eric wrote:
>> Hi Jean,
>>
>> On 7/16/20 5:39 PM, Jean-Philippe Brucker wrote:
>>> On Tue, Jul 14, 2020 at 10:12:49AM +0000, Liu, Yi L wrote:
>>>>> Have you verified that this doesn't break the existing usage of
>>>>> DOMAIN_ATTR_NESTING in drivers/vfio/vfio_iommu_type1.c?
>>>>
>>>> I didn't have ARM machine on my hand. But I contacted with Jean
>>>> Philippe, he confirmed no compiling issue. I didn't see any code
>>>> getting DOMAIN_ATTR_NESTING attr in current drivers/vfio/vfio_iommu_type1.c.
>>>> What I'm adding is to call iommu_domai_get_attr(, DOMAIN_ATTR_NESTIN)
>>>> and won't fail if the iommu_domai_get_attr() returns 0. This patch
>>>> returns an empty nesting info for DOMAIN_ATTR_NESTIN and return
>>>> value is 0 if no error. So I guess it won't fail nesting for ARM.
>>>
>>> I confirm that this series doesn't break the current support for
>>> VFIO_IOMMU_TYPE1_NESTING with an SMMUv3. That said...
>>>
>>> If the SMMU does not support stage-2 then there is a change in behavior
>>> (untested): after the domain is silently switched to stage-1 by the SMMU
>>> driver, VFIO will now query nesting info and obtain -ENODEV. Instead of
>>> succeding as before, the VFIO ioctl will now fail. I believe that's a fix
>>> rather than a regression, it should have been like this since the
>>> beginning. No known userspace has been using VFIO_IOMMU_TYPE1_NESTING so
>>> far, so I don't think it should be a concern.
>> But as Yi mentioned ealier, in the current vfio code there is no
>> DOMAIN_ATTR_NESTING query yet.
> 
> That's why something that would have succeeded before will now fail:
> Before this series, if user asked for a VFIO_IOMMU_TYPE1_NESTING, it would
> have succeeded even if the SMMU didn't support stage-2, as the driver
> would have silently fallen back on stage-1 mappings (which work exactly
> the same as stage-2-only since there was no nesting supported). After the
> series, we do check for DOMAIN_ATTR_NESTING so if user asks for
> VFIO_IOMMU_TYPE1_NESTING and the SMMU doesn't support stage-2, the ioctl
> fails.
OK I now understand what you meant. Yes this actual change is brought by
the next patch, ie.
[PATCH v5 04/15] vfio/type1: Report iommu nesting info to userspace

Thanks

Eric
> 
> I believe it's a good fix and completely harmless, but wanted to make sure
> no one objects because it's an ABI change.
> 
> Thanks,
> Jean
> 
>> In my SMMUV3 nested stage series, I added
>> such a query in vfio-pci.c to detect if I need to expose a fault region
>> but I already test both the returned value and the output arg. So to me
>> there is no issue with that change.
>>>
>>> And if userspace queries the nesting properties using the new ABI
>>> introduced in this patchset, it will obtain an empty struct. I think
>>> that's acceptable, but it may be better to avoid adding the nesting cap if
>>> @format is 0?
>> agreed
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks,
>>> Jean
>>>
>>>>
>>>> @Eric, how about your opinion? your dual-stage vSMMU support may
>>>> also share the vfio_iommu_type1.c code.
>>>>
>>>> Regards,
>>>> Yi Liu
>>>>
>>>>> Will
>>>
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
