Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBFC5DF60
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A41421924
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR4k56dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A41421924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8240DC64;
	Fri,  8 Nov 2019 16:18:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3DE5AC7
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:18:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
	[205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 58162EC
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1573229909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=fEUGEbDEfPr/owp9u8Xo/PbGoTk1t896oZ4K9wNCr+I=;
	b=HR4k56dRzLLbrYjOsB6wZYB4gKXwTmeC/FjB+QVD8EaUZ4JHEgKMillFGjv9sBix1ZuYgb
	sb2Q1zitFJ49GmIWXYO+AOeJAIPwv9NW2B5BVzHVwt4EZ8hszTMOWmdT4R+AHGi+uTJ7E5
	GFznosUDYzmO+I85XaF9c6o+lOqy5VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
	[209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-354-lZCKI3h0Pv2OQ-r-J7Nqeg-1; Fri, 08 Nov 2019 11:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFF0B1800D7B;
	Fri,  8 Nov 2019 16:18:23 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F695DA7F;
	Fri,  8 Nov 2019 16:18:11 +0000 (UTC)
Subject: Re: [PATCH v7 10/11] iommu/vt-d: Support flushing more translation
	cache types
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <467e60cc-efb1-83d4-2dea-f6131a60428b@redhat.com>
Date: Fri, 8 Nov 2019 17:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lZCKI3h0Pv2OQ-r-J7Nqeg-1
X-Mimecast-Spam-Score: 0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,

On 10/24/19 9:55 PM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, scalable
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.c |  3 ++-
>  include/linux/intel-iommu.h | 21 +++++++++++++++++----
>  3 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 49bb7d76e646..0ce2d32ff99e 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1346,6 +1346,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> +/* PASID-based IOTLB Invalidate */
> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
> +		unsigned int size_order, u64 granu, int ih)
> +{
> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> +	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
> +		QI_EIOTLB_AM(size_order);
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask)
>  {
> @@ -1369,6 +1383,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> +/* PASID-based device IOTLB Invalidate */
> +void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +		u32 pasid,  u16 qdep, u64 addr, unsigned size_order, u64 granu)
> +{
> +	struct qi_desc desc;
> +
> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> +		QI_DEV_IOTLB_PFSID(pfsid);
> +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> +
> +	/* If S bit is 0, we only flush a single page. If S bit is set,
> +	 * The least significant zero bit indicates the invalidation address
> +	 * range. VT-d spec 6.5.2.6.
> +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
> +	 */
> +	if (!size_order) {
> +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
this is desc.qw1

With that fixed and the qi_flush_dev_piotlb init issue spotted by Lu,
feel free to add my

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> +	} else {
> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order);
> +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
> +	}
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
> +{
> +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_TYPE;
> +	qi_submit_sync(&desc, iommu);
> +}
>  /*
>   * Disable Queued Invalidation interface.
>   */
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index f846a907cfcf..6d7a701ef4d3 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -491,7 +491,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  {
>  	struct qi_desc desc;
>  
> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +		QI_PC_PASID(pasid) | QI_PC_TYPE;
>  	desc.qw1 = 0;
>  	desc.qw2 = 0;
>  	desc.qw3 = 0;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6c74c71b1ebf..a25fb3a0ea5b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -332,7 +332,7 @@ enum {
>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
>  #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
>  #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
> -#define QI_IOTLB_AM(am)		(((u8)am))
> +#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
>  
>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> @@ -350,16 +350,21 @@ enum {
>  #define QI_PC_DID(did)		(((u64)did) << 16)
>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>  
> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS	0
> +#define QI_PC_PASID_SEL		1
>  
>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> -#define QI_EIOTLB_AM(am)	(((u64)am))
> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>  
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL		1
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> +
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> @@ -655,8 +660,16 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
>  			     u8 fm, u64 type);
>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  			  unsigned int size_order, u64 type);
> +extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> +			u32 pasid, unsigned int size_order, u64 type, int ih);
>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask);
> +
> +extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u32 pasid, u16 qdep, u64 addr, unsigned size_order, u64 granu);
> +
> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
> +
>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>  
>  extern int dmar_ir_support(void);
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
