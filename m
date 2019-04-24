Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D2C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E668208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK4njm5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E668208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BB6E116DE;
	Wed, 24 Apr 2019 21:15:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AD531606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 35698786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:45 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id h4so26687523wre.7
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
	b=KK4njm5c66wApJlm8WGtcK3eINA7bZzqf9jpF/xDcoCSdcuGWR7ygTnW7CxGOT7Zpb
	ClJa1zpkc0LnLQ3Y9FSdXrMwgQvpBYbm2h61pKGsBRYXBFkHEnXr7h2wDgkaAsAj6P04
	n+Zhe79BzllwSlP7qQcQ1oNHfpi5n4yGvzSir6Qil6I+8IfT0AGlMW1C3bfb7hbIOrnv
	/TQKg5FQRX19gB+eGsG3WBIFJCSsQmuhe604FqNiT/pZUC4DClEWV5U3gwAbTgI70ma+
	+jCLa9iSGj52KBjpTWMg0o/2CwQGRZzVKsI7N71kUDVC8rL8yE29inQ1qfO+L+vf3GA3
	Zx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+k7fklQVC1wXNkIsXxuBFFgxierE2Y58VYjajnqTX8M=;
	b=ec1wsNFrgpcKLGxS2Dt9y8FMzaC6/lR09+HxyDbbBeUbcKIOiP+PPdFjx3Y5ry/HD8
	pDlutdfcM5RlE4YSkz/0GCPwTKm1gTvL432o73n6xvA5tv74S20jAXbb652uUAL8cjed
	GzUea2wZvT8Iu9w24YK+AT6En7cwnt3sXKh0pCSbnEmsYUjUGv+uRQZCLJG5qOuN3MRN
	jM1P9vnOA+TbWSFnIbBbvMk9I2hFA/PfC8gyyODz8suEfeLgtYnqkXqB7DoPpgZ5ZmvT
	SotryJ3Td2VWQaq7hWDubziF2FLxrB8rcmRDbVSHhbEVxU6aXAMCNXapyJUT5qsJrIiq
	u7vg==
X-Gm-Message-State: APjAAAUl8Wn16c9c1Zp65+P7rVSQ+ycqn8m3Po+hdFShSNSOOTDCc4bt
	xW+6yCmqWQHPSd/75Jb8vI8=
X-Google-Smtp-Source: APXvYqwDmKBVeUMPZVGyJTnitTfK6cM0z/PsKemtuUUK1m2YTTQaoqWzBVErwIt/ROAiTYboFRIU3w==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr377002wrv.315.1556133463901;
	Wed, 24 Apr 2019 12:17:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	u1sm2183653wrp.69.2019.04.24.12.17.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:43 -0700 (PDT)
Subject: [PATCH v2 3/9] r8169: use new helper pci_dev_id
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
Message-ID: <fec3960e-5e65-3f62-0922-736f26db095f@gmail.com>
Date: Wed, 24 Apr 2019 21:13:25 +0200
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
Message-ID: <20190424191325.ZyPG9EF_WGALOLpjW2GB1JUhQghw0X_SPQDWL71pX-U@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index efaea1a0a..ae476fe8d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7020,8 +7020,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_IGNORE_INTERRUPT;
-	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x",
-		 PCI_DEVID(pdev->bus->number, pdev->devfn));
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x", pci_dev_id(pdev));
 
 	new_bus->read = r8169_mdio_read_reg;
 	new_bus->write = r8169_mdio_write_reg;
-- 
2.21.0




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
