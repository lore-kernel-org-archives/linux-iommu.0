Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3226C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 20:38:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC9823A22
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 20:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC9823A22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E502887AFF;
	Thu, 17 Dec 2020 20:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjYomQCWuocb; Thu, 17 Dec 2020 20:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5761F87B01;
	Thu, 17 Dec 2020 20:38:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48A3EC0893;
	Thu, 17 Dec 2020 20:38:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5A96C013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 20:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CC4DD876E6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 20:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cG5DJ6QoClG for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 20:38:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E9738763D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 20:38:08 +0000 (UTC)
Date: Thu, 17 Dec 2020 14:38:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608237488;
 bh=Rpq08eYW+DA58q5pcS/wXU0VbVBc1vYow6lIlzk55rU=;
 h=From:To:Cc:Subject:In-Reply-To:From;
 b=KqE949u41Nqk8wZdC73imrPNhV6iDujEFjRfkVjZScfGg5NLARgNksvDkk54oZI9i
 mv/u6l2got64jOQ5WYUtngu2q9vI6xjHII+Jcy+PrjjE2gs1K6xgdwztx+nAvI4G2p
 D/IUTUhGXYUo0T11xN0y5dzNNoaIntqhsq2soJ1qJZmtzmxSv5ozHe2eIvw5XczDhw
 7imXx7N9zkX5LZaNE/XBXWbLBfgxWdq6WNk63Vd9f31kXpIWOfBj6C4mP+2GZruhTz
 M32DBRPOd7HuNC1U2xW9CiDgiKPo9i9u/PExMcMNgvaVJ1cxp2OOgAAkXwohRF2CCU
 mV7YA0/SGEecA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20201217203806.GA20785@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5FD9EE6E.1040505@hisilicon.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Len Brown <lenb@kernel.org>,
 Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 kenneth-lee-2012@foxmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
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

On Wed, Dec 16, 2020 at 07:24:30PM +0800, Zhou Wang wrote:
> On 2020/6/23 23:04, Bjorn Helgaas wrote:
> > On Fri, Jun 19, 2020 at 10:26:54AM +0800, Zhangfei Gao wrote:
> >> Have studied _DSM method, two issues we met comparing using quirk.
> >>
> >> 1. Need change definition of either pci_host_bridge or pci_dev, like adding
> >> member can_stall,
> >> while pci system does not know stall now.
> >>
> >> a, pci devices do not have uuid: uuid need be described in dsdt, while pci
> >> devices are not defined in dsdt.
> >>     so we have to use host bridge.
> > 
> > PCI devices *can* be described in the DSDT.  IIUC these particular
> > devices are hardwired (not plug-in cards), so platform firmware can
> > know about them and could describe them in the DSDT.
> > 
> >> b,  Parsing dsdt is in in pci subsystem.
> >> Like drivers/acpi/pci_root.c:
> >>        obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid,
> >> 1,
> >>                                 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> >>
> >> After parsing DSM in pci, we need record this info.
> >> Currently, can_stall info is recorded in iommu_fwspec,
> >> which is allocated in iommu_fwspec_init and called by iort_iommu_configure
> >> for uefi.
> > 
> > You can look for a _DSM wherever it is convenient for you.  It could
> > be in an AMBA shim layer.
> > 
> >> 2. Guest kernel also need support sva.
> >> Using quirk, the guest can boot with sva enabled, since quirk is
> >> self-contained by kernel.
> >> If using  _DSM, a specific uefi or dtb has to be provided,
> >> currently we can useQEMU_EFI.fd from apt install qemu-efi
> > 
> > I don't quite understand what this means, but as I mentioned before, a
> > quirk for a *limited* number of devices is OK, as long as there is a
> > plan that removes the need for a quirk for future devices.
> > 
> > E.g., if the next platform version ships with a DTB or firmware with a
> > _DSM or other mechanism that enables the kernel to discover this
> > information without a kernel change, it's fine to use a quirk to cover
> > the early platform.
> > 
> > The principles are:
> > 
> >   - I don't want to have to update a quirk for every new Device ID
> >     that needs this.
> 
> Hi Bjorn and Zhangfei,
> 
> We plan to use ATS/PRI to support SVA in future PCI devices. However, for
> current devices, we need to add limited number of quirk to let them
> work. The device IDs of current quirk needed devices are ZIP engine(0xa250, 0xa251),
> SEC engine(0xa255, 0xa256), HPRE engine(0xa258, 0xa259), revision id are
> 0x21 and 0x30.
> 
> Let's continue to upstream these quirks!

Please post the patches you propose.  I don't think the previous ones
are in my queue.  Please include the lore URL for the previous
posting(s) in the cover letter so we can connect the discussion.

> >   - I don't really want to have to manage non-PCI information in the
> >     struct pci_dev.  If this is AMBA- or IOMMU-related, it should be
> >     stored in a structure related to AMBA or the IOMMU.
> > .
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
