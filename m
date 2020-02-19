Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB9C7619D
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 23:55:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C11206A5
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei3vKDzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C11206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16EEC877DB;
	Wed, 19 Feb 2020 23:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4gftskC48Ul; Wed, 19 Feb 2020 23:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 79D6985EC1;
	Wed, 19 Feb 2020 23:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C035C1D81;
	Wed, 19 Feb 2020 23:55:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE2D6C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 965B120781
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d-lXF8WHkiXK for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 23:55:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id BD20120502
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582156521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=gVZETO5ToPW9ORza98Ii24fKRNVEYxysJCTkt8Xpckw=;
 b=Ei3vKDzRLMehLGiO7JJUoEJWFVhwfYnmfVQ57XE0oPqFYrVtD2tD/n7npYmnAmN9FCQJ8c
 TLQkvYrNDZ8TJHEo63yXHHtUlJPUje63C2i/brVZ7PiWoDMKCEla2WW4GUfd3iR7HUKPTU
 ibz7yeQAOfDCpDwpTTkQtZ8yiC4hP2Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-qGMmkkmCO4avKoOpRs8LtA-1; Wed, 19 Feb 2020 18:55:19 -0500
X-MC-Unique: qGMmkkmCO4avKoOpRs8LtA-1
Received: by mail-qk1-f199.google.com with SMTP id 123so36765qkm.15
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 15:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:mime-version:content-disposition;
 bh=gVZETO5ToPW9ORza98Ii24fKRNVEYxysJCTkt8Xpckw=;
 b=dgnZsHPBcuMQNvjEZ4k/l5ck2vqPiPGP+okQ4BnwOjRqAI3aXtqFH9HjdNAUiVXWC4
 D5sBpxmTjHT8FsY78w7sI+GnzB9ui1zZSQZa+AtCs+QvPyNmtV9VPGnxWr8ZZeqV1MWL
 mTJtibozud2isUY3aerr48BbAp/a7qpO+iaq34kovz3yPSHyiI/zNuwgHe0aUgUzBMHy
 +NWqV0ssU4AGiVCh7zQDtNL/5O+nL5Ae4zhWFQgT/D0elT6glAxKGSTcrURS7CN50Zel
 apUsUy3Y/Ihs2Fat+ZpA0NGjAPPsWqwSOZCxf1SrJPaTnAPskOjhZvNjPdcQmZkT/0Is
 8/RA==
X-Gm-Message-State: APjAAAVx+oufuVHuB7jtcwBSUc9/c9laQxTj82oWiY8ycA6djz7Q3+S9
 mFtIFMiBD1mGUqIrxbVNoa09PA8g43o2AuA3LpMs6OieuMokUyzIIutazhQDUD9YdOm5ttvF3m1
 wvn7BslJScFGQ5ZKcV/ZiKxTxiONtSA==
X-Received: by 2002:ac8:7773:: with SMTP id h19mr24151850qtu.144.1582156518736; 
 Wed, 19 Feb 2020 15:55:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLk9mkKQYUXT76ax9fqf+CkQQ7t28OAi5KYr4prqEib7SPchhm8V2sj9zWJCebg67zNz8Iwg==
X-Received: by 2002:ac8:7773:: with SMTP id h19mr24151842qtu.144.1582156518440; 
 Wed, 19 Feb 2020 15:55:18 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id z6sm849662qto.86.2020.02.19.15.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 15:55:17 -0800 (PST)
Date: Wed, 19 Feb 2020 16:55:16 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: question about iommu_need_mapping
Message-ID: <20200219235516.zl44y7ydgqqja6x5@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

Is it possible for a device to end up with dev->archdata.iommu == NULL
on iommu_need_mapping in the following instance:

1. iommu_group has dma domain for default
2. device gets private identity domain in intel_iommu_add_device
3. iommu_need_mapping gets called with that device.
4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via unlink_domain_info.
5. request_default_domain_for_dev exits after checking that group->default_domain
    exists, and group->default_domain->type is dma.
6. iommu_request_dma_domain_for_dev returns 0 from request_default_domain_for_dev
    and a private dma domain isn't created for the device.

The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
Allow devices with RMRRs to use identity domain"), because it changed
which domain the group and devices were using, but it seems like it is
still a possibility with the code. Baolu, you mentioned possibly
removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
32bit device with identity default domain") makes it sound like the
domain switch is required.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
