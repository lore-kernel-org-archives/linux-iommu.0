Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CEFC433E3
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 21:24:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C0222B40
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 21:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOC8em/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C0222B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02DAA87C9A;
	Mon, 27 Jul 2020 21:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
	occurs 6 times
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4ip4I6kR9mV; Mon, 27 Jul 2020 21:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A2D287B3D;
	Mon, 27 Jul 2020 21:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C953C0050;
	Mon, 27 Jul 2020 21:24:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01C45C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 21:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E46E5868C5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 21:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
 occurs 6 times
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QYEUfbKay-PQ for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 21:24:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5C34A868BF
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 21:24:36 +0000 (UTC)
Received: from localhost (unknown [13.85.75.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03103207BB;
 Mon, 27 Jul 2020 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595885076;
 bh=MLbhfNhfEWUuWMxtsosQROgke8OOlnnRmKKhop1HBKY=;
 h=Date:From:To:To:To:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:
 In-Reply-To:References:From;
 b=lOC8em/eCe10ZWbtq336EyzrF6MJarubmtalkuk7A+eJVealxhety4YlWrNkMSRbV
 T5yV6wzz0HcRXeKz/6FOlBj2qy2sUDkEVs+23uRDZhFmNDf2ih2pPwj+FH5ykICsad
 Yko9Iea0KyNLNC58GVk/GamNr6usT5YQcpjDthE0=
Date: Mon, 27 Jul 2020 21:24:35 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <joro@8bytes.com>
To: Lu Baolu <baolu.lu@intel.com>
Subject: Re: [PATCH v3 1/1] PCI/ATS: Check PRI supported on the PF device when
 SRIOV is enabled
In-Reply-To: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
References: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
Message-Id: <20200727212436.03103207BB@mail.kernel.org>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ashok Raj <ashok.raj@intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS").

The bot has tested the following trees: v5.7.10, v5.4.53, v4.19.134, v4.14.189, v4.9.231, v4.4.231.

v5.7.10: Build OK!
v5.4.53: Failed to apply! Possible dependencies:
    2b0ae7cc3bfc ("PCI/ATS: Handle sharing of PF PASID Capability with all VFs")
    751035b8dc06 ("PCI/ATS: Cache PASID Capability offset")
    8cbb8a9374a2 ("PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI")
    9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with all VFs")
    c065190bbcd4 ("PCI/ATS: Cache PRI Capability offset")
    e5adf79a1d80 ("PCI/ATS: Cache PRI PRG Response PASID Required bit")

v4.19.134: Failed to apply! Possible dependencies:
    2b0ae7cc3bfc ("PCI/ATS: Handle sharing of PF PASID Capability with all VFs")
    4f802170a861 ("PCI/DPC: Save and restore config state")
    6e1ffbb7c2ab ("PCI: Move ATS declarations outside of CONFIG_PCI")
    751035b8dc06 ("PCI/ATS: Cache PASID Capability offset")
    8c938ddc6df3 ("PCI/ATS: Add pci_ats_page_aligned() interface")
    8cbb8a9374a2 ("PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI")
    9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with all VFs")
    9c2120090586 ("PCI: Provide pci_match_id() with CONFIG_PCI=n")
    b92b512a435d ("PCI: Make pci_ats_init() private")
    c065190bbcd4 ("PCI/ATS: Cache PRI Capability offset")
    e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
    e5adf79a1d80 ("PCI/ATS: Cache PRI PRG Response PASID Required bit")
    fff42928ade5 ("PCI/ATS: Add inline to pci_prg_resp_pasid_required()")

v4.14.189: Failed to apply! Possible dependencies:
    1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
    1e4511604dfa ("PCI/AER: Expose internal API for obtaining AER information")
    3133e6dd07ed ("PCI: Tidy Makefiles")
    37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
    4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
    4f802170a861 ("PCI/DPC: Save and restore config state")
    8c938ddc6df3 ("PCI/ATS: Add pci_ats_page_aligned() interface")
    8cbb8a9374a2 ("PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI")
    9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with all VFs")
    9de0eec29c07 ("PCI: Regroup all PCI related entries into drivers/pci/Makefile")
    b92b512a435d ("PCI: Make pci_ats_init() private")
    c065190bbcd4 ("PCI/ATS: Cache PRI Capability offset")
    d3252ace0bc6 ("PCI: Restore resized BAR state on resume")
    e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
    e5adf79a1d80 ("PCI/ATS: Cache PRI PRG Response PASID Required bit")
    fff42928ade5 ("PCI/ATS: Add inline to pci_prg_resp_pasid_required()")

v4.9.231: Failed to apply! Possible dependencies:
    4ebeb1ec56d4 ("PCI: Restore PRI and PASID state after Function-Level Reset")
    8c938ddc6df3 ("PCI/ATS: Add pci_ats_page_aligned() interface")
    8cbb8a9374a2 ("PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI")
    9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with all VFs")
    a4f4fa681add ("PCI: Cache PRI and PASID bits in pci_dev")
    c065190bbcd4 ("PCI/ATS: Cache PRI Capability offset")
    e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
    e5adf79a1d80 ("PCI/ATS: Cache PRI PRG Response PASID Required bit")
    fff42928ade5 ("PCI/ATS: Add inline to pci_prg_resp_pasid_required()")

v4.4.231: Failed to apply! Possible dependencies:
    2a2aca316aed ("PCI: Include <asm/dma.h> for isa_dma_bridge_buggy")
    4d3f13845957 ("PCI: Add pci_unmap_iospace() to unmap I/O resources")
    4ebeb1ec56d4 ("PCI: Restore PRI and PASID state after Function-Level Reset")
    8cbb8a9374a2 ("PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI")
    9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with all VFs")
    a4f4fa681add ("PCI: Cache PRI and PASID bits in pci_dev")
    c5076cfe7689 ("PCI, of: Move PCI I/O space management to PCI core code")
    e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
