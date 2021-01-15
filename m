Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F98C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 15:22:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4E52389B
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 15:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4E52389B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0FEDC86BC6;
	Fri, 15 Jan 2021 15:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gae3c6n9euNj; Fri, 15 Jan 2021 15:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A8D286AC7;
	Fri, 15 Jan 2021 15:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0922CC088B;
	Fri, 15 Jan 2021 15:22:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A39CC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 15:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E74520442
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 15:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TbIeXoRgEbzJ for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 15:22:24 +0000 (UTC)
X-Greylist: delayed 00:08:09 by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by silver.osuosl.org (Postfix) with ESMTPS id BBB6B20381
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcJq7gJcR8wGrxirpS7YgCH4oSZ0tPUnT6P18IedXe8=; b=HC/dbq+U8x8b6ApN9wq3/+KMa
 1DkEFnV9V67022GmrLF4V0dTmTPtKRHK3+l2RiRj73GzJ6+hmcivNMhj91+GhwpcsixXqafkOgMQe
 C5ELjmoxpCJaxxiwADge7gYaIKE0yfBABw/675IirMTagdIVwZbrdd7svGF+2GMAUF7Ftbms77YMU
 0gl3QdE8eLhhqH9Ov23nEBTFDVLmha3LRn9SSXkiDw22HFu3eFH/G01xlayfrSJMWL5TFhrFPDd8V
 jd8rilZ3Wx5LtFhi+dOTNXsJqQggBqLcqs77ar8EOGkXCBf9PfVB4y5vbDt7JUzmA3ShDya0xYvw3
 9BSZE9axQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48344)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1l0Qnf-0003vO-Uo; Fri, 15 Jan 2021 15:14:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1l0Qnc-00013o-7F; Fri, 15 Jan 2021 15:14:04 +0000
Date: Fri, 15 Jan 2021 15:14:04 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Consult on ARM SMMU debugfs
Message-ID: <20210115151403.GZ1551@shell.armlinux.org.uk>
References: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
 <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 11, 2021 at 08:01:48PM +0000, Robin Murphy wrote:
> On 2021-01-07 02:45, chenxiang (M) wrote:
> > Hi Will,=A0 Robin or other guys,
> > =

> > When debugging SMMU/SVA issue on huawei ARM64 board, we find that it
> > lacks of enough debugfs for ARM SMMU driver (such as
> > =

> > the value of STE/CD which we need to check sometimes). Currently it
> > creates top-level iommu directory in debugfs, but there is no debugfs
> > =

> > for ARM SMMU driver specially. Do you know whether ARM have the plan to
> > do that recently?
> =

> FWIW I don't think I've ever felt the need to need to inspect the Stream
> Table on a live system. So far the nature of the STE code has been simple
> enough that it's very hard for any given STE to be *wrong* - either it's =
set
> up as expected and thus works fine, or it's not initialised at all and you
> get C_BAD_STE, where 99% of the time you then just cross-reference the
> Stream ID against the firmware and find that the DT/IORT is wrong.
> =

> Similarly I don't think I've even even *seen* an issue that could be
> attributed to a context descriptor, although I appreciate that as we start
> landing more PASID and SVA support the scope for that starts to widen
> considerably.
> =

> Feel free to propose a patch if you believe it would be genuinely useful =
and
> won't just bit-rot into a maintenance burden, but it's not something that=
's
> on our roadmap here.

I do think that the IOMMU stuff needs better debugging. I've hit the
WARN_ON() in __arm_lpae_map(), and it's been pretty much undebuggable,
so I've resorted to putting the IOMMU into bypass mode permanently to
work around the issue.

The reason that it's undebuggable is if one puts printk() or trace
statements in the code, boots the platform, you get flooded with those
debugging messages, because every access to the rootfs generates and
tears down a mapping.

It would be nice to be able to inspect the IOMMU page tables and state
of the IOMMU, rather than having to resort to effectively disabling
the IOMMU.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
