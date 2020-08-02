Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F1FC433E5
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 18:47:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E15F20738
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="km2ppJ9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E15F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F154487C9A;
	Sun,  2 Aug 2020 18:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAEv79zhoRqa; Sun,  2 Aug 2020 18:47:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD2C587939;
	Sun,  2 Aug 2020 18:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93FB6C0051;
	Sun,  2 Aug 2020 18:47:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 349B9C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D74F86E77
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QfmVvB5npJug for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 18:47:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8857486230
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 18:47:23 +0000 (UTC)
Received: from nazgul.tnic (unknown [78.130.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6060E1EC027B;
 Sun,  2 Aug 2020 20:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1596394040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=6tNJPljLjNx2x9QEIVJnns37NMBlLLp4EAbpTzGkx/k=;
 b=km2ppJ9W1lKPkeogNByCZRPPB90pQ77y1xFpzqsz5v2Gw4jUrJuG2BUGC6FlwifBWKp5xA
 i/pwFuidiFCe1IAhyK7PX67NxCd1gqUPGlQREtpW/WPoHky93LT53Q3Zqf5RRY0CErhAu0
 8YCnO7sm9NOsIwnrSCtwGhnf6GzAdAw=
Date: Sun, 2 Aug 2020 20:46:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Saheed Bolarinwa <refactormyself@gmail.com>
Subject: Re: [RFC PATCH 00/17] Drop uses of pci_read_config_*() return value
Message-ID: <20200802184648.GA23190@nazgul.tnic>
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801125657.GA25391@nazgul.tnic>
 <b720aa44-895a-203b-e220-ecdb3acd9278@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b720aa44-895a-203b-e220-ecdb3acd9278@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, trix@redhat.com,
 linux-fpga@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-rdma@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-atm-general@lists.sourceforge.net, helgaas@kernel.org,
 linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Wolfgang Grandegger <wg@grandegger.com>, intel-gfx@lists.freedesktop.org,
 linux-gpio@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 skhan@linuxfoundation.org, bjorn@helgaas.com,
 Kalle Valo <kvalo@codeaurora.org>, linux-edac@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Sun, Aug 02, 2020 at 07:28:00PM +0200, Saheed Bolarinwa wrote:
> Because the value ~0 has a meaning to some drivers and only

No, ~0 means that the PCI read failed. For *every* PCI device I know.

Here's me reading from 0xf0 offset of my hostbridge:

# setpci -s 00:00.0 0xf0.l
01000000

That device doesn't have extended config space, so the last valid byte
is 0xff. Let's read beyond that:

# setpci -s 00:00.0 0x100.l
ffffffff

> Again, only the drivers can determine if ~0 is a valid value. This
> information is not available inside pci_config_read*().

Of course it is.

*every* change you've done in 6/17 - this is the only patch I have
received - checks for == ~0. So that check can just as well be moved
inside pci_config_read_*().

Here's how one could do it:

#define PCI_OP_READ(size, type, len) \
int noinline pci_bus_read_config_##size \
	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
{									\
	int res;							\
	unsigned long flags;						\
	u32 data = 0;							\
	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
	pci_lock_config(flags);						\
	res = bus->ops->read(bus, devfn, pos, len, &data);		\

	/* Check we actually read something which is not all 1s.*/
	if (data == ~0)
		return PCIBIOS_READ_FAILED;

	*value = (type)data;						\
	pci_unlock_config(flags);					\
	return res;							\
}

Also, I'd prefer a function to *not* return void but return either
an error or success. In the success case, the @value argument can be
consumed by the caller and otherwise not.

In any case, that change is a step in the wrong direction and I don't
like it, sorry.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
