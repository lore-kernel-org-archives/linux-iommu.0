Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9019C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69B7208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9/VNW2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C92BC16E9;
	Wed, 24 Apr 2019 21:15:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A4F2B1606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39B1782D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:55 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id r186so130575wmf.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=L7OMDqn053nsdqraX4ZA3guqlyVTDUsFXQaouF1/Gos=;
	b=f9/VNW2zxOMYFkwIrmd9gbXTTDyAPJldpW0jlqhc9ddqz/XExcnPvUBW2cuC7iHYM3
	X8sWEHPyq9nl5S69NEsfykmeiFCZbevHNdIJJgmHPsizhhWl3oiNih/U1mpX9mO9RGFS
	KM259Aqjr8WT/9cB8GP0T95XxV9rqSCvyVkiuYo4c3RfkmvfNBiLbt/GpLG7igafuNss
	0UqWwQWIKRUnf6Oj2yQ1TbESq80ZDjagj7yMKikfjntdayHK1k3hrrzsjj3j3M7dIK3l
	pEEm3SCuep4hIm6x/NT02bJpFetnVPIX1ICUNx0+JawhL4nuIXclauj3K/iR0qSrEfle
	NQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=L7OMDqn053nsdqraX4ZA3guqlyVTDUsFXQaouF1/Gos=;
	b=CZpxIBzKV/FVP+c3cCtnmxFeJrtq+TIQnlB6elhKlZO0FbLl241UcwCtE70OY0LeJw
	9eogzl38lSd5rB+80sqgqCpBNCwKVEZFZ94IsnILF/hcTUUXWDM8LC7OF+mio6a+oOX0
	dMAmGvgFyEb2ASNk26FFlRAAZvGcc0sTRYViEaLpXuxfZ3LxpfKGFIFdFe4vgeMETtzT
	C6fUFn0beRKwX6gfQ9/p4I+sAX1S14+7A7K+/6GfogBtXy3+YvJicPZC4tWjonsrqu0C
	Mv38uJRE4/vYduJL/loVnWNsUMLSbi1/KbHB6TCIgtyuqRxbfA5ly+4ixp85TUwaTYxr
	ttJA==
X-Gm-Message-State: APjAAAW3oxdwf0s9d9shvKYOObKggKx/3iHcpu6v9TbTK5WgVi9BbNZJ
	M0xKZ61+KTKCucwTfXO5VB0=
X-Google-Smtp-Source: APXvYqwx9IkvpF+W2lsA3mJH7M+n+CqCAXpBhPx/pthS51v7A1zJHA2H9Ks26cyCm8y+AFp3wsoEFA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr489308wmi.80.1556133473878;
	Wed, 24 Apr 2019 12:17:53 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	u17sm37513417wmu.36.2019.04.24.12.17.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:53 -0700 (PDT)
Subject: [PATCH v2 7/9] iommu/vt-d: use helper pci_dev_id
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
Message-ID: <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
Date: Wed, 24 Apr 2019 21:16:10 +0200
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
Message-ID: <20190424191610.7JaGbfU9hkmBnPjl26ML_9k8LIg9-5vmLVbFZHQi-vM@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/iommu/intel-iommu.c         | 2 +-
 drivers/iommu/intel_irq_remapping.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d93c4bd7d..3f475a23a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1391,7 +1391,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 		/* pdev will be returned if device is not a vf */
 		pf_pdev = pci_physfn(pdev);
-		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
+		info->pfsid = pci_dev_id(pf_pdev);
 	}
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 634d8f059..4160aa9f3 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -424,7 +424,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
 	else
 		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16,
-			     PCI_DEVID(dev->bus->number, dev->devfn));
+			     pci_dev_id(dev));
 
 	return 0;
 }
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
