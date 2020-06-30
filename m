Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B6C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D906A20772
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRScaUvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D906A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8260E87749;
	Tue, 30 Jun 2020 20:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJPllqT7YfH4; Tue, 30 Jun 2020 20:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CD63F876C6;
	Tue, 30 Jun 2020 20:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A15C4C0865;
	Tue, 30 Jun 2020 20:06:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67272C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6165A87733
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id htMdXJEmZjCj for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 20:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 81993876C6
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593547607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5YRZUUFvZuEyDjzkGzSnf3/D+5vRip2ZXUd5lXnW6Ts=;
 b=gRScaUvn8yzubxLnFWM/OjV5gKKnjciF6locUi+BlwxI4dXuI98c36UAFuciifxjc4IUpE
 zsYiNeDURvKOj4x1BgL1n9Vz8RPnXMVt8LzH4OTN+qFwm7Pmooy9sfeB5+ZtHb7Sd4D8Ix
 sM7mxN2/hQK9RvE8AjIzbXuGTWOjdEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-nUvQHNLROGi-O-XdjHPCdg-1; Tue, 30 Jun 2020 16:06:45 -0400
X-MC-Unique: nUvQHNLROGi-O-XdjHPCdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE779879512;
 Tue, 30 Jun 2020 20:06:44 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-115-86.phx2.redhat.com [10.3.115.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A84197BEA0;
 Tue, 30 Jun 2020 20:06:44 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/2] iommu: Move AMD and Intel Kconfig + Makefile bits into
 their directories
Date: Tue, 30 Jun 2020 13:06:34 -0700
Message-Id: <20200630200636.48600-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

This patchset imeplements the suggestion from Linus to move the
Kconfig and Makefile bits for AMD and Intel into their respective
directories.

v2: Rebase against v5.8-rc3. Dropped ---help--- changes from Kconfig as that was
    dealt with in systemwide cleanup.

Jerry Snitselaar (2):
      iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
      iommu/amd: Move Kconfig and Makefile bits down into amd directory


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
