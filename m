Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3EC4346E
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:56:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9593F20888
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzkDcS3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9593F20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FC61861B2;
	Mon, 21 Sep 2020 18:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33e8n+-jp4BL; Mon, 21 Sep 2020 18:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD03086156;
	Mon, 21 Sep 2020 18:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81BDAC0859;
	Mon, 21 Sep 2020 18:56:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7268CC0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6DD1A87058
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kK1Miod1+cU2 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 18:56:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8781C87057
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600714608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=pWkNANwFp8KVnuJc5tgcb5hxDfStvMJRcSA/c6Kt/yw=;
 b=QzkDcS3khaFcv54pWEHs9DpDTy4H0dyCPDdqLOsjAt6I77R8zcGtwyEPiGt5nTAtMP3Epd
 u49a/8+isfNinRHNN4NoHnT6VjsjHYlBM8WKeufZdjtlgWp7y1E43PwNlPY2A1RLZu3ZMr
 ATM0orOSa0dsu/728XY1ZPoKK6qsoo8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-X8cgJAzzMZqsq8ygntiQBA-1; Mon, 21 Sep 2020 14:56:46 -0400
X-MC-Unique: X8cgJAzzMZqsq8ygntiQBA-1
Received: by mail-pg1-f199.google.com with SMTP id s4so8737757pgk.17
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 11:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:subject:date:message-id
 :mime-version;
 bh=pWkNANwFp8KVnuJc5tgcb5hxDfStvMJRcSA/c6Kt/yw=;
 b=b+57ahvuV+RAKV97A4B5B4JbkneSNOXJ4cULef01PIiQaAx9ihRRr2jOlgzlYz+c+C
 Z36kzG24MT8AVAHVSVXXEkr06tPDX/5tKaUd2jJGqREg3vdTxThrTT7eKJmLQACP++5S
 p93hXEFZotIpkJzElhP8J1L4sSyVQ+lnBTLX6ABnFt+qMCVE01cKa9GXvgVvuMyLSPNZ
 uSkP8fu4alwkw52yCQZs5dgdwh4iJ/zB9qmylgnjusdQOIgwcWCbmj67dfID3XKas7F1
 jNdX4AgrNaTn5Za/jqPxS8i/bIZvtVZ0kaTAWlgiQ6Xi/lnZQ7z59c4H1VCsJy8XrZOi
 14WA==
X-Gm-Message-State: AOAM532OqsNiWABZSZnFzuKfd4h7wihSLJ25YAB+wZcqfHzKTm4ZpQ81
 NmdXeJrpI/AFlYv+eQ583Mm/wZ84uadmiFstrq9EAuk1/2KA6rUfBK7WSGdlcFi3URZPdN0A2De
 xx/2R/JjiaFfFklfiN/qbf9w+cqSmcQ==
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id
 v7-20020aa799c70000b029013ed13da056mr1065265pfi.28.1600714604912; 
 Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGtS9wJP1qEjTL2vZQLuVGFgxGjE7bi7YLAPHtKyeJGP8o7s+XsIA0TtINV5U5VfRwMCqwGw==
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id
 v7-20020aa799c70000b029013ed13da056mr1065245pfi.28.1600714604684; 
 Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id j9sm12285498pfc.175.2020.09.21.11.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg
 Roedel <joro@8bytes.org>, Adrian Huang <adrianhuang0701@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: kdump boot failing with IVRS checksum failure
Date: Mon, 21 Sep 2020 11:56:42 -0700
Message-ID: <87o8lzvtzp.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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


Hello Joerg,

We are seeing a kdump kernel boot failure in test on an HP DL325 Gen10
and it was tracked down to 387caf0b759a ("iommu/amd: Treat per-device
exclusion ranges as r/w unity-mapped regions"). Reproduced on 5.9-rc5
and goes away with revert of the commit. There is a follow on commit
that depends on this that was reverted as well 2ca6b6dc8512 ("iommu/amd:
Remove unused variable"). I'm working on getting system access and want
to see what the IVRS table looks like, but thought I'd give you heads
up.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
