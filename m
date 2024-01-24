Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFA129A93
	for <iommu@lists.linux.dev>; Wed, 24 Jan 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120859; cv=none; b=R3/QZptwdjpnwUrLr7lSwGBiMYL/1aWuQJ5FllrE5ARDxmJQI8V0OO73G4Ddzob0xXQhX0RDhLa3135oCb4qY5NTOo8r0Avg/up7OKCASGTxBO3ypzz86L9SFEdlY97R8/57+KHnxHrp58HmhRHQLz+hzH0dPukTXE20JlHDBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120859; c=relaxed/simple;
	bh=1+3JCBgdZEHmfohGl/gvbE6GIltZvFYoxyCw+qaTRBM=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=tP6qFQ1phbcXTIPpndoVfBM8cP/TapJ7v2STNfRLPeLfMIPqSmEKsnXzqCKmNvWXCi6zJakt88MJWTY8SyVXdQbxwvDnwZC6LluJVSezz/kBDE+9jYjoo0Z3W9W0EMyqX1ekK3dkLwM7SOcBGh8ChnkgmqLqWKAaPeKYD6YN3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/a0Tm1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/a0Tm1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706120856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VgBoIa/4WPFft3WofQ67XbHpzteXQuoB8JXYa5uwDio=;
	b=X/a0Tm1kf3UyocL89Dhdjo73qhKKCvMpxw+IU/HyPfqDDV90xibxjI2i2ogLrHMQM59H65
	kcHvNDvNEk6HWUTDB6hJhXHLPPHqC+L1Oc2vQ6qKDJeblXdh8o+Rb83PVaUUiy7B4lvWj/
	sicO7LQEN0XQAwyfAlDKRaekZfh7rxo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-CnueD7WhNDq01Xjrgdj8LA-1; Wed, 24 Jan 2024 13:27:35 -0500
X-MC-Unique: CnueD7WhNDq01Xjrgdj8LA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33926c83a2cso2896632f8f.0
        for <iommu@lists.linux.dev>; Wed, 24 Jan 2024 10:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120854; x=1706725654;
        h=mime-version:user-agent:date:message-id:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgBoIa/4WPFft3WofQ67XbHpzteXQuoB8JXYa5uwDio=;
        b=GrypV53bNRdhaJHBNLxkldw8GL65QZKpWfwghmXxA66MP9Y0fTIHb5DQaP+FqU1tF1
         MzDYipagECD8fLCSGVIE5yCto9okAARoZRI4q2f468AQotaZLXnoGXdH/WAINizfQFHN
         cp9BKLOASfu5lPOeCl783rQNQ3oO6SaRSsjloxjN3jhePqjbMr2KRrSguLHZI4aPZzqq
         vrMG1tnr7xHJD8FeyxmNOa8QQaHCekhdKLRza++ERloTxEhgOU4ZdMzD1gA/ukxOyrG7
         w1BQbHHtGBVe+G2seJwvZdTyfpIRQ/8w5c1qNlN0BeG1kcTrFi0D8btUjnDPzr4vT8vQ
         Vzpg==
X-Gm-Message-State: AOJu0YyfiIi9zgQy6+zJ0wGHhtcxZ21i9XllkgTYdmbT1aZLVFay3S1T
	mge9/D1YkaZ/TC3PtlmvsZQEMrMr99wVkadUwaq576V+ZpQ9JxtCgJo++zf6Uwzna6Wh59FmqGy
	lP5yzNJk8g09sGwCSBaJUFVqc+t71avSJz1HnUvvFmbxovXFn1WwR
X-Received: by 2002:a5d:6c66:0:b0:337:c55f:66d8 with SMTP id r6-20020a5d6c66000000b00337c55f66d8mr545303wrz.149.1706120853999;
        Wed, 24 Jan 2024 10:27:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS2R9YhtbWch89RLyJmRCRV/+5KI9G6qFNI03oweoU8VChpFpo0c6pTtrBvbQzE2/Z/dcr4g==
X-Received: by 2002:a5d:6c66:0:b0:337:c55f:66d8 with SMTP id r6-20020a5d6c66000000b00337c55f66d8mr545301wrz.149.1706120853698;
        Wed, 24 Jan 2024 10:27:33 -0800 (PST)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709064a0300b00a3105a5500bsm139253eju.160.2024.01.24.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:27:32 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, Pavel Machek
 <pavel@ucw.cz>, Maxime Ripard <mripard@redhat.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, kieran.bingham@ideasonboard.com, Hans
 de Goede <hdegoede@redhat.com>
Subject: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <87bk9ahex7.fsf@redhat.com>
Date: Wed, 24 Jan 2024 19:27:31 +0100
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Hello,

in the libcamera project, we experience a major performance problem related to
DMA buffers while working on camera image processing using CPU.  This happens
only with some Arm boards, we have observed it on Debix Model A (NXP i.MX 8M
Plus) and PinePhone.  We use /dev/dma_heap/linux,cma (or reserved) DMA buffer
heap on Arm.

Reading V4L2 camera data from buffers is very slow.  When we memcpy the data
from the buffer to a malloc'ed memory before working with it (reading each byte
multiple times, without any big non-sequential jumps across the data), we get
more than 10 times speed up.  It looks like the input buffer is uncached.

We experience slow down also when writing to output buffers.  It doesn't seem to
matter whether we write to the output byte-by-byte or memcpy larger chunks.

We are having trouble to understand what's the problem with the buffers on some
hardware and what we can realistically do about it.  Could you please help us
clarify this?  Is it possible to force the DMA buffer CMA heap to be cached?
Or is there anything else we can do or try?

Thank you,
Milan

