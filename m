Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C04FC282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A112208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/vVbZY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A112208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 43AAE16D7;
	Wed, 24 Apr 2019 21:15:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D54E1606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 35852786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:40 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id n25so6646439wmk.4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
	b=q/vVbZY/oSONQZN13xcosLByqm2O1DfMuokvB/Zs2CWi9b5hGXmvyq5jC9E3clmH+l
	mIkrlnMdfjyZvxDJ7sKt77zegqGhpIuSqQ+loZavowwQos0CAq4G8VuC2WsyZSU4w9eS
	FEpVZEGh+2MtbxAPoEBXG807GvXT+LbvdPixqZwaMbJnTUMyKK9cG9RgV7pugAkrGx0+
	VlDqc1JKTGsHMFI/rNNYUesCgEfddgmbZ68Cmkgj3BJX0xcTRbEbCbMwco6Yc1n7sbDy
	tm3SLEuQ1Aojh+7gfxXY3GPDcxlsHmodwHLzy1agZwERBblJjhvLLUlBgvN1AxNgjjzB
	+NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
	b=aFjb/dvsNOH8xgbebPi6KPuDr+oCBxcErMWS9V+9jCSuUXzivtdWdCkHgJ/LDfCKDH
	MuyMhdE57Aq4DTagOuQVO1kbYaguMNVy5+Ox4yD10mqq52iV8Mt5NQpczL8wYvoXjxLb
	QbZcnv2KP7czK23q3MmrzsJ5DpNK7A0nE80fw+AmE6NuPvcB4+j/2j7d8Sw9iH1f5nJ6
	z9DeNEU0g/NQTn479rt/nyfPrTFtELUnVjD9OLyVhBBe7Y7oFjl6izN3b30w4JHmlS5F
	mssWYhH27FYyRujJHPYm8YmaluoqCbvnw+wLkg1CXxo8uBlSCxBZbnNIENzTKjbb6KFC
	ZzQQ==
X-Gm-Message-State: APjAAAXgrorNqlcghuCbOOONyh58jw4gv7yaWNPfobmSaRPh4bmP2m9m
	32IuaLwBiZvEMErewHFoTTg=
X-Google-Smtp-Source: APXvYqy1cGZoaC1duyy6JSmEOesKryNZXcbz5ec5DLtsSEFpsU7HttVUGLgD8gDdtV6ofxfO1zXzUA==
X-Received: by 2002:a05:600c:22d1:: with SMTP id
	17mr449859wmg.62.1556133458836; 
	Wed, 24 Apr 2019 12:17:38 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	s18sm19261192wmc.41.2019.04.24.12.17.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:37 -0700 (PDT)
Subject: [PATCH v2 1/9] PCI: add helper pci_dev_id
From: Heiner Kallweit <hkallweit1@gmail.com>
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
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Message-ID: <a7980450-4ae2-9a18-4068-7463fb0190bd@gmail.com>
Date: Wed, 24 Apr 2019 21:11:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
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
Message-ID: <20190424191158.KdEOuuYzfrD2MuDY6TPg2NDDFuFVkSaZNHIKPISA98w@z>

In several places in the kernel we find PCI_DEVID used like this:
PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
for it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/pci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c056a7a7..28d0313a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -598,6 +598,11 @@ struct pci_bus {
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
+static inline u16 pci_dev_id(struct pci_dev *dev)
+{
+	return PCI_DEVID(dev->bus->number, dev->devfn);
+}
+
 /*
  * Returns true if the PCI bus is root (behind host-PCI bridge),
  * false otherwise
-- 
2.21.0



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
