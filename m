Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.37.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719024;
	b=2L+zmX9pXx8BKwFHu8zCfJLoeHBxhAdC+2nLN9Ll20pKa81ahoOfKIL4WVLrqHxI9AbN
	 1eO9v8G9j6OJL/AIasx3k3saqSwfj4HzqxBTzuVaTxCG7ICGxo02QxPt437/dGIokSxDN
	 njNS1CjlLiK5mg21w1y4b7kArZ/bV4bBkFMwuXjPM84sS6c1WHEHr+mCGEDuzRC+7qjJk
	 zHnJWYH/o5F7rF0NpCBm3ATO/UzRsO2kZhFDw/finK/rf5aNwSegwzO8FknxtqHTXPZtU
	 n/Mfg9ghOoOV5njSicc3U0uXntbUj4P4rcV955NcessFym+gWPCi76sevlIUwUm1vzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719024;
	h=DMARC-Filter:Received:Received:Received:Received:X-OVh-ClientIp:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=PFj2dQrzmKcwRNdxcPLwxaXC0ZJ3jZ+D5gGAYchiSRY=;
	b=tO4auTz1n6HlQJtBmalx9O2YfyyzFVAWDnUywOY1QILQ+FYXIKRmikmo2FeyFZKMgtz4
	 Mc4hBO/b1a3J9dC9K+KFtvp9/JegeI/tklCykZ8EriQBzrkUiywDPDCMS0RidQX48xXv3
	 nLdog4StutCpw3IZpFrjD3tD4OmVw10WFpabuZ2MZF8K/pH8R3Ts+yGCnra5KobhhnX8T
	 7dy2WEr5p4DmyYuyCxTAg76O33XtLaBRm7ye/NDZ1Uj8rd/qZ253KfAZTo1cOxcw5RVcq
	 QEK+sM0FtpGNnwoLo+yhGVtyz3YJUl5NCvMuk8ipkQ9WY7e/ls2042lsWY8pQDpNC2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=guillain.net;
	spf=pass smtp.mailfrom=guillain.net;
	dkim=pass header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=WdyctHnF;
	arc=none smtp.remote-ip=46.105.37.93
Received: from 10.mo528.mail-out.ovh.net (10.mo528.mail-out.ovh.net [46.105.37.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF4606B27D
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6AF4606B27D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=guillain.net header.i=@guillain.net header.a=rsa-sha256 header.s=ovhmo31693-selector1 header.b=WdyctHnF
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [79.137.60.225])
	by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jJscR1Bhjz5x5Y;
	Tue,  3 Nov 2026 15:16:55 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <joro@8bytes.org>; Tue,  3 Nov 2026 15:16:55 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.249.147])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jJscR0C0Kz6MbQ;
	Tue,  3 Nov 2026 15:16:55 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.6])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 04F519A206D;
	Tue,  3 Nov 2026 15:16:53 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-104R005edef0976-17d7-43fe-a2ff-da6a2899532a,
                    15838527D7D3E0897ACBD919E55849F771FD37B2) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.202.160.126
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: vasant.hegde@amd.com,
	joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jean-Christophe Guillain <jean-christophe@guillain.net>
Subject: [PATCH] iommu/amd: Fix NULL pointer dereference for GPUs without upstream bridge
Date: Tue,  3 Nov 2026 16:16:07 +0100
Message-ID: <20261103151607.435642-1-jean-christophe@guillain.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
References: <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
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
x-ovh-tracer-id: 18079419229820111676
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFeYew5JbChkrWgEkAmZab79BS/XOqyPSLunAfjBSTH+VfubWg/VkJvf4f9hmgfC1+UtU+V0Et8lK/VNXY6i1PDh7MislYyK+1ym4KTklhkAv0xKn05BxfN4HIphIpBzEG4D2F9tjS1ySKVVOV723NB3vBxT32knQz7Vgj3aEdQw7nlaR9b2r1XklFSusZOEUOgQNd/27dpkNie/zyxOCh4X46bVmRepsRim2tNcEL7n34RVEvtL5BBWGzjmgLxddQztNW/TRjMjCApM0eT3ap2uU+T6NJc8MqjmSrdqyeBqARxuJfZKf2b3jZXKy6csqY6YL0sU6Ec2iAHaIZV86bNDTgfVhSqPa+fbpkE4kqjA5dVTeMmFHBriDwpxBRHsg2yk29CUG0lX9//7e5136Ra3sJQBjcZJJLXggt529RuyJ+jXxhwHCBbmgYdt3AzEEyJx1ES09vIbNxr/ntB1RXjw1xBdoBfQMQ2HBORa3A4Sr91QcNvEKXfmNJAbnZ2GFC8ZQoorWv5ZXFi19AxV/T7ZJgg2qxw3r2FZx9XJl5F+o4wg2WrCqcJyMzzbO8uSvobTndxCA3bXL23EEwJ/or4W9gozXy04/B3BpGNccduYMgyXig1J6AV+Z8iEyBPAl/CgrDQfZb1SIWxYHTMu8j3bwmk836EUk0DN80h5Yvlew
DKIM-Signature: a=rsa-sha256; bh=PFj2dQrzmKcwRNdxcPLwxaXC0ZJ3jZ+D5gGAYchiSRY=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1793719015; v=1;
 b=WdyctHnF8L7913PRrClsrtqRNEYUPH2LcedEnGgyOiIaIsamSZIbK/MTuPDT1ag4qQJVqOYl
 LxG06CjTp3oUbYpr1YjOyoCgDgVzIKx5IKMqgy1njlI89BeYXbZpiL7ZSE1j90S7l6atiWcw5d6
 qh2mcrMwPVzxhSfqqOn7j4GDIgTIJwgfMqfTGXy0VRAgii+2eAOoOaEovRu5tv+ZI8XAX5+Wv5Y
 Ucwnp5QpNu3UqKNTyS10FuowaPfWZXHB+b340zF6WlFmLLIBg6tz/DjPVkoNKzROrVXaTBx2pvP
 9t4kjvskfKpnL+n8lcqD5CA4Kvl65uL5krrM6Zz4D+K8Q==

pci_upstream_bridge() can return NULL for devices without an upstream
bridge. The AMD GPU identity mapping quirk dereferences the returned
pointer unconditionally, causing a kernel panic during boot.

Check the pointer before accessing the bridge vendor ID.

This fixes a boot regression on a Lenovo system with an AMD PRO
A10-9700E APU. The system now boots with AMD IOMMU enabled.

Fixes: bf5bdfd1f8d4 ("iommu/amd: Force identity mode for selected GPUs only")

Signed-off-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
---
 drivers/iommu/amd/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..75e98e2e9d83 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3372,6 +3372,7 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 
 static bool quirks_force_identity_mapping(struct pci_dev *pdev)
 {
+	struct pci_dev *bridge;
 	int class = pdev->class >> 8;
 
 	/* AMD GPU vendor ID */
@@ -3383,7 +3384,8 @@ static bool quirks_force_identity_mapping(struct pci_dev *pdev)
 	    class != PCI_CLASS_DISPLAY_OTHER)
 		return false;
 
-	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge && bridge->vendor == PCI_VENDOR_ID_ATI)
 		return false;
 
 	/* It is the GPU in an APU, force identity domain */
-- 
2.47.3

