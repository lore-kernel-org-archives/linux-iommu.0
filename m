Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7EC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438F5208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AME1sDCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438F5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 11C0D16D5;
	Wed, 24 Apr 2019 21:15:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ED63515EC
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:10:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DD16C786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:10:30 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id w15so6606925wmc.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:message-id:date:user-agent:mime-version
	:content-language:content-transfer-encoding;
	bh=S/zxi2ylVDkqZZBbgyooXrxhGjXILZWxNPyecty54tU=;
	b=AME1sDCz7IsznAaDKCRLuMso2ULXcX84VgNd/onrA55lmWTjEfne7pilAe89L/ReV1
	YL9MkF8MqachlqSB3wJTEJH6MOv/gQGRB/O6DAvToz1PH+1DMgeNpO9tu88O2ydj0pnt
	kTJeApTO6c4GDURe1RXAU3UHmaMbKeM3+mEx1Ec/d8AQj61u9u1ioGmeWYVfwKvsSYDQ
	EotF34SOSdUwn1gBDqLatg2zIixPBW6W5UjcJteZumeVE0IWtAIalsL6g+2Ga9zeo+pp
	+2D73T8neDESABr59mxcT8taWO4ION6zMrpk16S+v+ncVCXBdCxaN+Tv7youENwXFOaQ
	4UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
	:mime-version:content-language:content-transfer-encoding;
	bh=S/zxi2ylVDkqZZBbgyooXrxhGjXILZWxNPyecty54tU=;
	b=Zx0M6rSvt3KpTwBp42vl8kMGx7tIYh7q2NVD5BFwL0pZvq42M+/sZrrI/bxIpbYBzH
	NakQw8mNYzNUNTL06mCdK007+p5U3e/OGCQFu4zskT+OmEGmcoXI94R6P6/zRGgvym38
	6W/v2XrOCsJfOKm+D0BeN3sdS3bgoTTLXiEodusdd849zNsz32gouVlPh2lI/Jq7ueb6
	N27zpAKU6jdvIz8K26b3Pkx3J5FMSqY6sCU3jCKW69QQbFu0m2CsXpa5n0hh2FDtfKvB
	W5/Ep1JsiV9IYrygajUz8ZEYFePxgQllSDsnV3ve89fl92b/SiEUm51z9nteMn7lnP+n
	IWkA==
X-Gm-Message-State: APjAAAWN2hO4x4wT9xKdFqcfLzGshMTn+mIGSfDX3F796lcbOGIwa+sG
	6n7B5V5xYTrRfNx+F8VtRsQ=
X-Google-Smtp-Source: APXvYqwve8fzbjDfRoaAHshs/aKdK6nujPjOor6S8/pTST7pGm1teWfE5s7YlHOGCSqyrGCrLN3GMw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr449512wma.120.1556133029543;
	Wed, 24 Apr 2019 12:10:29 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	t17sm17020471wrr.26.2019.04.24.12.10.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:10:28 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/9] PCI: add help pci_dev_id
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oded Gabbay <oded.gabbay@gmail.com>, 
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>
Message-ID: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Date: Wed, 24 Apr 2019 21:10:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Wed, 24 Apr 2019 21:15:37 +0000
Cc: "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	"open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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
Message-ID: <20190424191021.rciFyu92xncnx0v2V7jiG4knhIywrsAm30iRdmCgeUk@z>

In several places in the kernel we find PCI_DEVID used like this:
PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
for it.

v2:
- apply the change to all affected places in the kernel

Heiner Kallweit (9):
  PCI: add helper pci_dev_id
  PCI: use helper pci_dev_id
  r8169: use new helper pci_dev_id
  powerpc/powernv/npu: use helper pci_dev_id
  drm/amdkfd: use helper pci_dev_id
  iommu/amd: use helper pci_dev_id
  iommu/vt-d: use helper pci_dev_id
  stmmac: pci: use helper pci_dev_id
  platform/chrome: chromeos_laptop: use helper pci_dev_id

 arch/powerpc/platforms/powernv/npu-dma.c         | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c        |  3 +--
 drivers/iommu/amd_iommu.c                        |  2 +-
 drivers/iommu/intel-iommu.c                      |  2 +-
 drivers/iommu/intel_irq_remapping.c              |  2 +-
 drivers/net/ethernet/realtek/r8169.c             |  3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  2 +-
 drivers/pci/msi.c                                |  6 +++---
 drivers/pci/search.c                             | 10 +++-------
 drivers/platform/chrome/chromeos_laptop.c        |  2 +-
 include/linux/pci.h                              |  5 +++++
 11 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
