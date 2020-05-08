Return-Path: <SRS0=3/wr=6X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B52C28CBC
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 17:55:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3D120820
	for <iommu@archiver.kernel.org>; Sat,  9 May 2020 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aO/VaZcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3D120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 26F1D88615;
	Sat,  9 May 2020 17:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9MsD+cNqVTMN; Sat,  9 May 2020 17:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 80D1D885BB;
	Sat,  9 May 2020 17:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68A6AC0889;
	Sat,  9 May 2020 17:55:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1F2FC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E8C58746D
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qy5f2X6ZBtMZ for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 22:54:29 +0000 (UTC)
X-Greylist: delayed 00:05:55 by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D81AE86CC7
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:54:29 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id s10so3426322iog.7
 for <iommu@lists.linux-foundation.org>; Fri, 08 May 2020 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fWdsJ1NGPr7oPwWFvlUBsi6Qw8i1lzhg04lZd6bc6aM=;
 b=aO/VaZcOYz/Kc0PeZol3BrIcDYWRjNYcEV4HH9TIWi6NIRkGQqrao0rXYf8DXlMYkw
 5iUYwq5F6iIKqthHa2WlsWQuNt/bv9OwTt/j5Hv8LdBA5qs2/EE2VFRkvHp4Xpocerqt
 TLcefjFE87OQVuugLNM8vOr+L+WRXnbBFHnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fWdsJ1NGPr7oPwWFvlUBsi6Qw8i1lzhg04lZd6bc6aM=;
 b=RRCmuv+44EeeaApnqir/tZQh8GWH1Ichh5omDsx4JqmnV9nzThWvAjrw8GCdqVbj9Z
 qmhFstlgbbjTn7OkZ5EkgJ3wiKW+rke92pVNNjvSQJEFcY4y5j/kOxnvMWf6fPO4Zy0a
 0u3rlRCVf71XBJKDcfAdkBRdXYnXoWMHOIMvx8e7HNO9CRJ2BYzltH49T7w7tZGGCbzY
 Vf07O0zzPQkm8oJ4W1u7cAvWvjinhbaYmOfmM44k6H8J1f6KEMWsmJsnSloUgXJOPLNq
 yZ18N9ujZmLUr6jjvJEUWvEl+6ntcKaexoK7QiHDz8DF4qleELtHgksR5ABRHUdbs3BO
 hU3Q==
X-Gm-Message-State: AGi0Pubx+WwAy5UPE1ZBuKLqNWRnCE7N9gffluWrIksNXl4uZR51MSrX
 BAuO6hRSbOs7ZMw+YHFhKyLN2YUQ0jXPaA==
X-Google-Smtp-Source: APiQypI25iFqqbLfAR8A9ESKFC1ynWatFmSQmQsfDFNfZoDnC88RujwSFozsdqmou1Wfrnm/FyVC7g==
X-Received: by 2002:a5d:8591:: with SMTP id f17mr3040492ioj.26.1588978113517; 
 Fri, 08 May 2020 15:48:33 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com
 (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
 by smtp.gmail.com with ESMTPSA id 17sm431818ill.14.2020.05.08.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 15:48:33 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: Joerg Roedel <jroedel@suse.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix get_acpihid_device_id
Date: Fri,  8 May 2020 16:48:30 -0600
Message-Id: <20200508164819.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 09 May 2020 17:55:46 +0000
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dianders@chromium.org,
 evgreen@chromium.org, Adrian Hunter <adrian.hunter@intel.com>,
 Raul E Rangel <rrangel@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
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

acpi_dev_hid_uid_match expects a null pointer for UID if it doesn't
exist. The acpihid_map_entry contains a char buffer for holding the
UID. If no UID was provided in the IVRS table, this buffer will be
zeroed. If we pass in a null string, acpi_dev_hid_uid_match will return
false because it will try and match an empty string to the ACPI UID of
the device.

Fixes: ae5e6c6439c3 ("iommu/amd: Switch to use acpi_dev_hid_uid_match()")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..06f603366cb1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -125,7 +125,8 @@ static inline int get_acpihid_device_id(struct device *dev,
 		return -ENODEV;
 
 	list_for_each_entry(p, &acpihid_map, list) {
-		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid,
+					   p->uid[0] ? p->uid : NULL)) {
 			if (entry)
 				*entry = p;
 			return p->devid;
-- 
2.26.2.645.ge9eca65c58-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
