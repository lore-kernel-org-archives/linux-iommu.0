Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A874C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 09:28:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB762339D
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 09:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB762339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A3D38769E;
	Mon,  7 Dec 2020 09:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cWW3AVHx8HW; Mon,  7 Dec 2020 09:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7796087004;
	Mon,  7 Dec 2020 09:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE64C0893;
	Mon,  7 Dec 2020 09:28:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04733C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D83CB20447
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OzQCvpfv0I5H for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 09:28:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B79182033E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607333305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qrnWwjmFtSVqE1nCYYjX2OgHJMarljryfL3WzdzuOk=;
 b=A3Hr3G6bX2XKuMr3dn2PQTbShdWeI5tDXYHJlYVX+/Qc42wr+0cn66+DbPm9eHw4kNI/jY
 HZSwGwc3LVf2kuqOGqVoLN3Oy6nyMaqWlU7W31lxy3RI/epspVJtAxs15qZVDcoVzswrF7
 KNA8DmjOdDJb4kmenL3h3Yv6kufFGBQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Mpu1YICDN0yb9us6QlPuCg-1; Mon, 07 Dec 2020 04:28:23 -0500
X-MC-Unique: Mpu1YICDN0yb9us6QlPuCg-1
Received: by mail-io1-f72.google.com with SMTP id j10so11443348iog.22
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 01:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=6qrnWwjmFtSVqE1nCYYjX2OgHJMarljryfL3WzdzuOk=;
 b=gx+JmQ1IGZmhdMwC5/74GUKnQvhuqBnXk0qvXyyhlntgiH6ul7a2kU2nxc387wIgJy
 XWUyu92x1qXCJ1f/0kAxE/h+B/+PTCwQ4echj04K60FBK8nMtq5FQMGHLb645+O9s1ZW
 r2zzE7I0EthckjQ5jPJsAB3D+unXMf5PG2qao+aNs9XzNn35Z809MVn0hrDHUmvFjcVJ
 QylEsTsZGsLnRMxoftlSjh0Ebp4byjIlh0am7av8n2B8t+D62Xekw1KTD6QuDoPtU5Mu
 luqMFfwaRZEW4yXcBPlqFsJG1juE2uKaP5y+TV4pjpRgFBrgbgJvbOO2w6QfngAT0hSX
 aISA==
X-Gm-Message-State: AOAM532ZF65r+Aq4hKdBQRD5Y5ZMJvTzs8cEgIzEjb4EwDj2lksjddIb
 iJ+YujSDslrBCUWrFzfLhwAKcVLVf1xaV5xWUh4TSYh/l+7BfWcsX87zbDAbh+cbPmTTlGaSaC2
 kmty1m5aheDWs2IzRmWq2aUaFDq/eBA==
X-Received: by 2002:a6b:7801:: with SMTP id j1mr14958162iom.17.1607333303184; 
 Mon, 07 Dec 2020 01:28:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDeY2O6DXZTuNKUmmjnn6q642QkKRkKnpp1/z+FVrKsgGZ3hLKlszE4AUMS1UPcFkAU7/nAg==
X-Received: by 2002:a6b:7801:: with SMTP id j1mr14958152iom.17.1607333302821; 
 Mon, 07 Dec 2020 01:28:22 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id t1sm6996674ile.1.2020.12.07.01.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 01:28:22 -0800 (PST)
References: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs
In-reply-to: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
Date: Mon, 07 Dec 2020 02:28:20 -0700
Message-ID: <87eek2rmmj.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brijesh.singh@amd.com, Jon.Grimm@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
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


Suravee Suthikulpanit @ 2020-12-07 02:19 MST:

> According to the AMD IOMMU spec, the commit 73db2fc595f3
> ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
> also requires the interrupt table length (IntTabLen) to be set to 9
> (power of 2) in the device table mapping entry (DTE).
>
> Fixes: 73db2fc595f3 ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 89647700bab2..494b42a31b7a 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -257,7 +257,7 @@
>  #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
>  #define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
>  #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> +#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>  #define DTE_IRQ_REMAP_ENABLE    1ULL
>  
>  #define PAGE_MODE_NONE    0x00

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
