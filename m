Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC589C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E6321D7E
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMxczCo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E6321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5819D86BCC;
	Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JIkWy6aQb5vR; Mon,  9 Mar 2020 14:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D47C186302;
	Mon,  9 Mar 2020 14:11:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5D42C18D3;
	Mon,  9 Mar 2020 14:11:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C0BC0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1EA74257B1
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pDptexlFE03H for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 14:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id BA1182578F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583762506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kk2kJlIHOu992MyJJn0OJdvuyqlGqwctf9WWPynqD5o=;
 b=dMxczCo2XoP52pRhXBO6lFKNYeHY9XwXgjHcHVaUn8GGnVfV+5WpuGnHMFOVp4zSIce0br
 VARShTnHKQSpoLlEklTQaVpj2/4SzfUD4vhW/584obf61L6la4OGqji1bL4MEMO/2yqrY3
 v3KM8dg45N2N5yTMXg2aBRYnYuKVEZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-K9yp9XdXOguFr16teuc86g-1; Mon, 09 Mar 2020 10:01:42 -0400
X-MC-Unique: K9yp9XdXOguFr16teuc86g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EC5DBCF;
 Mon,  9 Mar 2020 14:01:41 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9732619AD;
 Mon,  9 Mar 2020 14:01:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu/vt-d: replace WARN_TAINT with pr_warn + add_taint
Date: Mon,  9 Mar 2020 15:01:36 +0100
Message-Id: <20200309140138.3753-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 09 Mar 2020 14:11:20 +0000
Cc: Hans de Goede <hdegoede@redhat.com>, iommu@lists.linux-foundation.org
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

Hi All,

The iommu/vt-d code calls WARN_TAINT(... TAINT_FIRMWARE_WORKAROUND ...)
in various places. Since the firmware is outside of the kernel's control
this should not be using the WARN_TAINT macro for this, calling the WARN*
macros based on external inputs is wrong, as there is nothing we can do
to fix those external inputs and the WARN* macros are intended for things
which we can fix (also see the patch commit msg).

I'm working on a patch-set which converts all in kernel uses of
WARN_TAINT(... TAINT_FIRMWARE_WORKAROUND ...) to pr_warn + add_taint,
but I'm sending these 2 out separately because these address the 2
most troublesome cases of the vt-d code calling WARN_TAINT() which
together are responsible for over a 100 bugzilla-s in Fedora alone.

Can we please get these 2 patches queued up as fixes for 5.6-rc# ?

Regards,

Hans



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
