Return-Path: <SRS0=MlyH=OW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4220C433EF
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 13:15:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CE361B21
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 13:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29CE361B21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E517342615;
	Sat,  2 Oct 2021 13:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKa6lVISMLmV; Sat,  2 Oct 2021 13:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8366341609;
	Sat,  2 Oct 2021 13:15:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 586D8C0011;
	Sat,  2 Oct 2021 13:15:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3C2CC000D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 13:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E52642615
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 13:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ezIzmk9z4T8Y for <iommu@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 13:14:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8407741609
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 13:14:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248263422"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; d="scan'208";a="248263422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2021 06:14:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; d="scan'208";a="619966367"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.7])
 ([10.254.214.7])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2021 06:14:51 -0700
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
To: Ajay Garg <ajaygargnsit@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
Date: Sat, 2 Oct 2021 21:14:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211002124012.18186-1-ajaygargnsit@gmail.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021/10/2 20:40, Ajay Garg wrote:
> Taking a SD-MMC controller (over PCI) as an example, following is an
> example sequencing, where the log-flooding happened :
> 
> 0.
> We have a host and a guest, both running latest x86_64 kernels.
> 
> 1.
> Host-machine is booted up (with intel_iommu=on), and the DMA-PTEs
> are setup for the controller (on the host), for the first time.
> 
> 2.
> The SD-controller device is added to a (L1) guest on a KVM-VM
> (via virt-manager).

Isn't the domain should be switched from a default domain to an
unmanaged domain when the device is assigned to the guest?

Even you want to r-setup the same mappings, you need to un-map all
existing mappings, right?

Best regards,
baolu

> 
> 3.
> The KVM-VM is booted up.
> 
> 4.
> Above triggers a re-setup of DMA-PTEs on the host, for a
> second time.
> 
> It is observed that the new PTEs formed (on the host) are same
> as the original PTEs, and thus following logs, accompanied by
> stacktraces, overwhelm the logs :
> 
> ......
>   DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
>   DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
>   DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
>   DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
>   DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
> ......
> 
> As the PTEs are same, so there is no cause of concern, and we can easily
> avoid the logs-flood for this non-error case.
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..8bea8b4e3ff9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2370,7 +2370,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   		 * touches the iova range
>   		 */
>   		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
> -		if (tmp) {
> +		if (tmp && (tmp != pteval)) {
>   			static int dumps = 5;
>   			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
>   				iov_pfn, tmp, (unsigned long long)pteval);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
