Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C32C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 11:55:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD8C206EB
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 11:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9962203E3;
	Mon, 22 Jun 2020 11:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xcjvnw3iJSSP; Mon, 22 Jun 2020 11:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D844620382;
	Mon, 22 Jun 2020 11:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B44BFC0891;
	Mon, 22 Jun 2020 11:55:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9311BC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 11:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7B5862038A
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 11:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lQTVl8NBKY1B for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 11:55:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 27E0320382
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 11:55:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 746F636B; Mon, 22 Jun 2020 13:55:38 +0200 (CEST)
Date: Mon, 22 Jun 2020 13:55:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200622115536.GH3701@8bytes.org>
References: <20200601174104.GA734973@bjorn-Precision-5520>
 <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-crypto@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kenneth-lee-2012@foxmail.com,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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

On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
> +++ b/drivers/iommu/iommu.c
> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> fwnode_handle *iommu_fwnode,
> =A0=A0=A0=A0=A0=A0=A0 fwspec->iommu_fwnode =3D iommu_fwnode;
> =A0=A0=A0=A0=A0=A0=A0 fwspec->ops =3D ops;
> =A0=A0=A0=A0=A0=A0=A0 dev_iommu_fwspec_set(dev, fwspec);
> +
> +=A0=A0=A0=A0=A0=A0 if (dev_is_pci(dev))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_fixup_device(pci_fixup_fi=
nal, to_pci_dev(dev));
> +

That's not going to fly, I don't think we should run the fixups twice,
and they should not be run from IOMMU code. Is the only reason for this
second pass that iommu_fwspec is not yet allocated when it runs the
first time? I ask because it might be easier to just allocate the struct
earlier then.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
