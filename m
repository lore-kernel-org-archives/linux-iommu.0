Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1FBC64E90
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 23:53:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424AA222B8
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 23:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424AA222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B4DF42E215;
	Tue,  1 Dec 2020 23:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kazp9U8saSX; Tue,  1 Dec 2020 23:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E531A20481;
	Tue,  1 Dec 2020 23:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCA9BC163C;
	Tue,  1 Dec 2020 23:53:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D370CC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 23:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BB12786C47
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 23:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id he8jqWzOTzIi for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 23:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 879E686C40
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606866815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTWwMY4ZKYnVUyQmcMgy5Pq772/cdOxveE8A1FOaxjU=;
 b=WoMBZY4MTnb5dk49WYTgy6DGGiAI1DhAxZlyfSIgL5OXTvUDiqZ0+pZsRBw1fbfdaDQhD+
 MOSwcRj7I212ihU5VDWJRmLXtHc5z4Ud8wOmtkaX+fI59IAo1WTsi4b3kAsTHKtfNTg+L3
 OPQrgPqNG/bIOlWEgTJpI/BasdlPtSk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-QM40qZLfMyG54PsRL9wj1g-1; Tue, 01 Dec 2020 18:53:33 -0500
X-MC-Unique: QM40qZLfMyG54PsRL9wj1g-1
Received: by mail-qt1-f199.google.com with SMTP id n95so2540218qte.16
 for <iommu@lists.linux-foundation.org>; Tue, 01 Dec 2020 15:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=kTWwMY4ZKYnVUyQmcMgy5Pq772/cdOxveE8A1FOaxjU=;
 b=WU+5861bUAMRf74ihcOT2RbHY/JLH6rX73dBktnV7XPBhUVDsyufM+FFv487GkIiye
 4qFXo5FQYx+P3J4BUNRw/09W16hN1XHnxj7Wg4U4w7Ed+UKbyC+DHARqGpEUuWxrui6M
 ZgiIro2xiIlbfLPA368divrqXwJUgauwttdnrZ6iKE32NZm5U6R5cfTt0i9shT1mY5eE
 2J40sNbB7iRjaGCHzkdCdkKPzwazyBo2zDCFzTDjshQXrCeCmgypQ6gqksABskPPyBSE
 YN3zP02c9katljzeBW20NC2noqImZDbOYnPMmwR08JB2dBur32elljtMeXU5XVIqByFU
 1h7w==
X-Gm-Message-State: AOAM531t7GkHulwBiMn/rMBKoGEZh0i3PQosSrsAeITworJOOB+Lqvl4
 TDF7NKRFwkTo3pEx9U0kq/vKH5m1MeSywdMwuCB985P1hlOLWyl7AnRoF8q5xsybtUIdF2KaQsw
 w8k354uobUjtx7pqR4Fw+F0wN9Wy2cA==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr5604053qtb.380.1606866813076; 
 Tue, 01 Dec 2020 15:53:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOzxndVYqPQFSh1N3T/G4TW6qTcdOT3oSZXbfEAVOFr6V95caA3iOSHKHcZ/VW/NY87Kq1Rw==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr5604045qtb.380.1606866812869; 
 Tue, 01 Dec 2020 15:53:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id b197sm36856qkg.65.2020.12.01.15.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 15:53:27 -0800 (PST)
References: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Increase interrupt remapping table limit to
 512 entries
In-reply-to: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
Date: Tue, 01 Dec 2020 16:53:25 -0700
Message-ID: <87sg8pkrre.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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


Suravee Suthikulpanit @ 2020-10-14 19:50 MST:

> Certain device drivers allocate IO queues on a per-cpu basis.
> On AMD EPYC platform, which can support up-to 256 cpu threads,
> this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
> and result in the error message:
>
>     AMD-Vi: Failed to allocate IRTE
>
> This has been observed with certain NVME devices.
>
> AMD IOMMU hardware can actually support upto 512 interrupt
> remapping table entries. Therefore, update the driver to
> match the hardware limit.
>
> Please note that this also increases the size of interrupt remapping
> table to 8KB per device when using the 128-bit IRTE format.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 30a5d412255a..427484c45589 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -406,7 +406,11 @@ extern bool amd_iommu_np_cache;
>  /* Only true if all IOMMUs support device IOTLBs */
>  extern bool amd_iommu_iotlb_sup;
>  
> -#define MAX_IRQS_PER_TABLE	256
> +/*
> + * AMD IOMMU hardware only support 512 IRTEs despite
> + * the architectural limitation of 2048 entries.
> + */
> +#define MAX_IRQS_PER_TABLE	512
>  #define IRQ_TABLE_ALIGNMENT	128
>  
>  struct irq_remap_table {

With this change should DTE_IRQ_TABLE_LEN be changed to 9? IIUC the spec
correctly leaving it at 8 is saying the table is 256 entries long.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
