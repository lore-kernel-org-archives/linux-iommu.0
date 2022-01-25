Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FADC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 06:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBF18813A5;
	Tue, 25 Jan 2022 06:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRdmBdWy2n9R; Tue, 25 Jan 2022 06:23:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB8748135E;
	Tue, 25 Jan 2022 06:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 909E6C0031;
	Tue, 25 Jan 2022 06:23:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22D4FC002F;
 Tue, 25 Jan 2022 06:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10E8560B62;
 Tue, 25 Jan 2022 06:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="zzHOzRVp";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="r5M9bjkV"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMbKTqq_pZ2K; Tue, 25 Jan 2022 06:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4C2D60A9D;
 Tue, 25 Jan 2022 06:23:49 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 064461F380;
 Tue, 25 Jan 2022 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643091827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxB22q2urXIdsrmoPoT22ET5VLL7DY5GwQTRZaWBW4k=;
 b=zzHOzRVpDg59xKWbExTM2/HqgZWsRi4itrBoEkpBmycht04q+RJ8l1Qi1laURT8PHz4Oab
 LHsGRuS21D2Njw5+Rhxv2AEFlyFZnN9TPzzMn/dKmksWvxMze7T/UsO5biJ0hYg+D0/lxJ
 ABZ+HQkBmjrYGLC8E1Rc0wWyiwYzVKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643091827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxB22q2urXIdsrmoPoT22ET5VLL7DY5GwQTRZaWBW4k=;
 b=r5M9bjkVQyRw9A8wG8mbR8CjiorcPAjhdDcb4urtIt5x1C1NZ/0/s0Hv3QDrLBkE6xzwhc
 ZyzLjlvANPU60DCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D81F113D7B;
 Tue, 25 Jan 2022 06:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kQk5NHKX72GxdgAAMHmgww
 (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 06:23:46 +0000
MIME-Version: 1.0
Date: Tue, 25 Jan 2022 07:23:46 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 2/7] mm: page_isolation: move has_unmovable_pages() to
 mm/page_isolation.c
In-Reply-To: <20220119190623.1029355-3-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-3-zi.yan@sent.com>
User-Agent: Roundcube Webmail
Message-ID: <d8809f69b4e813f981a2f13d81849b7b@suse.de>
X-Sender: osalvador@suse.de
Cc: Mel Gorman <mgorman@techsingularity.net>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Eric Ren <renzhengeek@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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

On 2022-01-19 20:06, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
> mm/page_alloc.c and make it static.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
