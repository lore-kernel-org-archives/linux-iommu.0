Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920DC433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 23:57:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF27610E9
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 23:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCF27610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 951FE6078A;
	Tue,  9 Nov 2021 23:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tc0s9bAzWdmK; Tue,  9 Nov 2021 23:57:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C7BE76075D;
	Tue,  9 Nov 2021 23:56:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C16AC0019;
	Tue,  9 Nov 2021 23:56:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77CFEC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 588AB40015
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0uXShvB3gSP for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 23:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 053184015B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 23:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636502215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRV/TegudE4KD97ZYWf0Cw6oVPNjmaXLvDvxNqODgMM=;
 b=GTIOFcFRv3BNE5MXFVENPEV38lmQZSSJl/rvz1Eq6tVPnK6/OwwBQZMhNRQZ9yt2kbE8Go
 LI0CF454quN5or+QsVUvEVvzjxlu0YcUnyYTzePG5nZk5irTi0XrPUM243td3rsL3DZQ+N
 /1bB/lwl60Pp/37aCOuWutbldlmZUCk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-MtrqAaTJOM2EgXj5asMcrg-1; Tue, 09 Nov 2021 18:56:54 -0500
X-MC-Unique: MtrqAaTJOM2EgXj5asMcrg-1
Received: by mail-ot1-f70.google.com with SMTP id
 q9-20020a056830440900b0055ab7135cc4so497338otv.0
 for <iommu@lists.linux-foundation.org>; Tue, 09 Nov 2021 15:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=JRV/TegudE4KD97ZYWf0Cw6oVPNjmaXLvDvxNqODgMM=;
 b=4GI/YDTdMWCHyRVJQ758wkFHxcfDqvVhezapKMY4/cG2ZhPneMvL7eqRYcsn5YyxfL
 uVW2XHnzhoevqZBRyqv8kXCuPP+kj/0hIedwOgt+80A794fR5811iBLEjwUuL+casgnY
 clF1/ysleiLhEQAKxRSrPhdKGV+VZktzBJM9P63cj6sgSgv007AR5rMPgikj3CHStF+i
 51U+uOLZKC0VNXKMXmZdEC2f1nL4M5SIp9AcafZOTBHL0KWm4luIGEWxifcY3TFRF+Ez
 XHRe6mGRR2ZZazXDr7+yQPeHtYUUs+AssIvhaXQpx5lslTtettkFQWH9gcMD2HME6kBy
 xrnw==
X-Gm-Message-State: AOAM531qGRDB5mgVLTfB+zLz0vQh8W3XjObK7WT+hYJ6422sWM6OUmPD
 xGXM7gNk1KtRgRlTU3gWO/3KXwvXruCX9V2mYtWo5gXEHKQPUVFqBVSrhRV4y4ZWs2wRNVfs5kb
 OLtUvgBzcoYphsT+dfWUM8BHZ93CTBg==
X-Received: by 2002:a9d:f61:: with SMTP id 88mr9100563ott.330.1636502214269;
 Tue, 09 Nov 2021 15:56:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYFzqVPai6Jbhhbi6oF8oR/yxb8D8BLMoHNAEJh3W9RZ/ViMcZNtJyQiTUTtc2J2pJOxHxpg==
X-Received: by 2002:a9d:f61:: with SMTP id 88mr9100547ott.330.1636502213993;
 Tue, 09 Nov 2021 15:56:53 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
 by smtp.gmail.com with ESMTPSA id n67sm7941257oib.42.2021.11.09.15.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 15:56:53 -0800 (PST)
Date: Tue, 9 Nov 2021 16:56:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] iommu: intel: do deep dma-unmapping, to avoid
 kernel-flooding.
Message-ID: <20211109165652.19d1b9f8.alex.williamson@redhat.com>
In-Reply-To: <20211012135653.3852-1-ajaygargnsit@gmail.com>
References: <20211012135653.3852-1-ajaygargnsit@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org
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


Hi Baolu,

Have you looked into this?  I'm able to reproduce by starting and
destroying an assigned device VM several times.  It seems like it came
in with Joerg's pull request for the v5.15 merge window.  Bisecting
lands me on 3f34f1259776 where intel-iommu added map/unmap_pages
support, but I'm not convinced that isn't an artifact that the regular
map/unmap calls had been been simplified to only be used for single
pages by that point.  If I mask the map/unmap_pages callbacks and use
map/unmap with (pgsize * size) and restore the previous pgsize_bitmap,
I can generate the same faults.  So maybe the root issue was introduced
somewhere else, or perhaps it is a latent bug in clearing of pte ranges
as Ajay proposes below.  In any case, I think there's a real issue
here.  Thanks,

Alex

On Tue, 12 Oct 2021 19:26:53 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> === Issue ===
> 
> Kernel-flooding is seen, when an x86_64 L1 guest (Ubuntu-21) is booted in qemu/kvm
> on a x86_64 host (Ubuntu-21), with a host-pci-device attached.
> 
> Following kind of logs, along with the stacktraces, cause the flood :
> 
> ......
>  DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
>  DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
> ......
> 
> 
> 
> === Current Behaviour, leading to the issue ===
> 
> Currently, when we do a dma-unmapping, we unmap/unlink the mappings, but
> the pte-entries are not cleared.
> 
> Thus, following sequencing would flood the kernel-logs :
> 
> i)
> A dma-unmapping makes the real/leaf-level pte-slot invalid, but the 
> pte-content itself is not cleared.
> 
> ii)
> Now, during some later dma-mapping procedure, as the pte-slot is about
> to hold a new pte-value, the intel-iommu checks if a prior 
> pte-entry exists in the pte-slot. If it exists, it logs a kernel-error,
> along with a corresponding stacktrace.
> 
> iii)
> Step ii) runs in abundance, and the kernel-logs run insane.
> 
> 
> 
> === Fix ===
> 
> We ensure that as part of a dma-unmapping, each (unmapped) pte-slot
> is also cleared of its value/content (at the leaf-level, where the 
> real mapping from a iova => pfn mapping is stored). 
> 
> This completes a "deep" dma-unmapping.
> 
> 
> 
> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..485a8ea71394 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5090,6 +5090,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>  	gather->freelist = domain_unmap(dmar_domain, start_pfn,
>  					last_pfn, gather->freelist);
>  
> +	dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
> +
>  	if (dmar_domain->max_addr == iova + size)
>  		dmar_domain->max_addr = iova;
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
