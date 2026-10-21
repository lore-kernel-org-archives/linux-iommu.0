Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603388;
	b=P/7DpiayZgZ78l3wp9ESrcXgXjxJqSeXkRGNMkJGM4a8d+ox+4qmg3bVw9PM0jkYjISB
	 GAbEqY7SJQCoaQDXnLiyK2M6ui7nXelM9JK85Kf9FW70ICV65EWvZV09oZM/SzDNlUlO/
	 BTMKUHF8sr9bsagk9SyxbZlYKCb0EyH+jmi4TZ/LqF13OAXKbcD+0v1aZStSBlD6H1g1J
	 Lk/wujwOkfqLfkDpd+eGaMU/BfnOLm95fk+aCSlxTlHD0b6LDMkn2uuXrw4ZPa8xvzFVN
	 ASwR9pBXnEPwM1jv9E8mbmFzrEg6DsvTZMlJNUa7Rkfpvfk1CtPt9lJhZvHoIoV5CQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603388;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TOJ16XUg6eE1K14QnduWV2MPYO1jo/9YTRDZbFyERD0=;
	b=wVG5EKdHG+v9Co05Ioh8+js5f4pKXclFVqRAVbUhIqEGMBTOdoUoRw3O/AQw3RzwgvXX
	 k21QEPKuxJZPgp2qNV+uVjW202Wz7b3jVs9tUaJkC8cvIRKlSvohpHPRqPKJJ/zj4h1Ko
	 I/h8L2ADN1FNTeZ0t/KecwdX/58vcTJekCaGP9Vzn/oXYHHnqu60GIS/dvyiJl7cN3wDy
	 PQts4Lgz95vWlKcKtn5aNAySWXaS/H5U0mq4MfKOIcj9EfWW5o4nOZxXGNlUYCEVWxNPv
	 Iu4qmG3hyQYgnNPw5hOnvLNpc6PFL1zC936vxzSkHOCh4dBK1z5WL190atANki+sitw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sc3li7px;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775D606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4775D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sc3li7px
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=bp4shnOQ9u3ewOpbvMQE3hJPs45HWfqzfiCPIYJD8gk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792603385; v=1; x=1793208185;
 b=Sc3li7pxo10gvRU2zvNc5BWAjRCsWNY2vnk2DWdz9r77E6dtKi66htSvBFbardtFPfxI3+Ba
 Y9Z8ZWrTcYs2bwDfKvs84640fKvpytAWJ32E2IBATcTBn3vZv0WdQ3ZxoQHAYcUgVGjUUY+k2CL
 RXVIymrb7/QgT6aG56GVsGtU=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 322f1b2b0bdb5508;
	Wed, 21 Oct 2026 17:23:05 +0000
X-Mizu-Trace-ID: 322f1b2b0bdb5508
X-Migadu-Flow: FLOW_OUT
From: Aditya Garg <aditya.garg@linux.dev>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: iommu@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Jason Perlow <jperlow@gmail.com>
Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
Date: Wed, 21 Oct 2026 22:52:38 +0530
Message-ID: <20261021172238.10004-1-aditya.garg@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Perlow <jperlow@gmail.com>

Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
BCM4364 firmware also reads posted RX buffers, so with VT-d
translation enabled every such read faults ("PTE Read access is not
set") and the firmware crashes and resets in a loop.

Map the RX pool DMA_BIDIRECTIONAL again, as before that commit. TX
keeps DMA_TO_DEVICE.

Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Perlow <jperlow@gmail.com>
Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 069ba70..ff47d48 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1639,7 +1639,7 @@ int brcmf_proto_msgbuf_attach(struct brcmf_pub *drvr)
 	if (!msgbuf->tx_pktids)
 		goto fail;
 	msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
-						     DMA_FROM_DEVICE);
+						     DMA_BIDIRECTIONAL);
 	if (!msgbuf->rx_pktids)
 		goto fail;
 
-- 
2.53.0

