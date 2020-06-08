Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A323BC433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 01:54:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9072063A
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9072063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B4E385618;
	Mon,  8 Jun 2020 01:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bSZOh7U12Gf; Mon,  8 Jun 2020 01:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F4A6854CC;
	Mon,  8 Jun 2020 01:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1EFC07FF;
	Mon,  8 Jun 2020 01:54:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF63CC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BB21620005
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyVKR+JVdTKM for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 01:54:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id BDD161FE0A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 01:54:15 +0000 (UTC)
IronPort-SDR: 0FjgxXm0tWKarBxC8rAoRS17C8EtuKKcLNiIBfi3/HSce5OBp415dUYW+GThIjnTlaDXKV4zHx
 dyo8Yc9/4v2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 18:54:15 -0700
IronPort-SDR: kIeNvx4NqtmcJGiRPkJIqcTlzYKbxEFbr3Kc3yvDdp8bwHeYxxv/rQH0fV2w+2O4RdlVqQkr9+
 km9955wTRgcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; d="scan'208";a="295297387"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2020 18:54:12 -0700
Subject: Re: [PATCH V4 2/3] iommu: Take lock before reading iommu group
 default domain type
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <379b0d7307bb76699e2438a21f6c8259a7538ef7.1591290586.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <106b9809-0cb1-77c7-61c0-c870ed6abf16@linux.intel.com>
Date: Mon, 8 Jun 2020 09:50:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <379b0d7307bb76699e2438a21f6c8259a7538ef7.1591290586.git.sai.praneeth.prakhya@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 6/5/20 9:32 AM, Sai Praneeth Prakhya wrote:
> "/sys/kernel/iommu_groups/<grp_id>/type" file could be read to find out the
> default domain type of an iommu group. The default domain of an iommu group
> doesn't change after booting and hence could be read directly. But,
> after addding support to dynamically change iommu group default domain, the
> above assumption no longer stays valid.
> 
> iommu group default domain type could be changed at any time by writing to
> "/sys/kernel/iommu_groups/<grp_id>/type". So, take group mutex before
> reading iommu group default domain type so that the user wouldn't see stale
> values or iommu_group_show_type() doesn't try to derefernce stale pointers.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>   drivers/iommu/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b023f06f12d6..eb133ee5c13a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -501,6 +501,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
>   {
>   	char *type = "unknown\n";
>   
> +	mutex_lock(&group->mutex);
>   	if (group->default_domain) {
>   		switch (group->default_domain->type) {
>   		case IOMMU_DOMAIN_BLOCKED:
> @@ -517,6 +518,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
>   			break;
>   		}
>   	}
> +	mutex_unlock(&group->mutex);
>   	strcpy(buf, type);
>   
>   	return strlen(type);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
