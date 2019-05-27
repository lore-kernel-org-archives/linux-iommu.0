Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83AC04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 15:24:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79122183F
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 15:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79122183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 627E619F5;
	Mon, 27 May 2019 15:24:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B40318D7
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 15:23:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 103B1821
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 15:23:07 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 75B98244; Mon, 27 May 2019 17:23:05 +0200 (CEST)
Date: Mon, 27 May 2019 17:23:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Duplicate iommu_resv_region objects
	per device list
Message-ID: <20190527152303.GD12745@8bytes.org>
References: <20190527085541.5294-1-eric.auger@redhat.com>
	<20190527085541.5294-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190527085541.5294-4-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alex.williamson@redhat.com, dwmw2@infradead.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com, eric.auger.pro@gmail.com
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

On Mon, May 27, 2019 at 10:55:36AM +0200, Eric Auger wrote:
> -			list_add_tail(&rmrr->resv->list, head);
> +			length = rmrr->end_address - rmrr->base_address + 1;
> +			resv = iommu_alloc_resv_region(rmrr->base_address,
> +						       length, prot,
> +						       IOMMU_RESV_DIRECT,
> +						       GFP_ATOMIC);
> +			if (!resv)
> +				break;
> +
> +			list_add_tail(&resv->list, head);

Okay, so this happens in a rcu_read_locked section and must be atomic,
but I don't like this extra parameter to iommu_alloc_resv_region().

How about replacing the rcu-lock with the dmar_global_lock, which
protects against changes to the global rmrr list? This will make this
loop preemptible and taking the global lock is okay because this
function is in no way performance relevant.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
