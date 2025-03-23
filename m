Received: from resqmta-a2p-658917.sys.comcast.net (resqmta-a2p-658917.sys.comcast.net [96.103.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125018C900
	for <iommu@lists.linux.dev>; Sun, 23 Mar 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.103.146.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742719825; cv=none; b=ldYMENYyUhkXC+hB3Z7gMYsO6pdg+hJsqMDl3MJHKRmEYe5xNTKHkYnbdPAkXLy3cX4fJkCaAWmseZKhAEGfzcB9Sowpld38FuXzuoPLkL2YgoCZJeBw0+rgu0qtRb3nFJcHuotTpqiOrVjwwajgBzl0SqJWosFAlT4frUe62cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742719825; c=relaxed/simple;
	bh=pIdGOeh+Oqd44OY9HzqX6b7OnT6pGBkcE5pwRBCdkB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agIKmFcfStywcCf+3hYZ2luLYkVhscRu+xQoAuNO/4ciDfBEJY12XdzKZdb3ZpfBK2NqbRUb9TrDELNbQ58MIWW6a1SGRNP2wLaBgNoHnq+EYljQ7WHy4IYZ5+Ux6r5YNxggxP7qWmd1Ysk46xX8khWolYxRYwOygqgWimAR3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=sGA9FJHm; arc=none smtp.client-ip=96.103.146.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="sGA9FJHm"
Received: from resomta-a2p-646771.sys.comcast.net ([96.103.145.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-a2p-658917.sys.comcast.net with ESMTPS
	id wGeDtmrbwKKrqwGzhtInzI; Sun, 23 Mar 2025 08:47:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1742719666;
	bh=As9xYhkiLfqyvDbQAJ2I9bXnaME852VQCvf8EPkmAaM=;
	h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
	 Xfinity-Spam-Result;
	b=sGA9FJHmeCJ5Xdys3YlUJc7ywJAf2yhxspVv5GlQ6xjgPOOECJ9kM8Fjf6MCDA493
	 VQf6uI5+tGI+KP5UWNOO4c+hDqwezKwrQl/I0uLD1mXXlrkiopF0Jio1M+5wJei1BS
	 2UrTU28yPGsLSCzk7Etbj36kz/8cZtCdfgYzw+JRrEJHUToxUzdjHqYsArXKIiGMgN
	 nm3+yx6nF62WwCJYaiVxivUmiSPMzNfXJlBjEBlHCAEOT1jWLH0pkwTFNVdszX5M0H
	 E9tjIjd7RdzaOEKiphdpLxVKWfd0k5Rxk49EiAio3gDuSa+4yFhw4FKQHnA7w1Ktuq
	 XZgr87rjlFW0g==
Received: from jack-livingood.. ([IPv6:2601:647:4d81:b870::81ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-a2p-646771.sys.comcast.net with ESMTPSA
	id wGzQtcTGiB6NhwGzgt3n7K; Sun, 23 Mar 2025 08:47:45 +0000
From: jack Livingood <jacklivingood@comcast.net>
To: robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	jack Livingood <jacklivingood@comcast.net>
Subject: [PATCH 1/1] Kernel:dma: fixed whitespace error
Date: Sun, 23 Mar 2025 01:46:47 -0700
Message-ID: <20250323084647.33558-1-jacklivingood@comcast.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIRXYm2DNNebo7tovIJhEmnD6jGygwCSguvDtZUu8fhuuJxjDQBA1JVxTd6ZQMgchsuyPPhWUm8psCWsbTTVZ8GDylDTH+8hIY8RV/4qC4++GZEDWveo
 p+spYJ3VreBuwnlLmVQoXfGIlM9ArtM5GGVm4h49mgHhDMFExAc9w7K6gQ0Y10WnPltjUDRkyDOFUMOIRwFu9UiIX1oiU6aecT+4Bp3a+5zaEkJy3SYtomh1
 geP+E/HT3EdVOjBEWzWXekmwT/M4B0Lp60wOIT9FUWFtRV3/2c4hd67NEUYkhd/PrtD1bmmNbiSdCQQwNABZZQ==

Removed a space between the * and the pointer title to conform
with the checkpatch, and the continuing body of code.

Signed off by Jack Livingood <jacklivingood@comcast.net>
---
 kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma.c b/kernel/dma.c
index 40f152936316..74015f28c929 100644
--- a/kernel/dma.c
+++ b/kernel/dma.c
@@ -67,7 +67,7 @@ static struct dma_chan dma_chan_busy[MAX_DMA_CHANNELS] = {
  * @dmanr: DMA channel number
  * @device_id: reserving device ID string, used in /proc/dma
  */
-int request_dma(unsigned int dmanr, const char * device_id)
+int request_dma(unsigned int dmanr, const char *device_id)
 {
 	if (dmanr >= MAX_DMA_CHANNELS)
 		return -EINVAL;
-- 
2.49.0

