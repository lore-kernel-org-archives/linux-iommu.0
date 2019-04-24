Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417DC282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56C1208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIXRJwuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56C1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0DCB516EC;
	Wed, 24 Apr 2019 21:15:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 216F01606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4A5F82E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:57 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id 10so6097897wmk.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SAbbSQG37YeApBp0oyHaMCbtBHNMxP+2zNJpk+CsD/M=;
	b=AIXRJwuB+H8CUQQMeS5qlpm0mA9MRtCpnvd55esAPnP4ZWf8RvpdvE922lJmqnVIpB
	3WTSTa1p1xLB/UPdSXHtSdMm3TwK0Ijnw5bZfpyK0oWvEVW3C09vKa1Q2aYpH2hWevRC
	LzFsybDvUKqNfYk+TG/LaBrmNyzjfxLPOoWGgrjG+moMF94/PiKjNMdt7AGAj8dA59K4
	1/Eg3DgVYvKL5GLVCx68IVgAiK56Pb2bmSAxMnuMtfO32YoCnamKsq6gqu71j44UcOgv
	4GZRg98MJRc10wCTTm84P0cCLZbrQhwuPU/OgImeBXnr5lQkDyGgHFjzV90i9GpJdHs7
	kLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SAbbSQG37YeApBp0oyHaMCbtBHNMxP+2zNJpk+CsD/M=;
	b=f/ziFs7cmUtvx47IozZ0Tb2EVdqhdW1B6BR1RYGnVv0T9ohMcNixjWGHdAneco4Q2a
	xP1TnuZ1OH1Tf6ZPWMxqlp+kX5EoOQp0yuM4Wu0Yju9q7yc9fEwdAsMassic/dZXPEfq
	Qs+BjMZZ3imoK63Y8Y8sTUYhU6uDSLp3n/fIHqe0tQCxscfs4jE/c2UMRXGnemckWRXB
	mQhdxvXMEY6+I9TlAbNwShYvaSCaZpPAWSQjelfkl022Y4d5zoGUeJnxu1xiOIxPSQor
	3QYukcBQ43B1uZNohdKH6nddx/Ch06Kx/PU6SwXZ2Zu/8Xx+wMw4L7dVk0Ip66Daozcy
	8DBA==
X-Gm-Message-State: APjAAAXygNBNC/rgOzN9l8xSSJLsOvswOCwFdRa6LH0LFuUgg/htdMa2
	XEYoOlzCURoKUd1DxGgSP6g=
X-Google-Smtp-Source: APXvYqz1FxREHsjxcSzzKYBRZR1hyc+jklGgIQJ7OMGK1qrzBngr1H8WAm880vG55Y8yYFtfRLfERA==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr473319wmh.86.1556133476436;
	Wed, 24 Apr 2019 12:17:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	q202sm4917605wme.9.2019.04.24.12.17.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:55 -0700 (PDT)
Subject: [PATCH v2 8/9] stmmac: pci: use helper pci_dev_id
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
Message-ID: <82febf42-5f1e-a5d1-5c38-40dcaefdf700@gmail.com>
Date: Wed, 24 Apr 2019 21:16:41 +0200
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
Message-ID: <20190424191641.RgUCPL0XnYY7VpdLCFV--SQsrp2O25a7Qw6vrOLiVb8@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index cc1e887e4..0e87a9596 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -208,7 +208,7 @@ static int quark_default_data(struct pci_dev *pdev,
 		ret = 1;
 	}
 
-	plat->bus_id = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	plat->bus_id = pci_dev_id(pdev);
 	plat->phy_addr = ret;
 	plat->interface = PHY_INTERFACE_MODE_RMII;
 
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
