Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11687C4360C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 22:58:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E122D21721
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 22:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E122D21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1FD39CAE;
	Tue,  8 Oct 2019 22:58:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A5CE2C79
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 22:58:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 609E55F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 22:58:19 +0000 (UTC)
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1iHxod-000551-C6; Tue, 08 Oct 2019 16:18:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
	(envelope-from <gunthorp@deltatee.com>)
	id 1iHxoa-0003PX-Nt; Tue, 08 Oct 2019 16:18:44 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Joerg Roedel <joro@8bytes.org>
Date: Tue,  8 Oct 2019 16:18:34 -0600
Message-Id: <20191008221837.13067-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, joro@8bytes.org,
	kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/3] AMD IOMMU Changes for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Logan Gunthorpe <logang@deltatee.com>, Kit Chow <kchow@gigaio.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

Please find the following patches which help support
Non-Transparent-Bridge (NTB) devices on AMD platforms with the IOMMU
enabled.

The first patch implements dma_map_resource() correctly with the AMD
IOMMU. This is required for correct functioning of ntb_transport which
uses that interface.

The second two patches add support for multiple PCI aliases. NTB
hardware will normally send TLPs from a range of requestor IDs to
facilitate routing the responses back to the correct requestor on the
other side of the bridge. To support this, NTB hardware registers a
number of PCI aliases. Currently the AMD IOMMU only allows for one
PCI alias so TLPs from the other aliases get rejected.

See commit ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi
Switchtec NTB") for more information on this.

Similar patches were upstreamed for Intel hardware earlier this year:

commit 21d5d27c042d ("iommu/vt-d: Implement dma_[un]map_resource()")
commit 3f0c625c6ae7 ("iommu/vt-d: Allow interrupts from the entire bus
    for aliased devices")

Thanks,

Logan

--

Kit Chow (1):
  iommu/amd: Implement dma_[un]map_resource()

Logan Gunthorpe (2):
  iommu/amd: Support multiple PCI DMA aliases in device table
  iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping

 drivers/iommu/amd_iommu.c       | 198 +++++++++++++++++++-------------
 drivers/iommu/amd_iommu_types.h |   2 +-
 2 files changed, 120 insertions(+), 80 deletions(-)

--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
