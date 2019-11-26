Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B63C432C0
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:19:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07A72073F
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qtw5bJoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A72073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BE38221BB;
	Tue, 26 Nov 2019 17:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y07NNoVGf48D; Tue, 26 Nov 2019 17:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 22CC7220E5;
	Tue, 26 Nov 2019 17:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03B4AC0881;
	Tue, 26 Nov 2019 17:19:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCFCBC0878
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A4B0E86BDE
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVwLDybNNukv for <iommu@lists.linux-foundation.org>;
 Tue, 26 Nov 2019 17:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A69A786123
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574788751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZMwHV3KrQEfrY5tMKLf1OtDElvXlEV64ghBrb4GlKA=;
 b=Qtw5bJoa7mNi6tNlsC33QZCHYYtTZISPPKOI5NlPxpD3Rq6vtvauTVq2/iPNhPMSejSdDW
 9KbQYvszC3L+Oi4MCeAgF3zllaElK6GsJ3lLkcfwBtGxykSk8JOvBB+Xq4y5QgayMJgANR
 Te3+xburyNgwYm8olhiuDfMiEdSH+Ns=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-NI5fleuKPnKnyrAWA3c2qw-1; Tue, 26 Nov 2019 12:19:07 -0500
Received: by mail-pl1-f200.google.com with SMTP id p23so8156245plo.14
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=5wVzpglEIAjYehdG9sWNgS3uaz+PIjpeWL9/GEH0Tp4=;
 b=A15tAb5BBTz9e6r5xc7zn/5gs1GNdK5GF0xYTlJeJPBhKmmwzhDSfwXGwaC+Y8ayZw
 geySZqelSFs58IT0dhrY/hpBKoMN/JLZ8R5bqmAEBdLg6Nc2x9JRlF42gVl5geI51TDW
 +uKjMVoMZaHsG52n6BMKETuKBr4WPWL9LB9LGj1Ed5kSAXZdaSKapbIoMRLL2lM3hkaE
 G4rhozpRcWi079FF5skSp6gRdUy1a5xRan/+hB/0iX6s45GV/DGsjXMg5oA8k4+8HPGH
 pHWlg+h3fGsecSIokdF9CShDxtwaUZEhpgCc1xsMA+wpUNuTgo3b/N0aWHzMzxQxZtCq
 1Ceg==
X-Gm-Message-State: APjAAAWT8AQj+f3mp6verMV0Dz6ISAhHjfzd4YRE8OXMtO0uI+wdyxkz
 y+Z/FXKlj3ekivgzs6qR6rF33mbVJ4zcjHUtNCl6vmRYn77jxnOsXHoyoGv1/mc/gzprDW2qITy
 EElaZ2PRNsOLv5caD3GKd1Q2pMJ4ZgQ==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr42634015pfr.23.1574788746766; 
 Tue, 26 Nov 2019 09:19:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCm+jc/Xy/HZ1W4zmlXRfEuhPmaS7/3b4qGmZ2g5RVMrlhJaArpPToSqjkaru3MdpMy2wxVw==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr42633987pfr.23.1574788746524; 
 Tue, 26 Nov 2019 09:19:06 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id g30sm12879606pgm.23.2019.11.26.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 09:19:05 -0800 (PST)
Date: Tue, 26 Nov 2019 10:19:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
Message-ID: <20191126171904.tnd27x3mjhdo4dy7@cantor>
Mail-Followup-To: Eric Auger <eric.auger@redhat.com>,
 eric.auger.pro@gmail.com, joro@8bytes.org, hch@lst.de, cai@lca.pw,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20191126102743.3269-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126102743.3269-1-eric.auger@redhat.com>
X-MC-Unique: NI5fleuKPnKnyrAWA3c2qw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de,
 eric.auger.pro@gmail.com
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

On Tue Nov 26 19, Eric Auger wrote:
>In case the new region gets merged into another one, the nr
>list node is freed. Checking its type while completing the
>merge algorithm leads to a use-after-free. Use new->type
>instead.
>
>Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
>implementation")
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>Reported-by: Qian Cai <cai@lca.pw>
>Cc: Stable <stable@vger.kernel.org> #v5.3+
>

Minor nit, but should the comment above list_for_each_entry_safe get
updated as well? Other than that, lgtm.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
>
>v2 -> v3:
>- directly use new->type
>
>v1 -> v2:
>- remove spurious new line
>---
> drivers/iommu/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index d658c7c6a2ab..285ad4a4c7f2 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
> 		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
>
> 		/* no merge needed on elements of different types than @nr */
>-		if (iter->type != nr->type) {
>+		if (iter->type != new->type) {
> 			list_move_tail(&iter->list, &stack);
> 			continue;
> 		}
>-- 
>2.20.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
