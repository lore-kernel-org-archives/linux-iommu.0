Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C0C35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:32:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1991321744
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWIIwc1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1991321744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4E0D8766C;
	Tue, 25 Feb 2020 08:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFH1Kvj6V0ae; Tue, 25 Feb 2020 08:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D204E854D1;
	Tue, 25 Feb 2020 08:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFFBFC089F;
	Tue, 25 Feb 2020 08:32:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B212C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3951B203A0
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8c50y8vbJ+7 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 08:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 4DF5C2036D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582619551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgKQtRV01Bi8I2OWDhHoJzlNxr2o35DwN7ZNxHQ2pcE=;
 b=EWIIwc1rwxjLMWLXVRxtPQGUg5qm4mQrvv26p0iJwfgqcUr5oNgpcYpmpbclA0TvKAcvyk
 qPj5blpuFmU13LvcUqkox9jLKRI+cdpjl3z3+ekm/aFl1ai1HdowsYe1wAsuT9oka4cZgo
 Kv/MQSboxwACkgDgnWQS2gORv9orVXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-aLC00U-3MtC6YXxGwaGXZA-1; Tue, 25 Feb 2020 03:32:23 -0500
X-MC-Unique: aLC00U-3MtC6YXxGwaGXZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08BB107ACC7;
 Tue, 25 Feb 2020 08:32:21 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 448B660BF7;
 Tue, 25 Feb 2020 08:32:16 +0000 (UTC)
Subject: Re: [PATCH V9 05/10] iommu/vt-d: Support flushing more translation
 cache types
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
 <20200214152701.18f76ce1@jacob-builder>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5e7841c4-28df-7a4a-e801-f42b62de1e3d@redhat.com>
Date: Tue, 25 Feb 2020 09:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200214152701.18f76ce1@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
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

On 2/15/20 12:27 AM, Jacob Pan wrote:
> Hi Eric,
> 
> On Wed, 12 Feb 2020 13:55:25 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 1/29/20 7:01 AM, Jacob Pan wrote:
>>> When Shared Virtual Memory is exposed to a guest via vIOMMU,
>>> scalable IOTLB invalidation may be passed down from outside IOMMU
>>> subsystems. This patch adds invalidation functions that can be used
>>> for additional translation cache types.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/dmar.c        | 33 +++++++++++++++++++++++++++++++++
>>>  drivers/iommu/intel-pasid.c |  3 ++-
>>>  include/linux/intel-iommu.h | 20 ++++++++++++++++----
>>>  3 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>>> index 071bb42bbbc5..206733ec8140 100644
>>> --- a/drivers/iommu/dmar.c
>>> +++ b/drivers/iommu/dmar.c
>>> @@ -1411,6 +1411,39 @@ void qi_flush_piotlb(struct intel_iommu
>>> *iommu, u16 did, u32 pasid, u64 addr, qi_submit_sync(&desc, iommu);
>>>  }
>>>  
>>> +/* PASID-based device IOTLB Invalidate */
>>> +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
>>> u16 pfsid,
>>> +		u32 pasid,  u16 qdep, u64 addr, unsigned
>>> size_order, u64 granu) +{
>>> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
>>> +
>>> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
>>> QI_DEV_EIOTLB_SID(sid) |
>>> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>>> +		QI_DEV_IOTLB_PFSID(pfsid);
>>> +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
>>> +
>>> +	/* If S bit is 0, we only flush a single page. If S bit is
>>> set,
>>> +	 * The least significant zero bit indicates the
>>> invalidation address
>>> +	 * range. VT-d spec 6.5.2.6.
>>> +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates
>>> 16KB.
>>> +	 */
>>> +	if (!size_order) {
>>> +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) &
>>> ~QI_DEV_EIOTLB_SIZE;
>>> +	} else {
>>> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT +
>>> size_order);
>>> +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) |
>>> QI_DEV_EIOTLB_SIZE;
>>> +	}
>>> +	qi_submit_sync(&desc, iommu);  
>> I made some comments in
>> https://lkml.org/lkml/2019/8/14/1311
>> that do not seem to have been taken into account. Or do I miss
>> something?
>>
> I missed adding these changes. At the time Baolu was doing cache flush
> consolidation so I wasn't sure if I could use his code completely. This
> patch is on top of his consolidated flush code with what is still
> needed for vSVA. Then I forgot to address your comments. Sorry about
> that.
no problem
> 
>> More generally having an individual history log would be useful and
>> speed up the review.
>>
> Will add history to each patch, e.g. like this?
> ---
> v8 -> v9
yes thanks. You're not obliged to list every little thing but to me, it
helps to see at first sight if you took into account major comments and
in case you did not - on purpose -, you can also indicate it.

Thanks

Eric
> ---
>> Thanks
>>
>> Eric
>>> +}
>>> +
>>> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
>>> granu, int pasid) +{
>>> +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
>>> +
>>> +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
>>> QI_PC_GRAN(granu) | QI_PC_TYPE;
>>> +	qi_submit_sync(&desc, iommu);
>>> +}
>>> +
>>>  /*
>>>   * Disable Queued Invalidation interface.
>>>   */
>>> diff --git a/drivers/iommu/intel-pasid.c
>>> b/drivers/iommu/intel-pasid.c index bd067af4d20b..b100f51407f9
>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct
>>> intel_iommu *iommu, {
>>>  	struct qi_desc desc;
>>>  
>>> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
>>> QI_PC_PASID(pasid);
>>> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
>>> +		QI_PC_PASID(pasid) | QI_PC_TYPE;
>>>  	desc.qw1 = 0;
>>>  	desc.qw2 = 0;
>>>  	desc.qw3 = 0;
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index b0ffecbc0dfc..dd9fa61689bc
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -332,7 +332,7 @@ enum {
>>>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
>>> (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
>>> (((u64)addr) & VTD_PAGE_MASK) #define
>>> QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
>>> QI_IOTLB_AM(am)		(((u8)am)) +#define
>>> QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
>>>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
>>>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
>>> @@ -351,16 +351,21 @@ enum {
>>>  #define QI_PC_DID(did)		(((u64)did) << 16)
>>>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>>>  
>>> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
>>> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
>>> +/* PASID cache invalidation granu */
>>> +#define QI_PC_ALL_PASIDS	0
>>> +#define QI_PC_PASID_SEL		1
>>>  
>>>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>>>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
>>> -#define QI_EIOTLB_AM(am)	(((u64)am))
>>> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>>>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>>>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>>>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>>>  
>>> +/* QI Dev-IOTLB inv granu */
>>> +#define QI_DEV_IOTLB_GRAN_ALL		1
>>> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
>>> +
>>>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>>>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>>>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
>>> @@ -660,8 +665,15 @@ extern void qi_flush_iotlb(struct intel_iommu
>>> *iommu, u16 did, u64 addr, unsigned int size_order, u64 type);
>>>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid,
>>> u16 pfsid, u16 qdep, u64 addr, unsigned mask);
>>> +
>>>  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32
>>> pasid, u64 addr, unsigned long npages, bool ih);
>>> +
>>> +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
>>> u16 sid, u16 pfsid,
>>> +			u32 pasid, u16 qdep, u64 addr, unsigned
>>> size_order, u64 granu); +
>>> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
>>> did, u64 granu, int pasid); +
>>>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu
>>> *iommu); 
>>>  extern int dmar_ir_support(void);
>>>   
>>
> 
> [Jacob Pan]
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
