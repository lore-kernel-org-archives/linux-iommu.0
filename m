Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7AAC433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8296720774
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyCRgzzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8296720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60B6B87647;
	Tue, 23 Jun 2020 15:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dveLRzHWnd4i; Tue, 23 Jun 2020 15:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4D6387578;
	Tue, 23 Jun 2020 15:04:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0401C088E;
	Tue, 23 Jun 2020 15:04:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD337C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 15:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B23A62637A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 15:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iByShuw0TXZz for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 15:04:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 51D3D22CB0
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 15:04:29 +0000 (UTC)
Received: from localhost (mobile-166-170-222-206.mycingular.net
 [166.170.222.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94EC420723;
 Tue, 23 Jun 2020 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592924669;
 bh=pYSmEX90OpGgB4bw3JQlLwOPKGPZt8zcCg2Jw+YWJhM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=uyCRgzznNIaGzwTA5WSAD0mfkUx7PWjjDA0xuNRfK8wdFyqid6COQmfVRcULXo7eB
 x6r9H+xRROcynvqijhjGKwufYcigaaHtOMvN1NklZTodXP7DkrU83liurSsGCNLFtO
 sRrkKEDXRbWwc9kz0no38z13LtKl0kt/Ne0JEuNE=
Date: Tue, 23 Jun 2020 10:04:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200623150427.GA2403606@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5d7b2f1-6b32-d965-3b60-eb70a26e02b4@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 19, 2020 at 10:26:54AM +0800, Zhangfei Gao wrote:
> Have studied _DSM method, two issues we met comparing using quirk.
> =

> 1. Need change definition of either pci_host_bridge or pci_dev, like addi=
ng
> member can_stall,
> while pci system does not know stall now.
> =

> a, pci devices do not have uuid: uuid need be described in dsdt, while pci
> devices are not defined in dsdt.
> =A0=A0=A0 so we have to use host bridge.

PCI devices *can* be described in the DSDT.  IIUC these particular
devices are hardwired (not plug-in cards), so platform firmware can
know about them and could describe them in the DSDT.

> b,=A0 Parsing dsdt is in in pci subsystem.
> Like drivers/acpi/pci_root.c:
> =A0=A0=A0=A0=A0=A0 obj =3D acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &p=
ci_acpi_dsm_guid,
> 1,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> =

> After parsing DSM in pci, we need record this info.
> Currently, can_stall info is recorded in iommu_fwspec,
> which is allocated in iommu_fwspec_init and called by iort_iommu_configure
> for uefi.

You can look for a _DSM wherever it is convenient for you.  It could
be in an AMBA shim layer.

> 2. Guest kernel also need support sva.
> Using quirk, the guest can boot with sva enabled, since quirk is
> self-contained by kernel.
> If using=A0 _DSM, a specific uefi or dtb has to be provided,
> currently we can useQEMU_EFI.fd from apt install qemu-efi

I don't quite understand what this means, but as I mentioned before, a
quirk for a *limited* number of devices is OK, as long as there is a
plan that removes the need for a quirk for future devices.

E.g., if the next platform version ships with a DTB or firmware with a
_DSM or other mechanism that enables the kernel to discover this
information without a kernel change, it's fine to use a quirk to cover
the early platform.

The principles are:

  - I don't want to have to update a quirk for every new Device ID
    that needs this.

  - I don't really want to have to manage non-PCI information in the
    struct pci_dev.  If this is AMBA- or IOMMU-related, it should be
    stored in a structure related to AMBA or the IOMMU.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
