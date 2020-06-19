Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA5C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 00:53:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB47207FC
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 00:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBI/P+6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB47207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 93B8C88D06;
	Fri, 19 Jun 2020 00:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KXo4rjZ2uYK; Fri, 19 Jun 2020 00:53:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD04188D01;
	Fri, 19 Jun 2020 00:53:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92D5FC07FF;
	Fri, 19 Jun 2020 00:53:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42F3DC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2BA6B89791
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJ+nD680Z9tG for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 00:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 55E468978D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592528030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OzO0DZvXOyrs2UoWemzcvke5bgA0xlYm3qpRtsparnk=;
 b=TBI/P+6P3KO3sM8YAQiKhC61le5W4Z6id5z42aAvGxN+WrHiM8K2eyU+dMUn+ff4H/HwCK
 y6h+WhiKZFtd6CGCvjYFOkz/z8YuzVzoPX4vB2MVLSwpqYQSKDpkMRWRqF8iEM3ozQUe8A
 9C3851v8ha0JZ4Z1G6bPCiSRAYuQ+no=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-PXIMUP8fOR-BaoU7AmYIXg-1; Thu, 18 Jun 2020 20:53:49 -0400
X-MC-Unique: PXIMUP8fOR-BaoU7AmYIXg-1
Received: by mail-qv1-f72.google.com with SMTP id o1so5441070qvq.14
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=OzO0DZvXOyrs2UoWemzcvke5bgA0xlYm3qpRtsparnk=;
 b=H0ZLaKnOsO682OyzvRM3JQ2GN4vF665xnUOLriZkluQ60EoqPxHbQPVmrB+qJZ4W40
 /7OAHlseihhaNBk76FPHcqxI07ur5Yp3kjFGEF2OSUo6IJgHnulmogEqm87nqiQf8iNS
 KvO36+/WV0EfWeY4ZvqvDK53OKb20gzOCHaWvEgXrKzEftn5ivioQZYaQUW0gi8vLazF
 pQZTfIgCTV4hFo/Dhf4zvmkGEMUqP9bJb9jntenDOgc6XcdXHDwEwlW9L8Go1udJax2b
 ixlP0KeCFtVoSK+pGTeAEHK9Gns5URtqfkcyn8B7+p3BRs/BlFM22V4ciG4ocTBHKFVC
 wfMg==
X-Gm-Message-State: AOAM532ciYVK7dVh/4axFNYCiro8nKhuLa3UMQWm5uj8eqV5igNdascM
 O3ZcRLHw6zKzBxYpkimxFABbOXcqsVwBtlM4XXso13VB27f4u0aVUCv64a9RyQ2nj2f2I9PKKEg
 9EMhBdbflwV0OneOGLbdoGJ3/US+62g==
X-Received: by 2002:a37:8fc4:: with SMTP id r187mr866376qkd.101.1592528028647; 
 Thu, 18 Jun 2020 17:53:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiA+6cMQVXFq5FeGfedcN1zN2nB+rxmpe65HllqoVigwROBWuwpKS7U3/P27ciI3EUh+2wXQ==
X-Received: by 2002:a37:8fc4:: with SMTP id r187mr866367qkd.101.1592528028392; 
 Thu, 18 Jun 2020 17:53:48 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id f3sm4364250qta.44.2020.06.18.17.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 17:53:47 -0700 (PDT)
Date: Thu, 18 Jun 2020 17:53:46 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix misuse of iommu_domain_identity_map()
Message-ID: <20200619005346.2myy4lwbquxuch76@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
 linux-kernel@vger.kernel.org
References: <20200618233650.9214-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200618233650.9214-1-baolu.lu@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tom Murphy <murphyt7@tcd.ie>, Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Fri Jun 19 20, Lu Baolu wrote:
>The iommu_domain_identity_map() helper takes start/end PFN as arguments.
>Fix a misuse case where the start and end addresses are passed.
>
>Fixes: e70b081c6f376 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops path")
>Cc: Tom Murphy <murphyt7@tcd.ie>
>Reported-by: Alex Williamson <alex.williamson@redhat.com>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
