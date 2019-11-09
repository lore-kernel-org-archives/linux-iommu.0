Return-Path: <SRS0=RXoQ=ZB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA87C17440
	for <iommu@archiver.kernel.org>; Sat,  9 Nov 2019 00:48:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862D820869
	for <iommu@archiver.kernel.org>; Sat,  9 Nov 2019 00:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3EB88C4E;
	Sat,  9 Nov 2019 00:48:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C46F0B4B
	for <iommu@lists.linux-foundation.org>;
	Sat,  9 Nov 2019 00:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 51E635F4
	for <iommu@lists.linux-foundation.org>;
	Sat,  9 Nov 2019 00:48:06 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Nov 2019 16:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; d="scan'208";a="213338989"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2019 16:48:03 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and
	QI_DEV_EIOTLB_PFSID macros
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org
References: <20191108155803.15051-1-eric.auger@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6c3be6b6-18ac-e0ad-cd41-6f9efe4e02e3@linux.intel.com>
Date: Sat, 9 Nov 2019 08:45:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108155803.15051-1-eric.auger@redhat.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Eric,

On 11/8/19 11:58 PM, Eric Auger wrote:
> For both PASID-based-Device-TLB Invalidate Descriptor and
> Device-TLB Invalidate Descriptor, the Physical Function Source-ID
> value is split according to this layout:
> 
> PFSID[3:0] is set at offset 12 and PFSID[15:4] is put at offset 52.
> Fix the part laid out at offset 52.
> 
> Fixes: 0f725561e1684 ("iommu/vt-d: Add definitions for PFSID")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Please cc this to stable as well.

Cc: stable@vger.kernel.org # v4.19+

Good catch!

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu


> ---
>   include/linux/intel-iommu.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..6d8bf4bdf240 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -336,7 +336,8 @@ enum {
>   #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
>   #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
>   #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> -#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
> +#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
> +				   ((u64)((pfsid >> 4) & 0xfff) << 52))
>   #define QI_DEV_IOTLB_SIZE	1
>   #define QI_DEV_IOTLB_MAX_INVS	32
>   
> @@ -360,7 +361,8 @@ enum {
>   #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
>   #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>   #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> -#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
> +#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
> +				    ((u64)((pfsid >> 4) & 0xfff) << 52))
>   #define QI_DEV_EIOTLB_MAX_INVS	32
>   
>   /* Page group response descriptor QW0 */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
