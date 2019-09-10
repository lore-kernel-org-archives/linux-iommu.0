Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969CC49ED9
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A282168B
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PntmOjjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A282168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8FD07D67;
	Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EC770D67
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
	[207.171.184.29])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F4B58A8
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1568137808; x=1599673808; h=from:to:subject:date:message-id;
	bh=Wd9BZT5mhRC+sg3kUmT7XieFg+66hTOzR6acJxYycRM=;
	b=PntmOjjwpKHjbptT5VQUuxAsz3zNZ4gkvPx6nCsq0zPdtl8y1HbfYHA3
	I17Qnm1KVN/2mweFBsUYXDeBLY9WsoreI5C0xnzJGklcnOr0wYFG8xK8u
	QdUDXnJSX+YbzgR4gjQ5QHP0k1NqKDu2lZv5OmqEaEQJwL6R3ypXyD+6u M=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; d="scan'208";a="701858127"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO
	email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.38])
	by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
	10 Sep 2019 17:49:38 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com
	(pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
	by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with
	ESMTPS id B5062A24F8; Tue, 10 Sep 2019 17:49:35 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with
	ESMTP id x8AHnXLb023806; Tue, 10 Sep 2019 19:49:33 +0200
Received: (from sironi@localhost)
	by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id
	x8AHnXi2023801; Tue, 10 Sep 2019 19:49:33 +0200
To: sironi@amazon.de, joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: iommu/amd: Flushing and locking fixes
Date: Tue, 10 Sep 2019 19:49:20 +0200
Message-Id: <1568137765-20278-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
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
From: Filippo Sironi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Filippo Sironi <sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This patch series introduce patches to take the domain lock whenever we call
functions that end up calling __domain_flush_pages.  Holding the domain lock is
necessary since __domain_flush_pages traverses the device list, which is
protected by the domain lock.

The first patch in the series adds a completion right after an IOTLB flush in
attach_device.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
