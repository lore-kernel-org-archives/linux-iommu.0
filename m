Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3090C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E72208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUzhCOH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E72208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8C41216E6;
	Wed, 24 Apr 2019 21:15:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 384741606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDE0982D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:52 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id h18so6654429wml.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=IeRjLmIo3+zL+ngn2z6PfEn9LxaA8z9ME0E/GMbJl4A=;
	b=TUzhCOH2F7RvxialpvgaUFfNbsBpgDv13m50OH+yCHXNzbKgkQ3+3J9fmVotTjHhZ+
	nT72Tzc880/U6F/39r2rOLBXumQ/j5RU5NezTirLrIrK8HKif6onpzxPkeL9+3b1vQq2
	1DjaR7ZH62jNLmGYqQQPFRrk8RastcZUjByEctXZYR9dDWVH50TBAdTissGRPJJFAaku
	yTmszbRe7C6g/MQlgrFC4qFKTUqOyA0NfxLlCq1xXJvcaq0cajMvWvopZxIRGurM8C5w
	Ky8/X9fshxb+9fnIfYrOG+f4N+cBIWfqByuQioMYFAZ1K6Xx48p3R+XHvkUnajpJttNi
	B/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IeRjLmIo3+zL+ngn2z6PfEn9LxaA8z9ME0E/GMbJl4A=;
	b=ONPMEVX6m2Rgs1PqHBsJq3fwRx3lq+WB+XUlMwZZBvuGso5zmWr9s/I+/n4or0p27P
	dY0YFEz7+nGx8Szg7BN0VBimRgKWFYWoJiPv2RBEHkZA+cTw1UGvzbaYwBLmasS2bbKa
	abCoiUL9QdKzmwJ9/zewviHgSY6WBN8IUyMKpMhjFNwi/gov4zcY4v4GVI8RnFrTQe1L
	gUDoigANzucC5BpBPWgHnEDq3nv6CjipWggK0n7tzqB49U44jFibVXNrnd0hy+4t8//8
	G1kLnx68I5n6aKGwYIo3Xu4lCaEEouBWJO9eb5LEXjZ393obIqvhqg0fudwLcH3rZ7FL
	o2zQ==
X-Gm-Message-State: APjAAAXSRJuMnettYeJqU4zzPLHbe2qOAx0/tYfKDBuywLb5AwRuM4J/
	Edt52jxbqIq3MWuJEuWzNuQ=
X-Google-Smtp-Source: APXvYqwLwnDZWORI7BhpqSdPQhydSnH4TJiDh5p2OFwPcJ1S0/zRXEp6j1rg2GAjg1ue7Rb470bFqw==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr474306wmf.73.1556133471446;
	Wed, 24 Apr 2019 12:17:51 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	a11sm16605685wrx.5.2019.04.24.12.17.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:50 -0700 (PDT)
Subject: [PATCH v2 6/9] iommu/amd: use helper pci_dev_id
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
Message-ID: <f673e8ac-cc9a-75a6-09b8-35b94bfc868b@gmail.com>
Date: Wed, 24 Apr 2019 21:15:25 +0200
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
Message-ID: <20190424191525.1PrGOYQH_9EbUg3Zl_RYUri9Q-P3lvFe3mScfFt9Wpk@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f467cc4b4..5cb201422 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -165,7 +165,7 @@ static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return PCI_DEVID(pdev->bus->number, pdev->devfn);
+	return pci_dev_id(pdev);
 }
 
 static inline int get_acpihid_device_id(struct device *dev,
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
