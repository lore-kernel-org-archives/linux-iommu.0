Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6FC282CE
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:04:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11ED2084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11ED2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02E45FFB;
	Tue,  9 Apr 2019 14:04:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30FF1FBF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:04:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB0A176D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:04:00 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D353F68B02; Tue,  9 Apr 2019 16:03:47 +0200 (CEST)
Date: Tue, 9 Apr 2019 16:03:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>
Subject: status of the calgary iommu driver
Message-ID: <20190409140347.GA11524@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409140347._6zNHQTVa1a6_EK4l_3uprWihjMKk6hcejVsWLEt1Xo@z>

Hi Muli and Jon,

do you know if there are user of systems with the Calgary iommu
around still? It seems like the last non-drive by changes to it
are from 2010 and I'm not sure how common these systems were.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
