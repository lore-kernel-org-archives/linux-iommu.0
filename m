Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E332066D4
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489956; cv=none; b=DcCtGhiBA2cGzxQBbCQAUUpUmPO//8xruaNqIm7579mYqmXMCev3YvuHxKmO8zkwOMg6nn6GzbuqfrbyMlh/w8Eo42DaKX09yfdNgo8HQ4M74zP7aebforWwm0dofOj02Q6VYgWTpQF/MmSClPQlDds4KEJZ1mx+LqtMjze6X5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489956; c=relaxed/simple;
	bh=ECEpQPYqsfrJxNwLqVbdfAjbqo4xKyR8hskE+48/d6A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GkHKQPMQ5oDqHOerTHFe6oZVuH3xMibXifsULXjZtyaBUDt3rXnguS5Ww6MqTT8q16LUTrZG7KS+Vw8eWogm7/BV0aHSElqOph9EjvEumn5GlY2VGJG1Iyy8i5nAQln7JHuFMDRUxylnIwWCEa+mOyXlQcSvOl9Rh/dAelp27Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWk9P42X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWk9P42X"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso20441605ad.2
        for <iommu@lists.linux.dev>; Thu, 09 Jan 2025 22:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736489953; x=1737094753; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECEpQPYqsfrJxNwLqVbdfAjbqo4xKyR8hskE+48/d6A=;
        b=IWk9P42X0lAAFS14K++1TMTSpWeMMsChzPdDCf01GuyK1cP56qErJNeOb2q9OCvRpE
         xbVdznbANo4B/ZmySnJm5en8iXUjttK428nxiaQn5Qgs4dsotytgcv46sM3yXa7byC3D
         8tNlLplzOitXUZL7rxbTd+QZBYykcZfmVEmHSHpm3f7hy7Qk56SyIqekESWYSoozN7Oj
         3Jz9bEngkbtKKpt1eDA66smDobZWC1dh77ikJb8CG28RQEGV3QXxt/axo7Ho2Xd2qdyW
         YXLGigeZBS3X7pLb4Uh7PuTq5xmwu2iAZkcf9EyoNLAfmuROhssAfBqTUSoboBQ7FZaB
         d5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736489953; x=1737094753;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECEpQPYqsfrJxNwLqVbdfAjbqo4xKyR8hskE+48/d6A=;
        b=I9/xvAat9lGUas5wZF2nx7Za/iXsEblrt2ICnNYgh4/oL9OFvn7/iI483WQ48kP4pG
         acBK1CDCPslnqg2AN2uE7bWCakFwRi55bLxX79ZwE/bbwGke8cG8iiGOgvMrb/Xl+zrJ
         hv3cu1skVzfWhnnX9hGA5egFsMrAzdp5vS4wKUmWeBqmdSdlqYQ3oab8B3tu9SB2vin+
         0vwAkHl5ocUDWc8vrLq4wTU1VRTG0zTz98Az5j+xpKgMo6P9B1CYWsATBJaa8CFXPivI
         tVjutPz9g6l3dagDnEUMBlU3jq//CdQB+MZF50dHshrDoCxB2CRKLkcmAetNEiTKo9i/
         y7cg==
X-Gm-Message-State: AOJu0YxFQHbc2O7iOvkM/PN9/xb7BPAToCPaaIrBYshJCvV4Tq2IIY2K
	0mXr966uFnMv/TU269dfF3r4qcDFhjsIWz/larWSpezcicLkJ4Uqjca9MxWKoUU=
X-Gm-Gg: ASbGnctXV5d9dntrk4Gp9ZVOYxOwBPtEpG+HVijElh9ld5wiBLVbwSqgsyBCi4VLXAf
	2olAk+CEL3BxnbpFAnFJxehOeRl4afdNym95QPt/SmblQqru0IkIXdyPbBpf7CMnk2bHAIKtZbG
	fJG6v7ah8J8W0q90uYOTQPNcbRahRzhBkmhwcH6yzM+2JXvyFMPuvnv4YZVT8PPa4bUZJ45lXw/
	q8jqLMGS23DnOTi+E3g87wCham4uH1I/T/npczmUmXzkAwYM/n6xo8RgBEP27TggA==
X-Google-Smtp-Source: AGHT+IGFx7uLiMw9ocBxx631+M8AG/uuJhQlG3xAqE1fGOaA7rKOKmXV5sGYmQXm4q6Ic8SyV9AuAw==
X-Received: by 2002:a05:6a00:928c:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-72d21fb1e07mr13460769b3a.10.1736489953046;
        Thu, 09 Jan 2025 22:19:13 -0800 (PST)
Received: from [192.168.123.209] ([38.59.243.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm858438b3a.173.2025.01.09.22.19.11
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 22:19:12 -0800 (PST)
Message-ID: <88b97162-bace-4e9b-b362-4da96a7a2cfe@gmail.com>
Date: Fri, 10 Jan 2025 14:19:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: iommu@lists.linux.dev
From: Yee Li <seven.yi.lee@gmail.com>
Subject: Not fully traversing iova reservations bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear All,

Is there any other method to fix not fully traversing iova reservations bug.

A case:

For multiple devices in the same iommu group, sorted later device (based
on Bus:Dev.Func) have the RMRR.

Sorted earlier device (without RMRR) initialized the iova domain causing
the sorted later device goto done_unlock  in iommu_dma_init_domain.

     if (iovad->start_pfn) {
         if (1UL << order != iovad->granule ||
             base_pfn != iovad->start_pfn) {
             pr_warn("Incompatible range for DMA domain\n");
             ret = -EFAULT;
             goto done_unlock;
         }

         ret = 0;
         goto done_unlock;
     }

Actually RMRR ignored.

The solution patch link(no response so far):

https://lore.kernel.org/lkml/20240819104219.8057-1-LeoLiu-oc@zhaoxin.com/T/

