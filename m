Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485A9C352A2
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A03220658
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOoZAtVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A03220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB12521538;
	Thu,  6 Feb 2020 10:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsH4HrnoEzcs; Thu,  6 Feb 2020 10:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F340E2152E;
	Thu,  6 Feb 2020 10:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA92AC0881;
	Thu,  6 Feb 2020 10:14:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE35C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26F9781B72
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id as6ZX78ZK3KE for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 10:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF0D0816DE
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 10:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580984055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/8jMCgcRBwoorhMZbq6RgVNlEpA0XX7FSkiDIMkNUY=;
 b=aOoZAtVFWgsp7tEclxtV3nCUZ/wBmgniH4oZSeRAVJD2rQu1FmrXX7xgdOZBjBkOgEyE1p
 BMQOi9eOl53Pthlq9lOnRi4OfNwQuZJnos07TN0fdczN1MPYKJaQ/2KykfdEbuTw5PJobj
 /O2q/m3rk2XJEbGS1icEx3bHe2rcRuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-SJTNOm4wPrawFLOgqAvpXw-1; Thu, 06 Feb 2020 05:14:13 -0500
X-MC-Unique: SJTNOm4wPrawFLOgqAvpXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81952108951A;
 Thu,  6 Feb 2020 10:14:11 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A7184DB4;
 Thu,  6 Feb 2020 10:14:02 +0000 (UTC)
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home> <20200129151951.2e354e37@w520.home>
 <20200131155125.53475a72@jacob-builder> <20200203112708.14174ce2@w520.home>
 <20200203124143.05061d1e@jacob-builder> <20200203141236.4e2d7a74@w520.home>
 <20200203144102.643f9684@jacob-builder>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <409b976f-9481-6363-738e-18dae8d32401@redhat.com>
Date: Thu, 6 Feb 2020 11:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203144102.643f9684@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,
On 2/3/20 11:41 PM, Jacob Pan wrote:
> On Mon, 3 Feb 2020 14:12:36 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Mon, 3 Feb 2020 12:41:43 -0800
>> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>>
>>> On Mon, 3 Feb 2020 11:27:08 -0700
>>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>>   
>>>> On Fri, 31 Jan 2020 15:51:25 -0800
>>>> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>>>>     
>>>>> Hi Alex,
>>>>> Sorry I missed this part in the previous reply. Comments below.
>>>>>
>>>>> On Wed, 29 Jan 2020 15:19:51 -0700
>>>>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>>>>       
>>>>>> Also, is the 12-bytes of padding in struct
>>>>>> iommu_gpasid_bind_data excessive with this new versioning
>>>>>> scheme?  Per rule #2 I'm not sure if we're allowed to
>>>>>> repurpose those padding bytes,        
>>>>> We can still use the padding bytes as long as there is a new
>>>>> flag bit to indicate the validity of the new filed within the
>>>>> padding. I should have made it clear in rule #2 when mentioning
>>>>> the flags bits. Should define what extension constitutes.
>>>>> How about this?
>>>>> "
>>>>>  * 2. Data structures are open to extension but closed to
>>>>> modification.
>>>>>  *    Extension should leverage the padding bytes first where a
>>>>> new
>>>>>  *    flag bit is required to indicate the validity of each new
>>>>> member.
>>>>>  *    The above rule for padding bytes also applies to adding
>>>>> new union
>>>>>  *    members.
>>>>>  *    After padding bytes are exhausted, new fields must be
>>>>> added at the
>>>>>  *    end of each data structure with 64bit alignment. Flag bits
>>>>> can be
>>>>>  *    added without size change but existing ones cannot be
>>>>> altered. *
>>>>> "
>>>>> So if we add new field by doing re-purpose of padding bytes,
>>>>> size lookup result will remain the same. New code would
>>>>> recognize the new flag, old code stays the same.
>>>>>
>>>>> VFIO layer checks for UAPI compatibility and size to copy,
>>>>> version sanity check and flag usage are done in the IOMMU code.
>>>>>       
>>>>>> but if we add
>>>>>> fields to the end of the structure as the scheme suggests,
>>>>>> we're stuck with not being able to expand the union for new
>>>>>> fields.        
>>>>> Good point, it does sound contradictory. I hope the rewritten
>>>>> rule #2 address that.
>>>>> Adding data after the union should be extremely rare. Do you
>>>>> see any issues with the example below?
>>>>>  
>>>>>  offsetofend() can still find the right size.
>>>>> e.g.
>>>>> V1
>>>>> struct iommu_gpasid_bind_data {
>>>>> 	__u32 version;
>>>>> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>>>>> 	__u32 format;
>>>>> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID
>>>>> valid */ __u64 flags;
>>>>> 	__u64 gpgd;
>>>>> 	__u64 hpasid;
>>>>> 	__u64 gpasid;
>>>>> 	__u32 addr_width;
>>>>> 	__u8  padding[12];
>>>>> 	/* Vendor specific data */
>>>>> 	union {
>>>>> 		struct iommu_gpasid_bind_data_vtd vtd;
>>>>> 	};
>>>>> };
>>>>>
>>>>> const static int
>>>>> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] =
>>>>> { /* IOMMU_UAPI_BIND_GPASID */ {offsetofend(struct
>>>>> iommu_gpasid_bind_data, vtd)}, ...
>>>>> };
>>>>>
>>>>> V2, Add new_member at the end (forget padding for now).
>>>>> struct iommu_gpasid_bind_data {
>>>>> 	__u32 version;
>>>>> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>>>>> 	__u32 format;
>>>>> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID
>>>>> valid */ #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new
>>>>> member added */ __u64 flags;
>>>>> 	__u64 gpgd;
>>>>> 	__u64 hpasid;
>>>>> 	__u64 gpasid;
>>>>> 	__u32 addr_width;
>>>>> 	__u8  padding[12];
>>>>> 	/* Vendor specific data */
>>>>> 	union {
>>>>> 		struct iommu_gpasid_bind_data_vtd vtd;
>>>>> 	};
>>>>> 	__u64 new_member;
>>>>> };
>>>>> const static int
>>>>> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] =
>>>>> { /* IOMMU_UAPI_BIND_GPASID */ 
>>>>> 	{offsetofend(struct iommu_gpasid_bind_data,
>>>>> 	vtd), offsetofend(struct
>>>>> iommu_gpasid_bind_data,new_member)},
>>>>>
>>>>> };
>>>>>
>>>>> V3, Add smmu to the union,larger than vtd
>>>>>
>>>>> struct iommu_gpasid_bind_data {
>>>>> 	__u32 version;
>>>>> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>>>>> #define IOMMU_PASID_FORMAT_INTEL_SMMU	2
>>>>> 	__u32 format;
>>>>> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID
>>>>> valid */ #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new
>>>>> member added */ #define IOMMU_SVA_SMMU_SUPP	(1 << 2) /*
>>>>> SMMU data supported */ __u64 flags;
>>>>> 	__u64 gpgd;
>>>>> 	__u64 hpasid;
>>>>> 	__u64 gpasid;
>>>>> 	__u32 addr_width;
>>>>> 	__u8  padding[12];
>>>>> 	/* Vendor specific data */
>>>>> 	union {
>>>>> 		struct iommu_gpasid_bind_data_vtd vtd;
>>>>> 		struct iommu_gpasid_bind_data_smmu smmu;
>>>>> 	};
>>>>> 	__u64 new_member;
>>>>> };
>>>>> const static int
>>>>> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
>>>>> 	/* IOMMU_UAPI_BIND_GPASID */
>>>>> 	{offsetofend(struct iommu_gpasid_bind_data,vtd),
>>>>> 	offsetofend(struct iommu_gpasid_bind_data, new_member),
>>>>> 	offsetofend(struct iommu_gpasid_bind_data, new_member)},
>>>>> ...
>>>>> };
>>>>>       
>>>>
>>>> How are you not breaking rule #3, "Versions are backward
>>>> compatible" with this?  If the kernel is at version 3 and
>>>> userspace is at version 2 then new_member exists at different
>>>> offsets of the structure.  The kernels iommu_uapi_data_size for
>>>> V2 changed between version 2 and 3. Thanks,
>>>>     
>>> You are right. if we want to add new member to the end of the
>>> structure as well as expanding union, I think we have to fix the
>>> size of the union. Would this work? (just an example for one struct)
>>>
>>>
>>> @@ -344,6 +348,11 @@ struct iommu_gpasid_bind_data_vtd {
>>>   * @gpasid:    Process address space ID used for the guest mm in
>>> guest IOMMU
>>>   * @addr_width:        Guest virtual address width
>>>   * @padding:   Reserved for future use (should be zero)
>>> + * @dummy      Reserve space for vendor specific data in the
>>> union. New
>>> + *             members added to the union cannot exceed the size of
>>> dummy.
>>> + *             The fixed size union is needed to allow further
>>> expansion
>>> + *             after the end of the union while still maintain
>>> backward
>>> + *             compatibility.
>>>   * @vtd:       Intel VT-d specific data
>>>   *
>>>   * Guest to host PASID mapping can be an identity or non-identity,
>>> where guest @@ -365,6 +374,7 @@ struct iommu_gpasid_bind_data {
>>>         __u8  padding[12];
>>>         /* Vendor specific data */
>>>         union {
>>> +               __u8 dummy[128];
>>>                 struct iommu_gpasid_bind_data_vtd vtd;
>>>         };
>>>  };  
>>
>> It's not the most space efficient thing and we're just guessing at
>> what might need to be added into that union in future, but it
>> works... until it doesn't ;)  One might also argue that we could
>> inflate the padding field even further to serve the same purpose.
> That was our initial intention, the padding field is already inflated
> to accommodate any foreseeable extensions :)
> 
> Extensions beyond union was deemed unlikely that is why we use the
> union at the end.
> 
> The intention of this patchset is not to change that, but rather
> clarify and simplify the version checking.
> 
>> The only other route I can think of would be to let the user specify
>> the offset of the variable size data from the start of the structure,
>> for example similar to how we're laying out vfio migration region or
>> how we do capabilities in vfio ioctls.  This is where passing an
>> argsz for each ioctl comes in handy so we're not limited to a
>> structure, we can link various structures together in a chain.  Of
>> course that requires work on both the user and kernel side to pack
>> and unpack, but it leaves a lot of flexibility in extending it.
>> Thanks,
>>
> Yeah, that would work as well. I just feel IOMMU UAPI is unlikely to get
> updated frequently, should be much less than adding new capabilities.
> I think argsz could be viewed as the version field set by the
> user, minsz is what kernel current code supports.
> 
> So let me summarize the options we have
> 1. Disallow adding new members to each structure other than reuse
> padding bits or adding union members at the end.
> 2. Allow extension of the structures beyond union, but union size has
> to be fixed with reserved spaces
> 3. Adopt VFIO argsz scheme, I don't think we need version for each
> struct anymore. argsz implies the version that user is using assuming
> UAPI data is extension only.
> 
> Jean, Eric, any comments? My preference is #1. In the apocalyptic event
> when we run out of padding, perhaps we can introduce a new API_v2 :)
I had #1 in mind too.

Thanks

Eric
> 
>> Alex
>>
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
