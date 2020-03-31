Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9FC43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 16:19:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFB020786
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acOi2m3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFB020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E2F1D2202C;
	Tue, 31 Mar 2020 16:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybCNywvEW1B6; Tue, 31 Mar 2020 16:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3241E204D7;
	Tue, 31 Mar 2020 16:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A8B9C1AE2;
	Tue, 31 Mar 2020 16:19:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B25C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 20B9788828
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRdHcQgBN+VW for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 16:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 17AF18881A
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585671577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Knl+J+ncq8iy4lpwl7zts4N74U3gDGfq7AsLaAMdSLI=;
 b=acOi2m3ojbSQyy1BXLdQGgFXJX1rQmgqxFE7ZdG12ZKEuFsrgzybBNoheJ9V7boFS6Zcbh
 FHgOCOlnt8jSnBy8DEk7D+DyIyuSOSjxpdfKy9SM7ENh3DKlS00CwocdUy0u2VVVAOanAu
 CaoO2bbPZiioM4hV6UgKI8875r2kwrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-3Dsj50QLPnCv2dedz5fYsw-1; Tue, 31 Mar 2020 12:19:33 -0400
X-MC-Unique: 3Dsj50QLPnCv2dedz5fYsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D60C1137840;
 Tue, 31 Mar 2020 16:19:32 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7DCD5C1A2;
 Tue, 31 Mar 2020 16:19:28 +0000 (UTC)
Subject: Re: [PATCH] iommu/vt-d: Fix PASID cache flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1585610725-78316-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
 <20200331090843.59961e03@jacob-builder>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2e9fc0f5-6181-0a10-db59-67e0ffca14cd@redhat.com>
Date: Tue, 31 Mar 2020 18:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200331090843.59961e03@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 3/31/20 6:08 PM, Jacob Pan wrote:
> Actually, this is not a bug. The current code has:
> #define QI_PC_PASID_SEL             (QI_PC_TYPE | QI_PC_GRAN(1))
> 
> Which already has the type and shift.
> 
> In my vSVA series, I redefined granu such that I can use them in the 2D
> table lookup.
> 
> -#define QI_PC_ALL_PASIDS       (QI_PC_TYPE | QI_PC_GRAN(0))        
> -#define QI_PC_PASID_SEL                (QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */                               
> +#define QI_PC_ALL_PASIDS       0                                   
> +#define QI_PC_PASID_SEL                1                           
> 
> Please ignore this, sorry about the confusion.
OK I missed that as well, sorry. So that's not a fix but the code will
become more readable/consistent in your vSVA series.

Thanks

Eric
> 
> On Tue, 31 Mar 2020 11:28:17 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 3/31/20 1:25 AM, Jacob Pan wrote:
>>> PASID cache type and shift of granularity bits are missing in
>>> the current code.
>>>
>>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table
>>> interface")
>>>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks
>>
>> Eric
>>
>>> ---
>>>  drivers/iommu/intel-pasid.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index 22b30f10b396..57d05b0fbafc
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct
>>> intel_iommu *iommu, {
>>>  	struct qi_desc desc;
>>>  
>>> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
>>> QI_PC_PASID(pasid);
>>> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
>>> +		   QI_PC_PASID(pasid) | QI_PC_TYPE;
>>>  	desc.qw1 = 0;
>>>  	desc.qw2 = 0;
>>>  	desc.qw3 = 0;
>>>   
>>
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
