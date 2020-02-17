Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C964C34028
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ABB20801
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/UR3vz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ABB20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B588020430;
	Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbDbMmZDvNCE; Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 138B520104;
	Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAD4EC089F;
	Mon, 17 Feb 2020 19:54:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6012AC013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E04586D51
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0j8v9LpX09i for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1302D856E4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581969297;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=k22V0NI2T+CODElUbt4W6m1o0DIF8IGREqO+FIqkD2A=;
 b=c/UR3vz5QF9joQ1vxxV453PF5fV3rm47WIRJz9J5n5XeF4rWnA/LqRsZC9/e+bQoPADG5u
 h3COjvi9xFzYuVsEpdXn4UIz/yQdZ4FXvF8UuQkUauodd4PuWeatyPLLd80hi7nZs+3UVV
 tqT/mTeiwd/PtsndRJNB+4hd2L2DMOk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Ux_a4TAlOqyd8f48fwWR_A-1; Mon, 17 Feb 2020 14:54:52 -0500
Received: by mail-qk1-f198.google.com with SMTP id c206so12510058qkg.6
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=k22V0NI2T+CODElUbt4W6m1o0DIF8IGREqO+FIqkD2A=;
 b=ue8MeR4otr10WqPS5+03zmp7A3DYYM8EWCf/RhgeMOFQsLAeZQ/bc0CO9KAzfSTMG3
 jgkFeZ7tsGT40ygzPnPnbkUMWdL7WigEh6yI1tIP6k8fuPVyrWvG/SxRuQ37D/NgKZb5
 Eroq/2GMxezSaiho1nlanfcPybcC8tAPsnl5w5dRn054SYdI2gOZ4CecG646Yn4ZIFiV
 bVmweg/yv0SIMnEm62HOpduY3wUco51/+1InMgNXjyF166EHi08eWoASY2hwOZ0LhGyE
 yr61AX23NMLmel0UA0GDv1doaXD1yiN2ktDsJySyEdz92xuquap2SlofNwA+JspucYwn
 MFGQ==
X-Gm-Message-State: APjAAAVUpvFkhGpQLSqeE+rV2gcXILdLL1L3aoj0OXPMwTQ2cN2TJtYt
 UUGYHhSvU05sspaCqujprCba1otytsRSofa27UZ9QjSl8YmPtqOyty2iR7dEbw7xbKHixc2nhDe
 pV5VJR41S7cvFgYBRuQveHoepOJBy2A==
X-Received: by 2002:ac8:530c:: with SMTP id t12mr13720558qtn.83.1581969292524; 
 Mon, 17 Feb 2020 11:54:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxz6/8kkWYoZceed2fKmMhPAZIXHW8axo8YLZkRnosQXVJIt3ilwzbKaFZnDXltOQklmiye5A==
X-Received: by 2002:ac8:530c:: with SMTP id t12mr13720547qtn.83.1581969292343; 
 Mon, 17 Feb 2020 11:54:52 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id f7sm678488qtj.92.2020.02.17.11.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:54:51 -0800 (PST)
Date: Mon, 17 Feb 2020 12:54:50 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 5/5] iommu/vt-d: Simplify check in identity_mapping()
Message-ID: <20200217195450.hpk5mtxzbhy5p72a@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-6-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-6-joro@8bytes.org>
X-MC-Unique: Ux_a4TAlOqyd8f48fwWR_A-1
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

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The function only has one call-site and there it is never called with
>dummy or deferred devices. Simplify the check in the function to
>account for that.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
