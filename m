Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E1C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD44208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBX0KuQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD44208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 070DD16E1;
	Wed, 24 Apr 2019 21:15:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4403E1606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B5F2F82D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:47 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c5so17814233wrs.11
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hab7qAz6lzS7ZRowBkQ/f/HEdXNfdhNCdKWF0/BVKmE=;
	b=IBX0KuQhIHPofugi8VbvuAnaDQlqeZ9svo7oPOlRq9Nl+c4hfx7GC4G6FUzkUJubse
	wiLJj/sOBCAdP1NhfNYrPK8BsSVeCk2cAA9eP+HTjzeXBPDI3xwU9YjRDKxu7BUkh9Qy
	ARW/rPtI4IpoC3x2CibtLLT839KW5Gqd98nS+2DFcQq+T+/e7v1mCfxpxSvQXhLRtDMs
	OI5Y+gnOsn5tFiln6JJbcNGlizY5/JYmaoqck6PjX5tjV488YO+0nhW8BLltqBNP29iS
	aIYrY8Al7ib3uqnETxszQ99kc8ZoQ/z7edNx0J2Z7OwrxHfOrSpfu23Pmg27nR0v1NZi
	ReGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hab7qAz6lzS7ZRowBkQ/f/HEdXNfdhNCdKWF0/BVKmE=;
	b=mrzc6h739V8cNxSnTOoc2/O/J0RlrX8uODizPfbuvv6HMeLMCceTgu8wKc/jdziJhH
	NWDkIeDFwpcbBEtqc0wVzImsJL8FicCZrMMZ+k11xdxOMQT53QVdUz7EOLT/PvWY+a8u
	P81RmOcE1FhaIxbpPbfrwlpKN8aOk7QbHTb0RO38XcK9pNS+yYtXpJTq/WC170iAGryB
	g5nbGw+jsuNMU40VqpWBk4CuR7VF6FLiIs4uVoPdoRHrSOHWpq8HxqLgyaXlnY3Iltvm
	P0stjzGgCU1uX6heNPs02tOQUqyWx8+pUMA6dDhIQd/FoJqBj0B3S/8kKLs3ahqYuZkn
	OIzg==
X-Gm-Message-State: APjAAAXjugKhWP7s5D7jWbThstVv/hskF0CTzbXxTrmsblStjAdRY64L
	0ZZPOGk9GdwUrWBNirESQoQ=
X-Google-Smtp-Source: APXvYqy3cqzUuKRDBnCN6u4ytA6IsqF8dbo/CC+cpZ/NjBgj06qGIEA9zqzusRK5xh+DIv6B8gl90A==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr18245461wrs.15.1556133466411; 
	Wed, 24 Apr 2019 12:17:46 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	p6sm18060129wrs.6.2019.04.24.12.17.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:45 -0700 (PDT)
Subject: [PATCH v2 4/9] powerpc/powernv/npu: use helper pci_dev_id
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
Message-ID: <8ed5b4ee-3226-6786-eb96-886826e180cd@gmail.com>
Date: Wed, 24 Apr 2019 21:14:25 +0200
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
Message-ID: <20190424191425.1xZTwOhRWTWJbfsO2E8dRqtc2aXKL3By5Q-SNoEEoTA@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index dc23d9d2a..495550432 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1213,9 +1213,8 @@ int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 	 * Currently we only support radix and non-zero LPCR only makes sense
 	 * for hash tables so skiboot expects the LPCR parameter to be a zero.
 	 */
-	ret = opal_npu_map_lpar(nphb->opal_id,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn), lparid,
-			0 /* LPCR bits */);
+	ret = opal_npu_map_lpar(nphb->opal_id, pci_dev_id(gpdev), lparid,
+				0 /* LPCR bits */);
 	if (ret) {
 		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
 		return ret;
@@ -1224,7 +1223,7 @@ int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 	dev_dbg(&gpdev->dev, "init context opalid=%llu msr=%lx\n",
 			nphb->opal_id, msr);
 	ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+				    pci_dev_id(gpdev));
 	if (ret < 0)
 		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
 	else
@@ -1258,7 +1257,7 @@ int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
 	dev_dbg(&gpdev->dev, "destroy context opalid=%llu\n",
 			nphb->opal_id);
 	ret = opal_npu_destroy_context(nphb->opal_id, 0/*__unused*/,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+				       pci_dev_id(gpdev));
 	if (ret < 0) {
 		dev_err(&gpdev->dev, "Failed to destroy context: %d\n", ret);
 		return ret;
@@ -1266,9 +1265,8 @@ int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
 
 	/* Set LPID to 0 anyway, just to be safe */
 	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=0\n", nphb->opal_id);
-	ret = opal_npu_map_lpar(nphb->opal_id,
-			PCI_DEVID(gpdev->bus->number, gpdev->devfn), 0 /*LPID*/,
-			0 /* LPCR bits */);
+	ret = opal_npu_map_lpar(nphb->opal_id, pci_dev_id(gpdev), 0 /*LPID*/,
+				0 /* LPCR bits */);
 	if (ret)
 		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
 
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
