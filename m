Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F85C2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD3F214AF
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBIlpPJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD3F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81D1A87EA9;
	Thu, 16 Apr 2020 15:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCiG8H7-NAjl; Thu, 16 Apr 2020 15:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7CDB87D6A;
	Thu, 16 Apr 2020 15:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7A6FC089E;
	Thu, 16 Apr 2020 15:12:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04955C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 15:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E29E6221FF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 15:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgl3Wx61b+D6 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 15:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 3F034221F8
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587049955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBW9oZnC7o7UHDZIGFKToXwrEuLBhCPll+eChHTjsyQ=;
 b=VBIlpPJpX/W11MPikq92PJdlrlw3qz5fh/CHvuBmgQKNH+OdGv2IRbLWPn92wQMUr8gPe2
 ec7ekA11u5P2DS2l+CN7N3wBnA6VzdZtqOYEK4MCxut74CNu7m2SiOxql3zv3JKnMrt8pM
 27WIoVpBqJferTmT7muQI+P1Dt7Pk94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-4JsCiRBvPDaurYyCFFs7lA-1; Thu, 16 Apr 2020 11:12:34 -0400
X-MC-Unique: 4JsCiRBvPDaurYyCFFs7lA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A89D800D5C;
 Thu, 16 Apr 2020 15:12:32 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4AB7E7D1;
 Thu, 16 Apr 2020 15:12:22 +0000 (UTC)
Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
 <20200403093436.094b1928@w520.home>
 <A2975661238FB949B60364EF0F2C25743A231BAA@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D82336C@SHSMSX104.ccr.corp.intel.com>
 <7d13bdbb-e972-c301-0970-90f63ecf69fc@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D823543@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4f7de577-dee7-91db-bc8c-637558016673@redhat.com>
Date: Thu, 16 Apr 2020 17:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D823543@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Kevin,

On 4/16/20 3:28 PM, Tian, Kevin wrote:
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Thursday, April 16, 2020 8:43 PM
>>
>> Hi Kevin,
>> On 4/16/20 2:09 PM, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Thursday, April 16, 2020 6:40 PM
>>>>
>>>> Hi Alex,
>>>> Still have a direction question with you. Better get agreement with you
>>>> before heading forward.
>>>>
>>>>> From: Alex Williamson <alex.williamson@redhat.com>
>>>>> Sent: Friday, April 3, 2020 11:35 PM
>>>> [...]
>>>>>>>> + *
>>>>>>>> + * returns: 0 on success, -errno on failure.
>>>>>>>> + */
>>>>>>>> +struct vfio_iommu_type1_cache_invalidate {
>>>>>>>> +	__u32   argsz;
>>>>>>>> +	__u32   flags;
>>>>>>>> +	struct	iommu_cache_invalidate_info cache_info;
>>>>>>>> +};
>>>>>>>> +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE,
>>>>> VFIO_BASE
>>>>>>> + 24)
>>>>>>>
>>>>>>> The future extension capabilities of this ioctl worry me, I wonder if
>>>>>>> we should do another data[] with flag defining that data as
>>>> CACHE_INFO.
>>>>>>
>>>>>> Can you elaborate? Does it mean with this way we don't rely on iommu
>>>>>> driver to provide version_to_size conversion and instead we just pass
>>>>>> data[] to iommu driver for further audit?
>>>>>
>>>>> No, my concern is that this ioctl has a single function, strictly tied
>>>>> to the iommu uapi.  If we replace cache_info with data[] then we can
>>>>> define a flag to specify that data[] is struct
>>>>> iommu_cache_invalidate_info, and if we need to, a different flag to
>>>>> identify data[] as something else.  For example if we get stuck
>>>>> expanding cache_info to meet new demands and develop a new uapi to
>>>>> solve that, how would we expand this ioctl to support it rather than
>>>>> also create a new ioctl?  There's also a trade-off in making the ioctl
>>>>> usage more difficult for the user.  I'd still expect the vfio layer to
>>>>> check the flag and interpret data[] as indicated by the flag rather
>>>>> than just passing a blob of opaque data to the iommu layer though.
>>>>> Thanks,
>>>>
>>>> Based on your comments about defining a single ioctl and a unified
>>>> vfio structure (with a @data[] field) for pasid_alloc/free, bind/
>>>> unbind_gpasid, cache_inv. After some offline trying, I think it would
>>>> be good for bind/unbind_gpasid and cache_inv as both of them use the
>>>> iommu uapi definition. While the pasid alloc/free operation doesn't.
>>>> It would be weird to put all of them together. So pasid alloc/free
>>>> may have a separate ioctl. It would look as below. Does this direction
>>>> look good per your opinion?
>>>>
>>>> ioctl #22: VFIO_IOMMU_PASID_REQUEST
>>>> /**
>>>>   * @pasid: used to return the pasid alloc result when flags ==
>> ALLOC_PASID
>>>>   *         specify a pasid to be freed when flags == FREE_PASID
>>>>   * @range: specify the allocation range when flags == ALLOC_PASID
>>>>   */
>>>> struct vfio_iommu_pasid_request {
>>>> 	__u32	argsz;
>>>> #define VFIO_IOMMU_ALLOC_PASID	(1 << 0)
>>>> #define VFIO_IOMMU_FREE_PASID	(1 << 1)
>>>> 	__u32	flags;
>>>> 	__u32	pasid;
>>>> 	struct {
>>>> 		__u32	min;
>>>> 		__u32	max;
>>>> 	} range;
>>>> };
>>>>
>>>> ioctl #23: VFIO_IOMMU_NESTING_OP
>>>> struct vfio_iommu_type1_nesting_op {
>>>> 	__u32	argsz;
>>>> 	__u32	flags;
>>>> 	__u32	op;
>>>> 	__u8	data[];
>>>> };
>>>>
>>>> /* Nesting Ops */
>>>> #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL        0
>>>> #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL      1
>>>> #define VFIO_IOMMU_NESTING_OP_CACHE_INVLD       2
>>>>
>>>
>>> Then why cannot we just put PASID into the header since the
>>> majority of nested usage is associated with a pasid?
>>>
>>> ioctl #23: VFIO_IOMMU_NESTING_OP
>>> struct vfio_iommu_type1_nesting_op {
>>> 	__u32	argsz;
>>> 	__u32	flags;
>>> 	__u32	op;
>>> 	__u32   pasid;
>>> 	__u8	data[];
>>> };
>>>
>>> In case of SMMUv2 which supports nested w/o PASID, this field can
>>> be ignored for that specific case.
>> On my side I would prefer keeping the pasid in the data[]. This is not
>> always used.
>>
>> For instance, in iommu_cache_invalidate_info/iommu_inv_pasid_info we
>> devised flags to tell whether the PASID is used.
>>
> 
> But don't we include a PASID in both invalidate structures already?
The pasid presence is indicated by the IOMMU_INV_ADDR_FLAGS_PASID flag.

For instance for nested stage SMMUv3 I current performs an ARCHID (asid)
based invalidation only.

Eric
> 
> struct iommu_inv_addr_info {
> #define IOMMU_INV_ADDR_FLAGS_PASID      (1 << 0)
> #define IOMMU_INV_ADDR_FLAGS_ARCHID     (1 << 1)
> #define IOMMU_INV_ADDR_FLAGS_LEAF       (1 << 2)
>         __u32   flags;
>         __u32   archid;
>         __u64   pasid;
>         __u64   addr;
>         __u64   granule_size;
>         __u64   nb_granules;
> };
> 
> struct iommu_inv_pasid_info {
> #define IOMMU_INV_PASID_FLAGS_PASID     (1 << 0)
> #define IOMMU_INV_PASID_FLAGS_ARCHID    (1 << 1)
>         __u32   flags;
>         __u32   archid;
>         __u64   pasid;
> };
> 
> then consolidating the pasid field into generic header doesn't
> hurt. the specific handler still rely on flags to tell whether it
> is used?
> 
> Thanks
> Kevin
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
