Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6FC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1054208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWGOnKfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1054208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 450FB16EE;
	Wed, 24 Apr 2019 21:15:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DD871606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:18:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2985C786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:18:00 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id r186so130717wmf.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=HyUIjv1ZcTz3BJRhp2dFVjFVc8FZkCvFMerRUJk35rs=;
	b=mWGOnKfdu64PXdK4VkEsSESr1A3fAGLATh3SgnROHhCWvMZgDNu3SbfVQoPybvG9pK
	eigLrw6HkNx5eSa60OFNw6I6AzBlh0qp0v52mQi8APrNqu/ZnNdmaA+iKPOVsqt2sCoO
	UOUnXM4kOp9PKJ9lKXwfABww/PaNtFz+94XxKPe2LJODsi37G30Gy73vot5PxxNWqeiU
	hxNThydhzbWKbCUtL5M5CZw60KzQgBVKTQSh5IWajOiiGVoJwP0oDJwDu0qP8ZACVfS0
	vA0rmAJ6uWd6gloEFSDqu1PVRiB4HPHDDZoCDdJeh3wY72Eu3UBBlWTKHV+DIA2o1TxV
	vjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HyUIjv1ZcTz3BJRhp2dFVjFVc8FZkCvFMerRUJk35rs=;
	b=Ldn5+N3EnNAVM6U7robn7vsFFpOuCIba+GpaHexbKPtE5vOikUW3GcBUMuwgiK0tSz
	Mbm5nakt9WNEG83uEqlXiMl/i5ToBMQ04IM09XNlh2WhFG8LdIx/dU8K285xjyTW72vT
	jZHMWZjbxfwln5V9dDe0QiwIaAFIsbqw5hCOUghlsIUI+uj14EvZEpfH2X4DLV6XqcJs
	zpPSlxV0mPYb70CGWsHJHnPtpAPzcZmGlcipmiGR+X2hPeAc3MmcskoQnyBLCztvf8NW
	11P/+v97BEolxQEVOPL3lgqlaJeD2wvi2to0hJ6UloUaY/YN8dlS3YGYRZ4CY4ISX7fV
	rtOg==
X-Gm-Message-State: APjAAAWvKj+1bF0grax++ljKMvYPPRp4TSUy8Kpxg74nGcJ+Kdvxe7BP
	n/QdpDUflvtZds7AaNDft5s=
X-Google-Smtp-Source: APXvYqwh3CNfCKJTs9MOTu4bXqWdzGeM/Qp5h/VOnaJHwwOVsZkGf5/cSOBP+OP8er+qIAMJlFmteg==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr478703wme.67.1556133478847;
	Wed, 24 Apr 2019 12:17:58 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	t17sm17033907wrr.26.2019.04.24.12.17.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:58 -0700 (PDT)
Subject: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper pci_dev_id
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
Message-ID: <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
Date: Wed, 24 Apr 2019 21:17:19 +0200
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
Message-ID: <20190424191719.-I2ZHV2Q2hCl4g9dONaFGNeOSptRHvQ39n5CR7b3mfY@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 24326eecd..7abbb6167 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struct device *dev, u32 devid)
 		return false;
 
 	pdev = to_pci_dev(dev);
-	return devid == PCI_DEVID(pdev->bus->number, pdev->devfn);
+	return devid == pci_dev_id(pdev);
 }
 
 static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
