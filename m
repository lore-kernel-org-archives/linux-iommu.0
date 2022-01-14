Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968FC433FE
	for <iommu@archiver.kernel.org>; Fri, 14 Jan 2022 13:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A08A4051D;
	Fri, 14 Jan 2022 13:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6dkarbiobl9v; Fri, 14 Jan 2022 13:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16627402EB;
	Fri, 14 Jan 2022 13:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5426C002F;
	Fri, 14 Jan 2022 13:44:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0B05C001E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 13:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD7BB40500
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 13:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xhbBS6b5X3aT for <iommu@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:44:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 026A3402EB
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642167876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
 b=EoNGWjaU2GFwo1XS2eOlMsTulLpubFLWni/ldxfyuZtnP/7YK8aG9QOo2+bbK7RGxDH5HM
 WxyE6sKLZ0tfiZ1G8VXJu54mveDa0j0AwbUIL1JyPjONCS/viwwgEPVGwKDGs+m7wemLam
 ++rKVt2FPuRuRfgGD733DuLjo286Q0k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-O8ecglIhNxacYFIF7JRdlA-1; Fri, 14 Jan 2022 08:44:35 -0500
X-MC-Unique: O8ecglIhNxacYFIF7JRdlA-1
Received: by mail-ed1-f70.google.com with SMTP id
 v18-20020a056402349200b003f8d3b7ee8dso8367960edc.23
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 05:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
 b=ogdk/WuzMEYyNMKuxVIC7Gmz2ZRFzZE0P6JtnGhgqCDwLSlHJaTw/yMKc6IsxTS3XG
 7FHAPAeCoXE0nV9pJ44yR8FY9LJcSFhSfnnfwF1dy3wzM6/5Op90RXzlwv4UBJCtq9bf
 YndBfisFoI94kSVBFVNe7Zaql3WA1fQ+zUkS9+IhDfKjDyAI6Rh5ysCBnLM2hitIcKUZ
 GTZtDTq/ivue4jKoaz6eIakNJCxWBUQAPELv8xKshs9832wQdkoSY3Yu3tGA/yp3tLuK
 e4CrNjThwJt0BwtmfbAxHBC808QipGuBErg3mBD0je2cg8PnjFJNz1PRNyYnlckJecw4
 LohA==
X-Gm-Message-State: AOAM53358MwNGfq8mszbUB6ZqZsJblHbc0J+k+1AP8/aFDYVJdZ9y6NG
 ATcdY0s8jd/ONj24bIOQkPAwX3cuBrmBAxBR0EOT2QQYDsFAEXa7H3sffm2ORdUdB7iCKCLyBxJ
 Llr0QJRL/kq3VGYUvN3yla6fj7VQr+g==
X-Received: by 2002:a05:6402:1008:: with SMTP id
 c8mr9115182edu.114.1642167874595; 
 Fri, 14 Jan 2022 05:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5OFak9AC/l+A6gU6QqTI2K9zWFX8t7yOZXV50BOSN3qj9pr1cdJHhBXdsT7LCgDNpLjpiDw==
X-Received: by 2002:a05:6402:1008:: with SMTP id
 c8mr9115163edu.114.1642167874354; 
 Fri, 14 Jan 2022 05:44:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702?
 (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de.
 [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
 by smtp.gmail.com with ESMTPSA id 10sm1861145ejy.174.2022.01.14.05.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jan 2022 05:44:33 -0800 (PST)
Message-ID: <60778775-b5f5-0837-092f-9911cec84854@redhat.com>
Date: Fri, 14 Jan 2022 14:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 7/8] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-8-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-8-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> alloc_contig_range() now only needs to be aligned to pageblock_order,
> drop virtio_mem size requirement that it needs to be the max of
> pageblock_order and MAX_ORDER.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  drivers/virtio/virtio_mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index a6a78685cfbe..2664dc16d0f9 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2481,8 +2481,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
>  	 * - Is required for now for alloc_contig_range() to work reliably -
>  	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>  	 */

Please also update this comment.

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
