Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF9C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 15:53:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15641207FD
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkK4Ltob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15641207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A318085CDB;
	Tue, 18 Feb 2020 15:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSE8bY5V-sDc; Tue, 18 Feb 2020 15:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3F6285325;
	Tue, 18 Feb 2020 15:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5EFEC08A0;
	Tue, 18 Feb 2020 15:53:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25D90C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E3148452A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id suW2sDoBX6me for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 15:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 42BA784525
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582041205;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q+LvgNaJ530nPcNkzsaYj3wiY+FNtaDd/w1XVB2i/Z8=;
 b=IkK4LtobnORLoiMbbVno1drsyXb6AQFEn6sB4iZWaUUwdBjIzg/jG7Wm5VI8QlXvtOVv81
 BgvYj26vGm76NCQwtBGMbugZFcI/t3+48ytSqf9x5IrKKpQQ89GOJSu8wf+dtowfnExzIh
 WS04i08h9cMkcU6K08BypLwoBCplA48=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-W7P2dftBNLeaJ5WNIG2bmA-1; Tue, 18 Feb 2020 10:53:14 -0500
Received: by mail-qk1-f197.google.com with SMTP id r142so14423753qke.3
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 07:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=Q+LvgNaJ530nPcNkzsaYj3wiY+FNtaDd/w1XVB2i/Z8=;
 b=WsozFni/hIbZII6kHNJ5R5X9sJ6KrMncT6fHIxUOL3cZyEwS/vZdMeuksPy6k/vA3m
 goWYO+CSUMQVdVbdiWJVBKyILfsS9jzUsGEn/9veLkOa4O2DFiRE/pNOgLfSD5LdQSnn
 xvKEa27LrW+0PR9CHQcpVe2+2GJIsagJ2/U4osSVU0obXW7sxhWkK5wBHISuiYLMoky2
 4iU9JzyyXC7REMpTLRN6K8yYOflxitEnzTkWEyAD/9UBTZaZAKJ18+sx7p2FuoWzE8Br
 /fa08HHXP72tqMuIChtQ3RpGkjTOioRVwszGFWPYTHLBZRXz3x+UHyTlL72HjgPopQW/
 f4qw==
X-Gm-Message-State: APjAAAWjBo6QvSo3YQTe2OCt0rKpA/Rmyf0wI/bf4R/PwKTMKmBbbjJm
 N/NNE1dG4fzP61Li1j6SChL+SIU0rTBN/FVFRrEDJBI5GVXiR+rrz7oBnxw11PCasXAPqJIS21t
 mLQFu8ON6iSXv0P+zXF7L39pEyS9g1Q==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr18262805qtl.111.1582041193921; 
 Tue, 18 Feb 2020 07:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxx86PkNdwWLfRNVUu9A9AJPwjH27gBb/xg1DG+ZjwS9PDON2cDdI1BbzPHkVEt5g0bAtA72w==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr18262775qtl.111.1582041193542; 
 Tue, 18 Feb 2020 07:53:13 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id x3sm2037808qts.35.2020.02.18.07.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 07:53:12 -0800 (PST)
Date: Tue, 18 Feb 2020 08:53:11 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/5 v2] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200218155311.kt6fd25odl2gzu2t@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
 <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
 <20200218092827.tp3pq67adzr56k7e@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200218092827.tp3pq67adzr56k7e@8bytes.org>
X-MC-Unique: W7P2dftBNLeaJ5WNIG2bmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue Feb 18 20, Joerg Roedel wrote:
>Hi Baolu,
>
>On Tue, Feb 18, 2020 at 10:38:14AM +0800, Lu Baolu wrote:
>> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> > index 42cdcce1602e..32f43695a22b 100644
>> > --- a/drivers/iommu/intel-iommu.c
>> > +++ b/drivers/iommu/intel-iommu.c
>> > @@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
>> >   static struct dmar_domain *deferred_attach_domain(struct device *dev)
>> >   {
>> > -	if (unlikely(attach_deferred(dev)))
>> > -		do_deferred_attach(dev);
>> > -
>>
>> This should also be moved to the call place of deferred_attach_domain()
>> in bounce_map_single().
>>
>> bounce_map_single() assumes that devices always use DMA domain, so it
>> doesn't call iommu_need_mapping(). We could do_deferred_attach() there
>> manually.
>
>Good point, thanks for your review. Updated patch below.
>
>From 3a5b8a66d288d86ac1fd45092e7d96f842d0cccf Mon Sep 17 00:00:00 2001
>From: Joerg Roedel <jroedel@suse.de>
>Date: Mon, 17 Feb 2020 17:20:59 +0100
>Subject: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
> iommu_need_mapping()
>
>The attachment of deferred devices needs to happen before the check
>whether the device is identity mapped or not. Otherwise the check will
>return wrong results, cause warnings boot failures in kdump kernels, like
>
>	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70
>
>	[...]
>
>	 Call Trace:
>	  __intel_map_single+0x55/0x190
>	  intel_alloc_coherent+0xac/0x110
>	  dmam_alloc_attrs+0x50/0xa0
>	  ahci_port_start+0xfb/0x1f0 [libahci]
>	  ata_host_start.part.39+0x104/0x1e0 [libata]
>
>With the earlier check the kdump boot succeeds and a crashdump is written.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
