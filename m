Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A285FC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2027164F6A
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2027164F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC37187274;
	Thu,  4 Feb 2021 19:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPf2GIieL7mt; Thu,  4 Feb 2021 19:31:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F9ED8725C;
	Thu,  4 Feb 2021 19:31:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E10C1D9F;
	Thu,  4 Feb 2021 19:30:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D6B1C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B36D8723E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wE6YqpqjrSl for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:30:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DB5F87262
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=W3wFYsuZo6rSbhnnadXYaNkhzPsYyX2m1sRxVxahG9U=; b=E++kGEeqIJz3+hZ9yh5cr8M1pj
 q0Nvqj9CTHQMMIXKAfqyT/fwW297FPCO9iOdB8E929HxMmrKkx46nrw+R1eq9JVlNkVyTy+8WwmaP
 SysBghteURvf7WHb/szvMvRm4ncmdXTYobo0eHAxjeQTaUHYD5v072Fo/IMEbzjdwQaSV2QyaHz11
 bQ3NINsMd/NiN1z3ukhhZXJjJU4FpMjiTpD+QBGG7AjzPbU++ZfK9Jjjo9EI4IRgcgiapjoU1PDa+
 moXldjbQLlU6ys0Pdcl6s5/0c+qo1G3/SBdyf8dCxdRjxzO+bqoYPe80NYadKJzGCTo4Od8qYVsPq
 HxTe/VoQ==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kKt-001Jh1-33; Thu, 04 Feb 2021 19:30:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: preserve DMA offsets when using swiotlb 
Date: Thu,  4 Feb 2021 20:30:27 +0100
Message-Id: <20210204193035.2606838-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Hi all,

this series make NVMe happy when running with swiotlb.  This caters
towards to completely broken NVMe controllers that ignore the
specification (hello to the biggest cloud provider on the planet!),
to crappy SOC that have addressing limitations, or "secure"
virtualization that force bounce buffering to enhance the user
experience.  Or in other words, no one sane should hit it, but
people do.

It is basically a respin of the

    "SWIOTLB: Preserve swiotlb map offset when needed."

series from Jianxiong Gao.  It complete rewrites the swiotlb part so that
the offset really is preserved and not just the offset into the swiotlb
slot, and to do so it grew half a dozen patches to refactor the swiotlb
so that a mere mortal like me could actually understand it.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
