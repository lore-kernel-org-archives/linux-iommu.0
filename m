Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4460C34026
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944D9206E2
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzlBnvBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944D9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B162854E5;
	Mon, 17 Feb 2020 19:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SPO4loEYT7ya; Mon, 17 Feb 2020 19:51:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 28BB281BDF;
	Mon, 17 Feb 2020 19:51:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1136CC089F;
	Mon, 17 Feb 2020 19:51:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8B81C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A7388856E4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2MZ7+AOw264p for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:51:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD71485207
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581969109;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=B9s0juc3AflESlDHl9D+g0GD+lvMcnZm6qayBkujW4o=;
 b=BzlBnvBOJ4QDT8O9b/8d5ObdleqjlMxXpq055CKFfpsyuRh4clz/gN1gxa8Iw8N7Zy6rww
 mKpHEE5KaRRPeq7DhHUr72X3giWPHpzgoFtrq1/wdwDhGjWn0ZbFX/mC1ue6IBUyloUQBg
 3d/ORljGUI2UftDFMk/7sqLlm4Dsc0Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-PXdIVXdFPnS6cl6-J_d4eQ-1; Mon, 17 Feb 2020 14:51:39 -0500
Received: by mail-qt1-f200.google.com with SMTP id l1so11528661qtp.21
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=B9s0juc3AflESlDHl9D+g0GD+lvMcnZm6qayBkujW4o=;
 b=dHPFDo4RLaaUn8TENz7pIc/+RYO16z0bmyYlrrcVWmCTwo2PqIpJkRR+qETa9s4ax7
 i+BAryCgMcv8Niz+rb9HLF/GKqCxjePRKA6KcOF9lyutSJMQfTRGl5bahxfcDZezOkSX
 rLMBROxqvEmk40VPoE/PISiVx9M61uUqJoFvdEAQ3YU+0K1fW83NDFEccVFbEAMegUab
 SmTVKwXAxvtgRCSCotddnilCvNqz1OZNPQC7m5RE2ixgtFt1PVqGnhUZs4WVrQAMdqOO
 Bdsz7wsnOkvXZ8MCdsL+qaFCfeD1FGrfaKz53EP1/fjGdLaBameUzfdyo3Po/JMYuyHw
 aSgw==
X-Gm-Message-State: APjAAAWF/dpvlFx4xpQEnBBpXEqZDNhmcltTrGiyJKpGKRhM4/PZdGTq
 TCOUYAZulbzv92MxiF4DagIIL5c13c/rApEa6UpcSpUK5qOZnKQtNc5g3FdPymKELSVA2lVLfUX
 6KxW2Lwi8tUiA1iGGNVQp3ysAwGEz9g==
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr14174349qtu.141.1581969099210; 
 Mon, 17 Feb 2020 11:51:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqObS39aCeAmxnIcidfbrehPHzRVkMTV6gjTpXgTb5GckX99ilZ8eP+pSZqDZudFEE4ChYTg==
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr14174335qtu.141.1581969099001; 
 Mon, 17 Feb 2020 11:51:39 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id u13sm676899qtg.64.2020.02.17.11.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:51:37 -0800 (PST)
Date: Mon, 17 Feb 2020 12:51:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200217195136.g7gfamcmtpow35nk@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-4-joro@8bytes.org>
X-MC-Unique: PXdIVXdFPnS6cl6-J_d4eQ-1
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
