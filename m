Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D647BC282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5830206A3
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ahPan2fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5830206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AF971384;
	Wed, 24 Apr 2019 16:51:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1151A1382
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 16:51:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 182B082B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 16:51:10 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id y67so16580015ede.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=iqXJdGaFlfiiJTJLgY9f/HTOvJcH9iD1vYBFNl3Eq7Q=;
	b=ahPan2fb23ZwJK9mMpjdr9I9tFYsGCh6Rybt9NG+QIubaMB4p29seFK7C2udYNBtjL
	wmzLLWDqhntze0GG9Nyxr1nII6YUI695r8neq+IJDQ4XtEi+63HXwaDRcpr9zYLNJp5B
	Am7CW9qqJykuKUHbv/x86wRnMANC8tferNKB5nkR4qKOjLEkvc/Jf/1X/OFjXQwMO33B
	VBIHJwIqKxOOGi3tTmc8aOKAGXFY1T9HWVrbaECBmUoOXUrvrPbhseLPpS5RXxSHG7ZY
	HQznn91+b757e5KuVboTDuQBT3FBn+qaqbhRaD5ShzJJ8ZfMOgVUrQ9NMUffvkQqr1MX
	v9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=iqXJdGaFlfiiJTJLgY9f/HTOvJcH9iD1vYBFNl3Eq7Q=;
	b=XqqDaMH0wgou9OtPhQI3IBRctUwrMUHzSSvINZzecHVZAHSUOWgySg/UuYdnVgODGt
	vj9cOqUdj5HrMf2kKFBd4wEvkk00iXobx75hxQ3lL+81GBw4ycgQX0NfKd3K2BYCHCez
	cS92aUeu/w47P+VGR6iWDVzx2bFqnbaO6O2lrRJ9U9ZhR2NoBdlfA2kjSLyDjqsIp+yo
	ccFOvvXFVQb8uswZ5xFnlbJvvlXQmqLANStuVB+ADJyYNND0KJB+V65fvpsXshCF7443
	gjvK5oBgBUFMnGsa8ZIq0f5RsMJapX9aRvxblZ8wPwJp1QBHmXbEqHL+NpeuAA/TFDCT
	Xgrg==
X-Gm-Message-State: APjAAAXtZLM42WceTwmfHccgJ8ylBnIqhMxd1UGkKx+yAZSMF+fQQXdA
	d2N3Zt9Gn1LYo27kC0D0jbl2czYWsdQ0vw==
X-Google-Smtp-Source: APXvYqy5m0cq67m7iQ3AlUUZD6EjbVPpaKzlEqgdd4iUcMjCKGolFHT1tB4EF306EiVey+BlONNTvw==
X-Received: by 2002:a17:906:5855:: with SMTP id
	h21mr16482031ejs.264.1556124668507; 
	Wed, 24 Apr 2019 09:51:08 -0700 (PDT)
Received: from localhost.localdomain ([80.233.44.160])
	by smtp.gmail.com with ESMTPSA id
	w54sm5800702eda.85.2019.04.24.09.51.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 09:51:07 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Wed, 24 Apr 2019 17:50:51 +0100
Message-Id: <20190424165051.13614-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424165051.MQvkf6ozp-fb1NWE876_x9_itRRkZoxqCO-Lxo64O8o@z>

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..91fe5cb10f50 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	update_domain(dom);
 
+	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
+		domain_flush_pages(dom, bus_addr, page_size);
+		domain_flush_complete(dom);
+	}
+
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
