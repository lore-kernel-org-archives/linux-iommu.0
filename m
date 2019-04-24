Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDFC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66645208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+WDYEss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66645208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 51D5416E4;
	Wed, 24 Apr 2019 21:15:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A41DF1606
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 353FA82E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:17:50 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id c6so20999745wrm.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=JGOU3ia6g6f+mcCeqoj5rUs2fETF3ERMMj8iqSjiOI4=;
	b=N+WDYEss0BjujrTkoVQFmlZMauTQnxRdnQZfZb7Pj5loUGC4okCuuv16tnp3aMqup9
	iAjLrSNm+TMJmHj3YYK9T/bwzZxTQKmGcK/m44oWL5evBfcPwpv2eoAi9aqBLRf40l7b
	ZsYLe15al+e+C0axyxR8ts7wuFEGb5+V5SLcItizyuxglNbmNpn9ZJIUpYxtl2BnxfHM
	cMMEPrEFkthMa9Qfs8gl42cjef5Z4uJaPHZZ7LyHX/GXlTmyzP2/mOIFXaU55f72KVC6
	ZxazwPCP9QGXRTy/D2w8I7pZ0CJEwXBPsTEPewxOtZegukdlOLsrv1x21Y+4zxQftilz
	SuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JGOU3ia6g6f+mcCeqoj5rUs2fETF3ERMMj8iqSjiOI4=;
	b=hBTpbgqjnhMSxK13a54Uq6lYKrP/ZV4lzCvM6plUCOffQIwXc4jecz7tTyfmdSpq7P
	6nPc2ltr5YQaEWyul+77Ntz0eK+amwmn5B1F03+xWX1s4+jWpAozlsa6egSHzJSG2+LD
	JhF6Zo3Ch19ZxIEgnAc7pLu3oY5lbyYkMp10+IX5uwjwREUUK1l3S6EEeaZEQpKKRVXn
	41PwYZJzb/CORKcBnJLxbWuV8eoz3UYkxMqzKa9+LkmUvJte+4R6KdsS0bQU0tj/aind
	ALIotnlJDJY7RA0bdXfHTuCu3812jZxElk+yEYEhSUp2ymWDrcUhPMUgou+HALZ2GfbQ
	lTsg==
X-Gm-Message-State: APjAAAVMwF/4jYk9MxfVt+tNUo7XbaPdsuEvzWr7OmsgeNJow3Rnx5m8
	ZhPiWBib/MquHbGdYRHxZvg=
X-Google-Smtp-Source: APXvYqyys0p4vzH3+QBE8b2LeEy6eALBMG3KHgepXOv8RrEgFJw4q6sOt683Zhup+UYIuSsIl60E9Q==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr23877569wrv.224.1556133468924;
	Wed, 24 Apr 2019 12:17:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5?
	(p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de.
	[2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
	by smtp.googlemail.com with ESMTPSA id
	s7sm3419954wrn.84.2019.04.24.12.17.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:17:48 -0700 (PDT)
Subject: [PATCH v2 5/9] drm/amdkfd: use helper pci_dev_id
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
Message-ID: <50613002-d5a2-2522-b183-4ab156686fce@gmail.com>
Date: Wed, 24 Apr 2019 21:14:55 +0200
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
Message-ID: <20190424191455.frFh0i4samfj3Yfl20IWG3whbUOGLvRUPCZVhM4VCX4@z>

Use new helper pci_dev_id() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2cb09e088..769dbc7be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1272,8 +1272,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
-	dev->node_props.location_id = PCI_DEVID(gpu->pdev->bus->number,
-		gpu->pdev->devfn);
+	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
 	dev->node_props.max_engine_clk_ccompute =
-- 
2.21.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
