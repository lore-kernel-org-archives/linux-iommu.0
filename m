Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC717B505
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329097; cv=none; b=Ihgkp6NfFriPbQc4UHhRnaI+pY0M+5FyWuiX5nBJUKOOJLaYhh9/sB7VCTNfygn1n+16HT6kC4quRTkVCnvDsqreRDCsnNRC6ReBKqCipho4mr3rZzbQ9zOc0xV2bR4pqo0/RKTo3g4FFzqYpS0B3OzLcRVlCPqucWuOgc7gXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329097; c=relaxed/simple;
	bh=kCMTfI7dzBOFipYIy5Kks1xdsteHQYxHHZjru9teJcI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qRH0MmNw6OmWLtl9nj2i2cljW5T6kRaF7r1f+LTkDLTJ62wV5lQLm37orzy8xO0nSxTF+eBObkyinIlhITp/NMT+kc/Wp/f1l0TYmlEanuFI3GAy72J1U/UZ64UWmci3nonXsIPujUgVxis6KpMMXHuk6NE+lb6LxDnqyr1lNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZcQ9T3se; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZcQ9T3se"
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:ea2:0:640:ef77:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 04426C004D;
	Tue, 13 Jan 2026 21:31:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IVYgsY1Gq0U0-k9uatQ9f;
	Tue, 13 Jan 2026 21:31:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1768329084; bh=kCMTfI7dzBOFipYIy5Kks1xdsteHQYxHHZjru9teJcI=;
	h=Date:Cc:To:From:Subject:Message-ID;
	b=ZcQ9T3seB2K/MYqGqZbWCywQEOk6b9S4hop76LZ5JHi5fIz6VdUO7TsM4+7Ku6rnM
	 cMJuhkigcwVAjn+PE3Ds2Lko6BcI8+kAi6JdQi1LVW0G2ADyWXquZo4ZAY0JP/REJK
	 psBdSfGviRc0Rj8yWQhZ4O4wII4P2lQSf7bWtTl0=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <05fd3e4d1b7f4ef7b55c35d79fde55b3b3eaa47b.camel@yandex.ru>
Subject: Possible mid-air JMB58x AHCI SATA reset / data loss
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, support@minisforum.com
Date: Tue, 13 Jan 2026 21:31:18 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

could someone please read and comment on https://www.reddit.com/r/MINISFORU=
M/comments/1pbnql6/silent_data_corruption_on_n5_pro_nas?
A few users of https://www.minisforum.com/products/n5 has suspecting a nast=
y hardware bug resulting in data corruption on SATA drives,
and an actual data corruption comes immediately after the message like:

[60281.710938] ahci 0000:04:00.0: Using 64-bit DMA addresses

has appeared in kernel log.

Feel free to ask more questions and even send kernel patches - I have this =
(maybe buggy)
hardware, can reproduce this issue, and run custom kernel as well.

Thanks in advance,
Dmitry
